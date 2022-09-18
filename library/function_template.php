<?php
// Fungsi untuk mendapatkan data pada tabel setting
function web_info($parameter){
	global $mysqli;
	$query = $mysqli->query("SELECT * FROM setting WHERE parameter='$parameter'");
	$setting = $query->fetch_array();
	return $setting['nilai'];
}

// Fungsi untuk mendapatkan nama folder template yang aktif
function folder_template(){
	global $mysqli;
	$qtemplate = $mysqli->query("SELECT * FROM template WHERE aktif='Y'");
	$tpl = $qtemplate->fetch_array();
	return 'template/'.$tpl['folder'];
}

// Fungsi untuk memembuat meta header, judul website, memanggil bootstrap dan jquery
function meta_header(){
	global $mysqli;
		
	$content = (isset($_GET['content'])) ? $_GET['content'] : "home";
	if($content=="artikel"){
		$qartikel = $mysqli->query("SELECT * FROM artikel WHERE id_artikel='$_GET[id]'");
		$artikel = $qartikel->fetch_array();
		
		$judul = $artikel['judul'].' - '.web_info('judul');
		$deskripsi = $artikel['judul'];
		$keyword = $artikel['tag'];
	}else{
		$judul = web_info('judul');
		$deskripsi = web_info('deskripsi');
		$keyword = web_info('keyword');
	}	
		
	$icon = web_info('url')."/media/source/".web_info('ikon');
	
	echo'<title>'.$judul.'</title>

		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="robots" content="index, follow">
		<meta name="description" content="'.$deskripsi.'">
		<meta name="keywords" content="'.$keyword.'">
		<meta http-equiv="Copyright" content="'.web_info('url').'">
		<meta name="author" content="Dino Arla">
		<meta name="language" content="Indonesia">
		<meta name="revisit-after" content="7">
		<meta name="webcrawlers" content="all">
		<meta name="rating" content="general">
		<meta name="spiders" content="all">
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<meta name="generator" content="Base Enam Empat">
        <meta name="theme-color" content="#2a2b2f">
		
		<link rel="shortcut icon" href="'.$icon.'" />

		<link href="https://fonts.googleapis.com/css?family=Poppins:400,600,300%7COpen+Sans:400,300,700" rel="stylesheet" type="text/css">

		<link rel="stylesheet" type="text/css" href="'.web_info('url').'/'.folder_template().'/assets/vendor/revo-slider/css/settings-custom.css">
		<link rel="stylesheet" type="text/css" href="'.web_info('url').'/'.folder_template().'/assets/vendor/revo-slider/css/navigation.css">
		<link rel="stylesheet" type="text/css" href="'.web_info('url').'/'.folder_template().'/assets/vendor/revo-slider/css/navigation-skins/hermes-custom.css">
		<link rel="stylesheet" type="text/css" href="'.web_info('url').'/'.folder_template().'/assets/vendor/bootstrap/css/bootstrap.min.css">

		<link rel="stylesheet" type="text/css" href="'.web_info('url').'/'.folder_template().'/assets/css/icons-fonts.css">
		<link rel="stylesheet" type="text/css" href="'.web_info('url').'/'.folder_template().'/assets/css/animate.min.css">
		<link rel="stylesheet" type="text/css" href="'.web_info('url').'/'.folder_template().'/assets/css/style.css">
				
		<script src="https://www.google.com/recaptcha/api.js"></script>';	
}

// Fungsi untuk menampilkan template header pada folder template
function template_header(){
	include folder_template()."/header.php";
}

