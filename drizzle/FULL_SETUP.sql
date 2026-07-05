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

CREATE TABLE `user_module_access` (
	`user_id` int NOT NULL,
	`module_id` int NOT NULL,
	`granted_at` timestamp NOT NULL DEFAULT (now()),
	`granted_by` int,
	CONSTRAINT `user_module_access_pk` PRIMARY KEY(`user_id`, `module_id`),
	INDEX `uma_user_idx` (`user_id`)
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

-- Domain: Energi & Ketenagalistrikan
INSERT INTO domains (slug, nama, deskripsi, is_active) VALUES
('energi-jabar', 'Energi & Ketenagalistrikan', 'Data riset pribadi sektor energi & ketenagalistrikan — bauran RE & NRE, RUPTL PLN nasional, operasional PLN UID Jabar, ekuitas energi, dan keandalan distribusi', true);

-- Modul-modul domain Energi Jabar
INSERT INTO domain_modules (domain_id, slug, nama, route_path, sensitivitas, status)
-- Modul lama (sudah ada)
SELECT id, 'mdp',          'Bauran Energi Jawa Barat',        '/modules/energi-jabar/mdp/',          'internal',  'aktif' FROM domains WHERE slug='energi-jabar' UNION ALL
SELECT id, 'ruptl',        'RUPTL PLN 2025-2034',             '/modules/energi-jabar/ruptl/',        'publik',    'aktif' FROM domains WHERE slug='energi-jabar' UNION ALL
SELECT id, 'pelanggan',    'Data Induk Langganan PLN Jabar',  '/modules/energi-jabar/pelanggan/',    'sensitif',  'aktif' FROM domains WHERE slug='energi-jabar' UNION ALL
SELECT id, 'olap-tagihan', 'Data OLAP Tagihan Listrik Jabar', '/modules/energi-jabar/olap-tagihan/', 'sensitif',  'draft' FROM domains WHERE slug='energi-jabar' UNION ALL
SELECT id, 'pencurian',    'Data Pencurian Tenaga Listrik',   '/modules/energi-jabar/pencurian/',    'sensitif',  'draft' FROM domains WHERE slug='energi-jabar' UNION ALL
-- Section 01: PLN
SELECT id, 'company-presentation',  'Company Presentation',    '/modules/energi-jabar/company-presentation/',  'publik', 'draft' FROM domains WHERE slug='energi-jabar' UNION ALL
SELECT id, 'annual-report',         'Annual Reports',          '/modules/energi-jabar/annual-report/',         'publik', 'draft' FROM domains WHERE slug='energi-jabar' UNION ALL
SELECT id, 'sustainability-report', 'Sustainability Reports',  '/modules/energi-jabar/sustainability-report/', 'publik', 'draft' FROM domains WHERE slug='energi-jabar' UNION ALL
SELECT id, 'statistical-report',    'Statistical Report',      '/modules/energi-jabar/statistical-report/',    'publik', 'draft' FROM domains WHERE slug='energi-jabar' UNION ALL
SELECT id, 'tariff-adjustment',     'Tariff Adjustment',       '/modules/energi-jabar/tariff-adjustment/',     'publik', 'draft' FROM domains WHERE slug='energi-jabar' UNION ALL
SELECT id, 'financial-information', 'Financial Information',   '/modules/energi-jabar/financial-information/', 'publik', 'draft' FROM domains WHERE slug='energi-jabar' UNION ALL
-- Section 02: Pembangkitan, Transisi Energi & Energi Hijau
SELECT id, 'atlas-pembangkit',  'Atlas Kapasitas & Transisi Pembangkit',          '/modules/energi-jabar/atlas-pembangkit/',  'publik',   'aktif' FROM domains WHERE slug='energi-jabar' UNION ALL
SELECT id, 'ekonomi-transisi',  'Ekonomi & Kebijakan Transisi Energi',            '/modules/energi-jabar/ekonomi-transisi/',  'publik',   'draft' FROM domains WHERE slug='energi-jabar' UNION ALL
SELECT id, 'atlas-ebt',         'Atlas Potensi & Pengembangan EBT',               '/modules/energi-jabar/atlas-ebt/',         'publik',   'aktif' FROM domains WHERE slug='energi-jabar' UNION ALL
SELECT id, 'der-storage',       'Energi Terdistribusi & Storage',                 '/modules/energi-jabar/der-storage/',       'internal', 'draft' FROM domains WHERE slug='energi-jabar' UNION ALL
-- Section 02: Transmisi
SELECT id, 'sistem-transmisi',  'Topologi & Keandalan Sistem Transmisi',          '/modules/energi-jabar/sistem-transmisi/',  'internal', 'draft' FROM domains WHERE slug='energi-jabar' UNION ALL
SELECT id, 'rencana-transmisi', 'Rencana Pengembangan & Investasi Transmisi',     '/modules/energi-jabar/rencana-transmisi/', 'internal', 'draft' FROM domains WHERE slug='energi-jabar' UNION ALL
SELECT id, 'proteksi-transmisi','Studi Proteksi Sistem Transmisi',                '/modules/energi-jabar/proteksi-transmisi/','internal', 'draft' FROM domains WHERE slug='energi-jabar' UNION ALL
-- Section 03: Distribusi Tenaga Listrik
SELECT id, 'infrastruktur-distribusi','Infrastruktur & Modernisasi Jaringan Distribusi','/modules/energi-jabar/infrastruktur-distribusi/','internal','draft' FROM domains WHERE slug='energi-jabar' UNION ALL
SELECT id, 'keandalan-layanan', 'Keandalan & Kualitas Layanan',                   '/modules/energi-jabar/keandalan-layanan/', 'internal', 'draft' FROM domains WHERE slug='energi-jabar' UNION ALL
SELECT id, 'ekonomi-niaga',     'Ekonomi Niaga & Pelanggan',                      '/modules/energi-jabar/ekonomi-niaga/',     'sensitif', 'draft' FROM domains WHERE slug='energi-jabar' UNION ALL
SELECT id, 'losses-integritas', 'Losses & Integritas Jaringan',                   '/modules/energi-jabar/losses-integritas/', 'sensitif', 'draft' FROM domains WHERE slug='energi-jabar' UNION ALL
SELECT id, 'ekuitas-akses',     'Ekuitas & Akses Kelistrikan',                    '/modules/energi-jabar/ekuitas-akses/',     'internal', 'draft' FROM domains WHERE slug='energi-jabar';

-- Domain: Open-Source Data Nasional
INSERT INTO domains (slug, nama, deskripsi, is_active) VALUES
('open-data-nasional', 'Open-Source Data Nasional', 'Kumpulan data publik nasional — tata ruang & pemerintahan, iklim & lingkungan, geospasial, dan sosial-kependudukan dari berbagai sumber terbuka', true);

-- Modul domain Open-Source Data Nasional
INSERT INTO domain_modules (domain_id, slug, nama, route_path, sensitivitas, status)
-- Section 01: Tata Ruang & Pemerintahan
SELECT id, 'rkpd-jabar',       'RKPD Jawa Barat',              '/modules/open-data-nasional/rkpd-jabar/',       'publik', 'draft' FROM domains WHERE slug='open-data-nasional' UNION ALL
SELECT id, 'apbd-jabar',       'APBD Jawa Barat',              '/modules/open-data-nasional/apbd-jabar/',       'publik', 'draft' FROM domains WHERE slug='open-data-nasional' UNION ALL
-- Section 02: Lingkungan & Iklim
SELECT id, 'iklim-cuaca',      'Data Iklim dan Cuaca',         '/modules/open-data-nasional/iklim-cuaca/',      'publik', 'draft' FROM domains WHERE slug='open-data-nasional' UNION ALL
SELECT id, 'indeks-bencana',   'Indeks Risiko Bencana',        '/modules/open-data-nasional/indeks-bencana/',   'publik', 'draft' FROM domains WHERE slug='open-data-nasional' UNION ALL
-- Section 03: Geospasial
SELECT id, 'gis-jabar',        'Data Geografis / GIS',         '/modules/open-data-nasional/gis-jabar/',        'publik', 'draft' FROM domains WHERE slug='open-data-nasional' UNION ALL
SELECT id, 'peta-admin',       'Peta Administrasi Wilayah',    '/modules/open-data-nasional/peta-admin/',       'publik', 'draft' FROM domains WHERE slug='open-data-nasional' UNION ALL
-- Section 04: Sosial & Kependudukan
SELECT id, 'kependudukan-bps', 'Data Kependudukan BPS',        '/modules/open-data-nasional/kependudukan-bps/', 'publik', 'draft' FROM domains WHERE slug='open-data-nasional' UNION ALL
SELECT id, 'data-kemiskinan',  'Data Kemiskinan & Sosial',     '/modules/open-data-nasional/data-kemiskinan/',  'publik', 'draft' FROM domains WHERE slug='open-data-nasional';

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

-- -------- BANTEN (B2) --------
-- Penjualan historis B2 (Tabel B2.1)
INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh)
SELECT id,2015,'RUMAH_TANGGA',4278  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2015,'BISNIS',      2154  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2015,'PUBLIK',       455  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2015,'INDUSTRI',   11645  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2016,'RUMAH_TANGGA',4543  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2016,'BISNIS',      2526  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2016,'PUBLIK',       488  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2016,'INDUSTRI',   12811  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2017,'RUMAH_TANGGA',4600  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2017,'BISNIS',      2931  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2017,'PUBLIK',       528  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2017,'INDUSTRI',   13623  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2018,'RUMAH_TANGGA',4825  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2018,'BISNIS',      2990  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2018,'PUBLIK',       544  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2018,'INDUSTRI',   14803  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2019,'RUMAH_TANGGA',5232  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2019,'BISNIS',      3164  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2019,'PUBLIK',       587  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2019,'INDUSTRI',   14601  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2020,'RUMAH_TANGGA',5871  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2020,'BISNIS',      2898  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2020,'PUBLIK',       557  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2020,'INDUSTRI',   13027  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2021,'RUMAH_TANGGA',6014  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2021,'BISNIS',      3009  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2021,'PUBLIK',       574  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2021,'INDUSTRI',   14233  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2022,'RUMAH_TANGGA',6050  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2022,'BISNIS',      3408  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2022,'PUBLIK',       643  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2022,'INDUSTRI',   16605  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2023,'RUMAH_TANGGA',6475  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2023,'BISNIS',      3965  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2023,'PUBLIK',       717  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2023,'INDUSTRI',   15814  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2024,'RUMAH_TANGGA',6877  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2024,'BISNIS',      4210  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2024,'PUBLIK',       762  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2024,'INDUSTRI',   16917  FROM ruptl_provinsi WHERE kode='B2';

