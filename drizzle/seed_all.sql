-- ============================================================
-- COCKPIT — SEED ALL: Update inkremental untuk database yang
-- sudah menjalankan FULL_SETUP.sql (versi lama, sebelum B2/B4).
-- ============================================================
-- FULL_SETUP.sql sudah punya: schema, domain/modul, 34 provinsi,
--   B1 DKI (penjualan historis), B3 Jawa Barat (lengkap kecuali transmisi/GI).
-- File ini menambahkan yang belum ada:
--   [0] UPDATE nama domain & modul (idempoten — aman diulang)
--   [1] B2 Banten    — penjualan, proyeksi, pembangkit, rencana, transmisi, GI
--   [2] B4 Jawa Tengah — penjualan, proyeksi, pembangkit, rencana, transmisi, GI
--
-- Cara import via SSH ke Hostinger:
--   mysql -u u164655286_cockpit -p u164655286_cockpit < drizzle/seed_all.sql
-- ============================================================


-- ============================================================
-- BAGIAN 0: UPDATE NAMA DOMAIN & MODUL  (idempoten)
-- ============================================================

UPDATE domains SET
  nama      = 'Energi & Ketenagalistrikan',
  deskripsi = 'Data riset pribadi sektor energi & ketenagalistrikan — bauran RE & NRE, RUPTL PLN nasional, operasional PLN UID Jabar, ekuitas energi, dan keandalan distribusi'
WHERE slug = 'energi-jabar';

UPDATE domain_modules dm
JOIN domains d ON dm.domain_id = d.id
SET dm.nama = 'Bauran Energi Jawa Barat'
WHERE d.slug = 'energi-jabar' AND dm.slug = 'mdp';


-- ============================================================
-- BAGIAN 1: B2 — BANTEN
-- Sumber: RUPTL PLN 2025-2034, Lampiran B2 (hal. B-14 s.d B-26)
-- ============================================================

SET @b2 = (SELECT id FROM ruptl_provinsi WHERE kode = 'B2');

-- Penjualan Historis B2 — Tabel B2.1
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

-- Proyeksi Kebutuhan B2 — Tabel B2.8
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

-- Pembangkit Eksisting B2 — Tabel B2.3
INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw) VALUES
(@b2,'PLN','PLTD', 'Jawa Bali',  7,    1.2,   1.2),
(@b2,'PLN','PLTGU','Jawa Bali',  1,  739.0, 660.0),
(@b2,'PLN','PLTU', 'Jawa Bali', 14, 5885.0,5467.0),
(@b2,'IPP','PLTM', 'Jawa Bali',  4,   20.6,  20.6),
(@b2,'IPP','PLTU', 'Jawa Bali',  3, 2607.0,2607.0);