// Fungsi untuk menampilkan kontak
function kontak_tampil(){
	global $mysqli;
	//Mengatur validasi form komentar dan menyimpan komentar ke database
	if(isset($_POST['kirim-komentar'])){
		$msg = '';
		if(trim($_POST['nama'])=="") $msg .= '<li><code>Nama belum diisi</code></li>';
		if(trim($_POST['email'])=="") $msg .= '<li><code>Email belum diisi</code></li>';
		if(trim($_POST['komentar'])=="") $msg .= '<li><code>Komentar belum diisi</code></li>';
		 
		$email_pattern = '/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/';  
		if(!preg_match($email_pattern, $_POST['email'])) $msg .= '<li><code>Email tidak valid</code></li>';
		
		
		if($msg==''){
			$nama = antiinjeksi($_POST['nama']);
			$email = antiinjeksi($_POST['email']);
			$komentar = antiinjeksi($_POST['komentar']);
			$tgl = date("Y-m-d");
			
			
			$quser = $mysqli->query("SELECT * FROM user WHERE level='admin'");
			$rus = $quser->fetch_array();
			$pesan = "$nama mengirim pesan pada website ".web_info('judul');
			mail($rus['email'], "Komentar Website", $pesan);
			
			$mysqli->query("INSERT INTO inbox SET
				nama = '$nama',
				email = '$email',
				inbox = '$komentar',
				tanggal = '$tgl'
			");
			

			echo'<div><ul class="contact">Pesan Sukses Terkirim. Terima kasih telah berkunjung di Base Enam Empat.</div>
			<script> window.location.href="'.web_info('url').'/#three";</script>';
		}else{
			echo'<ul class="contact">'.$msg.'</ul>
				<script> window.location.href="#three";</script>';
		}
	}
	
	//Menampilkan form komentar
	echo'<form method="post" class="form-horizontal form-komentar" id="form-komentar">';
	
	echo'<div class="field half first">
			<label for="nama" class="col-sm-2 control-label">Nama</label>
			<div class="col-sm-6">
			  <input type="text" class="form-control" name="nama" id="nama">
			</div>
		 </div>';
		 
	echo'<div class="field half">
			<label for="email" class="col-sm-2 control-label">Email</label>
			<div class="col-sm-6">
			  <input type="text" class="form-control" name="email" id="email">
			</div>
		 </div>';
		 
	echo'<div class="field">
			<label for="komentar" class="col-sm-2 control-label">Message</label>
			<div class="col-sm-10">
			  <textarea class="form-control" name="komentar" id="komentar" rows="5"></textarea>
			</div>
		 </div>';
		 
	echo'<div class="action">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" class="btn btn-default" name="kirim-komentar">
					Kirim Pesan
				</button>
			</div>
		</div>
	</form>
	<section>
		<ul class="contact">
			<li>
				<h3>Address</h3>
				<span>'.web_info('lokasi').'</span>
			</li>
			<li>
				<h3>Email</h3>
				<a href="mailto:'.web_info('email').'">'.web_info('email').'</a>
			</li>
			<li>
				<h3>Phone</h3>
				<a href="tel:'.web_info('phone').'">'.web_info('phone').'</a>
			</li>
			<li>
				<h3>Social</h3>
				<ul class="icons">
					<li><a href="'.web_info('fb').'" class="fa-facebook"><span class="label">Facebook</span></a></li>
					<li><a href="'.web_info('pinterest').'" class="fa-pinterest"><span class="label">Pinterest</span></a></li>
					<li><a href="'.web_info('ig').'" class="fa-instagram"><span class="label">Instagram</span></a></li>
					<li><a href="'.web_info('skype').'" class="fa-skype"><span class="label">Skype</span></a></li>
				</ul>
			</li>
		</ul>
	</section>';
}


// Fungsi untuk menampilkan layanan
function info_layanan(){
	global $mysqli;
	$query = $mysqli->query("SELECT * FROM service");
	while($hasil = $query->fetch_array()){
	echo'<section>
		<span class="icon major '.$hasil['logo'].'"></span>
		<h3>'.$hasil['judul'].'</h3>
		<p>'.$hasil['deskripsi'].'</p>
	</section>';
	}
}

// Fungsi untuk menentukan link menu sesuai dengan jenis link (halaman, kategori atau URL)
function cari_link($rmenu){	
	global $mysqli;
	
	if($rmenu['jenis_link'] == "halaman"){
		$qhalaman = $mysqli->query("SELECT * FROM halaman WHERE id_halaman='$rmenu[link]'");
		$rhal = $qhalaman->fetch_array();
		$link = web_info('url')."/f/$rmenu[link]/$rhal[judul_seo]";
	}elseif($rmenu['jenis_link'] == "kategori"){
		$qkategori = $mysqli->query("SELECT * FROM kategori WHERE id_kategori='$rmenu[link]'");
		$rkat = $qkategori->fetch_array();
		$link = web_info('url')."/c/$rmenu[link]/$rkat[kategori_seo]";
	}else{
		$link = $rmenu['link'];
	}
	
	return $link;
}

// Fungsi untuk menampilkan menu
function template_intro_portfolio($kategori='intro'){
	global $mysqli;					
	$qmenu = $mysqli->query("SELECT * FROM menu WHERE kategori_menu='$kategori' AND induk='0' ORDER BY urut");
		while($menu = $qmenu->fetch_array()){
			echo'<li>
				<a href="#one" class="button special scrolly">Learn more</a>&nbsp;
					<a href="'.cari_link($menu).'" class="button">'.$menu['judul'].'</a>
						</li>';			
	}
}

function template_menu($kategori='main'){
	global $mysqli;					
	$qmenu = $mysqli->query("SELECT * FROM menu WHERE kategori_menu='$kategori' AND induk='0' ORDER BY urut");
		while($menu = $qmenu->fetch_array()){
			echo'<li><a href="'.cari_link($menu).'">'.$menu['judul'].'</a></li>';			
	
	}
}


function template_footer($kategori='secondary'){
	global $mysqli;					
	$qmenu = $mysqli->query("SELECT * FROM menu WHERE kategori_menu='$kategori' AND induk='0' ORDER BY urut");
		while($menu = $qmenu->fetch_array()){
			echo'<li><a href="'.cari_link($menu).'">'.$menu['judul'].'</a></li>';			
	
	}
}


// Fungsi untuk menampilkan daftar fitur
function template_fitur($template, $panjang=300){	
	global $mysqli;
	
	$qfitur = $mysqli->query("SELECT * FROM halaman ORDER BY id_halaman ASC");
	while($r = $qfitur->fetch_array()){
		$template_fitur = $template;
		$link = web_info('url')."/f/$r[id_halaman]/$r[judul_seo]";
		$template_fitur = str_replace('{link}', $link, $template_fitur);
		
		if($r['gambar'] != "") $gambar = web_info('url')."/media/source/".$r['gambar'];
		else $gambar = web_info('url')."/media/source/blank.png";
		$template_fitur = str_replace('{gambar}',	$gambar, $template_fitur);
		
		
		$template_fitur = str_replace('{judul}', $r['judul'], $template_fitur);
		$template_fitur = str_replace('{tagline}', $r['tagline'], $template_fitur);
		
		$konten = substr($r['isi'], 0, $panjang);
		$konten = substr($r['isi'], 0, strrpos($konten, " ") );
		$konten = str_replace("../media/", web_info('url')."/media/", $konten);
		$template_fitur = str_replace('{konten}', $konten, $template_fitur);
		
		echo $template_fitur;
	}
}

// Fungsi untuk menampilkan artikel detail
function template_fitur_detail($template){	
	global $mysqli;
	
	$qartikel = $mysqli->query("SELECT * FROM halaman WHERE id_halaman='$_GET[id]'");
	$r = $qartikel->fetch_array();
	
		
	//Menampilkan artikel detail
		$template_fitur = $template;
		
		if($r['gambar'] != "") $gambar = web_info('url')."/media/source/".$r['gambar'];
		else $gambar = web_info('url')."/media/source/blank.png";
		$template_fitur = str_replace('{gambar}', $gambar, $template_fitur);
		
		$template_fitur = str_replace('{judul}', $r['judul'], $template_fitur);
		$template_fitur = str_replace('{tagline}', $r['tagline'], $template_fitur);
		
		$quser = $mysqli->query("SELECT * FROM user WHERE id_user='$r[id_user]'");
		$u = $quser->fetch_array();			
		$meta= $u['nama_lengkap'].' | '.$r['hari'].', '.tgl_indonesia($r['tanggal']).' '.$r['jam'].' WIB'; 
		$template_fitur = str_replace('{meta}', $meta, $template_fitur);
		
		$konten = str_replace("../media/", web_info('url')."/media/", $r['isi']);
		$template_fitur = str_replace('{konten}', $konten, $template_fitur);
		
		echo $template_fitur;
		
		//Update Page View
		date_default_timezone_set('Asia/Jakarta');
	 	$jam = date("H:i:s");
		$tgl = date("Y-m-d");
		$ip_address=$_SERVER['REMOTE_ADDR'];
		$hostname=gethostbyaddr($_SERVER['REMOTE_ADDR']);
		$info=$_SERVER['HTTP_USER_AGENT'];

		

		if($r['id_halaman'] == "2"){
			$mysqli->query("INSERT INTO page_view
						(`tanggal`,`jam`,`utama`,`iot`,`webdev`,`course`,`ip_add`,`hostname`,`browser`)
						VALUES('$tgl','$jam','0','1','0','0','$ip_address','$hostname','$info')");
			
			//Menampilkan form komentar
			echo'<hr /><section id="form-order">
					<h2>Form Order IoT</h2>
					<blockquote>Just a basic form. Form ini hanya digunakan untuk <b>pemesanan</b> produk Internet of Things (IoT), 
					tidak untuk melakukan konsultasi atau tanya jawab seputar produk. </blockquote>
					<form method="post" class="form-horizontal form-komentar" id="form-komentar">';
			
			echo'<div class="field half first">
					<div class="col-sm-6">
					  <input type="text" class="form-control" name="nama" id="nama" placeholder="Nama">
					</div>
				 </div>';
				 
			echo'<div class="field half">
					<div class="col-sm-6">
					  <input type="text" class="form-control" name="email" id="email" placeholder="Email">
					</div>
				 </div>';

			echo'<div class="field half first">
					<div class="col-sm-6">
					  <input type="number" class="form-control" name="no_hp" id="no_hp" placeholder="Phone Number" maxlength="13">
					</div>
				 </div>';
				 
			echo'<div class="field half">
					<div class="col-sm-6">
					  <div class="select-wrapper">
						<select name="produk" id="produk">
							<option value="">- Pilih Produk -</option>
							<option value="1">Manufacturing</option>
							<option value="1">Shipping</option>
							<option value="1">Administration</option>
							<option value="1">Human Resources</option>
						</select>
					</div>
					</div>
				 </div>';
				 
			echo'<div class="field">
					<div class="col-sm-10">
					  <textarea class="form-control" name="pesan" id="pesan" rows="5" placeholder="Tulis pesan anda disini..."></textarea>
					</div>
				 </div>';
				 
			echo'<div class="action">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="submit" class="btn btn-default" name="kirim-komentar">
							Pesan
						</button>
					</div>
				</div>
			</form></section>';

		}elseif($r['id_halaman'] == "3"){
			$mysqli->query("INSERT INTO page_view
						(`tanggal`,`jam`,`utama`,`iot`,`webdev`,`course`,`ip_add`,`hostname`,`browser`)
						VALUES('$tgl','$jam','0','0','1','0','$ip_address','$hostname','$info')");

			//Menampilkan form komentar
			echo'<hr /><section id="form-order">
					<h2>Form Order Web/App Development</h2>
					<blockquote>Just a basic form. Form ini hanya digunakan untuk <b>pemesanan</b> produk Web/App Development, 
					tidak untuk melakukan konsultasi atau tanya jawab seputar produk. </blockquote>
					<form method="post" class="form-horizontal form-komentar" id="form-komentar">';
			
			echo'<div class="field half first">
					<div class="col-sm-6">
					  <input type="text" class="form-control" name="nama" id="nama" placeholder="Nama">
					</div>
				 </div>';
				 
			echo'<div class="field half">
					<div class="col-sm-6">
					  <input type="text" class="form-control" name="email" id="email" placeholder="Email">
					</div>
				 </div>';

			echo'<div class="field half first">
					<div class="col-sm-6">
					  <input type="number" class="form-control" name="no_hp" id="no_hp" placeholder="Phone Number" maxlength="13">
					</div>
				 </div>';
				 
			echo'<div class="field half">
					<div class="col-sm-6">
					  <div class="select-wrapper">
						<select name="produk" id="produk">
							<option value="">- Pilih Produk -</option>
							<option value="1">Andrena</option>
							<option value="2">Apidae</option>
							<option value="3">Carpenter Bee</option>
							<option value="4">Bumblebee</option>
							<option value="5">Sweat Bee</option>
						</select>
					</div>
					</div>
				 </div>';
				 
			echo'<div class="field">
					<div class="col-sm-10">
					  <textarea class="form-control" name="pesan" id="pesan" rows="5" placeholder="Tulis pesan anda disini..."></textarea>
					</div>
				 </div>';
				 
			echo'<div class="action">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="submit" class="btn btn-default" name="kirim-komentar">
							Pesan
						</button>
					</div>
				</div>
			</form></section>';

		}elseif($r['id_halaman'] == "4"){
			$mysqli->query("INSERT INTO page_view
						(`tanggal`,`jam`,`utama`,`iot`,`webdev`,`course`,`ip_add`,`hostname`,`browser`)
						VALUES('$tgl','$jam','0','0','0','1','$ip_address','$hostname','$info')");

			//Menampilkan form komentar
			echo'<hr /><section id="form-order">
					<h2>Form Order Programming Course</h2>
					<blockquote>Just a basic form. Form ini hanya digunakan untuk <b>pemesanan</b> produk Programming Course, 
					tidak untuk melakukan konsultasi atau tanya jawab seputar produk. </blockquote>
					<form method="post" class="form-horizontal form-komentar" id="form-komentar">';
			
			echo'<div class="field half first">
					<div class="col-sm-6">
					  <input type="text" class="form-control" name="nama" id="nama" placeholder="Nama">
					</div>
				 </div>';
				 
			echo'<div class="field half">
					<div class="col-sm-6">
					  <input type="text" class="form-control" name="email" id="email" placeholder="Email">
					</div>
				 </div>';

			echo'<div class="field half first">
					<div class="col-sm-6">
					  <input type="number" class="form-control" name="no_hp" id="no_hp" placeholder="Phone Number" maxlength="13">
					</div>
				 </div>';
				 
			echo'<div class="field half">
					<div class="col-sm-6">
					  <div class="select-wrapper">
						<select name="produk" id="produk">
							<option value="">- Pilih Produk -</option>
							<option value="6">Eggs</option>
							<option value="7">Larvae</option>
							<option value="8">Pupae</option>
							<option value="9">Queen</option>
							<option value="10">Worker</option>
						</select>
					</div>
					</div>
				 </div>';
				 
			echo'<div class="field">
					<div class="col-sm-10">
					  <textarea class="form-control" name="pesan" id="pesan" rows="5" placeholder="Tulis pesan anda disini..."></textarea>
					</div>
				 </div>';
				 
			echo'<div class="action">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="submit" class="btn btn-default" name="kirim-komentar">
							Pesan
						</button>
					</div>
				</div>
			</form></section>';
		}
		//Mengatur validasi form orderan
			if(isset($_POST['kirim-komentar'])){
				$msg = '';
				if(trim($_POST['nama'])=="") $msg .= '<li><code>Nama belum diisi</code></li>';
				if(trim($_POST['email'])=="") $msg .= '<li><code>Email belum diisi</code></li>';
				if(trim($_POST['no_hp'])=="") $msg .= '<li><code>Phone Number belum diisi</code></li>';
				if(trim($_POST['produk'])=="") $msg .= '<li><code>Produk belum dipilih</code></li>';
				if(trim($_POST['pesan'])=="") $msg .= '<li><code>Pesan belum diisi</code></li>';
				 
				$email_pattern = '/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/';  
				if(!preg_match($email_pattern, $_POST['email'])) $msg .= '<li><code>Email tidak valid</code></li>';

				if($msg==''){
					$nama = antiinjeksi($_POST['nama']);
					$email = antiinjeksi($_POST['email']);
					$no_hp = $_POST['no_hp'];
					$produk = antiinjeksi($_POST['produk']);
					$pesan = antiinjeksi($_POST['pesan']);
					$tgl = date("Y-m-d");
					$status = '1';
					
					$quser = $mysqli->query("SELECT * FROM user WHERE level='admin'");
					$rus = $quser->fetch_array();
					$pesan_email = "$nama mengirim pesan pada website ".web_info('judul');
					mail($rus['email'], "Order Produk", $pesan_email);
					
					$mysqli->query("INSERT INTO orderan SET
						nama = '$nama',
						email = '$email',
						no_hp = '$no_hp',
						id_produk = '$produk',
						pesan = '$pesan',
						tanggal = '$tgl',
						status = '$status'
					");
					

					echo'<div><ul class="contact">Orderan Sukses Terkirim. Terima kasih telah memesan produk di Base Enam Empat.</div>
					<script> window.location.href="#form-order";</script>';
				}else{
					echo'<ul class="contact">'.$msg.'</ul>
						<script> window.location.href="#form-order";</script>';
				}
			}
}


// Fungsi untuk menampilkan daftar fitur
function template_portfolio($template, $panjang=300){	
	global $mysqli;

	$qartikel = $mysqli->query("SELECT * FROM artikel WHERE kategori='$_GET[id]' ORDER BY id_artikel DESC");
	while($r = $qartikel->fetch_array()){
		$template_portfolio = $template;
		$link = web_info('url')."/artikel/$r[id_artikel]/$r[judul_seo]";
		$template_portfolio = str_replace('{link}', $link, $template_portfolio);
		
		if($r['gambar'] != "") $gambar = web_info('url')."/media/source/".$r['gambar'];
		else $gambar = web_info('url')."/media/source/blank.png";
		$template_portfolio = str_replace('{gambar}',	$gambar, $template_portfolio);
		
		
		$template_portfolio = str_replace('{judul}', $r['judul'], $template_portfolio);
		
		$quser = $mysqli->query("SELECT * FROM user WHERE id_user='$r[id_user]'");
		$u = $quser->fetch_array();			
		$meta= $u['nama_lengkap'].' | '.$r['hari'].', '.tgl_indonesia($r['tanggal']).' '.$r['jam'].' WIB'; 
		$template_portfolio = str_replace('{meta}', $meta, $template_portfolio);
		
		$konten = substr($r['isi'], 0, $panjang);
		$konten = substr($r['isi'], 0, strrpos($konten, " ") );
		$konten = str_replace("../media/", web_info('url')."/media/", $konten);
		$template_portfolio = str_replace('{konten}', $konten, $template_portfolio);
		
		echo $template_portfolio;
	}
}


// Fungsi untuk menampilkan daftar artikel dalam sebuah kategori
function template_kategori($template, $limit=10, $panjang=300){
	global $mysqli;
	
	$qkategori = $mysqli->query("SELECT * FROM kategori WHERE id_kategori='$_GET[id]'");
	$rkat = $qkategori->fetch_array();
	echo'<h1 class="major">'.$rkat['kategori'].'</h1>

		<blockquote>'.$rkat['tagline'].' -- <b>'.$rkat['tagline_owner'].'</b> </blockquote>';
	
	$batas 	= $limit;	
	$hal 	= isset($_GET['hal']) ? $_GET['hal'] : 1;
	$posisi = isset($_GET['hal']) ? ($hal-1) * $batas : 0;
			
	$qartikel = $mysqli->query("SELECT * FROM artikel WHERE kategori='$_GET[id]' ORDER BY id_artikel DESC  LIMIT $posisi, $batas");
	while($r = $qartikel->fetch_array()){
		$template_artikel = $template;
		$link = web_info('url')."/artikel/$r[id_artikel]/$r[judul_seo]";
		$template_artikel = str_replace('{link}', $link, $template_artikel);
		
		if($r['gambar'] != "") $gambar = web_info('url')."/media/source/".$r['gambar'];
		else $gambar = web_info('url')."/media/source/blank.png";
		$template_artikel = str_replace('{gambar}',	$gambar, $template_artikel);
		
		$template_artikel = str_replace('{judul}', $r['judul'], $template_artikel);
		
		$quser = $mysqli->query("SELECT * FROM user WHERE id_user='$r[id_user]'");
		$u = $quser->fetch_array();			
		$meta= $u['nama_lengkap'].' | '.$r['hari'].', '.tgl_indonesia($r['tanggal']).' '.$r['jam'].' WIB'; 
		$template_artikel = str_replace('{meta}', $meta, $template_artikel);
		
		$konten = substr($r['isi'], 0, $panjang);
		$konten = substr($r['isi'], 0, strrpos($konten, " ") );
		$konten = str_replace("../media/", web_info('url')."/media/", $konten);
		$template_artikel = str_replace('{konten}', $konten, $template_artikel);
		
		echo $template_artikel;
	}
	
	$qartikel = $mysqli->query("SELECT * FROM artikel WHERE kategori='$_GET[id]'");
	$jmldata = $qartikel->num_rows;
	
	if($jmldata>$batas){
		echo buat_paging('c/'.$_GET['id'], '/'.$rkat['kategori_seo'], $batas, $jmldata, $hal);
	}
	
}


// Page hits index
function index_hits(){
	global $mysqli;
	date_default_timezone_set('Asia/Jakarta');
 	$jam = date("H:i:s");
	$tgl = date("Y-m-d");
	$ip_address=$_SERVER['REMOTE_ADDR'];
	$hostname=gethostbyaddr($_SERVER['REMOTE_ADDR']);
	$info=$_SERVER['HTTP_USER_AGENT'];

	$mysqli->query("INSERT INTO page_view
					(`tanggal`,`jam`,`utama`,`iot`,`webdev`,`course`,`ip_add`,`hostname`,`browser`)
					VALUES('$tgl','$jam','1','0','0','0','$ip_address','$hostname','$info')");
}
?>
