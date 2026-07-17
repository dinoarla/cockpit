import { Hono } from "hono";
import { GoogleGenerativeAI, SchemaType, type FunctionDeclarationSchema } from "@google/generative-ai";
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

const SQL_TOOL = {
  functionDeclarations: [
    {
      name: "execute_sql",
      description: "Jalankan SELECT query ke database MySQL COCKPIT untuk mengambil data",
      parameters: {
        type: SchemaType.OBJECT,
        properties: {
          query: {
            type: SchemaType.STRING,
            description: "SELECT SQL query yang akan dijalankan",
          },
        },
        required: ["query"],
      } as FunctionDeclarationSchema,
    },
  ],
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
  // Tambahkan LIMIT jika belum ada
  const limited = /\bLIMIT\b/i.test(trimmed) ? trimmed : `${trimmed} LIMIT 100`;
  const result = await db.execute(sql.raw(limited));
  const rows = Array.isArray(result) && Array.isArray(result[0]) ? result[0] : result;
  return { rows: rows as unknown[], rowCount: (rows as unknown[]).length, sql: limited };
}

chatbotRoutes.post("/chat", async (c) => {
  const apiKey = process.env.GEMINI_API_KEY;
  if (!apiKey) {
    return c.json({ error: "GEMINI_API_KEY belum dikonfigurasi" }, 503);
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
    const genAI = new GoogleGenerativeAI(apiKey);
    const model = genAI.getGenerativeModel({
      model: "gemini-1.5-flash",
      systemInstruction: SYSTEM_PROMPT,
      tools: [SQL_TOOL],
    });

    const geminiHistory = history.map((h) => ({
      role: h.role as "user" | "model",
      parts: [{ text: h.text }],
    }));

    const chat = model.startChat({ history: geminiHistory });
    const result = await chat.sendMessage(message);

    let usedSql: string | undefined;
    let rowCount: number | undefined;

    // Cek apakah Gemini ingin memanggil function
    const candidate = result.response.candidates?.[0];
    const parts = candidate?.content?.parts ?? [];
    const fnCall = parts.find((p) => p.functionCall);

    if (fnCall?.functionCall) {
      const { name, args } = fnCall.functionCall;
      if (name === "execute_sql") {
        const fnArgs = args as { query: string };
        let sqlResult: unknown;
        try {
          const { rows, rowCount: rc, sql: executedSql } = await runSQL(fnArgs.query);
          usedSql = executedSql;
          rowCount = rc;
          sqlResult = { success: true, rows, rowCount: rc };
        } catch (err: unknown) {
          sqlResult = { success: false, error: err instanceof Error ? err.message : String(err) };
        }

        // Kirim hasil SQL kembali ke Gemini
        const finalResult = await chat.sendMessage([
          {
            functionResponse: {
              name: "execute_sql",
              response: sqlResult as Record<string, unknown>,
            },
          },
        ]);

        return c.json({
          answer: finalResult.response.text(),
          sql: usedSql,
          rowCount,
        });
      }
    }

    return c.json({ answer: result.response.text() });
  } catch (err: unknown) {
    const raw = err instanceof Error ? err.message : String(err);
    // Sederhanakan pesan error quota/rate-limit agar tidak tampil JSON panjang
    if (raw.includes("429") || raw.includes("quota") || raw.includes("Quota")) {
      return c.json({ error: "Kuota Gemini API habis. Pastikan API key dari Google AI Studio (aistudio.google.com) dan coba lagi sebentar." }, 429);
    }
    if (raw.includes("API_KEY") || raw.includes("401") || raw.includes("403")) {
      return c.json({ error: "API key Gemini tidak valid. Periksa GEMINI_API_KEY di hosting." }, 401);
    }
    return c.json({ error: "Terjadi kesalahan saat menghubungi Gemini. Coba lagi." }, 500);
  }
});
