import "dotenv/config";
import os from "node:os";
import fs from "node:fs";
import { fileURLToPath } from "node:url";
import { dirname, join } from "node:path";
import { readFile } from "node:fs/promises";
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
import { olapTagihanRoutes } from "./routes/olap-tagihan.js";
import { plnScholarRoutes } from "./routes/pln-scholar.js";
import { plnStatRoutes } from "./routes/pln-stat.js";
import { plnSrRoutes } from "./routes/pln-sr.js";
import { plnArRoutes } from "./routes/pln-ar.js";
import { simbaRoutes } from "./routes/simba.js";
import { bacaMeterRoutes } from "./routes/baca-meter.js";
import { gantiMeterRoutes } from "./routes/ganti-meter.js";
import { chatbotRoutes } from "./routes/chatbot.js";
import { db } from "./db/client.js";
import { domains, domainModules, userDomainAccess, userModuleAccess, sessions } from "./db/schema.js";
import { eq, and, sql, gt } from "drizzle-orm";

const __dirname = dirname(fileURLToPath(import.meta.url));
const publicDir = join(__dirname, "..", "public");

const app = new Hono();

app.use("*", securityHeaders);
app.get("/healthz", async (c) => {
  const [latest] = await db
    .select({ lastUpdate: sql<string>`MAX(created_at)` })
    .from(domainModules);
  return c.json({
    status: "ok",
    ts: new Date().toISOString(),
    lastUpdate: latest?.lastUpdate ?? null,
  });
});

app.get("/api/server-stats", requireAuth, async (c) => {
  const totalMem = os.totalmem();
  const freeMem  = os.freemem();
  const usedMem  = totalMem - freeMem;
  const loadAvg  = os.loadavg();
  const cpus     = os.cpus();
  const heap     = process.memoryUsage();

  // Disk usage via fs.statfs (Node ≥ 18.15)
  let disk = null;
  try {
    const stat = fs.statfsSync("/");
    const diskTotal = stat.blocks  * stat.bsize;
    const diskFree  = stat.bfree   * stat.bsize;
    const diskUsed  = diskTotal - diskFree;
    disk = {
      total:   Math.round(diskTotal / 1024 / 1024 / 1024 * 10) / 10,
      used:    Math.round(diskUsed  / 1024 / 1024 / 1024 * 10) / 10,
      free:    Math.round(diskFree  / 1024 / 1024 / 1024 * 10) / 10,
      percent: Math.round((diskUsed / diskTotal) * 100),
    };
  } catch { /* statfs tidak tersedia */ }

  // Active sessions (belum expired)
  let activeSessions = 0;
  try {
    const [row] = await db
      .select({ count: sql<number>`COUNT(*)` })
      .from(sessions)
      .where(gt(sessions.expiresAt, new Date()));
    activeSessions = Number(row?.count ?? 0);
  } catch { /* skip */ }

  return c.json({
    memory: {
      total:   Math.round(totalMem / 1024 / 1024),
      used:    Math.round(usedMem  / 1024 / 1024),
      free:    Math.round(freeMem  / 1024 / 1024),
      percent: Math.round((usedMem / totalMem) * 100),
    },
    load: {
      m1:  Math.round(loadAvg[0] * 100) / 100,
      m5:  Math.round(loadAvg[1] * 100) / 100,
      m15: Math.round(loadAvg[2] * 100) / 100,
    },
    heap: {
      used:  Math.round(heap.heapUsed  / 1024 / 1024),
      total: Math.round(heap.heapTotal / 1024 / 1024),
      rss:   Math.round(heap.rss       / 1024 / 1024),
      percent: Math.round((heap.heapUsed / heap.heapTotal) * 100),
    },
    disk,
    activeSessions,
    uptime:   Math.floor(os.uptime()),
    cpuCount: cpus.length,
  });
});

