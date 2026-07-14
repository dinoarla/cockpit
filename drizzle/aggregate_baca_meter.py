#!/usr/bin/env python3
"""
aggregate_baca_meter.py — Aggregate DATA BACA METER JABAR 2026 XLSX files.
Outputs SQL inserts for baca_meter_* tables (idempotent via ON DUPLICATE KEY UPDATE).

Usage:
  python3 drizzle/aggregate_baca_meter.py > drizzle/baca_meter_import.sql

Requirements:
  pip install openpyxl
"""
import re
import sys
from pathlib import Path
from collections import defaultdict
import openpyxl

DATA_DIR = Path.home() / "Downloads" / "DATA BACA METER JABAR 2026"
MONTH_FOLDERS = ["202601", "202602", "202604", "202605", "202606", "202607"]

# Comprehensive lookup: filename keyword OR column-0 value → (canonical_kode, nama)
ALL_UP3 = {
    # Short codes (Feb, Apr, May filenames & column-0)
    "BDG":          ("53BDG", "Bandung"),
    "BGR":          ("53BGR", "Bogor"),
    "BKS":          ("53BKS", "Bekasi"),
    "CJR":          ("53CJR", "Cianjur"),
    "CKG":          ("53CKG", "Cikarang"),
    "CMI":          ("53CMI", "Cimahi"),
    "CRB":          ("53CRB", "Cirebon"),
    "DPK":          ("53DPK", "Depok"),
    "GRT":          ("53GRT", "Garut"),
    "GPI":          ("53GPI", "Gunung Putri"),
    "IDM":          ("53IDM", "Indramayu"),
    "KRW":          ("53KRW", "Karawang"),
    "MJA":          ("53MJA", "Majalaya"),
    "PWK":          ("53PWK", "Purwakarta"),
    "SKI":          ("53SKI", "Sukabumi"),
    "SDM":          ("53SMD", "Sumedang"),
    "SMD":          ("53SMD", "Sumedang"),
    "TSK":          ("53TSK", "Tasikmalaya"),
    # Full names (Jun, Jul filenames & column-0)
    "BANDUNG":      ("53BDG", "Bandung"),
    "BOGOR":        ("53BGR", "Bogor"),
    "BEKASI":       ("53BKS", "Bekasi"),
    "CIANJUR":      ("53CJR", "Cianjur"),
    "CIKARANG":     ("53CKG", "Cikarang"),
    "CIMAHI":       ("53CMI", "Cimahi"),
    "CIREBON":      ("53CRB", "Cirebon"),
    "DEPOK":        ("53DPK", "Depok"),
    "GARUT":        ("53GRT", "Garut"),
    "GN PUTRI":     ("53GPI", "Gunung Putri"),
    "GUNUNG PUTRI": ("53GPI", "Gunung Putri"),
    "INDRAMAYU":    ("53IDM", "Indramayu"),
    "KARAWANG":     ("53KRW", "Karawang"),
    "MAJALAYA":     ("53MJA", "Majalaya"),
    "PURWAKARTA":   ("53PWK", "Purwakarta"),
    "SUKABUMI":     ("53SKI", "Sukabumi"),
    "SUMEDANG":     ("53SMD", "Sumedang"),
    "TASIK":        ("53TSK", "Tasikmalaya"),
    "TASIKMALAYA":  ("53TSK", "Tasikmalaya"),
    # Column-0 canonical codes (BU/INI files)
    "53BDG": ("53BDG", "Bandung"),
    "53BGR": ("53BGR", "Bogor"),
    "53BKS": ("53BKS", "Bekasi"),
    "53CJR": ("53CJR", "Cianjur"),
    "53CKG": ("53CKG", "Cikarang"),
    "53CMI": ("53CMI", "Cimahi"),
    "53CRB": ("53CRB", "Cirebon"),
    "53DPK": ("53DPK", "Depok"),
    "53GRT": ("53GRT", "Garut"),
    "53GPI": ("53GPI", "Gunung Putri"),
    "53IDM": ("53IDM", "Indramayu"),
    "53KRW": ("53KRW", "Karawang"),
    "53MJA": ("53MJA", "Majalaya"),
    "53PWK": ("53PWK", "Purwakarta"),
    "53SKI": ("53SKI", "Sukabumi"),
    "53SDM": ("53SMD", "Sumedang"),
    "53SMD": ("53SMD", "Sumedang"),
    "53TSK": ("53TSK", "Tasikmalaya"),
}

