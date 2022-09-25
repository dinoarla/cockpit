<?php
session_start();
ob_start();
define("INDEX", true);

//Panggil semua file yang diperlukan pada folder library
include "../library/config.php";
include "../library/function_seo.php";
include "../library/function_menu.php";
include "../library/function_table.php";
include "../library/function_form.php";
include "../library/function_date.php";
include "../library/function_rupiah.php";
include "../library/function_number.php";

//Mengatur batas timeout
$timeout = $_SESSION['timeout'];
if (time() < $timeout) {
	$_SESSION['timeout'] = time() + 5000;
} else {
	$_SESSION['login'] = 0;
}

//Mengecek status login
if (empty($_SESSION['username']) or empty($_SESSION['password']) or $_SESSION['login'] == 0) {
	header('location: login.php');
} else {
?>

	<html>

	<head>
		<title>COCKPIT - Personal Finance and Assets Monitoring Station of Dino Arla</title>

		<meta charset="utf-8" />
		<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />

		<link rel="stylesheet" type="text/css" href="../plugin/bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="../plugin/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" />
		<link rel="stylesheet" type="text/css" href="css/style.css" />

		<link rel="shortcut icon" href="images/pln_logo.png" />
		<script type="text/javascript" src="../plugin/jquery/jquery-2.0.2.min.js"></script>

		<script src="../plugin/highcharts/code/highcharts.js"></script>
		<script src="../plugin/highcharts/code/highcharts-3d.js"></script>
		<script src="../plugin/highcharts/code/modules/data.js"></script>
		<script src="../plugin/highcharts/code/modules/cylinder.js"></script>
		<script src="../plugin/highcharts/code/modules/funnel3d.js"></script>
		<script src="../plugin/highcharts/code/modules/exporting.js"></script>


	</head>

	<body>

		<nav class="navbar navbar-inverse navbar-fixed-top">
			<div class="container-fluid">
				<?php include "menu.php"; ?>
			</div>
		</nav>

		<section class="container-fluid">
			<div class="row">
				<div class="col-md-2 col-sm-3 hidden-xs sidebar">
					<?php include "sidebar.php"; ?>
				</div>
				<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
					<?php include "content.php"; ?>
				</div>
			</div>
		</section>

		<footer class="navbar navbar-fixed-bottom footer">
			<div class="container-fluid">
				<p class="text-center">Copyright © 2022. COCKPIT. All right reserved.</p>
			</div>
		</footer>


		<script type="text/javascript" src="../plugin/bootstrap/js/bootstrap.min.js"></script>

		<script type="text/javascript" src="../plugin/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
		<link type="text/css" rel="stylesheet" href="../plugin/dataTables/css/dataTables.bootstrap.css">

		<script type="text/javascript" src="../plugin/dataTables/js/jquery.dataTables.min.js"></script>
		<script type="text/javascript" src="../plugin/dataTables/js/dataTables.bootstrap.min.js"></script>

		<link rel="stylesheet" type="text/css" href="../plugin/bootstrap/css/pe-icon-7-stroke.css" />

		<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
		<link href='https://fonts.googleapis.com/css?family=Roboto:400,700,300' rel='stylesheet' type='text/css'>

		<script type="text/javascript" src="js/myscript.js"></script>
	</body>


	</html>

<?php } ?>