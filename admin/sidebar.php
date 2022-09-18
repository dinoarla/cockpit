<ul class="nav">
	<?php
	if (!defined("INDEX")) header('location: index.php');

	buat_menu("horizon", "plane", "Horizon", array("admin"));

	buka_dropdown("shopping-cart", "Finance", array("admin"));
	buat_submenu("asset", "Asset Monitoring", array("admin"));
	buat_submenu("debt", "Debt Monitoring", array("admin"));
	tutup_dropdown(array("admin"));

	buat_menu("user", "file", "Dino Projects", array("admin"));
	buat_menu("user", "leaf", "Arla Industri", array("admin"));
	buat_menu("user", "book", "Dino Library", array("admin"));

	buat_menu("user", "user", "User Data", array("admin"));
	buat_menu("media", "picture", "Media", array("admin"));
	buat_menu("backuprestore", "cog", "Backup dan Restore", array("admin"));


	//buat_menu("entry", "pencil", "Entry Data", array("admin"));
	//buka_dropdown("flag", "Monitoring Gardu", array("admin"));
	//buat_submenu("report", "Laporan Pengukuran", array("admin"));
	//buat_submenu("graph", "Grafik Pembebanan", array("admin"));
	//buat_submenu("penyeimbangan", "Penyeimbangan Beban", array("admin"));
	//buat_submenu("kva", "Total kVA", array("admin"));
	//buat_submenu("trafo", "Data Trafo", array("admin"));
	//tutup_dropdown(array("admin"));

	//buka_dropdown("cog", "Pengaturan", array("admin"));
	//buat_submenu("gardu", "Data Gardu", array("admin"));
	//buat_submenu("backuprestore", "Backup dan Restore", array("admin"));
	//tutup_dropdown(array("admin"));
	?>
</ul>