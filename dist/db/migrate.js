import "dotenv/config";
import { migrate } from "drizzle-orm/mysql2/migrator";
import { db, pool } from "./client.js";
async function main() {
    console.log("Menjalankan migrasi database...");
    await migrate(db, { migrationsFolder: "./drizzle" });
    console.log("Migrasi selesai.");
    await pool.end();
}
main().catch((err) => {
    console.error("Migrasi gagal:", err);
    process.exit(1);
});
//# sourceMappingURL=migrate.js.map