import { Hono } from "hono";
import Groq from "groq-sdk";
import { db } from "../db/client.js";
import { sql } from "drizzle-orm";
import { requireAuth } from "../middleware/auth.js";

export const chatbotRoutes = new Hono();
chatbotRoutes.use("*", requireAuth);

const SYSTEM_PROMPT = `Kamu adalah asisten riset untuk COCKPIT — portal data riset pribadi.
Jawab pertanyaan dalam Bahasa Indonesia yang ringkas dan informatif.
Jika pertanyaan membutuhkan data dari database, gunakan tool execute_sql untuk mengambil data.
Hanya gunakan SELECT query. Jangan gunakan DROP, DELETE, UPDATE, INSERT, atau DDL apapun.

=== SKEMA DATABASE COCKPIT (MySQL) ===

-- Data Baca Meter Paskabayar Jawa Barat 2026
-- bulan format: '202601' s/d '202607' (Jan-Jul 2026)
-- UP3 Jawa Barat: Bandung, Bekasi Kota, Bekasi, Bogor, Cianjur, Cikokol,
--   Cimahi, Depok, Garut, Karawang, Majalaya, Purwakarta, Sukabumi,
--   Sumedang, Tasikmalaya, Cikarang, Banten, Cirebon

baca_meter_summary(
  bulan CHAR(6),          -- periode, mis '202603' = Maret 2026
  up3_kode VARCHAR(10),   -- kode UP3
  up3_nama VARCHAR(100),  -- nama UP3
  total_pelanggan INT,    -- jumlah pelanggan
  total_kwh DECIMAL,      -- total konsumsi kWh
  avg_kwh DECIMAL,        -- rata-rata kWh per pelanggan
  pct_normal DECIMAL,     -- persentase baca normal
  baca_ulang INT,         -- jumlah baca ulang
  inisialisasi INT,       -- jumlah inisialisasi
  avg_jam DECIMAL         -- rata-rata jam baca
)

baca_meter_tarif(
  bulan CHAR(6), up3_kode VARCHAR(10),
  tarif VARCHAR(20),      -- golongan tarif: R1, R2, R3, B1, B2, I1, I2, dst
  pelanggan INT, total_kwh DECIMAL
)

baca_meter_daya(
  bulan CHAR(6), up3_kode VARCHAR(10),
  daya_va INT,            -- kapasitas daya: 450, 900, 1300, 2200, dst (VA)
  pelanggan INT, total_kwh DECIMAL
)

baca_meter_kode_pesan(
  bulan CHAR(6), up3_kode VARCHAR(10),
  kode_pesan VARCHAR(10), -- kode status bacaan meter
  jumlah INT
)

baca_meter_jam(
  bulan CHAR(6), up3_kode VARCHAR(10),
  jam TINYINT,            -- jam 0-23
  jumlah INT
)

-- Data Statistik Nasional PLN (2014-2025)
pln_stat_national(
  year INT,
  installed_capacity_pln_mw DECIMAL, installed_capacity_total_mw DECIMAL,
  peak_load_mw DECIMAL, prod_total_gwh DECIMAL,
  cust_household BIGINT, cust_total BIGINT,
  sold_household_gwh DECIMAL, sold_industry_gwh DECIMAL,
  sold_total_gwh DECIMAL, tariff_avg_rp_kwh DECIMAL,
  electrification_ratio_pct DECIMAL
)

-- OLAP Tagihan AMR
olap_amr_tagihan(
  thblrek CHAR(6),        -- periode YYYYMM
  unitap VARCHAR(10), unitap_nama VARCHAR(50),
  unitup VARCHAR(10), tarif VARCHAR(10), tarif_grup VARCHAR(20),
  jml_pelanggan INT, kwh_total DECIMAL,
  kwh_lwbp DECIMAL, kwh_wbp DECIMAL,
  rp_ptl BIGINT, rp_ppj BIGINT, rp_total BIGINT
)

-- Kependudukan BPS Jawa Barat
kependudukan_bps_jabar(
  tahun INT, kabkota VARCHAR(100), indikator VARCHAR(200),
  satuan VARCHAR(50), nilai DECIMAL
)

=== ATURAN ===
1. Selalu gunakan LIMIT jika memungkinkan (maks 100 baris)
2. Format angka besar dengan koma ribuan di jawaban akhir
3. Jika data tidak ditemukan, sampaikan dengan jelas
4. Untuk pertanyaan tren, gunakan ORDER BY bulan/tahun ASC`;