DAYA_ORDER = [
    "≤450 VA", "900 VA", "1.300–2.200 VA",
    "3.500–5.500 VA", "6.600–13.200 VA", "≥16.500 VA", "Tidak Diketahui",
]

def daya_group(d):
    if d is None:
        return "Tidak Diketahui"
    d = int(d)
    if d <= 450:              return "≤450 VA"
    if d == 900:              return "900 VA"
    if 1300 <= d <= 2200:     return "1.300–2.200 VA"
    if 3500 <= d <= 5500:     return "3.500–5.500 VA"
    if 6600 <= d <= 13200:    return "6.600–13.200 VA"
    return "≥16.500 VA"

def esc(s):
    return str(s).replace("'", "''")

def up3_from_filename(fname):
    """
    Extract UP3 keyword from a unit filename.
    '1. BDG REK FEB 26.xlsx'       → 'BDG'
    '1. BANDUNG REK JUL 26.xlsx'   → 'BANDUNG'
    '10. GN PUTRI REK JUN 26.xlsx' → 'GN PUTRI'
    """
    name = Path(fname).stem.upper()
    name = re.sub(r'^\d+\.\s*', '', name)         # strip leading "N. "
    parts = re.split(r'\s+REK\b', name, flags=re.IGNORECASE)
    return parts[0].strip()

def detect_cols(header_row):
    """
    Auto-detect column indices from header row.
    Returns dict with keys: tarif, daya, kode_pesan, stan_baca, stan_meter, pemkwh, up3, unitap
    """
    h = [str(c).upper().replace(' ', '_').strip() if c else '' for c in header_row]

    def find(*names):
        for n in names:
            nu = n.upper().replace(' ', '_')
            if nu in h:
                return h.index(nu)
        return None

    return {
        'up3':       find('UP3', 'UNITUPI'),
        'unitap':    find('UNITAP'),          # BU files
        'tarif':     find('TARIF'),
        'daya':      find('DAYA'),
        'kode_pesan':find('KODE_PESAN', 'KODE PESAN'),
        'stan_baca': find('STAN_BACA', 'STAND_BACA'),
        'stan_meter':find('STAN_METER'),
        'pemkwh':    find('PEMAKAIAN_KWH', 'PEMKWH'),
        'jam':       find('JAM_PEMBACAAN', 'JAM PEMBACAAN', 'JAM'),
    }

def parse_jam(val):
    """Parse 'HH:MM' string → integer hour (0-23), or None if invalid."""
    if val is None:
        return None
    s = str(val).strip()
    if ':' in s:
        try:
            h = int(s.split(':')[0])
            if 0 <= h <= 23:
                return h
        except ValueError:
            pass
    return None


