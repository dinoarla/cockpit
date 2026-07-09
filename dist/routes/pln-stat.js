import { Hono } from "hono";
import { asc, eq } from "drizzle-orm";
import { db } from "../db/client.js";
import { plnStatNational } from "../db/schema.js";
import { requireAuth } from "../middleware/auth.js";
export const plnStatRoutes = new Hono();
plnStatRoutes.use("*", requireAuth);
plnStatRoutes.get("/national", async (c) => {
    const rows = await db
        .select()
        .from(plnStatNational)
        .orderBy(asc(plnStatNational.year));
    return c.json(rows);
});
plnStatRoutes.get("/year/:year", async (c) => {
    const yr = parseInt(c.req.param("year") ?? "0");
    if (!yr)
        return c.json({ error: "year invalid" }, 400);
    const [row] = await db
        .select()
        .from(plnStatNational)
        .where(eq(plnStatNational.year, yr))
        .limit(1);
    if (!row)
        return c.json({ error: "not found" }, 404);
    return c.json(row);
});
