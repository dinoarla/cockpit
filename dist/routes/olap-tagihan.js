import { Hono } from "hono";
import { eq, sql, asc } from "drizzle-orm";
import { db } from "../db/client.js";
import { olapAmrTagihan } from "../db/schema.js";
import { requireAuth } from "../middleware/auth.js";
export const olapTagihanRoutes = new Hono();
olapTagihanRoutes.use("*", requireAuth);
// GET /api/olap-tagihan/summary — agregat per periode (untuk trend chart)
olapTagihanRoutes.get("/summary", async (c) => {
    const rows = await db
        .select({
        thblrek: olapAmrTagihan.thblrek,
        jmlPelanggan: sql `SUM(jml_pelanggan)`,
        kwhTotal: sql `SUM(kwh_total)`,
        rpTotal: sql `SUM(rp_total)`,
        rpPtl: sql `SUM(rp_ptl)`,
        rpPpj: sql `SUM(rp_ppj)`,
    })
        .from(olapAmrTagihan)
        .groupBy(olapAmrTagihan.thblrek)
        .orderBy(asc(olapAmrTagihan.thblrek));
    return c.json(rows);
});
// GET /api/olap-tagihan/by-unitap — agregat per UP3 per periode (semua periode)
olapTagihanRoutes.get("/by-unitap", async (c) => {
    const rows = await db
        .select({
        thblrek: olapAmrTagihan.thblrek,
        unitap: olapAmrTagihan.unitap,
        unitapNama: olapAmrTagihan.unitapNama,
        jmlPelanggan: sql `SUM(jml_pelanggan)`,
        kwhTotal: sql `SUM(kwh_total)`,
        rpTotal: sql `SUM(rp_total)`,
    })
        .from(olapAmrTagihan)
        .groupBy(olapAmrTagihan.thblrek, olapAmrTagihan.unitap, olapAmrTagihan.unitapNama)
        .orderBy(asc(olapAmrTagihan.thblrek), asc(olapAmrTagihan.unitap));
    return c.json(rows);
});
// GET /api/olap-tagihan/by-tarif — agregat per grup tarif per periode (semua periode)
olapTagihanRoutes.get("/by-tarif", async (c) => {
    const rows = await db
        .select({
        thblrek: olapAmrTagihan.thblrek,
        tarifGrup: olapAmrTagihan.tarifGrup,
        jmlPelanggan: sql `SUM(jml_pelanggan)`,
        kwhTotal: sql `SUM(kwh_total)`,
        rpTotal: sql `SUM(rp_total)`,
    })
        .from(olapAmrTagihan)
        .groupBy(olapAmrTagihan.thblrek, olapAmrTagihan.tarifGrup)
        .orderBy(asc(olapAmrTagihan.thblrek), asc(olapAmrTagihan.tarifGrup));
    return c.json(rows);
});
// GET /api/olap-tagihan/detail?period=&unitap= — detail per ULP dan tarif
olapTagihanRoutes.get("/detail", async (c) => {
    const period = c.req.query("period");
    const unitap = c.req.query("unitap");
    if (!period)
        return c.json({ error: "period required" }, 400);
    if (unitap) {
        const rows = await db
            .select()
            .from(olapAmrTagihan)
            .where(sql `${olapAmrTagihan.thblrek} = ${period} AND ${olapAmrTagihan.unitap} = ${unitap}`)
            .orderBy(asc(olapAmrTagihan.unitup), asc(olapAmrTagihan.tarif));
        return c.json(rows);
    }
    const rows = await db
        .select()
        .from(olapAmrTagihan)
        .where(eq(olapAmrTagihan.thblrek, period))
        .orderBy(asc(olapAmrTagihan.unitap), asc(olapAmrTagihan.unitup), asc(olapAmrTagihan.tarif));
    return c.json(rows);
});
//# sourceMappingURL=olap-tagihan.js.map