def process_file(fpath, is_bu, is_ini, fixed_up3, summary, tarif_map, kode_map, daya_map, jam_map):
    wb  = openpyxl.load_workbook(str(fpath), read_only=True, data_only=True)
    ws  = wb.active
    cols = None
    count = 0

    for i, row in enumerate(ws.iter_rows(values_only=True)):
        if i == 0:
            cols = detect_cols(row)
            continue

        # ── BACA ULANG: count per UP3 from UNITAP column ──
        if is_bu:
            ci = cols.get('unitap') or cols.get('up3')
            if ci is not None and len(row) > ci and row[ci]:
                key = str(row[ci]).strip().upper()
                entry = ALL_UP3.get(key)
                if entry:
                    summary[entry[0]]["baca_ulang"] += 1
            count += 1
            continue

        # ── INISIALISASI: count per UP3 from UP3 column ──
        if is_ini:
            ci = cols.get('up3')
            if ci is not None and len(row) > ci and row[ci]:
                key = str(row[ci]).strip().upper()
                entry = ALL_UP3.get(key)
                if entry:
                    summary[entry[0]]["inisialisasi"] += 1
            count += 1
            continue

        # ── UNIT FILE: aggregate ──
        up3_kode, _ = fixed_up3  # determined from filename

        # Read fields using detected column positions
        def col(key, default=None):
            ci = cols.get(key)
            if ci is None or len(row) <= ci:
                return default
            return row[ci]

        tarif  = str(col('tarif', '?')).strip() or '?'
        daya   = col('daya')
        kpesan = str(col('kode_pesan', '?')).strip() or '?'
        kwh_raw = col('pemkwh')
        kwh = float(kwh_raw) if kwh_raw is not None else 0.0
        if kwh < 0:
            kwh = 0.0

        # Outlier filter: STAN_BACA == STAN_METER but PEMKWH huge
        # → likely inisialisasi error (meter reading used instead of pemakaian)
        sb_raw = col('stan_baca')
        sm_raw = col('stan_meter')
        if sb_raw is not None and sm_raw is not None and kwh > 1000:
            try:
                sb, sm = float(sb_raw), float(sm_raw)
                if abs(sb - sm) < 1:   # no movement on meter
                    kwh = 0.0
            except (ValueError, TypeError):
                pass

        dg = daya_group(daya)

        # JAM_PEMBACAAN — reading hour distribution
        jam_val = col('jam')
        jam_h   = parse_jam(jam_val)

        summary[up3_kode]["pelanggan"] += 1
        summary[up3_kode]["kwh"] += kwh
        if kpesan == "Z - NORMAL":
            summary[up3_kode]["normal"] += 1
        if jam_h is not None:
            summary[up3_kode]["sum_jam"] += jam_h
            summary[up3_kode]["cnt_jam"] += 1
            jam_map[(up3_kode, jam_h)] += 1

        tarif_map[(up3_kode, tarif)]["pelanggan"] += 1
        tarif_map[(up3_kode, tarif)]["kwh"] += kwh

        kode_map[(up3_kode, kpesan)] += 1

        daya_map[(up3_kode, dg)]["pelanggan"] += 1
        daya_map[(up3_kode, dg)]["kwh"] += kwh

        count += 1

    wb.close()
    return count


def process_month(bulan, folder):
    summary   = defaultdict(lambda: {"pelanggan": 0, "kwh": 0.0, "normal": 0, "baca_ulang": 0, "inisialisasi": 0, "sum_jam": 0.0, "cnt_jam": 0})
    tarif_map = defaultdict(lambda: {"pelanggan": 0, "kwh": 0.0})
    kode_map  = defaultdict(int)
    daya_map  = defaultdict(lambda: {"pelanggan": 0, "kwh": 0.0})
    jam_map   = defaultdict(int)  # (up3_kode, hour) → count

    for fpath in sorted(folder.glob("*.xlsx")):
        fname_up = fpath.name.upper()
        is_bu    = "BACA ULANG"   in fname_up
        is_ini   = "INISIALISASI" in fname_up

        if is_bu:
            label = "BU"
            fixed_up3 = None
        elif is_ini:
            label = "INI"
            fixed_up3 = None
        else:
            label = "UNIT"
            key = up3_from_filename(fpath.name)
            fixed_up3 = ALL_UP3.get(key)
            if fixed_up3 is None:
                print(f"  [SKIP] {fpath.name} — tidak dikenal: '{key}'", file=sys.stderr)
                continue

        print(f"  [{label}] {fpath.name}", file=sys.stderr, flush=True)
        n = process_file(fpath, is_bu, is_ini, fixed_up3, summary, tarif_map, kode_map, daya_map, jam_map)
        print(f"         → {n:,} rows", file=sys.stderr, flush=True)

    return summary, tarif_map, kode_map, daya_map, jam_map


