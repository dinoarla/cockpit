-- ============================================================
-- SEED DATA B2: PROVINSI BANTEN
-- Sumber: RUPTL PLN 2025-2034, Lampiran B2 (hal. B-14 s.d B-26)
-- Jalankan setelah FULL_SETUP.sql dan seed_ruptl.sql
-- ============================================================

SET @b2 = (SELECT id FROM ruptl_provinsi WHERE kode = 'B2');

-- -------- PENJUALAN HISTORIS — BANTEN (B2) --------
-- Sumber: Tabel B2.1 RUPTL PLN 2025-2034
INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh) VALUES
(@b2,2015,'RUMAH_TANGGA',4278),  (@b2,2015,'BISNIS',2154),  (@b2,2015,'PUBLIK',455),  (@b2,2015,'INDUSTRI',11645),
(@b2,2016,'RUMAH_TANGGA',4543),  (@b2,2016,'BISNIS',2526),  (@b2,2016,'PUBLIK',488),  (@b2,2016,'INDUSTRI',12811),
(@b2,2017,'RUMAH_TANGGA',4600),  (@b2,2017,'BISNIS',2931),  (@b2,2017,'PUBLIK',528),  (@b2,2017,'INDUSTRI',13623),
(@b2,2018,'RUMAH_TANGGA',4825),  (@b2,2018,'BISNIS',2990),  (@b2,2018,'PUBLIK',544),  (@b2,2018,'INDUSTRI',14803),
(@b2,2019,'RUMAH_TANGGA',5232),  (@b2,2019,'BISNIS',3164),  (@b2,2019,'PUBLIK',587),  (@b2,2019,'INDUSTRI',14601),
(@b2,2020,'RUMAH_TANGGA',5871),  (@b2,2020,'BISNIS',2898),  (@b2,2020,'PUBLIK',557),  (@b2,2020,'INDUSTRI',13027),
(@b2,2021,'RUMAH_TANGGA',6014),  (@b2,2021,'BISNIS',3009),  (@b2,2021,'PUBLIK',574),  (@b2,2021,'INDUSTRI',14233),
(@b2,2022,'RUMAH_TANGGA',6050),  (@b2,2022,'BISNIS',3408),  (@b2,2022,'PUBLIK',643),  (@b2,2022,'INDUSTRI',16605),
(@b2,2023,'RUMAH_TANGGA',6475),  (@b2,2023,'BISNIS',3965),  (@b2,2023,'PUBLIK',717),  (@b2,2023,'INDUSTRI',15814),
(@b2,2024,'RUMAH_TANGGA',6877),  (@b2,2024,'BISNIS',4210),  (@b2,2024,'PUBLIK',762),  (@b2,2024,'INDUSTRI',16917);

-- -------- PROYEKSI KEBUTUHAN — BANTEN (B2) --------
-- Sumber: Tabel B2.8 RUPTL PLN 2025-2034
INSERT INTO ruptl_proyeksi_kebutuhan (provinsi_id, tahun, pertumbuhan_ekonomi_pct, sales_gwh, produksi_gwh, beban_puncak_mw, pelanggan) VALUES
(@b2,2025,3.3,29715,31122,4441,4115849),
(@b2,2026,2.3,30406,31835,4543,4170631),
(@b2,2027,3.3,31400,32863,4689,4224316),
(@b2,2028,3.2,32390,33895,4837,4276872),
(@b2,2029,3.1,33383,34930,4984,4328266),
(@b2,2030,3.1,34418,36010,5138,4378628),
(@b2,2031,3.2,35517,37156,5302,4428180),
(@b2,2032,3.2,36647,38334,5470,4477048),
(@b2,2033,3.2,37828,39565,5646,4525288),
(@b2,2034,3.4,39113,40905,5837,4572970);

-- -------- PEMBANGKIT EKSISTING — BANTEN (B2) --------
-- Sumber: Tabel B2.3 RUPTL PLN 2025-2034
INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw) VALUES
(@b2,'PLN','PLTD','Jawa Bali',7,1.2,1.2),
(@b2,'PLN','PLTGU','Jawa Bali',1,739,660),
(@b2,'PLN','PLTU','Jawa Bali',14,5885,5467),
(@b2,'IPP','PLTM','Jawa Bali',4,20.6,20.6),
(@b2,'IPP','PLTU','Jawa Bali',3,2607,2607);

