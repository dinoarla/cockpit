#!/usr/bin/env python3
"""
import_ganti_meter.py — Baca semua XLS Ganti Meter (2024-2026) dan impor ke MySQL.

Tabel yang dihasilkan:
  ganti_meter_harian   — per (tgl DATE, unitap, jumlah, prabayar, pascabayar)
  ganti_meter_alasan   — per (bulan CHAR(6), unitap, alasan, alasan_grup, jumlah)
  ganti_meter_merk     — per (bulan CHAR(6), merk_lama, merk_baru, jumlah)
  ganti_meter_umur     — per (bulan CHAR(6), thbuat_lama VARCHAR(4), jumlah)

Usage:
  # Export SQL file (import via phpMyAdmin):
  python3 drizzle/import_ganti_meter.py --to-sql ganti_meter_data.sql

  # Direct DB insert (jika ada remote MySQL):
  python3 drizzle/import_ganti_meter.py

Requirements:
  pip install xlrd pymysql python-dotenv
"""

import os
import re
import sys
import warnings
from pathlib import Path

warnings.filterwarnings("ignore")

import xlrd
from dotenv import load_dotenv

# ── Load .env ──────────────────────────────────────────────────────────────────
load_dotenv(Path(__file__).parent.parent / ".env")

DB_HOST = os.getenv("DB_HOST", "localhost")
DB_PORT = int(os.getenv("DB_PORT", "3306"))
DB_USER = os.getenv("DB_USER", "")
DB_PASS = os.getenv("DB_PASSWORD") or os.getenv("DB_PASS", "")
DB_NAME = os.getenv("DB_NAME", "")

# ── Data root ──────────────────────────────────────────────────────────────────
DATA_ROOT = Path.home() / "Downloads" / "Ganti Meter"

# ── UNITAP map ─────────────────────────────────────────────────────────────────
UNITAP_NAMA = {
    "53BDG": "UP3 Bandung",
    "53BGR": "UP3 Bogor",
    "53BKS": "UP3 Bekasi Kota",
    "53CJR": "UP3 Cianjur",
    "53CKG": "UP3 Cikokol",
    "53CMI": "UP3 Cimahi",
    "53CRB": "UP3 Cirebon",
    "53DPK": "UP3 Depok",
    "53GPI": "UP3 Cikarang",
    "53GRT": "UP3 Garut",
    "53IDM": "UP3 Banten",
    "53KRW": "UP3 Karawang",
    "53MJA": "UP3 Majalaya",
    "53PWK": "UP3 Purwakarta",
    "53SKI": "UP3 Sukabumi",
    "53SMD": "UP3 Sumedang",
    "53TSK": "UP3 Tasikmalaya",
}

# ── Folder → (year, month) mapping ────────────────────────────────────────────
FOLDER_MONTHS = {
    "2024": {
        "3Maret": (2024, 3), "4April": (2024, 4), "5Mei": (2024, 5),
        "6Jun": (2024, 6), "7Jul": (2024, 7), "8Ags": (2024, 8),
        "9Sept": (2024, 9), "10Okt": (2024, 10), "11Nov": (2024, 11), "12Des": (2024, 12),
    },
    "2025": {
        "1Jan2025": (2025, 1), "2Feb2025": (2025, 2), "3Mar2025": (2025, 3),
        "4Apr2025": (2025, 4), "5Mei2025": (2025, 5), "6Jun2025": (2025, 6),
        "7Jul2025": (2025, 7), "8Ags 2025": (2025, 8), "9Sep 2025": (2025, 9),
        "10Okt 2025": (2025, 10), "11Nop 2025": (2025, 11), "12Des 2025": (2025, 12),
    },
    "2026": {
        "1Jan": (2026, 1), "2Feb": (2026, 2), "3Mar": (2026, 3),
        "4Apr": (2026, 4), "5Mei": (2026, 5), "6Jun": (2026, 6), "7Jul": (2026, 7),
    },
}

MONTH_NAMES = {
    "jan": 1, "feb": 2, "mar": 3, "maret": 3, "apr": 4, "april": 4,
    "mei": 5, "jun": 6, "jul": 7, "ags": 8, "agst": 8, "sep": 9, "sept": 9,
    "okt": 10, "nop": 11, "nov": 11, "des": 12,
}

