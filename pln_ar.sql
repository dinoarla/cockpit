-- ============================================================
-- PLN ANNUAL REPORT 2025 — Schema & Data
-- Sumber: Laporan Tahunan PT PLN (Persero) 2025
-- Auditor: KAP Rintis, Jumadi, Rianto & Rekan (PwC network)
-- Opini: Wajar Tanpa Pengecualian
-- ============================================================

-- 1. LAPORAN KEUANGAN KONSOLIDASIAN (2021-2025)
-- Nilai dalam juta Rupiah
CREATE TABLE IF NOT EXISTS pln_ar_financial (
  id INT AUTO_INCREMENT PRIMARY KEY,
  year INT NOT NULL UNIQUE,
  -- Neraca
  total_assets BIGINT,
  noncurrent_assets BIGINT,
  current_assets BIGINT,
  total_equity BIGINT,
  total_liabilities BIGINT,
  noncurrent_liabilities BIGINT,
  current_liabilities BIGINT,
  -- Laba Rugi
  revenue BIGINT,
  electricity_sales BIGINT,
  customer_conn_fees BIGINT,
  govt_subsidy BIGINT,
  compensation_income BIGINT,
  other_revenue BIGINT,
  total_opex BIGINT,
  operating_profit BIGINT,
  finance_income BIGINT,
  finance_costs BIGINT,
  fx_gain_loss BIGINT,
  other_income_net BIGINT,
  profit_before_tax BIGINT,
  income_tax BIGINT,
  profit_for_year BIGINT,
  other_comprehensive_income BIGINT,
  total_comprehensive_income BIGINT,
  eps_rupiah DECIMAL(10,3),
  -- Arus Kas
  op_cashflow BIGINT,
  inv_cashflow BIGINT,
  fin_cashflow BIGINT,
  cash_end BIGINT
);

INSERT INTO pln_ar_financial
(year, total_assets, noncurrent_assets, current_assets, total_equity, total_liabilities, noncurrent_liabilities, current_liabilities,
 revenue, electricity_sales, customer_conn_fees, govt_subsidy, compensation_income, other_revenue,
 total_opex, operating_profit, finance_income, finance_costs, fx_gain_loss, other_income_net,
 profit_before_tax, income_tax, profit_for_year, other_comprehensive_income, total_comprehensive_income, eps_rupiah,
 op_cashflow, inv_cashflow, fin_cashflow, cash_end)
VALUES
(2021, 1613216456, 1527305081, 85911375, 981607123, 631609333, 485070853, 146538480,
 368174270, 288862726, 493437, 49796949, 24594425, 4426733,
 323119125, 45055145, 787231, -20375755, 2676145, -4921682,
 23221084, -10046207, 13174877, 24007703, 37182580, 96.972,
 68621074, -59552028, -25880660, 37968399),
(2022, 1638139276, 1518747894, 119391382, 991450566, 646688710, 501617259, 145071451,
 441131943, 311057224, 857468, 58831960, 63649821, 6735470,
 386193802, 54938141, 687495, -17135165, -19790474, 2841675,
 21541672, -7126952, 14414720, -9006358, 5408362, 99.339,
 97710224, -54763962, -30092064, 51503096),
(2023, 1670639704, 1539256218, 131383486, 1020068374, 650571330, 507375897, 143195433,
 487384064, 333191062, 1288284, 68636731, 73991897, 10276090,
 440183990, 47200074, 953515, -21010355, 3723639, 1513051,
 32379924, -10308466, 22071458, 4297375, 26368833, 149.874,
 87389971, -65667486, -17029832, 55920541),
(2024, 1772375266, 1604928877, 167446389, 1069065470, 703309796, 531257713, 172052083,
 545380993, 353176020, 1746004, 77045335, 100184044, 13229590,
 484759987, 60621006, 976269, -24417860, -6780398, -2129058,
 28269959, -7038675, 21231284, 30855816, 52087100, 117.613,
 75359028, -62441438, -7830344, 61364446),
(2025, 1837409908, 1612008596, 225401312, 1064207613, 773202295, 569171840, 204030455,
 582681870, 367087729, 2242310, 87460664, 112734817, 13156350,
 533455857, 49226013, 673712, -24869532, -12462188, 424644,
 12992649, -5731941, 7260708, -8767213, -1506505, 46.599,
 9915032, -62169715, 32862593, 42204282);

