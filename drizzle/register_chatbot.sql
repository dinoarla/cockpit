-- =============================================================================
-- register_chatbot.sql
-- Daftarkan domain 'asisten' dan modul 'chatbot' ke database COCKPIT
-- Jalankan via phpMyAdmin pada database u164655286_cockpit
-- =============================================================================

SET NAMES utf8mb4;

-- 1. Buat domain 'asisten' jika belum ada
INSERT INTO `domains` (`slug`, `nama`, `deskripsi`, `is_active`)
SELECT 'asisten', 'Asisten AI', 'Alat bantu berbasis AI untuk query data COCKPIT', true
WHERE NOT EXISTS (SELECT 1 FROM `domains` WHERE `slug` = 'asisten');

-- 2. Daftarkan modul chatbot
INSERT INTO `domain_modules`
  (`domain_id`, `slug`, `url_token`, `nama`, `route_path`, `sensitivitas`, `status`)
SELECT
  d.id,
  'chatbot',
  SUBSTRING(MD5(RAND()), 1, 12),
  'Asisten AI',
  '/modules/asisten/chatbot/',
  'internal',
  'aktif'
FROM `domains` d
WHERE d.slug = 'asisten'
  AND NOT EXISTS (
    SELECT 1 FROM `domain_modules` m
    WHERE m.domain_id = d.id AND m.slug = 'chatbot'
  )
LIMIT 1;

-- 3. Tampilkan URL yang dihasilkan — catat hasilnya!
SELECT
  CONCAT('/modules/asisten/', m.url_token, '/') AS url_chatbot,
  m.url_token,
  m.status
FROM `domain_modules` m
JOIN `domains` d ON d.id = m.domain_id
WHERE d.slug = 'asisten' AND m.slug = 'chatbot';