app.route("/api/auth", authRoutes);
app.route("/api/domains", domainRoutes);
app.route("/api/mdp", mdpRoutes);
app.route("/api/ruptl", ruptlRoutes);
app.route("/api/admin", adminRoutes);
app.route("/api/tariff", tariffRoutes);
app.route("/api/olap-tagihan", olapTagihanRoutes);
app.route("/api/pln-scholar", plnScholarRoutes);
app.route("/api/pln-stat", plnStatRoutes);
app.route("/api/pln-sr", plnSrRoutes);
app.route("/api/pln-ar", plnArRoutes);
app.route("/api/simba", simbaRoutes);
app.route("/api/baca-meter", bacaMeterRoutes);
app.route("/api/ganti-meter", gantiMeterRoutes);
app.route("/api/chatbot", chatbotRoutes);

// Helper: inject widget ke semua halaman yang sudah login
function injectWidget(html: string): string {
  return html.replace("</body>", '<script src="/assets/chatbot-widget.js"></script></body>');
}

app.get("/menu.html", requireAuth, async (c) => {
  const content = await readFile(join(publicDir, "menu.html"), "utf-8");
  return c.html(injectWidget(content));
});

app.use("/admin/*", requireAuth, async (c, next) => {
  const reqPath = c.req.path.replace(/^\//, "");
  const candidates = [
    join(publicDir, reqPath),
    join(publicDir, reqPath, "index.html"),
  ];
  for (const fp of candidates) {
    try {
      const content = await readFile(fp, "utf-8");
      return c.html(injectWidget(content));
    } catch { /* try next */ }
  }
  return next();
});

// ── TOKEN-BASED MODULE HANDLER ──
// URL modul menggunakan token acak (url_token), bukan slug asli.
// Server resolve token → slug → file, sambil cek akses user.
app.get("/modules/:domainSlug/:token/", requireAuth, async (c) => {
  const user       = c.get("user");
  const domainSlug = c.req.param("domainSlug") ?? "";
  const token      = c.req.param("token") ?? "";
  if (!domainSlug || !token) return c.redirect("/menu.html");

  // Resolve domain
  const [domain] = await db.select().from(domains)
    .where(and(eq(domains.slug, domainSlug), eq(domains.isActive, true)))
    .limit(1);
  if (!domain) return c.redirect("/menu.html");

  // Resolve token → module (urlToken is nullable, filter client-side)
  const candidates = await db.select().from(domainModules)
    .where(eq(domainModules.domainId, domain.id));
  const mod = candidates.find((m) => m.urlToken === token);
  if (!mod) return c.redirect("/menu.html");

  // Access check untuk non-admin
  if (user.role !== "admin") {
    const [domAccess] = await db.select().from(userDomainAccess)
      .where(and(eq(userDomainAccess.userId, user.id), eq(userDomainAccess.domainId, domain.id)))
      .limit(1);
    if (!domAccess) return c.redirect("/menu.html");

    const modAccessList = await db.select().from(userModuleAccess)
      .where(eq(userModuleAccess.userId, user.id));

    if (modAccessList.length > 0) {
      const allowedIds = new Set(modAccessList.map((m) => m.moduleId));
      if (!allowedIds.has(mod.id)) return c.redirect("/menu.html");
    }
  }

  // Serve file dari path asli (slug, bukan token)
  const filePath = join(publicDir, "modules", domainSlug, mod.slug, "index.html");
  try {
    const content = await readFile(filePath, "utf-8");
    return c.html(injectWidget(content));
  } catch {
    return c.redirect("/menu.html");
  }
});

// Semua path /modules/* lainnya → redirect (tidak bisa akses langsung via slug)
app.all("/modules/*", requireAuth, (c) => c.redirect("/menu.html"));
app.use("/*", serveStatic({ root: publicDir }));

const port = Number(process.env.PORT) || 3000;

serve({
  fetch: app.fetch,
  port,
  hostname: "0.0.0.0",
});
