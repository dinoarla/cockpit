-- ============================================================
-- RUPTL PLN 2025-2034 — Data Import SQL
-- Source: RUPTL PLN 2025-2034 PDF, Lampiran A, B, C
-- Generated: 2026-07-06
-- ============================================================

SET NAMES utf8mb4;

-- ============================================================
-- A1: ACEH (provinsi_id=1)
-- ============================================================

INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh) VALUES
(1,2015,'RUMAH_TANGGA',1367),(1,2016,'RUMAH_TANGGA',1510),(1,2017,'RUMAH_TANGGA',1534),
(1,2018,'RUMAH_TANGGA',1622),(1,2019,'RUMAH_TANGGA',1733),(1,2020,'RUMAH_TANGGA',1868),
(1,2021,'RUMAH_TANGGA',1930),(1,2022,'RUMAH_TANGGA',1895),(1,2023,'RUMAH_TANGGA',1987),
(1,2024,'RUMAH_TANGGA',2186),
(1,2015,'BISNIS',337),(1,2016,'BISNIS',361),(1,2017,'BISNIS',386),
(1,2018,'BISNIS',429),(1,2019,'BISNIS',466),(1,2020,'BISNIS',478),
(1,2021,'BISNIS',515),(1,2022,'BISNIS',558),(1,2023,'BISNIS',631),
(1,2024,'BISNIS',635),
(1,2015,'PUBLIK',317),(1,2016,'PUBLIK',352),(1,2017,'PUBLIK',366),
(1,2018,'PUBLIK',389),(1,2019,'PUBLIK',423),(1,2020,'PUBLIK',420),
(1,2021,'PUBLIK',439),(1,2022,'PUBLIK',472),(1,2023,'PUBLIK',501),
(1,2024,'PUBLIK',530),
(1,2015,'INDUSTRI',97),(1,2016,'INDUSTRI',107),(1,2017,'INDUSTRI',124),
(1,2018,'INDUSTRI',147),(1,2019,'INDUSTRI',160),(1,2020,'INDUSTRI',172),
(1,2021,'INDUSTRI',191),(1,2022,'INDUSTRI',229),(1,2023,'INDUSTRI',340),
(1,2024,'INDUSTRI',355);

INSERT INTO ruptl_proyeksi_kebutuhan (provinsi_id, tahun, pertumbuhan_ekonomi_pct, sales_gwh, produksi_gwh, beban_puncak_mw, pelanggan) VALUES
(1,2025,NULL,3844,4263,661,1765952),
(1,2026,NULL,3964,4385,686,1789430),
(1,2027,NULL,4110,4541,712,1812607),
(1,2028,NULL,4280,4720,737,1835359),
(1,2029,NULL,4459,4893,761,1849797),
(1,2030,NULL,4837,5302,785,1871483),
(1,2031,NULL,5013,5487,808,1892565),
(1,2032,NULL,5189,5574,830,1913239),
(1,2033,NULL,6574,7086,853,1933481),
(1,2034,NULL,6749,7273,875,1953247);

INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw, dmp_mw) VALUES
(1,'PLN','PLTU','Sumatera',2,220.0,160.0,160.0),
(1,'PLN','PLTMG','Sumatera',32,421.7,398.3,398.3),
(1,'PLN','PLTD','Sumatera',66,134.2,64.9,48.1),
(1,'PLN','PLTD','Sinabang',31,24.4,11.5,11.5),
(1,'PLN','PLTD','Sabang',15,15.5,10.0,10.0),
(1,'PLN','PLTM','Sumatera',2,2.6,0.7,0.7),
(1,'IPP','PLTU','Sumatera',2,400.0,400.0,400.0),
(1,'IPP','PLTM','Sumatera',2,17.0,17.0,17.0);

INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun, keterangan) VALUES
(1,'RE_BASE','PLTA','Peusangan 1-2',45,2025,'Konstruksi - PLN'),
(1,'ARED','PLTA','Peusangan 1-2',45,2025,'Konstruksi - PLN'),
(1,'RE_BASE','PLTBm','Tanjung Semanto',9.8,2025,'Konstruksi - IPP'),
(1,'ARED','PLTBm','Tanjung Semanto',9.8,2025,'Konstruksi - IPP'),
(1,'RE_BASE','PLTBg','Aceh Tamiang',3,2026,'Konstruksi - IPP'),
(1,'ARED','PLTBg','Aceh Tamiang',3,2026,'Konstruksi - IPP'),
(1,'RE_BASE','PLTB','Bayu Sumatera',55,2026,'Rencana - SH-PLN'),
(1,'ARED','PLTB','Bayu Sumatera',55,2026,'Rencana - SH-PLN'),
(1,'RE_BASE','BESS','Sumatera BESS-1#1',50,2026,'Rencana - SH-PLN'),
(1,'ARED','BESS','Sumatera BESS-1#1',50,2026,'Rencana - SH-PLN'),
(1,'RE_BASE','PLTBm','Langsa',10,2027,'PPA - IPP'),
(1,'ARED','PLTBm','Langsa',10,2027,'PPA - IPP'),
(1,'RE_BASE','PLTM','Tersebar Sumbagut (Kuota)',14.4,2027,'Rencana - IPP'),
(1,'ARED','PLTM','Tersebar Sumbagut (Kuota)',14.4,2027,'Rencana - IPP'),
(1,'RE_BASE','PLTB','Bayu Sumatera',55,2028,'Rencana - SH-PLN'),
(1,'ARED','PLTB','Bayu Sumatera',55,2028,'Rencana - SH-PLN'),
(1,'RE_BASE','PLTGU','Sumbagut/Banda Aceh',80,2028,'Rencana - PLN'),
(1,'ARED','PLTGU','Sumbagut/Banda Aceh',80,2028,'Rencana - PLN'),
(1,'RE_BASE','PLTM','Tersebar Sumbagut (Kuota)',10,2029,'Rencana - IPP'),
(1,'ARED','PLTM','Tersebar Sumbagut (Kuota)',10,2029,'Rencana - IPP'),
(1,'RE_BASE','PLTA','Kumbih-3',45,2029,'Committed - PLN'),
(1,'ARED','PLTA','Kumbih-3',45,2029,'Committed - PLN'),
(1,'RE_BASE','PLTA','Sumatera (Kuota) Tersebar',200,2030,'Rencana - IPP'),
(1,'ARED','PLTA','Sumatera (Kuota) Tersebar',200,2030,'Rencana - IPP'),
(1,'RE_BASE','PLTB','Sumatera (Kuota) Tersebar',110,2030,'Rencana - IPP'),
(1,'ARED','PLTB','Sumatera (Kuota) Tersebar',110,2030,'Rencana - IPP'),
(1,'RE_BASE','PLTA','Sumbagut (Kuota) Tersebar',200,2031,'Rencana - IPP'),
(1,'ARED','PLTA','Sumbagut (Kuota) Tersebar',200,2031,'Rencana - IPP');

INSERT INTO ruptl_rencana_transmisi (provinsi_id, skenario, tahun, kms) VALUES
(1,'RE_BASE',2025,130),(1,'RE_BASE',2026,787),(1,'RE_BASE',2027,413),
(1,'RE_BASE',2028,0),(1,'RE_BASE',2029,216),(1,'RE_BASE',2030,3),
(1,'RE_BASE',2031,0),(1,'RE_BASE',2032,239),(1,'RE_BASE',2033,766),(1,'RE_BASE',2034,0),
(1,'ARED',2025,130),(1,'ARED',2026,787),(1,'ARED',2027,413),
(1,'ARED',2028,0),(1,'ARED',2029,216),(1,'ARED',2030,3),
(1,'ARED',2031,0),(1,'ARED',2032,239),(1,'ARED',2033,766),(1,'ARED',2034,0);

INSERT INTO ruptl_rencana_gardu_induk (provinsi_id, skenario, tahun, mva) VALUES
(1,'RE_BASE',2025,740),(1,'RE_BASE',2026,60),(1,'RE_BASE',2027,530),
(1,'RE_BASE',2028,60),(1,'RE_BASE',2029,30),(1,'RE_BASE',2030,60),
(1,'RE_BASE',2031,60),(1,'RE_BASE',2032,0),(1,'RE_BASE',2033,560),(1,'RE_BASE',2034,0),
(1,'ARED',2025,740),(1,'ARED',2026,60),(1,'ARED',2027,530),
(1,'ARED',2028,60),(1,'ARED',2029,30),(1,'ARED',2030,60),
(1,'ARED',2031,60),(1,'ARED',2032,0),(1,'ARED',2033,560),(1,'ARED',2034,0);

-- ============================================================
-- A2: SUMATERA UTARA (provinsi_id=2)
-- ============================================================

INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh) VALUES
(2,2015,'RUMAH_TANGGA',4504),(2,2016,'RUMAH_TANGGA',4809),(2,2017,'RUMAH_TANGGA',5363),
(2,2018,'RUMAH_TANGGA',5091),(2,2019,'RUMAH_TANGGA',5363),(2,2020,'RUMAH_TANGGA',5704),
(2,2021,'RUMAH_TANGGA',5999),(2,2022,'RUMAH_TANGGA',6026),(2,2023,'RUMAH_TANGGA',6187),
(2,2024,'RUMAH_TANGGA',6700),
(2,2015,'BISNIS',1328),(2,2016,'BISNIS',1447),(2,2017,'BISNIS',1515),
(2,2018,'BISNIS',1599),(2,2019,'BISNIS',1695),(2,2020,'BISNIS',1589),
(2,2021,'BISNIS',1672),(2,2022,'BISNIS',1808),(2,2023,'BISNIS',1992),
(2,2024,'BISNIS',2254),
(2,2015,'PUBLIK',796),(2,2016,'PUBLIK',857),(2,2017,'PUBLIK',894),
(2,2018,'PUBLIK',935),(2,2019,'PUBLIK',975),(2,2020,'PUBLIK',953),
(2,2021,'PUBLIK',994),(2,2022,'PUBLIK',1073),(2,2023,'PUBLIK',1156),
(2,2024,'PUBLIK',1222),
(2,2015,'INDUSTRI',2076),(2,2016,'INDUSTRI',2128),(2,2017,'INDUSTRI',2420),
(2,2018,'INDUSTRI',2820),(2,2019,'INDUSTRI',2911),(2,2020,'INDUSTRI',2947),
(2,2021,'INDUSTRI',3083),(2,2022,'INDUSTRI',3153),(2,2023,'INDUSTRI',3137),
(2,2024,'INDUSTRI',3483);

INSERT INTO ruptl_proyeksi_kebutuhan (provinsi_id, tahun, pertumbuhan_ekonomi_pct, sales_gwh, produksi_gwh, beban_puncak_mw, pelanggan) VALUES
(2,2025,NULL,14661,16034,2479,4769479),
(2,2026,NULL,15128,16508,2550,4937387),
(2,2027,NULL,15762,17179,2652,5053945),
(2,2028,NULL,16453,17931,2767,5117168),
(2,2029,NULL,17334,18906,2916,5179243),
(2,2030,NULL,18256,19878,3064,5240195),
(2,2031,NULL,19223,20896,3219,5300154),
(2,2032,NULL,20240,21964,3381,5359260),
(2,2033,NULL,21309,23086,3552,5417528),
(2,2034,NULL,22434,24265,3731,5474983);

INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw, dmp_mw) VALUES
(2,'PLN','PLTA','Sumatera',NULL,132.0,132.0,132.0),
(2,'PLN','PLTG','Sumatera',NULL,156.1,156.1,156.1),
(2,'PLN','PLTGU','Sumatera',NULL,817.0,817.0,817.0),
(2,'PLN','PLTMH','Sumatera',NULL,7.5,7.5,7.5),
(2,'PLN','PLTU','Sumatera',NULL,1070.0,1070.0,1070.0),
(2,'PLN','PLTMG','Sumatera',NULL,30.0,30.0,30.0),
(2,'PLN','PLTD','Sumatera',NULL,30.0,30.0,30.0),
(2,'IPP','PLTA','Sumatera',NULL,266.0,266.0,266.0),
(2,'IPP','PLTM','Sumatera',NULL,184.8,184.8,184.8),
(2,'IPP','PLTP','Sumatera',NULL,467.2,467.2,467.2),
(2,'IPP','PLTG','Sumatera',NULL,79.0,79.0,79.0),
(2,'IPP','PLTBio','Sumatera',NULL,13.7,13.7,13.7);

-- Rencana Pembangkit A2 (Tabel A2.11)
INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun, keterangan) VALUES
(2,'RE_BASE','PLTP','Sorik Marapi (FTP2)',33,2027,'Konstruksi - IPP'),
(2,'ARED','PLTP','Sorik Marapi (FTP2)',33,2025,'Konstruksi - IPP'),
(2,'ARED','PLTP','Sorik Marapi (FTP2)',65,2027,'Konstruksi - IPP'),
(2,'RE_BASE','PLTA','Asahan III (FTP2)',87,2025,'Konstruksi - PLN'),
(2,'ARED','PLTA','Asahan III (FTP2)',87,2025,'Konstruksi - PLN'),
(2,'RE_BASE','PLTM','Sidikalang 2',7.4,2025,'Konstruksi - IPP'),
(2,'ARED','PLTM','Sidikalang 2',7.4,2025,'Konstruksi - IPP'),
(2,'RE_BASE','PLTM','Rahu 2',6.4,2025,'Konstruksi - IPP'),
(2,'ARED','PLTM','Rahu 2',6.4,2025,'Konstruksi - IPP'),
(2,'RE_BASE','PLTM','Kineppen',10,2025,'Konstruksi - IPP'),
(2,'ARED','PLTM','Kineppen',10,2025,'Konstruksi - IPP'),
(2,'RE_BASE','PLTM','Kandibata 2',10,2025,'Konstruksi - IPP'),
(2,'ARED','PLTM','Kandibata 2',10,2025,'Konstruksi - IPP'),
(2,'RE_BASE','PLTM','Batang Toru 3',10,2025,'Konstruksi - IPP'),
(2,'ARED','PLTM','Batang Toru 3',10,2025,'Konstruksi - IPP'),
(2,'RE_BASE','PLTM','Aek Pungga',2,2025,'Pendanaan - IPP'),
(2,'ARED','PLTM','Aek Pungga',2,2025,'Pendanaan - IPP'),
(2,'RE_BASE','PLTM','Sisira',9.8,2026,'Konstruksi - IPP'),
(2,'ARED','PLTM','Sisira',9.8,2026,'Konstruksi - IPP'),
(2,'RE_BASE','PLTM','Simonggo',8,2026,'Konstruksi - IPP'),
(2,'ARED','PLTM','Simonggo',8,2026,'Konstruksi - IPP'),
(2,'RE_BASE','PLTM','Simbelin-1',6,2026,'Konstruksi - IPP'),
(2,'ARED','PLTM','Simbelin-1',6,2026,'Konstruksi - IPP'),
(2,'RE_BASE','PLTM','Lae Ordi-1',10,2026,'Konstruksi - IPP'),
(2,'ARED','PLTM','Lae Ordi-1',10,2026,'Konstruksi - IPP'),
(2,'RE_BASE','PLTM','Batang Toru 5',7.5,2026,'Konstruksi - IPP'),
(2,'ARED','PLTM','Batang Toru 5',7.5,2026,'Konstruksi - IPP'),
(2,'RE_BASE','PLTS','Sumatera (Kuota) Tersebar',50,2026,'Rencana - IPP'),
(2,'ARED','PLTS','Sumatera (Kuota) Tersebar',50,2026,'Rencana - IPP'),
(2,'RE_BASE','PLTA','Batang Toru',510,2026,'Konstruksi - IPP'),
(2,'ARED','PLTA','Batang Toru',510,2026,'Konstruksi - IPP'),
(2,'RE_BASE','PLTM','Raisan Nagatimbul',7,2027,'Pendanaan - IPP'),
(2,'ARED','PLTM','Raisan Nagatimbul',7,2027,'Pendanaan - IPP'),
(2,'RE_BASE','PLTM','Raisan Hutadolok',7,2027,'Pendanaan - IPP'),
(2,'ARED','PLTM','Raisan Hutadolok',7,2027,'Pendanaan - IPP'),
(2,'RE_BASE','PLTM','Huta Padang',10,2027,'Pendanaan - IPP'),
(2,'ARED','PLTM','Huta Padang',10,2027,'Pendanaan - IPP'),
(2,'RE_BASE','PLTM','Batang Toru 4',10,2027,'Pendanaan - IPP'),
(2,'ARED','PLTM','Batang Toru 4',10,2027,'Pendanaan - IPP'),
(2,'RE_BASE','PLTM','Aek Tomuan-1',8,2027,'Pendanaan - IPP'),
(2,'ARED','PLTM','Aek Tomuan-1',8,2027,'Pendanaan - IPP'),
(2,'RE_BASE','PLTM','Aek Situmandi',7.5,2027,'PPA - IPP'),
(2,'ARED','PLTM','Aek Situmandi',7.5,2027,'PPA - IPP'),
(2,'RE_BASE','PLTS','Sumatera (Kuota) Tersebar',25,2028,'Rencana - IPP'),
(2,'ARED','PLTS','Sumatera (Kuota) Tersebar',25,2028,'Rencana - IPP'),
(2,'RE_BASE','PLTM','Tersebar Sumbagut (Kuota)',14.8,2028,'Rencana - IPP'),
(2,'ARED','PLTM','Tersebar Sumbagut (Kuota)',14.8,2028,'Rencana - IPP'),
(2,'RE_BASE','PLTA','Sumatera (Kuota) Tersebar',250,2028,'Rencana - IPP'),
(2,'ARED','PLTA','Sumatera (Kuota) Tersebar',250,2028,'Rencana - IPP'),
(2,'RE_BASE','BESS','Sumatera BESS-1#3',50,2028,'Rencana - SH-PLN'),
(2,'ARED','BESS','Sumatera BESS-1#3',50,2028,'Rencana - SH-PLN'),
(2,'RE_BASE','BESS','Sumatera BESS-2',200,2029,'Rencana - SH-PLN'),
(2,'ARED','BESS','Sumatera BESS-2',200,2029,'Rencana - SH-PLN'),
(2,'RE_BASE','PLTS','Sumatera (Kuota) Tersebar',25,2029,'Rencana - IPP'),
(2,'ARED','PLTS','Sumatera (Kuota) Tersebar',25,2029,'Rencana - IPP'),
(2,'RE_BASE','PLTS','Sumatera (Kuota) Tersebar',25,2030,'Rencana - IPP'),
(2,'ARED','PLTS','Sumatera (Kuota) Tersebar',25,2030,'Rencana - IPP'),
(2,'RE_BASE','PLTP','Panas Bumi Sumatera (ISJ) Tersebar',705,2031,'Rencana - IPP'),
(2,'ARED','PLTP','Panas Bumi Sumatera (ISJ) Tersebar',705,2031,'Rencana - IPP'),
(2,'RE_BASE','PLTS','Sumatera (Kuota) Tersebar',50,2031,'Rencana - IPP'),
(2,'ARED','PLTS','Sumatera (Kuota) Tersebar',50,2031,'Rencana - IPP'),
(2,'RE_BASE','PLTS','Sumatera (Kuota) Tersebar',25,2032,'Rencana - IPP'),
(2,'ARED','PLTS','Sumatera (Kuota) Tersebar',25,2032,'Rencana - IPP'),
(2,'RE_BASE','Pump Storage','Sumatera Pump Storage-1',250,2033,'Rencana - SH-PLN'),
(2,'ARED','Pump Storage','Sumatera Pump Storage-1',250,2033,'Rencana - SH-PLN'),
(2,'RE_BASE','PLTP','Panas Bumi Sumatera (ISJ) Tersebar',95,2033,'Rencana - IPP'),
(2,'ARED','PLTP','Panas Bumi Sumatera (ISJ) Tersebar',95,2033,'Rencana - IPP'),
(2,'RE_BASE','PLTS','Sumatera (Kuota) Tersebar',100,2033,'Rencana - IPP'),
(2,'ARED','PLTS','Sumatera (Kuota) Tersebar',100,2033,'Rencana - IPP'),
(2,'RE_BASE','PLTA','Sumbagut (Kuota) Tersebar',100,2034,'Rencana - IPP'),
(2,'ARED','PLTA','Sumbagut (Kuota) Tersebar',100,2034,'Rencana - IPP'),
(2,'RE_BASE','PLTS','Nias (SH-PLN)',3,2026,'Rencana - SH-PLN'),
(2,'ARED','PLTS','Nias (SH-PLN)',3,2026,'Rencana - SH-PLN'),
(2,'RE_BASE','PLTMG','Nias-2',20,2027,'Rencana - SH-PLN'),
(2,'ARED','PLTMG','Nias-2',20,2027,'Rencana - SH-PLN'),
(2,'RE_BASE','PLTMG','Nias-3',5,2027,'Rencana - SH-PLN'),
(2,'ARED','PLTMG','Nias-3',5,2027,'Rencana - SH-PLN'),
(2,'RE_BASE','PLTBio','Kepulauan Nias (Kuota)',3,2028,'Rencana - IPP'),
(2,'ARED','PLTBio','Kepulauan Nias (Kuota)',3,2028,'Rencana - IPP'),
(2,'RE_BASE','PLTS','Isolated Sumut Tersebar',2.76,2029,'Rencana - IPP'),
(2,'ARED','PLTS','Isolated Sumut Tersebar',2.76,2029,'Rencana - IPP'),
(2,'RE_BASE','PLTS','Isolated Sumut Tersebar',3.68,2033,'Rencana - IPP'),
(2,'ARED','PLTS','Isolated Sumut Tersebar',3.68,2033,'Rencana - IPP');

INSERT INTO ruptl_rencana_transmisi (provinsi_id, skenario, tahun, kms) VALUES
(2,'RE_BASE',2025,22),(2,'RE_BASE',2026,384),(2,'RE_BASE',2027,212),
(2,'RE_BASE',2028,830),(2,'RE_BASE',2029,10),(2,'RE_BASE',2030,0),
(2,'RE_BASE',2031,0),(2,'RE_BASE',2032,108),(2,'RE_BASE',2033,185),(2,'RE_BASE',2034,0),
(2,'ARED',2025,22),(2,'ARED',2026,384),(2,'ARED',2027,212),
(2,'ARED',2028,830),(2,'ARED',2029,10),(2,'ARED',2030,0),
(2,'ARED',2031,0),(2,'ARED',2032,108),(2,'ARED',2033,185),(2,'ARED',2034,0);

INSERT INTO ruptl_rencana_gardu_induk (provinsi_id, skenario, tahun, mva) VALUES
(2,'RE_BASE',2025,270),(2,'RE_BASE',2026,650),(2,'RE_BASE',2027,660),
(2,'RE_BASE',2028,2340),(2,'RE_BASE',2029,300),(2,'RE_BASE',2030,900),
(2,'RE_BASE',2031,120),(2,'RE_BASE',2032,2050),(2,'RE_BASE',2033,430),(2,'RE_BASE',2034,300),
(2,'ARED',2025,270),(2,'ARED',2026,650),(2,'ARED',2027,660),
(2,'ARED',2028,2340),(2,'ARED',2029,300),(2,'ARED',2030,900),
(2,'ARED',2031,120),(2,'ARED',2032,2050),(2,'ARED',2033,430),(2,'ARED',2034,300);