-- Proyeksi kebutuhan B2 (Tabel B2.8)
INSERT INTO ruptl_proyeksi_kebutuhan (provinsi_id, tahun, pertumbuhan_ekonomi_pct, sales_gwh, produksi_gwh, beban_puncak_mw, pelanggan)
SELECT id,2025,3.3,29715,31122,4441,4115849 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2026,2.3,30406,31835,4543,4170631 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2027,3.3,31400,32863,4689,4224316 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2028,3.2,32390,33895,4837,4276872 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2029,3.1,33383,34930,4984,4328266 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2030,3.1,34418,36010,5138,4378628 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2031,3.2,35517,37156,5302,4428180 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2032,3.2,36647,38334,5470,4477048 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2033,3.2,37828,39565,5646,4525288 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,2034,3.4,39113,40905,5837,4572970 FROM ruptl_provinsi WHERE kode='B2';

-- Pembangkit eksisting B2 (Tabel B2.3)
INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw)
SELECT id,'PLN','PLTD', 'Jawa Bali', 7,    1.2,   1.2 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'PLN','PLTGU','Jawa Bali', 1,  739.0, 660.0 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'PLN','PLTU', 'Jawa Bali',14, 5885.0,5467.0 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'IPP','PLTM', 'Jawa Bali', 4,   20.6,  20.6 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'IPP','PLTU', 'Jawa Bali', 3, 2607.0,2607.0 FROM ruptl_provinsi WHERE kode='B2';

