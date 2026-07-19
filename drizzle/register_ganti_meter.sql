-- =============================================================================
-- register_ganti_meter.sql
-- Daftarkan modul Penggantian kWh Meter di domain_modules
-- Domain: energi-jabar · Section 04: Distribusi Tenaga Listrik
-- Jalankan di phpMyAdmin setelah import_ganti_meter.py selesai
-- =============================================================================

SET NAMES utf8mb4;

-- INSERT jika belum ada
INSERT INTO `domain_modules`
  (`domain_id`, `slug`, `url_token`, `nama`, `route_path`, `sensitivitas`, `status`, `data_updated_at`, `created_at`)
SELECT
  d.`id`,
  'ganti-meter',
  'gantimtr24',
  'Penggantian kWh Meter',
  '/modules/energi-jabar/ganti-meter/',
  'internal',
  'aktif',
  NOW(),
  NOW()
FROM `domains` d
WHERE d.`slug` = 'energi-jabar'
  AND NOT EXISTS (
    SELECT 1 FROM `domain_modules` m
    WHERE m.`domain_id` = d.`id` AND m.`slug` = 'ganti-meter'
  )
LIMIT 1;

-- UPDATE jika sudah ada tapi token NULL atau status bukan aktif
UPDATE `domain_modules` dm
JOIN `domains` d ON dm.`domain_id` = d.`id` AND d.`slug` = 'energi-jabar'
SET
  dm.`url_token`      = 'gantimtr24',
  dm.`status`         = 'aktif',
  dm.`data_updated_at` = NOW()
WHERE dm.`slug` = 'ganti-meter'
  AND (dm.`url_token` IS NULL OR dm.`url_token` = '' OR dm.`status` != 'aktif');

-- Tampilkan hasil
SELECT slug, url_token, nama, status, data_updated_at, created_at
FROM `domain_modules`
WHERE slug = 'ganti-meter';
