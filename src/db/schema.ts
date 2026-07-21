import {
  mysqlTable,
  varchar,
  int,
  bigint,
  decimal,
  timestamp,
  boolean,
  mysqlEnum,
  index,
  text,
  char,
  date,
  primaryKey,
  uniqueIndex,
} from "drizzle-orm/mysql-core";

/**
 * Tabel pengguna.
 * password_hash disimpan dalam format Argon2id (lihat src/auth/password.ts).
 * NEVER simpan plaintext password di tabel ini atau tabel manapun.
 */
export const users = mysqlTable("users", {
  id: int("id").autoincrement().primaryKey(),
  username: varchar("username", { length: 64 }).notNull().unique(),
  email: varchar("email", { length: 255 }).notNull().unique(),
  passwordHash: varchar("password_hash", { length: 255 }).notNull(),
  role: mysqlEnum("role", ["admin", "editor", "viewer"]).notNull().default("viewer"),
  isActive: boolean("is_active").notNull().default(true),

  // Rate limiting / account lockout (lihat src/auth/rateLimiter.ts)
  failedLoginCount: int("failed_login_count").notNull().default(0),
  lockedUntil: timestamp("locked_until"),

  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow().onUpdateNow(),
});

/**
 * Tabel sesi login.
 *
 * PENTING: kolom `id` di sini adalah HASH (SHA-256) dari token sesi,
 * bukan token itu sendiri. Token asli hanya pernah dikirim ke browser
 * lewat cookie httpOnly. Kalau database ini bocor, penyerang TIDAK bisa
 * memakai isi tabel ini langsung untuk membajak sesi — mereka butuh
 * token asli yang cuma ada di cookie browser pengguna.
 * Lihat src/auth/session.ts untuk detail implementasi.
 */
export const sessions = mysqlTable(
  "sessions",
  {
    id: varchar("id", { length: 64 }).primaryKey(), // SHA-256 hex dari token
    userId: int("user_id").notNull(),
    userAgent: varchar("user_agent", { length: 255 }),
    ipAddress: varchar("ip_address", { length: 45 }), // cukup untuk IPv6
    createdAt: timestamp("created_at").notNull().defaultNow(),
    expiresAt: timestamp("expires_at").notNull(),
  },
  (table) => ({
    userIdIdx: index("sessions_user_id_idx").on(table.userId),
    expiresAtIdx: index("sessions_expires_at_idx").on(table.expiresAt),
  })
);

/**
 * Audit log percobaan login (sukses maupun gagal).
 * Berguna untuk investigasi kalau ada aktivitas mencurigakan.
 */
export const loginAudit = mysqlTable(
  "login_audit",
  {
    id: int("id").autoincrement().primaryKey(),
    username: varchar("username", { length: 64 }).notNull(),
    success: boolean("success").notNull(),
    ipAddress: varchar("ip_address", { length: 45 }),
    userAgent: varchar("user_agent", { length: 255 }),
    reason: varchar("reason", { length: 100 }), // mis. "invalid_password", "account_locked", "ok"
    createdAt: timestamp("created_at").notNull().defaultNow(),
  },
  (table) => ({
    usernameIdx: index("login_audit_username_idx").on(table.username),
    createdAtIdx: index("login_audit_created_at_idx").on(table.createdAt),
  })
);

export type User = typeof users.$inferSelect;
export type NewUser = typeof users.$inferInsert;
export type Session = typeof sessions.$inferSelect;

// ============================================================
// MODUL RUPTL PLN 2025-2034
// ============================================================

export const ruptlProvinsi = mysqlTable("ruptl_provinsi", {
  id: int("id").autoincrement().primaryKey(),
  kode: varchar("kode", { length: 5 }).notNull().unique(),
  nama: varchar("nama", { length: 100 }).notNull(),
  lampiran: varchar("lampiran", { length: 2 }).notNull(),
  wilayahSistem: varchar("wilayah_sistem", { length: 60 }).notNull(),
  bebanPuncak2024Mw: decimal("beban_puncak_2024_mw", { precision: 10, scale: 2 }),
});

export const ruptlPenjualanHistoris = mysqlTable(
  "ruptl_penjualan_historis",
  {
    id: int("id").autoincrement().primaryKey(),
    provinsiId: int("provinsi_id").notNull(),
    tahun: int("tahun").notNull(),
    sektor: mysqlEnum("sektor", ["RUMAH_TANGGA", "BISNIS", "PUBLIK", "INDUSTRI"]).notNull(),
    gwh: decimal("gwh", { precision: 10, scale: 2 }),
  },
  (t) => ({ provTahunIdx: index("penjualan_prov_tahun_idx").on(t.provinsiId, t.tahun) })
);

export const ruptlPelangganHistoris = mysqlTable(
  "ruptl_pelanggan_historis",
  {
    id: int("id").autoincrement().primaryKey(),
    provinsiId: int("provinsi_id").notNull(),
    tahun: int("tahun").notNull(),
    sektor: mysqlEnum("sektor", ["RUMAH_TANGGA", "BISNIS", "PUBLIK", "INDUSTRI"]).notNull(),
    jumlahRibu: decimal("jumlah_ribu", { precision: 10, scale: 2 }),
  },
  (t) => ({ provTahunIdx: index("pelanggan_prov_tahun_idx").on(t.provinsiId, t.tahun) })
);

