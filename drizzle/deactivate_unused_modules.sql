-- =============================================================================
-- deactivate_unused_modules.sql
-- Nonaktifkan dissertation-tracker & dataset-registry (belum digunakan)
-- Jalankan di phpMyAdmin: Database u164655286_cockpit → tab SQL
-- =============================================================================

UPDATE `domain_modules`
SET `status` = 'segera', `data_updated_at` = NOW()
WHERE `slug` IN ('dissertation-tracker', 'dataset-registry');

-- Verifikasi
SELECT slug, nama, status FROM `domain_modules`
WHERE `slug` IN ('dissertation-tracker', 'dataset-registry');
