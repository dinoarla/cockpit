<?php
if (!defined("INDEX")) header('location: ../index.php');
if ($_SESSION['leveluser'] != "admin") header('location: index.php');

$show = isset($_GET['show']) ? $_GET['show'] : "";
$link = "?content=cashout";
$link_export = "../admin/content/export/export_cashout.php";
switch ($show) {

        //Menampilkan data
    default:
        echo '<h3 class="page-header"><b>Actual Transaction (Cash Out)</b>
				<a href="' . $link_export . '" target="_blank" class="btn btn-success btn-sm pull-right top-button" style="margin-left:10px;">
					<i class="glyphicon glyphicon-list-alt"></i> Export Excel
				</a>
				<a href="' . $link . '&show=form" class="btn btn-primary btn-sm pull-right top-button">
					<i class="glyphicon glyphicon-plus-sign"></i> Add Transaction
				</a>
			</h3>';

        buka_tabel(array("Uraian", "Category", "Tanggal Transaksi", "Nominal"));
        $no = 1;
        $query = $mysqli->query("SELECT * FROM tbl_cashout ORDER BY id_out DESC");
        while ($data = $query->fetch_array()) {
            $id = str_pad($data['id_out'], 4, '0', STR_PAD_LEFT);
            $uraian  =
                '<p>' . $data['uraian'] . '</p>
			<small class="text-muted">
                <span class="label label-primary">ID: DINO-CASHOUT-' . $data['kategori'] . '-' . $id . '</span>
			</small>';

            $beli = tgl_indonesia($data['tgl']);
            $value    = 'Rp ' . format_rupiah($data['nilai']);

            isi_tabel($no, array($uraian, $data['kategori'], $beli, $value), $link, $data['id_out']);
            $no++;
        }
        tutup_tabel();

        break;

        //Menampilkan form input dan edit data
    case "form":
        if (isset($_GET['id'])) {
            $query = $mysqli->query("SELECT * FROM tbl_cashout WHERE id_out='$_GET[id]'");
            $data = $query->fetch_array();
            $aksi = "Edit";
        } else {
            $data = array("id_out" => "", "uraian" => "", "tgl" => "", "kategori" => "", "nilai" => "", "ket" => "");
            $aksi = "Tambah";
        }

        echo '<h3 class="page-header"><b>' . $aksi . ' Transaksi Cash Out</b> </h3>';

        buka_form($link, $data['id_out'], strtolower($aksi));

        buat_textbox("Transaksi", "uraian", $data['uraian']);
        buat_textbox("Nominal", "nilai", $data['nilai']);
        buat_datepicker("Tanggal Transaksi", "tgl", $data['tgl']);
        $list = array();
        $list[] = array('val' => '0', 'cap' => '-- Choose Category --');
        $list[] = array('val' => '01', 'cap' => 'BRI Credit Anuity');
        $list[] = array('val' => '02', 'cap' => 'Birrul Walidain');
        $list[] = array('val' => '03', 'cap' => 'My Lovely Liebling');
        $list[] = array('val' => '04', 'cap' => 'Shofiyyah Meccara');
        $list[] = array('val' => '05', 'cap' => 'House Rent');
        $list[] = array('val' => '06', 'cap' => 'House Routine');
        $list[] = array('val' => '07', 'cap' => 'Gallon Routine');
        $list[] = array('val' => '08', 'cap' => 'Groceries');
        $list[] = array('val' => '09', 'cap' => 'Util. Electricity');
        $list[] = array('val' => '10', 'cap' => 'Util. Internet');
        $list[] = array('val' => '11', 'cap' => 'Util. Gas');
        $list[] = array('val' => '12', 'cap' => 'Util. Water');
        $list[] = array('val' => '13', 'cap' => 'Fuel');
        $list[] = array('val' => '14', 'cap' => 'Emergency Fund');
        $list[] = array('val' => '15', 'cap' => 'Drive/Cloud Subscription');
        $list[] = array('val' => '16', 'cap' => 'Hosting/Domain Subscription');
        $list[] = array('val' => '17', 'cap' => 'Vacation');
        $list[] = array('val' => '18', 'cap' => 'Vehicle Routine Service');
        $list[] = array('val' => '19', 'cap' => 'Vehicle Taxes');
        $list[] = array('val' => '20', 'cap' => 'Home Supplies');

        buat_combobox("Category", "kategori", $list, $data['kategori']);

        buat_textbox("Catatan", "ket", $data['ket'], 7);
        echo "<hr>";

        tutup_form($link);


        break;

        //Menyisipkan atau mengedit data di database
    case "action":
        if ($_POST['aksi'] == "tambah") {
            $mysqli->query("INSERT INTO tbl_cashout SET
			    uraian          = '$_POST[uraian]',
				tgl 	        = '$_POST[tgl]',
			    kategori 	    = '$_POST[kategori]',
				nilai 	        = '$_POST[nilai]',
				ket	 		    = '$_POST[ket]'		
			");
        } elseif ($_POST['aksi'] == "edit") {
            $mysqli->query("UPDATE tbl_cashout SET
			    uraian          = '$_POST[uraian]',
				tgl 	        = '$_POST[tgl]',
			    kategori 	    = '$_POST[kategori]',
				nilai 	        = '$_POST[nilai]',
				ket	 		    = '$_POST[ket]'	
			WHERE id_in='$_POST[id]'");
        }
        header('location:' . $link);
        break;

        //Menghapus data di database
    case "delete":
        $mysqli->query("DELETE FROM tbl_cashout WHERE id_in='$_GET[id]'");
        header('location:' . $link);
        break;
}
