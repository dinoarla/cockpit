import { Hono } from "hono";
import { sql } from "drizzle-orm";
import { db } from "../db/client.js";
import { requireAuth } from "../middleware/auth.js";
export const plnSrRoutes = new Hono();
plnSrRoutes.use("*", requireAuth);
// All years
plnSrRoutes.get("/all", async (c) => {
    const result = await db.execute(sql `SELECT * FROM pln_sr_summary ORDER BY year ASC`);
    const rows = Array.isArray(result) && Array.isArray(result[0]) ? result[0] : result;
    return c.json(rows);
});
// Single year
plnSrRoutes.get("/year/:year", async (c) => {
    const yr = parseInt(c.req.param("year") ?? "0");
    if (!yr)
        return c.json({ error: "year invalid" }, 400);
    const result = await db.execute(sql `SELECT * FROM pln_sr_summary WHERE year = ${yr} LIMIT 1`);
    const rows = Array.isArray(result) && Array.isArray(result[0]) ? result[0] : result;
    if (!rows.length)
        return c.json({ error: "not found" }, 404);
    return c.json(rows[0]);
});
//# sourceMappingURL=pln-sr.js.map