-- ============================================================
-- A3: RIAU (provinsi_id=3, beban_puncak_2024=1073 MW)
-- ============================================================

UPDATE ruptl_provinsi SET beban_puncak_2024_mw=1073 WHERE id=3;

INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh) VALUES
(3,2015,'RUMAH_TANGGA',2192),(3,2016,'RUMAH_TANGGA',2359),(3,2017,'RUMAH_TANGGA',2423),
(3,2018,'RUMAH_TANGGA',2496),(3,2019,'RUMAH_TANGGA',2636),(3,2020,'RUMAH_TANGGA',2832),
(3,2021,'RUMAH_TANGGA',2935),(3,2022,'RUMAH_TANGGA',3007),(3,2023,'RUMAH_TANGGA',3143),
(3,2024,'RUMAH_TANGGA',3341),
(3,2015,'BISNIS',836),(3,2016,'BISNIS',931),(3,2017,'BISNIS',946),
(3,2018,'BISNIS',1013),(3,2019,'BISNIS',1080),(3,2020,'BISNIS',1057),
(3,2021,'BISNIS',1109),(3,2022,'BISNIS',1236),(3,2023,'BISNIS',1359),
(3,2024,'BISNIS',1435),
(3,2015,'PUBLIK',359),(3,2016,'PUBLIK',390),(3,2017,'PUBLIK',405),
(3,2018,'PUBLIK',465),(3,2019,'PUBLIK',465),(3,2020,'PUBLIK',457),
(3,2021,'PUBLIK',470),(3,2022,'PUBLIK',487),(3,2023,'PUBLIK',531),
(3,2024,'PUBLIK',535),
(3,2015,'INDUSTRI',200),(3,2016,'INDUSTRI',224),(3,2017,'INDUSTRI',296),
(3,2018,'INDUSTRI',404),(3,2019,'INDUSTRI',466),(3,2020,'INDUSTRI',650),
(3,2021,'INDUSTRI',1594),(3,2022,'INDUSTRI',2961),(3,2023,'INDUSTRI',3181),
(3,2024,'INDUSTRI',3401);

INSERT INTO ruptl_proyeksi_kebutuhan (provinsi_id, tahun, pertumbuhan_ekonomi_pct, sales_gwh, produksi_gwh, beban_puncak_mw, pelanggan) VALUES
(3,2025,2.70,8818,9545,1447,2273806),
(3,2026,2.71,8987,9719,1472,2320600),
(3,2027,2.89,9396,10141,1535,2366912),
(3,2028,3.16,9848,10624,1607,2412630),
(3,2029,3.44,10227,11028,1667,2457694),
(3,2030,3.43,10619,11446,1728,2502063),
(3,2031,3.29,11019,11872,1791,2545779),
(3,2032,3.36,11455,12335,1860,2588991),
(3,2033,3.34,12262,13178,1985,2631687),
(3,2034,3.32,13403,14364,2162,2673906);

INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw, dmp_mw) VALUES
(3,'PLN','PLTA','Sumatera',3,114.0,114.0,114.0),
(3,'PLN','PLTG','Sumatera',3,61.6,43.7,0),
(3,'PLN','PLTMG','Sumatera',7,112.7,100.2,100.2),
(3,'PLN','PLTU','Sumatera',4,234.0,186.5,186.5),
(3,'PLN','PLTD','Bengkalis',27,24.9,21.2,21.2),
(3,'PLN','PLTD','Sungai Panjang',47,21.1,14.9,14.9),
(3,'IPP','PLTG','Sumatera',2,54.8,54.8,54.8),
(3,'IPP','PLTGU','Sumatera',3,275.0,275.0,275.0);

INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun, keterangan) VALUES
(3,'RE_BASE','PLTMG','Riau Peaker',200,2026,'Konstruksi - PLN'),
(3,'ARED','PLTMG','Riau Peaker',200,2026,'Konstruksi - PLN'),
(3,'RE_BASE','PLTBg','PLTBio Sumatera (Kuota) Tersebar',3,2027,'Rencana - IPP'),
(3,'ARED','PLTBg','PLTBio Sumatera (Kuota) Tersebar',3,2027,'Rencana - IPP'),
(3,'RE_BASE','PLTS','Dedieselisasi',3.6,2027,'Rencana - IPP'),
(3,'ARED','PLTS','Dedieselisasi',2.9,2027,'Rencana - IPP'),
(3,'RE_BASE','PLTS','Isolated Riau Tersebar',3.57,2033,'Rencana - IPP'),
(3,'ARED','PLTS','Isolated Riau Tersebar',3.57,2033,'Rencana - IPP');

INSERT INTO ruptl_rencana_transmisi (provinsi_id, skenario, tahun, kms) VALUES
(3,'RE_BASE',2025,195),(3,'RE_BASE',2026,650),(3,'RE_BASE',2027,234),
(3,'RE_BASE',2028,578),(3,'RE_BASE',2029,0),(3,'RE_BASE',2030,0),
(3,'RE_BASE',2031,360),(3,'RE_BASE',2032,360),(3,'RE_BASE',2033,10),(3,'RE_BASE',2034,300),
(3,'ARED',2025,195),(3,'ARED',2026,650),(3,'ARED',2027,234),
(3,'ARED',2028,578),(3,'ARED',2029,0),(3,'ARED',2030,0),
(3,'ARED',2031,360),(3,'ARED',2032,360),(3,'ARED',2033,10),(3,'ARED',2034,300);

INSERT INTO ruptl_rencana_gardu_induk (provinsi_id, skenario, tahun, mva) VALUES
(3,'RE_BASE',2025,1110),(3,'RE_BASE',2026,120),(3,'RE_BASE',2027,620),
(3,'RE_BASE',2028,620),(3,'RE_BASE',2029,60),(3,'RE_BASE',2030,180),
(3,'RE_BASE',2031,1560),(3,'RE_BASE',2032,1500),(3,'RE_BASE',2033,300),(3,'RE_BASE',2034,240),
(3,'ARED',2025,1110),(3,'ARED',2026,120),(3,'ARED',2027,620),
(3,'ARED',2028,620),(3,'ARED',2029,60),(3,'ARED',2030,180),
(3,'ARED',2031,1560),(3,'ARED',2032,1500),(3,'ARED',2033,300),(3,'ARED',2034,240);

-- ============================================================
-- A4: KEPULAUAN RIAU / tanpa Batam (provinsi_id=4)
-- ============================================================

INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh) VALUES
(4,2015,'RUMAH_TANGGA',393),(4,2016,'RUMAH_TANGGA',414),(4,2017,'RUMAH_TANGGA',413),
(4,2018,'RUMAH_TANGGA',420),(4,2019,'RUMAH_TANGGA',456),(4,2020,'RUMAH_TANGGA',485),
(4,2021,'RUMAH_TANGGA',497),(4,2022,'RUMAH_TANGGA',500),(4,2023,'RUMAH_TANGGA',523),
(4,2024,'RUMAH_TANGGA',538),
(4,2015,'BISNIS',164),(4,2016,'BISNIS',186),(4,2017,'BISNIS',229),
(4,2018,'BISNIS',267),(4,2019,'BISNIS',295),(4,2020,'BISNIS',267),
(4,2021,'BISNIS',275),(4,2022,'BISNIS',302),(4,2023,'BISNIS',325),
(4,2024,'BISNIS',355),
(4,2015,'PUBLIK',70),(4,2016,'PUBLIK',76),(4,2017,'PUBLIK',81),
(4,2018,'PUBLIK',85),(4,2019,'PUBLIK',95),(4,2020,'PUBLIK',95),
(4,2021,'PUBLIK',101),(4,2022,'PUBLIK',105),(4,2023,'PUBLIK',113),
(4,2024,'PUBLIK',115),
(4,2015,'INDUSTRI',28),(4,2016,'INDUSTRI',30),(4,2017,'INDUSTRI',33),
(4,2018,'INDUSTRI',34),(4,2019,'INDUSTRI',41),(4,2020,'INDUSTRI',39),
(4,2021,'INDUSTRI',40),(4,2022,'INDUSTRI',40),(4,2023,'INDUSTRI',39),
(4,2024,'INDUSTRI',44);

INSERT INTO ruptl_proyeksi_kebutuhan (provinsi_id, tahun, pertumbuhan_ekonomi_pct, sales_gwh, produksi_gwh, beban_puncak_mw, pelanggan) VALUES
(4,2025,6.83,1081,1171,189,376085),
(4,2026,6.87,1124,1217,197,382478),
(4,2027,6.88,1180,1277,207,388795),
(4,2028,6.90,1240,1342,217,395038),
(4,2029,6.88,1303,1410,228,401222),
(4,2030,6.93,1375,1486,241,407358),
(4,2031,6.86,5831,6039,980,413454),
(4,2032,6.84,5912,6125,994,419520),
(4,2033,6.82,5998,6218,1010,425574),
(4,2034,6.80,6089,6316,1026,431568);

INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw, dmp_mw) VALUES
(4,'PLN','PLTU','Kepri',2,14.0,10.2,10.2),
(4,'PLN','PLTS','Kepri',3,0.8,0.7,0.7),
(4,'PLN','PLTD','Kepri',284,122.8,92.5,92.5),
(4,'IPP','PLTBM','Kepri',1,0.9,0.9,0.9);

INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun, keterangan) VALUES
(4,'RE_BASE','PLTS','Pembangkit EBT LISDES',2.2,2025,'Rencana - PLN'),
(4,'ARED','PLTS','Pembangkit EBT LISDES',2.2,2025,'Rencana - PLN'),
(4,'RE_BASE','PLTS','Pembangkit EBT LISDES',0.63,2025,'Rencana - PLN'),
(4,'ARED','PLTS','Pembangkit EBT LISDES',0.63,2025,'Rencana - PLN'),
(4,'RE_BASE','PLTS','Pembangkit EBT LISDES',0.74,2026,'Rencana - PLN'),
(4,'ARED','PLTS','Pembangkit EBT LISDES',0.74,2026,'Rencana - PLN'),
(4,'RE_BASE','PLTS','Pembangkit EBT LISDES',0.94,2027,'Rencana - PLN'),
(4,'ARED','PLTS','Pembangkit EBT LISDES',0.94,2027,'Rencana - PLN'),
(4,'RE_BASE','PLTS','PLTS + BESS Kepri',4,2027,'Rencana - IPP'),
(4,'ARED','PLTS','PLTS + BESS Kepri',4,2027,'Rencana - IPP'),
(4,'RE_BASE','PLTS','Dedieselisasi',15.6,2027,'Rencana - IPP'),
(4,'ARED','PLTS','Dedieselisasi',15.6,2027,'Rencana - IPP'),
(4,'RE_BASE','PLTBio','PLTBio (Kuota) Kepri',4,2029,'Rencana - IPP'),
(4,'ARED','PLTBio','PLTBio (Kuota) Kepri',4,2029,'Rencana - IPP'),
(4,'RE_BASE','PLTBio','PLTBio (Kuota) Kepri',2.4,2029,'Rencana - IPP'),
(4,'ARED','PLTBio','PLTBio (Kuota) Kepri',2.4,2029,'Rencana - IPP'),
(4,'RE_BASE','PLTS','Isolated Kepri Tersebar',4.77,2029,'Rencana - IPP'),
(4,'ARED','PLTS','Isolated Kepri Tersebar',4.77,2029,'Rencana - IPP'),
(4,'RE_BASE','PLTS','Isolated Kepri Tersebar',2.07,2030,'Rencana - IPP'),
(4,'ARED','PLTS','Isolated Kepri Tersebar',2.07,2030,'Rencana - IPP'),
(4,'RE_BASE','PLTS','PLTS + BESS Kepri',4,2032,'Rencana - IPP'),
(4,'ARED','PLTS','PLTS + BESS Kepri',4,2032,'Rencana - IPP'),
(4,'RE_BASE','PLTS','Isolated Kepri Tersebar',3.45,2033,'Rencana - IPP'),
(4,'ARED','PLTS','Isolated Kepri Tersebar',3.45,2033,'Rencana - IPP');

INSERT INTO ruptl_rencana_transmisi (provinsi_id, skenario, tahun, kms) VALUES
(4,'RE_BASE',2025,0),(4,'RE_BASE',2026,14),(4,'RE_BASE',2027,0),
(4,'RE_BASE',2028,0),(4,'RE_BASE',2029,0),(4,'RE_BASE',2030,10),
(4,'RE_BASE',2031,228),(4,'RE_BASE',2032,318),(4,'RE_BASE',2033,0),(4,'RE_BASE',2034,0),
(4,'ARED',2025,0),(4,'ARED',2026,14),(4,'ARED',2027,0),
(4,'ARED',2028,0),(4,'ARED',2029,0),(4,'ARED',2030,10),
(4,'ARED',2031,228),(4,'ARED',2032,318),(4,'ARED',2033,0),(4,'ARED',2034,0);

INSERT INTO ruptl_rencana_gardu_induk (provinsi_id, skenario, tahun, mva) VALUES
(4,'RE_BASE',2025,0),(4,'RE_BASE',2026,60),(4,'RE_BASE',2027,0),
(4,'RE_BASE',2028,0),(4,'RE_BASE',2029,0),(4,'RE_BASE',2030,60),
(4,'RE_BASE',2031,3000),(4,'RE_BASE',2032,1810),(4,'RE_BASE',2033,0),(4,'RE_BASE',2034,0),
(4,'ARED',2025,0),(4,'ARED',2026,60),(4,'ARED',2027,0),
(4,'ARED',2028,0),(4,'ARED',2029,0),(4,'ARED',2030,60),
(4,'ARED',2031,3000),(4,'ARED',2032,1810),(4,'ARED',2033,0),(4,'ARED',2034,0);

-- ============================================================
-- A5: KEPULAUAN BANGKA BELITUNG (provinsi_id=5)
-- ============================================================

INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh) VALUES
(5,2015,'RUMAH_TANGGA',603),(5,2016,'RUMAH_TANGGA',620),(5,2017,'RUMAH_TANGGA',619),
(5,2018,'RUMAH_TANGGA',645),(5,2019,'RUMAH_TANGGA',689),(5,2020,'RUMAH_TANGGA',718),
(5,2021,'RUMAH_TANGGA',735),(5,2022,'RUMAH_TANGGA',766),(5,2023,'RUMAH_TANGGA',821),
(5,2024,'RUMAH_TANGGA',861),
(5,2015,'BISNIS',148),(5,2016,'BISNIS',164),(5,2017,'BISNIS',178),
(5,2018,'BISNIS',193),(5,2019,'BISNIS',205),(5,2020,'BISNIS',194),
(5,2021,'BISNIS',205),(5,2022,'BISNIS',226),(5,2023,'BISNIS',249),
(5,2024,'BISNIS',267),
(5,2015,'PUBLIK',60),(5,2016,'PUBLIK',67),(5,2017,'PUBLIK',74),
(5,2018,'PUBLIK',80),(5,2019,'PUBLIK',88),(5,2020,'PUBLIK',89),
(5,2021,'PUBLIK',95),(5,2022,'PUBLIK',99),(5,2023,'PUBLIK',109),
(5,2024,'PUBLIK',105),
(5,2015,'INDUSTRI',51),(5,2016,'INDUSTRI',70),(5,2017,'INDUSTRI',108),
(5,2018,'INDUSTRI',149),(5,2019,'INDUSTRI',186),(5,2020,'INDUSTRI',225),
(5,2021,'INDUSTRI',335),(5,2022,'INDUSTRI',393),(5,2023,'INDUSTRI',431),
(5,2024,'INDUSTRI',527);

INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw, dmp_mw) VALUES
(5,'PLN','PLTU','Bangka',2,60.0,50.0,50.0),
(5,'PLN','PLTU','Belitung',2,33.0,28.0,28.0),
(5,'PLN','PLTS','Bangka',2,0.2,0.2,0.1),
(5,'PLN','PLTS','Belitung',2,0.1,0.1,0.0),
(5,'PLN','PLTD','Bangka',53,79.8,45.5,45.5),
(5,'PLN','PLTD','Belitung',25,36.2,17.0,17.0),
(5,'IPP','PLTG','Bangka',4,100.0,100.0,100.0),
(5,'IPP','PLTG','Belitung',1,25.0,25.0,25.0),
(5,'IPP','PLTBM','Bangka',1,5.0,5.0,3.0),
(5,'IPP','PLTBg','Bangka',2,4.0,4.0,4.0),
(5,'IPP','PLTBg','Belitung',1,1.8,1.8,1.8);

-- [A5 proyeksi, rencana pembangkit/transmisi/GI: akan ditambah setelah data dikumpulkan]


-- ============================================================
-- A5: KEPULAUAN BANGKA BELITUNG (provinsi_id=5) - LANJUTAN
-- ============================================================

INSERT INTO ruptl_proyeksi_kebutuhan (provinsi_id, tahun, pertumbuhan_ekonomi_pct, sales_gwh, produksi_gwh, beban_puncak_mw, pelanggan) VALUES
(5,2025,5.45,1870,2096,326,577690),
(5,2026,5.34,1985,2222,347,586520),
(5,2027,5.22,2103,2352,370,595183),
(5,2028,5.10,2222,2486,394,603660),
(5,2029,4.98,2344,2620,418,611944),
(5,2030,4.96,2468,2756,443,620046),
(5,2031,4.96,2593,2895,468,627961),
(5,2032,4.93,2721,3035,495,635714),
(5,2033,4.93,2850,3177,518,643278),
(5,2034,4.93,2981,3321,529,650672);

INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun, keterangan) VALUES
(5,'RE_BASE','PLTS','PLTS Belinyu (BUMD)',1,2025,'Konstruksi - IPP'),
(5,'ARED','PLTS','PLTS Belinyu (BUMD)',1,2025,'Konstruksi - IPP'),
(5,'RE_BASE','PLTS','Belitung (Kuota Tersebar)',5,2026,'Rencana - IPP'),
(5,'ARED','PLTS','Belitung (Kuota Tersebar)',5,2026,'Rencana - IPP'),
(5,'RE_BASE','PLTS','Bangka (Kuota Tersebar)',10,2027,'Rencana - IPP'),
(5,'ARED','PLTS','Bangka (Kuota Tersebar)',10,2027,'Rencana - IPP'),
(5,'RE_BASE','PLTMG','Belitung 1',21,2027,'Rencana - SH-PLN'),
(5,'ARED','PLTMG','Belitung 1',21,2027,'Rencana - SH-PLN'),
(5,'RE_BASE','PLTS','Isolated Babel Tersebar - Dedieselisasi',2.4,2027,'Rencana - IPP'),
(5,'ARED','PLTS','Isolated Babel Tersebar - Dedieselisasi',2.4,2027,'Rencana - IPP'),
(5,'RE_BASE','PLTMG','Belitung 2',30,2028,'Rencana - SH-PLN'),
(5,'ARED','PLTMG','Belitung 2',30,2028,'Rencana - SH-PLN'),
(5,'RE_BASE','PLTBio','PLTBio Bangka (Kuota) Tersebar',2,2029,'Rencana - IPP'),
(5,'ARED','PLTBio','PLTBio Bangka (Kuota) Tersebar',2,2029,'Rencana - IPP'),
(5,'RE_BASE','PLTBio','PLTBio Bangka (Kuota) Tersebar',5,2029,'Rencana - IPP'),
(5,'ARED','PLTBio','PLTBio Bangka (Kuota) Tersebar',5,2029,'Rencana - IPP'),
(5,'RE_BASE','PLTBio','PLTBio Bangka (Kuota) Tersebar',5,2029,'Rencana - IPP'),
(5,'ARED','PLTBio','PLTBio Bangka (Kuota) Tersebar',5,2029,'Rencana - IPP'),
(5,'RE_BASE','PLTS','Belitung (Kuota Tersebar)',10,2029,'Rencana - IPP'),
(5,'ARED','PLTS','Belitung (Kuota Tersebar)',10,2029,'Rencana - IPP'),
(5,'RE_BASE','PLTBg','PLTBg Belitung (Kuota) Tersebar',2,2029,'Rencana - IPP'),
(5,'ARED','PLTBg','PLTBg Belitung (Kuota) Tersebar',2,2029,'Rencana - IPP'),
(5,'RE_BASE','PLTS','Isolated Babel Tersebar',0.69,2030,'Rencana - IPP'),
(5,'ARED','PLTS','Isolated Babel Tersebar',0.69,2030,'Rencana - IPP'),
(5,'RE_BASE','PLTMG','Belitung 3',10,2031,'Rencana - SH-PLN'),
(5,'ARED','PLTMG','Belitung 3',10,2031,'Rencana - SH-PLN'),
(5,'ARED','PLTN','PLTN Sumatera-Bangka (Kuota) Tersebar New EBT',250,2032,'Rencana - IPP'),
(5,'RE_BASE','PLTBg','PLTBg Belitung (Kuota) Tersebar',4,2032,'Rencana - IPP'),
(5,'ARED','PLTBg','PLTBg Belitung (Kuota) Tersebar',4,2032,'Rencana - IPP'),
(5,'RE_BASE','PLTMG','Belitung 4',10,2033,'Rencana - SH-PLN'),
(5,'ARED','PLTMG','Belitung 4',10,2033,'Rencana - SH-PLN'),
(5,'RE_BASE','PLTS','Belitung (Kuota Tersebar)',12,2033,'Rencana - IPP'),
(5,'ARED','PLTS','Belitung (Kuota Tersebar)',12,2033,'Rencana - IPP'),
(5,'RE_BASE','PLTBg','PLTBg Belitung (Kuota) Tersebar',4,2033,'Rencana - IPP'),
(5,'ARED','PLTBg','PLTBg Belitung (Kuota) Tersebar',4,2033,'Rencana - IPP'),
(5,'RE_BASE','PLTS','Isolated Babel Tersebar',0.36,2033,'Rencana - IPP'),
(5,'ARED','PLTS','Isolated Babel Tersebar',0.36,2033,'Rencana - IPP'),
(5,'RE_BASE','PLTS','Surya Belitung + BESS',10,2034,'Rencana - SH-PLN'),
(5,'ARED','PLTS','Surya Belitung + BESS',10,2034,'Rencana - SH-PLN');

