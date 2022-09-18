<?php
session_start();
include "../library/config.php";
include "../library/function_antiinjection.php";
?>

<!DOCTYPE HTML>
<html>

<head>
	<title>COCKPIT - Personal Finance and Assets Monitoring Station of Dino Arla</title>
	<link rel="shortcut icon" href="images/pln_logo.png" />
	<script src="js/jquery.min.js"></script>
	<!-- Custom Theme files -->
	<link href="css/login.css" rel="stylesheet" type="text/css" media="all" />
	<!-- for-mobile-apps -->
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="keywords" content="#" />
	<!-- //for-mobile-apps -->
	<!--Google Fonts-->
	<link href='//fonts.googleapis.com/css?family=Roboto+Condensed:400,700' rel='stylesheet' type='text/css'>
</head>

<body>
	<!--header start here-->
	<div class="body"></div>
	<div class="header">


		<?php
		if (isset($_POST['login'])) {
			$username = antiinjeksi($_POST['username']);
			$password = antiinjeksi(md5($_POST['password']));

			$cekuser = $mysqli->query("SELECT * FROM tbl_user WHERE username='$username' AND password='$password'");
			$jmluser = $cekuser->num_rows;
			$data = $cekuser->fetch_array();

			if ($jmluser > 0) {

				$_SESSION['username']     = $data['username'];
				$_SESSION['nama']  		= $data['nama_lengkap'];
				$_SESSION['password']     = $data['password'];
				$_SESSION['iduser']     	= $data['id_user'];
				$_SESSION['leveluser']    = $data['level'];

				$_SESSION['timeout'] = time() + 1000;
				$_SESSION['login'] = 1;

				date_default_timezone_set('Asia/Jakarta');
				$jam = date("H:i:s");
				$tgl = date("Y-m-d");
				$ip_address = $_SERVER['REMOTE_ADDR'];
				$hostname = gethostbyaddr($_SERVER['REMOTE_ADDR']);
				$info = $_SERVER['HTTP_USER_AGENT'];

				$mysqli->query("INSERT INTO user_logging SET 
							    nama        = '$_SESSION[nama]',
							    ip_add      = '$ip_address',
							    hostname    = '$hostname',
							    browser     = '$info',
							    tgl         = '$tgl',
							    jam_in      = '$jam',
							    jam_out     = 'logged',
							    status      = 'online'
							   ");

				header('location: index.php');
			} else {
				echo '<div class="alert" role="alert"><b>Punteun!</b> Username atau password salah.</div>';
			}
		}
		?>

		<div class="header-main">
			<img class="logo" src="images/pln_logo.png"></img>
			<h1>COCKPIT</h1>
			<h4>Personal Finance and Assets Monitoring Station of Dino Arla</h4>
			<div class="header-bottom">
				<div class="header-right w3agile">

					<div class="header-left-bottom agileinfo">

						<form action="login.php" method="post">
							<input type="text" value="Username" name="username" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Username';}" />
							<input type="password" value="Password" name="password" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'password';}" />

							<input type="submit" value="Login" name="login">
						</form>
					</div>
				</div>

			</div>
		</div>
	</div>
	<!--header end here-->
	<div class="copyright">
		<p>COCKPIT - Personal Finance and Assets Monitoring Station of Dino Arla &copy; 2022. All Rights Reserved.</p>
	</div>
	<!--footer end here-->
</body>

</html>