-- Rencana Pembangkit RE Base B2 — Tabel B2.9 & B2.11
INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun) VALUES
(@b2,'RE_BASE','PLTU',  'Jawa-9',                          1000.0, 2025),
(@b2,'RE_BASE','PLTU',  'Jawa-10',                         1000.0, 2025),
(@b2,'RE_BASE','PLTM',  'Cikotok',                            4.2, 2026),
(@b2,'RE_BASE','PLTS',  'Banten (Kuota) II',                 50.0, 2026),
(@b2,'RE_BASE','PLTM',  'Cikamunding',                        6.0, 2027),
(@b2,'RE_BASE','PLTM',  'Nagajaya',                           6.0, 2027),
(@b2,'RE_BASE','PLTM',  'Bulakan',                            3.0, 2027),
(@b2,'RE_BASE','PLTM',  'Jawa-Bali (Kuota) Tersebar',         4.4, 2027),
(@b2,'RE_BASE','PLTSa', 'Banten (Kuota) Tersebar 1',         40.0, 2028),
(@b2,'RE_BASE','PLTS',  'Banten (Kuota) IVA',                50.0, 2028),
(@b2,'RE_BASE','PLTM',  'Cibareno 1',                         5.0, 2028),
(@b2,'RE_BASE','PLTM',  'Karian',                             1.8, 2028),
(@b2,'RE_BASE','PLTB',  'Banten',                           100.0, 2028),
(@b2,'RE_BASE','PLTB',  'Banten',                           100.0, 2029),
(@b2,'RE_BASE','PLTS',  'Banten (Kuota) IVC',                50.0, 2030),
(@b2,'RE_BASE','PLTSa', 'Banten (Kuota) Tersebar 2',         40.0, 2030),
(@b2,'RE_BASE','PLTS',  'Banten (Kuota) IVB',                50.0, 2030),
(@b2,'RE_BASE','PLTS',  'Banten (Kuota) VII',                50.0, 2030),
(@b2,'RE_BASE','PLTP',  'Rawadano (FTP2)',                    30.0, 2030),
(@b2,'RE_BASE','PLTGU', 'Jawa-5',                          1000.0, 2030),
(@b2,'RE_BASE','PLTGU', 'Jawa-Bali-7 (SH-PLN)',             500.0, 2030),
(@b2,'RE_BASE','PLTP',  'Rawadano (FTP2)',                    80.0, 2032),
(@b2,'RE_BASE','PLTP',  'Jawa-Bali (Kuota) Tersebar',        35.0, 2033),
(@b2,'RE_BASE','PLTS',  'Banten (Kuota) V',                  45.0, 2034),
(@b2,'RE_BASE','PLTB',  'Jawa-Bali (Kuota) Tersebar III',   300.0, 2034),
(@b2,'RE_BASE','BESS',  'Jawa-Bali (Kuota) Tersebar IVA',   250.0, 2034);

-- Rencana Pembangkit ARED B2 — Tabel B2.10 & B2.11
INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun, keterangan) VALUES
(@b2,'ARED','PLTS+BESS','Banten (Kuota) III',               80.0, 2027, 'COD ARED lebih awal dari RE Base (2030)'),
(@b2,'ARED','PLTS',     'Banten (Kuota) IVC',               50.0, 2029, 'COD ARED 2029 vs RE Base 2030'),
(@b2,'ARED','PLTS',     'Banten (Kuota) IX',               110.0, 2033, 'Hanya skenario ARED'),
(@b2,'ARED','PLTS',     'Banten (Kuota) X',                150.0, 2034, 'Hanya skenario ARED'),
(@b2,'ARED','PLTB',     'Jawa-Bali (Kuota) Tersebar IV',   600.0, 2034, 'Hanya skenario ARED'),
(@b2,'ARED','PLTS',     'Banten (Kuota) V',                 45.0, 2031, 'COD ARED 2031 vs RE Base 2034');

-- Rencana Transmisi B2 — Tabel B2.12.a
INSERT INTO ruptl_rencana_transmisi (provinsi_id, skenario, tahun, kms) VALUES
(@b2,'RE_BASE',2025,222), (@b2,'RE_BASE',2026,77), (@b2,'RE_BASE',2027, 2),
(@b2,'RE_BASE',2028, 50), (@b2,'RE_BASE',2030, 8), (@b2,'RE_BASE',2033,10),
(@b2,'ARED',   2025,222), (@b2,'ARED',   2026,77), (@b2,'ARED',   2027, 2),
(@b2,'ARED',   2028, 50), (@b2,'ARED',   2030, 8), (@b2,'ARED',   2033,10);

-- Rencana Gardu Induk B2 — Tabel B2.14.a
INSERT INTO ruptl_rencana_gardu_induk (provinsi_id, skenario, tahun, mva) VALUES
(@b2,'RE_BASE',2025,2100), (@b2,'RE_BASE',2026,2180), (@b2,'RE_BASE',2027, 180),
(@b2,'RE_BASE',2028, 120), (@b2,'RE_BASE',2030,1060), (@b2,'RE_BASE',2033, 120),
(@b2,'ARED',   2025,2100), (@b2,'ARED',   2026,2180), (@b2,'ARED',   2027, 180),
(@b2,'ARED',   2028, 120), (@b2,'ARED',   2030,1060), (@b2,'ARED',   2033, 120);