export const ruptlProyeksiKebutuhan = mysqlTable(
  "ruptl_proyeksi_kebutuhan",
  {
    id: int("id").autoincrement().primaryKey(),
    provinsiId: int("provinsi_id").notNull(),
    tahun: int("tahun").notNull(),
    pertumbuhanEkonomiPct: decimal("pertumbuhan_ekonomi_pct", { precision: 5, scale: 2 }),
    salesGwh: decimal("sales_gwh", { precision: 10, scale: 2 }),
    produksiGwh: decimal("produksi_gwh", { precision: 10, scale: 2 }),
    bebanPuncakMw: decimal("beban_puncak_mw", { precision: 10, scale: 2 }),
    pelanggan: int("pelanggan"),
  },
  (t) => ({ provTahunIdx: index("proyeksi_prov_tahun_idx").on(t.provinsiId, t.tahun) })
);

export const ruptlPembangkitEksisting = mysqlTable(
  "ruptl_pembangkit_eksisting",
  {
    id: int("id").autoincrement().primaryKey(),
    provinsiId: int("provinsi_id").notNull(),
    pemilik: mysqlEnum("pemilik", ["PLN", "IPP"]).notNull().default("PLN"),
    jenis: varchar("jenis", { length: 20 }).notNull(),
    sistemTenagaListrik: varchar("sistem_tenaga_listrik", { length: 50 }),
    jumlahUnit: int("jumlah_unit"),
    kapasitasMw: decimal("kapasitas_mw", { precision: 10, scale: 2 }),
    dayaMambuMw: decimal("daya_mampu_mw", { precision: 10, scale: 2 }),
    dmpMw: decimal("dmp_mw", { precision: 10, scale: 2 }),
  },
  (t) => ({ provIdx: index("pembangkit_eks_prov_idx").on(t.provinsiId) })
);

export const ruptlRencanaPembangkit = mysqlTable(
  "ruptl_rencana_pembangkit",
  {
    id: int("id").autoincrement().primaryKey(),
    provinsiId: int("provinsi_id").notNull(),
    skenario: mysqlEnum("skenario", ["RE_BASE", "ARED"]).notNull(),
    jenis: varchar("jenis", { length: 30 }).notNull(),
    nama: varchar("nama", { length: 200 }),
    kapasitasMw: decimal("kapasitas_mw", { precision: 10, scale: 2 }),
    codTahun: int("cod_tahun"),
    keterangan: varchar("keterangan", { length: 500 }),
  },
  (t) => ({
    provSkenIdx: index("rencana_prov_sken_idx").on(t.provinsiId, t.skenario),
    codIdx: index("rencana_cod_idx").on(t.codTahun),
  })
);

export const ruptlRencanaTransmisi = mysqlTable(
  "ruptl_rencana_transmisi",
  {
    id: int("id").autoincrement().primaryKey(),
    provinsiId: int("provinsi_id").notNull(),
    skenario: mysqlEnum("skenario", ["RE_BASE", "ARED"]).notNull(),
    tahun: int("tahun").notNull(),
    kms: decimal("kms", { precision: 10, scale: 2 }),
  },
  (t) => ({ provSkenTahunIdx: index("transmisi_prov_sken_tahun_idx").on(t.provinsiId, t.skenario, t.tahun) })
);

export const ruptlRencanaGarduInduk = mysqlTable(
  "ruptl_rencana_gardu_induk",
  {
    id: int("id").autoincrement().primaryKey(),
    provinsiId: int("provinsi_id").notNull(),
    skenario: mysqlEnum("skenario", ["RE_BASE", "ARED"]).notNull(),
    tahun: int("tahun").notNull(),
    mva: decimal("mva", { precision: 10, scale: 2 }),
  },
  (t) => ({ provSkenTahunIdx: index("gi_prov_sken_tahun_idx").on(t.provinsiId, t.skenario, t.tahun) })
);

// ============================================================
// RUPTL — Dimensi & Tabel Nasional/Wilayah (v2)
// Berdasarkan Kerangka_Data_Pusat_Data_RUPTL_2025-2034.md
// ============================================================

export const ruptlWilayahUsaha = mysqlTable("ruptl_wilayah_usaha", {
  id: int("id").autoincrement().primaryKey(),
  kode: varchar("kode", { length: 5 }).notNull().unique(),
  nama: varchar("nama", { length: 100 }).notNull(),
  urutan: int("urutan").notNull().default(0),
});

export const ruptlSistemKelistrikan = mysqlTable("ruptl_sistem_kelistrikan", {
  id: int("id").autoincrement().primaryKey(),
  wilayahId: int("wilayah_id"),
  kode: varchar("kode", { length: 20 }).notNull().unique(),
  nama: varchar("nama", { length: 100 }).notNull(),
  jenis: mysqlEnum("jenis", ["INTERKONEKSI", "ISOLATED"]).notNull().default("INTERKONEKSI"),
});

