import { Hono } from "hono";
import { sql } from "drizzle-orm";
import { db } from "../db/client.js";
import { requireAuth } from "../middleware/auth.js";

export const plnSrRoutes = new Hono();
plnSrRoutes.use("*", requireAuth);

const rows = (r: any) => (Array.isArray(r) && Array.isArray(r[0]) ? r[0] : r);

// All years
plnSrRoutes.get("/all", async (c) => {
  const r = await db.execute(sql`SELECT * FROM pln_sr_summary ORDER BY year ASC`);
  return c.json(rows(r));
});

// Single year
plnSrRoutes.get("/year/:year", async (c) => {
  const yr = parseInt(c.req.param("year") ?? "0");
  if (!yr) return c.json({ error: "year invalid" }, 400);
  const r = await db.execute(sql`SELECT * FROM pln_sr_summary WHERE year = ${yr} LIMIT 1`);
  const result = rows(r);
  if (!result.length) return c.json({ error: "not found" }, 404);
  return c.json(result[0]);
});
