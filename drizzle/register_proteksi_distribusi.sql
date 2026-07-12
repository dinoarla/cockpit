-- ============================================================
-- Register module: proteksi-distribusi
-- Studi Proteksi Sistem Distribusi
-- Domain: energi-jabar · Section 04: Distribusi Tenaga Listrik
-- Run this in phpMyAdmin on Hostinger production DB
-- ============================================================

INSERT INTO `domain_modules`
  (`domain_id`, `slug`, `url_token`, `nama`, `route_path`, `sensitivitas`, `status`, `data_updated_at`, `created_at`)
SELECT
  d.`id`,
  'proteksi-distribusi',
  'protdis2025',
  'Studi Proteksi Sistem Distribusi',
  '/modules/energi-jabar/proteksi-distribusi/',
  'internal',
  'aktif',
  NOW(),
  NOW()
FROM `domains` d
WHERE d.`slug` = 'energi-jabar'
ON DUPLICATE KEY UPDATE
  `status`          = 'aktif',
  `url_token`       = IF(`url_token` IS NULL, 'protdis2025', `url_token`),
  `data_updated_at` = NOW();

-- Verify
SELECT
  d.slug AS domain, m.slug AS module, m.url_token, m.status, m.sensitivitas
FROM domain_modules m
JOIN domains d ON d.id = m.domain_id
WHERE d.slug = 'energi-jabar' AND m.slug = 'proteksi-distribusi';