// Modul 2 — Historis Kinerja Nasional/Wilayah (Bab IV)
export const ruptlHistPenjualanWilayah = mysqlTable(
  "ruptl_hist_penjualan_wilayah",
  {
    id: int("id").autoincrement().primaryKey(),
    wilayahId: int("wilayah_id"),
    tahun: int("tahun").notNull(),
    sektor: mysqlEnum("sektor", ["RUMAH_TANGGA", "BISNIS", "PUBLIK", "INDUSTRI", "TOTAL"]).notNull(),
    gwh: decimal("gwh", { precision: 12, scale: 2 }),
    pendapatanTriliun: decimal("pendapatan_triliun", { precision: 10, scale: 3 }),
  },
  (t) => ({ idx: index("idx_hist_penj_wil_tahun").on(t.wilayahId, t.tahun) })
);

export const ruptlHistPelangganWilayah = mysqlTable(
  "ruptl_hist_pelanggan_wilayah",
  {
    id: int("id").autoincrement().primaryKey(),
    wilayahId: int("wilayah_id"),
    tahun: int("tahun").notNull(),
    sektor: mysqlEnum("sektor", ["RUMAH_TANGGA", "BISNIS", "PUBLIK", "INDUSTRI", "TOTAL"]).notNull(),
    jumlahRibu: decimal("jumlah_ribu", { precision: 12, scale: 2 }),
  },
  (t) => ({ idx: index("idx_hist_pel_wil_tahun").on(t.wilayahId, t.tahun) })
);

// pemilik: MILIK_SENDIRI=PLN own, SEWA=disewa PLN, IPP=excess power/IPP
export const ruptlHistKapasitasWilayah = mysqlTable(
  "ruptl_hist_kapasitas_wilayah",
  {
    id: int("id").autoincrement().primaryKey(),
    wilayahId: int("wilayah_id"),
    tahun: int("tahun").notNull(),
    pemilik: mysqlEnum("pemilik", ["MILIK_SENDIRI", "SEWA", "IPP", "TOTAL"]).notNull(),
    kapasitasMw: decimal("kapasitas_mw", { precision: 12, scale: 2 }),
    dmnMw: decimal("dmn_mw", { precision: 12, scale: 2 }),
    jumlahUnit: int("jumlah_unit"),
  },
  (t) => ({ idx: index("idx_hist_kap_wil_tahun").on(t.wilayahId, t.tahun) })
);

export const ruptlHistKeandalan = mysqlTable(
  "ruptl_hist_keandalan",
  {
    id: int("id").autoincrement().primaryKey(),
    wilayahId: int("wilayah_id"),
    tahun: int("tahun").notNull(),
    saidiJam: decimal("saidi_jam", { precision: 8, scale: 3 }),
    saifiKali: decimal("saifi_kali", { precision: 8, scale: 3 }),
  },
  (t) => ({ idx: index("idx_keandalan_wil_tahun").on(t.wilayahId, t.tahun) })
);

export const ruptlHistSpklu = mysqlTable(
  "ruptl_hist_spklu",
  {
    id: int("id").autoincrement().primaryKey(),
    provinsiId: int("provinsi_id").notNull(),
    tahun: int("tahun").notNull(),
    jumlahUnit: int("jumlah_unit"),
    kapasitasKw: decimal("kapasitas_kw", { precision: 10, scale: 2 }),
  },
  (t) => ({ idx: index("idx_spklu_prov_tahun").on(t.provinsiId, t.tahun) })
);

// Modul 3 — Proyeksi Demand Nasional/Wilayah (Bab V.1-V.4)
export const ruptlProyeksiWilayah = mysqlTable(
  "ruptl_proyeksi_wilayah",
  {
    id: int("id").autoincrement().primaryKey(),
    wilayahId: int("wilayah_id"),
    skenario: mysqlEnum("skenario", ["RE_BASE", "ARED"]).notNull(),
    tahun: int("tahun").notNull(),
    salesGwh: decimal("sales_gwh", { precision: 12, scale: 2 }),
    produksiGwh: decimal("produksi_gwh", { precision: 12, scale: 2 }),
    bebanPuncakMw: decimal("beban_puncak_mw", { precision: 12, scale: 2 }),
    pelangganRibu: decimal("pelanggan_ribu", { precision: 12, scale: 2 }),
    pertumbuhanPct: decimal("pertumbuhan_pct", { precision: 5, scale: 2 }),
    konsumsiPerKapitaKwh: decimal("konsumsi_per_kapita_kwh", { precision: 10, scale: 2 }),
  },
  (t) => ({ idx: index("idx_proyeksi_wil_sken_tahun").on(t.wilayahId, t.skenario, t.tahun) })
);