# ── Alasan grouping ─────────────────────────────────────────────────────────────
ALASAN_GRUP = {
    "Program Migrasi AMI": "Program",
    "Program Pemeliharaan Meter": "Program",
    "Program meter tua": "Program",
    "Program pemeliharaan meter (kasus khusus)": "Program",
    "Upgrade KRN": "Program",

    "Display LCD Meter - Blank/cacat/mati": "Rusak Display",
    "Display LCD Meter - Error": "Rusak Display",
    "Display LCD Meter - Muncul Periksa": "Rusak Display",
    "Display LCD Meter - muncul Inscek": "Rusak Display",
    "LCD menunjukkan error/tidak normal": "Rusak Display",

    "Cover Meter rusak / pecah": "Rusak Fisik",
    "Cover meter buram": "Rusak Fisik",
    "Kerusakan Fisik Meter karena Gangguan Eksternal": "Rusak Fisik",
    "Terminal meter terbakar": "Rusak Fisik",
    "Meter terbakar/tersambar petir": "Rusak Fisik",
    "Meter Rusak karena Bencana Alam": "Rusak Fisik",
    "Meter Rusak karena Serangga / Hewan": "Rusak Fisik",

    "KCT tidak dapat masuk": "Gangguan Token",
    "Kredit kWh berkurang tanpa beban": "Gangguan Token",
    "Kredit kWh lebih besar dari kumulatif pembelian token": "Gangguan Token",
    "Kredit kWh menjadi nol (reset)": "Gangguan Token",
    "Kredit kWh tidak berkurang": "Gangguan Token",
    "Token pembelian tidak bisa masuk": "Gangguan Token",

    "Gangguan Firmware": "Gangguan Teknis",
    "Error meter diluar kelas": "Gangguan Teknis",
    "Meter Edrum register tidak berputar": "Gangguan Teknis",
    "Meter piringan tidak berputar": "Gangguan Teknis",
    "Relay rusak": "Gangguan Teknis",
    "Saklar Temper Rusak": "Gangguan Teknis",
    "Port komunikasi meter rusak": "Gangguan Teknis",
    "Keypad tidak berfungsi (rusak)": "Gangguan Teknis",
    "Meter terminal netral keluar arus": "Gangguan Teknis",
    "Permasalahan Instalasi Pelanggan (IML)": "Gangguan Teknis",
}

# ── SQL DDL ─────────────────────────────────────────────────────────────────────
DDL = """
CREATE TABLE IF NOT EXISTS `ganti_meter_harian` (
  `id`               INT AUTO_INCREMENT PRIMARY KEY,
  `tgl`              DATE         NOT NULL,
  `unitap`           VARCHAR(10)  NOT NULL,
  `jumlah`           INT          NOT NULL DEFAULT 0,
  `jumlah_prabayar`  INT          NOT NULL DEFAULT 0,
  `jumlah_pascabayar` INT         NOT NULL DEFAULT 0,
  UNIQUE KEY `uk_gmh` (`tgl`, `unitap`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ganti_meter_alasan` (
  `id`          INT AUTO_INCREMENT PRIMARY KEY,
  `bulan`       CHAR(6)      NOT NULL,
  `unitap`      VARCHAR(10)  NOT NULL,
  `alasan`      VARCHAR(200) NOT NULL,
  `alasan_grup` VARCHAR(50)  NOT NULL DEFAULT 'Lainnya',
  `jumlah`      INT          NOT NULL DEFAULT 0,
  UNIQUE KEY `uk_gma` (`bulan`, `unitap`, `alasan`(190))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ganti_meter_merk` (
  `id`        INT AUTO_INCREMENT PRIMARY KEY,
  `bulan`     CHAR(6)      NOT NULL,
  `merk_lama` VARCHAR(50)  NOT NULL DEFAULT '',
  `merk_baru` VARCHAR(50)  NOT NULL DEFAULT '',
  `jumlah`    INT          NOT NULL DEFAULT 0,
  UNIQUE KEY `uk_gmm` (`bulan`, `merk_lama`(45), `merk_baru`(45))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ganti_meter_umur` (
  `id`          INT AUTO_INCREMENT PRIMARY KEY,
  `bulan`       CHAR(6)     NOT NULL,
  `thbuat_lama` VARCHAR(4)  NOT NULL,
  `jumlah`      INT         NOT NULL DEFAULT 0,
  UNIQUE KEY `uk_gmu` (`bulan`, `thbuat_lama`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
"""


