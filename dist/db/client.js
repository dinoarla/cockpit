import "dotenv/config";
import mysql from "mysql2/promise";
import { drizzle } from "drizzle-orm/mysql2";
import * as schema from "./schema.js";
// Tidak throw di sini supaya app tetap start walau env var belum terset.
// Error akan muncul saat query pertama dijalankan (misal saat login).
function getEnv(name, fallback = "") {
    const value = process.env[name];
    if (!value) {
        console.warn(`[COCKPIT] Warning: env var ${name} tidak di-set.`);
        return fallback;
    }
    return value;
}
export const pool = mysql.createPool({
    host: getEnv("DB_HOST", "localhost"),
    port: Number(process.env.DB_PORT ?? 3306),
    user: getEnv("DB_USER"),
    password: getEnv("DB_PASSWORD"),
    database: getEnv("DB_NAME"),
    waitForConnections: true,
    connectionLimit: 10,
    maxIdle: 5,
    idleTimeout: 60_000,
    queueLimit: 0,
    ssl: process.env.DB_SSL === "true" ? { rejectUnauthorized: true } : undefined,
});
export const db = drizzle(pool, { schema, mode: "default" });
//# sourceMappingURL=client.js.map