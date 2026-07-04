CREATE TABLE `dataset_sources` (
	`id` int AUTO_INCREMENT NOT NULL,
	`domain_module_id` int NOT NULL,
	`nama_sumber` varchar(255) NOT NULL,
	`jenis_sumber` varchar(100),
	`url_atau_referensi` text,
	`tanggal_akses` date,
	`catatan_metodologi` text,
	`created_at` timestamp NOT NULL DEFAULT (now()),
	CONSTRAINT `dataset_sources_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `domain_modules` (
	`id` int AUTO_INCREMENT NOT NULL,
	`domain_id` int NOT NULL,
	`slug` varchar(50) NOT NULL,
	`nama` varchar(150) NOT NULL,
	`route_path` varchar(100) NOT NULL,
	`sensitivitas` enum('publik','internal','sensitif') NOT NULL DEFAULT 'internal',
	`status` enum('aktif','draft','arsip') NOT NULL DEFAULT 'draft',
	`created_at` timestamp NOT NULL DEFAULT (now()),
	CONSTRAINT `domain_modules_id` PRIMARY KEY(`id`),
	CONSTRAINT `domain_modules_domain_slug_uniq` UNIQUE(`domain_id`,`slug`)
);
--> statement-breakpoint
CREATE TABLE `domains` (
	`id` int AUTO_INCREMENT NOT NULL,
	`slug` varchar(50) NOT NULL,
	`nama` varchar(150) NOT NULL,
	`deskripsi` text,
	`is_active` boolean NOT NULL DEFAULT true,
	`created_at` timestamp NOT NULL DEFAULT (now()),
	CONSTRAINT `domains_id` PRIMARY KEY(`id`),
	CONSTRAINT `domains_slug_unique` UNIQUE(`slug`)
);
--> statement-breakpoint
CREATE TABLE `user_domain_access` (
	`user_id` int NOT NULL,
	`domain_id` int NOT NULL,
	`access_level` enum('read','write','admin') NOT NULL,
	`granted_at` timestamp NOT NULL DEFAULT (now()),
	`granted_by` int,
	CONSTRAINT `user_domain_access_user_id_domain_id_pk` PRIMARY KEY(`user_id`,`domain_id`)
);
