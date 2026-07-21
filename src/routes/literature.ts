import { Hono } from "hono";
import { eq, desc, sql } from "drizzle-orm";
import { db } from "../db/client.js";
import { literatureItems, literatureConfig, myWorks, literatureCitations } from "../db/schema.js";
import { requireAuth } from "../middleware/auth.js";

/* ── Auto-migrate: buat tabel jika belum ada ── */
async function ensureTables() {
  await db.execute(sql`
    CREATE TABLE IF NOT EXISTS \`my_works\` (
      \`id\`         INT AUTO_INCREMENT PRIMARY KEY,
      \`slug\`       VARCHAR(100) NOT NULL,
      \`title\`      TEXT NOT NULL,
      \`type\`       VARCHAR(20) NOT NULL DEFAULT 'dissertation',
      \`year\`       INT DEFAULT NULL,
      \`structure\`  TEXT DEFAULT '[]',
      \`created_at\` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      UNIQUE KEY \`my_works_slug_idx\` (\`slug\`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  `);
  await db.execute(sql`
    CREATE TABLE IF NOT EXISTS \`literature_citations\` (
      \`id\`         INT AUTO_INCREMENT PRIMARY KEY,
      \`lit_id\`     INT NOT NULL,
      \`work_slug\`  VARCHAR(100) NOT NULL,
      \`section\`    VARCHAR(100) NOT NULL DEFAULT '',
      \`created_at\` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      UNIQUE KEY \`lit_work_section_idx\` (\`lit_id\`, \`work_slug\`, \`section\`),
      KEY \`lit_id_idx\` (\`lit_id\`),
      KEY \`work_slug_idx\` (\`work_slug\`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  `);
  await db.execute(sql`
    INSERT IGNORE INTO \`my_works\` (\`slug\`, \`title\`, \`type\`, \`year\`, \`structure\`) VALUES (
      'disertasi-jabar',
      'Transisi Energi Jawa Barat: Bauran Energi, Distribusi, dan Implikasi Kebijakan',
      'dissertation',
      2026,
      '[{"id":"bab-1","label":"Bab 1 — Pendahuluan & Latar Belakang"},{"id":"bab-2","label":"Bab 2 — Tinjauan Pustaka"},{"id":"bab-3","label":"Bab 3 — Metodologi Penelitian"},{"id":"bab-4","label":"Bab 4 — Bauran Energi & Transisi Jabar"},{"id":"bab-5","label":"Bab 5 — Distribusi, Keandalan & Akses"},{"id":"bab-6","label":"Bab 6 — Pembahasan & Implikasi Kebijakan"},{"id":"bab-7","label":"Bab 7 — Kesimpulan & Rekomendasi"}]'
    )
  `);
}
ensureTables().catch(err => console.error("[literature] ensureTables error:", err));

export const literatureRoutes = new Hono();
literatureRoutes.use("*", requireAuth);

/* ── helpers ── */
const parse = (s: string | null | undefined) => { try { return JSON.parse(s || "[]"); } catch { return []; } };

/* ── GET all my works ── */
literatureRoutes.get("/works", async (c) => {
  const rows = await db.select().from(myWorks).orderBy(myWorks.year);
  return c.json(rows.map(r => ({ ...r, structure: parse(r.structure) })));
});

/* ── POST add work ── */
literatureRoutes.post("/works", async (c) => {
  const b = await c.req.json();
  await db.insert(myWorks).values({
    slug:      b.slug,
    title:     b.title,
    type:      b.type      || "dissertation",
    year:      b.year      || null,
    structure: JSON.stringify(b.structure || []),
  });
  return c.json({ ok: true });
});

/* ── PATCH update work ── */
literatureRoutes.patch("/works/:slug", async (c) => {
  const slug = c.req.param("slug");
  const b    = await c.req.json();
  const upd: Record<string, unknown> = {};
  if (b.title     !== undefined) upd.title     = b.title;
  if (b.type      !== undefined) upd.type      = b.type;
  if (b.year      !== undefined) upd.year      = b.year;
  if (b.structure !== undefined) upd.structure = JSON.stringify(b.structure);
  await db.update(myWorks).set(upd as any).where(eq(myWorks.slug, slug));
  return c.json({ ok: true });
});

/* ── DELETE work (POST fallback for Hostinger) ── */
literatureRoutes.post("/works/:slug/delete", async (c) => {
  const slug = c.req.param("slug");
  await db.delete(literatureCitations).where(eq(literatureCitations.workSlug, slug));
  await db.delete(myWorks).where(eq(myWorks.slug, slug));
  return c.json({ ok: true });
});

