-- ============================================================
-- Register 3 modul transmisi: sistem-transmisi, rencana-transmisi, proteksi-transmisi
-- Domain: energi-jabar · Section 03: Transmisi
-- Run this in phpMyAdmin on Hostinger production DB
-- ============================================================

-- ── 1. sistem-transmisi ──────────────────────────────────────
INSERT INTO `domain_modules`
  (`domain_id`, `slug`, `url_token`, `nama`, `route_path`, `sensitivitas`, `status`, `data_updated_at`, `created_at`)
SELECT
  d.`id`,
  'sistem-transmisi',
  'sistrans2024',
  'Topologi & Keandalan Sistem Transmisi',
  '/modules/energi-jabar/sistem-transmisi/',
  'internal',
  'aktif',
  NOW(),
  NOW()
FROM `domains` d
WHERE d.`slug` = 'energi-jabar'
ON DUPLICATE KEY UPDATE
  `status`          = 'aktif',
  `url_token`       = IF(`url_token` IS NULL, 'sistrans2024', `url_token`),
  `data_updated_at` = NOW();

-- ── 2. rencana-transmisi ─────────────────────────────────────
INSERT INTO `domain_modules`
  (`domain_id`, `slug`, `url_token`, `nama`, `route_path`, `sensitivitas`, `status`, `data_updated_at`, `created_at`)
SELECT
  d.`id`,
  'rencana-transmisi',
  'rentrans2025',
  'Rencana Pengembangan & Investasi Transmisi',
  '/modules/energi-jabar/rencana-transmisi/',
  'internal',
  'aktif',
  NOW(),
  NOW()
FROM `domains` d
WHERE d.`slug` = 'energi-jabar'
ON DUPLICATE KEY UPDATE
  `status`          = 'aktif',
  `url_token`       = IF(`url_token` IS NULL, 'rentrans2025', `url_token`),
  `data_updated_at` = NOW();

-- ── 3. proteksi-transmisi ────────────────────────────────────
INSERT INTO `domain_modules`
  (`domain_id`, `slug`, `url_token`, `nama`, `route_path`, `sensitivitas`, `status`, `data_updated_at`, `created_at`)
SELECT
  d.`id`,
  'proteksi-transmisi',
  'prottrans2024',
  'Studi Proteksi Sistem Tenaga Listrik',
  '/modules/energi-jabar/proteksi-transmisi/',
  'internal',
  'aktif',
  NOW(),
  NOW()
FROM `domains` d
WHERE d.`slug` = 'energi-jabar'
ON DUPLICATE KEY UPDATE
  `status`          = 'aktif',
  `url_token`       = IF(`url_token` IS NULL, 'prottrans2024', `url_token`),
  `data_updated_at` = NOW();

-- ── Verify semua modul energi-jabar Section Transmisi ────────
SELECT
  d.slug AS domain, m.slug AS module, m.url_token, m.status, m.sensitivitas
FROM domain_modules m
JOIN domains d ON d.id = m.domain_id
WHERE d.slug = 'energi-jabar'
  AND m.slug IN ('sistem-transmisi','rencana-transmisi','proteksi-transmisi','egla-pkdn')
ORDER BY m.slug;
