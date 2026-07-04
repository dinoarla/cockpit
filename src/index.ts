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

// Health check — tidak butuh DB
app.get("/healthz", (c) => c.json({ status: "ok", ts: new Date().toISOString() }));

// --- API routes ---
app.route("/api/auth", authRoutes);
app.route("/api/domains", domainRoutes);
app.route("/api/mdp", mdpRoutes);
app.route("/api/ruptl", ruptlRoutes);

// --- Halaman terproteksi ---
app.use("/menu.html", requireAuth, serveStatic({ root: "./public" }));
app.use("/modules/*", requireAuth, serveStatic({ root: "./public" }));

// --- Static assets ---
app.use("/*", serveStatic({ root: "./public" }));

// Export untuk Hostinger Hono preset (edge/serverless style)
export default app;

// Jalankan HTTP server hanya di local development
if (process.env.NODE_ENV !== "production") {
  const port = Number(process.env.PORT ?? 3000);
  console.log("[COCKPIT] Dev mode — starting local server on port", port);
  serve({ fetch: app.fetch, port, hostname: "0.0.0.0" }, (info) => {
    console.log(`[COCKPIT] http://${info.address}:${info.port}`);
  });
}
