<?php
if (!defined("INDEX")) header('location: index.php');

$content = isset($_GET['content']) ? $_GET['content'] : 'horizon';
$kosong = true;

function format_uang($angka)
{
	$hasil = number_format($angka, 0, ',', '.');
	return $hasil;
}

//Menampilkan file sesuai nilai $content
$page = array('horizon', 'asset', 'debt', 'budget', 'cashin', 'cashout', 'user', 'media', 'backuprestore');
foreach ($page as $pg) {
	if ($content == $pg and $kosong) {
		include 'content/' . $pg . '.php';
		$kosong = false;
	}
}


//Pesan jika kosong
if ($kosong) {
	echo '<br><br><div class="alert alert-warning"><b>Sorry</b>, Halaman tidak ditemukan!</div>';
}
