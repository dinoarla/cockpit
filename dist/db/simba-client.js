import mysql from "mysql2/promise";
import { drizzle } from "drizzle-orm/mysql2";
// Separate connection to u164655286_simba DB.
// Set SIMBA_DB_HOST / SIMBA_DB_USER / SIMBA_DB_PASSWORD / SIMBA_DB_NAME in .env.
// If not configured, all routes using simbaDb return 503 gracefully.
let _pool;
let _db;
function ensureInit() {
    if (_pool)
        return;
    const user = process.env.SIMBA_DB_USER;
    if (!user)
        throw new Error("SIMBA_DB_USER not configured");
    _pool = mysql.createPool({
        host: process.env.SIMBA_DB_HOST ?? process.env.DB_HOST ?? "localhost",
        port: Number(process.env.SIMBA_DB_PORT ?? process.env.DB_PORT ?? 3306),
        user,
        password: process.env.SIMBA_DB_PASSWORD ?? "",
        database: process.env.SIMBA_DB_NAME ?? "u164655286_simba",
        waitForConnections: true,
        connectionLimit: 5,
        maxIdle: 2,
        idleTimeout: 60_000,
        queueLimit: 0,
    });
    _db = drizzle(_pool, { mode: "default" });
}
export const simbaDb = new Proxy({}, {
    get(_, prop) {
        ensureInit();
        return Reflect.get(_db, prop);
    },
});
//# sourceMappingURL=simba-client.js.map