-- 2. RASIO KEUANGAN (2021-2025)
CREATE TABLE IF NOT EXISTS pln_ar_ratios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  year INT NOT NULL UNIQUE,
  -- Likuiditas
  current_ratio DECIMAL(6,2),
  cash_ratio DECIMAL(6,2),
  -- Solvabilitas
  liab_to_assets DECIMAL(6,2),
  liab_to_equity DECIMAL(6,2),
  debt_to_equity DECIMAL(6,2),
  ebitda_to_interest DECIMAL(8,2),
  -- Profitabilitas
  roa DECIMAL(6,2),
  roe DECIMAL(6,2),
  op_profit_margin DECIMAL(6,2),
  net_profit_margin DECIMAL(6,2),
  ebitda_margin DECIMAL(6,2),
  -- Operasional
  receivable_turnover DECIMAL(6,2),
  collection_period DECIMAL(6,2),
  fixed_asset_turnover DECIMAL(6,2)
);

INSERT INTO pln_ar_ratios
(year, current_ratio, cash_ratio, liab_to_assets, liab_to_equity, debt_to_equity, ebitda_to_interest,
 roa, roe, op_profit_margin, net_profit_margin, ebitda_margin,
 receivable_turnover, collection_period, fixed_asset_turnover)
VALUES
(2021, 58.63, 26.11, 39.15, 64.34, 42.71, 448.67, 0.82, 1.34, 11.95, 3.58, 24.91, 12.82, 28.48, 0.20),
(2022, 82.30, 35.87, 39.48, 65.23, 41.32, 485.85, 0.88, 1.45, 12.45, 3.27, 18.87, 12.81, 28.49, 0.22),
(2023, 91.75, 39.69, 38.94, 63.78, 39.01, 486.90, 1.32, 2.16,  9.68, 4.53, 20.99, 12.91, 28.26, 0.23),
(2024, 97.32, 36.24, 39.68, 65.79, 38.02, 445.01, 1.20, 1.99, 11.12, 3.89, 19.92, 12.96, 28.23, 0.24),
(2025,110.47, 20.70, 42.08, 72.66, 42.30, 381.58, 0.40, 0.68,  8.45, 1.25, 16.29, 12.87, 28.35, 0.24);

-- 3. KINERJA OPERASIONAL (2021-2025)
-- catatan: data lengkap hanya 2025, tahun lain dari ikhtisar AR
CREATE TABLE IF NOT EXISTS pln_ar_operational (
  id INT AUTO_INCREMENT PRIMARY KEY,
  year INT NOT NULL UNIQUE,
  production_gwh DECIMAL(12,2),
  sales_gwh DECIMAL(12,2),
  installed_capacity_mw DECIMAL(10,2),
  num_gen_units INT,
  distribution_km INT,
  transmission_km INT,
  additional_connected_mva INT,
  network_losses_pct DECIMAL(5,2),
  csi DECIMAL(5,2),
  new_customers INT,
  saidi_min DECIMAL(8,2),
  saifi_times DECIMAL(6,2),
  training_cost_bn DECIMAL(8,2),
  kpi_score DECIMAL(6,2)
);

INSERT INTO pln_ar_operational
(year, production_gwh, sales_gwh, installed_capacity_mw, num_gen_units,
 distribution_km, transmission_km, additional_connected_mva,
 network_losses_pct, csi, new_customers, saidi_min, saifi_times, training_cost_bn, kpi_score)
VALUES
(2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 95.17, NULL, NULL, NULL, 182.00, 107.49),
(2022, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 97.41, NULL, NULL, NULL, 670.15, 101.92),
(2023, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 98.02, NULL, NULL, NULL, 1157.90, 107.19),
(2024, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 98.93, NULL, NULL, NULL, 1042.65, 103.97),
(2025, 349884.00, 317692.00, 80189.32, 6649, 1086835, 74973, 10594, 8.19, 99.15, 3296942, 262.28, 3.14, 760.20, 100.19);

