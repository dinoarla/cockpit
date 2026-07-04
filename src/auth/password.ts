import * as argon2 from "argon2";

/**
 * Argon2id — pemenang Password Hashing Competition (2015), direkomendasikan
 * OWASP sebagai pilihan pertama di atas bcrypt/scrypt untuk hash password baru.
 *
 * Parameter di bawah ini ("memory cost" 19 MB, 2 iterasi, 1 thread paralel)
 * mengikuti rekomendasi minimum OWASP Password Storage Cheat Sheet (2024).
 * Kalau server hosting kamu cukup kuat, angka memoryCost bisa dinaikkan
 * (makin besar = makin lambat di-brute-force, tapi juga makin berat di server).
 */
const ARGON2_OPTIONS: argon2.Options = {
  type: argon2.argon2id,
  memoryCost: 19456, // ~19 MB
  timeCost: 2,
  parallelism: 1,
};

export async function hashPassword(plainPassword: string): Promise<string> {
  return argon2.hash(plainPassword, ARGON2_OPTIONS);
}

export async function verifyPassword(
  hash: string,
  plainPassword: string
): Promise<boolean> {
  try {
    return await argon2.verify(hash, plainPassword);
  } catch {
    // Hash korup/format tidak dikenal — anggap saja verifikasi gagal,
    // jangan lempar error ke caller (bisa bocorkan info lewat timing/pesan error).
    return false;
  }
}

/**
 * Validasi kekuatan password minimal saat registrasi/ganti password.
 * Ini validasi dasar — silakan diperketat sesuai kebutuhan (mis. cek
 * terhadap daftar password bocor via API "Have I Been Pwned" range search).
 */
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
