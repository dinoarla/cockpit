-- ============================================================
-- SEED DATA B4: PROVINSI JAWA TENGAH
-- Sumber: RUPTL PLN 2025-2034, Lampiran B4 (hal. B-50 s.d B-68)
-- Jalankan setelah FULL_SETUP.sql dan seed_ruptl.sql
-- ============================================================

SET @b4 = (SELECT id FROM ruptl_provinsi WHERE kode = 'B4');

-- -------- PENJUALAN HISTORIS — JAWA TENGAH (B4) --------
-- Sumber: Tabel B4.1 RUPTL PLN 2025-2034
INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh) VALUES
(@b4,2015,'RUMAH_TANGGA',9807),  (@b4,2015,'BISNIS',2339),  (@b4,2015,'PUBLIK',1360),  (@b4,2015,'INDUSTRI',6901),
(@b4,2016,'RUMAH_TANGGA',10370), (@b4,2016,'BISNIS',2585),  (@b4,2016,'PUBLIK',1493),  (@b4,2016,'INDUSTRI',7228),
(@b4,2017,'RUMAH_TANGGA',10428), (@b4,2017,'BISNIS',2685),  (@b4,2017,'PUBLIK',1572),  (@b4,2017,'INDUSTRI',7717),
(@b4,2018,'RUMAH_TANGGA',10816), (@b4,2018,'BISNIS',2907),  (@b4,2018,'PUBLIK',1693),  (@b4,2018,'INDUSTRI',8142),
(@b4,2019,'RUMAH_TANGGA',11486), (@b4,2019,'BISNIS',3178),  (@b4,2019,'PUBLIK',1824),  (@b4,2019,'INDUSTRI',8270),
(@b4,2020,'RUMAH_TANGGA',12556), (@b4,2020,'BISNIS',3169),  (@b4,2020,'PUBLIK',1773),  (@b4,2020,'INDUSTRI',7593),
(@b4,2021,'RUMAH_TANGGA',12987), (@b4,2021,'BISNIS',3513),  (@b4,2021,'PUBLIK',1829),  (@b4,2021,'INDUSTRI',8332),
(@b4,2022,'RUMAH_TANGGA',12962), (@b4,2022,'BISNIS',3790),  (@b4,2022,'PUBLIK',2035),  (@b4,2022,'INDUSTRI',8778),
(@b4,2023,'RUMAH_TANGGA',13620), (@b4,2023,'BISNIS',4171),  (@b4,2023,'PUBLIK',2233),  (@b4,2023,'INDUSTRI',8408),
(@b4,2024,'RUMAH_TANGGA',14630), (@b4,2024,'BISNIS',4480),  (@b4,2024,'PUBLIK',2398),  (@b4,2024,'INDUSTRI',9348);

-- -------- PROYEKSI KEBUTUHAN — JAWA TENGAH (B4) --------
-- Sumber: Tabel B4.8 RUPTL PLN 2025-2034
INSERT INTO ruptl_proyeksi_kebutuhan (provinsi_id, tahun, pertumbuhan_ekonomi_pct, sales_gwh, produksi_gwh, beban_puncak_mw, pelanggan) VALUES
(@b4,2025,8.8,33564,35683,5242,12184529),
(@b4,2026,4.9,35202,37350,5486,12365468),
(@b4,2027,4.8,36882,39078,5738,12545648),
(@b4,2028,5.6,38933,41208,6049,12725022),
(@b4,2029,5.3,40993,43319,6358,12903658),
(@b4,2030,5.9,43403,45794,6719,13081233),
(@b4,2031,7.2,46509,48993,7187,13257515),
(@b4,2032,4.7,48712,51232,7513,13433595),
(@b4,2033,4.9,51121,53766,7883,13609531),
(@b4,2034,4.9,53611,56385,8265,13785552);