-- Rencana pembangkit B2 RE Base (Tabel B2.9 & B2.11)
INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun)
SELECT id,'RE_BASE','PLTU', 'Jawa-9',                         1000,2025 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','PLTU', 'Jawa-10',                        1000,2025 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','PLTM', 'Cikotok',                         4.2,2026 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','PLTS', 'Banten (Kuota) II',               50,2026 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','PLTM', 'Cikamunding',                      6,2027 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','PLTM', 'Nagajaya',                         6,2027 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','PLTM', 'Bulakan',                          3,2027 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','PLTM', 'Jawa-Bali (Kuota) Tersebar',     4.4,2027 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','PLTSa','Banten (Kuota) Tersebar 1',       40,2028 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','PLTS', 'Banten (Kuota) IVA',              50,2028 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','PLTM', 'Cibareno 1',                       5,2028 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','PLTM', 'Karian',                         1.8,2028 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','PLTB', 'Banten',                         100,2028 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','PLTB', 'Banten',                         100,2029 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','PLTS', 'Banten (Kuota) IVC',              50,2030 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','PLTSa','Banten (Kuota) Tersebar 2',       40,2030 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','PLTS', 'Banten (Kuota) IVB',              50,2030 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','PLTS', 'Banten (Kuota) VII',              50,2030 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','PLTP', 'Rawadano (FTP2)',                  30,2030 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','PLTGU','Jawa-5',                        1000,2030 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','PLTGU','Jawa-Bali-7 (SH-PLN)',           500,2030 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','PLTP', 'Rawadano (FTP2)',                  80,2032 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','PLTP', 'Jawa-Bali (Kuota) Tersebar',      35,2033 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','PLTS', 'Banten (Kuota) V',                45,2034 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','PLTB', 'Jawa-Bali (Kuota) Tersebar III', 300,2034 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE','BESS', 'Jawa-Bali (Kuota) Tersebar IVA', 250,2034 FROM ruptl_provinsi WHERE kode='B2';