INSERT INTO ruptl_rencana_transmisi (provinsi_id, skenario, tahun, kms) VALUES
(5,'RE_BASE',2025,0),(5,'RE_BASE',2026,110),(5,'RE_BASE',2027,140),
(5,'RE_BASE',2028,184),(5,'RE_BASE',2029,0),(5,'RE_BASE',2030,0),
(5,'RE_BASE',2031,0),(5,'RE_BASE',2032,0),(5,'RE_BASE',2033,0),(5,'RE_BASE',2034,0),
(5,'ARED',2025,0),(5,'ARED',2026,110),(5,'ARED',2027,140),
(5,'ARED',2028,184),(5,'ARED',2029,0),(5,'ARED',2030,0),
(5,'ARED',2031,0),(5,'ARED',2032,0),(5,'ARED',2033,0),(5,'ARED',2034,0);

INSERT INTO ruptl_rencana_gardu_induk (provinsi_id, skenario, tahun, mva) VALUES
(5,'RE_BASE',2025,180),(5,'RE_BASE',2026,60),(5,'RE_BASE',2027,60),
(5,'RE_BASE',2028,120),(5,'RE_BASE',2029,0),(5,'RE_BASE',2030,0),
(5,'RE_BASE',2031,90),(5,'RE_BASE',2032,60),(5,'RE_BASE',2033,0),(5,'RE_BASE',2034,120),
(5,'ARED',2025,180),(5,'ARED',2026,60),(5,'ARED',2027,60),
(5,'ARED',2028,120),(5,'ARED',2029,0),(5,'ARED',2030,0),
(5,'ARED',2031,90),(5,'ARED',2032,60),(5,'ARED',2033,0),(5,'ARED',2034,120);

-- ============================================================
-- A6: SUMATERA BARAT (provinsi_id=6, beban_puncak_2024=699 MW)
-- ============================================================

UPDATE ruptl_provinsi SET beban_puncak_2024_mw=699 WHERE id=6;

INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh) VALUES
(6,2015,'RUMAH_TANGGA',1481),(6,2016,'RUMAH_TANGGA',1534),(6,2017,'RUMAH_TANGGA',1574),
(6,2018,'RUMAH_TANGGA',1596),(6,2019,'RUMAH_TANGGA',1650),(6,2020,'RUMAH_TANGGA',1718),
(6,2021,'RUMAH_TANGGA',1781),(6,2022,'RUMAH_TANGGA',1792),(6,2023,'RUMAH_TANGGA',1837),
(6,2024,'RUMAH_TANGGA',1940),
(6,2015,'BISNIS',400),(6,2016,'BISNIS',420),(6,2017,'BISNIS',450),
(6,2018,'BISNIS',503),(6,2019,'BISNIS',535),(6,2020,'BISNIS',527),
(6,2021,'BISNIS',574),(6,2022,'BISNIS',639),(6,2023,'BISNIS',730),
(6,2024,'BISNIS',780),
(6,2015,'PUBLIK',251),(6,2016,'PUBLIK',268),(6,2017,'PUBLIK',282),
(6,2018,'PUBLIK',304),(6,2019,'PUBLIK',335),(6,2020,'PUBLIK',327),
(6,2021,'PUBLIK',346),(6,2022,'PUBLIK',372),(6,2023,'PUBLIK',404),
(6,2024,'PUBLIK',437),
(6,2015,'INDUSTRI',838),(6,2016,'INDUSTRI',828),(6,2017,'INDUSTRI',998),
(6,2018,'INDUSTRI',986),(6,2019,'INDUSTRI',925),(6,2020,'INDUSTRI',857),
(6,2021,'INDUSTRI',945),(6,2022,'INDUSTRI',828),(6,2023,'INDUSTRI',840),
(6,2024,'INDUSTRI',897);

INSERT INTO ruptl_proyeksi_kebutuhan (provinsi_id, tahun, pertumbuhan_ekonomi_pct, sales_gwh, produksi_gwh, beban_puncak_mw, pelanggan) VALUES
(6,2025,6.68,4218,4472,739,1793901),
(6,2026,6.73,4388,4647,770,1835866),
(6,2027,6.74,4560,4826,801,1878131),
(6,2028,6.74,4746,5023,836,1920532),
(6,2029,6.76,4984,5270,879,1963021),
(6,2030,6.74,5238,5534,925,2005477),
(6,2031,6.69,5507,5813,974,2047855),
(6,2032,6.70,5795,6112,1026,2090200),
(6,2033,6.69,6101,6431,1080,2132409),
(6,2034,6.68,6429,6770,1137,2174415);

INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw, dmp_mw) VALUES
(6,'PLN','PLTA','Sumatera',11,253.5,252.9,253.3),
(6,'PLN','PLTG','Sumatera',2,43.0,32.7,29.3),
(6,'PLN','PLTU','Sumatera',4,424.0,355.0,355.0),
(6,'PLN','PLTD','Pokai',5,0.7,0.6,0.5),
(6,'PLN','PLTD','Mabolak',5,1.3,1.0,1.0),
(6,'PLN','PLTD','Seay Baru',5,0.5,0.4,0.4),
(6,'PLN','PLTD','Mailepet',7,1.8,1.4,1.1),
(6,'PLN','PLTD','Tua Pejat',8,4.8,3.7,3.4),
(6,'PLN','PLTD','Saibi',2,0.2,0.2,0.2),
(6,'IPP','PLTP','Sumatera',1,80.0,85.7,85.0),
(6,'IPP','PLTMH','Sumatera',10,48.9,48.7,48.7);

INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun, keterangan) VALUES
(6,'RE_BASE','PLTM','Bendungan PU Batanghari',5,2025,'Konstruksi - IPP'),
(6,'ARED','PLTM','Bendungan PU Batanghari',5,2025,'Konstruksi - IPP'),
(6,'RE_BASE','PLTM','Bayang Nyalo',6,2025,'Konstruksi - IPP'),
(6,'ARED','PLTM','Bayang Nyalo',6,2025,'Konstruksi - IPP'),
(6,'RE_BASE','PLTS','Pembangkit EBT LISDES',0.08,2025,'Rencana - PLN'),
(6,'ARED','PLTS','Pembangkit EBT LISDES',0.08,2025,'Rencana - PLN'),
(6,'RE_BASE','PLTM','Rabi Jonggor',4.5,2026,'Pendanaan - IPP'),
(6,'ARED','PLTM','Rabi Jonggor',4.5,2026,'Pendanaan - IPP'),
(6,'RE_BASE','PLTM','Tras',1.6,2026,'Pendanaan - IPP'),
(6,'ARED','PLTM','Tras',1.6,2026,'Pendanaan - IPP'),
(6,'RE_BASE','PLTS','Dedieselisasi',0.9,2027,'Rencana - IPP'),
(6,'ARED','PLTS','Dedieselisasi',0.9,2027,'Rencana - IPP'),
(6,'RE_BASE','PLTS','Dedieselisasi',5.4,2027,'Rencana - IPP'),
(6,'ARED','PLTS','Dedieselisasi',5.4,2027,'Rencana - IPP'),
(6,'RE_BASE','PLTP','Muara Laboh (FTP2)',80,2028,'PPA - IPP'),
(6,'ARED','PLTP','Muara Laboh (FTP2)',80,2028,'PPA - IPP'),
(6,'RE_BASE','PLTMG','Sumbagteng',25,2028,'Rencana - SH-PLN'),
(6,'ARED','PLTMG','Sumbagteng',25,2028,'Rencana - SH-PLN'),
(6,'RE_BASE','PLTA','Masang-2 (FTP2)',44,2029,'Committed - PLN'),
(6,'ARED','PLTA','Masang-2 (FTP2)',44,2029,'Committed - PLN'),
(6,'RE_BASE','PLTS','Isolated Sumbar Tersebar',5.1,2030,'Rencana - IPP'),
(6,'ARED','PLTS','Isolated Sumbar Tersebar',5.1,2030,'Rencana - IPP'),
(6,'RE_BASE','PLTM','Sumatera (Kuota) Tersebar Sumbagteng',4,2030,'Rencana - IPP'),
(6,'ARED','PLTM','Sumatera (Kuota) Tersebar Sumbagteng',4,2030,'Rencana - IPP'),
(6,'RE_BASE','PLTA','Sumagselteng (Kuota) Tersebar',110,2031,'Rencana - IPP'),
(6,'ARED','PLTA','Sumagselteng (Kuota) Tersebar',110,2031,'Rencana - IPP'),
(6,'RE_BASE','PLTA','Sumagselteng (kuota ISJ) Tersebar',350,2031,'Rencana - IPP'),
(6,'ARED','PLTA','Sumagselteng (kuota ISJ) Tersebar',350,2031,'Rencana - IPP'),
(6,'RE_BASE','PLTM','Sumatera (Kuota) Tersebar Sumbagteng',20.1,2031,'Rencana - IPP'),
(6,'ARED','PLTM','Sumatera (Kuota) Tersebar Sumbagteng',20.1,2031,'Rencana - IPP'),
(6,'RE_BASE','PLTP','Muara Laboh (FTP2)',60,2033,'PPA - IPP'),
(6,'ARED','PLTP','Muara Laboh (FTP2)',60,2033,'PPA - IPP'),
(6,'RE_BASE','PLTS','Isolated Sumbar Tersebar',24.2,2033,'Rencana - IPP'),
(6,'ARED','PLTS','Isolated Sumbar Tersebar',24.2,2033,'Rencana - IPP');

INSERT INTO ruptl_rencana_transmisi (provinsi_id, skenario, tahun, kms) VALUES
(6,'RE_BASE',2025,16),(6,'RE_BASE',2026,140),(6,'RE_BASE',2027,0),
(6,'RE_BASE',2028,80),(6,'RE_BASE',2029,49),(6,'RE_BASE',2030,0),
(6,'RE_BASE',2031,0),(6,'RE_BASE',2032,0),(6,'RE_BASE',2033,0),(6,'RE_BASE',2034,0),
(6,'ARED',2025,16),(6,'ARED',2026,140),(6,'ARED',2027,0),
(6,'ARED',2028,80),(6,'ARED',2029,49),(6,'ARED',2030,0),
(6,'ARED',2031,0),(6,'ARED',2032,0),(6,'ARED',2033,0),(6,'ARED',2034,0);

INSERT INTO ruptl_rencana_gardu_induk (provinsi_id, skenario, tahun, mva) VALUES
(6,'RE_BASE',2025,60),(6,'RE_BASE',2026,30),(6,'RE_BASE',2027,310),
(6,'RE_BASE',2028,0),(6,'RE_BASE',2029,180),(6,'RE_BASE',2030,90),
(6,'RE_BASE',2031,180),(6,'RE_BASE',2032,0),(6,'RE_BASE',2033,0),(6,'RE_BASE',2034,180),
(6,'ARED',2025,60),(6,'ARED',2026,30),(6,'ARED',2027,310),
(6,'ARED',2028,0),(6,'ARED',2029,180),(6,'ARED',2030,90),
(6,'ARED',2031,180),(6,'ARED',2032,0),(6,'ARED',2033,0),(6,'ARED',2034,180);


-- ============================================================
-- A7: JAMBI (provinsi_id=7, beban_puncak_2024=519 MW)
-- ============================================================

UPDATE ruptl_provinsi SET beban_puncak_2024_mw=519 WHERE id=7;

INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh) VALUES
(7,2015,'RUMAH_TANGGA',1001),(7,2016,'RUMAH_TANGGA',1041),(7,2017,'RUMAH_TANGGA',1070),
(7,2018,'RUMAH_TANGGA',1183),(7,2019,'RUMAH_TANGGA',1244),(7,2020,'RUMAH_TANGGA',1315),
(7,2021,'RUMAH_TANGGA',1373),(7,2022,'RUMAH_TANGGA',1422),(7,2023,'RUMAH_TANGGA',1502),
(7,2024,'RUMAH_TANGGA',1575),
(7,2015,'BISNIS',312),(7,2016,'BISNIS',338),(7,2017,'BISNIS',344),
(7,2018,'BISNIS',368),(7,2019,'BISNIS',385),(7,2020,'BISNIS',373),
(7,2021,'BISNIS',395),(7,2022,'BISNIS',419),(7,2023,'BISNIS',474),
(7,2024,'BISNIS',490),
(7,2015,'PUBLIK',109),(7,2016,'PUBLIK',121),(7,2017,'PUBLIK',125),
(7,2018,'PUBLIK',144),(7,2019,'PUBLIK',155),(7,2020,'PUBLIK',160),
(7,2021,'PUBLIK',161),(7,2022,'PUBLIK',169),(7,2023,'PUBLIK',193),
(7,2024,'PUBLIK',218),
(7,2015,'INDUSTRI',113),(7,2016,'INDUSTRI',108),(7,2017,'INDUSTRI',129),
(7,2018,'INDUSTRI',147),(7,2019,'INDUSTRI',148),(7,2020,'INDUSTRI',162),
(7,2021,'INDUSTRI',175),(7,2022,'INDUSTRI',201),(7,2023,'INDUSTRI',182),
(7,2024,'INDUSTRI',233);

INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw, dmp_mw) VALUES
(7,'PLN','PLTMG','Sumatera',11,104.7,93.5,93.5),
(7,'IPP','PLTMG','Sumatera',1,7.2,7.2,7.2);

INSERT INTO ruptl_proyeksi_kebutuhan (provinsi_id, tahun, pertumbuhan_ekonomi_pct, sales_gwh, produksi_gwh, beban_puncak_mw, pelanggan) VALUES
(7,2025,4.04,2662,3000,507,1200670),
(7,2026,4.03,2805,3147,532,1216426),
(7,2027,4.00,4344,4863,822,1231794),
(7,2028,3.96,4494,5031,850,1246919),
(7,2029,3.91,4649,5189,877,1261858),
(7,2030,3.89,4810,5352,904,1276538),
(7,2031,3.87,4975,5520,932,1290937),
(7,2032,3.86,5146,5694,961,1305165),
(7,2033,3.85,5324,5873,991,1319198),
(7,2034,3.84,5508,6058,1019,1333030);

INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun, keterangan) VALUES
(7,'RE_BASE','PLTA','Merangin',350,2025,'PPA - IPP'),
(7,'ARED','PLTA','Merangin',350,2025,'PPA - IPP'),
(7,'RE_BASE','PLTU MT','Jambi-1',600,2030,'PPA - IPP'),
(7,'ARED','PLTU MT','Jambi-1',600,2030,'PPA - IPP'),
(7,'RE_BASE','PLTU MT','Jambi-2',600,2032,'PPA - IPP'),
(7,'ARED','PLTU MT','Jambi-2',600,2032,'PPA - IPP'),
(7,'RE_BASE','PLTA','Bendungan Merangin PUPR',107,2032,'Rencana - IPP'),
(7,'ARED','PLTA','Bendungan Merangin PUPR',107,2032,'Rencana - IPP'),
(7,'RE_BASE','PLTP','Sungai Penuh (FTP2)',55,2033,'Konstruksi - SH-PLN'),
(7,'ARED','PLTP','Sungai Penuh (FTP2)',55,2033,'Konstruksi - SH-PLN'),
(7,'RE_BASE','PLTS','Sumatera (Kuota) Tersebar',100,2034,'Rencana - IPP'),
(7,'ARED','PLTS','Sumatera (Kuota) Tersebar',100,2034,'Rencana - IPP');

INSERT INTO ruptl_rencana_transmisi (provinsi_id, skenario, tahun, kms) VALUES
(7,'RE_BASE',2025,70),(7,'RE_BASE',2026,1),(7,'RE_BASE',2027,50),
(7,'RE_BASE',2028,0),(7,'RE_BASE',2029,0),(7,'RE_BASE',2030,0),
(7,'RE_BASE',2031,0),(7,'RE_BASE',2032,0),(7,'RE_BASE',2033,84),(7,'RE_BASE',2034,0),
(7,'ARED',2025,70),(7,'ARED',2026,1),(7,'ARED',2027,50),
(7,'ARED',2028,0),(7,'ARED',2029,0),(7,'ARED',2030,0),
(7,'ARED',2031,0),(7,'ARED',2032,0),(7,'ARED',2033,84),(7,'ARED',2034,0);

INSERT INTO ruptl_rencana_gardu_induk (provinsi_id, skenario, tahun, mva) VALUES
(7,'RE_BASE',2025,30),(7,'RE_BASE',2026,60),(7,'RE_BASE',2027,680),
(7,'RE_BASE',2028,30),(7,'RE_BASE',2029,120),(7,'RE_BASE',2030,0),
(7,'RE_BASE',2031,0),(7,'RE_BASE',2032,30),(7,'RE_BASE',2033,0),(7,'RE_BASE',2034,0),
(7,'ARED',2025,30),(7,'ARED',2026,60),(7,'ARED',2027,680),
(7,'ARED',2028,30),(7,'ARED',2029,120),(7,'ARED',2030,0),
(7,'ARED',2031,0),(7,'ARED',2032,30),(7,'ARED',2033,0),(7,'ARED',2034,0);


-- ============================================================
-- A8: SUMATERA SELATAN (provinsi_id=8, beban_puncak_2024=1221 MW)
-- ============================================================

UPDATE ruptl_provinsi SET beban_puncak_2024_mw=1221 WHERE id=8;

INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh) VALUES
(8,2015,'RUMAH_TANGGA',2486),(8,2016,'RUMAH_TANGGA',2599),(8,2017,'RUMAH_TANGGA',2657),
(8,2018,'RUMAH_TANGGA',2731),(8,2019,'RUMAH_TANGGA',2924),(8,2020,'RUMAH_TANGGA',3065),
(8,2021,'RUMAH_TANGGA',3213),(8,2022,'RUMAH_TANGGA',3295),(8,2023,'RUMAH_TANGGA',3494),
(8,2024,'RUMAH_TANGGA',3738),
(8,2015,'BISNIS',733),(8,2016,'BISNIS',743),(8,2017,'BISNIS',782),
(8,2018,'BISNIS',864),(8,2019,'BISNIS',926),(8,2020,'BISNIS',891),
(8,2021,'BISNIS',938),(8,2022,'BISNIS',874),(8,2023,'BISNIS',1141),
(8,2024,'BISNIS',1245),
(8,2015,'PUBLIK',328),(8,2016,'PUBLIK',351),(8,2017,'PUBLIK',373),
(8,2018,'PUBLIK',401),(8,2019,'PUBLIK',435),(8,2020,'PUBLIK',423),
(8,2021,'PUBLIK',444),(8,2022,'PUBLIK',498),(8,2023,'PUBLIK',534),
(8,2024,'PUBLIK',553),
(8,2015,'INDUSTRI',739),(8,2016,'INDUSTRI',780),(8,2017,'INDUSTRI',893),
(8,2018,'INDUSTRI',939),(8,2019,'INDUSTRI',970),(8,2020,'INDUSTRI',930),
(8,2021,'INDUSTRI',998),(8,2022,'INDUSTRI',1211),(8,2023,'INDUSTRI',1110),
(8,2024,'INDUSTRI',1319);

INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw, dmp_mw) VALUES
(8,'PLN','PLTD','Sumatera',2,25.0,19.0,19.0),
(8,'PLN','PLTG','Sumatera',6,126.0,76.5,76.5),
(8,'PLN','PLTGU','Sumatera',4,160.0,113.0,113.0),
(8,'PLN','PLTU','Sumatera',4,260.0,210.0,210.0),
(8,'IPP','PLTGU','Sumatera',6,279.8,279.8,279.0),
(8,'IPP','PLTMG','Sumatera',4,46.0,46.0,46.0),
(8,'IPP','PLTMH','Sumatera',3,19.4,19.4,19.4),
(8,'IPP','PLTP','Sumatera',3,153.8,126.2,126.2),
(8,'IPP','PLTS','Sumatera',1,2.0,2.0,2.0),
(8,'IPP','PLTU','Sumatera',12,2250.4,2250.4,2197.0);

INSERT INTO ruptl_proyeksi_kebutuhan (provinsi_id, tahun, pertumbuhan_ekonomi_pct, sales_gwh, produksi_gwh, beban_puncak_mw, pelanggan) VALUES
(8,2025,4.72,7346,8053,1420,2517344),
(8,2026,4.67,7799,8524,1502,2544979),
(8,2027,4.60,8195,8942,1574,2571942),
(8,2028,4.52,8613,9397,1653,2598232),
(8,2029,4.44,9151,9965,1751,2623853),
(8,2030,4.43,9848,10682,1875,2648894),
(8,2031,4.41,10340,11212,1966,2673450),
(8,2032,4.39,10853,11744,2058,2697611),
(8,2033,4.39,11787,12665,2218,2721419),
(8,2034,4.38,12350,13277,2314,2744886);

INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun, keterangan) VALUES
(8,'RE_BASE','PLTU MT','Sumsel-1',300,2025,'Konstruksi - IPP'),
(8,'ARED','PLTU MT','Sumsel-1',300,2025,'Konstruksi - IPP'),
(8,'RE_BASE','PLTU MT','Sumbagsel-1',150,2025,'Konstruksi - IPP'),
(8,'ARED','PLTU MT','Sumbagsel-1',150,2025,'Konstruksi - IPP'),
(8,'RE_BASE','PLTU MT','Sumsel-1 Unit 2',300,2025,'Konstruksi - IPP'),
(8,'ARED','PLTU MT','Sumsel-1 Unit 2',300,2025,'Konstruksi - IPP'),
(8,'RE_BASE','PLTU MT','Sumbagsel-1 Unit 2',150,2025,'Konstruksi - IPP'),
(8,'ARED','PLTU MT','Sumbagsel-1 Unit 2',150,2025,'Konstruksi - IPP'),
(8,'RE_BASE','PLTP','Lumut Balai (FTP2) #2',55,2025,'Konstruksi - IPP'),
(8,'ARED','PLTP','Lumut Balai (FTP2) #2',55,2025,'Konstruksi - IPP'),
(8,'RE_BASE','PLTGU','Sumbagsel 1',150,2026,'Rencana - IPP'),
(8,'ARED','PLTGU','Sumbagsel 1',150,2026,'Rencana - IPP'),
(8,'RE_BASE','PLTSa','PLTSa Palembang',17.7,2026,'Pengadaan - IPP'),
(8,'ARED','PLTSa','PLTSa Palembang',17.7,2026,'Pengadaan - IPP'),
(8,'RE_BASE','PLTS','Pembangkit EBT LISDES',4.9,2027,'Rencana - PLN'),
(8,'ARED','PLTS','Pembangkit EBT LISDES',4.9,2027,'Rencana - PLN'),
(8,'RE_BASE','PLTM','Kenali',3.6,2027,'Konstruksi - IPP'),
(8,'ARED','PLTM','Kenali',3.6,2027,'Konstruksi - IPP'),
(8,'RE_BASE','BESS','Sumatera BESS-1 #4',50,2028,'Rencana - SH-PLN'),
(8,'ARED','BESS','Sumatera BESS-1 #4',50,2028,'Rencana - SH-PLN'),
(8,'RE_BASE','PLTA','Sumbagselteng (Kuota) Tersebar',40,2029,'Rencana - IPP'),
(8,'ARED','PLTA','Sumbagselteng (Kuota) Tersebar',40,2029,'Rencana - IPP'),
(8,'RE_BASE','PLTP','Rantau Dedap (FTP2)',134,2030,'PPA - IPP'),
(8,'ARED','PLTP','Rantau Dedap (FTP2)',134,2030,'PPA - IPP'),
(8,'RE_BASE','PLTU MT','Sumatera Hybrid',600,2032,'Rencana - IPP'),
(8,'ARED','PLTU MT','Sumatera Hybrid',600,2032,'Rencana - IPP'),
(8,'RE_BASE','PLTS','Sumatera Hybrid PLTS',150,2032,'Rencana - IPP'),
(8,'ARED','PLTS','Sumatera Hybrid PLTS',150,2032,'Rencana - IPP'),
(8,'RE_BASE','BESS','Sumatera Hybrid BESS',75,2032,'Rencana - IPP'),
(8,'ARED','BESS','Sumatera Hybrid BESS',75,2032,'Rencana - IPP'),
(8,'RE_BASE','PLTU MT','Sumatera Hybrid Unit 2',600,2033,'Rencana - IPP'),
(8,'ARED','PLTU MT','Sumatera Hybrid Unit 2',600,2033,'Rencana - IPP'),
(8,'RE_BASE','PLTS','Sumatera Hybrid PLTS Unit 2',150,2033,'Rencana - IPP'),
(8,'ARED','PLTS','Sumatera Hybrid PLTS Unit 2',150,2033,'Rencana - IPP'),
(8,'RE_BASE','BESS','Sumatera Hybrid BESS Unit 2',75,2033,'Rencana - IPP'),
(8,'ARED','BESS','Sumatera Hybrid BESS Unit 2',75,2033,'Rencana - IPP'),
(8,'RE_BASE','PLTP','Danau Ranau (FTP2)',20,2033,'Committed - SH-PLN'),
(8,'ARED','PLTP','Danau Ranau (FTP2)',20,2033,'Committed - SH-PLN'),
(8,'RE_BASE','PLTA','Tanjung Sakti',94,2033,'Rencana - SH-PLN'),
(8,'ARED','PLTA','Tanjung Sakti',94,2033,'Rencana - SH-PLN'),
(8,'RE_BASE','PLTP','Lumut Balai (FTP2) #3',55,2033,'Konstruksi - IPP'),
(8,'ARED','PLTP','Lumut Balai (FTP2) #3',55,2033,'Konstruksi - IPP'),
(8,'RE_BASE','PLTP','Lumut Balai (FTP2) #4',55,2033,'Konstruksi - IPP'),
(8,'ARED','PLTP','Lumut Balai (FTP2) #4',55,2033,'Konstruksi - IPP');