-- ============================================================
-- BAGIAN 2: B4 — JAWA TENGAH
-- Sumber: RUPTL PLN 2025-2034, Lampiran B4 (hal. B-50 s.d B-68)
-- ============================================================

SET @b4 = (SELECT id FROM ruptl_provinsi WHERE kode = 'B4');

-- Penjualan Historis B4 — Tabel B4.1
INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh) VALUES
(@b4,2015,'RUMAH_TANGGA', 9807), (@b4,2015,'BISNIS',2339), (@b4,2015,'PUBLIK',1360), (@b4,2015,'INDUSTRI', 6901),
(@b4,2016,'RUMAH_TANGGA',10370), (@b4,2016,'BISNIS',2585), (@b4,2016,'PUBLIK',1493), (@b4,2016,'INDUSTRI', 7228),
(@b4,2017,'RUMAH_TANGGA',10428), (@b4,2017,'BISNIS',2685), (@b4,2017,'PUBLIK',1572), (@b4,2017,'INDUSTRI', 7717),
(@b4,2018,'RUMAH_TANGGA',10816), (@b4,2018,'BISNIS',2907), (@b4,2018,'PUBLIK',1693), (@b4,2018,'INDUSTRI', 8142),
(@b4,2019,'RUMAH_TANGGA',11486), (@b4,2019,'BISNIS',3178), (@b4,2019,'PUBLIK',1824), (@b4,2019,'INDUSTRI', 8270),
(@b4,2020,'RUMAH_TANGGA',12556), (@b4,2020,'BISNIS',3169), (@b4,2020,'PUBLIK',1773), (@b4,2020,'INDUSTRI', 7593),
(@b4,2021,'RUMAH_TANGGA',12987), (@b4,2021,'BISNIS',3513), (@b4,2021,'PUBLIK',1829), (@b4,2021,'INDUSTRI', 8332),
(@b4,2022,'RUMAH_TANGGA',12962), (@b4,2022,'BISNIS',3790), (@b4,2022,'PUBLIK',2035), (@b4,2022,'INDUSTRI', 8778),
(@b4,2023,'RUMAH_TANGGA',13620), (@b4,2023,'BISNIS',4171), (@b4,2023,'PUBLIK',2233), (@b4,2023,'INDUSTRI', 8408),
(@b4,2024,'RUMAH_TANGGA',14630), (@b4,2024,'BISNIS',4480), (@b4,2024,'PUBLIK',2398), (@b4,2024,'INDUSTRI', 9348);

-- Proyeksi Kebutuhan B4 — Tabel B4.8
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

-- Pembangkit Eksisting B4 — Tabel B4.3
INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw) VALUES
(@b4,'PLN','PLTA', 'Jawa Bali', 27,  318.0, 307.0),
(@b4,'PLN','PLTD', 'Isolated',   9,    5.7,   4.9),
(@b4,'PLN','PLTG', 'Jawa Bali',  2,   55.0,  49.5),
(@b4,'PLN','PLTGU','Jawa Bali',  3, 1813.0,1589.0),
(@b4,'PLN','PLTM', 'Jawa Bali',  5,   10.1,   8.8),
(@b4,'PLN','PLTS', 'Jawa Bali',  5,    0.2,   0.2),
(@b4,'PLN','PLTU', 'Jawa Bali', 10, 4410.0,4012.0),
(@b4,'IPP','PLTD', 'Isolated',   2,    1.6,   1.6),
(@b4,'IPP','PLTM', 'Jawa Bali', 28,   43.8,  40.3),
(@b4,'IPP','PLTP', 'Jawa Bali',  1,   60.0,  47.0),
(@b4,'IPP','PLTU', 'Jawa Bali',  8, 6105.0,6021.0);