-- Rencana pembangkit B2 ARED (Tabel B2.10 & B2.11)
INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun, keterangan)
SELECT id,'ARED','PLTS+BESS','Banten (Kuota) III',              80,2027,'COD ARED lebih awal dari RE Base (2030)' FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'ARED','PLTS',     'Banten (Kuota) IVC',              50,2029,'COD ARED 2029 vs RE Base 2030'           FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'ARED','PLTS',     'Banten (Kuota) IX',              110,2033,'Hanya skenario ARED'                     FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'ARED','PLTS',     'Banten (Kuota) X',               150,2034,'Hanya skenario ARED'                     FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'ARED','PLTB',     'Jawa-Bali (Kuota) Tersebar IV',  600,2034,'Hanya skenario ARED'                     FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'ARED','PLTS',     'Banten (Kuota) V',                45,2031,'COD ARED 2031 vs RE Base 2034'           FROM ruptl_provinsi WHERE kode='B2';

-- Rencana transmisi B2 (Tabel B2.12.a)
INSERT INTO ruptl_rencana_transmisi (provinsi_id, skenario, tahun, kms)
SELECT id,'RE_BASE',2025,222 FROM ruptl_provinsi WHERE kode='B2' UNION ALL SELECT id,'RE_BASE',2026,77  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE',2027,  2 FROM ruptl_provinsi WHERE kode='B2' UNION ALL SELECT id,'RE_BASE',2028,50  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE',2030,  8 FROM ruptl_provinsi WHERE kode='B2' UNION ALL SELECT id,'RE_BASE',2033,10  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'ARED',   2025,222 FROM ruptl_provinsi WHERE kode='B2' UNION ALL SELECT id,'ARED',   2026,77  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'ARED',   2027,  2 FROM ruptl_provinsi WHERE kode='B2' UNION ALL SELECT id,'ARED',   2028,50  FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'ARED',   2030,  8 FROM ruptl_provinsi WHERE kode='B2' UNION ALL SELECT id,'ARED',   2033,10  FROM ruptl_provinsi WHERE kode='B2';

