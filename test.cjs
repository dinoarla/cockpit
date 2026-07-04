// Test file: pure Node.js, zero npm packages, CommonJS
// Tujuan: membuktikan apakah Hostinger bisa menjalankan Node.js apapun
const http = require("http");

const port = Number(process.env.PORT) || 3000;

const server = http.createServer((req, res) => {
  res.writeHead(200, { "Content-Type": "application/json" });
  res.end(JSON.stringify({
    ok: true,
    port,
    node: process.version,
    url: req.url,
    ts: new Date().toISOString(),
  }));
});

server.listen(port, "0.0.0.0", () => {
  console.log("TEST SERVER running on port", port);
});