INSERT INTO ruptl_rencana_transmisi (provinsi_id, skenario, tahun, kms) VALUES
(8,'RE_BASE',2025,457),(8,'RE_BASE',2026,480),(8,'RE_BASE',2027,14),
(8,'RE_BASE',2028,220),(8,'RE_BASE',2029,0),(8,'RE_BASE',2030,20),
(8,'RE_BASE',2031,0),(8,'RE_BASE',2032,0),(8,'RE_BASE',2033,227),(8,'RE_BASE',2034,0),
(8,'ARED',2025,457),(8,'ARED',2026,480),(8,'ARED',2027,14),
(8,'ARED',2028,220),(8,'ARED',2029,0),(8,'ARED',2030,20),
(8,'ARED',2031,0),(8,'ARED',2032,0),(8,'ARED',2033,227),(8,'ARED',2034,0);

INSERT INTO ruptl_rencana_gardu_induk (provinsi_id, skenario, tahun, mva) VALUES
(8,'RE_BASE',2025,680),(8,'RE_BASE',2026,0),(8,'RE_BASE',2027,680),
(8,'RE_BASE',2028,60),(8,'RE_BASE',2029,0),(8,'RE_BASE',2030,90),
(8,'RE_BASE',2031,0),(8,'RE_BASE',2032,180),(8,'RE_BASE',2033,120),(8,'RE_BASE',2034,90),
(8,'ARED',2025,680),(8,'ARED',2026,0),(8,'ARED',2027,680),
(8,'ARED',2028,60),(8,'ARED',2029,0),(8,'ARED',2030,90),
(8,'ARED',2031,0),(8,'ARED',2032,180),(8,'ARED',2033,120),(8,'ARED',2034,90);

-- ============================================================
-- A9: BENGKULU (provinsi_id=9, beban_puncak_2024=254 MW)
-- ============================================================

UPDATE ruptl_provinsi SET beban_puncak_2024_mw=254 WHERE id=9;

INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh) VALUES
(9,2015,'RUMAH_TANGGA',585),(9,2016,'RUMAH_TANGGA',602),(9,2017,'RUMAH_TANGGA',622),
(9,2018,'RUMAH_TANGGA',647),(9,2019,'RUMAH_TANGGA',670),(9,2020,'RUMAH_TANGGA',730),
(9,2021,'RUMAH_TANGGA',752),(9,2022,'RUMAH_TANGGA',766),(9,2023,'RUMAH_TANGGA',805),
(9,2024,'RUMAH_TANGGA',806),
(9,2015,'BISNIS',109),(9,2016,'BISNIS',110),(9,2017,'BISNIS',112),
(9,2018,'BISNIS',123),(9,2019,'BISNIS',133),(9,2020,'BISNIS',148),
(9,2021,'BISNIS',146),(9,2022,'BISNIS',149),(9,2023,'BISNIS',175),
(9,2024,'BISNIS',192),
(9,2015,'PUBLIK',60),(9,2016,'PUBLIK',64),(9,2017,'PUBLIK',66),
(9,2018,'PUBLIK',71),(9,2019,'PUBLIK',78),(9,2020,'PUBLIK',79),
(9,2021,'PUBLIK',80),(9,2022,'PUBLIK',87),(9,2023,'PUBLIK',92),
(9,2024,'PUBLIK',97),
(9,2015,'INDUSTRI',31),(9,2016,'INDUSTRI',48),(9,2017,'INDUSTRI',52),
(9,2018,'INDUSTRI',66),(9,2019,'INDUSTRI',74),(9,2020,'INDUSTRI',72),
(9,2021,'INDUSTRI',80),(9,2022,'INDUSTRI',85),(9,2023,'INDUSTRI',83),
(9,2024,'INDUSTRI',130);

INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw, dmp_mw) VALUES
(9,'PLN','PLTA','Sumatera',10,236.3,231.6,231.6),
(9,'PLN','PLTD','Sumatera (Ipuh)',5,2.8,1.4,1.4),
(9,'PLN','PLTD','Sumatera (Kota Bani)',10,6.6,4.3,4.3),
(9,'PLN','PLTD','Sumatera (Muko-Muko)',5,4.0,2.0,2.0),
(9,'PLN','PLTD','Enggano',3,1.0,0.6,0.6),
(9,'IPP','PLTA','Sumatera',4,33.0,33.0,32.5);

INSERT INTO ruptl_proyeksi_kebutuhan (provinsi_id, tahun, pertumbuhan_ekonomi_pct, sales_gwh, produksi_gwh, beban_puncak_mw, pelanggan) VALUES
(9,2025,4.46,1265,1381,257,663796),
(9,2026,4.43,1323,1439,268,672637),
(9,2027,4.38,1390,1510,281,681286),
(9,2028,4.32,1462,1588,295,689731),
(9,2029,4.25,1538,1667,309,697979),
(9,2030,4.23,1617,1749,324,706041),
(9,2031,4.21,1701,1836,339,713934),
(9,2032,4.20,1789,1926,355,721662),
(9,2033,4.19,1880,2021,372,729242),
(9,2034,4.19,1976,2119,388,736666);

INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun, keterangan) VALUES
(9,'RE_BASE','PLTM','Ketaun 3',9.99,2025,'Konstruksi - IPP'),
(9,'ARED','PLTM','Ketaun 3',9.99,2025,'Konstruksi - IPP'),
(9,'RE_BASE','PLTM','Kanzy 3',5,2025,'Konstruksi - IPP'),
(9,'ARED','PLTM','Kanzy 3',5,2025,'Konstruksi - IPP'),
(9,'RE_BASE','PLTS','Dedieselisasi',0.5,2027,'Rencana - IPP'),
(9,'ARED','PLTS','Dedieselisasi',0.5,2027,'Rencana - IPP'),
(9,'RE_BASE','PLTP','Hululais (FTP2) Unit 1',55,2028,'Pengadaan - PLN'),
(9,'ARED','PLTP','Hululais (FTP2) Unit 1',55,2028,'Pengadaan - PLN'),
(9,'RE_BASE','PLTP','Hululais (FTP2) Unit 2',55,2028,'Pengadaan - PLN'),
(9,'ARED','PLTP','Hululais (FTP2) Unit 2',55,2028,'Pengadaan - PLN'),
(9,'RE_BASE','PLTP','Kepahiang #2',55,2030,'Committed - SH-PLN'),
(9,'ARED','PLTP','Kepahiang #2',55,2030,'Committed - SH-PLN'),
(9,'RE_BASE','PLTP','Kepahiang #1',55,2030,'Committed - SH-PLN'),
(9,'ARED','PLTP','Kepahiang #1',55,2030,'Committed - SH-PLN');

INSERT INTO ruptl_rencana_transmisi (provinsi_id, skenario, tahun, kms) VALUES
(9,'RE_BASE',2025,124),(9,'RE_BASE',2026,0),(9,'RE_BASE',2027,0),
(9,'RE_BASE',2028,392),(9,'RE_BASE',2029,0),(9,'RE_BASE',2030,20),
(9,'RE_BASE',2031,0),(9,'RE_BASE',2032,0),(9,'RE_BASE',2033,77),(9,'RE_BASE',2034,0),
(9,'ARED',2025,124),(9,'ARED',2026,0),(9,'ARED',2027,0),
(9,'ARED',2028,392),(9,'ARED',2029,0),(9,'ARED',2030,20),
(9,'ARED',2031,0),(9,'ARED',2032,0),(9,'ARED',2033,77),(9,'ARED',2034,0);

INSERT INTO ruptl_rencana_gardu_induk (provinsi_id, skenario, tahun, mva) VALUES
(9,'RE_BASE',2025,60),(9,'RE_BASE',2026,0),(9,'RE_BASE',2027,0),
(9,'RE_BASE',2028,60),(9,'RE_BASE',2029,0),(9,'RE_BASE',2030,60),
(9,'RE_BASE',2031,0),(9,'RE_BASE',2032,0),(9,'RE_BASE',2033,0),(9,'RE_BASE',2034,0),
(9,'ARED',2025,60),(9,'ARED',2026,0),(9,'ARED',2027,0),
(9,'ARED',2028,60),(9,'ARED',2029,0),(9,'ARED',2030,60),
(9,'ARED',2031,0),(9,'ARED',2032,0),(9,'ARED',2033,0),(9,'ARED',2034,0);

-- ============================================================
-- A10: LAMPUNG (provinsi_id=10, beban_puncak_2024=1318 MW)
-- ============================================================

UPDATE ruptl_provinsi SET beban_puncak_2024_mw=1318 WHERE id=10;

INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh) VALUES
(10,2015,'RUMAH_TANGGA',2205),(10,2016,'RUMAH_TANGGA',2335),(10,2017,'RUMAH_TANGGA',2402),
(10,2018,'RUMAH_TANGGA',2492),(10,2019,'RUMAH_TANGGA',2746),(10,2020,'RUMAH_TANGGA',2950),
(10,2021,'RUMAH_TANGGA',3032),(10,2022,'RUMAH_TANGGA',3050),(10,2023,'RUMAH_TANGGA',3239),
(10,2024,'RUMAH_TANGGA',3400),
(10,2015,'BISNIS',401),(10,2016,'BISNIS',432),(10,2017,'BISNIS',468),
(10,2018,'BISNIS',525),(10,2019,'BISNIS',587),(10,2020,'BISNIS',594),
(10,2021,'BISNIS',645),(10,2022,'BISNIS',739),(10,2023,'BISNIS',855),
(10,2024,'BISNIS',909),
(10,2015,'PUBLIK',239),(10,2016,'PUBLIK',256),(10,2017,'PUBLIK',278),
(10,2018,'PUBLIK',322),(10,2019,'PUBLIK',379),(10,2020,'PUBLIK',361),
(10,2021,'PUBLIK',398),(10,2022,'PUBLIK',422),(10,2023,'PUBLIK',474),
(10,2024,'PUBLIK',501),
(10,2015,'INDUSTRI',726),(10,2016,'INDUSTRI',798),(10,2017,'INDUSTRI',851),
(10,2018,'INDUSTRI',919),(10,2019,'INDUSTRI',974),(10,2020,'INDUSTRI',1005),
(10,2021,'INDUSTRI',1101),(10,2022,'INDUSTRI',1172),(10,2023,'INDUSTRI',1195),
(10,2024,'INDUSTRI',1312);

INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw, dmp_mw) VALUES
(10,'PLN','PLTU','Sumatera',4,400.0,320.0,320.0),
(10,'PLN','PLTA','Sumatera',4,118.6,117.6,117.6),
(10,'PLN','PLTD','Sumatera',8,61.1,26.9,26.9),
(10,'PLN','PLTG','Sumatera',1,21.5,14.8,14.8),
(10,'PLN','PLTP','Sumatera',2,110.0,103.8,100.0),
(10,'PLN','PLTD','Pulau Sebesi',5,0.5,0.4,0.4),
(10,'IPP','PLTA','Sumatera',2,55.0,55.0,55.0),
(10,'IPP','PLTP','Sumatera',2,98.8,98.8,98.8),
(10,'IPP','PLTG','Sumatera',1,28.0,25.0,25.0);

INSERT INTO ruptl_proyeksi_kebutuhan (provinsi_id, tahun, pertumbuhan_ekonomi_pct, sales_gwh, produksi_gwh, beban_puncak_mw, pelanggan) VALUES
(10,2025,4.47,6470,7368,1189,2685033),
(10,2026,4.43,6837,7741,1244,2723573),
(10,2027,4.38,7222,8151,1306,2761565),
(10,2028,4.32,7622,8567,1367,2798920),
(10,2029,4.25,8036,8996,1431,2835613),
(10,2030,4.23,8469,9443,1497,2872018),
(10,2031,4.21,8861,9849,1556,2903577),
(10,2032,4.20,9263,10255,1614,2936619),
(10,2033,4.19,9680,10716,1681,2969266),
(10,2034,4.19,10110,11192,1750,3001492);


-- A10: Lampung rencana pembangkit + transmisi + GI

INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun, keterangan) VALUES
(10,'RE_BASE','PLTM','Sumber Jaya',6.0,2025,'Konstruksi - IPP'),
(10,'ARED','PLTM','Sumber Jaya',6.0,2025,'Konstruksi - IPP'),
(10,'RE_BASE','PLTM','Way Meleson 2',2.3,2025,'Konstruksi - IPP'),
(10,'ARED','PLTM','Way Meleson 2',2.3,2025,'Konstruksi - IPP'),
(10,'RE_BASE','PLTM','Kukusan 2',5.4,2025,'Konstruksi - IPP'),
(10,'ARED','PLTM','Kukusan 2',5.4,2025,'Konstruksi - IPP'),
(10,'RE_BASE','PLTP','Sumatera (Kuota) Tersebar',40.0,2027,'Rencana - IPP'),
(10,'ARED','PLTP','Sumatera (Kuota) Tersebar',40.0,2027,'Rencana - IPP'),
(10,'RE_BASE','BESS','Sumatera BESS-1 #2',50.0,2027,'Rencana - SH-PLN'),
(10,'ARED','BESS','Sumatera BESS-1 #2',50.0,2027,'Rencana - SH-PLN'),
(10,'RE_BASE','PLTS','Dedieselisasi',0.6,2027,'Rencana - IPP'),
(10,'ARED','PLTS','Dedieselisasi',0.6,2027,'Rencana - IPP'),
(10,'RE_BASE','PLTS','Isolated Lampung Tersebar',0.4,2028,'Rencana - IPP'),
(10,'ARED','PLTS','Isolated Lampung Tersebar',0.4,2028,'Rencana - IPP'),
(10,'RE_BASE','PLTG','Sumbagsel 2',300.0,2029,'Rencana - SH-PLN'),
(10,'ARED','PLTG','Sumbagsel 2',300.0,2029,'Rencana - SH-PLN'),
(10,'RE_BASE','PLTM','Sumatera (Kuota) Tersebar Sumbagsel',9.5,2029,'Rencana - IPP'),
(10,'ARED','PLTM','Sumatera (Kuota) Tersebar Sumbagsel',9.5,2029,'Rencana - IPP'),
(10,'RE_BASE','PLTM','Sumatera (Kuota) Tersebar Sumbagsel #2',5.4,2029,'Rencana - IPP'),
(10,'ARED','PLTM','Sumatera (Kuota) Tersebar Sumbagsel #2',5.4,2029,'Rencana - IPP'),
(10,'RE_BASE','PLTS','PLTS BESS Sumatera 1',236.0,2029,'Rencana - SH-PLN'),
(10,'ARED','PLTS','PLTS BESS Sumatera 1',236.0,2029,'Rencana - SH-PLN'),
(10,'RE_BASE','BESS','PLTS BESS Sumatera 1',150.0,2029,'Rencana - SH-PLN'),
(10,'ARED','BESS','PLTS BESS Sumatera 1',150.0,2029,'Rencana - SH-PLN'),
(10,'RE_BASE','PLTS','Isolated Lampung Tersebar',0.2,2029,'Rencana - IPP'),
(10,'ARED','PLTS','Isolated Lampung Tersebar',0.2,2029,'Rencana - IPP'),
(10,'RE_BASE','BESS','Sumatera BESS-3',100.0,2030,'Rencana - SH-PLN'),
(10,'ARED','BESS','Sumatera BESS-3',100.0,2030,'Rencana - SH-PLN'),
(10,'RE_BASE','PLTS','PLTS BESS Sumatera 3',150.0,2030,'Rencana - IPP'),
(10,'ARED','PLTS','PLTS BESS Sumatera 3',150.0,2030,'Rencana - IPP'),
(10,'RE_BASE','BESS','PLTS BESS Sumatera 3',75.0,2030,'Rencana - IPP'),
(10,'ARED','BESS','PLTS BESS Sumatera 3',75.0,2030,'Rencana - IPP'),
(10,'RE_BASE','PLTP','Rajabasa (FTP2)',110.0,2031,'PPA - IPP'),
(10,'ARED','PLTP','Rajabasa (FTP2)',110.0,2031,'PPA - IPP'),
(10,'RE_BASE','PLTS','Isolated Lampung Tersebar',0.6,2031,'Rencana - IPP'),
(10,'ARED','PLTS','Isolated Lampung Tersebar',0.6,2031,'Rencana - IPP'),
(10,'RE_BASE','PLTB','Bayu Sumatera (Kuota) Tersebar',270.0,2033,'Rencana - IPP'),
(10,'ARED','PLTB','Bayu Sumatera (Kuota) Tersebar',270.0,2033,'Rencana - IPP'),
(10,'RE_BASE','PLTP','Rajabasa (FTP2) Unit 2',110.0,2033,'PPA - IPP'),
(10,'ARED','PLTP','Rajabasa (FTP2) Unit 2',110.0,2033,'PPA - IPP'),
(10,'RE_BASE','PLTP','Sumatera (Kuota) Tersebar',115.0,2033,'Rencana - IPP'),
(10,'ARED','PLTP','Sumatera (Kuota) Tersebar',115.0,2033,'Rencana - IPP'),
(10,'RE_BASE','PLTS','Isolated Lampung Tersebar',0.2,2033,'Rencana - IPP'),
(10,'ARED','PLTS','Isolated Lampung Tersebar',0.2,2033,'Rencana - IPP'),
(10,'RE_BASE','PLTS','Isolated Lampung Tersebar',0.79,2034,'Rencana - IPP'),
(10,'ARED','PLTS','Isolated Lampung Tersebar',0.79,2034,'Rencana - IPP');

INSERT INTO ruptl_rencana_transmisi (provinsi_id, skenario, tahun, kms) VALUES
(10,'RE_BASE',2025,522),(10,'RE_BASE',2026,20),(10,'RE_BASE',2027,94),
(10,'RE_BASE',2028,0),(10,'RE_BASE',2029,0),(10,'RE_BASE',2030,0),
(10,'RE_BASE',2031,0),(10,'RE_BASE',2032,0),(10,'RE_BASE',2033,0),(10,'RE_BASE',2034,0),
(10,'ARED',2025,522),(10,'ARED',2026,20),(10,'ARED',2027,94),
(10,'ARED',2028,0),(10,'ARED',2029,0),(10,'ARED',2030,0),
(10,'ARED',2031,0),(10,'ARED',2032,0),(10,'ARED',2033,0),(10,'ARED',2034,0);

INSERT INTO ruptl_rencana_gardu_induk (provinsi_id, skenario, tahun, mva) VALUES
(10,'RE_BASE',2025,620),(10,'RE_BASE',2026,120),(10,'RE_BASE',2027,180),
(10,'RE_BASE',2028,0),(10,'RE_BASE',2029,120),(10,'RE_BASE',2030,240),
(10,'RE_BASE',2031,120),(10,'RE_BASE',2032,180),(10,'RE_BASE',2033,420),(10,'RE_BASE',2034,300),
(10,'ARED',2025,620),(10,'ARED',2026,120),(10,'ARED',2027,180),
(10,'ARED',2028,0),(10,'ARED',2029,120),(10,'ARED',2030,240),
(10,'ARED',2031,120),(10,'ARED',2032,180),(10,'ARED',2033,420),(10,'ARED',2034,300);

-- ============================================================
-- A11: KALIMANTAN BARAT (provinsi_id=11, beban_puncak_2024=632 MW)
-- ============================================================

UPDATE ruptl_provinsi SET beban_puncak_2024_mw=632 WHERE id=11;

INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh) VALUES
(11,2015,'RUMAH_TANGGA',1297),(11,2016,'RUMAH_TANGGA',1398),(11,2017,'RUMAH_TANGGA',1430),
(11,2018,'RUMAH_TANGGA',1471),(11,2019,'RUMAH_TANGGA',1589),(11,2020,'RUMAH_TANGGA',1732),
(11,2021,'RUMAH_TANGGA',1851),(11,2022,'RUMAH_TANGGA',1906),(11,2023,'RUMAH_TANGGA',2055),
(11,2024,'RUMAH_TANGGA',2134),
(11,2015,'BISNIS',417),(11,2016,'BISNIS',471),(11,2017,'BISNIS',498),
(11,2018,'BISNIS',538),(11,2019,'BISNIS',567),(11,2020,'BISNIS',555),
(11,2021,'BISNIS',584),(11,2022,'BISNIS',626),(11,2023,'BISNIS',692),
(11,2024,'BISNIS',707),
(11,2015,'PUBLIK',173),(11,2016,'PUBLIK',184),(11,2017,'PUBLIK',189),
(11,2018,'PUBLIK',205),(11,2019,'PUBLIK',233),(11,2020,'PUBLIK',231),
(11,2021,'PUBLIK',245),(11,2022,'PUBLIK',270),(11,2023,'PUBLIK',295),
(11,2024,'PUBLIK',298),
(11,2015,'INDUSTRI',103),(11,2016,'INDUSTRI',107),(11,2017,'INDUSTRI',136),
(11,2018,'INDUSTRI',159),(11,2019,'INDUSTRI',183),(11,2020,'INDUSTRI',198),
(11,2021,'INDUSTRI',232),(11,2022,'INDUSTRI',233),(11,2023,'INDUSTRI',267),
(11,2024,'INDUSTRI',286);

INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw, dmp_mw) VALUES
(11,'PLN','PLTD','Khatulistiwa',23,94.2,64.8,58.6),
(11,'PLN','PLTD','Putussibau',15,15.4,12.5,11.4),
(11,'PLN','PLTD','Ketapang',16,27.1,20.1,20.1),
(11,'PLN','PLTD','Air Upas',6,3.2,3.2,3.1),
(11,'PLN','PLTD','Kota Baru',4,3.5,1.5,1.7),
(11,'PLN','PLTD','Semitau',9,6.9,4.5,3.9),
(11,'PLN','PLTD','Tepuai',4,5.3,4.0,3.8),
(11,'PLN','PLTD','Badau',3,2.1,1.1,1.2),
(11,'PLN','PLTD','Padang Tikar',8,6.1,3.6,2.5),
(11,'PLN','PLTG','Khatulistiwa',1,34.0,30.0,30.0),
(11,'PLN','PLTU','Khatulistiwa',7,135.0,110.6,119.3),
(11,'PLN','PLTU','Ketapang',2,20.0,16.0,17.2),
(11,'IPP','PLTBm','Khatulistiwa',1,10.0,10.0,14.6),
(11,'IPP','PLTG','Khatulistiwa',4,100.0,100.0,100.0),
(11,'IPP','PLTU','Khatulistiwa',2,200.0,200.0,211.3);

INSERT INTO ruptl_proyeksi_kebutuhan (provinsi_id, tahun, pertumbuhan_ekonomi_pct, sales_gwh, produksi_gwh, beban_puncak_mw, pelanggan) VALUES
(11,2025,4.57,3596,4082,662,1558712),
(11,2026,4.53,3791,4288,694,1587399),
(11,2027,4.47,3953,4461,721,1615923),
(11,2028,4.40,4117,4646,750,1644265),
(11,2029,4.33,4285,4823,777,1672394),
(11,2030,4.31,4458,5005,806,1700323),
(11,2031,4.29,4637,5191,835,1728093),
(11,2032,4.28,4821,5384,864,1755751),
(11,2033,4.27,5011,5581,895,1783310),
(11,2034,4.27,5207,5785,926,1810759);

-- Rencana Pembangkit A11 (RE Base vs ARED berbeda untuk beberapa item)
INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun, keterangan) VALUES
(11,'RE_BASE','PLTBm','Kuala Mandor',5.0,2025,'Konstruksi - IPP'),
(11,'ARED','PLTBm','Kuala Mandor',5.0,2025,'Konstruksi - IPP'),
(11,'RE_BASE','PLTS','Lisdes Kalbar',1.9,2025,'Rencana - PLN'),
(11,'ARED','PLTS','Lisdes Kalbar',1.9,2025,'Rencana - PLN'),
(11,'RE_BASE','PLTGU','Kalbar-1',250.0,2026,'Rencana - SH-PLN'),
(11,'ARED','PLTGU','Kalbar-1',250.0,2026,'Rencana - SH-PLN'),
(11,'ARED','PLTS','Kalbar-1 (PLTS+BESS)',80.0,2026,'Rencana - IPP'),
(11,'ARED','BESS','Kalbar-1 (PLTS+BESS)',50.0,2026,'Rencana - IPP'),
(11,'RE_BASE','PLTG','Kalbar-2',100.0,2027,'Rencana - IPP'),
(11,'RE_BASE','PLTM','Setanggi',5.0,2027,'PPA - IPP'),
(11,'ARED','PLTM','Setanggi',5.0,2027,'PPA - IPP'),
(11,'RE_BASE','PLTM','Manajur',5.0,2027,'PPA - IPP'),
(11,'ARED','PLTM','Manajur',5.0,2027,'PPA - IPP'),
(11,'ARED','PLTS','Kalbar-1 (PLTS+BESS) #2',40.0,2027,'Rencana - IPP'),
(11,'ARED','BESS','Kalbar-1 (PLTS+BESS) #2',25.0,2027,'Rencana - IPP'),
(11,'RE_BASE','PLTS','Dedieselisasi',21.6,2027,'Pengadaan - IPP'),
(11,'ARED','PLTS','Dedieselisasi',21.6,2027,'Pengadaan - IPP'),
(11,'RE_BASE','PLTS','Lisdes Kalbar #2',15.1,2027,'Rencana - PLN'),
(11,'ARED','PLTS','Lisdes Kalbar #2',15.1,2027,'Rencana - PLN'),
(11,'RE_BASE','PLTS','Kalbar (SH-PLN)',50.0,2028,'Rencana - SH-PLN'),
(11,'ARED','PLTS','Kalbar (SH-PLN)',50.0,2028,'Rencana - SH-PLN'),
(11,'RE_BASE','PLTM','Khatulistiwa (Kuota) Tersebar',16.0,2028,'Rencana - IPP'),
(11,'ARED','PLTM','Khatulistiwa (Kuota) Tersebar',16.0,2028,'Rencana - IPP'),
(11,'RE_BASE','PLTBg','Kalimantan (Kuota) Tersebar',7.5,2029,'Rencana - IPP'),
(11,'ARED','PLTBg','Kalimantan (Kuota) Tersebar',7.5,2029,'Rencana - IPP'),
(11,'RE_BASE','PLTM','Kalbar',2.0,2029,'Rencana - PLN'),
(11,'ARED','PLTM','Kalbar',2.0,2029,'Rencana - PLN'),
(11,'RE_BASE','PLTMG','Kalbar-3',50.0,2029,'Rencana - IPP'),
(11,'ARED','PLTS','Kalbar-2 (PLTS+BESS)',80.0,2029,'Rencana - IPP'),
(11,'ARED','BESS','Kalbar-2 (PLTS+BESS)',50.0,2029,'Rencana - IPP'),
(11,'RE_BASE','PLTBm','Kalimantan (Kuota) Tersebar',17.0,2030,'Rencana - IPP'),
(11,'ARED','PLTBm','Kalimantan (Kuota) Tersebar',17.0,2030,'Rencana - IPP'),
(11,'RE_BASE','PLTU','Parit Baru (FTP1)',50.0,2030,'Konstruksi - PLN'),
(11,'RE_BASE','PLTU','Parit Baru (FTP1) #2',50.0,2030,'Konstruksi - PLN'),
(11,'RE_BASE','PLTU','Pantai Kura-Kura (FTP1)',27.5,2030,'Konstruksi - PLN'),
(11,'RE_BASE','PLTU','Pantai Kura-Kura (FTP1) #2',27.5,2030,'Konstruksi - PLN'),
(11,'RE_BASE','PLTA','Khatulistiwa (Kuota) Tersebar',150.0,2030,'Rencana - IPP'),
(11,'ARED','PLTS','Kalbar-2 (PLTS+BESS) #2',160.0,2030,'Rencana - IPP'),
(11,'ARED','BESS','Kalbar-2 (PLTS+BESS) #2',100.0,2030,'Rencana - IPP'),
(11,'ARED','PLTA','Khatulistiwa (Kuota) Tersebar',150.0,2031,'Rencana - IPP'),
(11,'RE_BASE','PLTBm','Kalimantan (Kuota) Tersebar #2',10.0,2031,'Rencana - IPP'),
(11,'ARED','PLTBm','Kalimantan (Kuota) Tersebar #2',10.0,2031,'Rencana - IPP'),
(11,'RE_BASE','PLTBg','Kalimantan (Kuota) Tersebar #2',4.0,2031,'Rencana - IPP'),
(11,'ARED','PLTBg','Kalimantan (Kuota) Tersebar #2',4.0,2031,'Rencana - IPP'),
(11,'RE_BASE','PLTA','Khatulistiwa (Kuota) Tersebar #2',100.0,2032,'Rencana - IPP'),
(11,'ARED','PLTA','Khatulistiwa (Kuota) Tersebar #2',100.0,2032,'Rencana - IPP'),
(11,'RE_BASE','PLTBm','Kalimantan (Kuota) Tersebar #3',16.0,2032,'Rencana - IPP'),
(11,'ARED','PLTBm','Kalimantan (Kuota) Tersebar #3',16.0,2032,'Rencana - IPP'),
(11,'ARED','PLTU','Parit Baru (FTP1)',50.0,2033,'Konstruksi - PLN'),
(11,'ARED','PLTU','Parit Baru (FTP1) #2',50.0,2033,'Konstruksi - PLN'),
(11,'ARED','PLTU','Pantai Kura-Kura (FTP1)',27.5,2033,'Konstruksi - PLN'),
(11,'ARED','PLTU','Pantai Kura-Kura (FTP1) #2',27.5,2033,'Konstruksi - PLN'),
(11,'RE_BASE','PLTBm','Kalimantan (Kuota) Tersebar #4',5.0,2033,'Rencana - IPP'),
(11,'ARED','PLTBm','Kalimantan (Kuota) Tersebar #4',5.0,2033,'Rencana - IPP'),
(11,'RE_BASE','PLTBg','Kalimantan (Kuota) Tersebar #3',1.2,2033,'Rencana - IPP'),
(11,'ARED','PLTBg','Kalimantan (Kuota) Tersebar #3',1.2,2033,'Rencana - IPP'),
(11,'RE_BASE','PLTA','Khatulistiwa (Kuota) Tersebar #3',100.0,2033,'Rencana - IPP'),
(11,'ARED','PLTN','PLTN Kalimantan (Kuota) Tersebar New EBT',250.0,2033,'Rencana - IPP'),
(11,'RE_BASE','PLTU','Parit Baru (FTP1) ARED',50.0,2034,'Konstruksi - PLN'),
(11,'RE_BASE','PLTA','Khatulistiwa (Kuota) Tersebar #4',100.0,2034,'Rencana - IPP');


-- A11 Transmisi + GI (RE Base vs ARED berbeda di 2030)
INSERT INTO ruptl_rencana_transmisi (provinsi_id, skenario, tahun, kms) VALUES
(11,'RE_BASE',2025,478),(11,'RE_BASE',2026,620.6),(11,'RE_BASE',2027,204),
(11,'RE_BASE',2028,432.5),(11,'RE_BASE',2029,0),(11,'RE_BASE',2030,6),
(11,'RE_BASE',2031,144),(11,'RE_BASE',2032,0),(11,'RE_BASE',2033,0),(11,'RE_BASE',2034,0),
(11,'ARED',2025,478),(11,'ARED',2026,620.6),(11,'ARED',2027,204),
(11,'ARED',2028,432.5),(11,'ARED',2029,0),(11,'ARED',2030,0),
(11,'ARED',2031,144),(11,'ARED',2032,0),(11,'ARED',2033,0),(11,'ARED',2034,0);

INSERT INTO ruptl_rencana_gardu_induk (provinsi_id, skenario, tahun, mva) VALUES
(11,'RE_BASE',2025,180),(11,'RE_BASE',2026,120),(11,'RE_BASE',2027,30),
(11,'RE_BASE',2028,150),(11,'RE_BASE',2029,60),(11,'RE_BASE',2030,30),
(11,'RE_BASE',2031,30),(11,'RE_BASE',2032,60),(11,'RE_BASE',2033,0),(11,'RE_BASE',2034,60),
(11,'ARED',2025,180),(11,'ARED',2026,120),(11,'ARED',2027,30),
(11,'ARED',2028,150),(11,'ARED',2029,60),(11,'ARED',2030,30),
(11,'ARED',2031,30),(11,'ARED',2032,60),(11,'ARED',2033,0),(11,'ARED',2034,60);

-- ============================================================
-- A12: KALIMANTAN SELATAN (provinsi_id=13)
-- ============================================================

INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh) VALUES
(13,2015,'RUMAH_TANGGA',1420),(13,2016,'RUMAH_TANGGA',1490),(13,2017,'RUMAH_TANGGA',1496),
(13,2018,'RUMAH_TANGGA',1553),(13,2019,'RUMAH_TANGGA',1666),(13,2020,'RUMAH_TANGGA',1783),
(13,2021,'RUMAH_TANGGA',1814),(13,2022,'RUMAH_TANGGA',1846),(13,2023,'RUMAH_TANGGA',1950),
(13,2024,'RUMAH_TANGGA',2087),
(13,2015,'BISNIS',388),(13,2016,'BISNIS',413),(13,2017,'BISNIS',435),
(13,2018,'BISNIS',493),(13,2019,'BISNIS',539),(13,2020,'BISNIS',511),
(13,2021,'BISNIS',533),(13,2022,'BISNIS',589),(13,2023,'BISNIS',662),
(13,2024,'BISNIS',687),
(13,2015,'PUBLIK',185),(13,2016,'PUBLIK',202),(13,2017,'PUBLIK',213),
(13,2018,'PUBLIK',237),(13,2019,'PUBLIK',263),(13,2020,'PUBLIK',254),
(13,2021,'PUBLIK',270),(13,2022,'PUBLIK',303),(13,2023,'PUBLIK',334),
(13,2024,'PUBLIK',409),
(13,2015,'INDUSTRI',194),(13,2016,'INDUSTRI',211),(13,2017,'INDUSTRI',249),
(13,2018,'INDUSTRI',320),(13,2019,'INDUSTRI',379),(13,2020,'INDUSTRI',392),
(13,2021,'INDUSTRI',433),(13,2022,'INDUSTRI',561),(13,2023,'INDUSTRI',747),
(13,2024,'INDUSTRI',820);

INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw, dmp_mw) VALUES
(13,'PLN','PLTA','Barito',3,30.0,28.5,28.5),
(13,'PLN','PLTD','Barito',13,73.3,47.4,49.1),
(13,'PLN','PLTD','Sei Durian',41,6.9,5.5,5.5),
(13,'PLN','PLTD','Sebuku',9,2.7,2.2,2.2),
(13,'PLN','PLTD','Isolated Tersebar',17,1.9,1.4,1.4),
(13,'PLN','PLTG','Barito',1,21.0,17.0,17.0),
(13,'PLN','PLTU','Barito',6,460.0,416.0,418.8),
(13,'IPP','PLTU','Barito',2,200.0,200.0,201.8);

INSERT INTO ruptl_proyeksi_kebutuhan (provinsi_id, tahun, pertumbuhan_ekonomi_pct, sales_gwh, produksi_gwh, beban_puncak_mw, pelanggan) VALUES
(13,2025,4.36,4299,4774,774,1536544),
(13,2026,4.33,4572,5076,822,1569591),
(13,2027,4.29,4820,5350,865,1602848),
(13,2028,4.23,5055,5610,905,1636276),
(13,2029,4.17,5296,5876,947,1669870),
(13,2030,4.13,5545,6150,990,1703718),
(13,2031,4.13,5804,6436,1034,1737888),
(13,2032,4.11,6073,6732,1080,1772359),
(13,2033,4.11,6352,7039,1128,1807163),
(13,2034,4.10,6640,7357,1177,1844509);

INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun, keterangan) VALUES
(13,'RE_BASE','PLTB','Tanah Laut',70.0,2026,'Pengadaan - IPP'),
(13,'ARED','PLTB','Tanah Laut',70.0,2026,'Pengadaan - IPP'),
(13,'RE_BASE','PLTS','Lisdes Kalsel',4.9,2026,'Rencana - PLN'),
(13,'ARED','PLTS','Lisdes Kalsel',4.9,2026,'Rencana - PLN'),
(13,'RE_BASE','PLTG','Kalselteng',100.0,2027,'Rencana - SH-PLN'),
(13,'ARED','PLTG','Kalselteng',100.0,2027,'Rencana - SH-PLN'),
(13,'RE_BASE','PLTS','Lisdes Kalsel #2',0.6,2027,'Rencana - PLN'),
(13,'ARED','PLTS','Lisdes Kalsel #2',0.6,2027,'Rencana - PLN'),
(13,'RE_BASE','PLTGU','Kalimantan-1',150.0,2028,'Rencana - SH-PLN'),
(13,'RE_BASE','PLTM','Kalseltengtimra (Kuota) Tersebar',2.7,2029,'Rencana - IPP'),
(13,'ARED','PLTM','Kalseltengtimra (Kuota) Tersebar',2.7,2029,'Rencana - IPP'),
(13,'RE_BASE','PLTU','Kotabaru',14.0,2030,'Konstruksi - PLN'),
(13,'RE_BASE','PLTS','Isolated Kalsel',0.8,2030,'Rencana - IPP'),
(13,'ARED','PLTS','Isolated Kalsel',0.8,2030,'Rencana - IPP'),
(13,'ARED','PLTGU','Add-On Kalselteng',50.0,2030,'Rencana - SH-PLN'),
(13,'ARED','PLTU','Kotabaru',14.0,2033,'Konstruksi - PLN'),
(13,'RE_BASE','PLTS','Isolated Kalsel (PLTS+BESS)',0.4,2033,'Rencana - IPP'),
(13,'ARED','PLTS','Isolated Kalsel (PLTS+BESS)',0.4,2033,'Rencana - IPP');

INSERT INTO ruptl_rencana_transmisi (provinsi_id, skenario, tahun, kms) VALUES
(13,'RE_BASE',2025,281),(13,'RE_BASE',2026,169),(13,'RE_BASE',2027,6),
(13,'RE_BASE',2028,66),(13,'RE_BASE',2029,0),(13,'RE_BASE',2030,143),
(13,'RE_BASE',2031,0),(13,'RE_BASE',2032,0),(13,'RE_BASE',2033,0),(13,'RE_BASE',2034,0),
(13,'ARED',2025,281),(13,'ARED',2026,169),(13,'ARED',2027,6),
(13,'ARED',2028,56),(13,'ARED',2029,0),(13,'ARED',2030,143),
(13,'ARED',2031,0),(13,'ARED',2032,0),(13,'ARED',2033,0),(13,'ARED',2034,0);

INSERT INTO ruptl_rencana_gardu_induk (provinsi_id, skenario, tahun, mva) VALUES
(13,'RE_BASE',2025,120),(13,'RE_BASE',2026,30),(13,'RE_BASE',2027,30),
(13,'RE_BASE',2028,150),(13,'RE_BASE',2029,90),(13,'RE_BASE',2030,90),
(13,'RE_BASE',2031,60),(13,'RE_BASE',2032,60),(13,'RE_BASE',2033,60),(13,'RE_BASE',2034,0),
(13,'ARED',2025,120),(13,'ARED',2026,30),(13,'ARED',2027,30),
(13,'ARED',2028,150),(13,'ARED',2029,90),(13,'ARED',2030,90),
(13,'ARED',2031,60),(13,'ARED',2032,60),(13,'ARED',2033,60),(13,'ARED',2034,0);


-- ============================================================
-- A13: KALIMANTAN TENGAH (provinsi_id=12)
-- ============================================================

INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh) VALUES
(12,2015,'RUMAH_TANGGA',701),(12,2016,'RUMAH_TANGGA',730),(12,2017,'RUMAH_TANGGA',745),
(12,2018,'RUMAH_TANGGA',785),(12,2019,'RUMAH_TANGGA',849),(12,2020,'RUMAH_TANGGA',931),
(12,2021,'RUMAH_TANGGA',984),(12,2022,'RUMAH_TANGGA',1010),(12,2023,'RUMAH_TANGGA',1085),
(12,2024,'RUMAH_TANGGA',1182),
(12,2015,'BISNIS',222),(12,2016,'BISNIS',237),(12,2017,'BISNIS',248),
(12,2018,'BISNIS',261),(12,2019,'BISNIS',283),(12,2020,'BISNIS',293),
(12,2021,'BISNIS',293),(12,2022,'BISNIS',323),(12,2023,'BISNIS',370),
(12,2024,'BISNIS',371),
(12,2015,'PUBLIK',96),(12,2016,'PUBLIK',104),(12,2017,'PUBLIK',108),
(12,2018,'PUBLIK',119),(12,2019,'PUBLIK',138),(12,2020,'PUBLIK',140),
(12,2021,'PUBLIK',147),(12,2022,'PUBLIK',167),(12,2023,'PUBLIK',183),
(12,2024,'PUBLIK',221),
(12,2015,'INDUSTRI',29),(12,2016,'INDUSTRI',28),(12,2017,'INDUSTRI',33),
(12,2018,'INDUSTRI',59),(12,2019,'INDUSTRI',90),(12,2020,'INDUSTRI',130),
(12,2021,'INDUSTRI',167),(12,2022,'INDUSTRI',189),(12,2023,'INDUSTRI',192),
(12,2024,'INDUSTRI',236);

INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw, dmp_mw) VALUES
(12,'PLN','PLTD','Barito',33,56.5,31.7,31.7),
(12,'PLN','PLTD','Timpah',44,9.9,7.2,5.8),
(12,'PLN','PLTD','Isolated Tersebar',115,17.2,13.6,13.6),
(12,'PLN','PLTMG','Barito',32,311.0,277.6,269.0),
(12,'PLN','PLTU','Barito',2,120.0,90.0,93.9),
(12,'IPP','PLTU','Barito',2,200.0,200.0,201.3);

INSERT INTO ruptl_proyeksi_kebutuhan (provinsi_id, tahun, pertumbuhan_ekonomi_pct, sales_gwh, produksi_gwh, beban_puncak_mw, pelanggan) VALUES
(12,2025,5.24,2195,2438,399,842593),
(12,2026,5.15,2329,2585,423,857666),
(12,2027,5.05,2464,2735,447,872554),
(12,2028,4.94,2603,2889,471,887230),
(12,2029,4.83,2747,3047,496,901675),
(12,2030,4.82,2898,3214,522,915904),
(12,2031,4.81,3057,3390,550,931706),
(12,2032,4.78,3226,3576,580,945523),
(12,2033,4.78,3406,3775,611,959117),
(12,2034,4.78,3599,3988,645,972469);

INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun, keterangan) VALUES
(12,'RE_BASE','PLTS','Lisdes Kalteng',0.6,2026,'Rencana - PLN'),
(12,'ARED','PLTS','Lisdes Kalteng',0.6,2026,'Rencana - PLN'),
(12,'ARED','PLTS','Kalseltengtimra-5 (PLTS+BESS)',160.0,2027,'Rencana - IPP'),
(12,'ARED','BESS','Kalseltengtimra-5 (PLTS+BESS)',100.0,2027,'Rencana - IPP'),
(12,'RE_BASE','PLTS','Lisdes Kalteng #2',13.8,2027,'Rencana - PLN'),
(12,'ARED','PLTS','Lisdes Kalteng #2',13.8,2027,'Rencana - PLN'),
(12,'RE_BASE','PLTS','Dedieselisasi',0.8,2027,'Pengadaan - IPP'),
(12,'ARED','PLTS','Dedieselisasi',0.8,2027,'Pengadaan - IPP'),
(12,'RE_BASE','PLTU','Kalselteng 3',200.0,2029,'Committed - IPP'),
(12,'ARED','PLTU','Kalselteng 3',200.0,2029,'Committed - IPP'),
(12,'RE_BASE','PLTBg','Kalimantan (Kuota) Tersebar',3.8,2029,'Rencana - IPP'),
(12,'ARED','PLTBg','Kalimantan (Kuota) Tersebar',3.8,2029,'Rencana - IPP'),
(12,'RE_BASE','PLTG','Kalimantan-2',100.0,2029,'Rencana - SH-PLN'),
(12,'RE_BASE','PLTU','Sampit',50.0,2030,'Konstruksi - PLN'),
(12,'RE_BASE','PLTS','Isolated Kalteng',0.2,2030,'Rencana - IPP'),
(12,'ARED','PLTS','Isolated Kalteng',0.2,2030,'Rencana - IPP'),
(12,'ARED','PLTU','Sampit',50.0,2033,'Konstruksi - PLN'),
(12,'RE_BASE','PLTS','MT Hybrid Kalselteng 4',40.0,2032,'Rencana - IPP'),
(12,'ARED','PLTS','MT Hybrid Kalselteng 4',40.0,2032,'Rencana - IPP'),
(12,'RE_BASE','BESS','MT Hybrid Kalselteng 4',25.0,2032,'Rencana - IPP'),
(12,'ARED','BESS','MT Hybrid Kalselteng 4',25.0,2032,'Rencana - IPP'),
(12,'RE_BASE','PLTU','MT Hybrid Kalselteng 4',200.0,2032,'Rencana - IPP'),
(12,'ARED','PLTU','MT Hybrid Kalselteng 4',200.0,2032,'Rencana - IPP'),
(12,'RE_BASE','PLTA','Muara Juloi',340.0,2032,'Rencana - SH-PLN'),
(12,'ARED','PLTA','Muara Juloi',340.0,2032,'Rencana - SH-PLN'),
(12,'RE_BASE','PLTS','Isolated Kalteng (PLTS+BESS)',0.2,2033,'Rencana - IPP'),
(12,'ARED','PLTS','Isolated Kalteng (PLTS+BESS)',0.2,2033,'Rencana - IPP');

INSERT INTO ruptl_rencana_transmisi (provinsi_id, skenario, tahun, kms) VALUES
(12,'RE_BASE',2025,116),(12,'RE_BASE',2026,0),(12,'RE_BASE',2027,27),
(12,'RE_BASE',2028,0),(12,'RE_BASE',2029,11),(12,'RE_BASE',2030,474),
(12,'RE_BASE',2031,0),(12,'RE_BASE',2032,0),(12,'RE_BASE',2033,486),(12,'RE_BASE',2034,0),
(12,'ARED',2025,116),(12,'ARED',2026,0),(12,'ARED',2027,1),
(12,'ARED',2028,0),(12,'ARED',2029,1),(12,'ARED',2030,474),
(12,'ARED',2031,0),(12,'ARED',2032,0),(12,'ARED',2033,486),(12,'ARED',2034,0);

INSERT INTO ruptl_rencana_gardu_induk (provinsi_id, skenario, tahun, mva) VALUES
(12,'RE_BASE',2025,0),(12,'RE_BASE',2026,0),(12,'RE_BASE',2027,60),
(12,'RE_BASE',2028,0),(12,'RE_BASE',2029,60),(12,'RE_BASE',2030,60),
(12,'RE_BASE',2031,180),(12,'RE_BASE',2032,60),(12,'RE_BASE',2033,60),(12,'RE_BASE',2034,120),
(12,'ARED',2025,0),(12,'ARED',2026,0),(12,'ARED',2027,60),
(12,'ARED',2028,0),(12,'ARED',2029,60),(12,'ARED',2030,60),
(12,'ARED',2031,180),(12,'ARED',2032,60),(12,'ARED',2033,60),(12,'ARED',2034,120);

-- ============================================================
-- A14: KALIMANTAN TIMUR (provinsi_id=14)
-- ============================================================

INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh) VALUES
(14,2015,'RUMAH_TANGGA',1708),(14,2016,'RUMAH_TANGGA',1802),(14,2017,'RUMAH_TANGGA',1749),
(14,2018,'RUMAH_TANGGA',1797),(14,2019,'RUMAH_TANGGA',1933),(14,2020,'RUMAH_TANGGA',2076),
(14,2021,'RUMAH_TANGGA',2105),(14,2022,'RUMAH_TANGGA',2161),(14,2023,'RUMAH_TANGGA',2370),
(14,2024,'RUMAH_TANGGA',2457),
(14,2015,'BISNIS',698),(14,2016,'BISNIS',758),(14,2017,'BISNIS',769),
(14,2018,'BISNIS',850),(14,2019,'BISNIS',924),(14,2020,'BISNIS',904),
(14,2021,'BISNIS',920),(14,2022,'BISNIS',983),(14,2023,'BISNIS',1111),
(14,2024,'BISNIS',1126),
(14,2015,'PUBLIK',261),(14,2016,'PUBLIK',282),(14,2017,'PUBLIK',283),
(14,2018,'PUBLIK',304),(14,2019,'PUBLIK',333),(14,2020,'PUBLIK',318),
(14,2021,'PUBLIK',324),(14,2022,'PUBLIK',362),(14,2023,'PUBLIK',404),
(14,2024,'PUBLIK',409),
(14,2015,'INDUSTRI',166),(14,2016,'INDUSTRI',170),(14,2017,'INDUSTRI',194),
(14,2018,'INDUSTRI',221),(14,2019,'INDUSTRI',253),(14,2020,'INDUSTRI',300),
(14,2021,'INDUSTRI',406),(14,2022,'INDUSTRI',402),(14,2023,'INDUSTRI',540),
(14,2024,'INDUSTRI',1577);

INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw, dmp_mw) VALUES
(14,'PLN','PLTD','Mahakam',17,75.6,49.5,49.5),
(14,'PLN','PLTD','Berau',11,14.4,10.3,10.3),
(14,'PLN','PLTD','Melak',16,21.3,16.5,16.5),
(14,'PLN','PLTD','Sangkulirang',9,4.2,2.7,2.7),
(14,'PLN','PLTD','Muara Bengkal',9,4.5,3.2,3.2),
(14,'PLN','PLTD','Muara Wahau',13,11.5,7.8,7.8),
(14,'PLN','PLTD','Talisayan',7,6.1,4.3,4.3),
(14,'PLN','PLTG','Mahakam',4,200.0,173.0,173.0),
(14,'PLN','PLTGU','Mahakam',3,60.0,45.6,45.6),
(14,'PLN','PLTMG','Mahakam',6,53.0,47.4,47.4),
(14,'PLN','PLTU','Mahakam',2,220.0,180.0,188.5),
(14,'PLN','PLTU','Berau',2,19.0,14.0,12.0),
(14,'IPP','PLTGU','Mahakam',3,117.0,117.0,119.5),
(14,'IPP','PLTU','Mahakam',9,550.0,550.0,501.1);

INSERT INTO ruptl_proyeksi_kebutuhan (provinsi_id, tahun, pertumbuhan_ekonomi_pct, sales_gwh, produksi_gwh, beban_puncak_mw, pelanggan) VALUES
(14,2025,1.64,6362,6856,1034,1368542),
(14,2026,1.61,7141,7685,1160,1441789),
(14,2027,1.58,8383,9015,1360,1512434),
(14,2028,1.54,8552,9188,1387,1580117),
(14,2029,1.50,9637,10344,1561,1644530),
(14,2030,1.49,10252,10993,1660,1705141),
(14,2031,1.46,10658,11418,1723,1761284),
(14,2032,1.45,12295,13158,1986,1803094),
(14,2033,1.44,12805,13661,2064,1839479),
(14,2034,1.43,13118,13965,2110,1870226);


-- ============================================================
-- A14 KALIMANTAN TIMUR (id=14) - Rencana Pembangkit
-- ============================================================
INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun, keterangan) VALUES
-- Items with same COD both skenarios
(14,'RE_BASE','PLTS','IKN',50.0,2025,'Konstruksi - IPP'),
(14,'ARED','PLTS','IKN',50.0,2025,'Konstruksi - IPP'),
(14,'RE_BASE','PLTG','Kaltim Peaker 2',100.0,2026,'Rencana - SH-PLN'),
(14,'ARED','PLTG','Kaltim Peaker 2',100.0,2026,'Rencana - SH-PLN'),
(14,'RE_BASE','PLTGU','Kaltim-1',250.0,2026,'Rencana - SH-PLN'),
(14,'ARED','PLTGU','Kaltim-1',250.0,2026,'Rencana - SH-PLN'),
(14,'RE_BASE','PLTGU','Kaltara/Kaltimra',100.0,2027,'Rencana - SH-PLN'),
(14,'ARED','PLTGU','Kaltara/Kaltimra',100.0,2027,'Rencana - SH-PLN'),
(14,'RE_BASE','PLTGU','Kaltim Add on Blok 2',80.0,2027,'Rencana - SH-PLN'),
(14,'ARED','PLTGU','Kaltim Add on Blok 2',80.0,2027,'Rencana - SH-PLN'),
(14,'RE_BASE','PLTS','Kalseltengtimra-1 (PLTS+BESS)',80.0,2027,'Rencana - SH-PLN'),
(14,'ARED','PLTS','Kalseltengtimra-1 (PLTS+BESS)',80.0,2027,'Rencana - SH-PLN'),
(14,'RE_BASE','BESS','Kalseltengtimra-1 (PLTS+BESS)',50.0,2027,'Rencana - SH-PLN'),
(14,'ARED','BESS','Kalseltengtimra-1 (PLTS+BESS)',50.0,2027,'Rencana - SH-PLN'),
-- ARED only
(14,'ARED','PLTS','Kalseltengtimra-2 (PLTS+BESS)',240.0,2028,'Rencana - IPP'),
(14,'ARED','BESS','Kalseltengtimra-2 (PLTS+BESS)',150.0,2028,'Rencana - IPP'),
-- Both skenarios
(14,'RE_BASE','PLTS','Kalseltengtimra (Kuota) Tersebar',15.0,2029,'Rencana - IPP'),
(14,'ARED','PLTS','Kalseltengtimra (Kuota) Tersebar',15.0,2029,'Rencana - IPP'),
(14,'RE_BASE','PLTM','Kalseltengtimra (Kuota) Tersebar',0.15,2029,'Rencana - IPP'),
(14,'ARED','PLTM','Kalseltengtimra (Kuota) Tersebar',0.15,2029,'Rencana - IPP'),
-- ARED only
(14,'ARED','PLTGU','Add-On Kaltara/Kaltimra',50.0,2030,'Rencana - SH-PLN'),
-- Both skenarios
(14,'RE_BASE','PLTBm','Kalimantan (Kuota) Tersebar',10.0,2030,'Rencana - IPP'),
(14,'ARED','PLTBm','Kalimantan (Kuota) Tersebar',10.0,2030,'Rencana - IPP'),
(14,'RE_BASE','PLTS','Kalseltengtimra Tersebar',30.0,2030,'Rencana - IPP'),
(14,'ARED','PLTS','Kalseltengtimra Tersebar',30.0,2030,'Rencana - IPP'),
-- ARED only
(14,'ARED','PLTS','Kalseltengtimra-4 (PLTS+BESS)',40.0,2030,'Rencana - IPP'),
(14,'ARED','BESS','Kalseltengtimra-4 (PLTS+BESS)',25.0,2030,'Rencana - IPP'),
-- Both skenarios
(14,'RE_BASE','PLTA','Kelai',45.0,2032,'Rencana - SH-PLN'),
(14,'ARED','PLTA','Kelai',45.0,2032,'Rencana - SH-PLN'),
(14,'RE_BASE','PLTA','Tabang 1',101.0,2032,'Rencana - SH-PLN'),
(14,'ARED','PLTA','Tabang 1',101.0,2032,'Rencana - SH-PLN'),
-- Different COD: PLTU Tanah Grogot RE_BASE=2030, ARED=2033
(14,'RE_BASE','PLTU','Tanah Grogot',14.0,2030,'PPA - IPP'),
(14,'ARED','PLTU','Tanah Grogot',14.0,2033,'PPA - IPP'),
-- Different COD: PLTA Kelai 2 RE_BASE=2032, ARED=2033
(14,'RE_BASE','PLTA','Kelai 2',65.0,2032,'Rencana - SH-PLN'),
(14,'ARED','PLTA','Kelai 2',65.0,2033,'Rencana - SH-PLN'),
-- Both skenarios
(14,'RE_BASE','PLTA','Lambakan',15.0,2033,'Rencana - SH-PLN'),
(14,'ARED','PLTA','Lambakan',15.0,2033,'Rencana - SH-PLN'),
(14,'RE_BASE','PLTS','Kalseltengtimra (Kuota) Tersebar',50.0,2033,'Rencana - IPP'),
(14,'ARED','PLTS','Kalseltengtimra (Kuota) Tersebar',50.0,2033,'Rencana - IPP'),
-- ARED only
(14,'ARED','PLTN','PLTN Kalimantan (Kuota) Tersebar',250.0,2033,'Rencana - IPP'),
-- Both skenarios
(14,'RE_BASE','PLTA','Kalseltengtimra (Kuota) Tersebar',125.0,2034,'Rencana - IPP'),
(14,'ARED','PLTA','Kalseltengtimra (Kuota) Tersebar',125.0,2034,'Rencana - IPP'),
-- Isolated system PLN
(14,'RE_BASE','PLTS','Lisdes Kaltim',1.3,2025,'Rencana - PLN'),
(14,'ARED','PLTS','Lisdes Kaltim',1.3,2025,'Rencana - PLN'),
(14,'RE_BASE','PLTS','Lisdes Kaltim',10.5,2026,'Rencana - PLN'),
(14,'ARED','PLTS','Lisdes Kaltim',10.5,2026,'Rencana - PLN'),
(14,'RE_BASE','PLTS','Lisdes Kaltim',12.1,2027,'Rencana - PLN'),
(14,'ARED','PLTS','Lisdes Kaltim',12.1,2027,'Rencana - PLN'),
(14,'RE_BASE','PLTS','Dedieselisasi',0.9,2027,'Pengadaan - IPP'),
(14,'ARED','PLTS','Dedieselisasi',0.9,2027,'Pengadaan - IPP'),
(14,'RE_BASE','PLTS','Isolated Kaltim',7.7,2030,'Rencana - IPP'),
(14,'ARED','PLTS','Isolated Kaltim',7.7,2030,'Rencana - IPP'),
(14,'RE_BASE','PLTS+BESS','Isolated Kaltim',9.5,2033,'Rencana - IPP'),
(14,'ARED','PLTS+BESS','Isolated Kaltim',9.5,2033,'Rencana - IPP');

-- ============================================================
-- A14 KALIMANTAN TIMUR (id=14) - Rencana Transmisi
-- ============================================================
-- RE Base differs from ARED at 2032 and 2033
INSERT INTO ruptl_rencana_transmisi (provinsi_id, skenario, tahun, kms) VALUES
(14,'RE_BASE',2025,464),
(14,'RE_BASE',2026,470),
(14,'RE_BASE',2027,935.6),
(14,'RE_BASE',2028,234.6),
(14,'RE_BASE',2030,125),
(14,'RE_BASE',2031,809),
(14,'RE_BASE',2032,1311),
(14,'RE_BASE',2034,4),
(14,'ARED',2025,464),
(14,'ARED',2026,470),
(14,'ARED',2027,935.6),
(14,'ARED',2028,234.6),
(14,'ARED',2030,125),
(14,'ARED',2031,809),
(14,'ARED',2032,1269),
(14,'ARED',2033,42),
(14,'ARED',2034,4);

-- ============================================================
-- A14 KALIMANTAN TIMUR (id=14) - Rencana Gardu Induk
-- ============================================================
-- RE Base and ARED identical (both Total=5300 MVA, same per-year breakdown)
INSERT INTO ruptl_rencana_gardu_induk (provinsi_id, skenario, tahun, mva) VALUES
(14,'RE_BASE',2025,150),
(14,'RE_BASE',2026,60),
(14,'RE_BASE',2027,180),
(14,'RE_BASE',2028,360),
(14,'RE_BASE',2029,300),
(14,'RE_BASE',2030,360),
(14,'RE_BASE',2031,3590),
(14,'RE_BASE',2032,60),
(14,'RE_BASE',2033,120),
(14,'RE_BASE',2034,120),
(14,'ARED',2025,150),
(14,'ARED',2026,60),
(14,'ARED',2027,180),
(14,'ARED',2028,360),
(14,'ARED',2029,300),
(14,'ARED',2030,360),
(14,'ARED',2031,3590),
(14,'ARED',2032,60),
(14,'ARED',2033,120),
(14,'ARED',2034,120);

-- ============================================================
-- A15 KALIMANTAN UTARA (id=15) - Penjualan Historis
-- ============================================================
INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh) VALUES
(15,2015,'RUMAH_TANGGA',218),(15,2016,'RUMAH_TANGGA',236),(15,2017,'RUMAH_TANGGA',238),
(15,2018,'RUMAH_TANGGA',256),(15,2019,'RUMAH_TANGGA',281),(15,2020,'RUMAH_TANGGA',304),
(15,2021,'RUMAH_TANGGA',316),(15,2022,'RUMAH_TANGGA',325),(15,2023,'RUMAH_TANGGA',353),
(15,2024,'RUMAH_TANGGA',362),
(15,2015,'BISNIS',77),(15,2016,'BISNIS',82),(15,2017,'BISNIS',82),
(15,2018,'BISNIS',89),(15,2019,'BISNIS',96),(15,2020,'BISNIS',95),
(15,2021,'BISNIS',100),(15,2022,'BISNIS',109),(15,2023,'BISNIS',122),
(15,2024,'BISNIS',127),
(15,2015,'PUBLIK',53),(15,2016,'PUBLIK',58),(15,2017,'PUBLIK',61),
(15,2018,'PUBLIK',66),(15,2019,'PUBLIK',73),(15,2020,'PUBLIK',75),
(15,2021,'PUBLIK',79),(15,2022,'PUBLIK',85),(15,2023,'PUBLIK',90),
(15,2024,'PUBLIK',92),
(15,2015,'INDUSTRI',34),(15,2016,'INDUSTRI',37),(15,2017,'INDUSTRI',43),
(15,2018,'INDUSTRI',53),(15,2019,'INDUSTRI',60),(15,2020,'INDUSTRI',51),
(15,2021,'INDUSTRI',53),(15,2022,'INDUSTRI',53),(15,2023,'INDUSTRI',77),
(15,2024,'INDUSTRI',74);

-- ============================================================
-- A15 KALIMANTAN UTARA (id=15) - Pembangkit Eksisting
-- ============================================================
-- Skip Sewa rows (not in schema)
INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw, dmp_mw) VALUES
(15,'PLN','PLTD','Tanjung Selor',2,1.9,1.0,1.0),
(15,'PLN','PLTD','Nunukan',19,23.7,14.4,14.4),
(15,'PLN','PLTD','Malinau',10,13.3,10.0,8.1),
(15,'PLN','PLTD','Tideng Pale',7,6.2,3.5,3.1),
(15,'PLN','PLTMG','Tanjung Selor',2,17.8,15.0,15.0),
(15,'PLN','PLTMG','Tarakan',2,12.4,8.0,9.0),
(15,'PLN','PLTU','Malinau',2,7.0,6.0,4.0),
(15,'PLN','PLTS','Nunukan',1,0.3,0.05,0.05);


-- ============================================================
-- A15 KALIMANTAN UTARA (id=15) - Proyeksi Kebutuhan
-- ============================================================
INSERT INTO ruptl_proyeksi_kebutuhan (provinsi_id, tahun, pertumbuhan_ekonomi_pct, sales_gwh, produksi_gwh, beban_puncak_mw, pelanggan) VALUES
(15,2025,4.60,691,749,114,212184),
(15,2026,4.50,729,789,120,216811),
(15,2027,4.50,769,831,126,221396),
(15,2028,4.40,810,875,133,225949),
(15,2029,4.30,853,921,140,230483),
(15,2030,4.30,899,970,147,235012),
(15,2031,4.30,948,1021,154,239544),
(15,2032,4.30,1000,1076,162,244084),
(15,2033,4.30,1055,1124,169,248634),
(15,2034,4.30,1115,1186,178,253199);

-- ============================================================
-- A15 KALIMANTAN UTARA (id=15) - Rencana Pembangkit
-- ============================================================
INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun, keterangan) VALUES
-- Both skenarios
(15,'RE_BASE','PLTMG','Tarakan',50.0,2027,'Rencana - SH-PLN'),
(15,'ARED','PLTMG','Tarakan',50.0,2027,'Rencana - SH-PLN'),
(15,'RE_BASE','PLTGU','Kaltara/Kaltimra',100.0,2027,'Rencana - SH-PLN'),
(15,'ARED','PLTGU','Kaltara/Kaltimra',100.0,2027,'Rencana - SH-PLN'),
-- ARED only
(15,'ARED','PLTS','Kalseltengtimra-3 (PLTS+BESS)',240.0,2029,'Rencana - IPP'),
(15,'ARED','BESS','Kalseltengtimra-3 (PLTS+BESS)',150.0,2029,'Rencana - IPP'),
(15,'ARED','PLTGU','Add-On Kaltara/Kaltimra',50.0,2030,'Rencana - SH-PLN'),
-- Different COD: PLTU Tanjung Selor RE_BASE=2030, ARED=2033
(15,'RE_BASE','PLTU','Tanjung Selor',14.0,2030,'Konstruksi - PLN'),
(15,'ARED','PLTU','Tanjung Selor',14.0,2033,'Konstruksi - PLN'),
-- Both skenarios
(15,'RE_BASE','PLTA','Kalseltengtimra (Kuota) Tersebar',300.0,2031,'Rencana - IPP'),
(15,'ARED','PLTA','Kalseltengtimra (Kuota) Tersebar',300.0,2031,'Rencana - IPP'),
(15,'RE_BASE','PLTA','Kalseltengtimra (Kuota) Tersebar',200.0,2031,'Rencana - IPP'),
(15,'ARED','PLTA','Kalseltengtimra (Kuota) Tersebar',200.0,2031,'Rencana - IPP'),
(15,'RE_BASE','PLTA','Kalseltengtimra (Kuota) Tersebar',200.0,2032,'Rencana - IPP'),
(15,'ARED','PLTA','Kalseltengtimra (Kuota) Tersebar',200.0,2032,'Rencana - IPP'),
-- Different COD: PLTA 200MW RE_BASE=2032, ARED=2034
(15,'RE_BASE','PLTA','Kalseltengtimra (Kuota) Tersebar',200.0,2032,'Rencana - IPP'),
(15,'ARED','PLTA','Kalseltengtimra (Kuota) Tersebar',200.0,2034,'Rencana - IPP'),
-- Both skenarios
(15,'RE_BASE','PLTS','Kalseltengtimra (Kuota) Tersebar',50.0,2034,'Rencana - IPP'),
(15,'ARED','PLTS','Kalseltengtimra (Kuota) Tersebar',50.0,2034,'Rencana - IPP'),
-- Isolated system
(15,'RE_BASE','PLTMG','Nunukan 2',10.0,2025,'Konstruksi - PLN'),
(15,'ARED','PLTMG','Nunukan 2',10.0,2025,'Konstruksi - PLN'),
(15,'RE_BASE','PLTS','Lisdes Kaltara',2.0,2025,'Rencana - PLN'),
(15,'ARED','PLTS','Lisdes Kaltara',2.0,2025,'Rencana - PLN'),
(15,'RE_BASE','PLTS','Lisdes Kaltara',1.5,2026,'Rencana - PLN'),
(15,'ARED','PLTS','Lisdes Kaltara',1.5,2026,'Rencana - PLN'),
(15,'RE_BASE','PLTS','Lisdes Kaltara',0.9,2027,'Rencana - PLN'),
(15,'ARED','PLTS','Lisdes Kaltara',0.9,2027,'Rencana - PLN'),
(15,'RE_BASE','PLTM','Paramayo',0.76,2027,'Rencana - PLN'),
(15,'ARED','PLTM','Paramayo',0.76,2027,'Rencana - PLN'),
(15,'RE_BASE','PLTS','Isolated Kaltara',5.1,2030,'Rencana - IPP'),
(15,'ARED','PLTS','Isolated Kaltara',5.1,2030,'Rencana - IPP'),
(15,'RE_BASE','PLTS+BESS','Isolated Kaltara',6.8,2033,'Rencana - IPP'),
(15,'ARED','PLTS+BESS','Isolated Kaltara',6.8,2033,'Rencana - IPP');