// Modul 4 — Neraca Daya per Sistem Kelistrikan (Bab V.5)
export const ruptlNeracaDaya = mysqlTable(
  "ruptl_neraca_daya",
  {
    id: int("id").autoincrement().primaryKey(),
    sistemId: int("sistem_id").notNull(),
    skenario: mysqlEnum("skenario", ["RE_BASE", "ARED"]).notNull(),
    tahun: int("tahun").notNull(),
    bebanPuncakBrutoMw: decimal("beban_puncak_bruto_mw", { precision: 12, scale: 2 }),
    bebanPuncakNetoMw: decimal("beban_puncak_neto_mw", { precision: 12, scale: 2 }),
    kapasitasTerpasangMw: decimal("kapasitas_terpasang_mw", { precision: 12, scale: 2 }),
    dmnMw: decimal("dmn_mw", { precision: 12, scale: 2 }),
    reserveMarginPct: decimal("reserve_margin_pct", { precision: 6, scale: 2 }),
    produksiGwh: decimal("produksi_gwh", { precision: 12, scale: 2 }),
    penjualanGwh: decimal("penjualan_gwh", { precision: 12, scale: 2 }),
    faktorBebanPct: decimal("faktor_beban_pct", { precision: 6, scale: 2 }),
  },
  (t) => ({ idx: index("idx_neraca_sistem_sken_tahun").on(t.sistemId, t.skenario, t.tahun) })
);

// Modul 5 — Bauran Energi Nasional/Wilayah (Bab V.6)
export const ruptlBauranEnergi = mysqlTable(
  "ruptl_bauran_energi",
  {
    id: int("id").autoincrement().primaryKey(),
    wilayahId: int("wilayah_id"),
    skenario: mysqlEnum("skenario", ["RE_BASE", "ARED", "BAU"]).notNull(),
    tahun: int("tahun").notNull(),
    sumber: mysqlEnum("sumber", [
      "BATUBARA", "GAS", "LNG", "BBM",
      "AIR", "PANAS_BUMI", "BIOMASSA", "SAMPAH", "SURYA", "BAYU", "NUKLIR",
      "IMPOR", "LAINNYA_EBT", "TOTAL"
    ]).notNull(),
    produksiGwh: decimal("produksi_gwh", { precision: 12, scale: 2 }),
    porsiPct: decimal("porsi_pct", { precision: 6, scale: 2 }),
  },
  (t) => ({ idx: index("idx_bauran_wil_sken_tahun").on(t.wilayahId, t.skenario, t.tahun) })
);

// Modul 6 — Emisi GRK Nasional/Wilayah (Bab V.7-V.8)
export const ruptlEmisiGrk = mysqlTable(
  "ruptl_emisi_grk",
  {
    id: int("id").autoincrement().primaryKey(),
    wilayahId: int("wilayah_id"),
    skenario: mysqlEnum("skenario", ["RE_BASE", "ARED", "BAU"]).notNull(),
    tahun: int("tahun").notNull(),
    sumber: mysqlEnum("sumber", ["GAS", "BBM", "BATUBARA", "TOTAL"]).notNull(),
    emisiJutaTco2: decimal("emisi_juta_tco2", { precision: 10, scale: 3 }),
  },
  (t) => ({ idx: index("idx_emisi_wil_sken_tahun").on(t.wilayahId, t.skenario, t.tahun) })
);

// Modul 7 — Rencana Transmisi & GI Nasional/Wilayah per Tegangan (Bab V.9)
// tegangan_kv: '500', '500DC', '275', '150', '70', 'TOTAL'
export const ruptlRencanaTransmisiWilayah = mysqlTable(
  "ruptl_rencana_transmisi_wilayah",
  {
    id: int("id").autoincrement().primaryKey(),
    wilayahId: int("wilayah_id"),
    skenario: mysqlEnum("skenario", ["RE_BASE", "ARED"]).notNull(),
    tahun: int("tahun").notNull(),
    teganganKv: varchar("tegangan_kv", { length: 20 }).notNull(),
    kms: decimal("kms", { precision: 10, scale: 2 }),
  },
  (t) => ({ idx: index("idx_trans_wil_sken_tahun").on(t.wilayahId, t.skenario, t.tahun) })
);

// tegangan: '500/275', '500/150', '500DC', '275/150', '150/20', 'TOTAL'
export const ruptlRencanaGiWilayah = mysqlTable(
  "ruptl_rencana_gi_wilayah",
  {
    id: int("id").autoincrement().primaryKey(),
    wilayahId: int("wilayah_id"),
    skenario: mysqlEnum("skenario", ["RE_BASE", "ARED"]).notNull(),
    tahun: int("tahun").notNull(),
    tegangan: varchar("tegangan", { length: 30 }).notNull(),
    mva: decimal("mva", { precision: 10, scale: 2 }),
  },
  (t) => ({ idx: index("idx_gi_wil_sken_tahun").on(t.wilayahId, t.skenario, t.tahun) })
);

// Modul 9 — Kebutuhan Investasi (Bab VI, Tabel 6.1)
export const ruptlInvestasi = mysqlTable(
  "ruptl_investasi",
  {
    id: int("id").autoincrement().primaryKey(),
    tahun: int("tahun").notNull(),
    kategori: mysqlEnum("kategori", ["IDC", "DISTRIBUSI_LISDES", "TL_GI", "KIT_PLN", "KIT_IPP", "TOTAL"]).notNull(),
    nilaiTriliun: decimal("nilai_triliun", { precision: 10, scale: 3 }),
  },
  (t) => ({ idx: index("idx_investasi_tahun").on(t.tahun) })
);

