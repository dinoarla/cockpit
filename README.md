# COCKPIT — Pusat Data Riset Pribadi
### Product Requirements Document (PRD)

**Domain:** cockpit.dinoarla.com
**Versi dokumen:** 2.3
**Status:** Living document — update tiap ada perubahan requirement, jangan biarkan basi
**Pemilik & Hak Cipta:** © 2026 Dino Arla. Seluruh data, kode, dan dokumen ini adalah milik pribadi untuk keperluan riset dan studi PhD — bukan untuk didistribusikan tanpa izin tertulis dari pemilik.

> Dokumen ini adalah *single source of truth*. Kalau ada pertentangan antara dokumen ini dan kode yang sudah jalan, dokumen ini yang benar — perbaiki kodenya, bukan sebaliknya. Kalau requirement berubah, update dokumen ini dulu sebelum ubah kode.

---

## 1. Ringkasan Eksekutif

**COCKPIT bukan portal data PLN Jawa Barat — itu cuma domain data pertama yang masuk.**

COCKPIT adalah pusat data riset pribadi: satu tempat terpusat, aman, dan bisa terus berkembang untuk menampung seluruh dataset yang menunjang riset dan studi PhD pemilik portal ini. Domain PLN/ketenagalistrikan Jawa Barat adalah kumpulan data pertama yang dimasukkan (karena riset yang sedang berjalan sekarang di area itu), tapi arsitekturnya harus dari awal dirancang **domain-agnostic** — siap menerima dataset riset lain di masa depan yang mungkin sama sekali tidak berhubungan dengan kelistrikan (data demografi, data kesehatan, data ekonomi, hasil survei, dataset dari kolaborasi riset lain, dll), tanpa perlu bongkar ulang fondasinya.

**Implikasi desain penting dari framing ini:**
- Struktur "modul" TIDAK boleh di-hardcode seolah-olah semuanya soal PLN. Modul adalah unit generik: "satu dataset/topik riset = satu modul", apa pun isinya.
- Skema database & routing harus punya pola yang gampang direplikasi ke domain baru, bukan pola yang cuma masuk akal untuk data ketenagalistrikan.
- Karena ini menunjang PhD, pertimbangan **provenance data** (dari mana, kapan diambil, metodologi apa) jadi penting — bukan cuma soal keamanan/kecepatan, tapi juga soal kerapian riset akademik yang bisa dipertanggungjawabkan.

**Prinsip desain utama** (urutan prioritas kalau ada trade-off):
1. **Keamanan** — sebagian data (pelanggan, finansial, investigatif) sensitif; sebagian lagi mungkin data riset yang belum dipublikasikan (perlu dijaga sebelum sempat publish).
2. **Ekstensibilitas** — nambah domain riset baru harus semudah mungkin, tidak menganggu domain yang sudah ada.
3. **Kecepatan muat (fast load)** — tiap modul harus terasa instan.
4. **User-friendly** — dipakai sehari-hari untuk kerja riset sendiri, jangan sampai app-nya sendiri jadi hambatan.
5. **Provenance & reprodusibilitas** — tiap dataset idealnya tercatat sumber & metodologinya, memudahkan sitasi/verifikasi saat penulisan disertasi.

---

## 2. Target Pengguna

Ini bukan aplikasi tim/organisasi — target utamanya **satu peneliti (pemilik)**, dengan kemungkinan akses terbatas untuk:
- Pembimbing/promotor PhD (kemungkinan perlu lihat data tertentu, read-only)
- Kolaborator riset spesifik per proyek (akses dibatasi per-domain, bukan otomatis semua data)
- Diri sendiri di masa depan (tahun ke-2, ke-3 PhD) — jadi dokumentasi & konsistensi struktur data itu investasi jangka panjang, bukan formalitas

Implikasi: role `admin/editor/viewer` yang sudah ada di §5 tetap relevan, tapi tambahkan konsep **akses per-domain** (lihat §4) — pembimbing yang diberi akses ke domain "Energi Jabar" belum tentu otomatis bisa lihat domain riset lain yang ditambahkan belakangan.

---

## 3. Tech Stack

*(Tidak berubah dari versi sebelumnya — keputusan teknologi ini domain-agnostic, cocok dipakai untuk data apa pun, bukan spesifik PLN.)*

