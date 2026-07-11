#!/usr/bin/env bash
# drizzle/generate_simba_import.sh
# Extracts 12 key analytics tables from the SIMBA dump and renames
# them with a simba_ prefix for import into the Cockpit DB.
#
# Usage:
#   chmod +x drizzle/generate_simba_import.sh
#   ./drizzle/generate_simba_import.sh /path/to/u164655286_simba.sql > /tmp/simba_import.sql
#   # Then run /tmp/simba_import.sql in phpMyAdmin
#
# Tables extracted:
#   mon_sera, mon_stn, mon_sdr, mon_wie, mon_pw, mon_bugak, mon_pltg, mon_mpp
#   rekap_pemakaian, rekap_penerimaan, info_tangki, _versi (→ simba_versi)

INPUT="${1:-/Users/dinoarla/Downloads/u164655286_simba.sql}"

if [[ ! -f "$INPUT" ]]; then
  echo "ERROR: SIMBA dump not found at $INPUT" >&2
  echo "Usage: $0 /path/to/u164655286_simba.sql" >&2
  exit 1
fi

python3 - "$INPUT" <<'PYEOF'
import sys, re

src = sys.argv[1]
with open(src, 'r', encoding='latin-1') as f:
    content = f.read()

TABLES = [
    ('mon_sera',          'simba_mon_sera'),
    ('mon_stn',           'simba_mon_stn'),
    ('mon_sdr',           'simba_mon_sdr'),
    ('mon_wie',           'simba_mon_wie'),
    ('mon_pw',            'simba_mon_pw'),
    ('mon_bugak',         'simba_mon_bugak'),
    ('mon_pltg',          'simba_mon_pltg'),
    ('mon_mpp',           'simba_mon_mpp'),
    ('rekap_pemakaian',   'simba_rekap_pemakaian'),
    ('rekap_penerimaan',  'simba_rekap_penerimaan'),
    ('info_tangki',       'simba_info_tangki'),
    ('_versi',            'simba_versi'),
]

print("-- ============================================================")
print("-- SIMBA → Cockpit DB Import")
print("-- Generated from u164655286_simba.sql")
print("-- Run this SQL in phpMyAdmin (Cockpit DB = u164655286_cockpit)")
print("-- ============================================================\n")
print("SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';")
print("SET time_zone = '+00:00';")
print("SET NAMES utf8mb4;\n")

for (orig, new) in TABLES:
    print(f"-- ── {orig} → {new} ──")

    # CREATE TABLE
    m = re.search(
        r'(CREATE TABLE `' + re.escape(orig) + r'`.*?ENGINE=InnoDB[^\n]*\n)',
        content, re.DOTALL
    )
    if m:
        ddl = m.group(1).replace(f'`{orig}`', f'`{new}`')
        print(f"DROP TABLE IF EXISTS `{new}`;")
        print(ddl)

    # INSERT INTO (may be multiple batches)
    for ins in re.findall(
        r'(INSERT INTO `' + re.escape(orig) + r'`[^;]+;)',
        content, re.DOTALL
    ):
        print(ins.replace(f'`{orig}`', f'`{new}`'))
        print()

    # ALTER TABLE (PRIMARY KEY + AUTO_INCREMENT)
    for alt in re.findall(
        r'(ALTER TABLE `' + re.escape(orig) + r'`[^;]+;)',
        content
    ):
        print(alt.replace(f'`{orig}`', f'`{new}`'))
    print()

print("-- ── VERIFY ──")
print("SELECT 'simba_mon_sera'        AS tbl, COUNT(*) AS rows FROM simba_mon_sera UNION ALL")
print("SELECT 'simba_mon_stn',               COUNT(*)         FROM simba_mon_stn  UNION ALL")
print("SELECT 'simba_mon_sdr',               COUNT(*)         FROM simba_mon_sdr  UNION ALL")
print("SELECT 'simba_mon_wie',               COUNT(*)         FROM simba_mon_wie  UNION ALL")
print("SELECT 'simba_mon_pw',                COUNT(*)         FROM simba_mon_pw   UNION ALL")
print("SELECT 'simba_mon_bugak',             COUNT(*)         FROM simba_mon_bugak UNION ALL")
print("SELECT 'simba_mon_pltg',              COUNT(*)         FROM simba_mon_pltg UNION ALL")
print("SELECT 'simba_mon_mpp',               COUNT(*)         FROM simba_mon_mpp  UNION ALL")
print("SELECT 'simba_rekap_pemakaian',       COUNT(*)         FROM simba_rekap_pemakaian  UNION ALL")
print("SELECT 'simba_rekap_penerimaan',      COUNT(*)         FROM simba_rekap_penerimaan UNION ALL")
print("SELECT 'simba_info_tangki',           COUNT(*)         FROM simba_info_tangki UNION ALL")
print("SELECT 'simba_versi',                 COUNT(*)         FROM simba_versi;")

PYEOF
