-- ============================================================
-- FULL SETUP — Pusat Data PLN & Jawa Barat
-- Copy seluruh isi file ini ke phpMyAdmin → tab SQL → Execute
-- ============================================================

-- BAGIAN 1: BUAT SEMUA TABEL

-- Arsitektur domain & modul (§4 PRD)
CREATE TABLE `domains` (
	`id` int AUTO_INCREMENT NOT NULL,
	`slug` varchar(50) NOT NULL,
	`nama` varchar(150) NOT NULL,
	`deskripsi` text,
	`is_active` boolean NOT NULL DEFAULT true,
	`created_at` timestamp NOT NULL DEFAULT (now()),
	CONSTRAINT `domains_id` PRIMARY KEY(`id`),
	CONSTRAINT `domains_slug_unique` UNIQUE(`slug`)
);

CREATE TABLE `domain_modules` (
	`id` int AUTO_INCREMENT NOT NULL,
	`domain_id` int NOT NULL,
	`slug` varchar(50) NOT NULL,
	`nama` varchar(150) NOT NULL,
	`route_path` varchar(100) NOT NULL,
	`sensitivitas` enum('publik','internal','sensitif') NOT NULL DEFAULT 'internal',
	`status` enum('aktif','draft','arsip') NOT NULL DEFAULT 'draft',
	`created_at` timestamp NOT NULL DEFAULT (now()),
	CONSTRAINT `domain_modules_id` PRIMARY KEY(`id`)
);

CREATE TABLE `user_domain_access` (
	`user_id` int NOT NULL,
	`domain_id` int NOT NULL,
	`access_level` enum('read','write','admin') NOT NULL,
	`granted_at` timestamp NOT NULL DEFAULT (now()),
	`granted_by` int,
	CONSTRAINT `user_domain_access_pk` PRIMARY KEY(`user_id`, `domain_id`)
);

CREATE TABLE `dataset_sources` (
	`id` int AUTO_INCREMENT NOT NULL,
	`domain_module_id` int NOT NULL,
	`nama_sumber` varchar(255) NOT NULL,
	`jenis_sumber` varchar(100),
	`url_atau_referensi` text,
	`tanggal_akses` date,
	`catatan_metodologi` text,
	`created_at` timestamp NOT NULL DEFAULT (now()),
	CONSTRAINT `dataset_sources_id` PRIMARY KEY(`id`)
);

CREATE TABLE `login_audit` (
	`id` int AUTO_INCREMENT NOT NULL,
	`username` varchar(64) NOT NULL,
	`success` boolean NOT NULL,
	`ip_address` varchar(45),
	`user_agent` varchar(255),
	`reason` varchar(100),
	`created_at` timestamp NOT NULL DEFAULT (now()),
	CONSTRAINT `login_audit_id` PRIMARY KEY(`id`)
);

CREATE TABLE `ruptl_pelanggan_historis` (
	`id` int AUTO_INCREMENT NOT NULL,
	`provinsi_id` int NOT NULL,
	`tahun` int NOT NULL,
	`sektor` enum('RUMAH_TANGGA','BISNIS','PUBLIK','INDUSTRI') NOT NULL,
	`jumlah_ribu` decimal(10,2),
	CONSTRAINT `ruptl_pelanggan_historis_id` PRIMARY KEY(`id`)
);

CREATE TABLE `ruptl_pembangkit_eksisting` (
	`id` int AUTO_INCREMENT NOT NULL,
	`provinsi_id` int NOT NULL,
	`pemilik` enum('PLN','IPP') NOT NULL DEFAULT 'PLN',
	`jenis` varchar(20) NOT NULL,
	`sistem_tenaga_listrik` varchar(50),
	`jumlah_unit` int,
	`kapasitas_mw` decimal(10,2),
	`daya_mampu_mw` decimal(10,2),
	`dmp_mw` decimal(10,2),
	CONSTRAINT `ruptl_pembangkit_eksisting_id` PRIMARY KEY(`id`)
);

