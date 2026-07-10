import "dotenv/config";
import { db, pool } from "../db/client.js";
import { domainModules, domains } from "../db/schema.js";
import { eq, and } from "drizzle-orm";
import { randomBytes } from "node:crypto";
// Script: aktifkan modul + generate urlToken
// Usage: npx tsx src/scripts/activateModule.ts <domain-slug> <module-slug>
// Example: npx tsx src/scripts/activateModule.ts energi-jabar financial-information
async function main() {
    const domainSlug = process.argv[2];
    const moduleSlug = process.argv[3];
    if (!domainSlug || !moduleSlug) {
        console.error("Usage: npx tsx src/scripts/activateModule.ts <domain-slug> <module-slug>");
        process.exit(1);
    }
    const [domain] = await db.select().from(domains).where(eq(domains.slug, domainSlug)).limit(1);
    if (!domain) {
        console.error(`Domain '${domainSlug}' tidak ditemukan.`);
        process.exit(1);
    }
    const [mod] = await db.select().from(domainModules)
        .where(and(eq(domainModules.domainId, domain.id), eq(domainModules.slug, moduleSlug)))
        .limit(1);
    if (!mod) {
        console.error(`Modul '${moduleSlug}' tidak ditemukan di domain '${domainSlug}'.`);
        process.exit(1);
    }
    const token = mod.urlToken ?? randomBytes(6).toString("hex"); // 12 char hex
    await db.update(domainModules)
        .set({
        status: "aktif",
        urlToken: token,
        dataUpdatedAt: new Date(),
    })
        .where(eq(domainModules.id, mod.id));
    console.log(`✓ Modul '${moduleSlug}' diaktifkan.`);
    console.log(`  URL Token : ${token}`);
    console.log(`  Route     : /modules/${domainSlug}/${token}/`);
    await pool.end();
}
main().catch((e) => { console.error(e); process.exit(1); });
//# sourceMappingURL=activateModule.js.map