-- Rencana Pembangkit RE Base B4 — Tabel B4.9.a & B4.10
INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun) VALUES
(@b4,'RE_BASE','PLTM',     'Harjosari',                         9.90, 2025),
(@b4,'RE_BASE','PLTM',     'Banyubiru',                         0.17, 2025),
(@b4,'RE_BASE','PLTS',     'Jawa Tengah (Kuota) II',          100.00, 2025),
(@b4,'RE_BASE','PLTS',     'Jawa Tengah (Kuota) IV',          100.00, 2025),
(@b4,'RE_BASE','PLTM',     'Gerak Serayu',                      4.98, 2026),
(@b4,'RE_BASE','PLTM',     'Jatibarang',                        1.50, 2026),
(@b4,'RE_BASE','PLTP',     'Dieng (FTP2)',                     55.00, 2027),
(@b4,'RE_BASE','PLTM',     'Jawa-Bali (Kuota) Tersebar',      149.00, 2027),
(@b4,'RE_BASE','PLTS',     'Jawa Tengah (Kuota) IIIB',         50.00, 2027),
(@b4,'RE_BASE','PLTP',     'Dieng (FTP2)',                     35.00, 2028),
(@b4,'RE_BASE','PLTS',     'Jawa Tengah (Kuota) IIIA',         50.00, 2028),
(@b4,'RE_BASE','PLTM',     'Jawa-Bali (Kuota) Tersebar',        0.70, 2028),
(@b4,'RE_BASE','PLTS+BESS','Jawa Tengah (Kuota) IIIC',         90.00, 2030),
(@b4,'RE_BASE','PLTP',     'Dieng (FTP2)',                     55.00, 2030),
(@b4,'RE_BASE','PLTP',     'Dieng (FTP2)',                     55.00, 2030),
(@b4,'RE_BASE','PLTM',     'Jawa-Bali (Kuota) Tersebar',        5.00, 2030),
(@b4,'RE_BASE','PLTSa',    'Jawa Tengah (Kuota) Tersebar',     20.00, 2030),
(@b4,'RE_BASE','PLTSa',    'Jawa Tengah (Kuota) Tersebar',      5.00, 2030),
(@b4,'RE_BASE','PLTS+BESS','Jawa Tengah (Kuota) I',            50.00, 2031),
(@b4,'RE_BASE','PLTB',     'Jawa-Bali (Kuota) Tersebar I',     60.00, 2031),
(@b4,'RE_BASE','PLTS',     'Jawa Tengah (Kuota) V',            40.00, 2031),
(@b4,'RE_BASE','PLTP',     'Baturaden (FTP2)',                110.00, 2031),
(@b4,'RE_BASE','PLTP',     'Baturaden (FTP2)',                 75.00, 2031),
(@b4,'RE_BASE','PLTP',     'Ungaran (FTP2)',                   55.00, 2031),
(@b4,'RE_BASE','PLTB',     'Jawa-Bali (Kuota) Tersebar II',    50.00, 2032),
(@b4,'RE_BASE','PLTB',     'Jawa-Bali (Kuota) Tersebar III',   50.00, 2032),
(@b4,'RE_BASE','PLTP',     'Baturaden (FTP2)',                 35.00, 2032),
(@b4,'RE_BASE','PLTP',     'Jawa-Bali (Kuota) Tersebar',       45.00, 2032),
(@b4,'RE_BASE','PS',       'Matenggeng PS',                   943.00, 2032),
(@b4,'RE_BASE','PLTP',     'Dieng (FTP2) 1',                   55.00, 2033),
(@b4,'RE_BASE','PLTP',     'Dieng (FTP2) 2',                   55.00, 2033),
(@b4,'RE_BASE','PLTP',     'Dieng (FTP2) 3',                   35.00, 2033),
(@b4,'RE_BASE','PLTS',     'Jawa Tengah (Kuota) VI',           50.00, 2034);

