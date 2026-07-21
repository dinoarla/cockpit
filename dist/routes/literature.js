import { Hono } from "hono";
import { eq, desc } from "drizzle-orm";
import { db } from "../db/client.js";
import { literatureItems, literatureConfig } from "../db/schema.js";
import { requireAuth } from "../middleware/auth.js";
export const literatureRoutes = new Hono();
literatureRoutes.use("*", requireAuth);
/* ── helpers ── */
const parse = (s) => { try {
    return JSON.parse(s || "[]");
}
catch {
    return [];
} };
/* ── GET all ── */
literatureRoutes.get("/items", async (c) => {
    const rows = await db.select().from(literatureItems).orderBy(desc(literatureItems.updatedAt));
    return c.json(rows.map(r => ({ ...r, themes: parse(r.themes), citedIn: parse(r.citedIn) })));
});
/* ── POST add one ── */
literatureRoutes.post("/", async (c) => {
    const b = await c.req.json();
    await db.insert(literatureItems).values({
        title: b.title,
        authors: b.authors || "",
        year: b.year || null,
        journal: b.journal || "",
        doi: b.doi || "",
        themes: JSON.stringify(b.themes || []),
        status: b.status || "belum",
        relevance: b.relevance ?? 3,
        citedIn: JSON.stringify(b.citedIn || []),
        notes: b.notes || null,
    });
    return c.json({ ok: true });
});
/* ── PATCH update ── */
literatureRoutes.patch("/:id", async (c) => {
    const id = Number(c.req.param("id"));
    const b = await c.req.json();
    const upd = { updatedAt: new Date() };
    if (b.title !== undefined)
        upd.title = b.title;
    if (b.authors !== undefined)
        upd.authors = b.authors;
    if (b.year !== undefined)
        upd.year = b.year;
    if (b.journal !== undefined)
        upd.journal = b.journal;
    if (b.doi !== undefined)
        upd.doi = b.doi;
    if (b.themes !== undefined)
        upd.themes = JSON.stringify(b.themes);
    if (b.status !== undefined)
        upd.status = b.status;
    if (b.relevance !== undefined)
        upd.relevance = b.relevance;
    if (b.citedIn !== undefined)
        upd.citedIn = JSON.stringify(b.citedIn);
    if (b.notes !== undefined)
        upd.notes = b.notes;
    await db.update(literatureItems).set(upd).where(eq(literatureItems.id, id));
    return c.json({ ok: true });
});
/* ── DELETE ── */
literatureRoutes.delete("/:id", async (c) => {
    await db.delete(literatureItems).where(eq(literatureItems.id, Number(c.req.param("id"))));
    return c.json({ ok: true });
});
literatureRoutes.post("/:id/delete", async (c) => {
    await db.delete(literatureItems).where(eq(literatureItems.id, Number(c.req.param("id"))));
    return c.json({ ok: true });
});
/* ── Zotero config ── */
literatureRoutes.get("/zotero-config", async (c) => {
    const [uRow] = await db.select().from(literatureConfig).where(eq(literatureConfig.key, "zotero_user_id"));
    const [kRow] = await db.select().from(literatureConfig).where(eq(literatureConfig.key, "zotero_api_key"));
    const configured = !!(uRow?.value && kRow?.value);
    return c.json({
        configured,
        userId: uRow?.value || "",
        apiKeyMasked: kRow?.value ? kRow.value.slice(0, 4) + "••••••••" + kRow.value.slice(-4) : "",
    });
});
literatureRoutes.post("/zotero-config", async (c) => {
    const { userId, apiKey } = await c.req.json();
    await db.insert(literatureConfig).values({ key: "zotero_user_id", value: userId })
        .onDuplicateKeyUpdate({ set: { value: userId } });
    await db.insert(literatureConfig).values({ key: "zotero_api_key", value: apiKey })
        .onDuplicateKeyUpdate({ set: { value: apiKey } });
    return c.json({ ok: true });
});
/* ── Sync from Zotero ── */
literatureRoutes.post("/sync-zotero", async (c) => {
    const [uRow] = await db.select().from(literatureConfig).where(eq(literatureConfig.key, "zotero_user_id"));
    const [kRow] = await db.select().from(literatureConfig).where(eq(literatureConfig.key, "zotero_api_key"));
    if (!uRow?.value || !kRow?.value)
        return c.json({ error: "Zotero belum dikonfigurasi" }, 400);
    const ACADEMIC_TYPES = new Set([
        "journalArticle", "conferencePaper", "book", "bookSection",
        "thesis", "report", "preprint", "manuscript", "encyclopediaArticle", "dictionaryEntry",
    ]);
    let synced = 0;
    let start = 0;
    const limit = 100;
    while (true) {
        const url = `https://api.zotero.org/users/${uRow.value}/items?format=json&limit=${limit}&start=${start}&v=3`;
        const res = await fetch(url, { headers: { "Zotero-API-Key": kRow.value } });
        if (!res.ok)
            return c.json({ error: `Zotero API error: ${res.status}` }, 502);
        const items = (await res.json());
        if (items.length === 0)
            break;
        for (const item of items) {
            const d = item.data;
            if (!d?.title || d.title.length < 5)
                continue;
            if (!ACADEMIC_TYPES.has(d.itemType))
                continue;
            const authors = (d.creators || [])
                .map((cr) => cr.lastName || cr.name || "").filter(Boolean).join(", ");
            const year = d.date ? parseInt(d.date) : null;
            await db.insert(literatureItems).values({
                zoteroKey: d.key,
                title: d.title,
                authors,
                year: isNaN(year) ? null : year,
                journal: d.publicationTitle || d.proceedingsTitle || d.bookTitle || "",
                doi: d.DOI || "",
                themes: "[]", status: "belum", relevance: 3, citedIn: "[]",
            }).onDuplicateKeyUpdate({
                set: { title: d.title, authors, year: isNaN(year) ? null : year,
                    journal: d.publicationTitle || d.proceedingsTitle || d.bookTitle || "" },
            });
            synced++;
        }
        if (items.length < limit)
            break;
        start += limit;
    }
    return c.json({ ok: true, synced });
});
/* ── Import from .bib (parsed client-side) ── */
literatureRoutes.post("/import-bib", async (c) => {
    const { items } = await c.req.json();
    let imported = 0;
    for (const item of (items || [])) {
        if (!item.title)
            continue;
        await db.insert(literatureItems).values({
            title: item.title,
            authors: item.authors || "",
            year: item.year || null,
            journal: item.journal || "",
            doi: item.doi || "",
            themes: "[]", status: "belum", relevance: 3, citedIn: "[]",
        });
        imported++;
    }
    return c.json({ ok: true, imported });
});
//# sourceMappingURL=literature.js.map