CREATE TABLE `ruptl_penjualan_historis` (
	`id` int AUTO_INCREMENT NOT NULL,
	`provinsi_id` int NOT NULL,
	`tahun` int NOT NULL,
	`sektor` enum('RUMAH_TANGGA','BISNIS','PUBLIK','INDUSTRI') NOT NULL,
	`gwh` decimal(10,2),
	CONSTRAINT `ruptl_penjualan_historis_id` PRIMARY KEY(`id`)
);

CREATE TABLE `ruptl_provinsi` (
	`id` int AUTO_INCREMENT NOT NULL,
	`kode` varchar(5) NOT NULL,
	`nama` varchar(100) NOT NULL,
	`lampiran` varchar(2) NOT NULL,
	`wilayah_sistem` varchar(60) NOT NULL,
	`beban_puncak_2024_mw` decimal(10,2),
	CONSTRAINT `ruptl_provinsi_id` PRIMARY KEY(`id`),
	CONSTRAINT `ruptl_provinsi_kode_unique` UNIQUE(`kode`)
);

CREATE TABLE `ruptl_proyeksi_kebutuhan` (
	`id` int AUTO_INCREMENT NOT NULL,
	`provinsi_id` int NOT NULL,
	`tahun` int NOT NULL,
	`pertumbuhan_ekonomi_pct` decimal(5,2),
	`sales_gwh` decimal(10,2),
	`produksi_gwh` decimal(10,2),
	`beban_puncak_mw` decimal(10,2),
	`pelanggan` int,
	CONSTRAINT `ruptl_proyeksi_kebutuhan_id` PRIMARY KEY(`id`)
);

CREATE TABLE `ruptl_rencana_gardu_induk` (
	`id` int AUTO_INCREMENT NOT NULL,
	`provinsi_id` int NOT NULL,
	`skenario` enum('RE_BASE','ARED') NOT NULL,
	`tahun` int NOT NULL,
	`mva` decimal(10,2),
	CONSTRAINT `ruptl_rencana_gardu_induk_id` PRIMARY KEY(`id`)
);

CREATE TABLE `ruptl_rencana_pembangkit` (
	`id` int AUTO_INCREMENT NOT NULL,
	`provinsi_id` int NOT NULL,
	`skenario` enum('RE_BASE','ARED') NOT NULL,
	`jenis` varchar(30) NOT NULL,
	`nama` varchar(200),
	`kapasitas_mw` decimal(10,2),
	`cod_tahun` int,
	`keterangan` varchar(500),
	CONSTRAINT `ruptl_rencana_pembangkit_id` PRIMARY KEY(`id`)
);

CREATE TABLE `ruptl_rencana_transmisi` (
	`id` int AUTO_INCREMENT NOT NULL,
	`provinsi_id` int NOT NULL,
	`skenario` enum('RE_BASE','ARED') NOT NULL,
	`tahun` int NOT NULL,
	`kms` decimal(10,2),
	CONSTRAINT `ruptl_rencana_transmisi_id` PRIMARY KEY(`id`)
);

CREATE TABLE `sessions` (
	`id` varchar(64) NOT NULL,
	`user_id` int NOT NULL,
	`user_agent` varchar(255),
	`ip_address` varchar(45),
	`created_at` timestamp NOT NULL DEFAULT (now()),
	`expires_at` timestamp NOT NULL,
	CONSTRAINT `sessions_id` PRIMARY KEY(`id`)
);

CREATE TABLE `users` (
	`id` int AUTO_INCREMENT NOT NULL,
	`username` varchar(64) NOT NULL,
	`email` varchar(255) NOT NULL,
	`password_hash` varchar(255) NOT NULL,
	`role` enum('admin','editor','viewer') NOT NULL DEFAULT 'viewer',
	`is_active` boolean NOT NULL DEFAULT true,
	`failed_login_count` int NOT NULL DEFAULT 0,
	`locked_until` timestamp,
	`created_at` timestamp NOT NULL DEFAULT (now()),
	`updated_at` timestamp NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
	CONSTRAINT `users_id` PRIMARY KEY(`id`),
	CONSTRAINT `users_username_unique` UNIQUE(`username`),
	CONSTRAINT `users_email_unique` UNIQUE(`email`)
);