// Modul 12 — Pipeline Pelanggan Besar (Lampiran E)
// KEK, KI, DPP, SKPT, Smelter, dll.
export const ruptlPipelinePelangganBesar = mysqlTable(
  "ruptl_pipeline_pelanggan_besar",
  {
    id: int("id").autoincrement().primaryKey(),
    wilayahId: int("wilayah_id").notNull(),
    provinsiId: int("provinsi_id"),
    noUrut: int("no_urut"),
    kategori: varchar("kategori", { length: 50 }),
    namaPelanggan: varchar("nama_pelanggan", { length: 200 }).notNull(),
    kebutuhanMva: decimal("kebutuhan_mva", { precision: 10, scale: 2 }),
    rencanaTransmisi: text("rencana_transmisi"),
    rencanaGi: varchar("rencana_gi", { length: 200 }),
    targetTahun: int("target_tahun"),
    skema: varchar("skema", { length: 100 }),
  },
  (t) => ({
    wilayahIdx: index("idx_pipeline_wilayah").on(t.wilayahId),
    provinsiIdx: index("idx_pipeline_provinsi").on(t.provinsiId),
  })
);

// ============================================================
// ARSITEKTUR DOMAIN & MODUL (§4 PRD v2.x)
// ============================================================

export const domains = mysqlTable("domains", {
  id: int("id").autoincrement().primaryKey(),
  slug: varchar("slug", { length: 50 }).notNull().unique(),
  nama: varchar("nama", { length: 150 }).notNull(),
  deskripsi: text("deskripsi"),
  isActive: boolean("is_active").notNull().default(true),
  createdAt: timestamp("created_at").notNull().defaultNow(),
});

export const domainModules = mysqlTable(
  "domain_modules",
  {
    id: int("id").autoincrement().primaryKey(),
    domainId: int("domain_id").notNull(),
    slug: varchar("slug", { length: 50 }).notNull(),
    urlToken: varchar("url_token", { length: 12 }).unique(),
    nama: varchar("nama", { length: 150 }).notNull(),
    routePath: varchar("route_path", { length: 100 }).notNull(),
    sensitivitas: mysqlEnum("sensitivitas", ["publik", "internal", "sensitif"]).notNull().default("internal"),
    status: mysqlEnum("status", ["aktif", "draft", "arsip"]).notNull().default("draft"),
    dataUpdatedAt: timestamp("data_updated_at"),
    createdAt: timestamp("created_at").notNull().defaultNow(),
  },
  (t) => ({
    domainSlugUniq: uniqueIndex("domain_modules_domain_slug_uniq").on(t.domainId, t.slug),
  })
);

export const userDomainAccess = mysqlTable(
  "user_domain_access",
  {
    userId: int("user_id").notNull(),
    domainId: int("domain_id").notNull(),
    accessLevel: mysqlEnum("access_level", ["read", "write", "admin"]).notNull(),
    grantedAt: timestamp("granted_at").notNull().defaultNow(),
    grantedBy: int("granted_by"),
  },
  (t) => ({
    pk: primaryKey({ columns: [t.userId, t.domainId] }),
  })
);

// Akses per-modul (lebih granular dari userDomainAccess).
// Jika user punya entri di sini, hanya modul yang terdaftar yang ditampilkan
// dalam domain tersebut. Admin selalu bypass tabel ini.
export const userModuleAccess = mysqlTable(
  "user_module_access",
  {
    userId:    int("user_id").notNull(),
    moduleId:  int("module_id").notNull(),
    grantedAt: timestamp("granted_at").notNull().defaultNow(),
    grantedBy: int("granted_by"),
  },
  (t) => ({
    pk: primaryKey({ columns: [t.userId, t.moduleId] }),
    userIdx: index("uma_user_idx").on(t.userId),
  })
);

// ============================================================
// TARIFF ADJUSTMENT (Penetapan Penyesuaian Tarif per Kuartal)
// ============================================================

export const tariffPeriods = mysqlTable("tariff_periods", {
  id:          int("id").autoincrement().primaryKey(),
  period:      varchar("period", { length: 20 }).notNull(),       // "Q3-2026"
  periodLabel: varchar("period_label", { length: 100 }).notNull(), // "Juli - September 2026"
  effectiveDate: date("effective_date").notNull(),                 // 2026-07-01
  signedBy:    varchar("signed_by", { length: 150 }),
  isCurrent:   boolean("is_current").notNull().default(false),
  createdAt:   timestamp("created_at").notNull().defaultNow(),
});

