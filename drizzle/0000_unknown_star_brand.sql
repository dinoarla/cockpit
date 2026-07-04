CREATE TABLE `login_audit` (
	`id` int AUTO_INCREMENT NOT NULL,
	`username` varchar(64) NOT NULL,
	`success` boolean NOT NULL,
	`ip_address` varchar(45),
	`user_agent` varchar(255),
	`reason` varchar(100),
	`created_at` timestamp NOT NULL DEFAULT (now()),
	CONSTRAINT `login_audit_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `ruptl_pelanggan_historis` (
	`id` int AUTO_INCREMENT NOT NULL,
	`provinsi_id` int NOT NULL,
	`tahun` int NOT NULL,
	`sektor` enum('RUMAH_TANGGA','BISNIS','PUBLIK','INDUSTRI') NOT NULL,
	`jumlah_ribu` decimal(10,2),
	CONSTRAINT `ruptl_pelanggan_historis_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `ruptl_pembangkit_eksisting` (
	`id` int AUTO_INCREMENT NOT NULL,
	`provinsi_id` int NOT NULL,
	`pemilik` enum('PLN','IPP') NOT NULL DEFAULT 'PLN',
	`jenis` varchar(20) NOT NULL,
	`sistem_tenaga_listrik` varchar(50),
	`jumlah_unit` int,
	`kapasitas_mw` decimal(10,2),
	`daya_mampu_mw` decimal(10,2),
	`dmp_mw` decimal(10,2),
	CONSTRAINT `ruptl_pembangkit_eksisting_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `ruptl_penjualan_historis` (
	`id` int AUTO_INCREMENT NOT NULL,
	`provinsi_id` int NOT NULL,
	`tahun` int NOT NULL,
	`sektor` enum('RUMAH_TANGGA','BISNIS','PUBLIK','INDUSTRI') NOT NULL,
	`gwh` decimal(10,2),
	CONSTRAINT `ruptl_penjualan_historis_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `ruptl_provinsi` (
	`id` int AUTO_INCREMENT NOT NULL,
	`kode` varchar(5) NOT NULL,
	`nama` varchar(100) NOT NULL,
	`lampiran` varchar(2) NOT NULL,
	`wilayah_sistem` varchar(60) NOT NULL,
	`beban_puncak_2024_mw` decimal(10,2),
	CONSTRAINT `ruptl_provinsi_id` PRIMARY KEY(`id`),
	CONSTRAINT `ruptl_provinsi_kode_unique` UNIQUE(`kode`)
);
--> statement-breakpoint
CREATE TABLE `ruptl_proyeksi_kebutuhan` (
	`id` int AUTO_INCREMENT NOT NULL,
	`provinsi_id` int NOT NULL,
	`tahun` int NOT NULL,
	`pertumbuhan_ekonomi_pct` decimal(5,2),
	`sales_gwh` decimal(10,2),
	`produksi_gwh` decimal(10,2),
	`beban_puncak_mw` decimal(10,2),
	`pelanggan` int,
	CONSTRAINT `ruptl_proyeksi_kebutuhan_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `ruptl_rencana_gardu_induk` (
	`id` int AUTO_INCREMENT NOT NULL,
	`provinsi_id` int NOT NULL,
	`skenario` enum('RE_BASE','ARED') NOT NULL,
	`tahun` int NOT NULL,
	`mva` decimal(10,2),
	CONSTRAINT `ruptl_rencana_gardu_induk_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `ruptl_rencana_pembangkit` (
	`id` int AUTO_INCREMENT NOT NULL,
	`provinsi_id` int NOT NULL,
	`skenario` enum('RE_BASE','ARED') NOT NULL,
	`jenis` varchar(30) NOT NULL,
	`nama` varchar(200),
	`kapasitas_mw` decimal(10,2),
	`cod_tahun` int,
	`keterangan` varchar(500),
	CONSTRAINT `ruptl_rencana_pembangkit_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `ruptl_rencana_transmisi` (
	`id` int AUTO_INCREMENT NOT NULL,
	`provinsi_id` int NOT NULL,
	`skenario` enum('RE_BASE','ARED') NOT NULL,
	`tahun` int NOT NULL,
	`kms` decimal(10,2),
	CONSTRAINT `ruptl_rencana_transmisi_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `sessions` (
	`id` varchar(64) NOT NULL,
	`user_id` int NOT NULL,
	`user_agent` varchar(255),
	`ip_address` varchar(45),
	`created_at` timestamp NOT NULL DEFAULT (now()),
	`expires_at` timestamp NOT NULL,
	CONSTRAINT `sessions_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `users` (
	`id` int AUTO_INCREMENT NOT NULL,
	`username` varchar(64) NOT NULL,
	`email` varchar(255) NOT NULL,
	`password_hash` varchar(255) NOT NULL,
	`role` enum('admin','editor','viewer') NOT NULL DEFAULT 'viewer',
	`is_active` boolean NOT NULL DEFAULT true,
	`failed_login_count` int NOT NULL DEFAULT 0,
	`locked_until` timestamp,
	`created_at` timestamp NOT NULL DEFAULT (now()),
	`updated_at` timestamp NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
	CONSTRAINT `users_id` PRIMARY KEY(`id`),
	CONSTRAINT `users_username_unique` UNIQUE(`username`),
	CONSTRAINT `users_email_unique` UNIQUE(`email`)
);
--> statement-breakpoint
CREATE INDEX `login_audit_username_idx` ON `login_audit` (`username`);--> statement-breakpoint
CREATE INDEX `login_audit_created_at_idx` ON `login_audit` (`created_at`);--> statement-breakpoint
CREATE INDEX `pelanggan_prov_tahun_idx` ON `ruptl_pelanggan_historis` (`provinsi_id`,`tahun`);--> statement-breakpoint
CREATE INDEX `pembangkit_eks_prov_idx` ON `ruptl_pembangkit_eksisting` (`provinsi_id`);--> statement-breakpoint
CREATE INDEX `penjualan_prov_tahun_idx` ON `ruptl_penjualan_historis` (`provinsi_id`,`tahun`);--> statement-breakpoint
CREATE INDEX `proyeksi_prov_tahun_idx` ON `ruptl_proyeksi_kebutuhan` (`provinsi_id`,`tahun`);--> statement-breakpoint
CREATE INDEX `gi_prov_sken_tahun_idx` ON `ruptl_rencana_gardu_induk` (`provinsi_id`,`skenario`,`tahun`);--> statement-breakpoint
CREATE INDEX `rencana_prov_sken_idx` ON `ruptl_rencana_pembangkit` (`provinsi_id`,`skenario`);--> statement-breakpoint
CREATE INDEX `rencana_cod_idx` ON `ruptl_rencana_pembangkit` (`cod_tahun`);--> statement-breakpoint
CREATE INDEX `transmisi_prov_sken_tahun_idx` ON `ruptl_rencana_transmisi` (`provinsi_id`,`skenario`,`tahun`);--> statement-breakpoint
CREATE INDEX `sessions_user_id_idx` ON `sessions` (`user_id`);--> statement-breakpoint
CREATE INDEX `sessions_expires_at_idx` ON `sessions` (`expires_at`);