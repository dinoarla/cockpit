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

const __dirname = dirname(fileURLToPath(import.meta.url));
const publicDir = join(__dirname, "..", "public");

const app = new Hono();

app.use("*", securityHeaders);
app.get("/healthz", (c) => c.json({ status: "ok", ts: new Date().toISOString() }));

app.route("/api/auth", authRoutes);
app.route("/api/domains", domainRoutes);
app.route("/api/mdp", mdpRoutes);
app.route("/api/ruptl", ruptlRoutes);

app.use("/menu.html", requireAuth, serveStatic({ root: publicDir }));
app.use("/modules/*", requireAuth, serveStatic({ root: publicDir }));
app.use("/*", serveStatic({ root: publicDir }));

const port = Number(process.env.PORT ?? 3000);

serve({
  fetch: app.fetch,
  port,
  hostname: "0.0.0.0",
});
