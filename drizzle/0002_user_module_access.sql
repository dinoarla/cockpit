-- Migrasi: tambah tabel user_module_access untuk akses per-modul
-- Jalankan di server: mysql -u u164655286_cockpit -p u164655286_cockpit < drizzle/0002_user_module_access.sql

CREATE TABLE IF NOT EXISTS `user_module_access` (
  `user_id`    int NOT NULL,
  `module_id`  int NOT NULL,
  `granted_at` timestamp NOT NULL DEFAULT (now()),
  `granted_by` int,
  CONSTRAINT `user_module_access_pk` PRIMARY KEY(`user_id`, `module_id`),
  INDEX `uma_user_idx` (`user_id`)
);
