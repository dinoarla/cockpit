import { Hono } from "hono";
import { eq, and } from "drizzle-orm";
import { db } from "../db/client.js";
import {
  ruptlProvinsi,
  ruptlPenjualanHistoris,
  ruptlProyeksiKebutuhan,
  ruptlPembangkitEksisting,
  ruptlRencanaPembangkit,
  ruptlRencanaTransmisi,
} from "../db/schema.js";
import { requireAuth } from "../middleware/auth.js";

export const ruptlRoutes = new Hono();
ruptlRoutes.use("*", requireAuth);

// Ringkasan nasional
ruptlRoutes.get("/summary", async (c) => {
  const provinsiList = await db.select().from(ruptlProvinsi);
  const totalProvinsi = provinsiList.length;
  const denganData = provinsiList.filter((p) => p.bebanPuncak2024Mw !== null).length;

  const allBeban = provinsiList
    .map((p) => Number(p.bebanPuncak2024Mw ?? 0))
    .filter((v) => v > 0);
  const totalBebanPuncak = allBeban.reduce((a, b) => a + b, 0);

  return c.json({
    totalProvinsi,
    denganData,
    totalBebanPuncak2024Mw: Math.round(totalBebanPuncak),
    nasionalKpi: {
      totalRencanaPembangkitMw: 69512,
      targetEbtPct: 34.3,
      rencanaPembangkitEbtMw: 42569,
      rencanaPembangkitFosilMw: 16687,
      rencanaBessStorageMw: 10256,
      proyeksiPertumbuhanPct: 5.3,
      rencanaTransmisiKms: 47758,
      rencanaGarduIndukMva: 107950,
    },
  });
});

// Semua provinsi (untuk tabel/peta)
ruptlRoutes.get("/provinsi", async (c) => {
  const rows = await db.select().from(ruptlProvinsi);
  return c.json(rows);
});

// Detail 1 provinsi
ruptlRoutes.get("/provinsi/:kode", async (c) => {
  const kode = c.req.param("kode").toUpperCase();
  const [prov] = await db
    .select()
    .from(ruptlProvinsi)
    .where(eq(ruptlProvinsi.kode, kode))
    .limit(1);
  if (!prov) return c.json({ error: "Provinsi tidak ditemukan" }, 404);
  return c.json(prov);
});

// Penjualan historis per provinsi
ruptlRoutes.get("/provinsi/:kode/penjualan", async (c) => {
  const kode = c.req.param("kode").toUpperCase();
  const [prov] = await db
    .select()
    .from(ruptlProvinsi)
    .where(eq(ruptlProvinsi.kode, kode))
    .limit(1);
  if (!prov) return c.json({ error: "Provinsi tidak ditemukan" }, 404);

  const rows = await db
    .select()
    .from(ruptlPenjualanHistoris)
    .where(eq(ruptlPenjualanHistoris.provinsiId, prov.id));
  return c.json(rows);
});

// Proyeksi kebutuhan per provinsi
ruptlRoutes.get("/provinsi/:kode/proyeksi", async (c) => {
  const kode = c.req.param("kode").toUpperCase();
  const [prov] = await db
    .select()
    .from(ruptlProvinsi)
    .where(eq(ruptlProvinsi.kode, kode))
    .limit(1);
  if (!prov) return c.json({ error: "Provinsi tidak ditemukan" }, 404);

  const rows = await db
    .select()
    .from(ruptlProyeksiKebutuhan)
    .where(eq(ruptlProyeksiKebutuhan.provinsiId, prov.id));
  return c.json(rows);
});

// Pembangkit eksisting per provinsi
ruptlRoutes.get("/provinsi/:kode/pembangkit-eksisting", async (c) => {
  const kode = c.req.param("kode").toUpperCase();
  const [prov] = await db
    .select()
    .from(ruptlProvinsi)
    .where(eq(ruptlProvinsi.kode, kode))
    .limit(1);
  if (!prov) return c.json({ error: "Provinsi tidak ditemukan" }, 404);

  const rows = await db
    .select()
    .from(ruptlPembangkitEksisting)
    .where(eq(ruptlPembangkitEksisting.provinsiId, prov.id));
  return c.json(rows);
});

// Rencana pembangkit per provinsi + filter skenario
ruptlRoutes.get("/provinsi/:kode/rencana-pembangkit", async (c) => {
  const kode = c.req.param("kode").toUpperCase();
  const skenario = c.req.query("skenario"); // RE_BASE | ARED | undefined (keduanya)

  const [prov] = await db
    .select()
    .from(ruptlProvinsi)
    .where(eq(ruptlProvinsi.kode, kode))
    .limit(1);
  if (!prov) return c.json({ error: "Provinsi tidak ditemukan" }, 404);

  const rows = await db
    .select()
    .from(ruptlRencanaPembangkit)
    .where(
      skenario === "RE_BASE" || skenario === "ARED"
        ? and(
            eq(ruptlRencanaPembangkit.provinsiId, prov.id),
            eq(ruptlRencanaPembangkit.skenario, skenario)
          )
        : eq(ruptlRencanaPembangkit.provinsiId, prov.id)
    );
  return c.json(rows);
});

// Rencana transmisi per provinsi
ruptlRoutes.get("/provinsi/:kode/rencana-transmisi", async (c) => {
  const kode = c.req.param("kode").toUpperCase();
  const skenario = c.req.query("skenario");
  const [prov] = await db
    .select()
    .from(ruptlProvinsi)
    .where(eq(ruptlProvinsi.kode, kode))
    .limit(1);
  if (!prov) return c.json({ error: "Provinsi tidak ditemukan" }, 404);

  const rows = await db
    .select()
    .from(ruptlRencanaTransmisi)
    .where(
      skenario === "RE_BASE" || skenario === "ARED"
        ? and(
            eq(ruptlRencanaTransmisi.provinsiId, prov.id),
            eq(ruptlRencanaTransmisi.skenario, skenario)
          )
        : eq(ruptlRencanaTransmisi.provinsiId, prov.id)
    );
  return c.json(rows);
});

// Rencana semua provinsi — rencana pembangkit nasional (untuk tabel nasional)
ruptlRoutes.get("/rencana-pembangkit", async (c) => {
  const skenario = c.req.query("skenario");
  const jenis = c.req.query("jenis");
  const codTahun = c.req.query("cod_tahun");

  const rows = await db
    .select({
      id: ruptlRencanaPembangkit.id,
      skenario: ruptlRencanaPembangkit.skenario,
      jenis: ruptlRencanaPembangkit.jenis,
      nama: ruptlRencanaPembangkit.nama,
      kapasitasMw: ruptlRencanaPembangkit.kapasitasMw,
      codTahun: ruptlRencanaPembangkit.codTahun,
      keterangan: ruptlRencanaPembangkit.keterangan,
      namaProvinsi: ruptlProvinsi.nama,
      kodeProvinsi: ruptlProvinsi.kode,
      wilayahSistem: ruptlProvinsi.wilayahSistem,
    })
    .from(ruptlRencanaPembangkit)
    .innerJoin(ruptlProvinsi, eq(ruptlRencanaPembangkit.provinsiId, ruptlProvinsi.id))
    .orderBy(ruptlRencanaPembangkit.codTahun, ruptlRencanaPembangkit.kapasitasMw);

  const filtered = rows.filter((r) => {
    if (skenario && r.skenario !== skenario) return false;
    if (jenis && r.jenis !== jenis) return false;
    if (codTahun && String(r.codTahun) !== codTahun) return false;
    return true;
  });

  return c.json(filtered);
});