| Layer | Pilihan | Kenapa |
|---|---|---|
| Runtime | **Node.js** (≥18 LTS) | Wajib sesuai requirement — pastikan hosting expose versi ini lewat Node.js Selector/VPS |
| Bahasa | **TypeScript** (strict mode) | Type-safety mencegah banyak bug sebelum runtime, terutama di layer yang sentuh data sensitif |
| Web framework | **Hono** | Jauh lebih ringan dari Express/NestJS, native TypeScript, cold-start cepat |
| Database | **MySQL** (5.7+/8.0) | Sesuai yang sudah ada di hosting |
| ORM | **Drizzle ORM** | Pure TypeScript, query ter-parameterisasi otomatis (proteksi SQL injection bawaan) |
| DB driver | **mysql2** | Driver paling stabil di ekosistem Node untuk MySQL |
| Hash password | **Argon2id** (`argon2` package) | Rekomendasi OWASP #1 untuk implementasi baru |
| Sesi | Token random 256-bit, **di-hash SHA-256** sebelum disimpan ke DB | Kebocoran database ≠ otomatis kebocoran sesi aktif |
| Enkripsi field | **AES-256-GCM** (built-in Node `crypto`) | Untuk field sensitif di domain manapun yang butuh (PII, data belum publikasi, dll) |
| Frontend | **HTML + vanilla JS per halaman** (bukan SPA) | Tiap modul cuma load yang dia butuh — kunci "fast load" |
| Styling | CSS custom properties, tanpa framework berat | Konsisten & ringan |
| Charts | **Chart.js** | Ringan, cukup untuk kebutuhan dashboard riset |

---

## 4. Arsitektur Domain & Modul (Generik, Bukan Spesifik PLN)

Ini bagian yang paling berubah dari versi 1.0. Sebelumnya modul dianggap = "bagian dari data PLN". Sekarang:

### 4.1 Konsep "Domain Riset"
Satu **domain** = satu topik riset atau satu sumber data besar yang berdiri sendiri. PLN/Energi Jabar adalah SATU domain, bukan keseluruhan sistem.

```
domains
  id                  INT PK AUTO_INCREMENT
  slug                VARCHAR(50) UNIQUE NOT NULL   -- contoh: "energi-jabar", "riset-lain-x"
  nama                VARCHAR(150) NOT NULL
  deskripsi           TEXT
  is_active           BOOLEAN DEFAULT true
  created_at          TIMESTAMP DEFAULT NOW()
```

Tiap domain berisi satu atau lebih **modul** (dataset/tampilan spesifik dalam domain itu):

```
domain_modules
  id                  INT PK AUTO_INCREMENT
  domain_id           INT NOT NULL REFERENCES domains(id)
  slug                VARCHAR(50) NOT NULL          -- contoh: "mdp", "pelanggan", "ruptl"
  nama                VARCHAR(150) NOT NULL
  route_path          VARCHAR(100) NOT NULL         -- contoh: "/modules/energi-jabar/mdp/"
  sensitivitas        ENUM('publik','internal','sensitif') DEFAULT 'internal'
  status              ENUM('aktif','draft','arsip') DEFAULT 'draft'
  created_at          TIMESTAMP DEFAULT NOW()
  UNIQUE KEY (domain_id, slug)
```

### 4.2 Akses per-domain (bukan cuma role global)
```
user_domain_access
  user_id             INT NOT NULL REFERENCES users(id)
  domain_id           INT NOT NULL REFERENCES domains(id)
  access_level        ENUM('read','write','admin') NOT NULL
  granted_at          TIMESTAMP DEFAULT NOW()
  granted_by          INT REFERENCES users(id)
  PRIMARY KEY (user_id, domain_id)
```
Ini yang memungkinkan nanti kasih pembimbing akses "read" ke domain Energi Jabar saja, tanpa otomatis bisa lihat domain riset lain yang sifatnya belum siap dipublikasikan/dibagikan.

### 4.3 Provenance dataset (penting untuk kerja PhD)
Setiap dataset yang masuk ke suatu modul sebaiknya tercatat asal-usulnya — ini yang nanti memudahkan penulisan bab metodologi disertasi, dan memudahkan diri sendiri kalau lupa "data ini dari mana ya" enam bulan kemudian.

