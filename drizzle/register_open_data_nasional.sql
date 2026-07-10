-- ============================================================
-- Register domain: open-data-nasional
-- Register module: rkpd-jabar (RKPD Jawa Barat 2026)
-- Run this in phpMyAdmin on Hostinger production DB
-- ============================================================

-- 1. Insert domain (skip if already exists)
INSERT IGNORE INTO `domains` (`slug`, `nama`, `deskripsi`, `is_active`, `created_at`)
VALUES (
  'open-data-nasional',
  'Open-Source Data Nasional',
  'Kumpulan data publik nasional — tata ruang & pemerintahan, iklim & lingkungan, geospasial, dan sosial-kependudukan dari berbagai sumber terbuka',
  TRUE,
  NOW()
);

-- 2. Insert module rkpd-jabar (aktif, with url_token)
--    The url_token below can be changed — must be unique & max 12 chars
INSERT INTO `domain_modules`
  (`domain_id`, `slug`, `url_token`, `nama`, `route_path`, `sensitivitas`, `status`, `data_updated_at`, `created_at`)
SELECT
  d.`id`,
  'rkpd-jabar',
  'rk26jb2025a',
  'RKPD Jawa Barat 2026',
  '/modules/open-data-nasional/rkpd-jabar/',
  'publik',
  'aktif',
  NOW(),
  NOW()
FROM `domains` d
WHERE d.`slug` = 'open-data-nasional'
ON DUPLICATE KEY UPDATE
  `status`          = 'aktif',
  `url_token`       = IF(`url_token` IS NULL, 'rk26jb2025a', `url_token`),
  `data_updated_at` = NOW();

-- 3. Verify
SELECT
  d.slug   AS domain,
  m.slug   AS module,
  m.url_token,
  m.status,
  m.data_updated_at
FROM domain_modules m
JOIN domains d ON d.id = m.domain_id
WHERE d.slug = 'open-data-nasional'
ORDER BY m.slug;
