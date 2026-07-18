import { Hono } from "hono";
import { sql } from "drizzle-orm";
import { db } from "../db/client.js";
import { requireAuth } from "../middleware/auth.js";

export const gantiMeterRoutes = new Hono();
gantiMeterRoutes.use("*", requireAuth);

const rows = (r: any) => (Array.isArray(r) && Array.isArray(r[0]) ? r[0] : r);

// GET /api/ganti-meter/summary — total per bulan (agregat semua unitap)
gantiMeterRoutes.get("/summary", async (c) => {
  try {
    const r = await db.execute(sql`
      SELECT
        DATE_FORMAT(tgl, '%Y%m') AS bulan,
        SUM(jumlah)              AS jumlah,
        SUM(jumlah_prabayar)     AS jumlah_prabayar,
        SUM(jumlah_pascabayar)   AS jumlah_pascabayar
      FROM ganti_meter_harian
      GROUP BY bulan
      ORDER BY bulan ASC
    `);
    return c.json(rows(r));
  } catch {
    return c.json({ error: "data_not_imported" }, 503);
  }
});

// GET /api/ganti-meter/by-unitap — per unitap per bulan
gantiMeterRoutes.get("/by-unitap", async (c) => {
  try {
    const r = await db.execute(sql`
      SELECT
        DATE_FORMAT(tgl, '%Y%m') AS bulan,
        unitap,
        SUM(jumlah)              AS jumlah,
        SUM(jumlah_prabayar)     AS jumlah_prabayar,
        SUM(jumlah_pascabayar)   AS jumlah_pascabayar
      FROM ganti_meter_harian
      GROUP BY bulan, unitap
      ORDER BY bulan ASC, unitap ASC
    `);
    return c.json(rows(r));
  } catch {
    return c.json({ error: "data_not_imported" }, 503);
  }
});

// GET /api/ganti-meter/alasan?bulan= — alasan breakdown
gantiMeterRoutes.get("/alasan", async (c) => {
  const bulan = c.req.query("bulan");
  try {
    const r = bulan
      ? await db.execute(sql`
          SELECT alasan_grup, alasan, SUM(jumlah) AS jumlah
          FROM ganti_meter_alasan
          WHERE bulan = ${bulan}
          GROUP BY alasan_grup, alasan
          ORDER BY alasan_grup ASC, jumlah DESC
        `)
      : await db.execute(sql`
          SELECT alasan_grup, alasan, SUM(jumlah) AS jumlah
          FROM ganti_meter_alasan
          GROUP BY alasan_grup, alasan
          ORDER BY alasan_grup ASC, jumlah DESC
        `);
    return c.json(rows(r));
  } catch {
    return c.json({ error: "data_not_imported" }, 503);
  }
});

// GET /api/ganti-meter/merk?bulan= — top merk combinations
gantiMeterRoutes.get("/merk", async (c) => {
  const bulan = c.req.query("bulan");
  try {
    const r = bulan
      ? await db.execute(sql`
          SELECT merk_lama, merk_baru, SUM(jumlah) AS jumlah
          FROM ganti_meter_merk
          WHERE bulan = ${bulan}
          GROUP BY merk_lama, merk_baru
          ORDER BY jumlah DESC
          LIMIT 30
        `)
      : await db.execute(sql`
          SELECT merk_lama, merk_baru, SUM(jumlah) AS jumlah
          FROM ganti_meter_merk
          GROUP BY merk_lama, merk_baru
          ORDER BY jumlah DESC
          LIMIT 30
        `);
    return c.json(rows(r));
  } catch {
    return c.json({ error: "data_not_imported" }, 503);
  }
});

// GET /api/ganti-meter/umur?bulan= — umur meter lama distribution grouped by decade
gantiMeterRoutes.get("/umur", async (c) => {
  const bulan = c.req.query("bulan");
  try {
    const r = bulan
      ? await db.execute(sql`
          SELECT
            CONCAT(FLOOR(CAST(thbuat_lama AS UNSIGNED) / 10) * 10, 'an') AS dekade,
            SUM(jumlah) AS jumlah
          FROM ganti_meter_umur
          WHERE bulan = ${bulan}
            AND thbuat_lama REGEXP '^[0-9]{4}$'
          GROUP BY dekade
          ORDER BY dekade ASC
        `)
      : await db.execute(sql`
          SELECT
            CONCAT(FLOOR(CAST(thbuat_lama AS UNSIGNED) / 10) * 10, 'an') AS dekade,
            SUM(jumlah) AS jumlah
          FROM ganti_meter_umur
          WHERE thbuat_lama REGEXP '^[0-9]{4}$'
          GROUP BY dekade
          ORDER BY dekade ASC
        `);
    return c.json(rows(r));
  } catch {
    return c.json({ error: "data_not_imported" }, 503);
  }
});

// GET /api/ganti-meter/bulan-list — list bulan tersedia
gantiMeterRoutes.get("/bulan-list", async (c) => {
  try {
    const r = await db.execute(sql`
      SELECT DISTINCT DATE_FORMAT(tgl, '%Y%m') AS bulan
      FROM ganti_meter_harian
      ORDER BY bulan ASC
    `);
    return c.json(rows(r).map((x: any) => x.bulan));
  } catch {
    return c.json({ error: "data_not_imported" }, 503);
  }
});
