-- =============================================================================
-- register_my_works_module.sql
-- Daftarkan modul My Works ke domain riset-akademik
-- Jalankan di phpMyAdmin: Database u164655286_cockpit → tab SQL
-- =============================================================================

INSERT INTO `domain_modules`
  (`domain_id`, `slug`, `url_token`, `nama`, `route_path`, `sensitivitas`, `status`, `data_updated_at`, `created_at`)
SELECT d.`id`, 'my-works', 'myworks24', 'My Works', '/modules/riset-akademik/my-works/', 'internal', 'aktif', NOW(), NOW()
FROM `domains` d WHERE d.`slug` = 'riset-akademik'
ON DUPLICATE KEY UPDATE
  `url_token`       = VALUES(`url_token`),
  `status`          = 'aktif',
  `data_updated_at` = NOW();

SELECT dm.slug, dm.url_token, dm.nama, dm.status
FROM `domain_modules` dm
JOIN `domains` d ON dm.`domain_id` = d.`id`
WHERE d.`slug` = 'riset-akademik'
ORDER BY dm.slug;