```
dataset_sources
  id                  INT PK AUTO_INCREMENT
  domain_module_id    INT NOT NULL REFERENCES domain_modules(id)
  nama_sumber         VARCHAR(255) NOT NULL         -- contoh: "RUPTL PLN 2025-2034"
  jenis_sumber        VARCHAR(100)                  -- "dokumen resmi", "open data", "hasil kompilasi", dll
  url_atau_referensi  TEXT
  tanggal_akses       DATE
  catatan_metodologi  TEXT                          -- cara ekstraksi/transformasi, asumsi yang dipakai
  created_at          TIMESTAMP DEFAULT NOW()
```

### 4.4 Struktur folder mengikuti pola domain
```
public/modules/
  energi-jabar/           <- domain PLN/energi (yang sudah dibangun)
    mdp/index.html
    pelanggan/index.html  (nanti)
    ruptl/index.html      (nanti)
  [domain-riset-lain]/    <- domain baru di masa depan, pola sama persis
    [modul]/index.html

src/routes/
  energi-jabar/
    mdp.ts
    pelanggan.ts
  [domain-riset-lain]/
    [modul].ts
```

**Aturan menambah domain baru:** copy pola folder yang sudah ada, jangan desain ulang dari nol tiap kali. Kalau pola ini mulai terasa tidak cukup fleksibel untuk domain baru, itu sinyal untuk revisi §4 dulu — bukan langsung improvisasi kode.

---

### 4.5 Visi Jangka Panjang: COCKPIT sebagai AI Agent

Ke depan, setelah data dari berbagai domain riset terkumpul cukup banyak, COCKPIT diarahkan berkembang jadi **AI Agent** — bisa dipanggil kapan pun, di mana pun, dari perangkat apa pun, bukan cuma dibuka lewat browser di komputer.

**Yang TIDAK perlu dilakukan sekarang:** membangun agent-nya. Ini murni prinsip desain supaya jalan ke sana nanti tidak butuh bongkar ulang fondasi — fokus saat ini tetap di §4.1-4.4 (struktur domain), keamanan (§5), dan provenance data (§12), karena AI agent yang bagus itu cuma sebaik data & API yang dia panggil.

**Keputusan arsitektural yang perlu dijaga MULAI SEKARANG:**

- **API harus benar-benar berdiri sendiri dari frontend.** Pola yang sudah dipakai (Hono API + halaman HTML statis terpisah) itu sudah pas — pertahankan disiplin ini. Jangan taruh logic penting di frontend JS yang harusnya ada di API, karena nanti "client" dari API ini bukan cuma browser, tapi bisa AI agent, aplikasi mobile, atau integrasi lain yang belum kebayang sekarang.
- **Autentikasi perlu jalur kedua di luar session cookie**, disiapkan nanti (bukan sekarang): cookie httpOnly cocok untuk browser, tapi AI agent/aplikasi lain butuh cara akses yang tidak bergantung ke cookie (API key atau token per-aplikasi/per-agent). Desain tabel `users`/sesi sekarang jangan sampai diam-diam mengasumsikan "satu-satunya cara login = form HTML" — cukup dijaga saja, belum perlu dibangun.
- **Provenance (§4.3, §12) jadi makin krusial.** Kalau nanti AI agent menjawab pertanyaan berbasis data ini, dia butuh tahu dan bisa menyebutkan dari mana angka itu berasal — supaya jawabannya bisa dipertanggungjawabkan, bukan cuma "angka ajaib" tanpa sumber.
- **Pertimbangkan protokol standar untuk AI agent** saat waktunya tiba, seperti **MCP (Model Context Protocol)** — COCKPIT bisa suatu saat expose dirinya sebagai MCP server, supaya asisten AI (termasuk Claude) bisa langsung "connect" dan query data COCKPIT sebagai tool, tanpa integrasi custom tiap kali.
- **Kontrol akses untuk agent perlu lebih ketat daripada akses manusia, secara default.** Agent yang bisa dipanggil "kapan pun, di mana pun" berarti permukaan aksesnya lebih luas. Domain/modul sensitif (§4.2) sebaiknya default TIDAK bisa diakses agent kecuali diberi izin eksplisit — beda perlakuan dari akses manusia yang sudah melalui login browser biasa.