export const tariffRates = mysqlTable("tariff_rates", {
  id:          int("id").autoincrement().primaryKey(),
  periodId:    int("period_id").notNull(),
  no:          int("no").notNull(),
  golongan:    varchar("golongan", { length: 30 }).notNull(),   // "R-1/TR"
  kategori:    mysqlEnum("kategori", ["R", "B", "I", "P", "L"]).notNull(),
  batasDaya:   varchar("batas_daya", { length: 80 }),           // "900 VA-RTM"
  rmType:      varchar("rm_type", { length: 5 }),               // "RM1", "RM2", "RM3", null = tidak ada RM
  // Tarif flat (WBP = LWBP, tanpa multiplier) — untuk golongan sederhana
  tarifFlat:   decimal("tarif_flat", { precision: 10, scale: 2 }),
  // Tarif WBP/LWBP — untuk golongan dengan pembeda waktu pemakaian
  tarifWbp:    decimal("tarif_wbp",  { precision: 10, scale: 2 }),
  tarifLwbp:   decimal("tarif_lwbp", { precision: 10, scale: 2 }),
  tarifKvarh:  decimal("tarif_kvarh",{ precision: 10, scale: 2 }),
  multiplierWbp:   varchar("multiplier_wbp",   { length: 5 }),  // "K", "N", atau null
  multiplierKvarh: varchar("multiplier_kvarh", { length: 5 }),  // "K", "N", atau null
  // Prabayar
  tarifPrabayar: decimal("tarif_prabayar", { precision: 10, scale: 2 }),
});

export const olapAmrTagihan = mysqlTable(
  "olap_amr_tagihan",
  {
    id:            int("id").autoincrement().primaryKey(),
    thblrek:       char("thblrek", { length: 6 }).notNull(),
    unitap:        varchar("unitap", { length: 10 }).notNull(),
    unitapNama:    varchar("unitap_nama", { length: 50 }).notNull(),
    unitup:        varchar("unitup", { length: 10 }).notNull(),
    tarif:         varchar("tarif", { length: 10 }).notNull(),
    tarifGrup:     varchar("tarif_grup", { length: 20 }).notNull(),
    jmlPelanggan:  int("jml_pelanggan").notNull().default(0),
    kwhTotal:      decimal("kwh_total", { precision: 18, scale: 3 }).notNull().default("0"),
    kwhLwbp:       decimal("kwh_lwbp",  { precision: 18, scale: 3 }).notNull().default("0"),
    kwhWbp:        decimal("kwh_wbp",   { precision: 18, scale: 3 }).notNull().default("0"),
    rpPtl:         bigint("rp_ptl",   { mode: "number" }).notNull().default(0),
    rpPpj:         bigint("rp_ppj",   { mode: "number" }).notNull().default(0),
    rpTotal:       bigint("rp_total", { mode: "number" }).notNull().default(0),
    createdAt:     timestamp("created_at").notNull().defaultNow(),
  },
  (t) => ({
    ukOlapAmr: uniqueIndex("uk_olap_amr").on(t.thblrek, t.unitap, t.unitup, t.tarif),
    idxPeriod:  index("idx_olap_amr_period").on(t.thblrek),
    idxUnitap:  index("idx_olap_amr_unitap").on(t.unitap),
  })
);

export const plnScholar = mysqlTable(
  "pln_scholar",
  {
    id:        int("id").autoincrement().primaryKey(),
    entity:    varchar("entity",   { length: 50  }).notNull(),
    unit:      varchar("unit",     { length: 50  }).notNull().default(""),
    bidang:    varchar("bidang",   { length: 20  }).notNull().default(""),
    docType:   varchar("doc_type", { length: 30  }).notNull().default(""),
    year:      int("year"),
    docCode:   varchar("doc_code", { length: 50  }).notNull().default(""),
    title:     varchar("title",    { length: 500 }).notNull(),
    filename:  varchar("filename", { length: 500 }).notNull(),
    createdAt: timestamp("created_at").notNull().defaultNow(),
  },
  (t) => ({
    idxEntity: index("idx_scholar_entity").on(t.entity),
    idxYear:   index("idx_scholar_year").on(t.year),
    idxBidang: index("idx_scholar_bidang").on(t.bidang),
  })
);

