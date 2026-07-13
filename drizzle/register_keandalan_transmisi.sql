-- Register new module: Analitik Keandalan & Gangguan Transmisi
-- Run via phpMyAdmin on u164655286_cockpit
-- Table: domain_modules

INSERT INTO `domain_modules`
  (`domain_id`, `nama`, `slug`, `url_token`, `route_path`, `sensitivitas`, `status`, `urutan`)
VALUES
  (
    (SELECT `id` FROM `domains` WHERE `kode` = 'energi-jabar' LIMIT 1),
    'Analitik Keandalan & Gangguan Transmisi',
    'keandalan-transmisi',
    'kndltrans25',
    '/modules/energi-jabar/keandalan-transmisi/',
    'confidential',
    'active',
    40
  );
