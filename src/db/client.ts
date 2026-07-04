import "dotenv/config";
import mysql from "mysql2/promise";
import { drizzle } from "drizzle-orm/mysql2";
import * as schema from "./schema.js";

function requireEnv(name: string): string {
  const value = process.env[name];
  if (!value) {
    throw new Error(
      `Environment variable ${name} belum di-set. Cek file .env kamu (salin dari .env.example).`
    );
  }
  return value;
}

// Connection pool — jangan buat koneksi baru per-request, mahal & bisa
// menghabiskan slot koneksi MySQL di hosting shared.
export const pool = mysql.createPool({
  host: requireEnv("DB_HOST"),
  port: Number(process.env.DB_PORT ?? 3306),
  user: requireEnv("DB_USER"),
  password: requireEnv("DB_PASSWORD"),
  database: requireEnv("DB_NAME"),
  waitForConnections: true,
  connectionLimit: 10,
  maxIdle: 5,
  idleTimeout: 60_000,
  queueLimit: 0,
  // Wajib true kalau provider hosting MySQL kamu butuh SSL (banyak yang butuh).
  // Kalau MySQL-nya di server yang sama (localhost), biasanya bisa false.
  ssl: process.env.DB_SSL === "true" ? { rejectUnauthorized: true } : undefined,
});

export const db = drizzle(pool, { schema, mode: "default" });