-- Rencana gardu induk B2 (Tabel B2.14.a)
INSERT INTO ruptl_rencana_gardu_induk (provinsi_id, skenario, tahun, mva)
SELECT id,'RE_BASE',2025,2100 FROM ruptl_provinsi WHERE kode='B2' UNION ALL SELECT id,'RE_BASE',2026,2180 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE',2027, 180 FROM ruptl_provinsi WHERE kode='B2' UNION ALL SELECT id,'RE_BASE',2028, 120 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'RE_BASE',2030,1060 FROM ruptl_provinsi WHERE kode='B2' UNION ALL SELECT id,'RE_BASE',2033, 120 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'ARED',   2025,2100 FROM ruptl_provinsi WHERE kode='B2' UNION ALL SELECT id,'ARED',   2026,2180 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'ARED',   2027, 180 FROM ruptl_provinsi WHERE kode='B2' UNION ALL SELECT id,'ARED',   2028, 120 FROM ruptl_provinsi WHERE kode='B2' UNION ALL
SELECT id,'ARED',   2030,1060 FROM ruptl_provinsi WHERE kode='B2' UNION ALL SELECT id,'ARED',   2033, 120 FROM ruptl_provinsi WHERE kode='B2';

-- -------- JAWA TENGAH (B4) --------
-- Penjualan historis B4 (Tabel B4.1)
INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh)
SELECT id,2015,'RUMAH_TANGGA', 9807 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2015,'BISNIS',       2339 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2015,'PUBLIK',       1360 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2015,'INDUSTRI',     6901 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2016,'RUMAH_TANGGA',10370 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2016,'BISNIS',       2585 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2016,'PUBLIK',       1493 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2016,'INDUSTRI',     7228 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2017,'RUMAH_TANGGA',10428 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2017,'BISNIS',       2685 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2017,'PUBLIK',       1572 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2017,'INDUSTRI',     7717 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2018,'RUMAH_TANGGA',10816 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2018,'BISNIS',       2907 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2018,'PUBLIK',       1693 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2018,'INDUSTRI',     8142 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2019,'RUMAH_TANGGA',11486 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2019,'BISNIS',       3178 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2019,'PUBLIK',       1824 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2019,'INDUSTRI',     8270 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2020,'RUMAH_TANGGA',12556 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2020,'BISNIS',       3169 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2020,'PUBLIK',       1773 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2020,'INDUSTRI',     7593 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2021,'RUMAH_TANGGA',12987 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2021,'BISNIS',       3513 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2021,'PUBLIK',       1829 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2021,'INDUSTRI',     8332 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2022,'RUMAH_TANGGA',12962 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2022,'BISNIS',       3790 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2022,'PUBLIK',       2035 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2022,'INDUSTRI',     8778 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2023,'RUMAH_TANGGA',13620 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2023,'BISNIS',       4171 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2023,'PUBLIK',       2233 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2023,'INDUSTRI',     8408 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2024,'RUMAH_TANGGA',14630 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2024,'BISNIS',       4480 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2024,'PUBLIK',       2398 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2024,'INDUSTRI',     9348 FROM ruptl_provinsi WHERE kode='B4';

-- Proyeksi kebutuhan B4 (Tabel B4.8)
INSERT INTO ruptl_proyeksi_kebutuhan (provinsi_id, tahun, pertumbuhan_ekonomi_pct, sales_gwh, produksi_gwh, beban_puncak_mw, pelanggan)
SELECT id,2025,8.8,33564,35683,5242,12184529 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2026,4.9,35202,37350,5486,12365468 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2027,4.8,36882,39078,5738,12545648 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2028,5.6,38933,41208,6049,12725022 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2029,5.3,40993,43319,6358,12903658 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2030,5.9,43403,45794,6719,13081233 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2031,7.2,46509,48993,7187,13257515 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2032,4.7,48712,51232,7513,13433595 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2033,4.9,51121,53766,7883,13609531 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,2034,4.9,53611,56385,8265,13785552 FROM ruptl_provinsi WHERE kode='B4';

