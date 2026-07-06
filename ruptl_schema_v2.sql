-- ============================================================
-- RUPTL PLN 2025-2034 — Schema Extension v2
-- Berdasarkan Kerangka_Data_Pusat_Data_RUPTL_2025-2034.md
-- Modul 2-9, 12 (nasional/wilayah/sistem level)
-- ============================================================

-- 1. Wilayah Usaha (dimensi: 5 wilayah usaha PLN)
CREATE TABLE `ruptl_wilayah_usaha` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kode` varchar(5) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `urutan` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_wilayah_kode` (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `ruptl_wilayah_usaha` (`kode`, `nama`, `urutan`) VALUES
('SUM','Sumatera',1),
('JMB','Jawa-Madura-Bali',2),
('KAL','Kalimantan',3),
('SUL','Sulawesi',4),
('MPN','Maluku-Papua-Nusa Tenggara',5);

-- 2. Sistem Kelistrikan (dimensi: interkoneksi & isolated)
CREATE TABLE `ruptl_sistem_kelistrikan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wilayah_id` int(11) DEFAULT NULL,
  `kode` varchar(20) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `jenis` enum('INTERKONEKSI','ISOLATED') NOT NULL DEFAULT 'INTERKONEKSI',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_sistem_kode` (`kode`),
  KEY `fk_sistem_wilayah` (`wilayah_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `ruptl_sistem_kelistrikan` (`wilayah_id`, `kode`, `nama`, `jenis`) VALUES
(1,'SUM-BANGKA','Sumatera-Bangka','INTERKONEKSI'),
(2,'JAWA-BALI','Jawa-Bali','INTERKONEKSI'),
(3,'KALBAR','Kalimantan Barat','INTERKONEKSI'),
(3,'KALSELTENGTIMRA','Kalsel-Kalteng-Kaltim-Kaltara','INTERKONEKSI'),
(4,'SULBAGUT','Sulawesi Bagian Utara','INTERKONEKSI'),
(4,'SULBAGSEL','Sulawesi Bagian Selatan','INTERKONEKSI'),
(5,'AMBON','Ambon','ISOLATED'),
(5,'HALMAHERA','Halmahera','ISOLATED'),
(5,'JAYAPURA','Jayapura','ISOLATED'),
(5,'MERAUKE','Merauke','ISOLATED'),
(5,'NABIRE','Nabire','ISOLATED'),
(5,'WAMENA','Wamena','ISOLATED'),
(5,'MANOKWARI','Manokwari','ISOLATED'),
(5,'SORONG','Sorong','ISOLATED'),
(5,'LOMBOK','Lombok','ISOLATED'),
(5,'TIMOR','Timor','ISOLATED');

-- 3. Historis Penjualan Nasional/Wilayah (Modul 2 — Bab IV)
-- wilayah_id NULL = nasional
CREATE TABLE `ruptl_hist_penjualan_wilayah` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wilayah_id` int(11) DEFAULT NULL,
  `tahun` int(11) NOT NULL,
  `sektor` enum('RUMAH_TANGGA','BISNIS','PUBLIK','INDUSTRI','TOTAL') NOT NULL,
  `gwh` decimal(12,2) DEFAULT NULL,
  `pendapatan_triliun` decimal(10,3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_hist_penj_wil_tahun` (`wilayah_id`,`tahun`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. Historis Pelanggan Nasional/Wilayah (Modul 2 — Bab IV)
CREATE TABLE `ruptl_hist_pelanggan_wilayah` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wilayah_id` int(11) DEFAULT NULL,
  `tahun` int(11) NOT NULL,
  `sektor` enum('RUMAH_TANGGA','BISNIS','PUBLIK','INDUSTRI','TOTAL') NOT NULL,
  `jumlah_ribu` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_hist_pel_wil_tahun` (`wilayah_id`,`tahun`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. Historis Kapasitas Pembangkit Nasional/Wilayah (Modul 2 — Bab IV)
-- pemilik: MILIK_SENDIRI=PLN, SEWA=disewa PLN, IPP=excess power
CREATE TABLE `ruptl_hist_kapasitas_wilayah` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wilayah_id` int(11) DEFAULT NULL,
  `tahun` int(11) NOT NULL,
  `pemilik` enum('MILIK_SENDIRI','SEWA','IPP','TOTAL') NOT NULL,
  `kapasitas_mw` decimal(12,2) DEFAULT NULL,
  `dmn_mw` decimal(12,2) DEFAULT NULL,
  `jumlah_unit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_hist_kap_wil_tahun` (`wilayah_id`,`tahun`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 6. Historis Keandalan SAIDI/SAIFI (Modul 2 — Bab IV)
CREATE TABLE `ruptl_hist_keandalan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wilayah_id` int(11) DEFAULT NULL,
  `tahun` int(11) NOT NULL,
  `saidi_jam` decimal(8,3) DEFAULT NULL,
  `saifi_kali` decimal(8,3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_keandalan_wil_tahun` (`wilayah_id`,`tahun`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 7. Historis SPKLU per Provinsi 2020-2024 (Modul 2 — Bab IV)
CREATE TABLE `ruptl_hist_spklu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provinsi_id` int(11) NOT NULL,
  `tahun` int(11) NOT NULL,
  `jumlah_unit` int(11) DEFAULT NULL,
  `kapasitas_kw` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_spklu_prov_tahun` (`provinsi_id`,`tahun`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 8. Proyeksi Demand Nasional/Wilayah (Modul 3 — Bab V.1-V.4)
CREATE TABLE `ruptl_proyeksi_wilayah` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wilayah_id` int(11) DEFAULT NULL,
  `skenario` enum('RE_BASE','ARED') NOT NULL,
  `tahun` int(11) NOT NULL,
  `sales_gwh` decimal(12,2) DEFAULT NULL,
  `produksi_gwh` decimal(12,2) DEFAULT NULL,
  `beban_puncak_mw` decimal(12,2) DEFAULT NULL,
  `pelanggan_ribu` decimal(12,2) DEFAULT NULL,
  `pertumbuhan_pct` decimal(5,2) DEFAULT NULL,
  `konsumsi_per_kapita_kwh` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_proyeksi_wil_sken_tahun` (`wilayah_id`,`skenario`,`tahun`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 9. Neraca Daya per Sistem Kelistrikan (Modul 4 — Bab V.5)
CREATE TABLE `ruptl_neraca_daya` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sistem_id` int(11) NOT NULL,
  `skenario` enum('RE_BASE','ARED') NOT NULL,
  `tahun` int(11) NOT NULL,
  `beban_puncak_bruto_mw` decimal(12,2) DEFAULT NULL,
  `beban_puncak_neto_mw` decimal(12,2) DEFAULT NULL,
  `kapasitas_terpasang_mw` decimal(12,2) DEFAULT NULL,
  `dmn_mw` decimal(12,2) DEFAULT NULL,
  `reserve_margin_pct` decimal(6,2) DEFAULT NULL,
  `produksi_gwh` decimal(12,2) DEFAULT NULL,
  `penjualan_gwh` decimal(12,2) DEFAULT NULL,
  `faktor_beban_pct` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_neraca_sistem_sken_tahun` (`sistem_id`,`skenario`,`tahun`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 10. Bauran Energi Nasional/Wilayah (Modul 5 — Bab V.6)
-- BAU khusus untuk perbandingan emisi
CREATE TABLE `ruptl_bauran_energi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wilayah_id` int(11) DEFAULT NULL,
  `skenario` enum('RE_BASE','ARED','BAU') NOT NULL,
  `tahun` int(11) NOT NULL,
  `sumber` enum('BATUBARA','GAS','LNG','BBM','AIR','PANAS_BUMI','BIOMASSA','SAMPAH','SURYA','BAYU','NUKLIR','IMPOR','LAINNYA_EBT','TOTAL') NOT NULL,
  `produksi_gwh` decimal(12,2) DEFAULT NULL,
  `porsi_pct` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_bauran_wil_sken_tahun` (`wilayah_id`,`skenario`,`tahun`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 11. Emisi GRK Nasional/Wilayah (Modul 6 — Bab V.7-V.8)
CREATE TABLE `ruptl_emisi_grk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wilayah_id` int(11) DEFAULT NULL,
  `skenario` enum('RE_BASE','ARED','BAU') NOT NULL,
  `tahun` int(11) NOT NULL,
  `sumber` enum('GAS','BBM','BATUBARA','TOTAL') NOT NULL,
  `emisi_juta_tco2` decimal(10,3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_emisi_wil_sken_tahun` (`wilayah_id`,`skenario`,`tahun`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 12. Rencana Transmisi Nasional/Wilayah per Tegangan (Modul 7 — Bab V.9)
-- tegangan_kv: '500', '500DC', '275', '150', '70', 'TOTAL'
CREATE TABLE `ruptl_rencana_transmisi_wilayah` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wilayah_id` int(11) DEFAULT NULL,
  `skenario` enum('RE_BASE','ARED') NOT NULL,
  `tahun` int(11) NOT NULL,
  `tegangan_kv` varchar(20) NOT NULL,
  `kms` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_trans_wil_sken_tahun` (`wilayah_id`,`skenario`,`tahun`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 13. Rencana GI Nasional/Wilayah per Kombinasi Tegangan (Modul 7 — Bab V.9)
-- tegangan: '500/275', '500/150', '500DC', '275/150', '150/20', 'TOTAL'
CREATE TABLE `ruptl_rencana_gi_wilayah` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wilayah_id` int(11) DEFAULT NULL,
  `skenario` enum('RE_BASE','ARED') NOT NULL,
  `tahun` int(11) NOT NULL,
  `tegangan` varchar(30) NOT NULL,
  `mva` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_gi_wil_sken_tahun` (`wilayah_id`,`skenario`,`tahun`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 14. Kebutuhan Investasi (Modul 9 — Bab VI, Tabel 6.1)
CREATE TABLE `ruptl_investasi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tahun` int(11) NOT NULL,
  `kategori` enum('IDC','DISTRIBUSI_LISDES','TL_GI','KIT_PLN','KIT_IPP','TOTAL') NOT NULL,
  `nilai_triliun` decimal(10,3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_investasi_tahun` (`tahun`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 15. Pipeline Pelanggan Besar (Modul 12 — Lampiran E)
-- Daftar KEK/KI/DPP/SKPT/Smelter rencana pasokan
CREATE TABLE `ruptl_pipeline_pelanggan_besar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wilayah_id` int(11) NOT NULL,
  `provinsi_id` int(11) DEFAULT NULL,
  `no_urut` int(11) DEFAULT NULL,
  `kategori` varchar(50) DEFAULT NULL,
  `nama_pelanggan` varchar(200) NOT NULL,
  `kebutuhan_mva` decimal(10,2) DEFAULT NULL,
  `rencana_transmisi` text DEFAULT NULL,
  `rencana_gi` varchar(200) DEFAULT NULL,
  `target_tahun` int(11) DEFAULT NULL,
  `skema` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_pipeline_wilayah` (`wilayah_id`),
  KEY `idx_pipeline_provinsi` (`provinsi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

