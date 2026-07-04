import { Hono } from "hono";
import { requireAuth } from "../middleware/auth.js";

export const mdpRoutes = new Hono();

// Semua route di bawah ini butuh login (lihat requireAuth di middleware/auth.ts).
mdpRoutes.use("*", requireAuth);

/**
 * Placeholder endpoint untuk data pendukung MDP (dashboard yang sudah
 * dibuat sebelumnya — kemiskinan, populasi, risiko bencana, demand energi,
 * gangguan jaringan, investasi AI Sar, dsb).
 *
 * Cara migrasinya nanti: pindahkan array-array di DATA {...} pada
 * dashboard HTML ke tabel MySQL (satu tabel per dataset, atau satu tabel
 * generik `mdp_metrics` dengan kolom kategori), lalu query di sini
 * menggantikan data yang sekarang di-hardcode.
 */
mdpRoutes.get("/summary", (c) => {
  return c.json({
    message: "Ganti handler ini dengan query ke tabel MySQL yang menyimpan data MDP.",
    contoh_struktur_tabel: {
      mdp_kemiskinan: ["daerah", "tahun", "persentase"],
      mdp_populasi: ["daerah", "tahun", "jumlah"],
      mdp_risiko_bencana: ["daerah", "tahun", "indeks"],
      mdp_demand_energi: ["daerah", "up3", "gwh", "std_gwh"],
      mdp_gangguan: ["up3", "tahun", "jumlah_kali"],
    },
  });
});
