import "dotenv/config";

process.on("uncaughtException", (err) => {
  console.error("[COCKPIT] uncaughtException:", err.message, err.stack);
  process.exit(1);
});
process.on("unhandledRejection", (reason) => {
  console.error("[COCKPIT] unhandledRejection:", reason);
  process.exit(1);
});

import { serve } from "@hono/node-server";
import { serveStatic } from "@hono/node-server/serve-static";
import { Hono } from "hono";
import { securityHeaders, requireAuth } from "./middleware/auth.js";
import { authRoutes } from "./routes/auth.js";
import { domainRoutes } from "./routes/domains.js";
import { mdpRoutes } from "./routes/mdp.js";
import { ruptlRoutes } from "./routes/ruptl.js";

const app = new Hono();

app.use("*", securityHeaders);

// Health check — tidak butuh DB, untuk verifikasi app berjalan
app.get("/healthz", (c) => c.json({ status: "ok", ts: new Date().toISOString() }));

// --- API routes ---
app.route("/api/auth", authRoutes);
app.route("/api/domains", domainRoutes);
app.route("/api/mdp", mdpRoutes);
app.route("/api/ruptl", ruptlRoutes);

// --- Halaman terproteksi ---
app.use("/menu.html", requireAuth, serveStatic({ root: "./public" }));
app.use("/modules/*", requireAuth, serveStatic({ root: "./public" }));

// --- Static assets (login page, CSS, dll) ---
app.use("/*", serveStatic({ root: "./public" }));

const port = Number(process.env.PORT ?? 3000);

console.log("[COCKPIT] Env check:", {
  DB_HOST:  process.env.DB_HOST  ? "SET" : "MISSING",
  DB_USER:  process.env.DB_USER  ? "SET" : "MISSING",
  DB_NAME:  process.env.DB_NAME  ? "SET" : "MISSING",
  PORT:     process.env.PORT     ?? "(default 3000)",
  NODE_ENV: process.env.NODE_ENV ?? "(not set)",
});

serve({ fetch: app.fetch, port, hostname: "0.0.0.0" }, (info) => {
  console.log(`[COCKPIT] Server berjalan di http://${info.address}:${info.port}`);
});