-- BAGIAN 2: BUAT INDEX

CREATE UNIQUE INDEX `domain_modules_domain_slug_uniq` ON `domain_modules` (`domain_id`, `slug`);
CREATE INDEX `login_audit_username_idx` ON `login_audit` (`username`);
CREATE INDEX `login_audit_created_at_idx` ON `login_audit` (`created_at`);
CREATE INDEX `pelanggan_prov_tahun_idx` ON `ruptl_pelanggan_historis` (`provinsi_id`,`tahun`);
CREATE INDEX `pembangkit_eks_prov_idx` ON `ruptl_pembangkit_eksisting` (`provinsi_id`);
CREATE INDEX `penjualan_prov_tahun_idx` ON `ruptl_penjualan_historis` (`provinsi_id`,`tahun`);
CREATE INDEX `proyeksi_prov_tahun_idx` ON `ruptl_proyeksi_kebutuhan` (`provinsi_id`,`tahun`);
CREATE INDEX `gi_prov_sken_tahun_idx` ON `ruptl_rencana_gardu_induk` (`provinsi_id`,`skenario`,`tahun`);
CREATE INDEX `rencana_prov_sken_idx` ON `ruptl_rencana_pembangkit` (`provinsi_id`,`skenario`);
CREATE INDEX `rencana_cod_idx` ON `ruptl_rencana_pembangkit` (`cod_tahun`);
CREATE INDEX `transmisi_prov_sken_tahun_idx` ON `ruptl_rencana_transmisi` (`provinsi_id`,`skenario`,`tahun`);
CREATE INDEX `sessions_user_id_idx` ON `sessions` (`user_id`);
CREATE INDEX `sessions_expires_at_idx` ON `sessions` (`expires_at`);

-- ============================================================
-- BAGIAN 3: DATA AWAL
-- ============================================================

-- Domain: Energi Jawa Barat (domain pertama)
INSERT INTO domains (slug, nama, deskripsi, is_active) VALUES
('energi-jabar', 'Energi Jawa Barat', 'Data PLN dan ketenagalistrikan Jawa Barat untuk riset doktoral MDP renewable energy', true);

-- Modul-modul domain Energi Jabar
INSERT INTO domain_modules (domain_id, slug, nama, route_path, sensitivitas, status)
SELECT id, 'mdp',          'Data Pendukung MDP',              '/modules/energi-jabar/mdp/',          'internal',  'aktif' FROM domains WHERE slug='energi-jabar' UNION ALL
SELECT id, 'ruptl',        'RUPTL PLN 2025-2034',             '/modules/energi-jabar/ruptl/',        'publik',    'aktif' FROM domains WHERE slug='energi-jabar' UNION ALL
SELECT id, 'pelanggan',    'Data Induk Langganan PLN Jabar',  '/modules/energi-jabar/pelanggan/',    'sensitif',  'draft' FROM domains WHERE slug='energi-jabar' UNION ALL
SELECT id, 'olap-tagihan', 'Data OLAP Tagihan Listrik Jabar', '/modules/energi-jabar/olap-tagihan/', 'sensitif',  'draft' FROM domains WHERE slug='energi-jabar' UNION ALL
SELECT id, 'pencurian',    'Data Pencurian Tenaga Listrik',   '/modules/energi-jabar/pencurian/',    'sensitif',  'draft' FROM domains WHERE slug='energi-jabar';

