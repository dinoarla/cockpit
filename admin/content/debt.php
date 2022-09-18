<?php
if (!defined("INDEX")) header('location: ../index.php');
if ($_SESSION['leveluser'] != "admin") header('location: index.php');

$show = isset($_GET['show']) ? $_GET['show'] : "";
$link = "?content=debt";
$link_export = "../admin/content/export/export_debt.php";
switch ($show) {

        //Menampilkan data
    default:
        echo '<h3 class="page-header"><b>Debt Monitoring</b>
				<a href="' . $link_export . '" target="_blank" class="btn btn-success btn-sm pull-right top-button" style="margin-left:10px;">
					<i class="glyphicon glyphicon-list-alt"></i> Export Excel
				</a>
				<a href="' . $link . '&show=form" class="btn btn-primary btn-sm pull-right top-button">
					<i class="glyphicon glyphicon-plus-sign"></i> Add Debt
				</a>
			</h3>';

        buka_tabel(array("Debt", "Category", "Tanggal Mulai", "Last Update", "Value"));
        $no = 1;
        $query = $mysqli->query("SELECT * FROM tbl_debt ORDER BY id_debt DESC");
        while ($data = $query->fetch_array()) {
            $id = str_pad($data['id_debt'], 4, '0', STR_PAD_LEFT);
            $uraian  =
                '<p>' . $data['nama'] . '</p>
			<small class="text-muted">
                <span class="label label-primary">ID: DINO-DEBT-' . $data['kategori'] . '-' . $id . '</span>
			</small>';

            $awal = tgl_indonesia($data['tgl_awal']);
            $update = tgl_indonesia($data['tgl_update']);
            $value    = 'Rp ' . format_rupiah($data['nilai']);

            isi_tabel($no, array($uraian, $data['kategori'], $awal, $update, $value), $link, $data['id_debt']);
            $no++;
        }
        tutup_tabel();

        break;

        //Menampilkan form input dan edit data
    case "form":
        if (isset($_GET['id'])) {
            $query = $mysqli->query("SELECT * FROM tbl_debt WHERE id_debt='$_GET[id]'");
            $data = $query->fetch_array();
            $aksi = "Edit";
        } else {
            $data = array("id_debt" => "", "nama" => "", "tgl_awal" => "",  "tgl_update" => "", "kategori" => "", "ket" => "", "nilai" => "");
            $aksi = "Tambah";
        }

        echo '<h3 class="page-header"><b>' . $aksi . ' Data Debt</b> </h3>';

        buka_form($link, $data['id_debt'], strtolower($aksi));

        buat_textbox("Debt Name", "nama", $data['nama']);
        buat_textbox("Debt Value", "nilai", $data['nilai']);
        buat_datepicker("Tanggal Awal", "tgl_awal", $data['tgl_awal']);
        buat_datepicker("Last Update", "tgl_update", $data['tgl_update']);
        $list = array();
        $list[] = array('val' => '0', 'cap' => '-- Choose Category --');
        $list[] = array('val' => 'BANK', 'cap' => 'BANK');
        $list[] = array('val' => 'CREDIT-CARD', 'cap' => 'CREDIT-CARD');
        $list[] = array('val' => 'PEOPLE', 'cap' => 'PEOPLE');

        buat_combobox("Category", "kategori", $list, $data['kategori']);

        buat_textbox("Catatan", "ket", $data['ket'], 7);
        echo "<hr>";

        tutup_form($link);


        break;

        //Menyisipkan atau mengedit data di database
    case "action":
        if ($_POST['aksi'] == "tambah") {
            $mysqli->query("INSERT INTO tbl_debt SET
			    nama                = '$_POST[nama]',
				tgl_awal 	        = '$_POST[tgl_awal]',
				tgl_update 	        = '$_POST[tgl_update]',
			    kategori 	        = '$_POST[kategori]',
				nilai 	        	= '$_POST[nilai]',
				ket	 		        = '$_POST[ket]'		
			");
        } elseif ($_POST['aksi'] == "edit") {
            $mysqli->query("UPDATE tbl_debt SET
			    nama                = '$_POST[nama]',
				tgl_awal 	        = '$_POST[tgl_awal]',
				tgl_update 	        = '$_POST[tgl_update]',
			    kategori 	        = '$_POST[kategori]',
				nilai 	        	= '$_POST[nilai]',
				ket	 		        = '$_POST[ket]'	
			WHERE id_debt='$_POST[id]'");
        }
        header('location:' . $link);
        break;

        //Menghapus data di database
    case "delete":
        $mysqli->query("DELETE FROM tbl_debt WHERE id_debt='$_GET[id]'");
        header('location:' . $link);
        break;
}
