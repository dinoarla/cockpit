import { mysqlTable, varchar, int, decimal, timestamp, boolean, mysqlEnum, index, text, date, primaryKey, uniqueIndex, } from "drizzle-orm/mysql-core";
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
export const sessions = mysqlTable("sessions", {
    id: varchar("id", { length: 64 }).primaryKey(), // SHA-256 hex dari token
    userId: int("user_id").notNull(),
    userAgent: varchar("user_agent", { length: 255 }),
    ipAddress: varchar("ip_address", { length: 45 }), // cukup untuk IPv6
    createdAt: timestamp("created_at").notNull().defaultNow(),
    expiresAt: timestamp("expires_at").notNull(),
}, (table) => ({
    userIdIdx: index("sessions_user_id_idx").on(table.userId),
    expiresAtIdx: index("sessions_expires_at_idx").on(table.expiresAt),
}));
/**
 * Audit log percobaan login (sukses maupun gagal).
 * Berguna untuk investigasi kalau ada aktivitas mencurigakan.
 */
export const loginAudit = mysqlTable("login_audit", {
    id: int("id").autoincrement().primaryKey(),
    username: varchar("username", { length: 64 }).notNull(),
    success: boolean("success").notNull(),
    ipAddress: varchar("ip_address", { length: 45 }),
    userAgent: varchar("user_agent", { length: 255 }),
    reason: varchar("reason", { length: 100 }), // mis. "invalid_password", "account_locked", "ok"
    createdAt: timestamp("created_at").notNull().defaultNow(),
}, (table) => ({
    usernameIdx: index("login_audit_username_idx").on(table.username),
    createdAtIdx: index("login_audit_created_at_idx").on(table.createdAt),
}));
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
export const ruptlPenjualanHistoris = mysqlTable("ruptl_penjualan_historis", {
    id: int("id").autoincrement().primaryKey(),
    provinsiId: int("provinsi_id").notNull(),
    tahun: int("tahun").notNull(),
    sektor: mysqlEnum("sektor", ["RUMAH_TANGGA", "BISNIS", "PUBLIK", "INDUSTRI"]).notNull(),
    gwh: decimal("gwh", { precision: 10, scale: 2 }),
}, (t) => ({ provTahunIdx: index("penjualan_prov_tahun_idx").on(t.provinsiId, t.tahun) }));
export const ruptlPelangganHistoris = mysqlTable("ruptl_pelanggan_historis", {
    id: int("id").autoincrement().primaryKey(),
    provinsiId: int("provinsi_id").notNull(),
    tahun: int("tahun").notNull(),
    sektor: mysqlEnum("sektor", ["RUMAH_TANGGA", "BISNIS", "PUBLIK", "INDUSTRI"]).notNull(),
    jumlahRibu: decimal("jumlah_ribu", { precision: 10, scale: 2 }),
}, (t) => ({ provTahunIdx: index("pelanggan_prov_tahun_idx").on(t.provinsiId, t.tahun) }));
export const ruptlProyeksiKebutuhan = mysqlTable("ruptl_proyeksi_kebutuhan", {
    id: int("id").autoincrement().primaryKey(),
    provinsiId: int("provinsi_id").notNull(),
    tahun: int("tahun").notNull(),
    pertumbuhanEkonomiPct: decimal("pertumbuhan_ekonomi_pct", { precision: 5, scale: 2 }),
    salesGwh: decimal("sales_gwh", { precision: 10, scale: 2 }),
    produksiGwh: decimal("produksi_gwh", { precision: 10, scale: 2 }),
    bebanPuncakMw: decimal("beban_puncak_mw", { precision: 10, scale: 2 }),
    pelanggan: int("pelanggan"),
}, (t) => ({ provTahunIdx: index("proyeksi_prov_tahun_idx").on(t.provinsiId, t.tahun) }));
export const ruptlPembangkitEksisting = mysqlTable("ruptl_pembangkit_eksisting", {
    id: int("id").autoincrement().primaryKey(),
    provinsiId: int("provinsi_id").notNull(),
    pemilik: mysqlEnum("pemilik", ["PLN", "IPP"]).notNull().default("PLN"),
    jenis: varchar("jenis", { length: 20 }).notNull(),
    sistemTenagaListrik: varchar("sistem_tenaga_listrik", { length: 50 }),
    jumlahUnit: int("jumlah_unit"),
    kapasitasMw: decimal("kapasitas_mw", { precision: 10, scale: 2 }),
    dayaMambuMw: decimal("daya_mampu_mw", { precision: 10, scale: 2 }),
    dmpMw: decimal("dmp_mw", { precision: 10, scale: 2 }),
}, (t) => ({ provIdx: index("pembangkit_eks_prov_idx").on(t.provinsiId) }));
export const ruptlRencanaPembangkit = mysqlTable("ruptl_rencana_pembangkit", {
    id: int("id").autoincrement().primaryKey(),
    provinsiId: int("provinsi_id").notNull(),
    skenario: mysqlEnum("skenario", ["RE_BASE", "ARED"]).notNull(),
    jenis: varchar("jenis", { length: 30 }).notNull(),
    nama: varchar("nama", { length: 200 }),
    kapasitasMw: decimal("kapasitas_mw", { precision: 10, scale: 2 }),
    codTahun: int("cod_tahun"),
    keterangan: varchar("keterangan", { length: 500 }),
}, (t) => ({
    provSkenIdx: index("rencana_prov_sken_idx").on(t.provinsiId, t.skenario),
    codIdx: index("rencana_cod_idx").on(t.codTahun),
}));
export const ruptlRencanaTransmisi = mysqlTable("ruptl_rencana_transmisi", {
    id: int("id").autoincrement().primaryKey(),
    provinsiId: int("provinsi_id").notNull(),
    skenario: mysqlEnum("skenario", ["RE_BASE", "ARED"]).notNull(),
    tahun: int("tahun").notNull(),
    kms: decimal("kms", { precision: 10, scale: 2 }),
}, (t) => ({ provSkenTahunIdx: index("transmisi_prov_sken_tahun_idx").on(t.provinsiId, t.skenario, t.tahun) }));
export const ruptlRencanaGarduInduk = mysqlTable("ruptl_rencana_gardu_induk", {
    id: int("id").autoincrement().primaryKey(),
    provinsiId: int("provinsi_id").notNull(),
    skenario: mysqlEnum("skenario", ["RE_BASE", "ARED"]).notNull(),
    tahun: int("tahun").notNull(),
    mva: decimal("mva", { precision: 10, scale: 2 }),
}, (t) => ({ provSkenTahunIdx: index("gi_prov_sken_tahun_idx").on(t.provinsiId, t.skenario, t.tahun) }));
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
export const domainModules = mysqlTable("domain_modules", {
    id: int("id").autoincrement().primaryKey(),
    domainId: int("domain_id").notNull(),
    slug: varchar("slug", { length: 50 }).notNull(),
    nama: varchar("nama", { length: 150 }).notNull(),
    routePath: varchar("route_path", { length: 100 }).notNull(),
    sensitivitas: mysqlEnum("sensitivitas", ["publik", "internal", "sensitif"]).notNull().default("internal"),
    status: mysqlEnum("status", ["aktif", "draft", "arsip"]).notNull().default("draft"),
    createdAt: timestamp("created_at").notNull().defaultNow(),
}, (t) => ({
    domainSlugUniq: uniqueIndex("domain_modules_domain_slug_uniq").on(t.domainId, t.slug),
}));
export const userDomainAccess = mysqlTable("user_domain_access", {
    userId: int("user_id").notNull(),
    domainId: int("domain_id").notNull(),
    accessLevel: mysqlEnum("access_level", ["read", "write", "admin"]).notNull(),
    grantedAt: timestamp("granted_at").notNull().defaultNow(),
    grantedBy: int("granted_by"),
}, (t) => ({
    pk: primaryKey({ columns: [t.userId, t.domainId] }),
}));
// Akses per-modul (lebih granular dari userDomainAccess).
// Jika user punya entri di sini, hanya modul yang terdaftar yang ditampilkan
// dalam domain tersebut. Admin selalu bypass tabel ini.
export const userModuleAccess = mysqlTable("user_module_access", {
    userId: int("user_id").notNull(),
    moduleId: int("module_id").notNull(),
    grantedAt: timestamp("granted_at").notNull().defaultNow(),
    grantedBy: int("granted_by"),
}, (t) => ({
    pk: primaryKey({ columns: [t.userId, t.moduleId] }),
    userIdx: index("uma_user_idx").on(t.userId),
}));
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
//# sourceMappingURL=schema.js.map