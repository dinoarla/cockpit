-- =============================================================================
-- register_ganti_meter.sql
-- Daftarkan modul Penggantian kWh Meter di domain_modules
-- Jalankan SETELAH import dari import_ganti_meter.py
-- =============================================================================

SET NAMES utf8mb4;

-- Daftarkan modul di domain_modules (domain energi-jabar)
INSERT INTO `domain_modules`
  (domain_id, slug, nama, route_path, sensitivitas, status, data_updated_at, url_token)
SELECT
  d.id,
  'ganti-meter',
  'Penggantian kWh Meter',
  '/modules/energi-jabar/ganti-meter/',
  'internal',
  'aktif',
  NOW(),
  LOWER(REPLACE(UUID(), '-', ''))
FROM `domains` d
WHERE d.slug = 'energi-jabar'
  AND NOT EXISTS (
    SELECT 1 FROM `domain_modules` m
    WHERE m.domain_id = d.id AND m.slug = 'ganti-meter'
  )
LIMIT 1;

-- Tampilkan token yang digenerate
SELECT slug, url_token, status, data_updated_at
FROM `domain_modules`
WHERE slug = 'ganti-meter';
