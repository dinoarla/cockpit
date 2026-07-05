import "dotenv/config";
import { fileURLToPath } from "node:url";
import { dirname, join } from "node:path";
import { serve } from "@hono/node-server";
import { serveStatic } from "@hono/node-server/serve-static";
import { Hono } from "hono";
import { securityHeaders, requireAuth } from "./middleware/auth.js";
import { authRoutes } from "./routes/auth.js";
import { domainRoutes } from "./routes/domains.js";
import { mdpRoutes } from "./routes/mdp.js";
import { ruptlRoutes } from "./routes/ruptl.js";
import { adminRoutes } from "./routes/admin.js";
import { tariffRoutes } from "./routes/tariff.js";
import { db } from "./db/client.js";
import { domains, domainModules, userDomainAccess, userModuleAccess } from "./db/schema.js";
import { eq, and, sql } from "drizzle-orm";
const __dirname = dirname(fileURLToPath(import.meta.url));
const publicDir = join(__dirname, "..", "public");
const app = new Hono();
app.use("*", securityHeaders);
app.get("/healthz", async (c) => {
    const [latest] = await db
        .select({ lastUpdate: sql `MAX(created_at)` })
        .from(domainModules);
    return c.json({
        status: "ok",
        ts: new Date().toISOString(),
        lastUpdate: latest?.lastUpdate ?? null,
    });
});
app.route("/api/auth", authRoutes);
app.route("/api/domains", domainRoutes);
app.route("/api/mdp", mdpRoutes);
app.route("/api/ruptl", ruptlRoutes);
app.route("/api/admin", adminRoutes);
app.route("/api/tariff", tariffRoutes);
app.use("/menu.html", requireAuth, serveStatic({ root: publicDir }));
app.use("/admin/*", requireAuth, serveStatic({ root: publicDir }));
// ── MODULE ACCESS GUARD ──
// Blok akses langsung via URL jika user tidak punya izin ke modul tersebut
app.use("/modules/:domainSlug/:moduleSlug/*", requireAuth, async (c, next) => {
    const user = c.get("user");
    if (user.role === "admin")
        return next(); // admin bypass
    const domainSlug = c.req.param("domainSlug");
    const moduleSlug = c.req.param("moduleSlug");
    // Cari domain
    const [domain] = await db.select().from(domains)
        .where(and(eq(domains.slug, domainSlug), eq(domains.isActive, true)))
        .limit(1);
    if (!domain)
        return c.redirect("/menu.html");
    // Cek domain access
    const [domAccess] = await db.select().from(userDomainAccess)
        .where(and(eq(userDomainAccess.userId, user.id), eq(userDomainAccess.domainId, domain.id)))
        .limit(1);
    if (!domAccess)
        return c.redirect("/menu.html");
    // Cek apakah user punya pembatasan per-modul
    const modAccessList = await db.select().from(userModuleAccess)
        .where(eq(userModuleAccess.userId, user.id));
    if (modAccessList.length === 0)
        return next(); // tidak ada pembatasan = full access
    // Cari module
    const [mod] = await db.select().from(domainModules)
        .where(and(eq(domainModules.domainId, domain.id), eq(domainModules.slug, moduleSlug)))
        .limit(1);
    if (!mod)
        return c.redirect("/menu.html");
    // Cek apakah module ini termasuk yang diizinkan
    const allowedIds = new Set(modAccessList.map((m) => m.moduleId));
    if (!allowedIds.has(mod.id))
        return c.redirect("/menu.html");
    return next();
});
app.use("/modules/*", serveStatic({ root: publicDir }));
app.use("/*", serveStatic({ root: publicDir }));
const port = Number(process.env.PORT) || 3000;
serve({
    fetch: app.fetch,
    port,
    hostname: "0.0.0.0",
});
//# sourceMappingURL=index.js.map