-- -------- PEMBANGKIT EKSISTING — JAWA TENGAH (B4) --------
-- Sumber: Tabel B4.3 RUPTL PLN 2025-2034
INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw) VALUES
(@b4,'PLN','PLTA','Jawa Bali',27,318,307),
(@b4,'PLN','PLTD','Isolated',9,5.7,4.9),
(@b4,'PLN','PLTG','Jawa Bali',2,55,49.5),
(@b4,'PLN','PLTGU','Jawa Bali',3,1813,1589),
(@b4,'PLN','PLTM','Jawa Bali',5,10.1,8.8),
(@b4,'PLN','PLTS','Jawa Bali',5,0.2,0.2),
(@b4,'PLN','PLTU','Jawa Bali',10,4410,4012),
(@b4,'IPP','PLTD','Isolated',2,1.6,1.6),
(@b4,'IPP','PLTM','Jawa Bali',28,43.8,40.3),
(@b4,'IPP','PLTP','Jawa Bali',1,60,47),
(@b4,'IPP','PLTU','Jawa Bali',8,6105,6021);

-- -------- RENCANA PEMBANGKIT RE BASE — JAWA TENGAH (B4) --------
-- Sumber: Tabel B4.9.a dan B4.10 RUPTL PLN 2025-2034
INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun) VALUES
(@b4,'RE_BASE','PLTM','Harjosari',9.9,2025),
(@b4,'RE_BASE','PLTM','Banyubiru',0.17,2025),
(@b4,'RE_BASE','PLTS','Jawa Tengah (Kuota) II',100,2025),
(@b4,'RE_BASE','PLTS','Jawa Tengah (Kuota) IV',100,2025),
(@b4,'RE_BASE','PLTM','Gerak Serayu',4.98,2026),
(@b4,'RE_BASE','PLTM','Jatibarang',1.5,2026),
(@b4,'RE_BASE','PLTP','Dieng (FTP2)',55,2027),
(@b4,'RE_BASE','PLTM','Jawa-Bali (Kuota) Tersebar',149,2027),
(@b4,'RE_BASE','PLTS','Jawa Tengah (Kuota) IIIB',50,2027),
(@b4,'RE_BASE','PLTP','Dieng (FTP2)',35,2028),
(@b4,'RE_BASE','PLTS','Jawa Tengah (Kuota) IIIA',50,2028),
(@b4,'RE_BASE','PLTM','Jawa-Bali (Kuota) Tersebar',0.7,2028),
(@b4,'RE_BASE','PLTS+BESS','Jawa Tengah (Kuota) IIIC',90,2030),
(@b4,'RE_BASE','PLTP','Dieng (FTP2)',55,2030),
(@b4,'RE_BASE','PLTP','Dieng (FTP2)',55,2030),
(@b4,'RE_BASE','PLTM','Jawa-Bali (Kuota) Tersebar',5,2030),
(@b4,'RE_BASE','PLTSa','Jawa Tengah (Kuota) Tersebar',20,2030),
(@b4,'RE_BASE','PLTSa','Jawa Tengah (Kuota) Tersebar',5,2030),
(@b4,'RE_BASE','PLTS+BESS','Jawa Tengah (Kuota) I',50,2031),
(@b4,'RE_BASE','PLTB','Jawa-Bali (Kuota) Tersebar I',60,2031),
(@b4,'RE_BASE','PLTS','Jawa Tengah (Kuota) V',40,2031),
(@b4,'RE_BASE','PLTP','Baturaden (FTP2)',110,2031),
(@b4,'RE_BASE','PLTP','Baturaden (FTP2)',75,2031),
(@b4,'RE_BASE','PLTP','Ungaran (FTP2)',55,2031),
(@b4,'RE_BASE','PLTB','Jawa-Bali (Kuota) Tersebar II',50,2032),
(@b4,'RE_BASE','PLTB','Jawa-Bali (Kuota) Tersebar III',50,2032),
(@b4,'RE_BASE','PLTP','Baturaden (FTP2)',35,2032),
(@b4,'RE_BASE','PLTP','Jawa-Bali (Kuota) Tersebar',45,2032),
(@b4,'RE_BASE','PS','Matenggeng PS',943,2032),
(@b4,'RE_BASE','PLTP','Dieng (FTP2) 1',55,2033),
(@b4,'RE_BASE','PLTP','Dieng (FTP2) 2',55,2033),
(@b4,'RE_BASE','PLTP','Dieng (FTP2) 3',35,2033),
(@b4,'RE_BASE','PLTS','Jawa Tengah (Kuota) VI',50,2034);

