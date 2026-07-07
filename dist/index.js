import "dotenv/config";
import os from "node:os";
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
app.get("/api/server-stats", requireAuth, (c) => {
    const totalMem = os.totalmem();
    const freeMem = os.freemem();
    const usedMem = totalMem - freeMem;
    const loadAvg = os.loadavg();
    const cpus = os.cpus();
    return c.json({
        memory: {
            total: Math.round(totalMem / 1024 / 1024),
            used: Math.round(usedMem / 1024 / 1024),
            free: Math.round(freeMem / 1024 / 1024),
            percent: Math.round((usedMem / totalMem) * 100),
        },
        load: {
            m1: Math.round(loadAvg[0] * 100) / 100,
            m5: Math.round(loadAvg[1] * 100) / 100,
            m15: Math.round(loadAvg[2] * 100) / 100,
        },
        uptime: Math.floor(os.uptime()),
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
app.use("/menu.html", requireAuth, serveStatic({ root: publicDir }));
app.use("/admin/*", requireAuth, serveStatic({ root: publicDir }));
// ── TOKEN-BASED MODULE HANDLER ──
// URL modul menggunakan token acak (url_token), bukan slug asli.
// Server resolve token → slug → file, sambil cek akses user.
app.get("/modules/:domainSlug/:token/", requireAuth, async (c) => {
    const user = c.get("user");
    const domainSlug = c.req.param("domainSlug") ?? "";
    const token = c.req.param("token") ?? "";
    if (!domainSlug || !token)
        return c.redirect("/menu.html");
    // Resolve domain
    const [domain] = await db.select().from(domains)
        .where(and(eq(domains.slug, domainSlug), eq(domains.isActive, true)))
        .limit(1);
    if (!domain)
        return c.redirect("/menu.html");
    // Resolve token → module (urlToken is nullable, filter client-side)
    const candidates = await db.select().from(domainModules)
        .where(eq(domainModules.domainId, domain.id));
    const mod = candidates.find((m) => m.urlToken === token);
    if (!mod)
        return c.redirect("/menu.html");
    // Access check untuk non-admin
    if (user.role !== "admin") {
        const [domAccess] = await db.select().from(userDomainAccess)
            .where(and(eq(userDomainAccess.userId, user.id), eq(userDomainAccess.domainId, domain.id)))
            .limit(1);
        if (!domAccess)
            return c.redirect("/menu.html");
        const modAccessList = await db.select().from(userModuleAccess)
            .where(eq(userModuleAccess.userId, user.id));
        if (modAccessList.length > 0) {
            const allowedIds = new Set(modAccessList.map((m) => m.moduleId));
            if (!allowedIds.has(mod.id))
                return c.redirect("/menu.html");
        }
    }
    // Serve file dari path asli (slug, bukan token)
    const filePath = join(publicDir, "modules", domainSlug, mod.slug, "index.html");
    try {
        const content = await readFile(filePath, "utf-8");
        return c.html(content);
    }
    catch {
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
//# sourceMappingURL=index.js.map