-- Provenance: sumber data RUPTL (§4.3 & §12 PRD)
INSERT INTO dataset_sources (domain_module_id, nama_sumber, jenis_sumber, url_atau_referensi, tanggal_akses, catatan_metodologi)
SELECT id,
  'RUPTL PLN 2025-2034',
  'dokumen resmi',
  'https://web.pln.co.id/statics/uploads/2024/12/RUPTL-PLN-2025-2034.pdf',
  '2026-07-04',
  'Data diambil dari dokumen RUPTL PLN 2025-2034. Provinsi dibagi sesuai Lampiran A (Sumatera Kalimantan), B (Jawa Madura Bali), C (Sulawesi Maluku Papua NT). Tabel historis, proyeksi, pembangkit eksisting, dan rencana diambil dari tabel dalam masing-masing lampiran provinsi. Data detail baru tersedia untuk B3 (Jawa Barat) dan B1 (DKI Jakarta).'
FROM domain_modules WHERE slug='ruptl';

-- Data RUPTL
INSERT INTO ruptl_provinsi (kode, nama, lampiran, wilayah_sistem, beban_puncak_2024_mw) VALUES
('A1',  'Aceh',                           'A', 'SUMATERA KALIMANTAN',          675.00),
('A2',  'Sumatera Utara',                 'A', 'SUMATERA KALIMANTAN',         2181.00),
('A3',  'Riau',                           'A', 'SUMATERA KALIMANTAN',         1073.00),
('A4',  'Kepulauan Riau',                 'A', 'SUMATERA KALIMANTAN',           NULL),
('A5',  'Kepulauan Bangka Belitung',      'A', 'SUMATERA KALIMANTAN',           NULL),
('A6',  'Sumatera Barat',                 'A', 'SUMATERA KALIMANTAN',          699.00),
('A7',  'Jambi',                          'A', 'SUMATERA KALIMANTAN',          519.00),
('A8',  'Sumatera Selatan',               'A', 'SUMATERA KALIMANTAN',         1221.00),
('A9',  'Bengkulu',                       'A', 'SUMATERA KALIMANTAN',          254.00),
('A10', 'Lampung',                        'A', 'SUMATERA KALIMANTAN',         1318.00),
('A11', 'Kalimantan Barat',               'A', 'SUMATERA KALIMANTAN',           NULL),
('A12', 'Kalimantan Selatan',             'A', 'SUMATERA KALIMANTAN',           NULL),
('A13', 'Kalimantan Tengah',              'A', 'SUMATERA KALIMANTAN',           NULL),
('A14', 'Kalimantan Timur',               'A', 'SUMATERA KALIMANTAN',           NULL),
('A15', 'Kalimantan Utara',               'A', 'SUMATERA KALIMANTAN',           NULL),
('B1',  'DKI Jakarta',                    'B', 'JAWA MADURA BALI',            5917.00),
('B2',  'Banten',                         'B', 'JAWA MADURA BALI',            4143.00),
('B3',  'Jawa Barat',                     'B', 'JAWA MADURA BALI',            8725.00),
('B4',  'Jawa Tengah',                    'B', 'JAWA MADURA BALI',            4296.00),
('B5',  'DI Yogyakarta',                  'B', 'JAWA MADURA BALI',             622.00),
('B6',  'Jawa Timur',                     'B', 'JAWA MADURA BALI',            6937.00),
('B7',  'Bali',                           'B', 'JAWA MADURA BALI',            1164.00),
('C1',  'Sulawesi Utara',                 'C', 'SULAWESI MALUKU PAPUA NT',      NULL),
('C2',  'Sulawesi Tengah',                'C', 'SULAWESI MALUKU PAPUA NT',      NULL),
('C3',  'Gorontalo',                      'C', 'SULAWESI MALUKU PAPUA NT',      NULL),
('C4',  'Sulawesi Selatan',               'C', 'SULAWESI MALUKU PAPUA NT',      NULL),
('C5',  'Sulawesi Tenggara',              'C', 'SULAWESI MALUKU PAPUA NT',      NULL),
('C6',  'Sulawesi Barat',                 'C', 'SULAWESI MALUKU PAPUA NT',      NULL),
('C7',  'Maluku',                         'C', 'SULAWESI MALUKU PAPUA NT',     75.20),
('C8',  'Maluku Utara',                   'C', 'SULAWESI MALUKU PAPUA NT',    114.15),
('C9',  'Papua & Papua Pegunungan',       'C', 'SULAWESI MALUKU PAPUA NT',      NULL),
('C10', 'Papua Barat & Papua Barat Daya', 'C', 'SULAWESI MALUKU PAPUA NT',      NULL),
('C11', 'Nusa Tenggara Barat',            'C', 'SULAWESI MALUKU PAPUA NT',      NULL),
('C12', 'Nusa Tenggara Timur',            'C', 'SULAWESI MALUKU PAPUA NT',      NULL);

