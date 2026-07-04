import { randomBytes, createHash, timingSafeEqual } from "node:crypto";
import { eq, lt } from "drizzle-orm";
import { db } from "../db/client.js";
import { sessions, type User } from "../db/schema.js";

const SESSION_DURATION_MS =
  Number(process.env.SESSION_DURATION_HOURS ?? 12) * 60 * 60 * 1000;

/**
 * Kenapa token di-hash sebelum disimpan?
 *
 * Cookie browser pengguna berisi TOKEN ASLI (random, tidak bisa ditebak).
 * Yang kita simpan di database bukan token itu, tapi SHA-256 hash-nya.
 *
 * Efeknya: kalau suatu saat database bocor (dump SQL dicuri, backup salah
 * konfigurasi permission, dll), isi tabel `sessions` TIDAK BISA dipakai
 * langsung untuk membajak akun pengguna — karena hash tidak reversible.
 * Penyerang butuh token asli, yang cuma pernah ada di cookie browser.
 *
 * Ini pola yang sama dipakai library auth modern (mis. Lucia Auth).
 */
function hashToken(token: string): string {
  return createHash("sha256").update(token).digest("hex");
}

function generateToken(): string {
  return randomBytes(32).toString("base64url");
}

export interface CreateSessionInput {
  userId: number;
  ipAddress?: string;
  userAgent?: string;
}

/**
 * Buat sesi baru. Mengembalikan token ASLI — inilah yang dikirim ke
 * browser sebagai cookie httpOnly. Setelah ini, token asli tidak pernah
 * disimpan di server dalam bentuk apapun.
 */
export async function createSession(input: CreateSessionInput): Promise<string> {
  const token = generateToken();
  const id = hashToken(token);
  const expiresAt = new Date(Date.now() + SESSION_DURATION_MS);

  await db.insert(sessions).values({
    id,
    userId: input.userId,
    ipAddress: input.ipAddress,
    userAgent: input.userAgent?.slice(0, 255),
    expiresAt,
  });

  return token;
}

/**
 * Validasi token dari cookie. Mengembalikan userId kalau valid & belum
 * kedaluwarsa, null kalau tidak.
 */
export async function validateSessionToken(token: string): Promise<number | null> {
  if (!token) return null;

  const id = hashToken(token);
  const [session] = await db.select().from(sessions).where(eq(sessions.id, id)).limit(1);

  if (!session) return null;

  if (session.expiresAt.getTime() < Date.now()) {
    // Sesi sudah expired — bersihkan sekalian.
    await db.delete(sessions).where(eq(sessions.id, id));
    return null;
  }

  return session.userId;
}

export async function destroySession(token: string): Promise<void> {
  const id = hashToken(token);
  await db.delete(sessions).where(eq(sessions.id, id));
}

/** Panggil ini secara berkala (mis. cron harian) untuk beresin sesi yang sudah expired. */
export async function pruneExpiredSessions(): Promise<number> {
  const result = await db.delete(sessions).where(lt(sessions.expiresAt, new Date()));
  return result[0].affectedRows;
}

/**
 * Bandingkan dua string dengan waktu konstan — mencegah timing attack
 * pada perbandingan token/secret. Dipakai di tempat yang relevan
 * (mis. validasi CSRF token).
 */
export function safeCompare(a: string, b: string): boolean {
  const bufA = Buffer.from(a);
  const bufB = Buffer.from(b);
  if (bufA.length !== bufB.length) return false;
  return timingSafeEqual(bufA, bufB);
}

export const SESSION_COOKIE_NAME = "cockpit_session";

export function sessionCookieOptions() {
  return {
    httpOnly: true,
    secure: process.env.COOKIE_SECURE === "true",
    sameSite: "lax" as const,
    domain: process.env.COOKIE_DOMAIN || undefined,
    path: "/",
    maxAge: SESSION_DURATION_MS / 1000,
  };
}

export type { User };
