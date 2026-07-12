-- ============================================================
-- Deactivate proteksi-distribusi — modul digabung ke proteksi-transmisi
-- Run this in phpMyAdmin on Hostinger production DB
-- (Safe to run even if the row never existed — affects 0 rows)
-- ============================================================

UPDATE `domain_modules`
SET
  `status`          = 'nonaktif',
  `data_updated_at` = NOW()
WHERE `slug` = 'proteksi-distribusi';

-- Update nama modul proteksi-transmisi (jika sudah teregister sebelumnya)
UPDATE `domain_modules`
SET
  `nama`            = 'Studi Proteksi Sistem Tenaga Listrik',
  `data_updated_at` = NOW()
WHERE `slug` = 'proteksi-transmisi';

-- Verify
SELECT slug, nama, url_token, status FROM domain_modules
WHERE slug IN ('proteksi-distribusi', 'proteksi-transmisi');
