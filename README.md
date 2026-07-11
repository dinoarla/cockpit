<div align="center">

```
 ██████╗ ██████╗  ██████╗██╗  ██╗██████╗ ██╗████████╗
██╔════╝██╔═══██╗██╔════╝██║ ██╔╝██╔══██╗██║╚══██╔══╝
██║     ██║   ██║██║     █████╔╝ ██████╔╝██║   ██║   
██║     ██║   ██║██║     ██╔═██╗ ██╔═══╝ ██║   ██║   
╚██████╗╚██████╔╝╚██████╗██║  ██╗██║     ██║   ██║   
 ╚═════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚═╝     ╚═╝   ╚═╝   
```

**Pusat Data Riset Pribadi — Dino Arla**

[![Node.js](https://img.shields.io/badge/Node.js-18+-FF4D00?style=flat-square&logo=node.js&logoColor=white)](https://nodejs.org)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.x-FF4D00?style=flat-square&logo=typescript&logoColor=white)](https://typescriptlang.org)
[![Hono](https://img.shields.io/badge/Hono-4.x-FF4D00?style=flat-square&logo=hono&logoColor=white)](https://hono.dev)
[![MySQL](https://img.shields.io/badge/MySQL-8.x-FF4D00?style=flat-square&logo=mysql&logoColor=white)](https://mysql.com)
[![Drizzle ORM](https://img.shields.io/badge/Drizzle_ORM-0.45-FF4D00?style=flat-square&logoColor=white)](https://orm.drizzle.team)
[![License](https://img.shields.io/badge/License-Proprietary-161B22?style=flat-square)](LICENSE)

*Satu portal terpusat, aman, dan extensible untuk semua dataset riset PhD*

</div>

---

## Daftar Isi

- [Tentang COCKPIT](#-tentang-cockpit)
- [Modul yang Tersedia](#-modul-yang-tersedia)
- [Tech Stack](#-tech-stack)
- [Arsitektur](#-arsitektur)
- [Keamanan](#-keamanan)
- [Struktur Folder](#-struktur-folder)
- [Database Schema](#-database-schema)
- [Instalasi & Setup](#-instalasi--setup)
- [Environment Variables](#-environment-variables)
- [Deployment ke Hostinger](#-deployment-ke-hostinger)
- [Roadmap](#-roadmap)
- [Changelog](#-changelog)
- [Hak Cipta](#-hak-cipta)

---

## ⚡ Tentang COCKPIT

**COCKPIT bukan portal data PLN Jawa Barat — itu cuma domain data pertama yang masuk.**

COCKPIT adalah **pusat data riset pribadi**: satu tempat terpusat, aman, dan extensible untuk menampung seluruh dataset yang menunjang riset dan studi PhD. Domain Energi & Ketenagalistrikan Jawa Barat adalah kumpulan data pertama karena riset yang sedang berjalan, tapi arsitekturnya dirancang **domain-agnostic** — siap menerima dataset riset lain di masa depan tanpa bongkar ulang fondasi.

### Prinsip Desain ⚡

```
1. KEAMANAN       Sebagian data bersifat sensitif — enkripsi & akses berlapis dari awal
2. EKSTENSIBILITAS Nambah domain riset baru semudah mungkin, tidak ganggu yang sudah ada
3. FAST LOAD      Tiap modul harus terasa instan — anggaran <300KB & <1.5s TTI
4. PROVENANCE     Tiap dataset tercatat sumber & metodologinya untuk kebutuhan akademik
```

### Fitur Utama ✨

| Kategori | Fitur |
|----------|-------|
| 🗂 **Multi-Domain** | Arsitektur domain-agnostic — tiap topik riset jadi satu domain mandiri |
| 🔐 **Auth & Akses** | Bcrypt-12, session token SHA-256, CSRF, rate limiter, akses per-modul |
| 🛡 **Enkripsi** | AES-256-GCM untuk field PII & data belum dipublikasikan |
| 📊 **Visualisasi** | Peta choropleth Leaflet, Chart.js, tabel interaktif per modul |
| 👤 **Admin Panel** | User management, monitor aktivitas login, security dashboard |
| 📋 **Provenance** | Setiap dataset tercatat asal, metodologi, dan tanggal akses |

---

## 📦 Modul yang Tersedia

### Domain: Energi & Ketenagalistrikan

| Modul | Status | Deskripsi |
|-------|--------|-----------|
| **Bauran Energi Jawa Barat** | ✅ Aktif | Peta & data RE vs NRE, RKPD 2026, RUPTL 2025-2034, gangguan PLN |
| **RUPTL PLN 2025-2034** | ✅ Aktif | Data 34 provinsi — penjualan, proyeksi, pembangkit, skenario RE Base & ARED |
| **Data Induk Langganan** | ✅ Aktif | Statistik 13,9 juta pelanggan PLN UID Jabar — hanya agregasi anonim |
| **OLAP Tagihan Listrik** | 🔜 Draft | Ringkasan tagihan bulanan per UP3 & golongan tarif |
| **Data Pencurian** | 🔜 Draft | Temuan & dugaan pencurian tenaga listrik — akses terbatas |

### Panel Admin (Admin Only)

| Modul | Deskripsi |
|-------|-----------|
| **User Management** | Buat user, atur role, set akses per-modul, reset password |
| **Monitor Aktivitas** | Log login real-time, sesi aktif, filter berhasil/gagal |
| **Security Dashboard** | Threat level, top IP gagal, status enkripsi & HTTP headers |

---

## 🛠 Tech Stack

### Core

```
Runtime      Node.js ≥18 LTS                 Wajib sesuai requirement hosting
Bahasa       TypeScript 5.x (strict mode)    Type-safety mencegah bug di layer data sensitif
Framework    Hono 4.x                        Ringan, native TypeScript, cold-start cepat
Database     MySQL 8.x                       Sesuai yang sudah ada di hosting
ORM          Drizzle ORM 0.45                Pure TypeScript, query ter-parameterisasi otomatis
Frontend     HTML + Vanilla JS per halaman   Tiap modul hanya load yang dibutuhkan
Charts       Chart.js 4.x + Leaflet 1.9     Visualisasi data & peta choropleth
```

### Security

```
Password     bcryptjs · 12 salt rounds       OWASP-compliant, pure JS (no native binary)
Session      32-byte CSPRNG → SHA-256 hash   Kebocoran DB ≠ kebocoran sesi aktif
Enkripsi     AES-256-GCM (Node built-in)     IV acak per enkripsi, untuk field PII
CSRF         Double-submit cookie pattern    Token 10 menit, wajib semua state-mutating request
Rate Limit   DB-based lockout                Max 3 percobaan → kunci 15 menit
Headers      CSP, X-Frame-Options, HSTS      Diapply global via middleware
```

---

## 🏗 Arsitektur

### Layer Architecture

```
┌────────────────────────────────────────────────────────┐
│                 🌐 Browser (HTML + Vanilla JS)         │
│        Fetch API → /api/* (same-origin, httpOnly)      │
└──────────────────────────┬─────────────────────────────┘
                           │  HTTPS
┌──────────────────────────▼─────────────────────────────┐
│              ⚡ Hono Server (Node.js)                   │
│   securityHeaders → requireAuth → requireRole          │
│   /api/auth · /api/domains · /api/admin · /api/mdp    │
└──────────────────────────┬─────────────────────────────┘
                           │
┌──────────────────────────▼─────────────────────────────┐
│              🗃 Drizzle ORM + MySQL                     │
│   users · sessions · login_audit                       │
│   domains · domain_modules · user_domain_access       │
│   user_module_access · dataset_sources · ruptl_*      │
└────────────────────────────────────────────────────────┘
```

### Konsep Domain & Modul

```
COCKPIT
├── Domain: energi-jabar          ← domain pertama (aktif)
│   ├── Modul: mdp                   /modules/energi-jabar/mdp/
│   ├── Modul: ruptl                 /modules/energi-jabar/ruptl/
│   └── Modul: pelanggan             /modules/energi-jabar/pelanggan/
├── Domain: [riset-lain]          ← domain riset berikutnya (pola sama)
│   └── Modul: [dataset]             /modules/[riset-lain]/[dataset]/
└── Admin: user, aktivitas, keamanan  /admin/*/
```

**Aturan:** `satu dataset/topik riset = satu modul`. Tambah domain baru = copy pola folder, tidak perlu desain ulang.

---

## 🔐 Keamanan

```
Lapisan      Implementasi                    Keterangan
─────────────────────────────────────────────────────────────────
Password     bcrypt · 12 rounds              Min 12 karakter, huruf besar+kecil+angka
Session      SHA-256(random token) di DB     httpOnly · Secure · SameSite=Lax
CSRF         Double-submit cookie            Cek di semua POST/PATCH/DELETE
Rate Limit   DB lockout (bukan in-memory)    Tahan restart — MAX_LOGIN_ATTEMPTS konfigurabel
Enkripsi     AES-256-GCM per field           IV unik tiap enkripsi, key terpisah dari DB
Headers      CSP · X-Frame-Options · HSTS   Di-set global sebelum semua response
Audit        login_audit table               Rekam semua login sukses/gagal + IP + alasan
Sesi         SESSION_DURATION_HOURS          Default 12 jam, configurable
```

**Akses berlapis:**
- Role global: `admin` · `editor` · `viewer`
- Akses per-domain: `user_domain_access` — bisa beri pembimbing akses ke 1 domain saja
- Akses per-modul: `user_module_access` — granular hingga level modul spesifik

---

## 📁 Struktur Folder

```
cockpit/
├── src/
│   ├── auth/
│   │   ├── csrf.ts               CSRF token — double-submit cookie
│   │   ├── fieldEncryption.ts    AES-256-GCM untuk field PII
│   │   ├── password.ts           bcrypt hash & validasi kekuatan
│   │   ├── rateLimiter.ts        DB-based lockout & audit log
│   │   └── session.ts            Buat / validasi / hapus sesi
│   ├── db/
│   │   ├── client.ts             Drizzle + mysql2 connection
│   │   ├── migrate.ts            Runner migrasi
│   │   └── schema.ts             Semua definisi tabel
│   ├── middleware/
│   │   └── auth.ts               requireAuth, requireRole, requireDomainAccess
│   ├── routes/
│   │   ├── admin.ts              /api/admin/* (users, audit, sessions, security)
│   │   ├── auth.ts               /api/auth/* (login, logout, me, csrf-token)
│   │   ├── domains.ts            /api/domains (daftar domain + modul per user)
│   │   ├── mdp.ts                /api/mdp/*
│   │   └── ruptl.ts              /api/ruptl/*
│   ├── scripts/
│   │   └── createAdmin.ts        Script buat akun admin pertama
│   └── index.ts                  Entry point Hono + static serve
├── public/
│   ├── index.html                Halaman login
│   ├── menu.html                 Dashboard utama — domain & modul
│   ├── admin/
│   │   ├── users/index.html      User management
│   │   ├── aktivitas/index.html  Monitor aktivitas & log
│   │   └── keamanan/index.html   Security dashboard
│   └── modules/
│       └── energi-jabar/
│           ├── mdp/index.html
│           ├── ruptl/index.html
│           └── pelanggan/index.html
├── drizzle/
│   └── FULL_SETUP.sql            Satu-satunya file SQL — schema + semua seed data
├── dist/                         Output TypeScript build (di-generate, jangan edit)
├── .env                          Kredensial lokal (jangan di-commit)
├── .env.example                  Template environment variables
├── drizzle.config.ts
├── package.json
├── server.js                     Entry point Hostinger (load dist/index.js)
└── tsconfig.json
```

---

## 🗄 Database Schema

### Tabel Inti

```sql
users               -- Auth: username, passwordHash, role, isActive, failedLoginCount
sessions            -- SHA-256 token, userId, ipAddress, expiresAt
login_audit         -- Semua percobaan login (sukses/gagal), IP, alasan

domains             -- Daftar domain riset (slug, nama, isActive)
domain_modules      -- Modul per domain (slug, nama, routePath, status, sensitivitas)
user_domain_access  -- Akses per domain per user (accessLevel: read/write/admin)
user_module_access  -- Akses granular per modul per user
dataset_sources     -- Provenance: sumber & metodologi tiap dataset

ruptl_provinsi      -- 34 provinsi RUPTL PLN 2025-2034
ruptl_penjualan_historis   -- Historis penjualan per sektor 2015-2024
ruptl_proyeksi_kebutuhan   -- Proyeksi demand 2025-2034
ruptl_pembangkit_eksisting -- Pembangkit terpasang per provinsi
ruptl_rencana_pembangkit   -- Pipeline RE Base & ARED
ruptl_rencana_transmisi    -- Rencana transmisi per tahun
ruptl_rencana_gardu_induk  -- Rencana gardu induk per tahun
```

**Fresh install:** jalankan `FULL_SETUP.sql` — sudah berisi schema + data B1, B2, B3, B4.

---

## 🚀 Instalasi & Setup

```bash
# 1. Clone
git clone https://github.com/dinoarla/cockpit.git
cd cockpit

# 2. Install dependencies
npm install

# 3. Setup environment variables
cp .env.example .env
# ← isi kredensial DB, session secret, encryption key

# 4. Import database (di server atau lokal)
mysql -u USER -p DB_NAME < drizzle/FULL_SETUP.sql

# 5. Buat akun admin pertama
npm run create-admin

# 6. Build TypeScript
npm run build

# 7. Jalankan
npm start          # production
npm run dev        # development (tsx watch)
```

---

## ⚙️ Environment Variables

```bash
# ── Database MySQL ───────────────────────────────────────────
DB_HOST=localhost
DB_PORT=3306
DB_USER=username
DB_PASSWORD=password
DB_NAME=database_name
DB_SSL=false               # set true jika hosting butuh SSL

# ── Session & Enkripsi ───────────────────────────────────────
SESSION_SECRET=            # generate: openssl rand -hex 32
FIELD_ENCRYPTION_KEY=      # generate: openssl rand -hex 32

# ── Cookie ───────────────────────────────────────────────────
COOKIE_SECURE=false        # set true di production (HTTPS)
# COOKIE_DOMAIN=           # opsional, isi domain jika perlu

# ── Server ───────────────────────────────────────────────────
PORT=3000
NODE_ENV=production

# ── Session & Rate Limiting ──────────────────────────────────
SESSION_DURATION_HOURS=12
MAX_LOGIN_ATTEMPTS=3
LOCKOUT_DURATION_MINUTES=15
```

---

## 🖥 Deployment ke Hostinger

### Prasyarat

```bash
node --version   # v18+
npm --version    # v9+
# Akses SSH ke server Hostinger
# MySQL database sudah dibuat via hPanel
```

### Deploy

```bash
# 1. SSH ke server
ssh user@server

# 2. Clone / pull kode
git clone https://github.com/dinoarla/cockpit.git
cd cockpit

# 3. Install & build
npm install
npm run build

# 4. Setup .env di server (tidak ikut git)
nano .env
# ← isi dengan kredensial production

# 5. Import database
mysql -u USER -p DB_NAME < drizzle/FULL_SETUP.sql

# 6. Buat admin
npm run create-admin

# 7. Jalankan via PM2 atau Application Manager hosting
pm2 start server.js --name cockpit
pm2 save
pm2 startup
```

### Update Deploy

```bash
git pull origin main
npm install
npm run build
pm2 reload cockpit   # zero-downtime reload
```

### Catatan Hostinger

```
⚠ argon2 native binary gagal di shared hosting → sudah diganti bcryptjs (pure JS)
⚠ Entry point harus ke server.js (bukan src/index.ts)
⚠ .env TIDAK ter-upload via git — buat manual di server setiap kali fresh deploy
⚠ Pastikan Node.js Selector di hPanel diset ke versi 18+
```

---

## 📋 Roadmap

| Fase | Status | Cakupan |
|------|--------|---------|
| **Fase 1** | ✅ Selesai | Auth lengkap, modul MDP & RUPTL domain Energi Jabar |
| **Fase 2** | ✅ Selesai | Arsitektur domain generik, modul Pelanggan (statistik DIL), admin panel |
| **Fase 3** | 🔜 Planned | Modul OLAP Tagihan — strategi tabel ringkasan + cron refresh |
| **Fase 4** | 🔜 Planned | Modul Pencurian Tenaga Listrik — enkripsi PII final |
| **Fase 5** | 🔜 Planned | Ekspansi RUPTL — data lengkap 34 provinsi (Lampiran A & C) |
| **Fase 6+** | 💡 Vision | Domain riset baru di luar PLN/energi — pakai pola domain generik |
| **Fase 7+** | 💡 Vision | COCKPIT sebagai AI Agent — API key, MCP server, non-browser auth |

---

## 📋 Changelog

### v0.1.0 — Juli 2026

- ⚡ Initial release **COCKPIT** — Pusat Data Pribadi Dino Arla
- ✅ Auth: bcrypt-12, session SHA-256, CSRF, rate limiter, login audit
- ✅ Arsitektur multi-domain: `domains`, `domain_modules`, `user_domain_access`, `user_module_access`
- ✅ Domain Energi & Ketenagalistrikan:
  - Modul Bauran Energi Jawa Barat — peta choropleth, RE/NRE, RKPD, RUPTL, gangguan PLN
  - Modul RUPTL PLN 2025-2034 — 34 provinsi, RE Base & ARED (B1/B2/B3/B4 lengkap)
  - Modul Data Induk Langganan — statistik 13,9 juta pelanggan PLN UID Jabar
- ✅ Admin Panel: user management, monitor aktivitas, security dashboard
- ✅ Enkripsi field sensitif AES-256-GCM
- ✅ Security headers: CSP, X-Frame-Options, HSTS, Permissions-Policy
- ✅ Single SQL file deployment: `drizzle/FULL_SETUP.sql`

---

## 🔒 Hak Cipta

**© 2026 Dino Arla. Hak cipta dilindungi.**

COCKPIT — Pusat Data Riset Pribadi, beserta seluruh kode sumber, skema database, dan dataset yang dikumpulkan di dalamnya, adalah milik pribadi **Dino Arla** untuk keperluan riset dan studi PhD.

- Dataset yang bersumber dari dokumen publik (RKPD, RUPTL, Open Data Jabar) tetap tunduk pada lisensi sumber aslinya — kepemilikan COCKPIT terbatas pada bentuk kompilasi, pengolahan, dan penyajiannya.
- Data internal/sensitif (pelanggan PLN, tagihan, temuan investigasi) tidak untuk didistribusikan atau dibagikan tanpa izin tertulis.
- Akses oleh pembimbing/kolaborator PhD diberikan terbatas untuk keperluan riset yang disepakati.

---

<div align="center">

⚡ ⚡ ⚡

**COCKPIT** — dibangun untuk mendukung riset PhD Dino Arla

[Laporkan Bug](../../issues) · [PRD Lengkap](README.md) · [cockpit.dinoarla.com](https://cockpit.dinoarla.com)

*"Satu portal untuk semua data riset — aman, cepat, dan siap berkembang."*

</div>
