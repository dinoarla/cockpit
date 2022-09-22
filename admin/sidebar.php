<ul class="nav">
	<?php
	if (!defined("INDEX")) header('location: index.php');

	buat_menu("horizon", "plane", "Horizon", array("admin"));

	buka_dropdown("usd", "Financial Health Station", array("admin"));
	buat_submenu("asset", "Asset Monitoring", array("admin"));
	buat_submenu("debt", "Debt Monitoring", array("admin"));
	buat_submenu("budget", "Expense Budget", array("admin"));
	buat_submenu("cashin", "Cash In", array("admin"));
	buat_submenu("cashout", "Cash Out", array("admin"));
	tutup_dropdown(array("admin"));

	buka_dropdown("road", "Road to Jannah", array("admin"));
	buat_submenu("#", "Qur'an Memorize", array("admin"));
	buat_submenu("#", "Hadits Memorize", array("admin"));
	tutup_dropdown(array("admin"));

	buka_dropdown("globe", "The Synapse", array("admin"));
	buat_submenu("#", "Education", array("admin"));
	buat_submenu("#", "Skill", array("admin"));
	buat_submenu("#", "Personal Achievement", array("admin"));
	tutup_dropdown(array("admin"));

	buat_menu("user", "file", "Dino Projects Archive", array("admin"));
	buat_menu("user", "book", "Digital Library", array("admin"));
	buat_menu("media", "cloud", "Personal Cloud", array("admin"));

	buat_menu("user", "user", "User Data", array("admin"));

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