// ============================================================
// PLN STATISTICS NATIONAL (2014-2025)
// ============================================================
export const plnStatNational = mysqlTable(
  "pln_stat_national",
  {
    id:   int("id").autoincrement().primaryKey(),
    year: int("year").notNull(),

    installedCapacityPlnMw:   decimal("installed_capacity_pln_mw",   { precision: 12, scale: 2 }),
    installedCapacityTotalMw: decimal("installed_capacity_total_mw", { precision: 12, scale: 2 }),
    ratedCapacityPlnMw:       decimal("rated_capacity_pln_mw",       { precision: 12, scale: 2 }),
    peakLoadMw:               decimal("peak_load_mw",                { precision: 12, scale: 2 }),
    plantsTotal:              int("plants_total"),
    loadFactorPct:            decimal("load_factor_pct",             { precision: 6, scale: 2 }),
    capacityFactorPct:        decimal("capacity_factor_pct",         { precision: 6, scale: 2 }),
    demandFactorPct:          decimal("demand_factor_pct",           { precision: 6, scale: 2 }),

    prodHydroGwh:      decimal("prod_hydro_gwh",      { precision: 12, scale: 2 }),
    prodSteamGwh:      decimal("prod_steam_gwh",      { precision: 12, scale: 2 }),
    prodGasGwh:        decimal("prod_gas_gwh",        { precision: 12, scale: 2 }),
    prodGeoGwh:        decimal("prod_geo_gwh",        { precision: 12, scale: 2 }),
    prodDieselGwh:     decimal("prod_diesel_gwh",     { precision: 12, scale: 2 }),
    prodRenewableGwh:  decimal("prod_renewable_gwh",  { precision: 12, scale: 2 }),
    prodLeasedGwh:     decimal("prod_leased_gwh",     { precision: 12, scale: 2 }),
    prodPlnOwnGwh:     decimal("prod_pln_own_gwh",    { precision: 12, scale: 2 }),
    prodPurchasedGwh:  decimal("prod_purchased_gwh",  { precision: 12, scale: 2 }),
    prodTotalGwh:      decimal("prod_total_gwh",      { precision: 12, scale: 2 }),

    ownUseGwh:              decimal("own_use_gwh",              { precision: 10, scale: 2 }),
    ownUsePct:              decimal("own_use_pct",              { precision: 5, scale: 2 }),
    lossTransmissionGwh:    decimal("loss_transmission_gwh",    { precision: 10, scale: 2 }),
    lossTransmissionPct:    decimal("loss_transmission_pct",    { precision: 5, scale: 2 }),
    lossDistributionGwh:    decimal("loss_distribution_gwh",    { precision: 10, scale: 2 }),
    lossDistributionPct:    decimal("loss_distribution_pct",    { precision: 5, scale: 2 }),
    lossTotalGwh:           decimal("loss_total_gwh",           { precision: 10, scale: 2 }),
    lossTotalPct:           decimal("loss_total_pct",           { precision: 5, scale: 2 }),

    custHousehold: bigint("cust_household", { mode: "number" }),
    custIndustry:  int("cust_industry"),
    custBusiness:  int("cust_business"),
    custSocial:    int("cust_social"),
    custGov:       int("cust_gov"),
    custStreet:    int("cust_street"),
    custOthers:    int("cust_others"),
    custTotal:     bigint("cust_total", { mode: "number" }),

    connHouseholdMva: decimal("conn_household_mva", { precision: 12, scale: 2 }),
    connIndustryMva:  decimal("conn_industry_mva",  { precision: 12, scale: 2 }),
    connBusinessMva:  decimal("conn_business_mva",  { precision: 12, scale: 2 }),
    connTotalMva:     decimal("conn_total_mva",     { precision: 12, scale: 2 }),

    soldHouseholdGwh: decimal("sold_household_gwh", { precision: 12, scale: 2 }),
    soldIndustryGwh:  decimal("sold_industry_gwh",  { precision: 12, scale: 2 }),
    soldBusinessGwh:  decimal("sold_business_gwh",  { precision: 12, scale: 2 }),
    soldSocialGwh:    decimal("sold_social_gwh",    { precision: 12, scale: 2 }),
    soldGovGwh:       decimal("sold_gov_gwh",       { precision: 12, scale: 2 }),
    soldStreetGwh:    decimal("sold_street_gwh",    { precision: 12, scale: 2 }),
    soldOthersGwh:    decimal("sold_others_gwh",    { precision: 12, scale: 2 }),
    soldTotalGwh:     decimal("sold_total_gwh",     { precision: 12, scale: 2 }),

    revHouseholdMrp: decimal("rev_household_mrp", { precision: 18, scale: 2 }),
    revIndustryMrp:  decimal("rev_industry_mrp",  { precision: 18, scale: 2 }),
    revBusinessMrp:  decimal("rev_business_mrp",  { precision: 18, scale: 2 }),
    revTotalMrp:     decimal("rev_total_mrp",     { precision: 18, scale: 2 }),

    tariffAvgRpKwh:       decimal("tariff_avg_rp_kwh",       { precision: 10, scale: 2 }),
    tariffHouseholdRpKwh: decimal("tariff_household_rp_kwh", { precision: 10, scale: 2 }),
    tariffIndustryRpKwh:  decimal("tariff_industry_rp_kwh",  { precision: 10, scale: 2 }),
    tariffBusinessRpKwh:  decimal("tariff_business_rp_kwh",  { precision: 10, scale: 2 }),

    electrificationRatioPct: decimal("electrification_ratio_pct", { precision: 5, scale: 2 }),

    fuelCoalTon:    bigint("fuel_coal_ton",  { mode: "number" }),
    fuelGasMmscf:   decimal("fuel_gas_mmscf", { precision: 12, scale: 2 }),

    createdAt: timestamp("created_at").notNull().defaultNow(),
  },
  (t) => ({
    ukYear: uniqueIndex("uk_pln_stat_year").on(t.year),
  })
);