-- Pembangkit eksisting B4 (Tabel B4.3)
INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw)
SELECT id,'PLN','PLTA', 'Jawa Bali',27, 318.0, 307.0 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'PLN','PLTD', 'Isolated',  9,   5.7,   4.9 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'PLN','PLTG', 'Jawa Bali', 2,  55.0,  49.5 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'PLN','PLTGU','Jawa Bali', 3,1813.0,1589.0 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'PLN','PLTM', 'Jawa Bali', 5,  10.1,   8.8 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'PLN','PLTS', 'Jawa Bali', 5,   0.2,   0.2 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'PLN','PLTU', 'Jawa Bali',10,4410.0,4012.0 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'IPP','PLTD', 'Isolated',  2,   1.6,   1.6 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'IPP','PLTM', 'Jawa Bali',28,  43.8,  40.3 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'IPP','PLTP', 'Jawa Bali', 1,  60.0,  47.0 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'IPP','PLTU', 'Jawa Bali', 8,6105.0,6021.0 FROM ruptl_provinsi WHERE kode='B4';

-- Rencana pembangkit B4 RE Base (Tabel B4.9.a & B4.10)
INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun)
SELECT id,'RE_BASE','PLTM',    'Harjosari',                       9.9,2025 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTM',    'Banyubiru',                      0.17,2025 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTS',    'Jawa Tengah (Kuota) II',          100,2025 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTS',    'Jawa Tengah (Kuota) IV',          100,2025 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTM',    'Gerak Serayu',                   4.98,2026 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTM',    'Jatibarang',                      1.5,2026 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTP',    'Dieng (FTP2)',                     55,2027 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTM',    'Jawa-Bali (Kuota) Tersebar',      149,2027 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTS',    'Jawa Tengah (Kuota) IIIB',         50,2027 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTP',    'Dieng (FTP2)',                      35,2028 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTS',    'Jawa Tengah (Kuota) IIIA',         50,2028 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTM',    'Jawa-Bali (Kuota) Tersebar',      0.7,2028 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTS+BESS','Jawa Tengah (Kuota) IIIC',        90,2030 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTP',    'Dieng (FTP2)',                      55,2030 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTP',    'Dieng (FTP2)',                      55,2030 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTM',    'Jawa-Bali (Kuota) Tersebar',         5,2030 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTSa',   'Jawa Tengah (Kuota) Tersebar',     20,2030 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTSa',   'Jawa Tengah (Kuota) Tersebar',      5,2030 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTS+BESS','Jawa Tengah (Kuota) I',            50,2031 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTB',    'Jawa-Bali (Kuota) Tersebar I',      60,2031 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTS',    'Jawa Tengah (Kuota) V',             40,2031 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTP',    'Baturaden (FTP2)',                  110,2031 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTP',    'Baturaden (FTP2)',                   75,2031 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTP',    'Ungaran (FTP2)',                     55,2031 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTB',    'Jawa-Bali (Kuota) Tersebar II',     50,2032 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTB',    'Jawa-Bali (Kuota) Tersebar III',    50,2032 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTP',    'Baturaden (FTP2)',                   35,2032 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTP',    'Jawa-Bali (Kuota) Tersebar',        45,2032 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PS',      'Matenggeng PS',                     943,2032 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTP',    'Dieng (FTP2) 1',                    55,2033 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTP',    'Dieng (FTP2) 2',                    55,2033 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTP',    'Dieng (FTP2) 3',                    35,2033 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE','PLTS',    'Jawa Tengah (Kuota) VI',            50,2034 FROM ruptl_provinsi WHERE kode='B4';