const SQL_TOOL: Groq.Chat.Completions.ChatCompletionTool = {
  type: "function",
  function: {
    name: "execute_sql",
    description: "Jalankan SELECT query ke database MySQL COCKPIT untuk mengambil data",
    parameters: {
      type: "object",
      properties: {
        query: {
          type: "string",
          description: "SELECT SQL query yang akan dijalankan",
        },
      },
      required: ["query"],
    },
  },
};

const BLOCKED_KEYWORDS = /\b(drop|delete|update|insert|alter|truncate|create|replace|grant|revoke|exec|execute|xp_|sp_)\b/i;

async function runSQL(query: string): Promise<{ rows: unknown[]; rowCount: number; sql: string }> {
  const trimmed = query.trim();
  if (!trimmed.toUpperCase().startsWith("SELECT")) {
    throw new Error("Hanya SELECT query yang diizinkan");
  }
  if (BLOCKED_KEYWORDS.test(trimmed)) {
    throw new Error("Query mengandung keyword yang tidak diizinkan");
  }
  const limited = /\bLIMIT\b/i.test(trimmed) ? trimmed : `${trimmed} LIMIT 100`;
  const result = await db.execute(sql.raw(limited));
  const rows = Array.isArray(result) && Array.isArray(result[0]) ? result[0] : result;
  return { rows: rows as unknown[], rowCount: (rows as unknown[]).length, sql: limited };
}

chatbotRoutes.post("/chat", async (c) => {
  const apiKey = process.env.GROQ_API_KEY;
  if (!apiKey) {
    return c.json({ error: "GROQ_API_KEY belum dikonfigurasi di server." }, 503);
  }

  let body: { message: string; history?: Array<{ role: string; text: string }> };
  try {
    body = await c.req.json();
  } catch {
    return c.json({ error: "Body JSON tidak valid" }, 400);
  }

  const { message, history = [] } = body;
  if (!message?.trim()) {
    return c.json({ error: "Pesan tidak boleh kosong" }, 400);
  }

  try {
    const groq = new Groq({ apiKey });

    const messages: Groq.Chat.Completions.ChatCompletionMessageParam[] = [
      { role: "system", content: SYSTEM_PROMPT },
      ...history.map((h) => ({
        role: (h.role === "model" ? "assistant" : h.role) as "user" | "assistant",
        content: h.text,
      })),
      { role: "user", content: message },
    ];

    const response = await groq.chat.completions.create({
      model: "llama-3.3-70b-versatile",
      messages,
      tools: [SQL_TOOL],
      tool_choice: "auto",
      max_tokens: 1024,
    });

    const choice = response.choices[0];
    const toolCalls = choice.message.tool_calls;

    if (toolCalls && toolCalls.length > 0) {
      const tc = toolCalls[0];
      let sqlResult: unknown;
      let usedSql: string | undefined;
      let rowCount: number | undefined;

      try {
        const args = JSON.parse(tc.function.arguments) as { query: string };
        const { rows, rowCount: rc, sql: executedSql } = await runSQL(args.query);
        usedSql = executedSql;
        rowCount = rc;
        sqlResult = JSON.stringify({ success: true, rows, rowCount: rc });
      } catch (err: unknown) {
        sqlResult = JSON.stringify({ success: false, error: err instanceof Error ? err.message : String(err) });
      }

      // Kirim hasil SQL kembali ke model untuk jawaban akhir
      const followUp = await groq.chat.completions.create({
        model: "llama-3.3-70b-versatile",
        messages: [
          ...messages,
          choice.message as Groq.Chat.Completions.ChatCompletionMessageParam,
          {
            role: "tool",
            tool_call_id: tc.id,
            content: sqlResult as string,
          },
        ],
        max_tokens: 1024,
      });

      return c.json({
        answer: followUp.choices[0].message.content ?? "",
        sql: usedSql,
        rowCount,
      });
    }

    return c.json({ answer: choice.message.content ?? "" });
  } catch (err: unknown) {
    const raw = err instanceof Error ? err.message : String(err);
    if (raw.includes("429") || raw.includes("rate_limit") || raw.includes("Rate limit")) {
      return c.json({ error: "Rate limit Groq tercapai. Tunggu sebentar lalu coba lagi." }, 429);
    }
    if (raw.includes("401") || raw.includes("403") || raw.includes("invalid_api_key") || raw.includes("Authentication")) {
      return c.json({ error: "GROQ_API_KEY tidak valid. Periksa konfigurasi di hosting." }, 401);
    }
    return c.json({ error: `Kesalahan: ${raw.slice(0, 300)}` }, 500);
  }
});
