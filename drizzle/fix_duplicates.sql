-- ============================================================
-- COCKPIT — Fix Duplicate RUPTL Data
-- B2 Banten & B4 Jawa Tengah terduplikat 3x.
-- Script ini menghapus duplikat, menyisakan 1 baris per key.
-- Jalankan via SSH: mysql -u u164655286_cockpit -p u164655286_cockpit < drizzle/fix_duplicates.sql
-- ============================================================

SET @b2 = (SELECT id FROM ruptl_provinsi WHERE kode = 'B2');
SET @b4 = (SELECT id FROM ruptl_provinsi WHERE kode = 'B4');

-- ── 1. penjualan_historis (key: provinsi_id, tahun, sektor) ─────────────
DELETE t1 FROM ruptl_penjualan_historis t1
INNER JOIN ruptl_penjualan_historis t2
  ON  t1.provinsi_id = t2.provinsi_id
  AND t1.tahun       = t2.tahun
  AND t1.sektor      = t2.sektor
  AND t1.id          > t2.id
WHERE t1.provinsi_id IN (@b2, @b4);

-- ── 2. proyeksi_kebutuhan (key: provinsi_id, tahun) ─────────────────────
DELETE t1 FROM ruptl_proyeksi_kebutuhan t1
INNER JOIN ruptl_proyeksi_kebutuhan t2
  ON  t1.provinsi_id = t2.provinsi_id
  AND t1.tahun       = t2.tahun
  AND t1.id          > t2.id
WHERE t1.provinsi_id IN (@b2, @b4);

-- ── 3. pembangkit_eksisting (key: provinsi_id, pemilik, jenis, sistem) ──
DELETE t1 FROM ruptl_pembangkit_eksisting t1
INNER JOIN ruptl_pembangkit_eksisting t2
  ON  t1.provinsi_id          = t2.provinsi_id
  AND t1.pemilik              = t2.pemilik
  AND t1.jenis                = t2.jenis
  AND IFNULL(t1.sistem_tenaga_listrik,'') = IFNULL(t2.sistem_tenaga_listrik,'')
  AND t1.id                   > t2.id
WHERE t1.provinsi_id IN (@b2, @b4);

-- ── 4. rencana_pembangkit (key: provinsi_id, skenario, jenis, nama, cod_tahun) ──
DELETE t1 FROM ruptl_rencana_pembangkit t1
INNER JOIN ruptl_rencana_pembangkit t2
  ON  t1.provinsi_id           = t2.provinsi_id
  AND t1.skenario              = t2.skenario
  AND t1.jenis                 = t2.jenis
  AND IFNULL(t1.nama,'')       = IFNULL(t2.nama,'')
  AND IFNULL(t1.cod_tahun, 0)  = IFNULL(t2.cod_tahun, 0)
  AND t1.id                    > t2.id
WHERE t1.provinsi_id IN (@b2, @b4);

-- ── 5. rencana_transmisi (key: provinsi_id, skenario, tahun) ────────────
DELETE t1 FROM ruptl_rencana_transmisi t1
INNER JOIN ruptl_rencana_transmisi t2
  ON  t1.provinsi_id = t2.provinsi_id
  AND t1.skenario    = t2.skenario
  AND t1.tahun       = t2.tahun
  AND t1.id          > t2.id
WHERE t1.provinsi_id IN (@b2, @b4);

-- ── 6. rencana_gardu_induk (key: provinsi_id, skenario, tahun) ──────────
DELETE t1 FROM ruptl_rencana_gardu_induk t1
INNER JOIN ruptl_rencana_gardu_induk t2
  ON  t1.provinsi_id = t2.provinsi_id
  AND t1.skenario    = t2.skenario
  AND t1.tahun       = t2.tahun
  AND t1.id          > t2.id
WHERE t1.provinsi_id IN (@b2, @b4);

-- ── Verifikasi akhir (query terpisah agar tidak penuh temp table) ────────
SELECT 'penjualan_historis' AS tabel, provinsi_id, COUNT(*) AS baris
FROM ruptl_penjualan_historis
WHERE provinsi_id IN (@b2, @b4)
GROUP BY provinsi_id;
-- Harusnya: B2=40, B4=40

SELECT 'proyeksi_kebutuhan' AS tabel, provinsi_id, COUNT(*) AS baris
FROM ruptl_proyeksi_kebutuhan
WHERE provinsi_id IN (@b2, @b4)
GROUP BY provinsi_id;
-- Harusnya: B2=10, B4=10

SELECT 'pembangkit_eksisting' AS tabel, provinsi_id, COUNT(*) AS baris
FROM ruptl_pembangkit_eksisting
WHERE provinsi_id IN (@b2, @b4)
GROUP BY provinsi_id;
-- Harusnya: B2=5, B4=11

SELECT 'rencana_pembangkit' AS tabel, provinsi_id, COUNT(*) AS baris
FROM ruptl_rencana_pembangkit
WHERE provinsi_id IN (@b2, @b4)
GROUP BY provinsi_id;
-- Harusnya: B2=26, B4=34

SELECT 'rencana_transmisi' AS tabel, provinsi_id, COUNT(*) AS baris
FROM ruptl_rencana_transmisi
WHERE provinsi_id IN (@b2, @b4)
GROUP BY provinsi_id;
-- Harusnya: B2=12, B4=18

SELECT 'rencana_gardu_induk' AS tabel, provinsi_id, COUNT(*) AS baris
FROM ruptl_rencana_gardu_induk
WHERE provinsi_id IN (@b2, @b4)
GROUP BY provinsi_id;
-- Harusnya: B2=12, B4=20
