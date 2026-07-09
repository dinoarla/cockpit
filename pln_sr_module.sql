-- PLN Sustainability Report — domain_modules registration
-- domain_id 1 = energi-jabar (sesuai screenshot)
-- url_token 12 karakter alphanumeric (max varchar 12)

INSERT INTO domain_modules
  (domain_id, slug, url_token, nama, route_path, sensitivitas, status, data_updated_at)
VALUES
  (1,
   'pln-sr',
   'n4x8sr2k7pqm',
   'PLN Sustainability Report 2014–2025',
   '/modules/energi-jabar/n4x8sr2k7pqm/',
   'internal',
   'aktif',
   '2025-12-31 00:00:00');