-- Penjualan historis Jawa Barat (Tabel B3.1)
INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh)
SELECT id, 2015, 'RUMAH_TANGGA', 16795 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2015, 'BISNIS',        4606  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2015, 'PUBLIK',        1441  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2015, 'INDUSTRI',     20717  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2016, 'RUMAH_TANGGA', 17464 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2016, 'BISNIS',        4921  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2016, 'PUBLIK',        1570  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2016, 'INDUSTRI',     22188  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2017, 'RUMAH_TANGGA', 17555 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2017, 'BISNIS',        5232  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2017, 'PUBLIK',        1682  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2017, 'INDUSTRI',     22957  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2018, 'RUMAH_TANGGA', 17934 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2018, 'BISNIS',        5645  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2018, 'PUBLIK',        1830  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2018, 'INDUSTRI',     23904  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2019, 'RUMAH_TANGGA', 18754 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2019, 'BISNIS',        6080  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2019, 'PUBLIK',        1998  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2019, 'INDUSTRI',     24052  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2020, 'RUMAH_TANGGA', 20362 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2020, 'BISNIS',        5798  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2020, 'PUBLIK',        1954  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2020, 'INDUSTRI',     21428  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2021, 'RUMAH_TANGGA', 20926 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2021, 'BISNIS',        6278  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2021, 'PUBLIK',        2037  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2021, 'INDUSTRI',     24078  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2022, 'RUMAH_TANGGA', 20872 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2022, 'BISNIS',        7610  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2022, 'PUBLIK',        2325  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2022, 'INDUSTRI',     25419  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2023, 'RUMAH_TANGGA', 21739 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2023, 'BISNIS',        7927  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2023, 'PUBLIK',        2422  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2023, 'INDUSTRI',     26476  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2024, 'RUMAH_TANGGA', 21739 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2024, 'BISNIS',        7927  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2024, 'PUBLIK',        2422  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2024, 'INDUSTRI',     26476  FROM ruptl_provinsi WHERE kode='B3';

-- Proyeksi kebutuhan Jawa Barat (Tabel B3.8)
INSERT INTO ruptl_proyeksi_kebutuhan (provinsi_id, tahun, pertumbuhan_ekonomi_pct, sales_gwh, produksi_gwh, beban_puncak_mw, pelanggan)
SELECT id, 2025, 4.5,  65919, 70743,  9274, 17479639 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2026, 6.4,  70153, 75161,  9851, 17723739 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2027, 5.0,  73666, 78850, 10332, 17962853 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2028, 4.6,  77088, 82418, 10797, 18196824 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2029, 3.0,  79416, 84818, 11109, 18425484 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2030, 5.0,  83363, 88932, 11645, 18649200 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2031, 3.0,  85838, 91476, 11975, 18868576 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2032, 3.6,  88890, 94627, 12385, 19083774 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2033, 3.1,  91659, 97571, 12767, 19294896 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 2034, 2.9,  94324,100404, 13135, 19502045 FROM ruptl_provinsi WHERE kode='B3';

