-- =============================================================================
-- create_literature_tables.sql
-- Tabel untuk Literature Map (Riset & Akademik)
-- Jalankan di phpMyAdmin: Database u164655286_cockpit → tab SQL
-- =============================================================================

CREATE TABLE IF NOT EXISTS `literature_items` (
  `id`         INT AUTO_INCREMENT PRIMARY KEY,
  `zotero_key` VARCHAR(32) DEFAULT NULL,
  `title`      TEXT NOT NULL,
  `authors`    VARCHAR(500) DEFAULT NULL,
  `year`       INT DEFAULT NULL,
  `journal`    VARCHAR(300) DEFAULT NULL,
  `doi`        VARCHAR(200) DEFAULT NULL,
  `themes`     TEXT DEFAULT '[]',
  `status`     VARCHAR(20) NOT NULL DEFAULT 'belum',
  `relevance`  INT NOT NULL DEFAULT 3,
  `cited_in`   TEXT DEFAULT '[]',
  `notes`      TEXT DEFAULT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `lit_zotero_key_idx` (`zotero_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `literature_config` (
  `id`    INT AUTO_INCREMENT PRIMARY KEY,
  `key`   VARCHAR(50) NOT NULL,
  `value` TEXT DEFAULT NULL,
  UNIQUE KEY `lit_config_key_idx` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
