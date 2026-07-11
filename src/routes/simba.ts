import { Hono } from "hono";
import { sql } from "drizzle-orm";
import { db } from "../db/client.js";
import { requireAuth } from "../middleware/auth.js";

export const simbaRoutes = new Hono();
simbaRoutes.use("*", requireAuth);

const rows = (r: any) => (Array.isArray(r) && Array.isArray(r[0]) ? r[0] : r);

// Trusted internal config — table names never come from user input
const PLANTS: Record<string, { table: string; label: string; type: "pltd" | "pltg"; fuels: string[] }> = {
  sera:  { table: "simba_mon_sera",  label: "PLTD Sei Raya",       type: "pltd", fuels: ["HSD", "MFO"] },
  stn:   { table: "simba_mon_stn",   label: "PLTD Siantan",        type: "pltd", fuels: ["HSD", "MFO"] },
  wie:   { table: "simba_mon_wie",   label: "PLTD Sei Wie",        type: "pltd", fuels: ["HSD", "MFO"] },
  pw:    { table: "simba_mon_pw",    label: "PLTD Prastiwahyu",    type: "pltd", fuels: ["HSD", "MFO"] },
  sdr:   { table: "simba_mon_sdr",   label: "PLTD Sudirman",       type: "pltd", fuels: ["HSD"] },
  bugak: { table: "simba_mon_bugak", label: "PLTD Bugak Berawang", type: "pltd", fuels: ["HSD", "MFO"] },
  pltg:  { table: "simba_mon_pltg",  label: "PLTG Siantan",        type: "pltg", fuels: ["HSD"] },
  mpp:   { table: "simba_mon_mpp",   label: "PLTG MPP",            type: "pltg", fuels: ["HSD"] },
};

// GET /api/simba/plants
simbaRoutes.get("/plants", (c) => {
  const list = Object.entries(PLANTS).map(([id, p]) => ({
    id, label: p.label, type: p.type, fuels: p.fuels,
  }));
  return c.json(list);
});

// GET /api/simba/monitoring/:plant?bbm=HSD
simbaRoutes.get("/monitoring/:plant", async (c) => {
  const plantId = c.req.param("plant");
  const plant = PLANTS[plantId];
  if (!plant) return c.json({ error: "plant not found" }, 404);

  const bbm = (c.req.query("bbm") ?? "HSD").toUpperCase() === "MFO" ? "MFO" : "HSD";
  const tbl = sql.raw("`" + plant.table + "`");

  try {
    let r: any;
    if (plant.type === "pltg") {
      r = await db.execute(sql`
        SELECT tgl, 'HSD' AS bbm, terima,
               pakai_pltg AS pakai, stock_pltg AS stock,
               kwh_prod, pakai_rata, CAST(sfc AS DECIMAL(6,3)) AS sfc
        FROM ${tbl} ORDER BY tgl ASC
      `);
    } else {
      r = await db.execute(sql`
        SELECT tgl, bbm, terima,
               pakai_pltd AS pakai, stock_pltd AS stock,
               kwh_prod, pakai_rata, CAST(sfc AS DECIMAL(6,3)) AS sfc
        FROM ${tbl}
        WHERE bbm = ${bbm}
        ORDER BY tgl ASC
      `);
    }
    return c.json(rows(r));
  } catch {
    return c.json({ error: "data_not_imported", rows: [] }, 503);
  }
});

// GET /api/simba/tanks
simbaRoutes.get("/tanks", async (c) => {
  try {
    const r = await db.execute(sql`
      SELECT tangki_id, kode, kode2, uraian,
             total_qty, efektif_qty, stock_mati,
             kalibrasi_awal, kalibrasi_akhir, metode, keterangan
      FROM simba_info_tangki ORDER BY kode, tangki_id ASC
    `);
    return c.json(rows(r));
  } catch {
    return c.json({ error: "data_not_imported", rows: [] }, 503);
  }
});

// GET /api/simba/rekap?type=pemakaian|penerimaan
simbaRoutes.get("/rekap", async (c) => {
  const type = c.req.query("type") ?? "pemakaian";
  const tblName = type === "penerimaan" ? "simba_rekap_penerimaan" : "simba_rekap_pemakaian";
  const tbl = sql.raw("`" + tblName + "`");
  try {
    const r = await db.execute(sql`
      SELECT tgl, SUM(hsd) AS hsd, SUM(mfo) AS mfo
      FROM ${tbl}
      GROUP BY tgl ORDER BY tgl ASC
    `);
    return c.json(rows(r));
  } catch {
    return c.json({ error: "data_not_imported", rows: [] }, 503);
  }
});

// GET /api/simba/sfc-summary — avg SFC per plant/fuel
simbaRoutes.get("/sfc-summary", async (c) => {
  const results: { plant: string; label: string; fuel: string; avg_sfc: number; days: number }[] = [];
  for (const [id, p] of Object.entries(PLANTS)) {
    const tbl = sql.raw("`" + p.table + "`");
    for (const fuel of p.fuels) {
      try {
        let r: any;
        if (p.type === "pltg") {
          r = await db.execute(sql`
            SELECT AVG(CAST(sfc AS DECIMAL(6,3))) AS avg_sfc, COUNT(*) AS cnt
            FROM ${tbl}
            WHERE sfc IS NOT NULL AND sfc NOT IN ('', '0', '0.000')
          `);
        } else {
          r = await db.execute(sql`
            SELECT AVG(CAST(sfc AS DECIMAL(6,3))) AS avg_sfc, COUNT(*) AS cnt
            FROM ${tbl}
            WHERE bbm = ${fuel} AND sfc IS NOT NULL AND sfc NOT IN ('', '0', '0.000')
          `);
        }
        const row = rows(r)[0];
        if (row?.avg_sfc != null) {
          results.push({
            plant: id, label: p.label, fuel,
            avg_sfc: Math.round(Number(row.avg_sfc) * 1000) / 1000,
            days: Number(row.cnt),
          });
        }
      } catch { /* table not yet imported — skip */ }
    }
  }
  return c.json(results);
});

// GET /api/simba/monthly-rekap?type=pemakaian|penerimaan
simbaRoutes.get("/monthly-rekap", async (c) => {
  const type = c.req.query("type") ?? "pemakaian";
  const tblName = type === "penerimaan" ? "simba_rekap_penerimaan" : "simba_rekap_pemakaian";
  const tbl = sql.raw("`" + tblName + "`");
  try {
    const r = await db.execute(sql`
      SELECT DATE_FORMAT(tgl, '%Y-%m') AS bulan,
             SUM(hsd) AS hsd, SUM(mfo) AS mfo
      FROM ${tbl}
      GROUP BY bulan ORDER BY bulan ASC
    `);
    return c.json(rows(r));
  } catch {
    return c.json({ error: "data_not_imported", rows: [] }, 503);
  }
});
