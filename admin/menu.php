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
		buat_menu("horizon", "home", "Horizon", array("admin"));
		buat_menu("asset", "flag", "Asset Monitoring", array("admin"));
		buat_menu("debt", "flag", "Debt Monitoring", array("admin"));
		buat_menu("user", "user", "User Data", array("admin"));
		buat_menu("media", "picture", "Media", array("admin"));
		buat_menu("backuprestore", "cog", "Backup dan Restore", array("admin"));

		?>
	</ul>
	<ul class="nav navbar-nav navbar-right">
		<li><a><i class="glyphicon glyphicon-user"></i> Halo,
				<?php echo "$_SESSION[nama]"; ?> (Level: <?php echo "$_SESSION[leveluser]"; ?> )</a></li>
		<li><a href="logout.php"><i class="glyphicon glyphicon-log-out"></i> Keluar</a></li>
	</ul>
</div>