def get_day_from_filename(fname: str, fallback_year: int, fallback_month: int) -> int:
    name = os.path.splitext(fname)[0].strip()
    m = re.match(r"^(\d{1,2})(?:_\d{1,2})?\s*[A-Za-z]+\s*\d{4}$", name)
    if m:
        return int(m.group(1))
    m = re.match(r"^(\d{1,2})(?:_\d{1,2})?\s*[A-Za-z]+$", name)
    if m:
        return int(m.group(1))
    return 1


def get_alasan_grup(alasan: str) -> str:
    return ALASAN_GRUP.get(alasan.strip(), "Lainnya")


def clean_str(val) -> str:
    s = str(val).strip()
    if re.match(r"^\d+\.0$", s):
        s = s[:-2]
    return s


def esc(s: str) -> str:
    """Escape string for SQL INSERT."""
    return s.replace("\\", "\\\\").replace("'", "\\'")


def process_file(filepath: str, year: int, month: int,
                 harian: dict, alasan: dict, merk: dict, umur: dict) -> int:
    fname = os.path.basename(filepath)
    day = get_day_from_filename(fname, year, month)
    tgl = f"{year:04d}-{month:02d}-{day:02d}"
    bulan = f"{year:04d}{month:02d}"

    wb = xlrd.open_workbook(filepath)
    ws = wb.sheet_by_index(0)
    count = 0

    for r in range(1, ws.nrows):
        try:
            unitap = clean_str(ws.cell_value(r, 2))
            if not unitap or unitap not in UNITAP_NAMA:
                continue

            jenis_mk = clean_str(ws.cell_value(r, 17))
            alasan_val = clean_str(ws.cell_value(r, 31))
            merk_baru = clean_str(ws.cell_value(r, 35)).upper()[:50]
            merk_lama = clean_str(ws.cell_value(r, 40)).upper()[:50]
            thbuat_lama = clean_str(ws.cell_value(r, 43))

            is_prabayar = jenis_mk in ("JK", "HJK")
            is_pascabayar = jenis_mk in ("J", "HJ", "JM")

            key_h = (tgl, unitap)
            if key_h not in harian:
                harian[key_h] = [0, 0, 0]
            harian[key_h][0] += 1
            if is_prabayar:
                harian[key_h][1] += 1
            if is_pascabayar:
                harian[key_h][2] += 1

            if alasan_val:
                grup = get_alasan_grup(alasan_val)
                key_a = (bulan, unitap, alasan_val)
                if key_a not in alasan:
                    alasan[key_a] = [grup, 0]
                alasan[key_a][1] += 1

            key_m = (bulan, merk_lama, merk_baru)
            merk[key_m] = merk.get(key_m, 0) + 1

            if re.match(r"^\d{4}$", thbuat_lama):
                yr = int(thbuat_lama)
                if 1950 <= yr <= 2025:
                    key_u = (bulan, thbuat_lama)
                    umur[key_u] = umur.get(key_u, 0) + 1

            count += 1
        except Exception:
            continue

    return count


# ─────────────────────────────────────────────────────────────────────────────
# SQL-file writer helpers
# ─────────────────────────────────────────────────────────────────────────────

def write_harian_sql(f, harian: dict):
    if not harian:
        return
    rows = [(tgl, ut, v[0], v[1], v[2]) for (tgl, ut), v in harian.items()]
    vals = ",\n  ".join(
        f"('{tgl}', '{ut}', {j}, {p}, {ps})" for tgl, ut, j, p, ps in rows
    )
    f.write(
        f"INSERT INTO `ganti_meter_harian` (tgl, unitap, jumlah, jumlah_prabayar, jumlah_pascabayar)\nVALUES\n  {vals}\n"
        "ON DUPLICATE KEY UPDATE jumlah=VALUES(jumlah), jumlah_prabayar=VALUES(jumlah_prabayar), jumlah_pascabayar=VALUES(jumlah_pascabayar);\n\n"
    )
    print(f"  → harian: {len(rows)} rows")


