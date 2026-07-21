-- =============================================================================
-- create_my_works_citations.sql
-- Tabel My Works (karya sendiri) + Literature Citations
-- Jalankan di phpMyAdmin: Database u164655286_cockpit → tab SQL
-- =============================================================================

CREATE TABLE IF NOT EXISTS `my_works` (
  `id`         INT AUTO_INCREMENT PRIMARY KEY,
  `slug`       VARCHAR(100) NOT NULL,
  `title`      TEXT NOT NULL,
  `type`       VARCHAR(20) NOT NULL DEFAULT 'dissertation',
  `year`       INT DEFAULT NULL,
  `structure`  TEXT DEFAULT '[]',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `my_works_slug_idx` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `literature_citations` (
  `id`         INT AUTO_INCREMENT PRIMARY KEY,
  `lit_id`     INT NOT NULL,
  `work_slug`  VARCHAR(100) NOT NULL,
  `section`    VARCHAR(100) NOT NULL DEFAULT '',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `lit_work_section_idx` (`lit_id`, `work_slug`, `section`),
  KEY `lit_id_idx` (`lit_id`),
  KEY `work_slug_idx` (`work_slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Seed: Disertasi Anda
INSERT IGNORE INTO `my_works` (`slug`, `title`, `type`, `year`, `structure`) VALUES (
  'disertasi-jabar',
  'Transisi Energi Jawa Barat: Bauran Energi, Distribusi, dan Implikasi Kebijakan',
  'dissertation',
  2026,
  '[
    {"id":"bab-1","label":"Bab 1 — Pendahuluan & Latar Belakang"},
    {"id":"bab-2","label":"Bab 2 — Tinjauan Pustaka"},
    {"id":"bab-3","label":"Bab 3 — Metodologi Penelitian"},
    {"id":"bab-4","label":"Bab 4 — Bauran Energi & Transisi Jabar"},
    {"id":"bab-5","label":"Bab 5 — Distribusi, Keandalan & Akses"},
    {"id":"bab-6","label":"Bab 6 — Pembahasan & Implikasi Kebijakan"},
    {"id":"bab-7","label":"Bab 7 — Kesimpulan & Rekomendasi"}
  ]'
);
