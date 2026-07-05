import { Hono } from "hono";
import { eq, desc } from "drizzle-orm";
import { db } from "../db/client.js";
import { tariffPeriods, tariffRates } from "../db/schema.js";
import { requireAuth } from "../middleware/auth.js";

export const tariffRoutes = new Hono();
tariffRoutes.use("*", requireAuth);

// GET /api/tariff/current — periode aktif + semua golongan tarif
tariffRoutes.get("/current", async (c) => {
  const [period] = await db
    .select()
    .from(tariffPeriods)
    .where(eq(tariffPeriods.isCurrent, true))
    .limit(1);

  if (!period) return c.json({ error: "Belum ada data tarif aktif." }, 404);

  const rates = await db
    .select()
    .from(tariffRates)
    .where(eq(tariffRates.periodId, period.id))
    .orderBy(tariffRates.no);

  return c.json({ period, rates });
});

// GET /api/tariff/periods — daftar semua periode (untuk dropdown historis)
tariffRoutes.get("/periods", async (c) => {
  const periods = await db
    .select()
    .from(tariffPeriods)
    .orderBy(desc(tariffPeriods.effectiveDate));
  return c.json(periods);
});

// GET /api/tariff/period/:id — tarif untuk periode tertentu
tariffRoutes.get("/period/:id", async (c) => {
  const id = Number(c.req.param("id"));
  const [period] = await db
    .select()
    .from(tariffPeriods)
    .where(eq(tariffPeriods.id, id))
    .limit(1);

  if (!period) return c.json({ error: "Periode tidak ditemukan." }, 404);

  const rates = await db
    .select()
    .from(tariffRates)
    .where(eq(tariffRates.periodId, id))
    .orderBy(tariffRates.no);

  return c.json({ period, rates });
});
