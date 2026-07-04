import { hash, verify, Algorithm } from "@node-rs/argon2";

/**
 * Argon2id — pemenang Password Hashing Competition (2015), direkomendasikan
 * OWASP sebagai pilihan pertama untuk hash password baru.
 *
 * Pakai @node-rs/argon2 (pre-built binary via napi-rs) bukan node-argon2
 * supaya tidak butuh kompilasi native di server hosting — lihat PRD §10.
 *
 * Parameter mengikuti rekomendasi minimum OWASP Password Storage Cheat Sheet (2024).
 */
const ARGON2_OPTIONS = {
  algorithm: Algorithm.Argon2id,
  memoryCost: 19456, // ~19 MB
  timeCost: 2,
  parallelism: 1,
};

export async function hashPassword(plainPassword: string): Promise<string> {
  return hash(plainPassword, ARGON2_OPTIONS);
}

export async function verifyPassword(
  storedHash: string,
  plainPassword: string
): Promise<boolean> {
  try {
    return await verify(storedHash, plainPassword, ARGON2_OPTIONS);
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