---

## 5. Arsitektur Keamanan (Tidak berubah — tetap prioritas tertinggi)

### 5.1 Password
- Hash pakai **Argon2id**: `memoryCost: 19456` (~19MB), `timeCost: 2`, `parallelism: 1`.
- Validasi kekuatan minimum: ≥12 karakter, kombinasi huruf besar+kecil+angka.

### 5.2 Sesi Login
- Token 32 byte random → cookie httpOnly+secure+sameSite=lax.
- Yang disimpan di DB adalah **SHA-256 hash dari token**, bukan token asli — kebocoran database tidak otomatis = kebocoran sesi aktif.
- Durasi via `SESSION_DURATION_HOURS` (default 12 jam).

### 5.3 Proteksi Brute-Force
- Lockout setelah `MAX_LOGIN_ATTEMPTS` (default 5), durasi `LOCKOUT_DURATION_MINUTES` (default 15), disimpan di DB (bukan in-memory).
- Response "user tidak ada" vs "password salah" harus identik (mencegah timing/enumeration attack).

### 5.4 CSRF Protection
- Pola double-submit cookie, wajib di semua endpoint yang mengubah state.

### 5.5 Enkripsi Data Sensitif
- AES-256-GCM untuk field PII atau data riset yang belum siap dipublikasikan.
- `FIELD_ENCRYPTION_KEY` disimpan terpisah dari database.

### 5.6 Role & Akses
- Role global: `admin`, `editor`, `viewer` (tabel `users`).
- **Ditambah** akses per-domain lewat `user_domain_access` (§4.2) — role global menentukan bisa apa secara umum, akses per-domain menentukan boleh lihat domain mana saja.

### 5.7 Header, Transport, Audit
- Security headers wajib (CSP, X-Frame-Options, HSTS, dll).
- HTTPS wajib di production; `COOKIE_SECURE=true` hanya kalau sudah HTTPS.
- `login_audit` mencatat semua percobaan login (sukses/gagal, IP, waktu, alasan).

---

## 6. Skema Database — Ringkasan Lengkap

```
-- Inti sistem (semua domain)
users, sessions, login_audit          -- lihat detail struktur di README v1.0 / kode aktual
domains, domain_modules               -- §4.1
user_domain_access                    -- §4.2
dataset_sources                       -- §4.3

-- Domain "energi-jabar" (domain pertama)
  Modul MDP: sudah aktif, data di-embed langsung di HTML (belum dipindah ke tabel — lihat §11 fase 2)
  Modul Pelanggan (rencana):
    pelanggan (id_pelanggan, nama_terenkripsi, alamat_terenkripsi, nik_terenkripsi, up3, ulp, daya_tersambung_va, golongan_tarif, status)
  Modul OLAP Tagihan (rencana):
    tagihan_ringkasan_bulanan (up3, bulan, golongan_tarif, total_pelanggan, total_tagihan_rp, total_tunggakan_rp, refreshed_at)
    -- WAJIB tabel ringkasan hasil cron job, JANGAN query live ke data transaksi mentah
  Modul Pencurian (rencana):
    temuan_pencurian (id_pelanggan, up3, tanggal_temuan, jenis_pelanggaran, status_kasus, catatan_terenkripsi, created_by)
  Modul RUPTL (rencana): data referensi RUPTL PLN 2025-2034, sebagian besar publik

-- Domain riset lain (masa depan)
  Struktur tabel didesain saat domain itu mulai dibangun, ikuti pola §4.4
```

---

## 7. Struktur Folder Lengkap

```
cockpit/
├── src/
│   ├── db/
│   │   ├── schema.ts              # tabel inti + re-export schema per domain
│   │   ├── schemas/
│   │   │   └── energi-jabar.ts    # tabel spesifik domain ini, terpisah dari inti
│   │   ├── client.ts
│   │   └── migrate.ts
│   ├── auth/                      # password.ts, session.ts, rateLimiter.ts, csrf.ts, fieldEncryption.ts
│   ├── middleware/
│   │   └── auth.ts                # requireAuth, requireRole, requireDomainAccess (baru), security headers
│   ├── routes/
│   │   ├── auth.ts
│   │   ├── domains.ts             # baru: daftar domain & modul yang bisa diakses user ybs
│   │   └── energi-jabar/
│   │       ├── mdp.ts
│   │       └── ...
│   ├── scripts/
│   │   └── createAdmin.ts
│   └── index.ts
├── public/
│   ├── index.html                 # login
│   ├── menu.html                  # sekarang: daftar DOMAIN dulu, baru modul di dalamnya
│   └── modules/
│       └── energi-jabar/
│           └── mdp/index.html
├── .env.example
├── drizzle.config.ts
├── package.json
├── tsconfig.json
└── README.md
```

