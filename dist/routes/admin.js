import { Hono } from "hono";
import { eq, desc, and, count, gte, sql } from "drizzle-orm";
import { db } from "../db/client.js";
import { users, sessions, loginAudit, domains, domainModules, userDomainAccess, userModuleAccess, } from "../db/schema.js";
import { requireAuth, requireRole } from "../middleware/auth.js";
import { hashPassword, validatePasswordStrength } from "../auth/password.js";
export const adminRoutes = new Hono();
adminRoutes.use("*", requireAuth, requireRole("admin"));
/* ── USERS ── */
adminRoutes.get("/users", async (c) => {
    const userList = await db
        .select({
        id: users.id,
        username: users.username,
        email: users.email,
        role: users.role,
        isActive: users.isActive,
        failedLoginCount: users.failedLoginCount,
        lockedUntil: users.lockedUntil,
        createdAt: users.createdAt,
    })
        .from(users)
        .orderBy(users.createdAt);
    // Untuk tiap user, ambil domain access + module access
    const result = await Promise.all(userList.map(async (u) => {
        const domAccess = await db
            .select({ domainId: userDomainAccess.domainId, domainSlug: domains.slug, domainNama: domains.nama })
            .from(userDomainAccess)
            .innerJoin(domains, eq(userDomainAccess.domainId, domains.id))
            .where(eq(userDomainAccess.userId, u.id));
        const modAccess = await db
            .select({ moduleId: userModuleAccess.moduleId, moduleSlug: domainModules.slug, moduleNama: domainModules.nama })
            .from(userModuleAccess)
            .innerJoin(domainModules, eq(userModuleAccess.moduleId, domainModules.id))
            .where(eq(userModuleAccess.userId, u.id));
        return { ...u, domainAccess: domAccess, moduleAccess: modAccess };
    }));
    return c.json(result);
});
adminRoutes.post("/users", async (c) => {
    const me = c.get("user");
    const body = await c.req.json();
    const { username, email, password, role, domainSlugs = [], moduleSlugs = [] } = body;
    if (!username || !email || !password || !role) {
        return c.json({ error: "username, email, password, role wajib diisi." }, 400);
    }
    const pwCheck = validatePasswordStrength(password);
    if (!pwCheck.ok)
        return c.json({ error: pwCheck.message }, 400);
    const [existing] = await db.select().from(users).where(eq(users.username, username)).limit(1);
    if (existing)
        return c.json({ error: "Username sudah dipakai." }, 409);
    const passwordHash = await hashPassword(password);
    const insertResult = await db.insert(users).values({ username, email, passwordHash, role });
    const newUserId = insertResult.insertId;
    // Grant domain access
    for (const slug of domainSlugs) {
        const [dom] = await db.select().from(domains).where(eq(domains.slug, slug)).limit(1);
        if (dom) {
            await db.insert(userDomainAccess).values({
                userId: newUserId, domainId: dom.id, accessLevel: "read", grantedBy: me.id,
            }).onDuplicateKeyUpdate({ set: { accessLevel: "read" } });
        }
    }
    // Grant module access (per-modul, lebih granular)
    for (const slug of moduleSlugs) {
        const [mod] = await db.select().from(domainModules).where(eq(domainModules.slug, slug)).limit(1);
        if (mod) {
            await db.insert(userModuleAccess).values({
                userId: newUserId, moduleId: mod.id, grantedBy: me.id,
            }).onDuplicateKeyUpdate({ set: { grantedBy: me.id } });
        }
    }
    return c.json({ ok: true, userId: newUserId });
});
async function doDeleteUser(c, id) {
    const me = c.get("user");
    if (id === me.id)
        return c.json({ error: "Tidak bisa menghapus akun sendiri." }, 400);
    if (!id || isNaN(id))
        return c.json({ error: "ID user tidak valid." }, 400);
    await db.delete(userModuleAccess).where(eq(userModuleAccess.userId, id));
    await db.delete(userDomainAccess).where(eq(userDomainAccess.userId, id));
    await db.delete(sessions).where(eq(sessions.userId, id));
    await db.delete(users).where(eq(users.id, id));
    return c.json({ ok: true });
}
// DELETE method (standard)
adminRoutes.delete("/users/:id", (c) => doDeleteUser(c, Number(c.req.param("id"))));
// POST fallback (untuk hosting yang blokir DELETE method)
adminRoutes.post("/users/:id/delete", (c) => doDeleteUser(c, Number(c.req.param("id"))));
adminRoutes.patch("/users/:id", async (c) => {
    const id = Number(c.req.param("id"));
    const body = await c.req.json();
    const update = {};
    if (body.isActive !== undefined)
        update.isActive = body.isActive;
    if (body.role)
        update.role = body.role;
    if (!Object.keys(update).length)
        return c.json({ error: "Tidak ada field yang diupdate." }, 400);
    await db.update(users).set(update).where(eq(users.id, id));
    return c.json({ ok: true });
});
// Reset password user
adminRoutes.post("/users/:id/reset-password", async (c) => {
    const id = Number(c.req.param("id"));
    const { password } = await c.req.json();
    const pwCheck = validatePasswordStrength(password);
    if (!pwCheck.ok)
        return c.json({ error: pwCheck.message }, 400);
    const hash = await hashPassword(password);
    await db.update(users).set({ passwordHash: hash, failedLoginCount: 0, lockedUntil: null }).where(eq(users.id, id));
    return c.json({ ok: true });
});
// Set module access untuk user (replace all)
adminRoutes.put("/users/:id/access", async (c) => {
    const me = c.get("user");
    const userId = Number(c.req.param("id"));
    const body = await c.req.json();
    // Domain access
    await db.delete(userDomainAccess).where(eq(userDomainAccess.userId, userId));
    for (const slug of (body.domainSlugs ?? [])) {
        const [dom] = await db.select().from(domains).where(eq(domains.slug, slug)).limit(1);
        if (dom) {
            await db.insert(userDomainAccess).values({ userId, domainId: dom.id, accessLevel: "read", grantedBy: me.id });
        }
    }
    // Module access (granular)
    await db.delete(userModuleAccess).where(eq(userModuleAccess.userId, userId));
    for (const slug of (body.moduleSlugs ?? [])) {
        const [mod] = await db.select().from(domainModules).where(eq(domainModules.slug, slug)).limit(1);
        if (mod) {
            await db.insert(userModuleAccess).values({ userId, moduleId: mod.id, grantedBy: me.id });
        }
    }
    return c.json({ ok: true });
});
/* ── ACTIVITY / AUDIT ── */
adminRoutes.get("/audit", async (c) => {
    const limit = Math.min(Number(c.req.query("limit") ?? 100), 500);
    const logs = await db
        .select()
        .from(loginAudit)
        .orderBy(desc(loginAudit.createdAt))
        .limit(limit);
    return c.json(logs);
});
adminRoutes.get("/sessions", async (c) => {
    const now = new Date();
    const activeSessions = await db
        .select({
        id: sessions.id,
        userId: sessions.userId,
        username: users.username,
        ipAddress: sessions.ipAddress,
        userAgent: sessions.userAgent,
        createdAt: sessions.createdAt,
        expiresAt: sessions.expiresAt,
    })
        .from(sessions)
        .innerJoin(users, eq(sessions.userId, users.id))
        .where(gte(sessions.expiresAt, now))
        .orderBy(desc(sessions.createdAt))
        .limit(200);
    return c.json(activeSessions);
});
/* ── SECURITY SUMMARY ── */
adminRoutes.get("/security", async (c) => {
    const now = new Date();
    const since24h = new Date(now.getTime() - 24 * 3600 * 1000);
    const since7d = new Date(now.getTime() - 7 * 24 * 3600 * 1000);
    const [totalUsers] = await db.select({ n: count() }).from(users);
    const [activeUsers] = await db.select({ n: count() }).from(users).where(eq(users.isActive, true));
    const [lockedUsers] = await db.select({ n: count() }).from(users).where(gte(users.lockedUntil, now));
    const [activeSess] = await db.select({ n: count() }).from(sessions).where(gte(sessions.expiresAt, now));
    const [failed24h] = await db
        .select({ n: count() }).from(loginAudit)
        .where(and(eq(loginAudit.success, false), gte(loginAudit.createdAt, since24h)));
    const [failed7d] = await db
        .select({ n: count() }).from(loginAudit)
        .where(and(eq(loginAudit.success, false), gte(loginAudit.createdAt, since7d)));
    const [success7d] = await db
        .select({ n: count() }).from(loginAudit)
        .where(and(eq(loginAudit.success, true), gte(loginAudit.createdAt, since7d)));
    // Top IP dengan gagal login (7 hari)
    const topFailIPs = await db
        .select({ ip: loginAudit.ipAddress, n: count() })
        .from(loginAudit)
        .where(and(eq(loginAudit.success, false), gte(loginAudit.createdAt, since7d)))
        .groupBy(loginAudit.ipAddress)
        .orderBy(sql `count(*) DESC`)
        .limit(10);
    // Gagal login per alasan
    const failReasons = await db
        .select({ reason: loginAudit.reason, n: count() })
        .from(loginAudit)
        .where(and(eq(loginAudit.success, false), gte(loginAudit.createdAt, since7d)))
        .groupBy(loginAudit.reason)
        .orderBy(sql `count(*) DESC`);
    return c.json({
        users: { total: totalUsers.n, active: activeUsers.n, locked: lockedUsers.n },
        sessions: { active: activeSess.n },
        loginFailed: { last24h: failed24h.n, last7d: failed7d.n },
        loginOk: { last7d: success7d.n },
        topFailIPs,
        failReasons,
        encryption: {
            algorithm: "AES-256-GCM",
            fields: ["password_hash (bcrypt-12)", "session_id (SHA-256 hash)", "field_encryption (AES-256-GCM)"],
            cookieFlags: ["httpOnly", process.env.COOKIE_SECURE === "true" ? "Secure" : "Secure:OFF(dev)", "SameSite=Lax"],
            headers: ["X-Frame-Options:DENY", "X-Content-Type-Options:nosniff", "CSP aktif", "Referrer-Policy"],
        },
    });
});
/* ── DOMAINS & MODULES (untuk admin UI dropdown) ── */
adminRoutes.get("/domains-modules", async (c) => {
    const domainList = await db.select().from(domains).where(eq(domains.isActive, true));
    const result = await Promise.all(domainList.map(async (d) => {
        const mods = await db.select().from(domainModules).where(eq(domainModules.domainId, d.id));
        return { ...d, modules: mods };
    }));
    return c.json(result);
});
//# sourceMappingURL=admin.js.map