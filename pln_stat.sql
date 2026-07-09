-- =============================================================
-- PLN STATISTICS MODULE  (2014-2025)
-- Sumber: PLN Statistics Book, Edisi 2014 s/d 2025
-- Data: nasional (Indonesia), annual
-- =============================================================

CREATE TABLE IF NOT EXISTS `pln_stat_national` (
  `id`                         INT NOT NULL AUTO_INCREMENT,
  `year`                       INT NOT NULL,

  -- Pembangkitan / Generation (Kapasitas)
  `installed_capacity_pln_mw`   DECIMAL(12,2) DEFAULT NULL,  -- Kapasitas terpasang PLN only
  `installed_capacity_total_mw` DECIMAL(12,2) DEFAULT NULL,  -- Nasional incl. IPP+Sewa
  `rated_capacity_pln_mw`       DECIMAL(12,2) DEFAULT NULL,  -- Daya mampu PLN
  `peak_load_mw`                DECIMAL(12,2) DEFAULT NULL,  -- Beban puncak sistem
  `plants_total`                INT           DEFAULT NULL,  -- Jumlah unit pembangkit PLN

  -- Faktor Operasi
  `load_factor_pct`             DECIMAL(6,2)  DEFAULT NULL,
  `capacity_factor_pct`         DECIMAL(6,2)  DEFAULT NULL,
  `demand_factor_pct`           DECIMAL(6,2)  DEFAULT NULL,

  -- Produksi Energi per Jenis Pembangkit (GWh)
  `prod_hydro_gwh`              DECIMAL(12,2) DEFAULT NULL,  -- PLTA+PLTM+PLTMH
  `prod_steam_gwh`              DECIMAL(12,2) DEFAULT NULL,  -- PLTU (batubara)
  `prod_gas_gwh`                DECIMAL(12,2) DEFAULT NULL,  -- PLTG+PLTGU
  `prod_geo_gwh`                DECIMAL(12,2) DEFAULT NULL,  -- PLTP (panas bumi)
  `prod_diesel_gwh`             DECIMAL(12,2) DEFAULT NULL,  -- PLTD+PLTMG
  `prod_renewable_gwh`          DECIMAL(12,2) DEFAULT NULL,  -- PLTS+Bayu+Biomasa
  `prod_leased_gwh`             DECIMAL(12,2) DEFAULT NULL,  -- Sewa genset
  `prod_pln_own_gwh`            DECIMAL(12,2) DEFAULT NULL,  -- Sub-total PLN (termasuk sewa)
  `prod_purchased_gwh`          DECIMAL(12,2) DEFAULT NULL,  -- Beli dari luar PLN / IPP
  `prod_total_gwh`              DECIMAL(12,2) DEFAULT NULL,  -- Grand total

  -- Pemakaian Sendiri & Susut Energi
  `own_use_gwh`                 DECIMAL(10,2) DEFAULT NULL,
  `own_use_pct`                 DECIMAL(5,2)  DEFAULT NULL,
  `loss_transmission_gwh`       DECIMAL(10,2) DEFAULT NULL,
  `loss_transmission_pct`       DECIMAL(5,2)  DEFAULT NULL,
  `loss_distribution_gwh`       DECIMAL(10,2) DEFAULT NULL,
  `loss_distribution_pct`       DECIMAL(5,2)  DEFAULT NULL,
  `loss_total_gwh`              DECIMAL(10,2) DEFAULT NULL,
  `loss_total_pct`              DECIMAL(5,2)  DEFAULT NULL,

  -- Pelanggan / Customers
  `cust_household`              BIGINT        DEFAULT NULL,
  `cust_industry`               INT           DEFAULT NULL,
  `cust_business`               INT           DEFAULT NULL,
  `cust_social`                 INT           DEFAULT NULL,
  `cust_gov`                    INT           DEFAULT NULL,
  `cust_street`                 INT           DEFAULT NULL,
  `cust_others`                 INT           DEFAULT NULL,
  `cust_total`                  BIGINT        DEFAULT NULL,

  -- Daya Tersambung / Connected Capacity (MVA)
  `conn_household_mva`          DECIMAL(12,2) DEFAULT NULL,
  `conn_industry_mva`           DECIMAL(12,2) DEFAULT NULL,
  `conn_business_mva`           DECIMAL(12,2) DEFAULT NULL,
  `conn_total_mva`              DECIMAL(12,2) DEFAULT NULL,

  -- Energi Terjual / Energy Sold (GWh)
  `sold_household_gwh`          DECIMAL(12,2) DEFAULT NULL,
  `sold_industry_gwh`           DECIMAL(12,2) DEFAULT NULL,
  `sold_business_gwh`           DECIMAL(12,2) DEFAULT NULL,
  `sold_social_gwh`             DECIMAL(12,2) DEFAULT NULL,
  `sold_gov_gwh`                DECIMAL(12,2) DEFAULT NULL,
  `sold_street_gwh`             DECIMAL(12,2) DEFAULT NULL,
  `sold_others_gwh`             DECIMAL(12,2) DEFAULT NULL,
  `sold_total_gwh`              DECIMAL(12,2) DEFAULT NULL,

  -- Pendapatan / Revenue (juta Rp / million Rp)
  `rev_household_mrp`           DECIMAL(18,2) DEFAULT NULL,
  `rev_industry_mrp`            DECIMAL(18,2) DEFAULT NULL,
  `rev_business_mrp`            DECIMAL(18,2) DEFAULT NULL,
  `rev_total_mrp`               DECIMAL(18,2) DEFAULT NULL,

  -- Tarif Rata-rata / Average Tariff (Rp/kWh)
  `tariff_avg_rp_kwh`           DECIMAL(10,2) DEFAULT NULL,
  `tariff_household_rp_kwh`     DECIMAL(10,2) DEFAULT NULL,
  `tariff_industry_rp_kwh`      DECIMAL(10,2) DEFAULT NULL,
  `tariff_business_rp_kwh`      DECIMAL(10,2) DEFAULT NULL,

  -- Elektrifikasi
  `electrification_ratio_pct`   DECIMAL(5,2)  DEFAULT NULL,

  -- Konsumsi Bahan Bakar
  `fuel_coal_ton`               BIGINT        DEFAULT NULL,   -- ton
  `fuel_gas_mmscf`              DECIMAL(12,2) DEFAULT NULL,   -- MMSCF

  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_pln_stat_year` (`year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================
-- DATA 2014  (sumber: PLN Statistics 2014 — Summary, Tables 1-27)
-- =============================================================
INSERT INTO `pln_stat_national`
  (`year`,
   `installed_capacity_pln_mw`, `installed_capacity_total_mw`, `rated_capacity_pln_mw`,
   `peak_load_mw`, `plants_total`,
   `load_factor_pct`, `capacity_factor_pct`, `demand_factor_pct`,
   `prod_hydro_gwh`, `prod_steam_gwh`, `prod_gas_gwh`, `prod_geo_gwh`, `prod_diesel_gwh`,
   `prod_renewable_gwh`, `prod_leased_gwh`, `prod_pln_own_gwh`, `prod_purchased_gwh`, `prod_total_gwh`,
   `own_use_gwh`, `own_use_pct`,
   `loss_transmission_gwh`, `loss_transmission_pct`,
   `loss_distribution_gwh`, `loss_distribution_pct`,
   `loss_total_gwh`, `loss_total_pct`,
   `cust_household`, `cust_industry`, `cust_business`, `cust_social`,
   `cust_gov`, `cust_street`, `cust_others`, `cust_total`,
   `conn_household_mva`, `conn_industry_mva`, `conn_business_mva`, `conn_total_mva`,
   `sold_household_gwh`, `sold_industry_gwh`, `sold_business_gwh`,
   `sold_social_gwh`, `sold_gov_gwh`, `sold_street_gwh`, `sold_others_gwh`, `sold_total_gwh`,
   `rev_household_mrp`, `rev_industry_mrp`, `rev_business_mrp`, `rev_total_mrp`,
   `tariff_avg_rp_kwh`, `tariff_household_rp_kwh`, `tariff_industry_rp_kwh`, `tariff_business_rp_kwh`,
   `electrification_ratio_pct`, `fuel_coal_ton`, `fuel_gas_mmscf`)
VALUES
  (2014,
   39257.53, 51620.58, NULL,
   33321.15, 5007,
   NULL, NULL, NULL,
   11163.62, 84076.12, 49193.48, 4285.37, 26433.18,
   NULL, NULL, 175296.98, 53257.93, 228554.91,
   NULL, NULL,
   NULL, 2.37,
   NULL, 7.52,
   NULL, 9.71,
   NULL, NULL, NULL, NULL,
   NULL, NULL, NULL, 57493234,
   NULL, NULL, NULL, NULL,
   84086.46, 65908.68, 36282.42,
   NULL, NULL, NULL, 12324.21, 198601.78,
   NULL, NULL, NULL, NULL,
   939.74, NULL, NULL, NULL,
   81.70, NULL, NULL);

-- =============================================================
-- DATA 2015  (sumber: PLN Statistics 2015 — Summary, Tables 1-27)
-- =============================================================
INSERT INTO `pln_stat_national`
  (`year`,
   `installed_capacity_pln_mw`, `installed_capacity_total_mw`, `rated_capacity_pln_mw`,
   `peak_load_mw`, `plants_total`,
   `load_factor_pct`, `capacity_factor_pct`, `demand_factor_pct`,
   `prod_hydro_gwh`, `prod_steam_gwh`, `prod_gas_gwh`, `prod_geo_gwh`, `prod_diesel_gwh`,
   `prod_renewable_gwh`, `prod_leased_gwh`, `prod_pln_own_gwh`, `prod_purchased_gwh`, `prod_total_gwh`,
   `own_use_gwh`, `own_use_pct`,
   `loss_transmission_gwh`, `loss_transmission_pct`,
   `loss_distribution_gwh`, `loss_distribution_pct`,
   `loss_total_gwh`, `loss_total_pct`,
   `cust_household`, `cust_industry`, `cust_business`, `cust_social`,
   `cust_gov`, `cust_street`, `cust_others`, `cust_total`,
   `conn_household_mva`, `conn_industry_mva`, `conn_business_mva`, `conn_total_mva`,
   `sold_household_gwh`, `sold_industry_gwh`, `sold_business_gwh`,
   `sold_social_gwh`, `sold_gov_gwh`, `sold_street_gwh`, `sold_others_gwh`, `sold_total_gwh`,
   `rev_household_mrp`, `rev_industry_mrp`, `rev_business_mrp`, `rev_total_mrp`,
   `tariff_avg_rp_kwh`, `tariff_household_rp_kwh`, `tariff_industry_rp_kwh`, `tariff_business_rp_kwh`,
   `electrification_ratio_pct`, `fuel_coal_ton`, `fuel_gas_mmscf`)
VALUES
  (2015,
   40265.26, 52859.29, NULL,
   33381.08, 5218,
   NULL, NULL, NULL,
   10004.86, 91041.86, 51358.66, 4391.55, 19017.36,
   657.94, NULL, 176472.21, 57509.77, 233981.99,
   NULL, NULL,
   NULL, 2.33,
   NULL, 7.63,
   NULL, 9.77,
   NULL, NULL, NULL, NULL,
   NULL, NULL, NULL, 61167980,
   NULL, NULL, NULL, NULL,
   88682.13, 64079.39, 36978.05,
   NULL, NULL, NULL, 13106.25, 202845.82,
   NULL, NULL, NULL, NULL,
   1034.50, NULL, NULL, NULL,
   86.20, NULL, NULL);

-- =============================================================
-- DATA 2016-2025  (sumber: PLN Statistics 2025 — Time Series T43-T58)
-- =============================================================
INSERT INTO `pln_stat_national`
  (`year`,
   `installed_capacity_pln_mw`, `installed_capacity_total_mw`, `rated_capacity_pln_mw`,
   `peak_load_mw`, `plants_total`,
   `load_factor_pct`, `capacity_factor_pct`, `demand_factor_pct`,
   `prod_hydro_gwh`, `prod_steam_gwh`, `prod_gas_gwh`, `prod_geo_gwh`, `prod_diesel_gwh`,
   `prod_renewable_gwh`, `prod_leased_gwh`, `prod_pln_own_gwh`, `prod_purchased_gwh`, `prod_total_gwh`,
   `own_use_gwh`, `own_use_pct`,
   `loss_transmission_gwh`, `loss_transmission_pct`,
   `loss_distribution_gwh`, `loss_distribution_pct`,
   `loss_total_gwh`, `loss_total_pct`,
   `cust_household`, `cust_industry`, `cust_business`, `cust_social`,
   `cust_gov`, `cust_street`, `cust_others`, `cust_total`,
   `conn_household_mva`, `conn_industry_mva`, `conn_business_mva`, `conn_total_mva`,
   `sold_household_gwh`, `sold_industry_gwh`, `sold_business_gwh`,
   `sold_social_gwh`, `sold_gov_gwh`, `sold_street_gwh`, `sold_others_gwh`, `sold_total_gwh`,
   `rev_household_mrp`, `rev_industry_mrp`, `rev_business_mrp`, `rev_total_mrp`,
   `tariff_avg_rp_kwh`, `tariff_household_rp_kwh`, `tariff_industry_rp_kwh`, `tariff_business_rp_kwh`,
   `electrification_ratio_pct`, `fuel_coal_ton`, `fuel_gas_mmscf`)
VALUES
-- 2016
  (2016,
   39785.06, NULL, 34471.39,
   NULL, 5235,
   62.62, 51.92, 49.55,
   13885.59, 97153.33, 45779.87, 3958.10, 5674.71,
   5.85, 17351.52, 183808.97, 64801.55, 248610.52,
   9060.67, 4.93,
   5486.54, 2.29,
   17219.45, 7.19,
   23358.90, 9.75,
   59243672, 69629, 3239764, 1354010,
   169478, 205940, NULL, 64282493,
   55284.60, 26569.81, 24362.27, 114347.62,
   93634.61, 68145.30, 40074.39,
   6630.80, 4021.61, 3497.58, NULL, 216004.29,
   79001584.00, 71676300.00, 48135789.00, 214139821.00,
   991.37, 843.72, 1051.82, 1201.16,
   NULL, 50556446, 505125.00),
-- 2017
  (2017,
   39651.80, NULL, 33931.83,
   NULL, 5389,
   74.93, 51.98, 39.75,
   12425.17, 105651.39, 39966.02, 4095.99, 5833.76,
   5.53, 13447.20, 181425.07, 73234.72, 254659.78,
   9233.26, 5.50,
   5865.60, 2.39,
   15619.45, 6.53,
   22147.47, 9.02,
   62543434, 76816, 3579364, 1460546,
   182874, 225249, NULL, 68068283,
   59257.37, 27584.67, 26197.72, 122017.63,
   94457.38, 72238.37, 41694.79,
   7095.37, 4121.26, 3526.55, NULL, 223133.72,
   99747380.00, 78652788.00, 51935757.00, 246586856.00,
   1105.11, 1056.00, 1088.80, 1245.62,
   NULL, 54711847, 447072.00),
-- 2018
  (2018,
   41696.67, NULL, 35452.44,
   NULL, 5980,
   78.64, 52.73, 37.20,
   10728.68, 113902.01, 41972.33, 4012.81, 7573.83,
   4.21, 10504.60, 188696.46, 78386.92, 267083.38,
   9616.42, 5.10,
   5969.98, 2.32,
   18510.36, 7.37,
   25093.26, 9.75,
   66071133, 88185, 3750666, 1559997,
   198113, 249303, NULL, 71917397,
   63576.71, 29136.29, 27751.75, 130280.55,
   97832.28, 76946.50, 44027.40,
   7781.34, 4403.28, 3627.07, NULL, 234617.88,
   107853456.00, 83510376.00, 54769851.00, 263477551.00,
   1123.01, 1102.43, 1085.30, 1243.99,
   NULL, 60481245, 465419.00),
-- 2019
  (2019,
   43856.58, NULL, 36920.09,
   NULL, 5987,
   76.41, 50.68, 37.72,
   9877.06, 122826.04, 40480.88, 4110.30, 9158.22,
   4.71, 7086.09, 193543.32, 85398.55, 278941.07,
   9910.95, 5.12,
   6073.34, 2.26,
   19006.53, 7.24,
   25822.86, 9.60,
   69619877, 104922, 3829553, 1662926,
   211947, 276389, NULL, 75705614,
   67877.52, 30433.91, 29180.45, 138076.53,
   103733.43, 77878.65, 46901.25,
   8621.83, 4750.29, 3632.71, NULL, 245518.17,
   114009150.67, 85696114.71, 59196245.28, 277517060.40,
   1129.59, 1098.82, 1100.69, 1258.34,
   NULL, 67008829, 479776.00),
-- 2020
  (2020,
   44174.80, NULL, 38073.54,
   NULL, 6059,
   78.32, 49.54, 34.61,
   11948.81, 114284.12, 32458.00, 4186.37, 9739.44,
   5.57, 5070.12, 177692.43, 97158.74, 274851.17,
   9732.18, 5.48,
   5521.04, 2.08,
   18729.89, 7.22,
   24960.53, 9.41,
   72606681, 130722, 4001917, 1746074,
   218408, 296231, NULL, 79000033,
   72096.64, 31146.41, 30277.65, 144678.21,
   112155.85, 72239.86, 42819.32,
   8098.06, 4634.78, 3634.88, NULL, 243582.75,
   111249935.56, 78805923.48, 53067797.67, 260963721.44,
   1071.36, 991.92, 1090.89, 1239.34,
   NULL, 66683392, 378246.00),
-- 2021
  (2021,
   44464.75, NULL, 38313.90,
   NULL, 6143,
   77.20, 51.19, 34.84,
   11869.30, 114518.49, 35800.78, 4216.71, 11074.49,
   5.63, 5488.49, 182973.88, 106496.69, 289470.57,
   9959.33, 5.44,
   5501.33, 1.97,
   18519.97, 6.77,
   25143.66, 9.00,
   75701985, 159057, 4300034, 1838087,
   230577, 314240, NULL, 82543980,
   76566.84, 33151.51, 31974.04, 153565.96,
   115370.05, 80904.45, 44440.85,
   8665.99, 4707.97, 3544.95, NULL, 257634.25,
   118139629.65, 87880138.90, 54870079.54, 279094308.54,
   1083.30, 1024.01, 1086.22, 1234.68,
   NULL, 68474268, 397765.00),
-- 2022
  (2022,
   44939.88, NULL, 38418.81,
   NULL, 6314,
   84.11, 50.93, 32.28,
   13175.01, 115316.09, 35091.21, 4138.19, 11765.93,
   9.09, 4323.52, 183819.03, 124183.27, 308002.30,
   10172.11, 5.53,
   5726.55, 1.92,
   20236.10, 6.94,
   27655.48, 9.29,
   78327897, 179553, 4640585, 1920615,
   236629, 330919, NULL, 85636198,
   80423.31, 34714.29, 34117.75, 161861.54,
   116095.41, 88483.30, 50532.19,
   10073.23, 4995.12, 3582.23, NULL, 273761.48,
   131002679.73, 95620299.54, 63446010.65, 311339066.61,
   1137.26, 1128.40, 1080.66, 1255.56,
   NULL, 70444162, 381620.00),
-- 2023
  (2023,
   45095.19, NULL, 39785.31,
   NULL, 6446,
   63.33, 50.58, 42.48,
   10655.07, 114598.55, 38378.28, 4310.50, 11650.25,
   12.85, 4375.37, 183980.89, 139339.73, 323320.62,
   9998.01, 5.43,
   6284.73, 2.01,
   20569.14, 6.71,
   28773.22, 9.18,
   81551348, 206770, 4806141, 1993078,
   242274, 353667, NULL, 89153278,
   85318.86, 36698.11, 36060.99, 171508.42,
   122339.69, 88587.68, 57112.00,
   11496.10, 5285.12, 3615.19, NULL, 288435.78,
   141442547.28, 95703256.67, 71998142.63, 333279863.57,
   1155.47, 1156.15, 1080.32, 1260.65,
   NULL, 69222936, 417039.00),
-- 2024
  (2024,
   46833.23, NULL, 41172.01,
   NULL, 6226,
   64.05, 51.70, 42.09,
   11476.93, 116622.40, 41031.20, 4230.97, 11246.97,
   13.77, 5952.65, 190574.90, 153316.85, 343891.75,
   10273.71, 5.39,
   6786.77, 2.03,
   21724.90, 6.65,
   30648.66, 9.19,
   84660382, 253055, 5146548, 2088434,
   253223, 375744, 99906, 92877292,
   89657.99, 38852.24, 37295.76, 182026.25,
   130433.10, 92195.69, 58771.14,
   12679.23, 5412.35, 3527.90, 3200.02, 306219.42,
   151861297.03, 98115291.08, 72764239.39, 353188837.19,
   1153.38, 1164.28, 1064.21, 1238.09,
   NULL, 71719964, 460624.00),
-- 2025
  (2025,
   47464.24, 80189.32, 41843.16,
   65133.90, 5985,
   62.21, 50.53, 42.27,
   13395.37, 115288.23, 41117.66, 4336.18, 11184.35,
   14.18, 7119.92, 192455.91, 162472.15, 354928.06,
   9616.54, 5.00,
   6679.64, 1.94,
   21546.93, 6.38,
   30551.53, 8.87,
   87399648, 300248, 5601723, 2171836,
   264169, 395265, 41345, 96174234,
   94178.69, 40275.72, 40610.56, 192620.59,
   134563.85, 95103.38, 61976.19,
   13193.09, 5359.44, 3502.51, 3993.39, 317691.86,
   143213710.04, 102236555.25, 76970261.91, 353493374.05,
   1112.69, 1064.28, 1075.00, 1241.93,
   98.56, 78406414, 466995.27);

-- =============================================================
-- MODULE REGISTRATION  (domain energi-jabar, domain_id = 1)
-- =============================================================
INSERT INTO `domain_modules`
  (`domain_id`, `slug`, `url_token`, `nama`, `route_path`, `sensitivitas`, `status`, `created_at`)
VALUES
  (1, 'pln-stat', 'q7r2wk9mt5vx', 'PLN Statistics',
   '/modules/energi-jabar/q7r2wk9mt5vx/', 'internal', 'aktif', NOW())
ON DUPLICATE KEY UPDATE
  `nama`        = VALUES(`nama`),
  `route_path`  = VALUES(`route_path`),
  `status`      = VALUES(`status`);
