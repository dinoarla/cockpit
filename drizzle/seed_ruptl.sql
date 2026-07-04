-- ============================================================
-- SEED DATA RUPTL PLN 2025-2034
-- Jalankan SETELAH migrasi: mysql -u USER -p DB_NAME < drizzle/seed_ruptl.sql
-- ============================================================

-- -------- MASTER PROVINSI (34 entri) --------
INSERT INTO ruptl_provinsi (kode, nama, lampiran, wilayah_sistem, beban_puncak_2024_mw) VALUES
('A1',  'Aceh',                          'A', 'SUMATERA KALIMANTAN',         675.00),
('A2',  'Sumatera Utara',                'A', 'SUMATERA KALIMANTAN',        2181.00),
('A3',  'Riau',                          'A', 'SUMATERA KALIMANTAN',        1073.00),
('A4',  'Kepulauan Riau',               'A', 'SUMATERA KALIMANTAN',         NULL),
('A5',  'Kepulauan Bangka Belitung',    'A', 'SUMATERA KALIMANTAN',         NULL),
('A6',  'Sumatera Barat',               'A', 'SUMATERA KALIMANTAN',          699.00),
('A7',  'Jambi',                         'A', 'SUMATERA KALIMANTAN',          519.00),
('A8',  'Sumatera Selatan',             'A', 'SUMATERA KALIMANTAN',         1221.00),
('A9',  'Bengkulu',                      'A', 'SUMATERA KALIMANTAN',          254.00),
('A10', 'Lampung',                       'A', 'SUMATERA KALIMANTAN',         1318.00),
('A11', 'Kalimantan Barat',             'A', 'SUMATERA KALIMANTAN',           NULL),
('A12', 'Kalimantan Selatan',           'A', 'SUMATERA KALIMANTAN',           NULL),
('A13', 'Kalimantan Tengah',            'A', 'SUMATERA KALIMANTAN',           NULL),
('A14', 'Kalimantan Timur',             'A', 'SUMATERA KALIMANTAN',           NULL),
('A15', 'Kalimantan Utara',             'A', 'SUMATERA KALIMANTAN',           NULL),
('B1',  'DKI Jakarta',                   'B', 'JAWA MADURA BALI',            5917.00),
('B2',  'Banten',                        'B', 'JAWA MADURA BALI',            4143.00),
('B3',  'Jawa Barat',                    'B', 'JAWA MADURA BALI',            8725.00),
('B4',  'Jawa Tengah',                   'B', 'JAWA MADURA BALI',            4296.00),
('B5',  'DI Yogyakarta',                 'B', 'JAWA MADURA BALI',             622.00),
('B6',  'Jawa Timur',                    'B', 'JAWA MADURA BALI',            6937.00),
('B7',  'Bali',                          'B', 'JAWA MADURA BALI',            1164.00),
('C1',  'Sulawesi Utara',               'C', 'SULAWESI MALUKU PAPUA NT',      NULL),
('C2',  'Sulawesi Tengah',              'C', 'SULAWESI MALUKU PAPUA NT',      NULL),
('C3',  'Gorontalo',                     'C', 'SULAWESI MALUKU PAPUA NT',     NULL),
('C4',  'Sulawesi Selatan',             'C', 'SULAWESI MALUKU PAPUA NT',      NULL),
('C5',  'Sulawesi Tenggara',            'C', 'SULAWESI MALUKU PAPUA NT',      NULL),
('C6',  'Sulawesi Barat',               'C', 'SULAWESI MALUKU PAPUA NT',     NULL),
('C7',  'Maluku',                        'C', 'SULAWESI MALUKU PAPUA NT',    75.20),
('C8',  'Maluku Utara',                 'C', 'SULAWESI MALUKU PAPUA NT',    114.15),
('C9',  'Papua & Papua Pegunungan',     'C', 'SULAWESI MALUKU PAPUA NT',      NULL),
('C10', 'Papua Barat & Papua Barat Daya','C','SULAWESI MALUKU PAPUA NT',     NULL),
('C11', 'Nusa Tenggara Barat',          'C', 'SULAWESI MALUKU PAPUA NT',      NULL),
('C12', 'Nusa Tenggara Timur',          'C', 'SULAWESI MALUKU PAPUA NT',      NULL);