-- 4. BEBAN USAHA DETAIL (2023-2025, dalam juta Rupiah)
CREATE TABLE IF NOT EXISTS pln_ar_opex_detail (
  id INT AUTO_INCREMENT PRIMARY KEY,
  year INT NOT NULL,
  category VARCHAR(60) NOT NULL,
  amount BIGINT NOT NULL
);

INSERT INTO pln_ar_opex_detail (year, category, amount) VALUES
(2023, 'Bahan Bakar & Pelumas', 164731578),
(2023, 'Pembelian Tenaga Listrik', 154831184),
(2023, 'Kepegawaian', 32355934),
(2023, 'Penyusutan Aset Tetap', 43967082),
(2023, 'Pemeliharaan', 29518324),
(2023, 'Penyusutan Aset Hak Guna', 3347165),
(2023, 'Sewa', 1874862),
(2023, 'Lain-lain', 9557861),
(2024, 'Bahan Bakar & Pelumas', 179290971),
(2024, 'Pembelian Tenaga Listrik', 178626777),
(2024, 'Kepegawaian', 30709373),
(2024, 'Penyusutan Aset Tetap', 46672799),
(2024, 'Pemeliharaan', 31546011),
(2024, 'Penyusutan Aset Hak Guna', 3822214),
(2024, 'Sewa', 2607032),
(2024, 'Lain-lain', 11484810),
(2025, 'Bahan Bakar & Pelumas', 198611362),
(2025, 'Pembelian Tenaga Listrik', 195214313),
(2025, 'Kepegawaian', 36015779),
(2025, 'Penyusutan Aset Tetap', 50265222),
(2025, 'Pemeliharaan', 35741226),
(2025, 'Penyusutan Aset Hak Guna', 3103408),
(2025, 'Sewa', 2829003),
(2025, 'Lain-lain', 11675544);

-- 5. INVESTASI BARANG MODAL / CAPEX (2023-2025, dalam juta Rupiah)
CREATE TABLE IF NOT EXISTS pln_ar_capex (
  id INT AUTO_INCREMENT PRIMARY KEY,
  year INT NOT NULL,
  category VARCHAR(80) NOT NULL,
  amount BIGINT NOT NULL
);

INSERT INTO pln_ar_capex (year, category, amount) VALUES
(2023, 'Pembangunan Pembangkit', 11496640),
(2023, 'Maintenance CAPEX', 15583057),
(2023, 'Penyambungan Pelanggan', 8645442),
(2023, 'Pengembangan Jaringan Distribusi', 11426695),
(2023, 'Pengembangan Transmisi & Gardu Induk', 13778429),
(2023, 'Infrastruktur Gas', 23741),
(2023, 'Infrastruktur Energi Primer', 617399),
(2023, 'Sarana & Fasilitas', 1755435),
(2023, 'Internet Data Center', 1455651),
(2024, 'Pembangunan Pembangkit', 10353207),
(2024, 'Maintenance CAPEX', 12439889),
(2024, 'Penyambungan Pelanggan', 12528573),
(2024, 'Pengembangan Jaringan Distribusi', 12685144),
(2024, 'Pengembangan Transmisi & Gardu Induk', 12269299),
(2024, 'Infrastruktur Gas', 112932),
(2024, 'Infrastruktur Energi Primer', 754529),
(2024, 'Sarana & Fasilitas', 4338924),
(2024, 'Internet Data Center', 1573236),
(2025, 'Pembangunan Pembangkit', 6005609),
(2025, 'Maintenance CAPEX', 16670001),
(2025, 'Penyambungan Pelanggan', 14738265),
(2025, 'Pengembangan Jaringan Distribusi', 10991187),
(2025, 'Pengembangan Transmisi & Gardu Induk', 10468710),
(2025, 'Infrastruktur Gas', 339299),
(2025, 'Infrastruktur Energi Primer', 499859),
(2025, 'Sarana & Fasilitas', 6724192),
(2025, 'Internet Data Center', 2677048);

-- 6. PROYEKSI PERMINTAAN LISTRIK 2025-2034 (RUPTL 2025-2034)
CREATE TABLE IF NOT EXISTS pln_ar_demand_forecast (
  id INT AUTO_INCREMENT PRIMARY KEY,
  year INT NOT NULL UNIQUE,
  sales_twh DECIMAL(6,1) NOT NULL,
  growth_pct DECIMAL(5,2) NOT NULL
);

