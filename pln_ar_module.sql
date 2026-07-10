-- PLN Annual Report 2025 — domain_modules registration
-- domain_id 1 = energi-jabar
-- url_token 12 karakter alphanumeric (max varchar 12)

INSERT INTO domain_modules
  (domain_id, slug, url_token, nama, route_path, sensitivitas, status, data_updated_at)
VALUES
  (1,
   'pln-ar',
   'ar25plnjbi9k',
   'PLN Annual Report 2025',
   '/modules/energi-jabar/ar25plnjbi9k/',
   'internal',
   'aktif',
   '2025-12-31 00:00:00');