-- -------- PENJUALAN HISTORIS — JAWA BARAT (B3) --------
-- Sumber: Tabel B3.1 RUPTL PLN 2025-2034
SET @b3 = (SELECT id FROM ruptl_provinsi WHERE kode = 'B3');

INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh) VALUES
(@b3,2015,'RUMAH_TANGGA',16795),(@b3,2015,'BISNIS',4606),(@b3,2015,'PUBLIK',1441),(@b3,2015,'INDUSTRI',20717),
(@b3,2016,'RUMAH_TANGGA',17464),(@b3,2016,'BISNIS',4921),(@b3,2016,'PUBLIK',1570),(@b3,2016,'INDUSTRI',22188),
(@b3,2017,'RUMAH_TANGGA',17555),(@b3,2017,'BISNIS',5232),(@b3,2017,'PUBLIK',1682),(@b3,2017,'INDUSTRI',22957),
(@b3,2018,'RUMAH_TANGGA',17934),(@b3,2018,'BISNIS',5645),(@b3,2018,'PUBLIK',1830),(@b3,2018,'INDUSTRI',23904),
(@b3,2019,'RUMAH_TANGGA',18754),(@b3,2019,'BISNIS',6080),(@b3,2019,'PUBLIK',1998),(@b3,2019,'INDUSTRI',24052),
(@b3,2020,'RUMAH_TANGGA',20362),(@b3,2020,'BISNIS',5798),(@b3,2020,'PUBLIK',1954),(@b3,2020,'INDUSTRI',21428),
(@b3,2021,'RUMAH_TANGGA',20926),(@b3,2021,'BISNIS',6278),(@b3,2021,'PUBLIK',2037),(@b3,2021,'INDUSTRI',24078),
(@b3,2022,'RUMAH_TANGGA',20872),(@b3,2022,'BISNIS',7610),(@b3,2022,'PUBLIK',2325),(@b3,2022,'INDUSTRI',25419),
(@b3,2023,'RUMAH_TANGGA',21739),(@b3,2023,'BISNIS',7927),(@b3,2023,'PUBLIK',2422),(@b3,2023,'INDUSTRI',26476),
(@b3,2024,'RUMAH_TANGGA',21739),(@b3,2024,'BISNIS',7927),(@b3,2024,'PUBLIK',2422),(@b3,2024,'INDUSTRI',26476);

-- -------- PROYEKSI KEBUTUHAN — JAWA BARAT (B3) --------
-- Sumber: Tabel B3.8 RUPTL PLN 2025-2034
INSERT INTO ruptl_proyeksi_kebutuhan (provinsi_id, tahun, pertumbuhan_ekonomi_pct, sales_gwh, produksi_gwh, beban_puncak_mw, pelanggan) VALUES
(@b3,2025,4.5,65919,70743,9274,17479639),
(@b3,2026,6.4,70153,75161,9851,17723739),
(@b3,2027,5.0,73666,78850,10332,17962853),
(@b3,2028,4.6,77088,82418,10797,18196824),
(@b3,2029,3.0,79416,84818,11109,18425484),
(@b3,2030,5.0,83363,88932,11645,18649200),
(@b3,2031,3.0,85838,91476,11975,18868576),
(@b3,2032,3.6,88890,94627,12385,19083774),
(@b3,2033,3.1,91659,97571,12767,19294896),
(@b3,2034,2.9,94324,100404,13135,19502045);

-- -------- PEMBANGKIT EKSISTING — JAWA BARAT (B3) --------
-- Sumber: Tabel B3.3 RUPTL PLN 2025-2034
INSERT INTO ruptl_pembangkit_eksisting (provinsi_id, pemilik, jenis, sistem_tenaga_listrik, jumlah_unit, kapasitas_mw, daya_mampu_mw, dmp_mw) VALUES
(@b3,'PLN','PLTA','Jawa Bali',39,1915,1888,1863),
(@b3,'PLN','PLTG','Jawa Bali',10,1168,1132,1128),
(@b3,'PLN','PLTGU','Jawa Bali',3,1152,1079,743),
(@b3,'PLN','PLTP','Jawa Bali',7,377,357,337),
(@b3,'PLN','PLTU','Jawa Bali',6,2040,1839,1842),
(@b3,'IPP','PLTA','Jawa Bali',2,227,227,205),
(@b3,'IPP','PLTGU','Jawa Bali',4,2029,2029,2016),
(@b3,'IPP','PLTM','Jawa Bali',30,150,150,113),
(@b3,'IPP','PLTP','Jawa Bali',10,821,821,788),
(@b3,'IPP','PLTU','Jawa Bali',2,1584,1584,906);

