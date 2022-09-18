<?php
if(!defined("INDEX")) header('location: ../index.php');

$show = isset($_GET['show']) ? $_GET['show'] : "";
$link = "?content=user";
switch($show){

	//Menampilkan data
	default:
		if($_SESSION['leveluser']=="admin"){
			echo '<h3 class="page-header"><b>Daftar User</b>
				<a href="'.$link.'&show=form" class="btn btn-primary btn-sm pull-right top-button">
					<i class="glyphicon glyphicon-plus-sign"></i> Tambah
				</a>
			</h3>';
			
			buka_tabel(array("Nama Lengkap", "Email", "Username", "Level"));
			$no = 1;
			$query = $mysqli->query("SELECT * FROM tbl_user ORDER BY id_user");
			while($data = $query->fetch_array()){
				if($data['level']=="admin") isi_tabel($no, array($data['nama_lengkap'], $data['email'], $data['username'], $data['level']), $link, $data['id_user'], true, false);
				else isi_tabel($no, array($data['nama_lengkap'], $data['email'], $data['username'], $data['level']), $link, $data['id_user']);
						
				$no++;
			} 
			tutup_tabel();
		}else{
			$id_user = $_SESSION['iduser'];
			$query 	= $mysqli->query("SELECT * FROM tbl_user WHERE id_user='$id_user'");
			$data	= $query->fetch_array();
			$aksi 	= "Edit";
			
			echo'<h3 class="page-header"><b>'.$aksi.' User</b> </h3>';	
		
			buka_form($link, $id_user, strtolower($aksi));
				buat_textbox("Nama Lengkap", "nama_lengkap", $data['nama_lengkap']);
				buat_textbox("Email", "email", $data['email']);;
				buat_textbox("Username", "username", $data['username']);
				buat_textbox("Password", "password", "", 4, "password");
			tutup_form($link);
		}
	break;
	
	//Menampilkan form input dan edit data
	case "form":
		if(isset($_GET['id'])){
			$query 	= $mysqli->query("SELECT * FROM tbl_user WHERE id_user='$_GET[id]'");
			$data	= $query->fetch_array();
			$aksi 	= "Edit";
		}else{
			$data = array("id_user"=>"", "nama_lengkap"=>"", "email"=>"", "username"=>"", "level"=>"");
			$aksi 	= "Tambah";
		}
		
		echo'<h3 class="page-header"><b>'.$aksi.' User</b> </h3>';	
		
		buka_form($link, $data['id_user'], strtolower($aksi));
			buat_textbox("Nama Lengkap", "nama_lengkap", $data['nama_lengkap']);
			buat_textbox("Email", "email", $data['email']);
			
		    $list = array();
			$list[] = array('val'=>'0', 'cap'=>'-- Pilih Hak Akses --');
			$list[] = array('val'=>'admin', 'cap'=>'Author');
			$list[] = array('val'=>'Manajemen', 'cap'=>'Manajemen');
			$list[] = array('val'=>'Ren', 'cap'=>'Perencanaan');
			$list[] = array('val'=>'Jar', 'cap'=>'Jaringan');
			$list[] = array('val'=>'k3l_ulp', 'cap'=>'Pejabat K3L ULP');
			$list[] = array('val'=>'k3l_up3', 'cap'=>'Pejabat K3L UP3');

			buat_combobox("Hak Akses", "hak_akses", $list, $data['level']);

			buat_textbox("Username", "username", $data['username']);
			buat_textbox("Password", "password", "", 4, "password");
		tutup_form($link);	
	break;	
	
	//Menyisipkan atau mengedit data di database
	case "action":
		$password = md5($_POST['password']);
		if($_POST['aksi'] == "tambah"){
			$mysqli->query("INSERT INTO tbl_user SET
				nama_lengkap 	= '$_POST[nama_lengkap]',				
				email	 		= '$_POST[email]',				
				username	 	= '$_POST[username]',				
				password	 	= '$password',
				level			= '$_POST[hak_akses]'
			");
		}elseif($_POST['aksi'] == "edit"){
			$mysqli->query("UPDATE tbl_user SET
				nama_lengkap 	= '$_POST[nama_lengkap]',				
				email	 		= '$_POST[email]',				
				username	 	= '$_POST[username]',
				level			= '$_POST[hak_akses]'	
			WHERE id_user='$_POST[id]'");
			
			if($_POST['password']!="") $mysqli->query("UPDATE tbl_user SET	password = '$password' WHERE id_user='$_POST[id]'");
		}
		header('location:'.$link);
	break;
	
	//Menghapus data di database
	case "delete":
		$query 	= $mysqli->query("SELECT * FROM tbl_user WHERE id_user='$_GET[id]'");
		$data	= $query->fetch_array();
		if($_SESSION['leveluser']=="admin" and $data['level']!="admin"){
			$mysqli->query("DELETE FROM user WHERE id_user='$_GET[id]'");
		}
		header('location:'.$link);
	break;
}
?>