def write_alasan_sql(f, alasan: dict):
    if not alasan:
        return
    rows = [(bulan, ut, al, v[0], v[1]) for (bulan, ut, al), v in alasan.items()]
    vals = ",\n  ".join(
        f"('{b}', '{ut}', '{esc(al)}', '{esc(g)}', {j})" for b, ut, al, g, j in rows
    )
    f.write(
        f"INSERT INTO `ganti_meter_alasan` (bulan, unitap, alasan, alasan_grup, jumlah)\nVALUES\n  {vals}\n"
        "ON DUPLICATE KEY UPDATE alasan_grup=VALUES(alasan_grup), jumlah=VALUES(jumlah);\n\n"
    )
    print(f"  → alasan: {len(rows)} rows")


def write_merk_sql(f, merk: dict):
    if not merk:
        return
    rows = [(bulan, ml, mb, cnt) for (bulan, ml, mb), cnt in merk.items()]
    vals = ",\n  ".join(
        f"('{b}', '{esc(ml)}', '{esc(mb)}', {cnt})" for b, ml, mb, cnt in rows
    )
    f.write(
        f"INSERT INTO `ganti_meter_merk` (bulan, merk_lama, merk_baru, jumlah)\nVALUES\n  {vals}\n"
        "ON DUPLICATE KEY UPDATE jumlah=VALUES(jumlah);\n\n"
    )
    print(f"  → merk: {len(rows)} rows")


def write_umur_sql(f, umur: dict):
    if not umur:
        return
    rows = [(bulan, th, cnt) for (bulan, th), cnt in umur.items()]
    vals = ",\n  ".join(f"('{b}', '{th}', {cnt})" for b, th, cnt in rows)
    f.write(
        f"INSERT INTO `ganti_meter_umur` (bulan, thbuat_lama, jumlah)\nVALUES\n  {vals}\n"
        "ON DUPLICATE KEY UPDATE jumlah=VALUES(jumlah);\n\n"
    )
    print(f"  → umur: {len(rows)} rows")


# ─────────────────────────────────────────────────────────────────────────────
# DB writer helpers
# ─────────────────────────────────────────────────────────────────────────────

def upsert_harian(cursor, harian: dict):
    rows = [(tgl, ut, v[0], v[1], v[2]) for (tgl, ut), v in harian.items()]
    if rows:
        cursor.executemany(
            "INSERT INTO ganti_meter_harian (tgl,unitap,jumlah,jumlah_prabayar,jumlah_pascabayar) "
            "VALUES (%s,%s,%s,%s,%s) ON DUPLICATE KEY UPDATE "
            "jumlah=VALUES(jumlah),jumlah_prabayar=VALUES(jumlah_prabayar),jumlah_pascabayar=VALUES(jumlah_pascabayar)",
            rows,
        )
    print(f"  → harian: {len(rows)} rows upserted")


def upsert_alasan(cursor, alasan: dict):
    rows = [(bulan, ut, al, v[0], v[1]) for (bulan, ut, al), v in alasan.items()]
    if rows:
        cursor.executemany(
            "INSERT INTO ganti_meter_alasan (bulan,unitap,alasan,alasan_grup,jumlah) "
            "VALUES (%s,%s,%s,%s,%s) ON DUPLICATE KEY UPDATE alasan_grup=VALUES(alasan_grup),jumlah=VALUES(jumlah)",
            rows,
        )
    print(f"  → alasan: {len(rows)} rows upserted")


def upsert_merk(cursor, merk: dict):
    rows = [(bulan, ml, mb, cnt) for (bulan, ml, mb), cnt in merk.items()]
    if rows:
        cursor.executemany(
            "INSERT INTO ganti_meter_merk (bulan,merk_lama,merk_baru,jumlah) "
            "VALUES (%s,%s,%s,%s) ON DUPLICATE KEY UPDATE jumlah=VALUES(jumlah)",
            rows,
        )
    print(f"  → merk: {len(rows)} rows upserted")


def upsert_umur(cursor, umur: dict):
    rows = [(bulan, th, cnt) for (bulan, th), cnt in umur.items()]
    if rows:
        cursor.executemany(
            "INSERT INTO ganti_meter_umur (bulan,thbuat_lama,jumlah) "
            "VALUES (%s,%s,%s) ON DUPLICATE KEY UPDATE jumlah=VALUES(jumlah)",
            rows,
        )
    print(f"  → umur: {len(rows)} rows upserted")