-- -------- RENCANA PEMBANGKIT RE BASE — JAWA BARAT (B3) --------
-- Sumber: Tabel B3.9.a RUPTL PLN 2025-2034
INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, kapasitas_mw, cod_tahun) VALUES
(@b3,'RE_BASE','PS',1040,2028),
(@b3,'RE_BASE','BESS',150,2034);

-- -------- RENCANA PEMBANGKIT ARED — JAWA BARAT (B3) --------
-- Sumber: Tabel B3.9.b RUPTL PLN 2025-2034 (ringkasan per jenis)
INSERT INTO ruptl_rencana_pembangkit (provinsi_id, skenario, jenis, kapasitas_mw, cod_tahun, keterangan) VALUES
(@b3,'ARED','PLTS',380,2026,'Termasuk PLTS+BESS'),
(@b3,'ARED','PLTA',1018,2027,'Hidro skala besar'),
(@b3,'ARED','PLTB',775,2028,'Bayu/Angin'),
(@b3,'ARED','PLTP',335,2029,'Panas Bumi'),
(@b3,'ARED','PLTS',180,2030,'PLTS+BESS tambahan'),
(@b3,'ARED','PS',760,2031,'Pumped Storage'),
(@b3,'ARED','PLTM',74,2032,'Mini Hidro'),
(@b3,'ARED','BESS',150,2034,'Battery Storage');

-- -------- PENJUALAN HISTORIS — DKI JAKARTA (B1) --------
-- Sumber: Tabel B1.1 RUPTL PLN 2025-2034
SET @b1 = (SELECT id FROM ruptl_provinsi WHERE kode = 'B1');

INSERT INTO ruptl_penjualan_historis (provinsi_id, tahun, sektor, gwh) VALUES
(@b1,2015,'RUMAH_TANGGA',12324),(@b1,2015,'BISNIS',11209),(@b1,2015,'PUBLIK',2738),(@b1,2015,'INDUSTRI',4234),
(@b1,2016,'RUMAH_TANGGA',12663),(@b1,2016,'BISNIS',10983),(@b1,2016,'PUBLIK',2672),(@b1,2016,'INDUSTRI',4976),
(@b1,2017,'RUMAH_TANGGA',12706),(@b1,2017,'BISNIS',11817),(@b1,2017,'PUBLIK',2799),(@b1,2017,'INDUSTRI',4322),
(@b1,2018,'RUMAH_TANGGA',13199),(@b1,2018,'BISNIS',12170),(@b1,2018,'PUBLIK',2901),(@b1,2018,'INDUSTRI',4509),
(@b1,2019,'RUMAH_TANGGA',13995),(@b1,2019,'BISNIS',12684),(@b1,2019,'PUBLIK',3079),(@b1,2019,'INDUSTRI',4349),
(@b1,2020,'RUMAH_TANGGA',14605),(@b1,2020,'BISNIS',10986),(@b1,2020,'PUBLIK',2772),(@b1,2020,'INDUSTRI',3832),
(@b1,2021,'RUMAH_TANGGA',14725),(@b1,2021,'BISNIS',10995),(@b1,2021,'PUBLIK',2806),(@b1,2021,'INDUSTRI',4184),
(@b1,2022,'RUMAH_TANGGA',14824),(@b1,2022,'BISNIS',12539),(@b1,2022,'PUBLIK',3075),(@b1,2022,'INDUSTRI',4140),
(@b1,2023,'RUMAH_TANGGA',15645),(@b1,2023,'BISNIS',14002),(@b1,2023,'PUBLIK',3349),(@b1,2023,'INDUSTRI',3997),
(@b1,2024,'RUMAH_TANGGA',16051),(@b1,2024,'BISNIS',14384),(@b1,2024,'PUBLIK',3436),(@b1,2024,'INDUSTRI',4101);

-- ============================================================
-- CATATAN: Data provinsi lain (A1-A15, B2, B4-B7, C1-C12)
-- dapat ditambahkan dengan format yang sama mengacu PDF RUPTL.
-- Gunakan SET @kode = (SELECT id FROM ruptl_provinsi WHERE kode = 'XX');
-- lalu INSERT INTO ruptl_penjualan_historis / ruptl_proyeksi_kebutuhan / dll.
-- ============================================================
