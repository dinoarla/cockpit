-- =============================================================================
-- register_riset_akademik.sql
-- Domain baru: Riset & Akademik
-- Jalankan di phpMyAdmin: Database u164655286_cockpit → tab SQL
-- =============================================================================

SET NAMES utf8mb4;

-- ── 1. Insert domain ──────────────────────────────────────────────────────────
INSERT INTO `domains` (`slug`, `nama`, `deskripsi`, `is_active`)
VALUES (
  'riset-akademik',
  'Riset & Akademik',
  'Repositori personal untuk mendukung riset PhD — progress disertasi, pipeline publikasi, peta literatur, dan registri dataset penelitian',
  true
)
ON DUPLICATE KEY UPDATE
  `nama`      = VALUES(`nama`),
  `deskripsi` = VALUES(`deskripsi`),
  `is_active` = true;

-- ── 2. Insert modules ─────────────────────────────────────────────────────────
INSERT INTO `domain_modules`
  (`domain_id`, `slug`, `url_token`, `nama`, `route_path`, `sensitivitas`, `status`, `data_updated_at`, `created_at`)
SELECT d.`id`, 'dissertation-tracker', 'disstrack24',  'Dissertation Tracker', '/modules/riset-akademik/dissertation-tracker/', 'internal', 'aktif', NOW(), NOW() FROM `domains` d WHERE d.`slug` = 'riset-akademik'
UNION ALL
SELECT d.`id`, 'literature-map',       'litmap24',     'Literature Map',       '/modules/riset-akademik/literature-map/',       'internal', 'aktif', NOW(), NOW() FROM `domains` d WHERE d.`slug` = 'riset-akademik'
UNION ALL
SELECT d.`id`, 'dataset-registry',     'datareg24',    'Dataset Registry',     '/modules/riset-akademik/dataset-registry/',     'internal', 'aktif', NOW(), NOW() FROM `domains` d WHERE d.`slug` = 'riset-akademik'
UNION ALL
SELECT d.`id`, 'paper-pipeline',       'ppipeline24',  'Paper Pipeline',       '/modules/riset-akademik/paper-pipeline/',       'internal', 'aktif', NOW(), NOW() FROM `domains` d WHERE d.`slug` = 'riset-akademik'
ON DUPLICATE KEY UPDATE
  `url_token`      = VALUES(`url_token`),
  `status`         = 'aktif',
  `data_updated_at`= NOW();

-- ── 3. Verifikasi ─────────────────────────────────────────────────────────────
SELECT dm.slug, dm.url_token, dm.nama, dm.status, d.nama AS domain
FROM `domain_modules` dm
JOIN `domains` d ON dm.`domain_id` = d.`id`
WHERE d.`slug` = 'riset-akademik'
ORDER BY dm.slug;
