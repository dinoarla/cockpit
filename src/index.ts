import "dotenv/config";
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

// --- API routes ---
app.route("/api/auth", authRoutes);
app.route("/api/domains", domainRoutes);
app.route("/api/mdp", mdpRoutes);
app.route("/api/ruptl", ruptlRoutes);

// Tambahkan modul baru di sini seiring berkembangnya portal, contoh:
// app.route("/api/pelanggan", pelangganRoutes);
// app.route("/api/olap-tagihan", olapTagihanRoutes);
// app.route("/api/pencurian", pencurianRoutes);
// app.route("/api/ruptl", ruptlRoutes);

// --- Halaman terproteksi: requireAuth dulu, baru serve file statis ---
app.use("/menu.html", requireAuth, serveStatic({ root: "./public" }));
app.use("/modules/*", requireAuth, serveStatic({ root: "./public" }));

// --- Static assets (login page, CSS, dll — publik) ---
app.use("/*", serveStatic({ root: "./public" }));

const port = Number(process.env.PORT ?? 3000);

console.log(`Server jalan di http://localhost:${port}`);
serve({ fetch: app.fetch, port });
