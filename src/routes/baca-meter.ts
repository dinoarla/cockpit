import { Hono } from "hono";
import { sql } from "drizzle-orm";
import { db } from "../db/client.js";
import { requireAuth } from "../middleware/auth.js";

export const bacaMeterRoutes = new Hono();
bacaMeterRoutes.use("*", requireAuth);

const rows = (r: any) => (Array.isArray(r) && Array.isArray(r[0]) ? r[0] : r);

// GET /api/baca-meter/summary — total Jabar per bulan
bacaMeterRoutes.get("/summary", async (c) => {
  try {
    const r = await db.execute(sql`
      SELECT bulan,
             SUM(total_pelanggan) AS total_pelanggan,
             SUM(total_kwh)       AS total_kwh,
             ROUND(SUM(total_kwh) / NULLIF(SUM(total_pelanggan),0), 2) AS avg_kwh,
             ROUND(AVG(pct_normal), 2) AS pct_normal,
             SUM(baca_ulang)      AS baca_ulang,
             SUM(inisialisasi)    AS inisialisasi,
             ROUND(AVG(avg_jam), 2) AS avg_jam
      FROM baca_meter_summary
      GROUP BY bulan
      ORDER BY bulan ASC
    `);
    return c.json(rows(r));
  } catch {
    return c.json({ error: "data_not_imported" }, 503);
  }
});

// GET /api/baca-meter/by-up3 — per UP3 per bulan (semua bulan)
bacaMeterRoutes.get("/by-up3", async (c) => {
  try {
    const r = await db.execute(sql`
      SELECT bulan, up3_kode, up3_nama,
             total_pelanggan, total_kwh, avg_kwh, pct_normal,
             baca_ulang, inisialisasi, avg_jam
      FROM baca_meter_summary
      ORDER BY bulan ASC, total_kwh DESC
    `);
    return c.json(rows(r));
  } catch {
    return c.json({ error: "data_not_imported" }, 503);
  }
});

// GET /api/baca-meter/tarif?bulan=XXXXXX — tarif breakdown per UP3 untuk 1 bulan
bacaMeterRoutes.get("/tarif", async (c) => {
  const bulan = c.req.query("bulan");
  if (!bulan) return c.json({ error: "bulan required" }, 400);
  try {
    const r = await db.execute(sql`
      SELECT up3_kode, tarif,
             SUM(pelanggan) AS pelanggan,
             SUM(total_kwh) AS total_kwh
      FROM baca_meter_tarif
      WHERE bulan = ${bulan}
      GROUP BY up3_kode, tarif
      ORDER BY up3_kode ASC, pelanggan DESC
    `);
    return c.json(rows(r));
  } catch {
    return c.json({ error: "data_not_imported" }, 503);
  }
});

// GET /api/baca-meter/tarif-jabar?bulan= — agregat tarif seluruh Jabar
bacaMeterRoutes.get("/tarif-jabar", async (c) => {
  const bulan = c.req.query("bulan");
  if (!bulan) return c.json({ error: "bulan required" }, 400);
  try {
    const r = await db.execute(sql`
      SELECT tarif,
             SUM(pelanggan) AS pelanggan,
             SUM(total_kwh) AS total_kwh
      FROM baca_meter_tarif
      WHERE bulan = ${bulan}
      GROUP BY tarif
      ORDER BY pelanggan DESC
    `);
    return c.json(rows(r));
  } catch {
    return c.json({ error: "data_not_imported" }, 503);
  }
});

// GET /api/baca-meter/kode-pesan?bulan=&up3= — status breakdown
bacaMeterRoutes.get("/kode-pesan", async (c) => {
  const bulan = c.req.query("bulan");
  const up3   = c.req.query("up3");
  if (!bulan) return c.json({ error: "bulan required" }, 400);
  try {
    const r = up3
      ? await db.execute(sql`
          SELECT kode_pesan, jumlah
          FROM baca_meter_kode_pesan
          WHERE bulan = ${bulan} AND up3_kode = ${up3}
          ORDER BY jumlah DESC
        `)
      : await db.execute(sql`
          SELECT kode_pesan, SUM(jumlah) AS jumlah
          FROM baca_meter_kode_pesan
          WHERE bulan = ${bulan}
          GROUP BY kode_pesan
          ORDER BY jumlah DESC
        `);
    return c.json(rows(r));
  } catch {
    return c.json({ error: "data_not_imported" }, 503);
  }
});

// GET /api/baca-meter/daya?bulan= — daya group breakdown Jabar
bacaMeterRoutes.get("/daya", async (c) => {
  const bulan = c.req.query("bulan");
  if (!bulan) return c.json({ error: "bulan required" }, 400);
  try {
    const r = await db.execute(sql`
      SELECT daya_group,
             SUM(pelanggan) AS pelanggan,
             SUM(total_kwh) AS total_kwh
      FROM baca_meter_daya
      WHERE bulan = ${bulan}
      GROUP BY daya_group
      ORDER BY daya_group ASC
    `);
    return c.json(rows(r));
  } catch {
    return c.json({ error: "data_not_imported" }, 503);
  }
});

// GET /api/baca-meter/jam?bulan=&up3= — distribusi jam pembacaan (0-23)
bacaMeterRoutes.get("/jam", async (c) => {
  const bulan = c.req.query("bulan");
  const up3   = c.req.query("up3");
  if (!bulan) return c.json({ error: "bulan required" }, 400);
  try {
    const r = up3
      ? await db.execute(sql`
          SELECT jam, jumlah
          FROM baca_meter_jam
          WHERE bulan = ${bulan} AND up3_kode = ${up3}
          ORDER BY jam ASC
        `)
      : await db.execute(sql`
          SELECT jam, SUM(jumlah) AS jumlah
          FROM baca_meter_jam
          WHERE bulan = ${bulan}
          GROUP BY jam
          ORDER BY jam ASC
        `);
    return c.json(rows(r));
  } catch {
    return c.json({ error: "data_not_imported" }, 503);
  }
});

// GET /api/baca-meter/bulan-list — bulan yang tersedia
bacaMeterRoutes.get("/bulan-list", async (c) => {
  try {
    const r = await db.execute(sql`
      SELECT DISTINCT bulan FROM baca_meter_summary ORDER BY bulan ASC
    `);
    return c.json(rows(r).map((x: any) => x.bulan));
  } catch {
    return c.json({ error: "data_not_imported" }, 503);
  }
});
