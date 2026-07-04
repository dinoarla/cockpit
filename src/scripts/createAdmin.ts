import "dotenv/config";
import { createInterface } from "node:readline/promises";
import { db, pool } from "../db/client.js";
import { users } from "../db/schema.js";
import { hashPassword, validatePasswordStrength } from "../auth/password.js";
import { eq } from "drizzle-orm";

/**
 * Script interaktif untuk membuat user admin pertama.
 * Jalankan dengan: npm run create-admin
 *
 * Sengaja interaktif (bukan lewat argument CLI) supaya password tidak
 * pernah tertulis di bash history atau process list (`ps aux`).
 */

async function main() {
  const rl = createInterface({ input: process.stdin, output: process.stdout });

  const username = await rl.question("Username admin: ");
  const email = await rl.question("Email admin: ");

  // Node readline tidak punya mode "hidden input" built-in tanpa dependency
  // tambahan — untuk produksi, pertimbangkan pakai package seperti
  // `@inquirer/password`. Untuk setup awal ini masih cukup aman karena
  // dijalankan manual sekali oleh pemilik server.
  const password = await rl.question("Password admin (minimal 12 karakter, ada besar/kecil/angka): ");

  rl.close();

  const strength = validatePasswordStrength(password);
  if (!strength.ok) {
    console.error(`Password ditolak: ${strength.message}`);
    process.exit(1);
  }

  const [existing] = await db.select().from(users).where(eq(users.username, username)).limit(1);
  if (existing) {
    console.error(`Username "${username}" sudah dipakai.`);
    process.exit(1);
  }

  const passwordHash = await hashPassword(password);

  await db.insert(users).values({
    username,
    email,
    passwordHash,
    role: "admin",
    isActive: true,
  });

  console.log(`\nUser admin "${username}" berhasil dibuat.`);
  await pool.end();
}

main().catch((err) => {
  console.error("Gagal membuat admin:", err);
  process.exit(1);
});
