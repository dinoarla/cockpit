import "dotenv/config";
import mysql from "mysql2/promise";
import { drizzle } from "drizzle-orm/mysql2";
import * as schema from "./schema.js";
// Lazy init — pool tidak dibuat saat module load, tapi saat pertama kali db dipakai.
// Ini memastikan serve() jalan dulu sebelum ada koneksi DB apapun.
let _pool;
let _db;
function ensureInit() {
    if (_pool)
        return;
    _pool = mysql.createPool({
        host: process.env.DB_HOST ?? "localhost",
        port: Number(process.env.DB_PORT ?? 3306),
        user: process.env.DB_USER ?? "",
        password: process.env.DB_PASSWORD ?? "",
        database: process.env.DB_NAME ?? "",
        waitForConnections: true,
        connectionLimit: 10,
        maxIdle: 5,
        idleTimeout: 60_000,
        queueLimit: 0,
        ssl: process.env.DB_SSL === "true" ? { rejectUnauthorized: true } : undefined,
    });
    _db = drizzle(_pool, { schema, mode: "default" });
}
// Proxy: db dibuat saat property pertama kali diakses (saat ada request masuk),
// bukan saat module di-import.
export const db = new Proxy({}, {
    get(_, prop) {
        ensureInit();
        return Reflect.get(_db, prop);
    },
});
export function getPool() {
    ensureInit();
    return _pool;
}
// pool.end() untuk migrate.ts dan createAdmin.ts
export const pool = {
    end: async () => {
        if (_pool) {
            await _pool.end();
            _pool = undefined;
            _db = undefined;
        }
    },
};
//# sourceMappingURL=client.js.map