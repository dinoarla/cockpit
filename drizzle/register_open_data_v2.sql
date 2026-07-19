-- =============================================================================
-- register_open_data_v2.sql
-- Aktifkan 6 modul Open Data Nasional (sudah ada di DB dari FULL_SETUP)
-- Jalankan di phpMyAdmin: Database u164655286_cockpit → tab SQL
-- =============================================================================

SET NAMES utf8mb4;

UPDATE `domain_modules` dm
JOIN `domains` d ON dm.`domain_id` = d.`id` AND d.`slug` = 'open-data-nasional'
SET
  dm.`status`          = 'aktif',
  dm.`data_updated_at` = NOW()
WHERE dm.`slug` IN ('apbd-jabar', 'iklim-cuaca', 'indeks-bencana', 'gis-jabar', 'peta-admin', 'data-kemiskinan');

-- Tampilkan hasil
SELECT slug, url_token, status, data_updated_at
FROM `domain_modules`
WHERE slug IN ('apbd-jabar', 'iklim-cuaca', 'indeks-bencana', 'gis-jabar', 'peta-admin', 'data-kemiskinan')
ORDER BY slug;
