-- =============================================================================
-- register_ganti_meter.sql
-- Daftarkan modul Penggantian kWh Meter di domain_modules
-- Domain: energi-jabar · Section 04: Distribusi Tenaga Listrik
-- Jalankan SETELAH import dari import_ganti_meter.py
-- =============================================================================

SET NAMES utf8mb4;

INSERT INTO `domain_modules`
  (`domain_id`, `slug`, `url_token`, `nama`, `route_path`, `sensitivitas`, `status`, `data_updated_at`, `created_at`)
SELECT
  d.`id`,
  'ganti-meter',
  'gantimeter2024',
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

-- Tampilkan hasil
SELECT slug, url_token, nama, status, data_updated_at
FROM `domain_modules`
WHERE slug = 'ganti-meter';
