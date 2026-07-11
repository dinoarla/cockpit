-- ============================================================
-- Register module: egla-pkdn (EGLA SUTT 70 kV Parakan-Kadipaten)
-- Domain: energi-jabar · Section 03: Transmisi
-- Run this in phpMyAdmin on Hostinger production DB
-- ============================================================

INSERT INTO `domain_modules`
  (`domain_id`, `slug`, `url_token`, `nama`, `route_path`, `sensitivitas`, `status`, `data_updated_at`, `created_at`)
SELECT
  d.`id`,
  'egla-pkdn',
  'eg70pkdn2026',
  'EGLA SUTT 70 kV Parakan–Kadipaten',
  '/modules/energi-jabar/egla-pkdn/',
  'internal',
  'aktif',
  NOW(),
  NOW()
FROM `domains` d
WHERE d.`slug` = 'energi-jabar'
ON DUPLICATE KEY UPDATE
  `status`          = 'aktif',
  `url_token`       = IF(`url_token` IS NULL, 'eg70pkdn2026', `url_token`),
  `data_updated_at` = NOW();

-- Verify
SELECT
  d.slug AS domain, m.slug AS module, m.url_token, m.status, m.sensitivitas
FROM domain_modules m
JOIN domains d ON d.id = m.domain_id
WHERE d.slug = 'energi-jabar' AND m.slug = 'egla-pkdn';
