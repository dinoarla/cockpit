-- =============================================================================
-- register_open_data_v2.sql
-- Daftarkan 6 modul Open Data Nasional ke domain_modules
-- url_token maks 12 karakter (VARCHAR(12) UNIQUE)
-- Jalankan di phpMyAdmin: Database u164655286_cockpit → tab SQL
-- =============================================================================

SET NAMES utf8mb4;

INSERT INTO `domain_modules`
  (`domain_id`, `slug`, `url_token`, `nama`, `route_path`, `sensitivitas`, `status`, `data_updated_at`, `created_at`)
SELECT d.`id`, m.`slug`, m.`token`, m.`nama`, m.`path`, 'publik', 'aktif', NOW(), NOW()
FROM `domains` d
JOIN (
  SELECT 'apbd-jabar'      AS `slug`, 'apbdjbr2024' AS `token`, 'APBD Jawa Barat'              AS `nama`, '/modules/open-data-nasional/apbd-jabar/'      AS `path` UNION ALL
  SELECT 'iklim-cuaca',               'iklim24jbr',             'Data Iklim dan Cuaca',               '/modules/open-data-nasional/iklim-cuaca/'         UNION ALL
  SELECT 'indeks-bencana',            'irbi24jabar',            'Indeks Risiko Bencana',              '/modules/open-data-nasional/indeks-bencana/'      UNION ALL
  SELECT 'gis-jabar',                 'gisjabar2024',           'Data Geografis / GIS',               '/modules/open-data-nasional/gis-jabar/'           UNION ALL
  SELECT 'peta-admin',                'petaadm2024',            'Peta Administrasi Wilayah',          '/modules/open-data-nasional/peta-admin/'          UNION ALL
  SELECT 'data-kemiskinan',           'miskin24jbr',            'Data Kemiskinan & Sosial',           '/modules/open-data-nasional/data-kemiskinan/'
) m ON 1=1
WHERE d.`slug` = 'open-data-nasional'
  AND NOT EXISTS (
    SELECT 1 FROM `domain_modules` x
    WHERE x.`domain_id` = d.`id` AND x.`slug` = m.`slug`
  );

-- Jika modul sudah ada tapi url_token NULL, update tokennya:
UPDATE `domain_modules` dm
JOIN `domains` d ON dm.`domain_id` = d.`id` AND d.`slug` = 'open-data-nasional'
JOIN (
  SELECT 'apbd-jabar'      AS `slug`, 'apbdjbr2024'  AS `token` UNION ALL
  SELECT 'iklim-cuaca',               'iklim24jbr'              UNION ALL
  SELECT 'indeks-bencana',            'irbi24jabar'             UNION ALL
  SELECT 'gis-jabar',                 'gisjabar2024'            UNION ALL
  SELECT 'peta-admin',                'petaadm2024'             UNION ALL
  SELECT 'data-kemiskinan',           'miskin24jbr'
) m ON dm.`slug` = m.`slug`
SET dm.`url_token` = m.`token`, dm.`status` = 'aktif', dm.`data_updated_at` = NOW()
WHERE dm.`url_token` IS NULL OR dm.`url_token` = '';

-- Tampilkan hasil
SELECT slug, url_token, status, data_updated_at
FROM `domain_modules`
WHERE slug IN ('apbd-jabar','iklim-cuaca','indeks-bencana','gis-jabar','peta-admin','data-kemiskinan')
ORDER BY slug;