-- Pembangkit eksisting Jawa Barat (Tabel B3.3)
INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw, dmp_mw)
SELECT id, 'PLN', 'PLTA',  'Jawa Bali', 39, 1915, 1888, 1863 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 'PLN', 'PLTG',  'Jawa Bali', 10, 1168, 1132, 1128 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 'PLN', 'PLTGU', 'Jawa Bali',  3, 1152, 1079,  743 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 'PLN', 'PLTP',  'Jawa Bali',  7,  377,  357,  337 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 'PLN', 'PLTU',  'Jawa Bali',  6, 2040, 1839, 1842 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 'IPP', 'PLTA',  'Jawa Bali',  2,  227,  227,  205 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 'IPP', 'PLTGU', 'Jawa Bali',  4, 2029, 2029, 2016 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 'IPP', 'PLTM',  'Jawa Bali', 30,  150,  150,  113 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 'IPP', 'PLTP',  'Jawa Bali', 10,  821,  821,  788 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 'IPP', 'PLTU',  'Jawa Bali',  2, 1584, 1584,  906 FROM ruptl_provinsi WHERE kode='B3';

-- Rencana pembangkit Jawa Barat RE Base (Tabel B3.9.a)
INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, kapasitas_mw, cod_tahun)
SELECT id, 'RE_BASE', 'PS',   1040, 2028 FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 'RE_BASE', 'BESS',  150, 2034 FROM ruptl_provinsi WHERE kode='B3';

-- Rencana pembangkit Jawa Barat ARED (Tabel B3.9.b)
INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, kapasitas_mw, cod_tahun, keterangan)
SELECT id, 'ARED', 'PLTS',  380, 2026, 'Termasuk PLTS+BESS'  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 'ARED', 'PLTA', 1018, 2027, 'Hidro skala besar'   FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 'ARED', 'PLTB',  775, 2028, 'Bayu/Angin'          FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 'ARED', 'PLTP',  335, 2029, 'Panas Bumi'          FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 'ARED', 'PLTS',  180, 2030, 'PLTS+BESS tambahan'  FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 'ARED', 'PS',    760, 2031, 'Pumped Storage'      FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 'ARED', 'PLTM',   74, 2032, 'Mini Hidro'          FROM ruptl_provinsi WHERE kode='B3' UNION ALL
SELECT id, 'ARED', 'BESS',  150, 2034, 'Battery Storage'     FROM ruptl_provinsi WHERE kode='B3';

-- Penjualan historis DKI Jakarta (Tabel B1.1)
INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh)
SELECT id, 2015, 'RUMAH_TANGGA', 12324 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2015, 'BISNIS',       11209 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2015, 'PUBLIK',        2738 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2015, 'INDUSTRI',      4234 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2016, 'RUMAH_TANGGA', 12663 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2016, 'BISNIS',       10983 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2016, 'PUBLIK',        2672 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2016, 'INDUSTRI',      4976 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2017, 'RUMAH_TANGGA', 12706 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2017, 'BISNIS',       11817 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2017, 'PUBLIK',        2799 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2017, 'INDUSTRI',      4322 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2018, 'RUMAH_TANGGA', 13199 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2018, 'BISNIS',       12170 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2018, 'PUBLIK',        2901 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2018, 'INDUSTRI',      4509 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2019, 'RUMAH_TANGGA', 13995 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2019, 'BISNIS',       12684 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2019, 'PUBLIK',        3079 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2019, 'INDUSTRI',      4349 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2020, 'RUMAH_TANGGA', 14605 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2020, 'BISNIS',       10986 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2020, 'PUBLIK',        2772 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2020, 'INDUSTRI',      3832 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2021, 'RUMAH_TANGGA', 14725 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2021, 'BISNIS',       10995 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2021, 'PUBLIK',        2806 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2021, 'INDUSTRI',      4184 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2022, 'RUMAH_TANGGA', 14824 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2022, 'BISNIS',       12539 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2022, 'PUBLIK',        3075 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2022, 'INDUSTRI',      4140 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2023, 'RUMAH_TANGGA', 15645 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2023, 'BISNIS',       14002 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2023, 'PUBLIK',        3349 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2023, 'INDUSTRI',      3997 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2024, 'RUMAH_TANGGA', 16051 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2024, 'BISNIS',       14384 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2024, 'PUBLIK',        3436 FROM ruptl_provinsi WHERE kode='B1' UNION ALL
SELECT id, 2024, 'INDUSTRI',      4101 FROM ruptl_provinsi WHERE kode='B1';
