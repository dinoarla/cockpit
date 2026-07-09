-- =============================================================
-- PLN SUSTAINABILITY REPORT 2014-2025
-- Schema + Data Insert
-- Sumber: SR-PLN 2014, 2015, 2016, 2017, 2018, 2020, 2021,
--         2022, 2023, 2024, 2025 (PT PLN Persero)
-- Catatan: Data 2019 diambil dari SR-2020 (angka perbandingan)
-- =============================================================

CREATE TABLE IF NOT EXISTS pln_sr_summary (
  id                        SMALLINT      AUTO_INCREMENT PRIMARY KEY,
  year                      SMALLINT      NOT NULL UNIQUE,

  -- B.1 EKONOMI
  production_gwh            DECIMAL(10,2)  COMMENT 'Produksi listrik total (GWh)',
  sales_gwh                 DECIMAL(10,2)  COMMENT 'Penjualan listrik total (GWh)',
  revenue_rp_billion        DECIMAL(12,2)  COMMENT 'Pendapatan usaha (Rp Miliar)',
  net_profit_rp_billion     DECIMAL(12,2)  COMMENT 'Laba/Rugi bersih (Rp Miliar)',
  installed_capacity_mw     INT            COMMENT 'Kapasitas terpasang nasional (MW)',
  customers_million         DECIMAL(7,3)   COMMENT 'Jumlah pelanggan (juta)',
  electrification_pct       DECIMAL(5,2)   COMMENT 'Rasio elektrifikasi nasional (%)',
  network_loss_pct          DECIMAL(5,2)   COMMENT 'Susut jaringan total (%)',
  subsidy_rp_billion        DECIMAL(10,2)  COMMENT 'Subsidi listrik pemerintah (Rp Miliar)',
  ev_generated_rp_billion   DECIMAL(12,2)  COMMENT 'Nilai ekonomi diperoleh - GRI EC1 (Rp Miliar)',
  ev_distributed_rp_billion DECIMAL(12,2)  COMMENT 'Nilai ekonomi didistribusikan - GRI EC1 (Rp Miliar)',
  ev_retained_rp_billion    DECIMAL(12,2)  COMMENT 'Nilai ekonomi ditahan (Rp Miliar)',
  tkdn_pct                  DECIMAL(5,2)   COMMENT 'Tingkat Komponen Dalam Negeri TKDN (%)',
  investment_rp_billion     DECIMAL(12,2)  COMMENT 'Investasi capex (Rp Miliar)',
  ebt_capacity_mw           DECIMAL(8,2)   COMMENT 'Kapasitas EBT/NRE terpasang (MW)',
  ebt_share_pct             DECIMAL(5,2)   COMMENT 'Porsi EBT dari kapasitas terpasang (%)',
  nre_generation_gwh        DECIMAL(10,2)  COMMENT 'Pembangkitan EBT/NRE (GWh)',
  spklu_count               INT            COMMENT 'Jumlah SPKLU (unit)',
  getting_electricity_rank  SMALLINT       COMMENT 'Peringkat Getting Electricity (World Bank)',
  ebitda_rp_billion         DECIMAL(12,2)  COMMENT 'EBITDA (Rp Miliar)',

  -- B.2 LINGKUNGAN
  nonre_energy_gj           BIGINT         COMMENT 'Konsumsi energi non-terbarukan (GJ)',
  re_energy_gj              BIGINT         COMMENT 'Konsumsi energi terbarukan (GJ)',
  energy_intensity_gj_mwh   DECIMAL(8,4)   COMMENT 'Intensitas energi (GJ/MWh)',
  ghg_intensity_tco2_mwh    DECIMAL(7,5)   COMMENT 'Intensitas emisi GRK (tCO2e/MWh)',
  ghg_scope_note            VARCHAR(60)    COMMENT 'Catatan metodologi scope GRK',
  ghg_reduction_tco2        BIGINT         COMMENT 'Penurunan emisi GRK (tCO2e)',
  b3_waste_ton              DECIMAL(12,2)  COMMENT 'Limbah B3 dihasilkan (ton)',
  faba_ton                  DECIMAL(14,2)  COMMENT 'FABA (Fly Ash & Bottom Ash) (ton)',
  trees_planted             INT            COMMENT 'Pohon ditanam (batang)',
  land_rehab_ha             DECIMAL(10,2)  COMMENT 'Rehabilitasi lahan (Ha)',
  proper_gold               TINYINT        COMMENT 'Penilaian PROPER Emas (unit pembangkit)',
  proper_green              TINYINT        COMMENT 'Penilaian PROPER Hijau (unit pembangkit)',
  proper_blue               TINYINT        COMMENT 'Penilaian PROPER Biru (unit pembangkit)',

  -- B.3 SOSIAL
  total_employees           INT            COMMENT 'Total karyawan PLN Holding',
  female_employees          INT            COMMENT 'Karyawan perempuan',
  women_mgmt_pct            DECIMAL(5,2)   COMMENT 'Perempuan dalam manajemen (%)',
  avg_training_hours        DECIMAL(7,2)   COMMENT 'Rata-rata jam pelatihan/karyawan',
  training_cost_rp_billion  DECIMAL(10,2)  COMMENT 'Biaya pelatihan (Rp Miliar)',
  ohs_fatalities            TINYINT        COMMENT 'Korban jiwa kecelakaan kerja',
  ohs_fr                    DECIMAL(8,4)   COMMENT 'Fatality Rate (FR)',
  ohs_sr                    DECIMAL(10,4)  COMMENT 'Severity Rate (SR)',
  saidi                     DECIMAL(10,2)  COMMENT 'SAIDI - menit/pelanggan/tahun',
  saifi                     DECIMAL(7,3)   COMMENT 'SAIFI - kali/pelanggan/tahun',
  csi_pct                   DECIMAL(5,2)   COMMENT 'Indeks Kepuasan Pelanggan (%)',
  csr_rp_million            DECIMAL(12,2)  COMMENT 'Dana CSR/PKBL (Rp Juta)',
  gcg_score                 DECIMAL(5,2)   COMMENT 'Skor Asesmen GCG (BPKP)',

  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='PLN Sustainability Report KPI 2014-2025';

-- =============================================================
-- DATA INSERT
-- NULL = tidak tersedia / tidak dilaporkan pada tahun tersebut
-- =============================================================

INSERT INTO pln_sr_summary
(year,
 production_gwh, sales_gwh, revenue_rp_billion, net_profit_rp_billion,
 installed_capacity_mw, customers_million, electrification_pct, network_loss_pct,
 subsidy_rp_billion, ev_generated_rp_billion, ev_distributed_rp_billion, ev_retained_rp_billion,
 tkdn_pct, investment_rp_billion, ebt_capacity_mw, ebt_share_pct, nre_generation_gwh,
 spklu_count, getting_electricity_rank, ebitda_rp_billion,
 nonre_energy_gj, re_energy_gj, energy_intensity_gj_mwh,
 ghg_intensity_tco2_mwh, ghg_scope_note, ghg_reduction_tco2,
 b3_waste_ton, faba_ton, trees_planted, land_rehab_ha,
 proper_gold, proper_green, proper_blue,
 total_employees, female_employees, women_mgmt_pct, avg_training_hours, training_cost_rp_billion,
 ohs_fatalities, ohs_fr, ohs_sr, saidi, saifi, csi_pct, csr_rp_million, gcg_score)
VALUES

-- 2014 (Sumber: SR-PLN-2015 comparative data)
(2014,
 NULL, 198600.00, NULL, NULL,
 51600, NULL, NULL, NULL,
 99300.00, 295300.00, 300500.00, -5200.00,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL,
 NULL, NULL, NULL,
 NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL, NULL, NULL, 84.62),

-- 2015 (Sumber: SR-PLN-2015)
(2015,
 NULL, 202800.00, NULL, NULL,
 52900, NULL, 88.30, NULL,
 56600.00, 254600.00, 293700.00, -39100.00,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL,
 NULL, NULL, NULL,
 NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 NULL, 2, 47,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL, 88.11, 36850.00, 86.46),

-- 2016 (Sumber: SR-PLN-2017 comparative + SR-PLN-2018 production data)
-- Kapasitas 2016 diturunkan dari SR-2017: 55926/1.0231 ≈ 54666 MW
(2016,
 248611.00, NULL, NULL, NULL,
 54666, NULL, NULL, NULL,
 NULL, 286700.00, 253310.00, 33390.00,
 NULL, NULL, NULL, NULL, NULL,
 NULL, 49, NULL,
 NULL, NULL, NULL,
 NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),

-- 2017 (Sumber: SR-PLN-2017 + SR-PLN-2018 comparative)
(2017,
 254660.00, NULL, NULL, 4430.00,
 55926, 68.070, 95.40, NULL,
 NULL, 302500.00, 271320.00, 31180.00,
 NULL, NULL, NULL, NULL, NULL,
 NULL, 38, NULL,
 NULL, NULL, NULL,
 0.89480, 'Scope 1+2+3', NULL,
 NULL, NULL, NULL, NULL,
 1, 15, 81,
 54820, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL, 88.52, 182800.00, 87.40),

-- 2018 (Sumber: SR-PLN-2018 + SR-PLN-2020 comparative)
(2018,
 267085.00, 234618.00, 272900.00, 11580.00,
 57823, 71.917, 98.30, 9.51,
 48100.00, 334355.00, 308209.00, 26146.00,
 NULL, 115764.00, 7000.00, 12.00, NULL,
 NULL, 33, NULL,
 NULL, NULL, NULL,
 NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 2, 16, 82,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL, NULL, NULL, 87.96),

-- 2019 (Sumber: SR-PLN-2020 comparative data)
(2019,
 278942.00, 245518.00, 282990.00, 4320.00,
 62833, 75.706, 98.30, 9.32,
 51710.00, 369561.00, 330815.00, 38746.00,
 NULL, 103787.00, NULL, NULL, NULL,
 NULL, 33, NULL,
 NULL, NULL, NULL,
 NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),

-- 2020 (Sumber: SR-PLN-2020 + SR-PLN-2022 KPI)
(2020,
 274851.00, 243583.00, 345400.00, 5990.00,
 63336, 79.000, 99.20, 9.15,
 47980.00, 338903.00, 295834.00, 43069.00,
 40.13, 73860.00, NULL, NULL, NULL,
 NULL, 33, 86690.00,
 1582607099, 23250135, 6695.7100,
 0.82000, 'Scope 1+2+3', NULL,
 90775.00, NULL, 135644, NULL,
 4, 19, NULL,
 NULL, 8504, 14.16, NULL, 255.90,
 23, 0.0600, 371.0000, 763.13, 9.250, 90.75, 251178.00, 89.559),

-- 2021 (Sumber: SR-PLN-2021 + SR-PLN-2022)
(2021,
 289470.00, 257630.00, 366900.00, 13170.00,
 64553, 82.500, 99.45, NULL,
 NULL, 373666.00, 315336.00, 58330.00,
 48.88, NULL, 8208.00, NULL, 37863.00,
 119, NULL, 93900.00,
 1647432126, 29181431, 6605.8400,
 0.84000, 'Scope 1+2+3', 2160249,
 98491.00, 878933.00, 431430, 237.90,
 8, 20, NULL,
 NULL, 8351, 13.82, 124.00, 182.00,
 13, 0.0300, 178.0000, 540.12, 6.700, 95.17, 835829.00, 90.456),

-- 2022 (Sumber: SR-PLN-2022 + SR-PLN-2023)
-- Catatan: GHG berubah metodologi ke Scope 1 only mulai 2022
(2022,
 308000.00, 273760.00, 441100.00, 14410.00,
 69040, 85.600, 99.63, NULL,
 NULL, 425705.00, 367250.00, 58455.00,
 48.51, NULL, 8524.00, NULL, 42959.00,
 570, NULL, 84740.00,
 1656846571, 37095238, 6297.8700,
 0.79700, 'Scope 1 only', 6043549,
 177868.00, 2240991.00, 1478734, 258.87,
 15, 18, NULL,
 NULL, 8327, 14.71, 81.00, 529.30,
 10, 0.0230, 139.0000, 463.20, 5.620, 97.41, 850804.00, 90.026),

-- 2023 (Sumber: SR-PLN-2023 + SR-PLN-2024)
(2023,
 323320.00, 288440.00, 487400.00, 22070.00,
 NULL, NULL, NULL, NULL,
 NULL, 495315.00, 424040.00, 71275.00,
 47.09, NULL, 8790.00, NULL, 41989.00,
 624, NULL, NULL,
 1677068528, 48787114, 6024.9200,
 0.77000, 'Scope 1 only', 9705182,
 294964.00, 3715646.00, 732503, 835.29,
 20, 19, NULL,
 NULL, 8070, 15.15, 86.00, 1157.90,
 15, 0.0650, 388.4400, 338.13, 4.270, 98.02, 852357.00, NULL),

-- 2024 (Sumber: SR-PLN-2024 + SR-PLN-2025)
(2024,
 343890.00, 306220.00, 545400.00, 17760.00,
 NULL, NULL, NULL, NULL,
 NULL, 542952.00, 448397.00, 94555.00,
 53.90, NULL, 8801.00, NULL, 44717.00,
 3233, NULL, NULL,
 1782774610, 64793688, 6045.2400,
 0.77400, 'Scope 1 only', 12773047,
 475339.00, 3456974.00, 1029327, 1168.08,
 24, 18, NULL,
 NULL, 8084, 16.19, 85.62, 1042.65,
 6, 0.0210, 128.6700, 320.24, 3.230, 98.93, 597020.00, NULL),

-- 2025 (Sumber: SR-PLN-2025)
(2025,
 354930.00, 317690.00, 582700.00, 7261.00,
 NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL,
 53.73, NULL, 9386.00, NULL, 49785.00,
 4655, NULL, NULL,
 1908311731, 82752201, 6384.8700,
 0.78700, 'Scope 1 only', 51051671,
 290960.00, 2508984.00, 520000, 1032.79,
 11, 35, NULL,
 NULL, 7906, 15.91, 105.49, NULL,
 9, NULL, NULL, 262.28, 3.140, 99.15, 762539.00, NULL);

-- =============================================================
-- REGISTRASI MODUL di domain_modules
-- Jalankan SETELAH tabel pln_sr_summary terisi
-- Ganti url_token dengan string acak 12 karakter jika perlu
-- =============================================================
INSERT INTO domain_modules (domain_id, nama, slug, route_path, sensitivitas, url_token, status)
SELECT
    d.id,
    'PLN Sustainability Report 2014–2025',
    'pln-sr',
    '/modules/energi-jabar/pln-sr/',
    'biasa',
    LOWER(SUBSTRING(REPLACE(UUID(),'-',''), 1, 12)),
    'active'
FROM domains d
WHERE d.slug = 'energi-jabar'
LIMIT 1
ON DUPLICATE KEY UPDATE
    nama   = VALUES(nama),
    status = VALUES(status);
