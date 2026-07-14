-- Register new module: Kependudukan BPS — Jawa Barat
-- Run via phpMyAdmin on u164655286_cockpit
-- Table: domain_modules

INSERT INTO `domain_modules`
  (`domain_id`, `nama`, `slug`, `url_token`, `route_path`, `sensitivitas`, `status`, `urutan`)
VALUES
  (
    (SELECT `id` FROM `domains` WHERE `kode` = 'open-data-nasional' LIMIT 1),
    'Kependudukan BPS — Jawa Barat',
    'kependudukan-bps',
    'kpddkbps25',
    '/modules/open-data-nasional/kependudukan-bps/',
    'public',
    'active',
    10
  );