# ─────────────────────────────────────────────────────────────────────────────
# Main
# ─────────────────────────────────────────────────────────────────────────────

def main():
    to_sql_file = None
    if "--to-sql" in sys.argv:
        idx = sys.argv.index("--to-sql")
        to_sql_file = sys.argv[idx + 1] if idx + 1 < len(sys.argv) else "ganti_meter_data.sql"

    print("=" * 60)
    print("import_ganti_meter.py — Cockpit Ganti Meter Importer")
    print("=" * 60)

    if to_sql_file:
        print(f"Mode: export SQL → {to_sql_file}")
    else:
        print(f"Mode: direct DB insert")
        print(f"DB: {DB_USER}@{DB_HOST}:{DB_PORT}/{DB_NAME}")

    print(f"Data root: {DATA_ROOT}\n")

    # ── Setup output ──
    if to_sql_file:
        sql_out = open(to_sql_file, "w", encoding="utf-8")
        sql_out.write("-- Ganti Meter import — generated by import_ganti_meter.py\n")
        sql_out.write("SET NAMES utf8mb4;\n\n")
        for stmt in DDL.strip().split(";\n\n"):
            s = stmt.strip()
            if s:
                sql_out.write(s + ";\n\n")
        conn = cur = None
    else:
        import pymysql
        conn = pymysql.connect(
            host=DB_HOST, port=DB_PORT, user=DB_USER,
            password=DB_PASS, database=DB_NAME,
            charset="utf8mb4", autocommit=False,
        )
        cur = conn.cursor()
        print("Creating tables (IF NOT EXISTS)…")
        for stmt in DDL.strip().split(";\n\n"):
            s = stmt.strip()
            if s:
                cur.execute(s)
        conn.commit()
        print("Tables ready.\n")
        sql_out = None

    grand_total = 0

    for year_str, months in FOLDER_MONTHS.items():
        year_dir = DATA_ROOT / year_str
        if not year_dir.exists():
            print(f"[SKIP] {year_dir} not found")
            continue

        print(f"── Year {year_str} ──────────────────────────────────────────")

        for folder_name, (year, month) in sorted(months.items(), key=lambda x: x[1]):
            month_dir = year_dir / folder_name
            if not month_dir.exists():
                print(f"  [SKIP] {folder_name} not found")
                continue

            xls_files = sorted([f for f in month_dir.iterdir() if f.suffix == ".xls"])
            if not xls_files:
                print(f"  [SKIP] {folder_name}: no XLS files")
                continue

            bulan_str = f"{year:04d}{month:02d}"
            print(f"  {folder_name} → {bulan_str}: {len(xls_files)} files")

            harian: dict = {}
            alasan: dict = {}
            merk: dict = {}
            umur: dict = {}
            month_rows = 0
            errors = 0

            for xls_path in xls_files:
                try:
                    n = process_file(str(xls_path), year, month, harian, alasan, merk, umur)
                    month_rows += n
                except Exception as e:
                    print(f"    [WARN] {xls_path.name}: {e}")
                    errors += 1

            print(f"    Rows processed: {month_rows:,}  Errors: {errors}")

            if sql_out:
                write_harian_sql(sql_out, harian)
                write_alasan_sql(sql_out, alasan)
                write_merk_sql(sql_out, merk)
                write_umur_sql(sql_out, umur)
            else:
                upsert_harian(cur, harian)
                upsert_alasan(cur, alasan)
                upsert_merk(cur, merk)
                upsert_umur(cur, umur)
                conn.commit()

            grand_total += month_rows

    print()
    print("=" * 60)
    print(f"DONE. Total rows processed: {grand_total:,}")

    if sql_out:
        sql_out.close()
        size_mb = os.path.getsize(to_sql_file) / 1_048_576
        print(f"SQL file: {to_sql_file} ({size_mb:.1f} MB)")
        print("Import via phpMyAdmin: Database → Import → pilih file ini")
    else:
        cur.close()
        conn.close()

    print("=" * 60)


if __name__ == "__main__":
    main()
