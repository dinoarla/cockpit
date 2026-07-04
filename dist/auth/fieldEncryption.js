import { createCipheriv, createDecipheriv, randomBytes } from "node:crypto";
/**
 * Utility enkripsi field-level pakai AES-256-GCM.
 *
 * Untuk apa ini? Modul "Data Induk Langganan PLN" nanti kemungkinan
 * menyimpan data pribadi pelanggan (nama, alamat, NIK, dll). Kolom
 * sesensitif itu sebaiknya dienkripsi saat disimpan (encryption at rest),
 * bukan cuma diamankan lewat access control aplikasi — supaya kalau
 * database-nya sendiri suatu saat bocor/dicuri, isinya tetap tidak
 * terbaca tanpa FIELD_ENCRYPTION_KEY yang terpisah dari database.
 *
 * AES-256-GCM dipilih karena ini "authenticated encryption" — selain
 * merahasiakan data, juga otomatis mendeteksi kalau ciphertext-nya
 * diubah/dirusak (integrity check bawaan).
 *
 * Cara pakai nanti di modul lain:
 *   const encrypted = encryptField(nikPelanggan);  // simpan `encrypted` ke DB
 *   const original = decryptField(encrypted);       // saat perlu ditampilkan
 */
function getKey() {
    const hex = process.env.FIELD_ENCRYPTION_KEY;
    if (!hex || hex.length !== 64) {
        throw new Error("FIELD_ENCRYPTION_KEY harus di-set di .env dan panjangnya 64 karakter hex (32 byte). " +
            "Generate dengan: node -e \"console.log(require('crypto').randomBytes(32).toString('hex'))\"");
    }
    return Buffer.from(hex, "hex");
}
// Format tersimpan: iv(hex).authTag(hex).ciphertext(hex) — semua digabung
// jadi satu string supaya gampang disimpan di satu kolom VARCHAR/TEXT.
export function encryptField(plaintext) {
    const key = getKey();
    const iv = randomBytes(12); // 96-bit IV, standar untuk GCM
    const cipher = createCipheriv("aes-256-gcm", key, iv);
    const encrypted = Buffer.concat([cipher.update(plaintext, "utf8"), cipher.final()]);
    const authTag = cipher.getAuthTag();
    return `${iv.toString("hex")}.${authTag.toString("hex")}.${encrypted.toString("hex")}`;
}
export function decryptField(stored) {
    const key = getKey();
    const [ivHex, authTagHex, dataHex] = stored.split(".");
    if (!ivHex || !authTagHex || !dataHex) {
        throw new Error("Format data terenkripsi tidak valid.");
    }
    const decipher = createDecipheriv("aes-256-gcm", key, Buffer.from(ivHex, "hex"));
    decipher.setAuthTag(Buffer.from(authTagHex, "hex"));
    const decrypted = Buffer.concat([
        decipher.update(Buffer.from(dataHex, "hex")),
        decipher.final(), // akan throw kalau authTag tidak cocok (data dirusak/salah key)
    ]);
    return decrypted.toString("utf8");
}
//# sourceMappingURL=fieldEncryption.js.map