INSERT INTO pln_ar_demand_forecast (year, sales_twh, growth_pct) VALUES
(2025, 323.0, 5.53),
(2026, 340.0, 5.24),
(2027, 360.0, 5.93),
(2028, 378.0, 4.98),
(2029, 396.0, 4.66),
(2030, 416.0, 5.01),
(2031, 440.0, 5.84),
(2032, 468.0, 6.25),
(2033, 492.0, 5.12),
(2034, 518.0, 5.01);

-- 7. PENCAPAIAN KPI 2025
CREATE TABLE IF NOT EXISTS pln_ar_kpi (
  id INT AUTO_INCREMENT PRIMARY KEY,
  kpi_no INT NOT NULL,
  category VARCHAR(40) NOT NULL,
  name_id VARCHAR(120) NOT NULL,
  name_en VARCHAR(120),
  weight INT NOT NULL,
  unit VARCHAR(30),
  target VARCHAR(60),
  realization VARCHAR(60),
  achievement_pct DECIMAL(6,2),
  value DECIMAL(8,2)
);

INSERT INTO pln_ar_kpi (kpi_no, category, name_id, name_en, weight, unit, target, realization, achievement_pct, value) VALUES
(1,  'Finansial',    'EBITDA', 'EBITDA', 9, 'Rp Triliun', '114,00', '94,89', 83.23, 7.49),
(2,  'Finansial',    'ROIC – WACC', 'ROIC – WACC', 5, '%', '-1,17', '-2,01', 28.27, 1.41),
(3,  'Finansial',    'Penyelesaian Laporan Keuangan Audit 2024', 'Submission of 2024 Audited Financials', 5, 'Hari Kerja', '5 (SA600)', '5,00', 100.00, 5.00),
(4,  'Operasional',  'Distribution Efficiency Rate (Susut Jaringan)', 'Distribution Efficiency Rate', 6, '%', '8,62', '8,19', 104.98, 6.29),
(5,  'Operasional',  'Optimalisasi Kesiapan Pasokan Pembangkit', 'Power Generation Supply Readiness', 8, '%', '80,00', '82,50', 103.11, 8.24),
(6,  'Sosial',       'Penyelesaian Program Dedieselisasi & Gasifikasi', 'Diesel Phase-Out & Gasification Program', 7, '%', '100%', '109,09%', 109.09, 7.63),
(7,  'Sosial',       'Rating ESG', 'ESG Rating', 7, 'Skor', '28 atau BB', '25,90', 107.50, 7.52),
(9,  'Inovasi Bisnis','Peningkatan Pendapatan Beyond-kWh', 'Beyond-kWh Revenue Growth', 6, 'Rp Triliun', '14,59', '13,15', 90.13, 5.40),
(10, 'Inovasi Bisnis','Jumlah Transaksi melalui PLN Mobile', 'PLN Mobile Transactions', 6, 'Juta Transaksi', '22,90', '33,62', 110.00, 6.60),
(11, 'Teknologi',    'SAIDI', 'System Average Interruption Duration Index', 7, 'Menit/Pelanggan', '322,80', '262,28', 110.00, 7.70),
(12, 'Teknologi',    'SAIFI', 'System Average Interruption Frequency Index', 7, 'Kali/Pelanggan', '3,50', '3,14', 110.00, 7.70),
(13, 'Investasi',    'Penyelesaian Pembangunan Pembangkit & Transmisi', 'Power Plant & Transmission Completion', 10, '%', '100% RKAP', '110%', 110.00, 11.00),
(14, 'Talenta',      'Talent Diversity (Milenial & Perempuan)', 'Talent Diversity (Millennials & Women)', 6, '%', 'Milenial=15%; Wanita=20%', 'Milenial=18,18%; Wanita=30,30%', 110.00, 6.60),
(15, 'Talenta',      'Lost Time Injury Frequency Rate', 'Lost Time Injury Frequency Rate', 6, 'Indeks/juta jam kerja', '0,136', '0,048', 110.00, 6.60);
