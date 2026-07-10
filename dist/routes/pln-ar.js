import { Hono } from "hono";
import { sql } from "drizzle-orm";
import { db } from "../db/client.js";
import { requireAuth } from "../middleware/auth.js";
export const plnArRoutes = new Hono();
plnArRoutes.use("*", requireAuth);
const rows = (r) => (Array.isArray(r) && Array.isArray(r[0]) ? r[0] : r);
plnArRoutes.get("/financial", async (c) => {
    const r = await db.execute(sql `SELECT * FROM pln_ar_financial ORDER BY year ASC`);
    return c.json(rows(r));
});
plnArRoutes.get("/ratios", async (c) => {
    const r = await db.execute(sql `SELECT * FROM pln_ar_ratios ORDER BY year ASC`);
    return c.json(rows(r));
});
plnArRoutes.get("/operational", async (c) => {
    const r = await db.execute(sql `SELECT * FROM pln_ar_operational ORDER BY year ASC`);
    return c.json(rows(r));
});
plnArRoutes.get("/opex-detail", async (c) => {
    const r = await db.execute(sql `SELECT * FROM pln_ar_opex_detail ORDER BY year ASC, category ASC`);
    return c.json(rows(r));
});
plnArRoutes.get("/capex", async (c) => {
    const r = await db.execute(sql `SELECT * FROM pln_ar_capex ORDER BY year ASC, amount DESC`);
    return c.json(rows(r));
});
plnArRoutes.get("/demand-forecast", async (c) => {
    const r = await db.execute(sql `SELECT * FROM pln_ar_demand_forecast ORDER BY year ASC`);
    return c.json(rows(r));
});
plnArRoutes.get("/kpi", async (c) => {
    const r = await db.execute(sql `SELECT * FROM pln_ar_kpi ORDER BY kpi_no ASC`);
    return c.json(rows(r));
});
//# sourceMappingURL=pln-ar.js.map