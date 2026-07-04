import {
  mysqlTable,
  varchar,
  int,
  timestamp,
  boolean,
  mysqlEnum,
  index,
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