-- ============================================================
-- A15 KALIMANTAN UTARA (id=15) - Rencana Transmisi
-- ============================================================
-- RE Base and ARED identical (both Total=1847 kms, same per-year breakdown)
INSERT INTO ruptl_rencana_transmisi (provinsi_id, skenario, tahun, kms) VALUES
(15,'RE_BASE',2025,226),
(15,'RE_BASE',2026,160.4),
(15,'RE_BASE',2027,2),
(15,'RE_BASE',2028,362.8),
(15,'RE_BASE',2031,840),
(15,'RE_BASE',2032,2),
(15,'RE_BASE',2033,164),
(15,'RE_BASE',2034,89.8),
(15,'ARED',2025,226),
(15,'ARED',2026,160.4),
(15,'ARED',2027,2),
(15,'ARED',2028,362.8),
(15,'ARED',2031,840),
(15,'ARED',2032,2),
(15,'ARED',2033,164),
(15,'ARED',2034,89.8);

-- ============================================================
-- A15 KALIMANTAN UTARA (id=15) - Rencana Gardu Induk
-- ============================================================
-- RE Base and ARED identical (both Total=770 MVA)
INSERT INTO ruptl_rencana_gardu_induk (provinsi_id, skenario, tahun, mva) VALUES
(15,'RE_BASE',2026,150),
(15,'RE_BASE',2028,60),
(15,'RE_BASE',2031,500),
(15,'RE_BASE',2033,60),
(15,'ARED',2026,150),
(15,'ARED',2028,60),
(15,'ARED',2031,500),
(15,'ARED',2033,60);

-- ============================================================
-- B1 DKI JAKARTA (id=16) - Proyeksi Kebutuhan
-- ============================================================
INSERT INTO ruptl_proyeksi_kebutuhan (provinsi_id, tahun, pertumbuhan_ekonomi_pct, sales_gwh, produksi_gwh, beban_puncak_mw, pelanggan) VALUES
(16,2025,2.9,39055,41666,5871,5374288),
(16,2026,3.0,40212,42845,6037,5428374),
(16,2027,4.0,41827,44533,6274,5482669),
(16,2028,3.8,43436,46203,6508,5536365),
(16,2029,5.5,45816,48692,6858,5589601),
(16,2030,2.4,46901,50335,7089,5643203),
(16,2031,2.7,48161,52201,7350,5698994),
(16,2032,2.6,49412,54094,7616,5758334),
(16,2033,2.7,50762,56134,7902,5821787),
(16,2034,2.7,52124,58114,8180,5889834);

-- ============================================================
-- B1 DKI JAKARTA (id=16) - Rencana Pembangkit
-- ============================================================
-- RE Base and ARED identical (both 185 MW total)
INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun, keterangan) VALUES
(16,'RE_BASE','PLTSa','Sunter',35.0,2028,'Pendanaan - IPP'),
(16,'ARED','PLTSa','Sunter',35.0,2028,'Pendanaan - IPP'),
(16,'RE_BASE','PLTSa','Jawa-Bali (Kuota) Tersebar',150.0,2029,'Rencana - IPP'),
(16,'ARED','PLTSa','Jawa-Bali (Kuota) Tersebar',150.0,2029,'Rencana - IPP');


-- ============================================================
-- B1 DKI JAKARTA (id=16) - Rencana Transmisi
-- ============================================================
-- RE Base and ARED identical (Total=426 kms)
INSERT INTO ruptl_rencana_transmisi (provinsi_id, skenario, tahun, kms) VALUES
(16,'RE_BASE',2025,158),(16,'RE_BASE',2026,74),(16,'RE_BASE',2027,136),
(16,'RE_BASE',2028,26),(16,'RE_BASE',2032,18),(16,'RE_BASE',2033,10),(16,'RE_BASE',2034,3),
(16,'ARED',2025,158),(16,'ARED',2026,74),(16,'ARED',2027,136),
(16,'ARED',2028,26),(16,'ARED',2032,18),(16,'ARED',2033,10),(16,'ARED',2034,3);

-- ============================================================
-- B1 DKI JAKARTA (id=16) - Rencana Gardu Induk
-- ============================================================
-- RE Base and ARED identical (Total=5,980 MVA)
INSERT INTO ruptl_rencana_gardu_induk (provinsi_id, skenario, tahun, mva) VALUES
(16,'RE_BASE',2025,180),(16,'RE_BASE',2026,240),(16,'RE_BASE',2027,2240),
(16,'RE_BASE',2028,2300),(16,'RE_BASE',2029,60),(16,'RE_BASE',2031,60),
(16,'RE_BASE',2032,180),(16,'RE_BASE',2033,420),(16,'RE_BASE',2034,360),
(16,'ARED',2025,180),(16,'ARED',2026,240),(16,'ARED',2027,2240),
(16,'ARED',2028,2300),(16,'ARED',2029,60),(16,'ARED',2031,60),
(16,'ARED',2032,180),(16,'ARED',2033,420),(16,'ARED',2034,360);

-- ============================================================
-- B2 BANTEN (id=17) - Penjualan Historis
-- ============================================================
INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh) VALUES
(17,2015,'RUMAH_TANGGA',4278),(17,2016,'RUMAH_TANGGA',4543),(17,2017,'RUMAH_TANGGA',4600),
(17,2018,'RUMAH_TANGGA',4825),(17,2019,'RUMAH_TANGGA',5232),(17,2020,'RUMAH_TANGGA',5871),
(17,2021,'RUMAH_TANGGA',6014),(17,2022,'RUMAH_TANGGA',6050),(17,2023,'RUMAH_TANGGA',6475),
(17,2024,'RUMAH_TANGGA',6877),
(17,2015,'BISNIS',2154),(17,2016,'BISNIS',2526),(17,2017,'BISNIS',2931),
(17,2018,'BISNIS',2990),(17,2019,'BISNIS',3164),(17,2020,'BISNIS',2898),
(17,2021,'BISNIS',3009),(17,2022,'BISNIS',3408),(17,2023,'BISNIS',3965),
(17,2024,'BISNIS',4210),
(17,2015,'PUBLIK',455),(17,2016,'PUBLIK',488),(17,2017,'PUBLIK',528),
(17,2018,'PUBLIK',544),(17,2019,'PUBLIK',587),(17,2020,'PUBLIK',557),
(17,2021,'PUBLIK',574),(17,2022,'PUBLIK',643),(17,2023,'PUBLIK',717),
(17,2024,'PUBLIK',762),
(17,2015,'INDUSTRI',11645),(17,2016,'INDUSTRI',12811),(17,2017,'INDUSTRI',13623),
(17,2018,'INDUSTRI',14803),(17,2019,'INDUSTRI',14601),(17,2020,'INDUSTRI',13027),
(17,2021,'INDUSTRI',14233),(17,2022,'INDUSTRI',16605),(17,2023,'INDUSTRI',15814),
(17,2024,'INDUSTRI',16917);

-- ============================================================
-- B2 BANTEN (id=17) - Pembangkit Eksisting
-- ============================================================
INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw, dmp_mw) VALUES
(17,'PLN','PLTD','Jawa Bali',7,1.2,1.2,1.2),
(17,'PLN','PLTGU','Jawa Bali',1,739,660,660),
(17,'PLN','PLTU','Jawa Bali',14,5885,5467,4890),
(17,'IPP','PLTM','Jawa Bali',4,20.6,20.6,20.3),
(17,'IPP','PLTU','Jawa Bali',3,2607,2607,2578);

-- ============================================================
-- B2 BANTEN (id=17) - Proyeksi Kebutuhan
-- ============================================================
INSERT INTO ruptl_proyeksi_kebutuhan (provinsi_id, tahun, pertumbuhan_ekonomi_pct, sales_gwh, produksi_gwh, beban_puncak_mw, pelanggan) VALUES
(17,2025,3.3,29715,31122,4441,4115849),
(17,2026,2.3,30406,31835,4543,4170631),
(17,2027,3.3,31400,32863,4689,4224316),
(17,2028,3.2,32390,33895,4837,4276872),
(17,2029,3.1,33383,34930,4984,4328266),
(17,2030,3.1,34418,36010,5138,4378628),
(17,2031,3.2,35517,37156,5302,4428180),
(17,2032,3.2,36647,38334,5470,4477048),
(17,2033,3.2,37828,39565,5646,4525288),
(17,2034,3.4,39113,40905,5837,4572970);

-- ============================================================
-- B2 BANTEN (id=17) - Rencana Pembangkit
-- ============================================================
INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun, keterangan) VALUES
-- Both skenarios same COD
(17,'RE_BASE','PLTU','Jawa-9',1000.0,2025,'Konstruksi - IPP'),
(17,'ARED','PLTU','Jawa-9',1000.0,2025,'Konstruksi - IPP'),
(17,'RE_BASE','PLTU','Jawa-10',1000.0,2025,'Konstruksi - IPP'),
(17,'ARED','PLTU','Jawa-10',1000.0,2025,'Konstruksi - IPP'),
(17,'RE_BASE','PLTM','Cikotok',4.2,2026,'Konstruksi - IPP'),
(17,'ARED','PLTM','Cikotok',4.2,2026,'Konstruksi - IPP'),
(17,'RE_BASE','PLTS','Banten (Kuota) II',50.0,2026,'Rencana - IPP'),
(17,'ARED','PLTS','Banten (Kuota) II',50.0,2026,'Rencana - IPP'),
(17,'RE_BASE','PLTM','Cikamunding',6.0,2027,'Pengadaan - IPP'),
(17,'ARED','PLTM','Cikamunding',6.0,2027,'Pengadaan - IPP'),
(17,'RE_BASE','PLTM','Nagajaya',6.0,2027,'Pengadaan - IPP'),
(17,'ARED','PLTM','Nagajaya',6.0,2027,'Pengadaan - IPP'),
(17,'RE_BASE','PLTM','Bulakan',3.0,2027,'Pengadaan - IPP'),
(17,'ARED','PLTM','Bulakan',3.0,2027,'Pengadaan - IPP'),
(17,'RE_BASE','PLTM','Jawa-Bali (Kuota) Tersebar',4.4,2027,'Rencana - IPP'),
(17,'ARED','PLTM','Jawa-Bali (Kuota) Tersebar',4.4,2027,'Rencana - IPP'),
(17,'RE_BASE','PLTS','Lisdes',0.2,2027,'Rencana - PLN'),
(17,'ARED','PLTS','Lisdes',0.2,2027,'Rencana - PLN'),
(17,'RE_BASE','BESS','Isolated Banten',0.2,2027,'Rencana - IPP'),
(17,'ARED','BESS','Isolated Banten',0.2,2027,'Rencana - IPP'),
(17,'RE_BASE','PLTS','Isolated Banten',0.7,2027,'Rencana - IPP'),
(17,'ARED','PLTS','Isolated Banten',0.7,2027,'Rencana - IPP'),
(17,'RE_BASE','PLTSa','Banten (Kuota) Tersebar 1',40.0,2028,'Rencana - IPP'),
(17,'ARED','PLTSa','Banten (Kuota) Tersebar 1',40.0,2028,'Rencana - IPP'),
(17,'RE_BASE','PLTS','Banten (Kuota) IVA',50.0,2028,'Rencana - IPP'),
(17,'ARED','PLTS','Banten (Kuota) IVA',50.0,2028,'Rencana - IPP'),
(17,'RE_BASE','PLTS','Banten (Kuota) VI',40.0,2028,'Rencana - IPP'),
(17,'ARED','PLTS','Banten (Kuota) VI',40.0,2028,'Rencana - IPP'),
(17,'RE_BASE','PLTM','Cibareno 1',5.0,2028,'Rencana - IPP'),
(17,'ARED','PLTM','Cibareno 1',5.0,2028,'Rencana - IPP'),
(17,'RE_BASE','PLTM','Jawa-Bali (Kuota) Tersebar',6.0,2028,'Rencana - IPP'),
(17,'ARED','PLTM','Jawa-Bali (Kuota) Tersebar',6.0,2028,'Rencana - IPP'),
(17,'RE_BASE','PLTM','Karian',1.8,2028,'Rencana - IPP'),
(17,'ARED','PLTM','Karian',1.8,2028,'Rencana - IPP'),
(17,'RE_BASE','PLTB','Banten',100.0,2028,'Rencana - PLN'),
(17,'ARED','PLTB','Banten',100.0,2028,'Rencana - PLN'),
(17,'RE_BASE','PLTB','Banten',100.0,2029,'Rencana - PLN'),
(17,'ARED','PLTB','Banten',100.0,2029,'Rencana - PLN'),
-- Different COD: PLTS+BESS Banten (Kuota) III RE_BASE=2030, ARED=2027
(17,'RE_BASE','PLTS+BESS','Banten (Kuota) III',80.0,2030,'Rencana - IPP'),
(17,'ARED','PLTS+BESS','Banten (Kuota) III',80.0,2027,'Rencana - IPP'),
-- Different COD: PLTS Banten (Kuota) IVC RE_BASE=2030, ARED=2029
(17,'RE_BASE','PLTS','Banten (Kuota) IVC',50.0,2030,'Rencana - IPP'),
(17,'ARED','PLTS','Banten (Kuota) IVC',50.0,2029,'Rencana - IPP'),
-- Both skenarios same COD 2030
(17,'RE_BASE','PLTSa','Banten (Kuota) Tersebar 2',40.0,2030,'Rencana - IPP'),
(17,'ARED','PLTSa','Banten (Kuota) Tersebar 2',40.0,2030,'Rencana - IPP'),
(17,'RE_BASE','PLTS','Banten (Kuota) IVB',50.0,2030,'Rencana - IPP'),
(17,'ARED','PLTS','Banten (Kuota) IVB',50.0,2030,'Rencana - IPP'),
(17,'RE_BASE','PLTS','Banten (Kuota) VII',50.0,2030,'Rencana - IPP'),
(17,'ARED','PLTS','Banten (Kuota) VII',50.0,2030,'Rencana - IPP'),
(17,'RE_BASE','PLTP','Rawadano (FTP2)',30.0,2030,'Eksplorasi - IPP'),
(17,'ARED','PLTP','Rawadano (FTP2)',30.0,2030,'Eksplorasi - IPP'),
(17,'RE_BASE','PLTGU','Jawa-5',1000.0,2030,'Rencana - IPP'),
(17,'ARED','PLTGU','Jawa-5',1000.0,2030,'Rencana - IPP'),
-- RE Base only
(17,'RE_BASE','PLTGU','Jawa-Bali-7',500.0,2030,'Rencana - SH-PLN'),
-- Both skenarios
(17,'RE_BASE','PLTP','Rawadano (FTP2)',80.0,2032,'Eksplorasi - IPP'),
(17,'ARED','PLTP','Rawadano (FTP2)',80.0,2032,'Eksplorasi - IPP'),
(17,'RE_BASE','PLTP','Jawa-Bali (Kuota) Tersebar',35.0,2033,'Rencana - IPP'),
(17,'ARED','PLTP','Jawa-Bali (Kuota) Tersebar',35.0,2033,'Rencana - IPP'),
-- Different COD: PLTS Banten (Kuota) V RE_BASE=2034, ARED=2031
(17,'RE_BASE','PLTS','Banten (Kuota) V',45.0,2034,'Rencana - IPP'),
(17,'ARED','PLTS','Banten (Kuota) V',45.0,2031,'Rencana - IPP'),
-- Both skenarios
(17,'RE_BASE','PLTB','Jawa-Bali (Kuota) Tersebar III',300.0,2034,'Rencana - IPP'),
(17,'ARED','PLTB','Jawa-Bali (Kuota) Tersebar III',300.0,2034,'Rencana - IPP'),
(17,'RE_BASE','BESS','Jawa-Bali (Kuota) Tersebar IVA',250.0,2034,'Rencana - SH-PLN'),
(17,'ARED','BESS','Jawa-Bali (Kuota) Tersebar IVA',250.0,2034,'Rencana - SH-PLN'),
-- ARED only
(17,'ARED','BESS','BESS Smoothing Tersebar',100.0,2028,'Rencana - PLN'),
(17,'ARED','BESS','BESS Smoothing Tersebar',100.0,2032,'Rencana - PLN'),
(17,'ARED','PLTB','Jawa-Bali (Kuota) Tersebar II',300.0,2030,'Rencana - IPP'),
(17,'ARED','BESS','Jawa-Bali (Kuota) Tersebar IIIA',300.0,2032,'Rencana - SH-PLN'),
(17,'ARED','PLTS','Banten (Kuota) Tersebar IX',110.0,2033,'Rencana - IPP'),
(17,'ARED','PLTS','Banten (Kuota) Tersebar X',150.0,2034,'Rencana - IPP'),
(17,'ARED','PLTB','Jawa-Bali (Kuota) Tersebar IV',600.0,2034,'Rencana - IPP');

-- ============================================================
-- B2 BANTEN (id=17) - Rencana Transmisi
-- ============================================================
-- RE Base and ARED identical (Total=369 kms)
INSERT INTO ruptl_rencana_transmisi (provinsi_id, skenario, tahun, kms) VALUES
(17,'RE_BASE',2025,222),(17,'RE_BASE',2026,77),(17,'RE_BASE',2027,2),
(17,'RE_BASE',2028,50),(17,'RE_BASE',2030,8),(17,'RE_BASE',2033,10),
(17,'ARED',2025,222),(17,'ARED',2026,77),(17,'ARED',2027,2),
(17,'ARED',2028,50),(17,'ARED',2030,8),(17,'ARED',2033,10);

-- ============================================================
-- B2 BANTEN (id=17) - Rencana Gardu Induk
-- ============================================================
-- RE Base and ARED identical (Total=5,760 MVA)
INSERT INTO ruptl_rencana_gardu_induk (provinsi_id, skenario, tahun, mva) VALUES
(17,'RE_BASE',2025,2100),(17,'RE_BASE',2026,2180),(17,'RE_BASE',2027,180),
(17,'RE_BASE',2028,120),(17,'RE_BASE',2030,1060),(17,'RE_BASE',2033,120),
(17,'ARED',2025,2100),(17,'ARED',2026,2180),(17,'ARED',2027,180),
(17,'ARED',2028,120),(17,'ARED',2030,1060),(17,'ARED',2033,120);


-- ============================================================
-- B3 JAWA BARAT (id=18) — Semua 6 Tabel
-- Beban puncak 2024: 8.725 MW (Oktober 2024)
-- ============================================================
UPDATE ruptl_provinsi SET beban_puncak_2024_mw = 8725 WHERE id = 18;

-- Penjualan Historis (Tabel B3.1, 2015-2024)
INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh) VALUES
(18,2015,'RUMAH_TANGGA',16795),(18,2016,'RUMAH_TANGGA',17464),(18,2017,'RUMAH_TANGGA',17555),
(18,2018,'RUMAH_TANGGA',17934),(18,2019,'RUMAH_TANGGA',18754),(18,2020,'RUMAH_TANGGA',20362),
(18,2021,'RUMAH_TANGGA',20926),(18,2022,'RUMAH_TANGGA',20872),(18,2023,'RUMAH_TANGGA',21739),
(18,2024,'RUMAH_TANGGA',21739),
(18,2015,'BISNIS',4606),(18,2016,'BISNIS',4921),(18,2017,'BISNIS',5232),
(18,2018,'BISNIS',5645),(18,2019,'BISNIS',6080),(18,2020,'BISNIS',5798),
(18,2021,'BISNIS',6278),(18,2022,'BISNIS',7610),(18,2023,'BISNIS',7927),
(18,2024,'BISNIS',7927),
(18,2015,'PUBLIK',1441),(18,2016,'PUBLIK',1570),(18,2017,'PUBLIK',1682),
(18,2018,'PUBLIK',1830),(18,2019,'PUBLIK',1998),(18,2020,'PUBLIK',1954),
(18,2021,'PUBLIK',2037),(18,2022,'PUBLIK',2325),(18,2023,'PUBLIK',2422),
(18,2024,'PUBLIK',2422),
(18,2015,'INDUSTRI',20717),(18,2016,'INDUSTRI',22188),(18,2017,'INDUSTRI',22957),
(18,2018,'INDUSTRI',23904),(18,2019,'INDUSTRI',24052),(18,2020,'INDUSTRI',21428),
(18,2021,'INDUSTRI',24078),(18,2022,'INDUSTRI',25419),(18,2023,'INDUSTRI',26476),
(18,2024,'INDUSTRI',26476);