def emit_sql(bulan, summary, tarif_map, kode_map, daya_map, jam_map):
    lines = []

    for up3_kode in sorted(summary):
        d   = summary[up3_kode]
        pel = d["pelanggan"]
        if pel == 0:
            continue
        kwh = int(d["kwh"])
        avg = round(d["kwh"] / pel, 2)
        pct = round(d["normal"] / pel * 100, 2)
        nm  = next((v[1] for v in ALL_UP3.values() if v[0] == up3_kode), up3_kode)
        nm  = esc(nm)
        bu  = d["baca_ulang"]
        ini = d["inisialisasi"]
        avg_jam_val = round(d["sum_jam"] / d["cnt_jam"], 2) if d["cnt_jam"] > 0 else 0.0
        lines.append(
            f"INSERT INTO `baca_meter_summary` "
            f"(bulan,up3_kode,up3_nama,total_pelanggan,total_kwh,avg_kwh,pct_normal,baca_ulang,inisialisasi,avg_jam) "
            f"VALUES ('{bulan}','{up3_kode}','{nm}',{pel},{kwh},{avg},{pct},{bu},{ini},{avg_jam_val}) "
            f"ON DUPLICATE KEY UPDATE "
            f"up3_nama='{nm}',total_pelanggan={pel},total_kwh={kwh},"
            f"avg_kwh={avg},pct_normal={pct},baca_ulang={bu},inisialisasi={ini},avg_jam={avg_jam_val};"
        )

    for (up3_kode, tf) in sorted(tarif_map):
        d   = tarif_map[(up3_kode, tf)]
        pel = d["pelanggan"]
        kwh = int(d["kwh"])
        lines.append(
            f"INSERT INTO `baca_meter_tarif` (bulan,up3_kode,tarif,pelanggan,total_kwh) "
            f"VALUES ('{bulan}','{up3_kode}','{esc(tf)}',{pel},{kwh}) "
            f"ON DUPLICATE KEY UPDATE pelanggan={pel},total_kwh={kwh};"
        )

    for (up3_kode, kp) in sorted(kode_map):
        cnt = kode_map[(up3_kode, kp)]
        lines.append(
            f"INSERT INTO `baca_meter_kode_pesan` (bulan,up3_kode,kode_pesan,jumlah) "
            f"VALUES ('{bulan}','{up3_kode}','{esc(kp)}',{cnt}) "
            f"ON DUPLICATE KEY UPDATE jumlah={cnt};"
        )

    for (up3_kode, dg) in sorted(daya_map):
        d   = daya_map[(up3_kode, dg)]
        pel = d["pelanggan"]
        kwh = int(d["kwh"])
        lines.append(
            f"INSERT INTO `baca_meter_daya` (bulan,up3_kode,daya_group,pelanggan,total_kwh) "
            f"VALUES ('{bulan}','{up3_kode}','{esc(dg)}',{pel},{kwh}) "
            f"ON DUPLICATE KEY UPDATE pelanggan={pel},total_kwh={kwh};"
        )

    for (up3_kode, jam_h) in sorted(jam_map):
        cnt = jam_map[(up3_kode, jam_h)]
        lines.append(
            f"INSERT INTO `baca_meter_jam` (bulan,up3_kode,jam,jumlah) "
            f"VALUES ('{bulan}','{up3_kode}',{jam_h},{cnt}) "
            f"ON DUPLICATE KEY UPDATE jumlah={cnt};"
        )

    return "\n".join(lines)


def main():
    print("-- baca_meter Jawa Barat 2026 — auto-generated by aggregate_baca_meter.py")
    print("-- Import ke phpMyAdmin: database u164655286_cockpit (file: drizzle/baca_meter_import.sql)")
    print("SET NAMES utf8mb4;")
    print()

    for bulan in MONTH_FOLDERS:
        folder = DATA_DIR / bulan
        if not folder.exists():
            print(f"-- WARNING: folder {bulan} tidak ditemukan, dilewati.", file=sys.stderr)
            continue

        print(f"\n-- ── {bulan} ──────────────────────────────────────────", flush=True)
        print(f"\n[{bulan}] Mulai proses...", file=sys.stderr, flush=True)

        s, t, k, d, j = process_month(bulan, folder)

        total_pel = sum(v["pelanggan"] for v in s.values())
        total_kwh = int(sum(v["kwh"] for v in s.values()))
        total_jam = sum(v["cnt_jam"] for v in s.values())
        print(f"[{bulan}] Selesai: {total_pel:,} pelanggan, {total_kwh:,} kWh, {total_jam:,} baris jam", file=sys.stderr, flush=True)

        print(emit_sql(bulan, s, t, k, d, j))

    print("\n-- Done.")


if __name__ == "__main__":
    main()