export const datasetSources = mysqlTable("dataset_sources", {
  id: int("id").autoincrement().primaryKey(),
  domainModuleId: int("domain_module_id").notNull(),
  namaSumber: varchar("nama_sumber", { length: 255 }).notNull(),
  jenisSumber: varchar("jenis_sumber", { length: 100 }),
  urlAtauReferensi: text("url_atau_referensi"),
  tanggalAkses: date("tanggal_akses"),
  catatanMetodologi: text("catatan_metodologi"),
  createdAt: timestamp("created_at").notNull().defaultNow(),
});

// ============================================================
// PENGGANTIAN kWh METER (Energi Jawa Barat)
// ============================================================

export const gantiMeterHarian = mysqlTable(
  "ganti_meter_harian",
  {
    id:                int("id").autoincrement().primaryKey(),
    tgl:               date("tgl").notNull(),
    unitap:            varchar("unitap", { length: 10 }).notNull(),
    jumlah:            int("jumlah").notNull().default(0),
    jumlahPrabayar:    int("jumlah_prabayar").notNull().default(0),
    jumlahPascabayar:  int("jumlah_pascabayar").notNull().default(0),
  },
  (t) => ({
    ukGmh: uniqueIndex("uk_gmh").on(t.tgl, t.unitap),
    idxTgl: index("idx_gmh_tgl").on(t.tgl),
  })
);

export const gantiMeterAlasan = mysqlTable(
  "ganti_meter_alasan",
  {
    id:         int("id").autoincrement().primaryKey(),
    bulan:      char("bulan", { length: 6 }).notNull(),
    unitap:     varchar("unitap", { length: 10 }).notNull(),
    alasan:     varchar("alasan", { length: 200 }).notNull(),
    alasanGrup: varchar("alasan_grup", { length: 50 }).notNull().default("Lainnya"),
    jumlah:     int("jumlah").notNull().default(0),
  },
  (t) => ({
    idxBulan: index("idx_gma_bulan").on(t.bulan),
    idxGrup:  index("idx_gma_grup").on(t.alasanGrup),
  })
);

export const gantiMeterMerk = mysqlTable(
  "ganti_meter_merk",
  {
    id:       int("id").autoincrement().primaryKey(),
    bulan:    char("bulan", { length: 6 }).notNull(),
    merkLama: varchar("merk_lama", { length: 50 }).notNull().default(""),
    merkBaru: varchar("merk_baru", { length: 50 }).notNull().default(""),
    jumlah:   int("jumlah").notNull().default(0),
  },
  (t) => ({
    idxBulan: index("idx_gmm_bulan").on(t.bulan),
  })
);

export const gantiMeterUmur = mysqlTable(
  "ganti_meter_umur",
  {
    id:         int("id").autoincrement().primaryKey(),
    bulan:      char("bulan", { length: 6 }).notNull(),
    thbuatLama: varchar("thbuat_lama", { length: 4 }).notNull(),
    jumlah:     int("jumlah").notNull().default(0),
  },
  (t) => ({
    idxBulan: index("idx_gmu_bulan").on(t.bulan),
  })
);

// ============================================================
// RISET & AKADEMIK — Literature Map
// ============================================================

export const literatureItems = mysqlTable(
  "literature_items",
  {
    id:        int("id").autoincrement().primaryKey(),
    zoteroKey: varchar("zotero_key", { length: 32 }),
    title:     text("title").notNull(),
    authors:   varchar("authors", { length: 500 }),
    year:      int("year"),
    journal:   varchar("journal", { length: 300 }),
    doi:       varchar("doi", { length: 200 }),
    themes:    text("themes").default("[]"),        // JSON string array
    status:    varchar("status", { length: 20 }).notNull().default("belum"),
    relevance: int("relevance").notNull().default(3),
    citedIn:   text("cited_in").default("[]"),      // JSON int array of chapter numbers
    notes:     text("notes"),
    createdAt: timestamp("created_at").defaultNow().notNull(),
    updatedAt: timestamp("updated_at").defaultNow().notNull(),
  },
  (t) => ({
    zoteroKeyIdx: uniqueIndex("lit_zotero_key_idx").on(t.zoteroKey),
  })
);

export const literatureConfig = mysqlTable("literature_config", {
  id:    int("id").autoincrement().primaryKey(),
  key:   varchar("key", { length: 50 }).notNull().unique(),
  value: text("value"),
});

export const myWorks = mysqlTable("my_works", {
  id:        int("id").autoincrement().primaryKey(),
  slug:      varchar("slug", { length: 100 }).notNull().unique(),
  title:     text("title").notNull(),
  type:      varchar("type", { length: 20 }).notNull().default("dissertation"),
  year:      int("year"),
  structure: text("structure").default("[]"),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

export const literatureCitations = mysqlTable(
  "literature_citations",
  {
    id:       int("id").autoincrement().primaryKey(),
    litId:    int("lit_id").notNull(),
    workSlug: varchar("work_slug", { length: 100 }).notNull(),
    section:  varchar("section", { length: 100 }).notNull().default(""),
    createdAt: timestamp("created_at").defaultNow().notNull(),
  },
  (t) => ({
    litWorkSectionIdx: uniqueIndex("lit_work_section_idx").on(t.litId, t.workSlug, t.section),
  })
);
