<?php
if (!defined("INDEX")) header('location: index.php');
?>
<div class="navbar-header">
	<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar">
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
	</button>
	<a class="navbar-brand" href="?content=horizon">COCKPIT</a>
</div>

<div id="navbar" class="navbar-collapse collapse">
	<ul class="nav navbar-nav visible-xs">
		<?php
		buat_menu("horizon", "plane", "Horizon", array("admin"));

		buka_dropdown("usd", "Financial Health Station", array("admin"));
		buat_submenu("asset", "Asset Monitoring", array("admin"));
		buat_submenu("debt", "Debt Monitoring", array("admin"));
		buat_submenu("budget", "Monthly Budget", array("admin"));
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

		?>
	</ul>
	<ul class="nav navbar-nav navbar-right">
		<li><a><i class="glyphicon glyphicon-user"></i> Halo,
				<?php echo "$_SESSION[nama]"; ?> (Level: <?php echo "$_SESSION[leveluser]"; ?> )</a></li>
		<li><a href="logout.php"><i class="glyphicon glyphicon-log-out"></i> Keluar</a></li>
	</ul>
</div>