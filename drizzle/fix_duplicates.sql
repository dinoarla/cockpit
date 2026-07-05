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

-- ── Verifikasi akhir ─────────────────────────────────────────────────────
SELECT p.kode, p.nama,
  COUNT(DISTINCT CONCAT(h.tahun,h.sektor))  AS penjualan_unik,
  COUNT(DISTINCT k.tahun)                    AS proyeksi_unik,
  COUNT(DISTINCT CONCAT(e.pemilik,e.jenis))  AS pembangkit_unik,
  COUNT(DISTINCT rp.id)                      AS rencana_total,
  COUNT(DISTINCT CONCAT(rt.skenario,rt.tahun)) AS transmisi_unik,
  COUNT(DISTINCT CONCAT(gi.skenario,gi.tahun)) AS gi_unik
FROM ruptl_provinsi p
LEFT JOIN ruptl_penjualan_historis   h  ON h.provinsi_id  = p.id
LEFT JOIN ruptl_proyeksi_kebutuhan   k  ON k.provinsi_id  = p.id
LEFT JOIN ruptl_pembangkit_eksisting e  ON e.provinsi_id  = p.id
LEFT JOIN ruptl_rencana_pembangkit   rp ON rp.provinsi_id = p.id
LEFT JOIN ruptl_rencana_transmisi    rt ON rt.provinsi_id = p.id
LEFT JOIN ruptl_rencana_gardu_induk  gi ON gi.provinsi_id = p.id
WHERE p.kode IN ('B1','B2','B3','B4')
GROUP BY p.kode, p.nama
ORDER BY p.kode;