**Perubahan dari v1.0:** `menu.html` sekarang perlu dua tingkat — pilih domain dulu (kalau user akses ke >1 domain), baru pilih modul di dalam domain itu. Untuk sekarang (baru ada 1 domain aktif), boleh langsung tampilkan modul-modul domain "energi-jabar" tanpa halaman pemilihan domain — tapi jangan hardcode asumsi "cuma akan selalu ada 1 domain" di kode navigasinya.

---

## 8. Environment Variables

*(Tidak berubah dari v1.0)*

```
DB_HOST, DB_PORT, DB_USER, DB_PASSWORD, DB_NAME, DB_SSL
SESSION_SECRET, FIELD_ENCRYPTION_KEY
NODE_ENV, PORT, COOKIE_SECURE, COOKIE_DOMAIN
SESSION_DURATION_HOURS, MAX_LOGIN_ATTEMPTS, LOCKOUT_DURATION_MINUTES
```

---

## 9. Frontend Guidelines — Smooth, User-Friendly, Fast Load

*(Prinsip tidak berubah dari v1.0, berlaku untuk domain manapun)*

- Anggaran performa: **<300KB** per halaman modul, **<1.5 detik** time-to-interactive di 4G biasa.
- Feedback instan di setiap aksi (tombol disable + ubah teks saat proses).
- Pesan error dalam Bahasa Indonesia yang jelas, bukan pesan teknis mentah.
- Semua modul baru wajib pakai `public/assets/style.css` yang sama — supaya terasa satu produk walau domainnya beda-beda.
- **Tambahan untuk multi-domain:** halaman menu perlu bisa nampilin banyak domain tanpa terasa berantakan — pertimbangkan pengelompokan visual per-domain (bukan cuma grid modul rata semua) begitu domain kedua mulai dibangun.

---

## 10. Known Deployment Pitfalls

*(Tidak berubah dari v1.0 — ini murni soal infrastruktur Node.js/MySQL, domain-agnostic)*

Ringkasan (detail lengkap ada di riwayat dokumen/kode):
1. Native binding `argon2` gagal install di shared hosting → fallback `@node-rs/argon2` atau `bcryptjs`
2. ESM vs CommonJS di Node.js Selector cPanel → pastikan startup file arahkan ke `dist/index.js` hasil build
3. Port hardcode vs `process.env.PORT`
4. `.env` tidak ikut ter-upload (karena `.gitignore`) → buat manual di server
5. MySQL butuh SSL tapi `DB_SSL` belum di-set
6. Proses mati setelah sesi terminal ditutup → pakai PM2 atau Application Manager hosting

*(Update bagian ini tiap kali nemu error deploy baru — termasuk nanti kalau error spesifik ke domain riset baru.)*

---

## 11. Roadmap

| Fase | Cakupan |
|---|---|
| **Fase 1** (selesai) | Sistem auth lengkap + modul MDP di domain Energi Jabar |
| **Fase 2** | Migrasi data MDP dari hardcoded HTML ke tabel database + implementasi struktur `domains`/`domain_modules`/`user_domain_access` (§4) — **lakukan ini sebelum nambah domain riset baru**, supaya domain kedua tidak mewarisi pola lama yang belum generik |
| **Fase 3** | Modul RUPTL (masih domain Energi Jabar, data publik — risiko rendah untuk validasi pola) |
| **Fase 4** | Modul Data Induk Langganan (skema enkripsi PII final dulu sebelum coding) |
| **Fase 5** | Modul OLAP Tagihan (strategi tabel ringkasan + cron refresh) |
| **Fase 6** | Modul Pencurian Tenaga Listrik |
| **Fase 7+** | Domain riset baru di luar PLN/energi — pakai pola §4.4, evaluasi apakah §4 masih cukup fleksibel atau perlu direvisi |
| **Fase 8+** | Eksplorasi COCKPIT sebagai AI Agent (§4.5) — token/API key untuk akses non-browser, eksplorasi MCP server, kontrol akses khusus agent. Baru relevan setelah data dari beberapa domain riset benar-benar terkumpul, jangan diburu-buru sebelum fondasinya (Fase 1-7) solid |

