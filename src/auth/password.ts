import bcrypt from "bcryptjs";

/**
 * bcryptjs — pure JavaScript, tidak butuh native binary.
 * Dipakai sebagai fallback dari Argon2id karena kompatibilitas hosting (PRD §10).
 * 12 salt rounds memberikan keamanan yang cukup (OWASP: minimum 10 rounds).
 */
const SALT_ROUNDS = 12;

export async function hashPassword(plainPassword: string): Promise<string> {
  return bcrypt.hash(plainPassword, SALT_ROUNDS);
}

export async function verifyPassword(
  storedHash: string,
  plainPassword: string
): Promise<boolean> {
  try {
    return await bcrypt.compare(plainPassword, storedHash);
  } catch {
    return false;
  }
}

export function validatePasswordStrength(password: string): { ok: boolean; message?: string } {
  if (password.length < 12) {
    return { ok: false, message: "Password minimal 12 karakter." };
  }
  if (!/[a-z]/.test(password) || !/[A-Z]/.test(password)) {
    return { ok: false, message: "Password harus ada huruf besar dan kecil." };
  }
  if (!/[0-9]/.test(password)) {
    return { ok: false, message: "Password harus mengandung angka." };
  }
  return { ok: true };
}