-- -------- RENCANA PEMBANGKIT ARED — JAWA TENGAH (B4, proyek yang berbeda) --------
INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun, keterangan) VALUES
(@b4,'ARED','PLTS','Jawa Tengah (Kuota) IX',57,2026,'Hanya ARED, COD lebih awal dari RE Base 2034'),
(@b4,'ARED','PLTS','Jawa Tengah (Kuota) X',786,2031,'Hanya ARED'),
(@b4,'ARED','PLTS','Jawa Tengah (Kuota) XI (×8)',786,2032,'Hanya ARED, 8 proyek @~98 MW'),
(@b4,'ARED','PLTS','Jawa Tengah (Kuota) XII (×8)',786,2033,'Hanya ARED'),
(@b4,'ARED','PLTS','Jawa Tengah (Kuota) XIII',786,2034,'Hanya ARED'),
(@b4,'ARED','PLTB','Jawa-Bali (Kuota) Tersebar IV-VII',800,2032,'Hanya ARED'),
(@b4,'ARED','BESS','Jawa-Bali (Kuota) Tersebar IVC',250,2034,'Hanya ARED'),
(@b4,'ARED','BESS','Jawa-Bali (Kuota) Tersebar I',200,2031,'Hanya ARED');

-- -------- RENCANA TRANSMISI — JAWA TENGAH (B4) --------
-- Sumber: Tabel B4.11.a RUPTL PLN 2025-2034 (RE Base, total per tahun)
INSERT INTO ruptl_rencana_transmisi (provinsi_id, skenario, tahun, kms) VALUES
(@b4,'RE_BASE',2025,283),
(@b4,'RE_BASE',2026,193),
(@b4,'RE_BASE',2027,629),
(@b4,'RE_BASE',2028,703),
(@b4,'RE_BASE',2029,94),
(@b4,'RE_BASE',2030,40),
(@b4,'RE_BASE',2031,120),
(@b4,'RE_BASE',2032,129),
(@b4,'RE_BASE',2033,400),
(@b4,'ARED',2025,283),
(@b4,'ARED',2026,193),
(@b4,'ARED',2027,629),
(@b4,'ARED',2028,703),
(@b4,'ARED',2029,94),
(@b4,'ARED',2030,40),
(@b4,'ARED',2031,120),
(@b4,'ARED',2032,129),
(@b4,'ARED',2033,400);

-- -------- RENCANA GARDU INDUK — JAWA TENGAH (B4) --------
-- Sumber: Tabel B4.13.a RUPTL PLN 2025-2034 (RE Base, total per tahun)
INSERT INTO ruptl_rencana_gardu_induk (provinsi_id, skenario, tahun, mva) VALUES
(@b4,'RE_BASE',2025,720),
(@b4,'RE_BASE',2026,1270),
(@b4,'RE_BASE',2027,1300),
(@b4,'RE_BASE',2028,3060),
(@b4,'RE_BASE',2029,180),
(@b4,'RE_BASE',2030,60),
(@b4,'RE_BASE',2031,240),
(@b4,'RE_BASE',2032,1000),
(@b4,'RE_BASE',2033,1120),
(@b4,'RE_BASE',2034,60),
(@b4,'ARED',2025,720),
(@b4,'ARED',2026,1270),
(@b4,'ARED',2027,1300),
(@b4,'ARED',2028,3060),
(@b4,'ARED',2029,180),
(@b4,'ARED',2030,60),
(@b4,'ARED',2031,240),
(@b4,'ARED',2032,1000),
(@b4,'ARED',2033,1120),
(@b4,'ARED',2034,60);
