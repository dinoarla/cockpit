import { Hono } from "hono";
import { eq, and, ne, inArray } from "drizzle-orm";
import { db } from "../db/client.js";
import { domains, domainModules, userDomainAccess, userModuleAccess } from "../db/schema.js";
import { requireAuth } from "../middleware/auth.js";

export const domainRoutes = new Hono();
domainRoutes.use("*", requireAuth);

/**
 * GET /api/domains
 * Mengembalikan daftar domain + modul yang bisa diakses user yang sedang login.
 * - Admin: semua domain aktif + modul aktif & draft (bukan arsip)
 * - Non-admin: hanya domain yang ada di user_domain_access + modul aktif saja
 */
domainRoutes.get("/", async (c) => {
  const user = c.get("user");

  let accessibleDomains: (typeof domains.$inferSelect)[];

  if (user.role === "admin") {
    accessibleDomains = await db
      .select()
      .from(domains)
      .where(eq(domains.isActive, true));
  } else {
    const rows = await db
      .select({ domain: domains })
      .from(userDomainAccess)
      .innerJoin(domains, eq(userDomainAccess.domainId, domains.id))
      .where(and(eq(userDomainAccess.userId, user.id), eq(domains.isActive, true)));
    accessibleDomains = rows.map((r) => r.domain);
  }

  const result = await Promise.all(
    accessibleDomains.map(async (domain) => {
      let mods;
      if (user.role === "admin") {
        mods = await db
          .select()
          .from(domainModules)
          .where(and(eq(domainModules.domainId, domain.id), ne(domainModules.status, "arsip")));
      } else {
        // Cek apakah user punya pembatasan per-modul
        const modAccess = await db
          .select({ moduleId: userModuleAccess.moduleId })
          .from(userModuleAccess)
          .where(eq(userModuleAccess.userId, user.id));

        if (modAccess.length > 0) {
          // Ada pembatasan spesifik — hanya tampilkan modul yang diizinkan
          const allowedIds = modAccess.map((m) => m.moduleId);
          mods = await db
            .select()
            .from(domainModules)
            .where(and(
              eq(domainModules.domainId, domain.id),
              eq(domainModules.status, "aktif"),
              inArray(domainModules.id, allowedIds)
            ));
        } else {
          // Tidak ada pembatasan — tampilkan semua modul aktif di domain
          mods = await db
            .select()
            .from(domainModules)
            .where(and(eq(domainModules.domainId, domain.id), eq(domainModules.status, "aktif")));
        }
      }
      return { ...domain, modules: mods };
    })
  );

  return c.json(result);
});
