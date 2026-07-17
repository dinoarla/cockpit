import { Hono } from "hono";
import { streamSSE } from "hono/streaming";
import Groq from "groq-sdk";
import { db } from "../db/client.js";
import { sql } from "drizzle-orm";
import { requireAuth } from "../middleware/auth.js";
export const chatbotRoutes = new Hono();
chatbotRoutes.use("*", requireAuth);
const SYSTEM_PROMPT = `Kamu adalah asisten riset untuk COCKPIT — portal data riset pribadi milik Dino.
Jawab dalam Bahasa Indonesia yang ringkas dan informatif.

=== DUA TOOL YANG TERSEDIA ===

1. execute_sql — query SQL langsung ke database utama COCKPIT (MySQL).
   Gunakan untuk: filter kustom, perhitungan khusus, data yang butuh agregasi fleksibel.

2. call_api — panggil endpoint API internal COCKPIT.
   Gunakan untuk: data SIMBA (database terpisah, TIDAK bisa via SQL), data RUPTL/PLN yang sudah diproses,
   atau ketika endpoint sudah menyediakan agregasi yang dibutuhkan.

KAPAN TIDAK PERLU TOOL: sapaan, pertanyaan umum, obrolan biasa → jawab langsung tanpa tool.

=== SKEMA DATABASE UTAMA (untuk execute_sql) ===

-- Data Baca Meter Paskabayar Jawa Barat 2026
-- bulan format: '202601' s/d '202607' | Default tanpa filter: WHERE bulan = '202607'
-- PENTING: total_pelanggan = jumlah pelanggan di BULAN ITU, bukan kumulatif
-- UP3 Jabar: Bandung, Bekasi Kota, Bekasi, Bogor, Cianjur, Cikokol, Cimahi,
--   Depok, Garut, Karawang, Majalaya, Purwakarta, Sukabumi, Sumedang,
--   Tasikmalaya, Cikarang, Banten, Cirebon

baca_meter_summary(bulan, up3_kode, up3_nama, total_pelanggan, total_kwh, avg_kwh, pct_normal, baca_ulang, inisialisasi, avg_jam)
baca_meter_tarif(bulan, up3_kode, tarif, pelanggan, total_kwh)
baca_meter_daya(bulan, up3_kode, daya_va, pelanggan, total_kwh)
baca_meter_kode_pesan(bulan, up3_kode, kode_pesan, jumlah)
baca_meter_jam(bulan, up3_kode, jam TINYINT, jumlah)

-- PLN Statistik Nasional 2014-2025
pln_stat_national(year, installed_capacity_pln_mw, installed_capacity_total_mw, peak_load_mw,
  prod_total_gwh, cust_household, cust_total, sold_household_gwh, sold_industry_gwh,
  sold_total_gwh, tariff_avg_rp_kwh, electrification_ratio_pct)

-- OLAP Tagihan AMR
olap_amr_tagihan(thblrek CHAR(6), unitap, unitap_nama, unitup, tarif, tarif_grup,
  jml_pelanggan, kwh_total, kwh_lwbp, kwh_wbp, rp_ptl, rp_ppj, rp_total)

-- Kependudukan BPS Jawa Barat
kependudukan_bps_jabar(tahun, kabkota, indikator, satuan, nilai)

-- User & Akses COCKPIT
users(id, username, name, role ENUM('admin','viewer'), is_active, created_at)
domains(id, name, slug, is_active)
domain_modules(id, domain_id, name, slug, is_active)

=== ENDPOINT API INTERNAL (untuk call_api) ===

SIMBA — monitoring BBM pembangkit Kalimantan Barat (database TERPISAH, wajib pakai call_api):
  /api/simba/plants                        → daftar pembangkit (sera, stn, wie, pw, sdr, bugak, pltg, mpp)
  /api/simba/monitoring/{plant}?bbm=HSD    → monitoring harian BBM per pembangkit
  /api/simba/rekap                         → rekap stok & pemakaian semua pembangkit
  /api/simba/sfc-summary                   → SFC (Specific Fuel Consumption) summary
  /api/simba/monthly-rekap                 → rekap bulanan BBM
  /api/simba/tanks                         → data tangki BBM

RUPTL — Rencana Umum Penyediaan Tenaga Listrik:
  /api/ruptl/summary                       → ringkasan nasional RUPTL
  /api/ruptl/provinsi                      → daftar provinsi & beban puncak 2024
  /api/ruptl/provinsi/{kode}/penjualan     → historis penjualan per provinsi (mis: JABAR, KALTIM)
  /api/ruptl/provinsi/{kode}/proyeksi      → proyeksi kebutuhan listrik per provinsi
  /api/ruptl/rencana-pembangkit            → rencana pembangkit nasional

Baca Meter — agregat siap pakai:
  /api/baca-meter/summary                  → total Jabar per bulan (semua bulan)
  /api/baca-meter/by-up3                   → per UP3 semua bulan
  /api/baca-meter/tarif-jabar?bulan=202607 → distribusi tarif se-Jabar
  /api/baca-meter/bulan-list               → daftar bulan tersedia

OLAP Tagihan:
  /api/olap-tagihan/summary                → ringkasan per periode
  /api/olap-tagihan/by-unitap              → per unit AP per periode
  /api/olap-tagihan/by-tarif               → per grup tarif per periode

PLN:
  /api/pln-stat/national                   → statistik nasional 2014-2025
  /api/pln-sr/all                          → data sambungan rumah

=== ATURAN PENTING ===
1. execute_sql: hanya SELECT, LIMIT maks 100, default bulan '202607'.
   JANGAN SUM(total_pelanggan) lintas bulan (double counting).
   JANGAN query tabel yang tidak ada di schema di atas.
2. call_api: hanya endpoint dari daftar di atas. Sertakan query_params jika diperlukan.
3. ANTI-HALUSINASI: jika data tidak tersedia (tabel tidak ada, endpoint tidak ada),
   jawab "Data tersebut tidak tersedia di COCKPIT." — jangan mengarang.
4. Format angka besar dengan titik ribuan (mis: 836.332 pelanggan).`;
// ── Tool definitions ──
const SQL_TOOL = {
    type: "function",
    function: {
        name: "execute_sql",
        description: "Jalankan SELECT query ke database utama MySQL COCKPIT",
        parameters: {
            type: "object",
            properties: {
                query: { type: "string", description: "SELECT SQL query" },
            },
            required: ["query"],
        },
    },
};
const CALL_API_TOOL = {
    type: "function",
    function: {
        name: "call_api",
        description: "Panggil endpoint API internal COCKPIT (wajib untuk data SIMBA, RUPTL, atau data terproses dari modul)",
        parameters: {
            type: "object",
            properties: {
                endpoint: {
                    type: "string",
                    description: "Path endpoint API, mis: /api/simba/rekap atau /api/ruptl/provinsi/JABAR/penjualan",
                },
                query_params: {
                    type: "object",
                    description: "Query parameters opsional, mis: {\"bulan\": \"202607\", \"bbm\": \"HSD\"}",
                    additionalProperties: { type: "string" },
                },
            },
            required: ["endpoint"],
        },
    },
};
// ── SQL runner ──
const BLOCKED_KEYWORDS = /\b(drop|delete|update|insert|alter|truncate|create|replace|grant|revoke|exec|execute|xp_|sp_)\b/i;
async function runSQL(query) {
    const trimmed = query.trim();
    if (!trimmed.toUpperCase().startsWith("SELECT"))
        throw new Error("Hanya SELECT query yang diizinkan");
    if (BLOCKED_KEYWORDS.test(trimmed))
        throw new Error("Query mengandung keyword yang tidak diizinkan");
    const limited = /\bLIMIT\b/i.test(trimmed) ? trimmed : `${trimmed} LIMIT 100`;
    const result = await db.execute(sql.raw(limited));
    const rows = Array.isArray(result) && Array.isArray(result[0]) ? result[0] : result;
    return { rows: rows, rowCount: rows.length, sql: limited };
}
// ── Internal API caller ──
const ALLOWED_PREFIXES = [
    "/api/baca-meter/",
    "/api/pln-stat/",
    "/api/olap-tagihan/",
    "/api/ruptl/",
    "/api/simba/",
    "/api/pln-sr/",
    "/api/pln-ar/",
    "/api/pln-scholar/",
    "/api/domains",
];
async function callInternalAPI(endpoint, queryParams, cookie) {
    if (!ALLOWED_PREFIXES.some((p) => endpoint.startsWith(p))) {
        throw new Error(`Endpoint tidak diizinkan: ${endpoint}`);
    }
    const port = process.env.PORT ?? "3000";
    const url = new URL(`http://127.0.0.1:${port}${endpoint}`);
    Object.entries(queryParams).forEach(([k, v]) => url.searchParams.set(k, v));
    const res = await fetch(url.toString(), {
        headers: { Cookie: cookie },
        signal: AbortSignal.timeout(15000),
    });
    if (!res.ok) {
        const text = await res.text().catch(() => "");
        throw new Error(`API ${endpoint} error ${res.status}: ${text.slice(0, 150)}`);
    }
    const data = await res.json();
    const json = JSON.stringify(data);
    // Potong response besar agar tidak overflow konteks model
    if (json.length > 8000) {
        return {
            _note: `Response dipotong (asli ${json.length} chars). Gunakan execute_sql untuk query lebih spesifik.`,
            data: JSON.parse(json.slice(0, 7800) + '"]}'),
        };
    }
    return data;
}
// ── Error simplifier ──
function simplifyError(raw) {
    if (raw.includes("429") || raw.includes("rate_limit"))
        return "Rate limit Groq tercapai. Tunggu sebentar lalu coba lagi.";
    if (raw.includes("401") || raw.includes("invalid_api_key"))
        return "GROQ_API_KEY tidak valid.";
    return `Kesalahan: ${raw.slice(0, 200)}`;
}
// ── Route handler ──
chatbotRoutes.post("/chat", async (c) => {
    const apiKey = process.env.GROQ_API_KEY;
    if (!apiKey)
        return c.json({ error: "GROQ_API_KEY belum dikonfigurasi di server." }, 503);
    let body;
    try {
        body = await c.req.json();
    }
    catch {
        return c.json({ error: "Body JSON tidak valid" }, 400);
    }
    const { message, history = [] } = body;
    if (!message?.trim())
        return c.json({ error: "Pesan tidak boleh kosong" }, 400);
    const cookie = c.req.header("Cookie") ?? "";
    const groq = new Groq({ apiKey });
    const messages = [
        { role: "system", content: SYSTEM_PROMPT },
        ...history.map((h) => ({
            role: (h.role === "model" ? "assistant" : h.role),
            content: h.text,
        })),
        { role: "user", content: message },
    ];
    return streamSSE(c, async (stream) => {
        const write = (data) => stream.writeSSE({ data: JSON.stringify(data) });
        try {
            // ── Fase 1: kirim ke model, deteksi tool call ──
            const firstStream = await groq.chat.completions.create({
                model: "llama-3.3-70b-versatile",
                messages,
                tools: [SQL_TOOL, CALL_API_TOOL],
                tool_choice: "auto",
                max_tokens: 1024,
                stream: true,
            });
            let toolCallId = "";
            let toolCallName = "";
            let toolCallArgs = "";
            let isToolCall = false;
            for await (const chunk of firstStream) {
                const delta = chunk.choices[0]?.delta;
                if (delta?.content)
                    await write({ t: "chunk", v: delta.content });
                if (delta?.tool_calls?.[0]) {
                    isToolCall = true;
                    const tc = delta.tool_calls[0];
                    if (tc.id)
                        toolCallId = tc.id;
                    if (tc.function?.name)
                        toolCallName += tc.function.name;
                    if (tc.function?.arguments)
                        toolCallArgs += tc.function.arguments;
                }
            }
            // ── Fase 2: eksekusi tool, stream jawaban akhir ──
            if (isToolCall) {
                let toolResult;
                let metaSql;
                let metaRows = 0;
                let metaApi;
                if (toolCallName === "execute_sql") {
                    try {
                        const args = JSON.parse(toolCallArgs);
                        const { rows, rowCount, sql: executedSql } = await runSQL(args.query);
                        metaSql = executedSql;
                        metaRows = rowCount;
                        toolResult = JSON.stringify({ success: true, rows, rowCount });
                    }
                    catch (err) {
                        toolResult = JSON.stringify({ success: false, error: err instanceof Error ? err.message : String(err) });
                    }
                }
                else if (toolCallName === "call_api") {
                    try {
                        const args = JSON.parse(toolCallArgs);
                        const data = await callInternalAPI(args.endpoint, args.query_params ?? {}, cookie);
                        metaApi = args.endpoint;
                        toolResult = JSON.stringify({ success: true, data });
                    }
                    catch (err) {
                        toolResult = JSON.stringify({ success: false, error: err instanceof Error ? err.message : String(err) });
                    }
                }
                else {
                    toolResult = JSON.stringify({ success: false, error: `Tool '${toolCallName}' tidak dikenal` });
                }
                const followUp = [
                    ...messages,
                    {
                        role: "assistant",
                        content: null,
                        tool_calls: [{ id: toolCallId, type: "function", function: { name: toolCallName, arguments: toolCallArgs } }],
                    },
                    { role: "tool", tool_call_id: toolCallId, content: toolResult },
                ];
                const secondStream = await groq.chat.completions.create({
                    model: "llama-3.3-70b-versatile",
                    messages: followUp,
                    max_tokens: 1024,
                    stream: true,
                });
                for await (const chunk of secondStream) {
                    const text = chunk.choices[0]?.delta?.content;
                    if (text)
                        await write({ t: "chunk", v: text });
                }
                if (metaSql)
                    await write({ t: "sql", query: metaSql, rows: metaRows });
                if (metaApi)
                    await write({ t: "api", endpoint: metaApi });
            }
            await write({ t: "done" });
        }
        catch (err) {
            const raw = err instanceof Error ? err.message : String(err);
            await write({ t: "error", v: simplifyError(raw) });
        }
    });
});
//# sourceMappingURL=chatbot.js.map