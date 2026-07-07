import { Hono } from "hono";
import { sql, like, eq, and, asc } from "drizzle-orm";
import { db } from "../db/client.js";
import { plnScholar } from "../db/schema.js";
import { requireAuth } from "../middleware/auth.js";

export const plnScholarRoutes = new Hono();
plnScholarRoutes.use("*", requireAuth);

plnScholarRoutes.get("/stats", async (c) => {
  const [totals] = await db
    .select({
      total:   sql<number>`COUNT(*)`,
      minYear: sql<number>`MIN(year)`,
      maxYear: sql<number>`MAX(year)`,
    })
    .from(plnScholar);

  const byEntity = await db
    .select({ entity: plnScholar.entity, count: sql<number>`COUNT(*)` })
    .from(plnScholar)
    .groupBy(plnScholar.entity)
    .orderBy(asc(plnScholar.entity));

  const byYear = await db
    .select({ year: plnScholar.year, count: sql<number>`COUNT(*)` })
    .from(plnScholar)
    .where(sql`year IS NOT NULL`)
    .groupBy(plnScholar.year)
    .orderBy(asc(plnScholar.year));

  const byBidang = await db
    .select({ bidang: plnScholar.bidang, count: sql<number>`COUNT(*)` })
    .from(plnScholar)
    .where(sql`bidang != ''`)
    .groupBy(plnScholar.bidang)
    .orderBy(asc(plnScholar.bidang));

  const byUnit = await db
    .select({ unit: plnScholar.unit, count: sql<number>`COUNT(*)` })
    .from(plnScholar)
    .groupBy(plnScholar.unit)
    .orderBy(asc(plnScholar.unit));

  return c.json({ totals, byEntity, byYear, byBidang, byUnit });
});

plnScholarRoutes.get("/search", async (c) => {
  const q      = c.req.query("q")      ?? "";
  const entity = c.req.query("entity") ?? "";
  const year   = c.req.query("year")   ?? "";
  const bidang = c.req.query("bidang") ?? "";
  const unit   = c.req.query("unit")   ?? "";
  const page   = Math.max(1, parseInt(c.req.query("page") ?? "1"));
  const limit  = 20;
  const offset = (page - 1) * limit;

  const conditions = [];
  if (q)      conditions.push(like(plnScholar.title, `%${q}%`));
  if (entity) conditions.push(eq(plnScholar.entity, entity));
  if (bidang) conditions.push(eq(plnScholar.bidang, bidang));
  if (unit)   conditions.push(eq(plnScholar.unit, unit));
  if (year)   conditions.push(eq(plnScholar.year, parseInt(year)));

  const where = conditions.length > 0 ? and(...conditions) : undefined;

  const [{ total }] = await db
    .select({ total: sql<number>`COUNT(*)` })
    .from(plnScholar)
    .where(where);

  const rows = await db
    .select()
    .from(plnScholar)
    .where(where)
    .orderBy(asc(plnScholar.year), asc(plnScholar.entity), asc(plnScholar.title))
    .limit(limit)
    .offset(offset);

  return c.json({ total: Number(total), page, pages: Math.ceil(Number(total) / limit), rows });
});
