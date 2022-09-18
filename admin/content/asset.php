<?php
if (!defined("INDEX")) header('location: ../index.php');
if ($_SESSION['leveluser'] != "admin") header('location: index.php');

$show = isset($_GET['show']) ? $_GET['show'] : "";
$link = "?content=asset";
$link_export = "../admin/content/export/export_asset.php";
switch ($show) {

        //Menampilkan data
    default:
        echo '<h3 class="page-header"><b>Asset Monitoring</b>
				<a href="' . $link_export . '" target="_blank" class="btn btn-success btn-sm pull-right top-button" style="margin-left:10px;">
					<i class="glyphicon glyphicon-list-alt"></i> Export Excel
				</a>
				<a href="' . $link . '&show=form" class="btn btn-primary btn-sm pull-right top-button">
					<i class="glyphicon glyphicon-plus-sign"></i> Add Assets
				</a>
			</h3>';

        buka_tabel(array("Assets", "Category", "Tanggal Awal/Beli", "Value"));
        $no = 1;
        $query = $mysqli->query("SELECT * FROM tbl_asset ORDER BY id_asset DESC");
        while ($data = $query->fetch_array()) {
            $id = str_pad($data['id_asset'], 4, '0', STR_PAD_LEFT);
            $uraian  =
                '<p>' . $data['nama'] . '</p>
			<small class="text-muted">
                <span class="label label-primary">ID: DINO-ASSETS-' . $data['kategori'] . '-' . $id . '</span>
			</small>';

            $beli = tgl_indonesia($data['tgl_beli']);
            $value    = 'Rp ' . format_rupiah($data['nilai']);

            isi_tabel($no, array($uraian, $data['kategori'], $beli, $value), $link, $data['id_asset']);
            $no++;
        }
        tutup_tabel();

        break;

        //Menampilkan form input dan edit data
    case "form":
        if (isset($_GET['id'])) {
            $query = $mysqli->query("SELECT * FROM tbl_asset WHERE id_asset='$_GET[id]'");
            $data = $query->fetch_array();
            $aksi = "Edit";
        } else {
            $data = array("id_asset" => "", "nama" => "", "tgl_beli" => "", "kategori" => "", "status" => "", "ket" => "", "nilai" => "");
            $aksi = "Tambah";
        }

        echo '<h3 class="page-header"><b>' . $aksi . ' Data Asset</b> </h3>';

        buka_form($link, $data['id_asset'], strtolower($aksi));

        buat_textbox("Asset Name", "nama", $data['nama']);
        buat_textbox("Asset Value", "nilai", $data['nilai']);
        buat_datepicker("Tanggal Beli", "tgl_beli", $data['tgl_beli']);
        $list = array();
        $list[] = array('val' => '0', 'cap' => '-- Choose Category --');
        $list[] = array('val' => 'PROPERTIES', 'cap' => 'PROPERTIES');
        $list[] = array('val' => 'VEHICLES', 'cap' => 'VEHICLES');
        $list[] = array('val' => 'INVESTMENTS', 'cap' => 'INVESTMENTS');
        $list[] = array('val' => 'RETIREMENT-SAVINGS', 'cap' => 'RETIREMENT-SAVINGS');
        $list[] = array('val' => 'CASH', 'cap' => 'CASH');

        buat_combobox("Category", "kategori", $list, $data['kategori']);

        $list = array();
        $list[] = array('val' => '0', 'cap' => '-- Choose Asset Status --');
        $list[] = array('val' => '1', 'cap' => 'Sudah Dijual');
        $list[] = array('val' => '2', 'cap' => 'Belum Dijual');

        buat_combobox("Status Asset", "status", $list, $data['status'], 3);


        buat_textbox("Catatan", "ket", $data['ket'], 7);
        echo "<hr>";

        tutup_form($link);


        break;

        //Menyisipkan atau mengedit data di database
    case "action":
        if ($_POST['aksi'] == "tambah") {
            $mysqli->query("INSERT INTO tbl_asset SET
			    nama                = '$_POST[nama]',
				tgl_beli 	        = '$_POST[tgl_beli]',
			    kategori 	        = '$_POST[kategori]',
				nilai 	        	= '$_POST[nilai]',
				status 		        = '$_POST[status]',
				ket	 		        = '$_POST[ket]'		
			");
        } elseif ($_POST['aksi'] == "edit") {
            $mysqli->query("UPDATE tbl_asset SET
			    nama                = '$_POST[nama]',
				tgl_beli 	        = '$_POST[tgl_beli]',
			    kategori 	        = '$_POST[kategori]',
				nilai 	        	= '$_POST[nilai]',
				status 		        = '$_POST[status]',
				ket	 		        = '$_POST[ket]'	
			WHERE id_asset='$_POST[id]'");
        }
        header('location:' . $link);
        break;

        //Menghapus data di database
    case "delete":
        $mysqli->query("DELETE FROM tbl_asset WHERE id_asset='$_GET[id]'");
        header('location:' . $link);
        break;
}