-- Rencana pembangkit B4 ARED
INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun, keterangan)
SELECT id,'ARED','PLTS','Jawa Tengah (Kuota) IX',           57,2026,'Hanya ARED, COD lebih awal dari RE Base 2034' FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'ARED','PLTS','Jawa Tengah (Kuota) X',           786,2031,'Hanya ARED'                                   FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'ARED','PLTS','Jawa Tengah (Kuota) XI (×8)',     786,2032,'Hanya ARED, 8 proyek @~98 MW'                FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'ARED','PLTS','Jawa Tengah (Kuota) XII (×8)',    786,2033,'Hanya ARED'                                   FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'ARED','PLTS','Jawa Tengah (Kuota) XIII',        786,2034,'Hanya ARED'                                   FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'ARED','PLTB','Jawa-Bali (Kuota) Tersebar IV-VII',800,2032,'Hanya ARED'                                  FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'ARED','BESS','Jawa-Bali (Kuota) Tersebar IVC',  250,2034,'Hanya ARED'                                   FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'ARED','BESS','Jawa-Bali (Kuota) Tersebar I',    200,2031,'Hanya ARED'                                   FROM ruptl_provinsi WHERE kode='B4';

-- Rencana transmisi B4 (Tabel B4.11.a)
INSERT INTO ruptl_rencana_transmisi (provinsi_id, skenario, tahun, kms)
SELECT id,'RE_BASE',2025,283 FROM ruptl_provinsi WHERE kode='B4' UNION ALL SELECT id,'RE_BASE',2026,193 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE',2027,629 FROM ruptl_provinsi WHERE kode='B4' UNION ALL SELECT id,'RE_BASE',2028,703 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE',2029, 94 FROM ruptl_provinsi WHERE kode='B4' UNION ALL SELECT id,'RE_BASE',2030, 40 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE',2031,120 FROM ruptl_provinsi WHERE kode='B4' UNION ALL SELECT id,'RE_BASE',2032,129 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE',2033,400 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'ARED',   2025,283 FROM ruptl_provinsi WHERE kode='B4' UNION ALL SELECT id,'ARED',   2026,193 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'ARED',   2027,629 FROM ruptl_provinsi WHERE kode='B4' UNION ALL SELECT id,'ARED',   2028,703 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'ARED',   2029, 94 FROM ruptl_provinsi WHERE kode='B4' UNION ALL SELECT id,'ARED',   2030, 40 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'ARED',   2031,120 FROM ruptl_provinsi WHERE kode='B4' UNION ALL SELECT id,'ARED',   2032,129 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'ARED',   2033,400 FROM ruptl_provinsi WHERE kode='B4';

-- Rencana gardu induk B4 (Tabel B4.13.a)
INSERT INTO ruptl_rencana_gardu_induk (provinsi_id, skenario, tahun, mva)
SELECT id,'RE_BASE',2025, 720 FROM ruptl_provinsi WHERE kode='B4' UNION ALL SELECT id,'RE_BASE',2026,1270 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE',2027,1300 FROM ruptl_provinsi WHERE kode='B4' UNION ALL SELECT id,'RE_BASE',2028,3060 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE',2029, 180 FROM ruptl_provinsi WHERE kode='B4' UNION ALL SELECT id,'RE_BASE',2030,  60 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE',2031, 240 FROM ruptl_provinsi WHERE kode='B4' UNION ALL SELECT id,'RE_BASE',2032,1000 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'RE_BASE',2033,1120 FROM ruptl_provinsi WHERE kode='B4' UNION ALL SELECT id,'RE_BASE',2034,  60 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'ARED',   2025, 720 FROM ruptl_provinsi WHERE kode='B4' UNION ALL SELECT id,'ARED',   2026,1270 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'ARED',   2027,1300 FROM ruptl_provinsi WHERE kode='B4' UNION ALL SELECT id,'ARED',   2028,3060 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'ARED',   2029, 180 FROM ruptl_provinsi WHERE kode='B4' UNION ALL SELECT id,'ARED',   2030,  60 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'ARED',   2031, 240 FROM ruptl_provinsi WHERE kode='B4' UNION ALL SELECT id,'ARED',   2032,1000 FROM ruptl_provinsi WHERE kode='B4' UNION ALL
SELECT id,'ARED',   2033,1120 FROM ruptl_provinsi WHERE kode='B4' UNION ALL SELECT id,'ARED',   2034,  60 FROM ruptl_provinsi WHERE kode='B4';
