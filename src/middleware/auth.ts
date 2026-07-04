import type { Context, Next } from "hono";
import { getCookie } from "hono/cookie";
import { eq, and } from "drizzle-orm";
import { db } from "../db/client.js";
import { users, domains, userDomainAccess, type User } from "../db/schema.js";
import { validateSessionToken, SESSION_COOKIE_NAME } from "../auth/session.js";

// Menyimpan user yang sedang login di context, supaya route handler
// berikutnya tinggal ambil dari `c.get("user")` tanpa query ulang.
declare module "hono" {
  interface ContextVariableMap {
    user: User;
  }
}

/**
 * Middleware ini menolak request yang tidak punya sesi valid.
 * Pasang di semua route yang butuh login (lihat contoh di src/routes/mdp.ts).
 */
export async function requireAuth(c: Context, next: Next) {
  const token = getCookie(c, SESSION_COOKIE_NAME);

  if (!token) {
    return c.json({ error: "Belum login." }, 401);
  }

  const userId = await validateSessionToken(token);
  if (!userId) {
    return c.json({ error: "Sesi tidak valid atau sudah kedaluwarsa." }, 401);
  }

  const [user] = await db.select().from(users).where(eq(users.id, userId)).limit(1);
  if (!user || !user.isActive) {
    return c.json({ error: "Akun tidak aktif." }, 401);
  }

  c.set("user", user);
  return next();
}

/**
 * Middleware tambahan untuk membatasi akses berdasarkan role.
 * Contoh pakai: requireRole("admin") di depan route yang cuma boleh admin.
 * Pasang SETELAH requireAuth.
 */
export function requireRole(...allowedRoles: Array<User["role"]>) {
  return async (c: Context, next: Next) => {
    const user = c.get("user");
    if (!allowedRoles.includes(user.role)) {
      return c.json({ error: "Tidak punya akses ke resource ini." }, 403);
    }
    return next();
  };
}

/**
 * Middleware akses per-domain (§4.2 PRD).
 * Admin selalu lolos. Non-admin harus punya entri di user_domain_access.
 * Pasang SETELAH requireAuth.
 */
export function requireDomainAccess(domainSlug: string) {
  return async (c: Context, next: Next) => {
    const user = c.get("user");
    if (user.role === "admin") return next();

    const [domain] = await db
      .select()
      .from(domains)
      .where(eq(domains.slug, domainSlug))
      .limit(1);
    if (!domain) return c.json({ error: "Domain tidak ditemukan." }, 404);

    const [access] = await db
      .select()
      .from(userDomainAccess)
      .where(and(eq(userDomainAccess.userId, user.id), eq(userDomainAccess.domainId, domain.id)))
      .limit(1);

    if (!access) return c.json({ error: "Tidak punya akses ke domain ini." }, 403);
    return next();
  };
}

/** Header keamanan dasar — dipasang global di src/index.ts. */
export async function securityHeaders(c: Context, next: Next) {
  await next();
  c.header("X-Content-Type-Options", "nosniff");
  c.header("X-Frame-Options", "DENY");
  c.header("Referrer-Policy", "strict-origin-when-cross-origin");
  c.header(
    "Content-Security-Policy",
    [
      "default-src 'self'",
      "script-src 'self' https://cdn.jsdelivr.net",
      "style-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net https://fonts.googleapis.com",
      "font-src 'self' https://fonts.gstatic.com",
      "img-src 'self' data: https://*.basemaps.cartocdn.com",
      "connect-src 'self'",
    ].join("; ")
  );
  c.header("Permissions-Policy", "geolocation=(), microphone=(), camera=()");
  if (process.env.COOKIE_SECURE === "true") {
    c.header("Strict-Transport-Security", "max-age=63072000; includeSubDomains");
  }
}