-- Rencana Pembangkit ARED B4
INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, nama, kapasitas_mw, cod_tahun, keterangan) VALUES
(@b4,'ARED','PLTS','Jawa Tengah (Kuota) IX',           57.00, 2026, 'Hanya ARED, COD lebih awal dari RE Base 2034'),
(@b4,'ARED','PLTS','Jawa Tengah (Kuota) X',           786.00, 2031, 'Hanya ARED'),
(@b4,'ARED','PLTS','Jawa Tengah (Kuota) XI (×8)',     786.00, 2032, 'Hanya ARED, 8 proyek @~98 MW'),
(@b4,'ARED','PLTS','Jawa Tengah (Kuota) XII (×8)',    786.00, 2033, 'Hanya ARED'),
(@b4,'ARED','PLTS','Jawa Tengah (Kuota) XIII',        786.00, 2034, 'Hanya ARED'),
(@b4,'ARED','PLTB','Jawa-Bali (Kuota) Tersebar IV-VII',800.00, 2032, 'Hanya ARED'),
(@b4,'ARED','BESS','Jawa-Bali (Kuota) Tersebar IVC',  250.00, 2034, 'Hanya ARED'),
(@b4,'ARED','BESS','Jawa-Bali (Kuota) Tersebar I',    200.00, 2031, 'Hanya ARED');

-- Rencana Transmisi B4 — Tabel B4.11.a
INSERT INTO ruptl_rencana_transmisi (provinsi_id, skenario, tahun, kms) VALUES
(@b4,'RE_BASE',2025,283), (@b4,'RE_BASE',2026,193), (@b4,'RE_BASE',2027,629),
(@b4,'RE_BASE',2028,703), (@b4,'RE_BASE',2029, 94), (@b4,'RE_BASE',2030, 40),
(@b4,'RE_BASE',2031,120), (@b4,'RE_BASE',2032,129), (@b4,'RE_BASE',2033,400),
(@b4,'ARED',   2025,283), (@b4,'ARED',   2026,193), (@b4,'ARED',   2027,629),
(@b4,'ARED',   2028,703), (@b4,'ARED',   2029, 94), (@b4,'ARED',   2030, 40),
(@b4,'ARED',   2031,120), (@b4,'ARED',   2032,129), (@b4,'ARED',   2033,400);

-- Rencana Gardu Induk B4 — Tabel B4.13.a
INSERT INTO ruptl_rencana_gardu_induk (provinsi_id, skenario, tahun, mva) VALUES
(@b4,'RE_BASE',2025, 720), (@b4,'RE_BASE',2026,1270), (@b4,'RE_BASE',2027,1300),
(@b4,'RE_BASE',2028,3060), (@b4,'RE_BASE',2029, 180), (@b4,'RE_BASE',2030,  60),
(@b4,'RE_BASE',2031, 240), (@b4,'RE_BASE',2032,1000), (@b4,'RE_BASE',2033,1120),
(@b4,'RE_BASE',2034,  60),
(@b4,'ARED',   2025, 720), (@b4,'ARED',   2026,1270), (@b4,'ARED',   2027,1300),
(@b4,'ARED',   2028,3060), (@b4,'ARED',   2029, 180), (@b4,'ARED',   2030,  60),
(@b4,'ARED',   2031, 240), (@b4,'ARED',   2032,1000), (@b4,'ARED',   2033,1120),
(@b4,'ARED',   2034,  60);


-- ============================================================
-- PROVINSI YANG BELUM DIISI
-- ============================================================
-- Gunakan format: SET @kode = (SELECT id FROM ruptl_provinsi WHERE kode = 'XX');
-- lalu INSERT per tabel sesuai urutan: penjualan → proyeksi → pembangkit → rencana → transmisi → GI
--
-- Lampiran A: A1 Aceh, A2 Sumut, A3 Riau, A4 Kepri, A5 Babel, A6 Sumbar,
--             A7 Jambi, A8 Sumsel, A9 Bengkulu, A10 Lampung,
--             A11 Kalbar, A12 Kalsel, A13 Kalteng, A14 Kaltim, A15 Kaltara
-- Lampiran B: B1 DKI (proyeksi+pembangkit belum), B3 Jabar (transmisi+GI belum),
--             B5 DIY, B6 Jatim, B7 Bali
-- Lampiran C: C1-C12 seluruhnya
-- ============================================================