-- Pelanggan Historis (Tabel B3.2, 2015-2024, Ribu)
INSERT INTO ruptl_pelanggan_historis (provinsi_id, tahun, sektor, jumlah_ribu) VALUES
(18,2015,'RUMAH_TANGGA',11223),(18,2016,'RUMAH_TANGGA',11748),(18,2017,'RUMAH_TANGGA',12388),
(18,2018,'RUMAH_TANGGA',13041),(18,2019,'RUMAH_TANGGA',13628),(18,2020,'RUMAH_TANGGA',14099),
(18,2021,'RUMAH_TANGGA',14605),(18,2022,'RUMAH_TANGGA',15054),(18,2023,'RUMAH_TANGGA',15594),
(18,2024,'RUMAH_TANGGA',15860),
(18,2015,'BISNIS',357),(18,2016,'BISNIS',427),(18,2017,'BISNIS',506),
(18,2018,'BISNIS',568),(18,2019,'BISNIS',589),(18,2020,'BISNIS',635),
(18,2021,'BISNIS',703),(18,2022,'BISNIS',778),(18,2023,'BISNIS',842),
(18,2024,'BISNIS',857),
(18,2015,'PUBLIK',294),(18,2016,'PUBLIK',319),(18,2017,'PUBLIK',344),
(18,2018,'PUBLIK',371),(18,2019,'PUBLIK',397),(18,2020,'PUBLIK',418),
(18,2021,'PUBLIK',442),(18,2022,'PUBLIK',461),(18,2023,'PUBLIK',485),
(18,2024,'PUBLIK',495),
(18,2015,'INDUSTRI',13.5),(18,2016,'INDUSTRI',14.0),(18,2017,'INDUSTRI',14.6),
(18,2018,'INDUSTRI',15.1),(18,2019,'INDUSTRI',15.4),(18,2020,'INDUSTRI',15.8),
(18,2021,'INDUSTRI',16.4),(18,2022,'INDUSTRI',17.0),(18,2023,'INDUSTRI',17.6),
(18,2024,'INDUSTRI',17.9);

-- Pembangkit Eksisting (Tabel B3.3, skip Sewa)
INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw, dmp_mw) VALUES
(18,'PLN','PLTA','Jawa Bali',39,1915,1888,1863),
(18,'PLN','PLTG','Jawa Bali',10,1168,1132,1128),
(18,'PLN','PLTGU','Jawa Bali',3,1152,1079,743),
(18,'PLN','PLTP','Jawa Bali',7,377,357,337),
(18,'PLN','PLTU','Jawa Bali',6,2040,1839,1842),
(18,'IPP','PLTA','Jawa Bali',2,227,227,205),
(18,'IPP','PLTGU','Jawa Bali',4,2029,2029,2016),
(18,'IPP','PLTM','Jawa Bali',30,150,150,113),
(18,'IPP','PLTP','Jawa Bali',10,821,821,788),
(18,'IPP','PLTU','Jawa Bali',2,1584,1584,906);

-- Proyeksi Kebutuhan (Tabel B3.8, 2025-2034)
INSERT INTO ruptl_proyeksi_kebutuhan (provinsi_id, tahun, pertumbuhan_ekonomi_pct, sales_gwh, produksi_gwh, beban_puncak_mw, pelanggan) VALUES
(18,2025,4.5,65919,70743,9274,17479639),
(18,2026,6.4,70153,75161,9851,17723739),
(18,2027,5.0,73666,78850,10332,17962853),
(18,2028,4.6,77088,82418,10797,18196824),
(18,2029,3.0,79416,84818,11109,18425484),
(18,2030,5.0,83363,88932,11645,18649200),
(18,2031,3.0,85838,91476,11975,18868576),
(18,2032,3.6,88890,94627,12385,19083774),
(18,2033,3.1,91659,97571,12767,19294896),
(18,2034,2.9,94324,100404,13135,19502045);

-- Rencana Pembangkit (Tabel B3.10, 75 item)
INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun, keterangan) VALUES
-- #1-10: COD sama kedua skenario (2025-2026)
(18,'RE_BASE','PLTGU','Muara Tawar Add-on Blok 4',250.0,2025,'Konstruksi - SH-PLN'),
(18,'ARED','PLTGU','Muara Tawar Add-on Blok 4',250.0,2025,'Konstruksi - SH-PLN'),
(18,'RE_BASE','PLTM','Pareang',2.8,2025,'Pendanaan - IPP'),
(18,'ARED','PLTM','Pareang',2.8,2025,'Pendanaan - IPP'),
(18,'RE_BASE','PLTS','Saguling',60.0,2025,'Rencana - SH-PLN'),
(18,'ARED','PLTS','Saguling',60.0,2025,'Rencana - SH-PLN'),
(18,'RE_BASE','PLTS','Jawa Barat (Kuota) IV',100.0,2025,'Rencana - IPP'),
(18,'ARED','PLTS','Jawa Barat (Kuota) IV',100.0,2025,'Rencana - IPP'),
(18,'RE_BASE','PLTP','Gunung Salak Small Scale Binary',15.0,2025,'Konstruksi - IPP'),
(18,'ARED','PLTP','Gunung Salak Small Scale Binary',15.0,2025,'Konstruksi - IPP'),
(18,'RE_BASE','PLTM','Jayamukti',2.3,2026,'Konstruksi - IPP'),
(18,'ARED','PLTM','Jayamukti',2.3,2026,'Konstruksi - IPP'),
(18,'RE_BASE','PLTM','Kertamukti',6.3,2026,'Konstruksi - IPP'),
(18,'ARED','PLTM','Kertamukti',6.3,2026,'Konstruksi - IPP'),
(18,'RE_BASE','PLTB','Jawa-Bali (Kuota) Tersebar I',150.0,2026,'Rencana - IPP'),
(18,'ARED','PLTB','Jawa-Bali (Kuota) Tersebar I',150.0,2026,'Rencana - IPP'),
(18,'RE_BASE','PLTP','Gunung Salak 7',40.0,2026,'Eksplorasi - IPP'),
(18,'ARED','PLTP','Gunung Salak 7',40.0,2026,'Eksplorasi - IPP'),
(18,'RE_BASE','PLTP','Patuha (FTP2)',55.0,2026,'Konstruksi - IPP'),
(18,'ARED','PLTP','Patuha (FTP2)',55.0,2026,'Konstruksi - IPP'),
-- #11-12: COD berbeda
(18,'RE_BASE','PLTP','Wayang Windu (FTP2)',30.0,2027,'Eksplorasi - IPP'),
(18,'ARED','PLTP','Wayang Windu (FTP2)',30.0,2026,'Eksplorasi - IPP'),
(18,'RE_BASE','PLTS+BESS','Jawa Barat (Kuota) VA',100.0,2027,'Rencana - SH-PLN'),
(18,'ARED','PLTS+BESS','Jawa Barat (Kuota) VA',100.0,2026,'Rencana - SH-PLN'),
-- #13-18: COD sama (2027)
(18,'RE_BASE','PLTM','Jawa-Bali (Kuota) Tersebar',74.7,2027,'Pengadaan - IPP'),
(18,'ARED','PLTM','Jawa-Bali (Kuota) Tersebar',74.7,2027,'Pengadaan - IPP'),
(18,'RE_BASE','PLTM','Cilongsong',2.4,2027,'Pengadaan - IPP'),
(18,'ARED','PLTM','Cilongsong',2.4,2027,'Pengadaan - IPP'),
(18,'RE_BASE','PLTM','Talaga 2',2.0,2027,'Pengadaan - IPP'),
(18,'ARED','PLTM','Talaga 2',2.0,2027,'Pengadaan - IPP'),
(18,'RE_BASE','PLTP','Jawa-Bali (Kuota) Tersebar',5.0,2027,'Rencana - IPP'),
(18,'ARED','PLTP','Jawa-Bali (Kuota) Tersebar',5.0,2027,'Rencana - IPP'),
(18,'RE_BASE','PLTM','Pasirhanjuang',4.4,2027,'Pengadaan - IPP'),
(18,'ARED','PLTM','Pasirhanjuang',4.4,2027,'Pengadaan - IPP'),
(18,'RE_BASE','PLTM','Cihaur',3.0,2027,'Pengadaan - IPP'),
(18,'ARED','PLTM','Cihaur',3.0,2027,'Pengadaan - IPP'),
-- #19-31: COD sama (2028)
(18,'RE_BASE','PLTP','Cibuni (FTP2)',10.0,2028,'Eksplorasi - IPP'),
(18,'ARED','PLTP','Cibuni (FTP2)',10.0,2028,'Eksplorasi - IPP'),
(18,'RE_BASE','PLTS','Jawa Barat (Kuota) VII',40.0,2028,'Rencana - IPP'),
(18,'ARED','PLTS','Jawa Barat (Kuota) VII',40.0,2028,'Rencana - IPP'),
(18,'RE_BASE','PS','Upper Cisokan Pump Storage (FTP2)',260.0,2028,'Konstruksi - PLN'),
(18,'ARED','PS','Upper Cisokan Pump Storage (FTP2)',260.0,2028,'Konstruksi - PLN'),
(18,'RE_BASE','PS','Upper Cisokan Pump Storage (FTP2)',260.0,2028,'Konstruksi - PLN'),
(18,'ARED','PS','Upper Cisokan Pump Storage (FTP2)',260.0,2028,'Konstruksi - PLN'),
(18,'RE_BASE','PS','Upper Cisokan Pump Storage (FTP2)',260.0,2028,'Konstruksi - PLN'),
(18,'ARED','PS','Upper Cisokan Pump Storage (FTP2)',260.0,2028,'Konstruksi - PLN'),
(18,'RE_BASE','PS','Upper Cisokan Pump Storage (FTP2)',260.0,2028,'Konstruksi - PLN'),
(18,'ARED','PS','Upper Cisokan Pump Storage (FTP2)',260.0,2028,'Konstruksi - PLN'),
(18,'RE_BASE','PLTSa','Jawa Barat (Kuota) Tersebar',90.0,2028,'Rencana - IPP'),
(18,'ARED','PLTSa','Jawa Barat (Kuota) Tersebar',90.0,2028,'Rencana - IPP'),
(18,'RE_BASE','PLTP','Wayang Windu',30.0,2028,'Rencana - IPP'),
(18,'ARED','PLTP','Wayang Windu',30.0,2028,'Rencana - IPP'),
(18,'RE_BASE','PLTM','Caringin',6.5,2028,'Pengadaan - IPP'),
(18,'ARED','PLTM','Caringin',6.5,2028,'Pengadaan - IPP'),
(18,'RE_BASE','PLTM','Cipanas',3.0,2028,'Rencana - IPP'),
(18,'ARED','PLTM','Cipanas',3.0,2028,'Rencana - IPP'),
(18,'RE_BASE','PLTM','Sadawarna',2.0,2028,'Rencana - IPP'),
(18,'ARED','PLTM','Sadawarna',2.0,2028,'Rencana - IPP'),
(18,'RE_BASE','PLTM','Jawa-Bali (Kuota) Tersebar',6.4,2028,'Rencana - IPP'),
(18,'ARED','PLTM','Jawa-Bali (Kuota) Tersebar',6.4,2028,'Rencana - IPP'),
(18,'RE_BASE','PLTS+BESS','Jawa Barat (Kuota) VB',80.0,2028,'Rencana - IPP'),
(18,'ARED','PLTS+BESS','Jawa Barat (Kuota) VB',80.0,2028,'Rencana - IPP'),
-- #32-35: COD sama (2029)
(18,'RE_BASE','PLTGU','Jawa-4',1000.0,2029,'Rencana - IPP'),
(18,'ARED','PLTGU','Jawa-4',1000.0,2029,'Rencana - IPP'),
(18,'RE_BASE','PLTA','Jawa-Bali (Kuota) Tersebar',50.0,2029,'Rencana - IPP'),
(18,'ARED','PLTA','Jawa-Bali (Kuota) Tersebar',50.0,2029,'Rencana - IPP'),
(18,'RE_BASE','PLTP','Jawa-Bali (Kuota) Tersebar',25.0,2029,'Rencana - IPP'),
(18,'ARED','PLTP','Jawa-Bali (Kuota) Tersebar',25.0,2029,'Rencana - IPP'),
(18,'RE_BASE','PLTG','Jawa-Bali-5',300.0,2029,'Rencana - SH-PLN'),
(18,'ARED','PLTG','Jawa-Bali-5',300.0,2029,'Rencana - SH-PLN'),
-- #36-38: COD berbeda
(18,'RE_BASE','PLTS','Jawa Barat (Kuota) VIA',100.0,2030,'Rencana - SH-PLN'),
(18,'ARED','PLTS','Jawa Barat (Kuota) VIA',100.0,2028,'Rencana - SH-PLN'),
(18,'RE_BASE','PLTS','Jawa Barat (Kuota) IIA',60.0,2030,'Rencana - IPP'),
(18,'ARED','PLTS','Jawa Barat (Kuota) IIA',60.0,2029,'Rencana - IPP'),
(18,'RE_BASE','PLTS','Jawa Barat (Kuota) VIII',40.0,2030,'Rencana - IPP'),
(18,'ARED','PLTS','Jawa Barat (Kuota) VIII',40.0,2029,'Rencana - IPP'),
-- #39-41: COD sama (2030)
(18,'RE_BASE','PLTS','Jawa Barat (Kuota) IIIB',40.0,2030,'Rencana - IPP'),
(18,'ARED','PLTS','Jawa Barat (Kuota) IIIB',40.0,2030,'Rencana - IPP'),
(18,'RE_BASE','PLTP','Jawa-Bali (Kuota) Tersebar',25.0,2030,'Rencana - IPP'),
(18,'ARED','PLTP','Jawa-Bali (Kuota) Tersebar',25.0,2030,'Rencana - IPP'),
(18,'RE_BASE','PLTM','Leuwikeris',7.4,2030,'Rencana - IPP'),
(18,'ARED','PLTM','Leuwikeris',7.4,2030,'Rencana - IPP'),
-- #42-43: COD berbeda
(18,'RE_BASE','PLTB','Jawa-Bali (Kuota) Tersebar II',75.0,2031,'Rencana - IPP'),
(18,'ARED','PLTB','Jawa-Bali (Kuota) Tersebar II',75.0,2030,'Rencana - IPP'),
(18,'RE_BASE','PLTS','Jawa Barat (Kuota) VIB',40.0,2031,'Rencana - IPP'),
(18,'ARED','PLTS','Jawa Barat (Kuota) VIB',40.0,2030,'Rencana - IPP'),
-- #44-48: COD sama (2031)
(18,'RE_BASE','PLTP','Jawa-Bali (Kuota) Tersebar',40.0,2031,'Rencana - IPP'),
(18,'ARED','PLTP','Jawa-Bali (Kuota) Tersebar',40.0,2031,'Rencana - IPP'),
(18,'RE_BASE','PS','Jawa-Bali (Kuota) Tersebar',190.0,2031,'Rencana - IPP'),
(18,'ARED','PS','Jawa-Bali (Kuota) Tersebar',190.0,2031,'Rencana - IPP'),
(18,'RE_BASE','PS','Jawa-Bali (Kuota) Tersebar',190.0,2031,'Rencana - IPP'),
(18,'ARED','PS','Jawa-Bali (Kuota) Tersebar',190.0,2031,'Rencana - IPP'),
(18,'RE_BASE','PS','Jawa-Bali (Kuota) Tersebar',190.0,2031,'Rencana - IPP'),
(18,'ARED','PS','Jawa-Bali (Kuota) Tersebar',190.0,2031,'Rencana - IPP'),
(18,'RE_BASE','PS','Jawa-Bali (Kuota) Tersebar',190.0,2031,'Rencana - IPP'),
(18,'ARED','PS','Jawa-Bali (Kuota) Tersebar',190.0,2031,'Rencana - IPP'),
-- #49: COD berbeda
(18,'RE_BASE','PLTB','Jawa-Bali (Kuota) Tersebar III',150.0,2032,'Rencana - IPP'),
(18,'ARED','PLTB','Jawa-Bali (Kuota) Tersebar III',150.0,2027,'Rencana - IPP'),
-- #50-53: COD sama (2032)
(18,'RE_BASE','PLTP','Gunung Salak 8',63.0,2032,'Eksplorasi - IPP'),
(18,'ARED','PLTP','Gunung Salak 8',63.0,2032,'Eksplorasi - IPP'),
(18,'RE_BASE','PLTP','Tangkuban Perahu (FTP2)',20.0,2032,'Eksplorasi - SH-PLN'),
(18,'ARED','PLTP','Tangkuban Perahu (FTP2)',20.0,2032,'Eksplorasi - SH-PLN'),
(18,'RE_BASE','PLTP','Tangkuban Perahu (FTP2)',20.0,2032,'Eksplorasi - SH-PLN'),
(18,'ARED','PLTP','Tangkuban Perahu (FTP2)',20.0,2032,'Eksplorasi - SH-PLN'),
(18,'RE_BASE','PLTP','Patuha (FTP2)',55.0,2032,'Eksplorasi - IPP'),
(18,'ARED','PLTP','Patuha (FTP2)',55.0,2032,'Eksplorasi - IPP'),
-- #54-61: COD sama (2033)
(18,'RE_BASE','PLTP','Jawa-Bali (Kuota) Tersebar',25.0,2033,'Rencana - IPP'),
(18,'ARED','PLTP','Jawa-Bali (Kuota) Tersebar',25.0,2033,'Rencana - IPP'),
(18,'RE_BASE','PLTP','Jawa-Bali (Kuota) Tersebar',55.0,2033,'Rencana - IPP'),
(18,'ARED','PLTP','Jawa-Bali (Kuota) Tersebar',55.0,2033,'Rencana - IPP'),
(18,'RE_BASE','PLTP','Jawa-Bali (Kuota) Tersebar',55.0,2033,'Rencana - IPP'),
(18,'ARED','PLTP','Jawa-Bali (Kuota) Tersebar',55.0,2033,'Rencana - IPP'),
(18,'RE_BASE','PLTP','Jawa-Bali (Kuota) Tersebar',20.0,2033,'Rencana - IPP'),
(18,'ARED','PLTP','Jawa-Bali (Kuota) Tersebar',20.0,2033,'Rencana - IPP'),
(18,'RE_BASE','PLTP','Jawa-Bali (Kuota) Tersebar',55.0,2033,'Rencana - IPP'),
(18,'ARED','PLTP','Jawa-Bali (Kuota) Tersebar',55.0,2033,'Rencana - IPP'),
(18,'RE_BASE','PLTP','Jawa-Bali (Kuota) Tersebar',30.0,2033,'Rencana - IPP'),
(18,'ARED','PLTP','Jawa-Bali (Kuota) Tersebar',30.0,2033,'Rencana - IPP'),
(18,'RE_BASE','PLTP','Patuha (FTP2)',55.0,2033,'Eksplorasi - IPP'),
(18,'ARED','PLTP','Patuha (FTP2)',55.0,2033,'Eksplorasi - IPP'),
(18,'RE_BASE','PLTP','Wayang Windu',120.0,2033,'Rencana - IPP'),
(18,'ARED','PLTP','Wayang Windu',120.0,2033,'Rencana - IPP'),
-- #62: COD berbeda
(18,'RE_BASE','PLTS','Jawa Barat (Kuota) Tersebar IX',190.0,2034,'Rencana - IPP'),
(18,'ARED','PLTS','Jawa Barat (Kuota) Tersebar IX',190.0,2027,'Rencana - IPP'),
-- #63-64: COD sama (2034)
(18,'RE_BASE','BESS','BESS Smoothing Tersebar',150.0,2034,'Rencana - PLN'),
(18,'ARED','BESS','BESS Smoothing Tersebar',150.0,2034,'Rencana - PLN'),
(18,'RE_BASE','BESS','Jawa-Bali (Kuota) Tersebar IVB',250.0,2034,'Rencana - SH-PLN'),
(18,'ARED','BESS','Jawa-Bali (Kuota) Tersebar IVB',250.0,2034,'Rencana - SH-PLN'),
-- #65: RE Base only
(18,'RE_BASE','PLTGU','Jawa-6',1000.0,2034,'Rencana - IPP'),
-- #66-75: ARED only
(18,'ARED','BESS','BESS Smoothing Tersebar',100.0,2029,'Rencana - PLN'),
(18,'ARED','PLTS','Jawa Barat (Kuota) Tersebar X',977.0,2031,'Rencana - IPP'),
(18,'ARED','PLTB','Jawa-Bali (Kuota) Tersebar IV',200.0,2031,'Rencana - IPP'),
(18,'ARED','PLTB','Jawa-Bali (Kuota) Tersebar V',200.0,2031,'Rencana - IPP'),
(18,'ARED','PLTS','Jawa Barat (Kuota) Tersebar XI',977.0,2032,'Rencana - IPP'),
(18,'ARED','BESS','BESS Jawa Bali (Kuota) Tersebar II',200.0,2032,'Rencana - SH-PLN'),
(18,'ARED','BESS','BESS Jawa Bali (Kuota) Tersebar IIIB',100.0,2032,'Rencana - SH-PLN'),
(18,'ARED','PLTS','Jawa Barat (Kuota) Tersebar XII',977.0,2033,'Rencana - IPP'),
(18,'ARED','BESS','BESS Smoothing Tersebar',150.0,2033,'Rencana - PLN'),
(18,'ARED','BESS','BESS Smoothing Tersebar',100.0,2034,'Rencana - PLN');

-- Rencana Transmisi (Tabel B3.11.a/b — RE Base dan ARED berbeda di 2026 & 2027)
INSERT INTO ruptl_rencana_transmisi (provinsi_id, skenario, tahun, kms) VALUES
(18,'RE_BASE',2025,516),(18,'RE_BASE',2026,699),(18,'RE_BASE',2027,687),
(18,'RE_BASE',2028,427),(18,'RE_BASE',2029,344),(18,'RE_BASE',2030,416),
(18,'RE_BASE',2031,176),(18,'RE_BASE',2032,191),(18,'RE_BASE',2033,154),(18,'RE_BASE',2034,20),
(18,'ARED',2025,516),(18,'ARED',2026,718),(18,'ARED',2027,667),
(18,'ARED',2028,427),(18,'ARED',2029,344),(18,'ARED',2030,416),
(18,'ARED',2031,176),(18,'ARED',2032,191),(18,'ARED',2033,154),(18,'ARED',2034,20);

-- Rencana Gardu Induk (Tabel B3.13.a/b — RE Base dan ARED identik, Total=18.220 MVA)
INSERT INTO ruptl_rencana_gardu_induk (provinsi_id, skenario, tahun, mva) VALUES
(18,'RE_BASE',2025,3700),(18,'RE_BASE',2026,1960),(18,'RE_BASE',2027,6020),
(18,'RE_BASE',2028,3900),(18,'RE_BASE',2029,960),(18,'RE_BASE',2030,300),
(18,'RE_BASE',2031,480),(18,'RE_BASE',2032,360),(18,'RE_BASE',2033,300),(18,'RE_BASE',2034,240),
(18,'ARED',2025,3700),(18,'ARED',2026,1960),(18,'ARED',2027,6020),
(18,'ARED',2028,3900),(18,'ARED',2029,960),(18,'ARED',2030,300),
(18,'ARED',2031,480),(18,'ARED',2032,360),(18,'ARED',2033,300),(18,'ARED',2034,240);

