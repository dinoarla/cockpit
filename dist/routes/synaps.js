import { Hono } from "hono";
import { eq, sql } from "drizzle-orm";
import { db } from "../db/client.js";
import { synapsConceptsTable, synapsEdgesTable, literatureItems, myWorks, domainModules, domains, } from "../db/schema.js";
import { requireAuth } from "../middleware/auth.js";
export const synapsRoutes = new Hono();
/* ── Auto-migrate ── */
async function ensureTables() {
    await db.execute(sql `
    CREATE TABLE IF NOT EXISTS \`synaps_concepts\` (
      \`id\`          INT AUTO_INCREMENT PRIMARY KEY,
      \`slug\`        VARCHAR(100) NOT NULL UNIQUE,
      \`name\`        VARCHAR(200) NOT NULL,
      \`description\` TEXT,
      \`color\`       VARCHAR(7) DEFAULT '#8B5CF6',
      \`created_at\`  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
  `);
    await db.execute(sql `
    CREATE TABLE IF NOT EXISTS \`synaps_edges\` (
      \`id\`           INT AUTO_INCREMENT PRIMARY KEY,
      \`from_type\`    VARCHAR(20) NOT NULL,
      \`from_id\`      VARCHAR(100) NOT NULL,
      \`to_type\`      VARCHAR(20) NOT NULL,
      \`to_id\`        VARCHAR(100) NOT NULL,
      \`relationship\` VARCHAR(50) DEFAULT 'related',
      \`note\`         TEXT,
      \`created_at\`   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      UNIQUE KEY \`synaps_edge_uniq\` (\`from_type\`, \`from_id\`, \`to_type\`, \`to_id\`)
    )
  `);
}
ensureTables().catch(console.error);
synapsRoutes.use("/*", requireAuth);
/* ── GET /synaps/graph — full graph payload ── */
synapsRoutes.get("/graph", async (c) => {
    // 1. Module nodes from DB
    const allMods = await db
        .select({ slug: domainModules.slug, nama: domainModules.nama,
        status: domainModules.status, domainId: domainModules.domainId })
        .from(domainModules);
    const allDomains = await db.select({ id: domains.id, slug: domains.slug }).from(domains);
    const domainMap = Object.fromEntries(allDomains.map(d => [d.id, d.slug]));
    const moduleNodes = allMods.map(m => ({
        id: m.slug,
        type: "module",
        name: m.nama,
        status: m.status,
        domain: domainMap[m.domainId] || "unknown",
    }));
    // 2. Literature nodes
    const lits = await db.select({ id: literatureItems.id, title: literatureItems.title,
        authors: literatureItems.authors, year: literatureItems.year,
        status: literatureItems.status, relevance: literatureItems.relevance })
        .from(literatureItems);
    const litNodes = lits.map(l => ({
        id: "lit-" + l.id,
        type: "literature",
        name: l.title,
        authors: l.authors || "",
        year: l.year,
        status: l.status,
        relevance: l.relevance,
    }));
    // 3. Work nodes
    const works = await db.select({ slug: myWorks.slug, title: myWorks.title,
        type: myWorks.type, status: myWorks.status, year: myWorks.year })
        .from(myWorks);
    const workNodes = works.map(w => ({
        id: "work-" + w.slug,
        type: "work",
        name: w.title,
        wtype: w.type,
        status: w.status,
        year: w.year,
    }));
    // 4. Concept nodes
    const concepts = await db.select().from(synapsConceptsTable);
    const conceptNodes = concepts.map(c => ({
        id: "concept-" + c.slug,
        type: "concept",
        name: c.name,
        description: c.description,
        color: c.color,
    }));
    // 5. Edges from synaps_edges
    const edges = await db.select().from(synapsEdgesTable);
    // Normalize edge source/target to node IDs used in graph
    const normalizedEdges = edges.map(e => ({
        edgeId: e.id,
        source: e.fromType === "module" ? e.fromId :
            e.fromType === "literature" ? "lit-" + e.fromId :
                e.fromType === "work" ? "work-" + e.fromId :
                    "concept-" + e.fromId,
        target: e.toType === "module" ? e.toId :
            e.toType === "literature" ? "lit-" + e.toId :
                e.toType === "work" ? "work-" + e.toId :
                    "concept-" + e.toId,
        relationship: e.relationship,
        note: e.note,
        cross: true,
    }));
    return c.json({
        nodes: [...moduleNodes, ...litNodes, ...workNodes, ...conceptNodes],
        edges: normalizedEdges,
    });
});
/* ── GET /synaps/concepts ── */
synapsRoutes.get("/concepts", async (c) => {
    const rows = await db.select().from(synapsConceptsTable);
    return c.json(rows);
});
/* ── POST /synaps/concepts ── */
synapsRoutes.post("/concepts", async (c) => {
    const b = await c.req.json();
    const slug = b.name.toLowerCase()
        .replace(/[^a-z0-9\s-]/g, "").replace(/\s+/g, "-").replace(/-+/g, "-").slice(0, 80);
    await db.insert(synapsConceptsTable).values({
        slug, name: b.name, description: b.description || null, color: b.color || "#8B5CF6",
    });
    return c.json({ ok: true, slug });
});
/* ── POST /synaps/concepts/:slug/delete ── */
synapsRoutes.post("/concepts/:slug/delete", async (c) => {
    const slug = c.req.param("slug");
    await db.delete(synapsConceptsTable).where(eq(synapsConceptsTable.slug, slug));
    await db.delete(synapsEdgesTable).where(eq(synapsEdgesTable.fromId, slug));
    await db.delete(synapsEdgesTable).where(eq(synapsEdgesTable.toId, slug));
    return c.json({ ok: true });
});
/* ── POST /synaps/edges ── */
synapsRoutes.post("/edges", async (c) => {
    const b = await c.req.json();
    try {
        await db.insert(synapsEdgesTable).values({
            fromType: b.fromType, fromId: b.fromId,
            toType: b.toType, toId: b.toId,
            relationship: b.relationship || "related",
            note: b.note || null,
        });
        return c.json({ ok: true });
    }
    catch (e) {
        if (e?.message?.includes("Duplicate"))
            return c.json({ error: "Koneksi sudah ada" }, 409);
        throw e;
    }
});
/* ── POST /synaps/edges/:id/delete ── */
synapsRoutes.post("/edges/:id/delete", async (c) => {
    const id = parseInt(c.req.param("id"));
    await db.delete(synapsEdgesTable).where(eq(synapsEdgesTable.id, id));
    return c.json({ ok: true });
});
//# sourceMappingURL=synaps.js.map