-- -------- RENCANA PEMBANGKIT RE BASE — BANTEN (B2) --------
-- Sumber: Tabel B2.9 dan B2.11 RUPTL PLN 2025-2034
INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun) VALUES
(@b2,'RE_BASE','PLTU','Jawa-9',1000,2025),
(@b2,'RE_BASE','PLTU','Jawa-10',1000,2025),
(@b2,'RE_BASE','PLTM','Cikotok',4.2,2026),
(@b2,'RE_BASE','PLTS','Banten (Kuota) II',50,2026),
(@b2,'RE_BASE','PLTM','Cikamunding',6,2027),
(@b2,'RE_BASE','PLTM','Nagajaya',6,2027),
(@b2,'RE_BASE','PLTM','Bulakan',3,2027),
(@b2,'RE_BASE','PLTM','Jawa-Bali (Kuota) Tersebar',4.4,2027),
(@b2,'RE_BASE','PLTSa','Banten (Kuota) Tersebar 1',40,2028),
(@b2,'RE_BASE','PLTS','Banten (Kuota) IVA',50,2028),
(@b2,'RE_BASE','PLTM','Cibareno 1',5,2028),
(@b2,'RE_BASE','PLTM','Karian',1.8,2028),
(@b2,'RE_BASE','PLTB','Banten',100,2028),
(@b2,'RE_BASE','PLTB','Banten',100,2029),
(@b2,'RE_BASE','PLTS','Banten (Kuota) IVC',50,2030),
(@b2,'RE_BASE','PLTSa','Banten (Kuota) Tersebar 2',40,2030),
(@b2,'RE_BASE','PLTS','Banten (Kuota) IVB',50,2030),
(@b2,'RE_BASE','PLTS','Banten (Kuota) VII',50,2030),
(@b2,'RE_BASE','PLTP','Rawadano (FTP2)',30,2030),
(@b2,'RE_BASE','PLTGU','Jawa-5',1000,2030),
(@b2,'RE_BASE','PLTGU','Jawa-Bali-7 (SH-PLN)',500,2030),
(@b2,'RE_BASE','PLTP','Rawadano (FTP2)',80,2032),
(@b2,'RE_BASE','PLTP','Jawa-Bali (Kuota) Tersebar',35,2033),
(@b2,'RE_BASE','PLTS','Banten (Kuota) V',45,2034),
(@b2,'RE_BASE','PLTB','Jawa-Bali (Kuota) Tersebar III',300,2034),
(@b2,'RE_BASE','BESS','Jawa-Bali (Kuota) Tersebar IVA',250,2034);

-- -------- RENCANA PEMBANGKIT ARED — BANTEN (B2) --------
-- Sumber: Tabel B2.10 dan B2.11 RUPTL PLN 2025-2034 (hanya proyek berbeda vs RE Base)
INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun, keterangan) VALUES
(@b2,'ARED','PLTS+BESS','Banten (Kuota) III',80,2027,'COD ARED lebih awal dari RE Base (2030)'),
(@b2,'ARED','PLTS','Banten (Kuota) IVC',50,2029,'COD ARED 2029 vs RE Base 2030'),
(@b2,'ARED','PLTS','Banten (Kuota) IX',110,2033,'Hanya skenario ARED'),
(@b2,'ARED','PLTS','Banten (Kuota) X',150,2034,'Hanya skenario ARED'),
(@b2,'ARED','PLTB','Jawa-Bali (Kuota) Tersebar IV',600,2034,'Hanya skenario ARED'),
(@b2,'ARED','PLTS','Banten (Kuota) V',45,2031,'COD ARED 2031 vs RE Base 2034');

-- -------- RENCANA TRANSMISI — BANTEN (B2) --------
-- Sumber: Tabel B2.12.a RUPTL PLN 2025-2034 (RE Base)
INSERT INTO ruptl_rencana_transmisi (provinsi_id, skenario, tahun, kms) VALUES
(@b2,'RE_BASE',2025,222),
(@b2,'RE_BASE',2026,77),
(@b2,'RE_BASE',2027,2),
(@b2,'RE_BASE',2028,50),
(@b2,'RE_BASE',2030,8),
(@b2,'RE_BASE',2033,10),
(@b2,'ARED',2025,222),
(@b2,'ARED',2026,77),
(@b2,'ARED',2027,2),
(@b2,'ARED',2028,50),
(@b2,'ARED',2030,8),
(@b2,'ARED',2033,10);

-- -------- RENCANA GARDU INDUK — BANTEN (B2) --------
-- Sumber: Tabel B2.14.a RUPTL PLN 2025-2034 (RE Base total per tahun)
INSERT INTO ruptl_rencana_gardu_induk (provinsi_id, skenario, tahun, mva) VALUES
(@b2,'RE_BASE',2025,2100),
(@b2,'RE_BASE',2026,2180),
(@b2,'RE_BASE',2027,180),
(@b2,'RE_BASE',2028,120),
(@b2,'RE_BASE',2030,1060),
(@b2,'RE_BASE',2033,120),
(@b2,'ARED',2025,2100),
(@b2,'ARED',2026,2180),
(@b2,'ARED',2027,180),
(@b2,'ARED',2028,120),
(@b2,'ARED',2030,1060),
(@b2,'ARED',2033,120);
