import { Hono } from "hono";
import { eq, desc, and, count, gte, sql } from "drizzle-orm";
import { db, getPool } from "../db/client.js";
import {
  users, sessions, loginAudit, domains, domainModules,
  userDomainAccess, userModuleAccess,
} from "../db/schema.js";
import { requireAuth, requireRole } from "../middleware/auth.js";
import { hashPassword, validatePasswordStrength } from "../auth/password.js";
import * as path from "path";
import * as fs from "fs";
import * as os from "os";
import { fileURLToPath } from "url";

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
  const result = await Promise.all(
    userList.map(async (u) => {
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
    })
  );

  return c.json(result);
});

adminRoutes.post("/users", async (c) => {
  const me = c.get("user");
  const body = await c.req.json<{
    username: string; email: string; password: string;
    role: "admin" | "editor" | "viewer";
    domainSlugs?: string[];
    moduleSlugs?: string[];
  }>();

  const { username, email, password, role, domainSlugs = [], moduleSlugs = [] } = body;

  if (!username || !email || !password || !role) {
    return c.json({ error: "username, email, password, role wajib diisi." }, 400);
  }

  const pwCheck = validatePasswordStrength(password);
  if (!pwCheck.ok) return c.json({ error: pwCheck.message }, 400);

  const [existing] = await db.select().from(users).where(eq(users.username, username)).limit(1);
  if (existing) return c.json({ error: "Username sudah dipakai." }, 409);

  const passwordHash = await hashPassword(password);
  const insertResult = await db.insert(users).values({ username, email, passwordHash, role });
  const newUserId = (insertResult as any).insertId as number;

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

async function doDeleteUser(c: any, id: number) {
  const me = c.get("user");
  if (id === me.id) return c.json({ error: "Tidak bisa menghapus akun sendiri." }, 400);
  if (!id || isNaN(id)) return c.json({ error: "ID user tidak valid." }, 400);

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
  const body = await c.req.json<{ isActive?: boolean; role?: "admin"|"editor"|"viewer" }>();

  const update: Record<string, unknown> = {};
  if (body.isActive !== undefined) update.isActive = body.isActive;
  if (body.role) update.role = body.role;
  if (!Object.keys(update).length) return c.json({ error: "Tidak ada field yang diupdate." }, 400);

  await db.update(users).set(update).where(eq(users.id, id));
  return c.json({ ok: true });
});

// Reset password user
adminRoutes.post("/users/:id/reset-password", async (c) => {
  const id = Number(c.req.param("id"));
  const { password } = await c.req.json<{ password: string }>();
  const pwCheck = validatePasswordStrength(password);
  if (!pwCheck.ok) return c.json({ error: pwCheck.message }, 400);
  const hash = await hashPassword(password);
  await db.update(users).set({ passwordHash: hash, failedLoginCount: 0, lockedUntil: null }).where(eq(users.id, id));
  return c.json({ ok: true });
});

// Set module access untuk user (replace all)
adminRoutes.put("/users/:id/access", async (c) => {
  const me = c.get("user");
  const userId = Number(c.req.param("id"));
  const body = await c.req.json<{ domainSlugs: string[]; moduleSlugs: string[] }>();

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
  const since7d  = new Date(now.getTime() - 7 * 24 * 3600 * 1000);

  const [totalUsers]   = await db.select({ n: count() }).from(users);
  const [activeUsers]  = await db.select({ n: count() }).from(users).where(eq(users.isActive, true));
  const [lockedUsers]  = await db.select({ n: count() }).from(users).where(gte(users.lockedUntil, now));
  const [activeSess]   = await db.select({ n: count() }).from(sessions).where(gte(sessions.expiresAt, now));

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
    .orderBy(sql`count(*) DESC`)
    .limit(10);

  // Gagal login per alasan
  const failReasons = await db
    .select({ reason: loginAudit.reason, n: count() })
    .from(loginAudit)
    .where(and(eq(loginAudit.success, false), gte(loginAudit.createdAt, since7d)))
    .groupBy(loginAudit.reason)
    .orderBy(sql`count(*) DESC`);

  return c.json({
    users:       { total: totalUsers.n, active: activeUsers.n, locked: lockedUsers.n },
    sessions:    { active: activeSess.n },
    loginFailed: { last24h: failed24h.n, last7d: failed7d.n },
    loginOk:     { last7d: success7d.n },
    topFailIPs,
    failReasons,
    encryption: {
      algorithm:  "AES-256-GCM",
      fields:     ["password_hash (bcrypt-12)", "session_id (SHA-256 hash)", "field_encryption (AES-256-GCM)"],
      cookieFlags: ["httpOnly", process.env.COOKIE_SECURE === "true" ? "Secure" : "Secure:OFF(dev)", "SameSite=Lax"],
      headers:    ["X-Frame-Options:DENY", "X-Content-Type-Options:nosniff", "CSP aktif", "Referrer-Policy"],
    },
  });
});

/* ── DOMAINS & MODULES (untuk admin UI dropdown) ── */

adminRoutes.get("/domains-modules", async (c) => {
  const domainList = await db.select().from(domains).where(eq(domains.isActive, true));
  const result = await Promise.all(
    domainList.map(async (d) => {
      const mods = await db.select().from(domainModules).where(eq(domainModules.domainId, d.id));
      return { ...d, modules: mods };
    })
  );
  return c.json(result);
});

/* ── DATABASE MANAGEMENT ── */

// Use BACKUP_DIR env var if set (recommended for production), otherwise persist in home directory
// so backups survive server restarts and re-deploys
const BACKUP_DIR = process.env.BACKUP_DIR ?? path.join(os.homedir(), "cockpit_backups");
const SCHEDULE_FILE = path.join(BACKUP_DIR, ".schedule.json");

interface ScheduleConfig {
  enabled: boolean;
  intervalHours: number;
  lastBackupAt: string | null;
  nextBackupAt: string | null;
  keepCount: number;
}

function ensureBackupDir() {
  if (!fs.existsSync(BACKUP_DIR)) fs.mkdirSync(BACKUP_DIR, { recursive: true });
}

function readSchedule(): ScheduleConfig {
  try {
    if (fs.existsSync(SCHEDULE_FILE))
      return JSON.parse(fs.readFileSync(SCHEDULE_FILE, "utf8"));
  } catch {}
  return { enabled: false, intervalHours: 24, lastBackupAt: null, nextBackupAt: null, keepCount: 7 };
}

function writeSchedule(cfg: ScheduleConfig) {
  ensureBackupDir();
  fs.writeFileSync(SCHEDULE_FILE, JSON.stringify(cfg, null, 2), "utf8");
}

function listBackups() {
  ensureBackupDir();
  return fs.readdirSync(BACKUP_DIR)
    .filter(f => f.endsWith(".sql"))
    .map(f => {
      const stat = fs.statSync(path.join(BACKUP_DIR, f));
      return { name: f, size: stat.size, createdAt: stat.mtime.toISOString() };
    })
    .sort((a, b) => b.createdAt.localeCompare(a.createdAt));
}

function escSqlVal(v: unknown): string {
  if (v === null || v === undefined) return "NULL";
  if (typeof v === "number") return String(v);
  if (typeof v === "boolean") return v ? "1" : "0";
  if (v instanceof Date) return `'${v.toISOString().slice(0, 19).replace("T", " ")}'`;
  if (Buffer.isBuffer(v)) return `0x${v.toString("hex")}`;
  return `'${String(v).replace(/\\/g, "\\\\").replace(/'/g, "\\'").replace(/\n/g, "\\n").replace(/\r/g, "\\r")}'`;
}

async function generateBackupSql(dbName: string): Promise<string> {
  const conn = await getPool().getConnection();
  try {
    const lines: string[] = [
      `-- COCKPIT Database Backup`,
      `-- Database: ${dbName}`,
      `-- Generated: ${new Date().toISOString()}`,
      `-- Host: ${process.env.DB_HOST ?? "localhost"}\n`,
      `SET NAMES utf8mb4;`,
      `SET FOREIGN_KEY_CHECKS=0;\n`,
    ];

    const [tableStatus] = await conn.execute("SHOW TABLE STATUS") as any[];

    for (const tbl of tableStatus as any[]) {
      const tblName: string = tbl.Name;
      const rowEst: number = tbl.Rows ?? 0;

      lines.push(`-- ── Table: \`${tblName}\` (≈${rowEst} rows) ──`);

      const [[createRow]] = await conn.execute(`SHOW CREATE TABLE \`${tblName}\``) as any[];
      lines.push(`DROP TABLE IF EXISTS \`${tblName}\`;`);
      lines.push((createRow as any)["Create Table"] + ";\n");

      if (rowEst <= 50000) {
        const [rows] = await conn.execute(`SELECT * FROM \`${tblName}\``) as any[];
        const rowArr = rows as Record<string, unknown>[];
        if (rowArr.length > 0) {
          const cols = Object.keys(rowArr[0]).map(c => `\`${c}\``).join(", ");
          const CHUNK = 500;
          for (let i = 0; i < rowArr.length; i += CHUNK) {
            const vals = rowArr.slice(i, i + CHUNK)
              .map(r => "(" + Object.values(r).map(escSqlVal).join(", ") + ")")
              .join(",\n");
            lines.push(`INSERT INTO \`${tblName}\` (${cols}) VALUES\n${vals};\n`);
          }
        }
      } else {
        lines.push(`-- Data skipped: ${rowEst} rows (>50k limit — re-import dari sumber)\n`);
      }
    }

    lines.push(`SET FOREIGN_KEY_CHECKS=1;`);
    lines.push(`-- Backup selesai: ${new Date().toISOString()}`);
    return lines.join("\n");
  } finally {
    conn.release();
  }
}

async function pruneOldBackups(keepCount: number) {
  const backups = listBackups();
  if (backups.length > keepCount) {
    for (const b of backups.slice(keepCount)) {
      try { fs.unlinkSync(path.join(BACKUP_DIR, b.name)); } catch {}
    }
  }
}

// ── DB INFO ──
adminRoutes.get("/db/info", async (c) => {
  const conn = await getPool().getConnection();
  try {
    const dbName = process.env.DB_NAME ?? "";
    const [tableStatus] = await conn.execute("SHOW TABLE STATUS") as any[];
    const tables = (tableStatus as any[]).map((t: any) => ({
      name: t.Name, engine: t.Engine, rows: t.Rows ?? 0,
      dataLength: t.Data_length ?? 0, indexLength: t.Index_length ?? 0,
      createTime: t.Create_time, updateTime: t.Update_time,
    }));
    const totalRows = tables.reduce((s, t) => s + t.rows, 0);
    const totalSize = tables.reduce((s, t) => s + t.dataLength + t.indexLength, 0);
    return c.json({ dbName, tables, totalRows, totalSize, backupCount: listBackups().length, schedule: readSchedule() });
  } finally { conn.release(); }
});

// ── BACKUP LIST ──
adminRoutes.get("/db/backups", async (c) => c.json(listBackups()));

// ── TRIGGER BACKUP ──
adminRoutes.post("/db/backup", async (c) => {
  const dbName = process.env.DB_NAME ?? "cockpit";
  const ts = new Date().toISOString().replace(/[:.]/g, "-").slice(0, 19);
  const filename = `cockpit_${dbName}_${ts}.sql`;
  const filepath = path.join(BACKUP_DIR, filename);
  ensureBackupDir();
  try {
    const sqlContent = await generateBackupSql(dbName);
    fs.writeFileSync(filepath, sqlContent, "utf8");
    const sched = readSchedule();
    sched.lastBackupAt = new Date().toISOString();
    if (sched.enabled) sched.nextBackupAt = new Date(Date.now() + sched.intervalHours * 3_600_000).toISOString();
    writeSchedule(sched);
    await pruneOldBackups(sched.keepCount ?? 7);
    return c.json({ ok: true, filename, size: fs.statSync(filepath).size });
  } catch (err: any) {
    return c.json({ error: err.message }, 500);
  }
});

// ── DOWNLOAD BACKUP ──
adminRoutes.get("/db/backup/:name/download", async (c) => {
  const name = c.req.param("name");
  if (!name || name.includes("/") || name.includes("..")) return c.json({ error: "Invalid" }, 400);
  const filepath = path.join(BACKUP_DIR, name);
  if (!fs.existsSync(filepath)) return c.json({ error: "Not found" }, 404);
  const content = fs.readFileSync(filepath);
  return new Response(content, {
    headers: {
      "Content-Type": "application/octet-stream",
      "Content-Disposition": `attachment; filename="${name}"`,
      "Content-Length": String(content.length),
    },
  });
});

// ── DELETE BACKUP ──
async function doDeleteBackup(c: any, name: string) {
  if (!name || name.includes("/") || name.includes("..")) return c.json({ error: "Invalid" }, 400);
  const filepath = path.join(BACKUP_DIR, name);
  if (!fs.existsSync(filepath)) return c.json({ error: "Not found" }, 404);
  fs.unlinkSync(filepath);
  return c.json({ ok: true });
}
adminRoutes.delete("/db/backup/:name", (c) => doDeleteBackup(c, c.req.param("name")));
adminRoutes.post("/db/backup/:name/delete", (c) => doDeleteBackup(c, c.req.param("name")));

// ── RESTORE ──
adminRoutes.post("/db/restore", async (c) => {
  const body = await c.req.formData();
  const file = body.get("file") as File | null;
  if (!file) return c.json({ error: "No file uploaded" }, 400);
  const text = await file.text();
  const conn = await getPool().getConnection();
  let executed = 0;
  const errors: string[] = [];
  const stmts = text
    .split(/;\s*\n/)
    .map((s: string) => s.trim())
    .filter((s: string) => s && !s.startsWith("--") && !s.startsWith("/*") && s.length > 3);
  try {
    for (const stmt of stmts) {
      try { await conn.execute(stmt); executed++; } catch (err: any) {
        errors.push(err.message.slice(0, 120));
        if (errors.length > 10) break;
      }
    }
  } finally { conn.release(); }
  return c.json({ ok: errors.length === 0, executed, errors });
});

// ── SCHEDULE ──
adminRoutes.get("/db/schedule", async (c) => c.json(readSchedule()));
adminRoutes.post("/db/schedule", async (c) => {
  const body = await c.req.json<{ enabled: boolean; intervalHours: number; keepCount: number }>();
  const sched = readSchedule();
  sched.enabled = body.enabled;
  sched.intervalHours = Math.max(1, Number(body.intervalHours) || 24);
  sched.keepCount = Math.max(1, Math.min(30, Number(body.keepCount) || 7));
  if (sched.enabled) {
    const base = sched.lastBackupAt ? new Date(sched.lastBackupAt).getTime() : Date.now();
    sched.nextBackupAt = new Date(base + sched.intervalHours * 3_600_000).toISOString();
  } else {
    sched.nextBackupAt = null;
  }
  writeSchedule(sched);
  resetScheduleTimer();
  return c.json({ ok: true, schedule: sched });
});

// ── AUTO-BACKUP TIMER ──
let _schedTimer: ReturnType<typeof setInterval> | null = null;

async function runAutoBackup() {
  const sched = readSchedule();
  if (!sched.enabled) return;
  if (sched.nextBackupAt && new Date(sched.nextBackupAt).getTime() > Date.now()) return;
  const dbName = process.env.DB_NAME ?? "cockpit";
  const ts = new Date().toISOString().replace(/[:.]/g, "-").slice(0, 19);
  const filename = `cockpit_${dbName}_auto_${ts}.sql`;
  ensureBackupDir();
  try {
    const sql = await generateBackupSql(dbName);
    fs.writeFileSync(path.join(BACKUP_DIR, filename), sql, "utf8");
    sched.lastBackupAt = new Date().toISOString();
    sched.nextBackupAt = new Date(Date.now() + sched.intervalHours * 3_600_000).toISOString();
    writeSchedule(sched);
    await pruneOldBackups(sched.keepCount ?? 7);
    console.log(`[AutoBackup] ${filename} (${Math.round(sql.length / 1024)} KB)`);
  } catch (err) {
    console.error("[AutoBackup] Error:", err);
  }
}

function resetScheduleTimer() {
  if (_schedTimer) { clearInterval(_schedTimer); _schedTimer = null; }
  const sched = readSchedule();
  if (!sched.enabled) return;
  _schedTimer = setInterval(runAutoBackup, 3_600_000); // cek tiap jam
}

// Jalankan 5 detik setelah server start
setTimeout(() => { try { resetScheduleTimer(); runAutoBackup(); } catch {} }, 5000);