---

## 12. Provenance & Reprodusibilitas (untuk kebutuhan PhD)

Karena portal ini menunjang riset akademik, beberapa kebiasaan yang sebaiknya dipegang sejak dini:

- **Isi `dataset_sources` (§4.3) setiap kali menambah dataset baru** — walau terasa formalitas sekarang, ini akan sangat menghemat waktu saat menulis metodologi disertasi atau ketika reviewer/promotor tanya "data ini dari mana".
- **Jangan overwrite dataset lama tanpa versioning.** Kalau suatu dataset direvisi (misal angka RUPTL ternyata perlu dikoreksi), pertimbangkan simpan versi lama juga (kolom `version` atau tabel `_history`) — riset butuh audit trail, bukan cuma "angka terbaru".
- **Pisahkan data mentah dari data olahan.** Kalau suatu modul menampilkan hasil agregasi/perhitungan (seperti proporsi/estimasi yang sudah dilakukan di modul MDP), field asumsi & metodologinya harus tetap tercatat di `dataset_sources.catatan_metodologi`, bukan cuma hidup di kepala sendiri.

---

## 13. Kepemilikan & Hak Cipta

**© 2026 Dino Arla. Hak cipta dilindungi.**

COCKPIT — Pusat Data Riset Pribadi, beserta seluruh kode sumber, skema database, dokumen ini, dan dataset yang dikumpulkan di dalamnya, adalah milik pribadi **Dino Arla** untuk keperluan riset dan studi PhD.

- Sebagian dataset (mis. RKPD, RUPTL, data Open Data Jabar) bersumber dari dokumen/data publik dan tetap tunduk pada lisensi/ketentuan sumber aslinya masing-masing — kepemilikan COCKPIT atas dataset tersebut terbatas pada bentuk kompilasi, pengolahan, dan penyajiannya, bukan atas data mentah itu sendiri.
- Data yang bersifat internal/sensitif (pelanggan, tagihan, temuan investigasi) tidak untuk didistribusikan, dipublikasikan, atau dibagikan ke pihak ketiga tanpa izin tertulis dari pemilik.
- Akses oleh pembimbing/kolaborator (§2, §4.2) diberikan terbatas untuk keperluan riset yang disepakati, bukan hak kepemilikan atas sistem atau datanya.

Untuk pertanyaan perizinan atau kolaborasi, hubungi langsung pemilik.

---

## 14. Versioning Dokumen

| Versi | Tanggal | Perubahan |
|---|---|---|
| 1.0 | 2026-07-04 | Dokumen awal — framing sebagai portal data PLN Jawa Barat |
| 2.0 | 2026-07-04 | **Reframing besar:** COCKPIT adalah pusat data riset pribadi untuk PhD, PLN/Energi Jabar cuma domain pertama. Tambah §4 (arsitektur domain generik), §12 (provenance riset). Update §2, §6, §7, §11 menyesuaikan. |
| 2.1 | 2026-07-04 | Tambah §13 Kepemilikan & Hak Cipta — © Dino Arla |
| 2.2 | 2026-07-04 | Tambah §4.5 Visi Jangka Panjang: COCKPIT sebagai AI Agent — prinsip desain API-first, autentikasi non-browser, MCP, kontrol akses agent. Update roadmap Fase 8+. |
| 2.3 | 2026-07-04 | **Rename proyek:** TERANG → COCKPIT, domain terang.dinoarla.com → cockpit.dinoarla.com. Tidak ada perubahan arsitektur/requirement, murni penggantian nama (termasuk retroaktif di riwayat versi sebelumnya, demi konsistensi dokumen). |

Setiap perubahan requirement signifikan, tambahkan baris baru di tabel ini — jangan timpa versi lama tanpa jejak, ini juga bagian dari provenance (§12).
