import { eq } from "drizzle-orm";
import { db } from "../db/client.js";
import { users, loginAudit } from "../db/schema.js";

const MAX_ATTEMPTS = Number(process.env.MAX_LOGIN_ATTEMPTS ?? 5);
const LOCKOUT_MS = Number(process.env.LOCKOUT_DURATION_MINUTES ?? 15) * 60 * 1000;

/**
 * Disimpan di kolom users.locked_until (bukan in-memory), supaya:
 * 1. Lockout tetap berlaku walau server di-restart.
 * 2. Kalau nanti scale ke lebih dari satu instance server, tetap konsisten
 *    (in-memory map akan beda-beda tiap instance dan gampang dibypass).
 */
export async function isAccountLocked(userId: number): Promise<boolean> {
  const [user] = await db.select().from(users).where(eq(users.id, userId)).limit(1);
  if (!user?.lockedUntil) return false;
  return user.lockedUntil.getTime() > Date.now();
}

export async function recordFailedLogin(userId: number): Promise<void> {
  const [user] = await db.select().from(users).where(eq(users.id, userId)).limit(1);
  if (!user) return;

  const newCount = user.failedLoginCount + 1;
  const shouldLock = newCount >= MAX_ATTEMPTS;

  await db
    .update(users)
    .set({
      failedLoginCount: newCount,
      lockedUntil: shouldLock ? new Date(Date.now() + LOCKOUT_MS) : user.lockedUntil,
    })
    .where(eq(users.id, userId));
}

export async function resetFailedLogins(userId: number): Promise<void> {
  await db
    .update(users)
    .set({ failedLoginCount: 0, lockedUntil: null })
    .where(eq(users.id, userId));
}

export async function logLoginAttempt(params: {
  username: string;
  success: boolean;
  ipAddress?: string;
  userAgent?: string;
  reason: string;
}): Promise<void> {
  await db.insert(loginAudit).values({
    username: params.username,
    success: params.success,
    ipAddress: params.ipAddress,
    userAgent: params.userAgent?.slice(0, 255),
    reason: params.reason,
  });
}