/* ── GET all items (with citations) ── */
literatureRoutes.get("/items", async (c) => {
  const rows = await db.select().from(literatureItems).orderBy(desc(literatureItems.updatedAt));
  const cits = await db.select().from(literatureCitations);
  const citMap = new Map<number, { id: number; workSlug: string; section: string }[]>();
  for (const c of cits) {
    if (!citMap.has(c.litId)) citMap.set(c.litId, []);
    citMap.get(c.litId)!.push({ id: c.id, workSlug: c.workSlug, section: c.section });
  }
  return c.json(rows.map(r => ({
    ...r,
    themes:  parse(r.themes),
    citedIn: citMap.get(r.id) ?? [],
  })));
});

/* ── POST citation ── */
literatureRoutes.post("/citations", async (c) => {
  const { litId, workSlug, section } = await c.req.json();
  await db.insert(literatureCitations)
    .values({ litId: Number(litId), workSlug, section: section || "" })
    .onDuplicateKeyUpdate({ set: { workSlug } });
  return c.json({ ok: true });
});

/* ── DELETE citation (POST fallback for Hostinger) ── */
literatureRoutes.post("/citations/:id/delete", async (c) => {
  await db.delete(literatureCitations).where(eq(literatureCitations.id, Number(c.req.param("id"))));
  return c.json({ ok: true });
});

/* ── POST add one ── */
literatureRoutes.post("/", async (c) => {
  const b = await c.req.json();
  await db.insert(literatureItems).values({
    title:     b.title,
    authors:   b.authors  || "",
    year:      b.year     || null,
    journal:   b.journal  || "",
    doi:       b.doi      || "",
    themes:    JSON.stringify(b.themes   || []),
    status:    b.status   || "belum",
    relevance: b.relevance ?? 3,
    citedIn:   JSON.stringify(b.citedIn  || []),
    notes:     b.notes    || null,
  });
  return c.json({ ok: true });
});

/* ── PATCH update ── */
literatureRoutes.patch("/:id", async (c) => {
  const id  = Number(c.req.param("id"));
  const b   = await c.req.json();
  const upd: Record<string, unknown> = { updatedAt: new Date() };
  if (b.title     !== undefined) upd.title     = b.title;
  if (b.authors   !== undefined) upd.authors   = b.authors;
  if (b.year      !== undefined) upd.year      = b.year;
  if (b.journal   !== undefined) upd.journal   = b.journal;
  if (b.doi       !== undefined) upd.doi       = b.doi;
  if (b.themes    !== undefined) upd.themes    = JSON.stringify(b.themes);
  if (b.status    !== undefined) upd.status    = b.status;
  if (b.relevance !== undefined) upd.relevance = b.relevance;
  if (b.citedIn   !== undefined) upd.citedIn   = JSON.stringify(b.citedIn);
  if (b.notes     !== undefined) upd.notes     = b.notes;
  await db.update(literatureItems).set(upd as any).where(eq(literatureItems.id, id));
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
    "journalArticle","conferencePaper","book","bookSection",
    "thesis","report","preprint","manuscript","encyclopediaArticle","dictionaryEntry",
  ]);

  let synced = 0;
  let start = 0;
  const limit = 100;

  while (true) {
    const url = `https://api.zotero.org/users/${uRow.value}/items?format=json&limit=${limit}&start=${start}&v=3`;
    const res = await fetch(url, { headers: { "Zotero-API-Key": kRow.value } });
    if (!res.ok) return c.json({ error: `Zotero API error: ${res.status}` }, 502);

    const items = (await res.json()) as any[];
    if (items.length === 0) break;

    for (const item of items) {
      const d = item.data;
      if (!d?.title || d.title.length < 5) continue;
      if (!ACADEMIC_TYPES.has(d.itemType)) continue;
      const authors = (d.creators || [])
        .map((cr: any) => cr.lastName || cr.name || "").filter(Boolean).join(", ");
      const year = d.date ? parseInt(d.date) : null;
      await db.insert(literatureItems).values({
        zoteroKey: d.key,
        title:     d.title,
        authors,
        year:      isNaN(year as number) ? null : year,
        journal:   d.publicationTitle || d.proceedingsTitle || d.bookTitle || "",
        doi:       d.DOI || "",
        themes:    "[]", status: "belum", relevance: 3, citedIn: "[]",
      }).onDuplicateKeyUpdate({
        set: { title: d.title, authors, year: isNaN(year as number) ? null : year,
               journal: d.publicationTitle || d.proceedingsTitle || d.bookTitle || "" },
      });
      synced++;
    }

    if (items.length < limit) break;
    start += limit;
  }

  return c.json({ ok: true, synced });
});

/* ── Import from .bib (parsed client-side) ── */
literatureRoutes.post("/import-bib", async (c) => {
  const { items } = await c.req.json();
  let imported = 0;
  for (const item of (items || [])) {
    if (!item.title) continue;
    await db.insert(literatureItems).values({
      title:   item.title,
      authors: item.authors || "",
      year:    item.year    || null,
      journal: item.journal || "",
      doi:     item.doi     || "",
      themes: "[]", status: "belum", relevance: 3, citedIn: "[]",
    });
    imported++;
  }
  return c.json({ ok: true, imported });
});
