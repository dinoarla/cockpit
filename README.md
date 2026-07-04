# Pusat Data PLN & Jawa Barat

Portal internal dengan login dan beberapa modul data:
1. Data Pendukung MDP (sudah aktif — dashboard yang sudah dibuat sebelumnya)
2. Data Induk Langganan PLN Jabar (slot siap, belum ada route/data)
3. Data OLAP Tagihan Listrik Jabar (slot siap)
4. Data Pencurian Tenaga Listrik (slot siap)
5. Data RUPTL PLN 2025–2034 (slot siap)
6. Modul lain menyusul

## Keamanan yang sudah diimplementasikan

- **Argon2id** untuk hash password (bukan bcrypt/MD5/SHA biasa)
- **Session token di-hash** (SHA-256) sebelum disimpan ke database — kalau database bocor, isi tabel `sessions` tidak bisa dipakai membajak akun
- **Account lockout** otomatis setelah beberapa kali gagal login (lihat `MAX_LOGIN_ATTEMPTS` di `.env`)
- **CSRF protection** (pola double-submit cookie) di form login
- **Audit log** semua percobaan login, sukses maupun gagal, lengkap dengan IP & waktu
- **AES-256-GCM** utility (`src/auth/fieldEncryption.ts`) siap dipakai untuk enkripsi field sensitif di modul-modul berikutnya (mis. NIK pelanggan)
- **Security headers** (CSP, X-Frame-Options, HSTS, dll) — lihat `src/middleware/auth.ts`
- Perbandingan waktu-konstan (`timingSafeEqual`) untuk mencegah timing attack di beberapa titik kritis

**Yang TETAP jadi tanggung jawab kamu di luar kode ini:**
- Pastikan situs diakses lewat **HTTPS** (set `COOKIE_SECURE=true` di `.env` HANYA kalau sudah HTTPS — kalau di-set true tapi situsnya masih HTTP, cookie session tidak akan pernah terkirim dan login akan terlihat gagal terus)
- Jangan commit file `.env` ke git manapun (sudah ada di `.gitignore`)
- Backup database secara rutin
- Kalau modul "Data Induk Langganan" nanti menyimpan data pribadi (NIK, dll), pastikan sesuai UU PDP — enkripsi field itu pakai `fieldEncryption.ts`, jangan simpan plaintext

## Setup Awal

### 1. Install dependencies
```bash
npm install
```

### 2. Siapkan database MySQL
Buat database kosong di MySQL hosting kamu, misalnya lewat phpMyAdmin atau CLI:
```sql
CREATE DATABASE plnjabar_portal CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### 3. Konfigurasi environment
```bash
cp .env.example .env
```
Lalu edit `.env`, isi kredensial database kamu. Generate dua secret yang wajib diganti:
```bash
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
```
Jalankan dua kali — hasil pertama untuk `SESSION_SECRET`, hasil kedua untuk `FIELD_ENCRYPTION_KEY`. **Jangan pernah pakai nilai contoh di `.env.example` di production.**

### 4. Migrasi database (bikin tabel users, sessions, login_audit)
```bash
npm run db:generate   # generate file migrasi SQL dari schema.ts
npm run db:migrate    # jalankan migrasi ke database
```

### 5. Buat user admin pertama
```bash
npm run create-admin
```
Ikuti instruksi interaktifnya (username, email, password).

### 6. Jalankan (development)
```bash
npm run dev
```
Buka `http://localhost:3000`, login pakai akun admin yang barusan dibuat.

### 7. Deploy ke hosting (production)
```bash
npm run build
npm start
```
Biasanya di cPanel dengan Node.js Selector, kamu tinggal set:
- **Application startup file**: `dist/index.js`
- **Application root**: folder project ini
- Jalankan `npm install && npm run build` lewat terminal cPanel dulu sebelum start

## Menambah modul baru

Contoh menambah modul "Data RUPTL":

1. Buat schema tabel baru di `src/db/schema.ts` (atau file schema terpisah)
2. Buat `src/routes/ruptl.ts`, contoh:
   ```ts
   import { Hono } from "hono";
   import { requireAuth } from "../middleware/auth.js";

   export const ruptlRoutes = new Hono();
   ruptlRoutes.use("*", requireAuth);

   ruptlRoutes.get("/summary", async (c) => {
     // query ke database di sini
     return c.json({ /* ... */ });
   });
   ```
3. Daftarkan di `src/index.ts`:
   ```ts
   import { ruptlRoutes } from "./routes/ruptl.js";
   app.route("/api/ruptl", ruptlRoutes);
   ```
4. Buat halaman `public/modules/ruptl/index.html` (bisa contek pola dari dashboard MDP yang sudah ada, tinggal ganti data hardcoded jadi `fetch('/api/ruptl/summary')`)
5. Update `public/menu.html` — hapus `data-locked="true"` dan ganti `href="#"` jadi `href="/modules/ruptl/index.html"` di card yang sesuai

## Struktur Project

```
src/
  db/
    schema.ts        → definisi tabel (users, sessions, login_audit)
    client.ts         → koneksi MySQL pool + Drizzle ORM
    migrate.ts         → runner migrasi
  auth/
    password.ts         → hash & verifikasi password (Argon2id)
    session.ts           → buat/validasi/hapus sesi (token di-hash)
    rateLimiter.ts         → account lockout & audit log
    csrf.ts                 → CSRF token (double-submit cookie)
    fieldEncryption.ts       → AES-256-GCM untuk data sensitif
  middleware/
    auth.ts                  → requireAuth, requireRole, security headers
  routes/
    auth.ts                   → login, logout, cek sesi
    mdp.ts                     → contoh route data terproteksi
  scripts/
    createAdmin.ts              → CLI bikin user admin
  index.ts                     → entry point server
public/
  index.html         → halaman login
  menu.html          → hub pemilihan modul
  modules/mdp/       → modul dashboard MDP (sudah aktif)
  assets/style.css   → styling shared
```

## Kenapa pilihan teknologinya begini?

- **Hono** bukan Express — lebih ringan, native TypeScript, cocok untuk hosting dengan resource terbatas
- **Drizzle ORM** bukan Prisma — Prisma butuh binary engine terpisah yang kadang bermasalah di shared hosting; Drizzle murni TypeScript
- **mysql2** — driver MySQL paling umum dipakai di ekosistem Node, support Promise & prepared statements (mencegah SQL injection secara default lewat parameterized query)
- **Halaman per-modul statis (bukan SPA React/Vue)** — tiap modul HTML+JS berdiri sendiri, browser cuma load yang dibutuhkan saat itu. Ini alasan utama kenapa portalnya bakal terasa ringan meskipun modulnya nanti banyak.
