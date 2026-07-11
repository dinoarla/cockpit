-- ============================================================
-- Register module: simba (SIMBA BBM Monitoring)
-- Domain: energi-jabar (must already exist)
-- Run this in phpMyAdmin on Hostinger production DB
-- ============================================================

-- Insert module simba (aktif, with url_token)
--   url_token: unique 12-char token — change only if collision
INSERT INTO `domain_modules`
  (`domain_id`, `slug`, `url_token`, `nama`, `route_path`, `sensitivitas`, `status`, `data_updated_at`, `created_at`)
SELECT
  d.`id`,
  'simba',
  'smb15kalbr1',
  'SIMBA — Monitoring BBM PLTD/PLTG Kalimantan Barat',
  '/modules/energi-jabar/simba/',
  'internal',
  'aktif',
  NOW(),
  NOW()
FROM `domains` d
WHERE d.`slug` = 'energi-jabar'
ON DUPLICATE KEY UPDATE
  `status`          = 'aktif',
  `url_token`       = IF(`url_token` IS NULL, 'smb15kalbr1', `url_token`),
  `data_updated_at` = NOW();

-- Verify
SELECT
  d.slug   AS domain,
  m.slug   AS module,
  m.url_token,
  m.status,
  m.sensitivitas,
  m.data_updated_at
FROM domain_modules m
JOIN domains d ON d.id = m.domain_id
WHERE d.slug = 'energi-jabar'
ORDER BY m.slug;
