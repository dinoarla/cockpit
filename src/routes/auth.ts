import { Hono } from "hono";
import { getCookie, setCookie, deleteCookie } from "hono/cookie";
import { eq } from "drizzle-orm";
import { db } from "../db/client.js";
import { users } from "../db/schema.js";
import { verifyPassword } from "../auth/password.js";
import {
  createSession,
  destroySession,
  SESSION_COOKIE_NAME,
  sessionCookieOptions,
} from "../auth/session.js";
import {
  isAccountLocked,
  recordFailedLogin,
  resetFailedLogins,
  logLoginAttempt,
} from "../auth/rateLimiter.js";
import { CSRF_COOKIE_NAME, generateCsrfToken, verifyCsrfToken } from "../auth/csrf.js";
import { requireAuth } from "../middleware/auth.js";

export const authRoutes = new Hono();

/** Dipanggil frontend saat halaman login dimuat, untuk ambil CSRF token. */
authRoutes.get("/csrf-token", (c) => {
  const token = generateCsrfToken();
  setCookie(c, CSRF_COOKIE_NAME, token, {
    httpOnly: false, // sengaja bisa dibaca JS, ini bagian dari pola double-submit
    secure: process.env.COOKIE_SECURE === "true",
    sameSite: "lax",
    path: "/",
    maxAge: 600, // 10 menit, cukup untuk isi form login
  });
  return c.json({ csrfToken: token });
});

authRoutes.post("/login", async (c) => {
  const ip = c.req.header("x-forwarded-for") ?? "unknown";
  const userAgent = c.req.header("user-agent");

  const body = await c.req.json<{ username: string; password: string; csrfToken: string }>();
  const { username, password, csrfToken } = body;

  const csrfCookie = getCookie(c, CSRF_COOKIE_NAME);
  if (!verifyCsrfToken(csrfCookie, csrfToken)) {
    return c.json({ error: "Sesi form tidak valid, silakan muat ulang halaman." }, 403);
  }

  if (!username || !password) {
    return c.json({ error: "Username dan password wajib diisi." }, 400);
  }

  const [user] = await db.select().from(users).where(eq(users.username, username)).limit(1);

  if (!user) {
    // Tetap jalankan verifyPassword dengan hash dummy supaya waktu respons
    // konsisten antara "user tidak ada" dan "password salah" — mencegah
    // penyerang menebak username valid lewat timing attack.
    await verifyPassword(
      "$argon2id$v=19$m=19456,t=2,p=1$AAAAAAAAAAAAAAAAAAAAAA$AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
      password
    );
    await logLoginAttempt({ username, success: false, ipAddress: ip, userAgent, reason: "user_not_found" });
    return c.json({ error: "Username atau password salah." }, 401);
  }

  if (!user.isActive) {
    await logLoginAttempt({ username, success: false, ipAddress: ip, userAgent, reason: "inactive" });
    return c.json({ error: "Akun tidak aktif. Hubungi admin." }, 403);
  }

  if (await isAccountLocked(user.id)) {
    await logLoginAttempt({ username, success: false, ipAddress: ip, userAgent, reason: "locked" });
    return c.json(
      { error: "Akun terkunci sementara karena terlalu banyak percobaan gagal. Coba lagi nanti." },
      423
    );
  }

  const valid = await verifyPassword(user.passwordHash, password);

  if (!valid) {
    await recordFailedLogin(user.id);
    await logLoginAttempt({ username, success: false, ipAddress: ip, userAgent, reason: "wrong_password" });
    return c.json({ error: "Username atau password salah." }, 401);
  }

  await resetFailedLogins(user.id);
  await logLoginAttempt({ username, success: true, ipAddress: ip, userAgent, reason: "ok" });

  const token = await createSession({ userId: user.id, ipAddress: ip, userAgent });
  setCookie(c, SESSION_COOKIE_NAME, token, sessionCookieOptions());

  return c.json({
    ok: true,
    user: { id: user.id, username: user.username, role: user.role },
  });
});

authRoutes.post("/logout", requireAuth, async (c) => {
  const token = getCookie(c, SESSION_COOKIE_NAME);
  if (token) {
    await destroySession(token);
  }
  deleteCookie(c, SESSION_COOKIE_NAME, { path: "/" });
  return c.json({ ok: true });
});

/** Dipakai frontend untuk cek "aku login sebagai siapa" saat buka menu.html. */
authRoutes.get("/me", requireAuth, (c) => {
  const user = c.get("user");
  return c.json({ id: user.id, username: user.username, role: user.role });
});
