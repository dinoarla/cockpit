-- =============================================================================
-- register_baca_meter.sql
-- Buat tabel agregat baca meter pascabayar Jawa Barat 2026
-- + daftarkan modul di domain_modules
-- Jalankan SETELAH import dari aggregate_baca_meter.py
-- =============================================================================

SET NAMES utf8mb4;

-- ── 1. Tabel summary per UP3 per bulan ──────────────────────────────────────
CREATE TABLE IF NOT EXISTS `baca_meter_summary` (
  `id`               INT AUTO_INCREMENT PRIMARY KEY,
  `bulan`            CHAR(6)        NOT NULL COMMENT 'YYYYMM, mis. 202602',
  `up3_kode`         VARCHAR(10)    NOT NULL COMMENT 'Kode UP3, mis. 53BDG',
  `up3_nama`         VARCHAR(50)    NOT NULL COMMENT 'Nama UP3, mis. Bandung',
  `total_pelanggan`  INT            NOT NULL DEFAULT 0,
  `total_kwh`        BIGINT         NOT NULL DEFAULT 0,
  `avg_kwh`          DECIMAL(10,2)  DEFAULT 0,
  `pct_normal`       DECIMAL(5,2)   DEFAULT 0 COMMENT '% baca dengan kode Z-NORMAL',
  `baca_ulang`       INT            DEFAULT 0,
  `inisialisasi`     INT            DEFAULT 0,
  `avg_jam`          DECIMAL(5,2)   DEFAULT NULL COMMENT 'Rata-rata jam pembacaan (0-23)',
  UNIQUE KEY `uk_bm_summary` (`bulan`, `up3_kode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── 2. Tabel tarif breakdown ─────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `baca_meter_tarif` (
  `id`              INT AUTO_INCREMENT PRIMARY KEY,
  `bulan`           CHAR(6)     NOT NULL,
  `up3_kode`        VARCHAR(10) NOT NULL,
  `tarif`           VARCHAR(10) NOT NULL COMMENT 'R1, R1M, R2, R3, S1, B1, B2, P1, P3, I1, I2, L, C',
  `pelanggan`       INT         NOT NULL DEFAULT 0,
  `total_kwh`       BIGINT      NOT NULL DEFAULT 0,
  UNIQUE KEY `uk_bm_tarif` (`bulan`, `up3_kode`, `tarif`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── 3. Tabel KODE_PESAN breakdown ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `baca_meter_kode_pesan` (
  `id`          INT AUTO_INCREMENT PRIMARY KEY,
  `bulan`       CHAR(6)      NOT NULL,
  `up3_kode`    VARCHAR(10)  NOT NULL,
  `kode_pesan`  VARCHAR(100) NOT NULL,
  `jumlah`      INT          NOT NULL DEFAULT 0,
  UNIQUE KEY `uk_bm_kode` (`bulan`, `up3_kode`, `kode_pesan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── 4. Tabel daya group breakdown ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `baca_meter_daya` (
  `id`          INT AUTO_INCREMENT PRIMARY KEY,
  `bulan`       CHAR(6)     NOT NULL,
  `up3_kode`    VARCHAR(10) NOT NULL,
  `daya_group`  VARCHAR(30) NOT NULL COMMENT '≤450 VA, 900 VA, 1.300-2.200 VA, dst.',
  `pelanggan`   INT         NOT NULL DEFAULT 0,
  `total_kwh`   BIGINT      NOT NULL DEFAULT 0,
  UNIQUE KEY `uk_bm_daya` (`bulan`, `up3_kode`, `daya_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── 5. Tabel jam pembacaan per UP3 per bulan ────────────────────────────────
CREATE TABLE IF NOT EXISTS `baca_meter_jam` (
  `id`        INT AUTO_INCREMENT PRIMARY KEY,
  `bulan`     CHAR(6)     NOT NULL COMMENT 'YYYYMM',
  `up3_kode`  VARCHAR(10) NOT NULL,
  `jam`       TINYINT     NOT NULL COMMENT 'Jam pembacaan 0-23',
  `jumlah`    INT         NOT NULL DEFAULT 0,
  UNIQUE KEY `uk_bm_jam` (`bulan`, `up3_kode`, `jam`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── 6. Daftarkan modul di domain_modules ────────────────────────────────────
-- Pastikan domain energi-jabar sudah ada (id = 1 atau sesuai)
INSERT INTO `domain_modules`
  (domain_id, slug, name, description, section, status, data_updated_at, url_token)
SELECT
  d.id,
  'baca-meter',
  'Baca Meter Pascabayar',
  'Agregat pembacaan meter pelanggan pascabayar PLN Jawa Barat — 18 UP3, data bulanan 2026',
  4,
  'aktif',
  NOW(),
  LOWER(REPLACE(UUID(), '-', ''))
FROM `domains` d
WHERE d.slug = 'energi-jabar'
  AND NOT EXISTS (
    SELECT 1 FROM `domain_modules` m
    WHERE m.domain_id = d.id AND m.slug = 'baca-meter'
  )
LIMIT 1;

-- Tampilkan token yang digenerate (untuk referensi)
SELECT slug, url_token, status, data_updated_at
FROM `domain_modules`
WHERE slug = 'baca-meter';
