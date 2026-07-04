// server.js — entry point untuk Hostinger
// File ini mencetak diagnostics sebelum load app utama
// sehingga error apapun akan terlihat di logs

console.log("[COCKPIT-BOOT] Starting...");
console.log("[COCKPIT-BOOT] Node version:", process.version);
console.log("[COCKPIT-BOOT] PORT:", process.env.PORT ?? "(not set, will use 3000)");
console.log("[COCKPIT-BOOT] CWD:", process.cwd());
console.log("[COCKPIT-BOOT] NODE_ENV:", process.env.NODE_ENV ?? "(not set)");

import("./dist/index.js").then(() => {
  console.log("[COCKPIT-BOOT] dist/index.js loaded OK");
}).catch((err) => {
  console.error("[COCKPIT-BOOT] FATAL - dist/index.js failed to load:");
  console.error("[COCKPIT-BOOT]", err.message);
  console.error("[COCKPIT-BOOT]", err.stack);
  process.exit(1);
});
