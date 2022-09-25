<?php
if (!defined("INDEX")) header('location: ../index.php');
if ($_SESSION['leveluser'] != "admin") header('location: index.php');

$show = isset($_GET['show']) ? $_GET['show'] : "";
$link = "?content=budget";
$link_export = "../admin/content/export/export_budget.php";
switch ($show) {

        //Menampilkan data
    default:
        echo '<h3 class="page-header"><b>Expense Budget</b>
				<a href="' . $link_export . '" target="_blank" class="btn btn-success btn-sm pull-right top-button" style="margin-left:10px;">
					<i class="glyphicon glyphicon-list-alt"></i> Export Excel
				</a>
				<a href="' . $link . '&show=form" class="btn btn-primary btn-sm pull-right top-button">
					<i class="glyphicon glyphicon-plus-sign"></i> Add Budget
				</a>
			</h3>';

        buka_tabel(array("Uraian", "Category", "Tanggal", "Nominal"));
        $no = 1;
        $query = $mysqli->query("SELECT * FROM tbl_budget ORDER BY id_budget DESC");
        while ($data = $query->fetch_array()) {
            $id = str_pad($data['id_budget'], 4, '0', STR_PAD_LEFT);
            $uraian  =
                '<p>' . $data['uraian'] . '</p>
			<small class="text-muted">
                <span class="label label-primary">ID: DINO-BUDGET-' . $data['kategori'] . '-' . $id . '</span>
			</small>';

            if ($data['kategori'] == '01') $kat = 'BRI Credit Anuity';
            elseif ($data['kategori'] == '02') $kat = 'Birrul Walidain';
            elseif ($data['kategori'] == '03') $kat = 'My Lovely Liebling';
            elseif ($data['kategori'] == '04') $kat = 'Shofiyyah Meccara';
            elseif ($data['kategori'] == '05') $kat = 'House Rent';
            elseif ($data['kategori'] == '06') $kat = 'House Routine';
            elseif ($data['kategori'] == '07') $kat = 'Gallon Routine';
            elseif ($data['kategori'] == '08') $kat = 'Groceries';
            elseif ($data['kategori'] == '09') $kat = 'Util. Electricity';
            elseif ($data['kategori'] == '10') $kat = 'Util. Internet';
            elseif ($data['kategori'] == '11') $kat = 'Util. Gas';
            elseif ($data['kategori'] == '12') $kat = 'Util. Water';
            elseif ($data['kategori'] == '13') $kat = 'Fuel';
            elseif ($data['kategori'] == '14') $kat = 'Emergency Fund';
            elseif ($data['kategori'] == '15') $kat = 'Drive/Cloud Subscription';
            elseif ($data['kategori'] == '16') $kat = 'Hosting/Domain Subscription';
            elseif ($data['kategori'] == '17') $kat = 'Vacation';
            elseif ($data['kategori'] == '18') $kat = 'Vehicle Routine Service';
            elseif ($data['kategori'] == '19') $kat = 'Vehicle Taxes';
            elseif ($data['kategori'] == '20') $kat = 'Home Supplies';
            else $kat = 'Belum Ada Kategori';

            $beli = tgl_indonesia($data['tgl']);
            $value    = 'Rp ' . format_rupiah($data['nilai']);

            isi_tabel($no, array($uraian, $kat, $beli, $value), $link, $data['id_budget']);
            $no++;
        }
        tutup_tabel();

        break;

        //Menampilkan form input dan edit data
    case "form":
        if (isset($_GET['id'])) {
            $query = $mysqli->query("SELECT * FROM tbl_budget WHERE id_budget='$_GET[id]'");
            $data = $query->fetch_array();
            $aksi = "Edit";
        } else {
            $data = array("id_budget" => "", "uraian" => "", "tgl" => "", "kategori" => "", "nilai" => "", "ket" => "");
            $aksi = "Tambah";
        }

        echo '<h3 class="page-header"><b>' . $aksi . ' Budget</b> </h3>';

        buka_form($link, $data['id_budget'], strtolower($aksi));

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
            $mysqli->query("INSERT INTO tbl_budget SET
			    uraian          = '$_POST[uraian]',
				tgl 	        = '$_POST[tgl]',
			    kategori 	    = '$_POST[kategori]',
				nilai 	        = '$_POST[nilai]',
				ket	 		    = '$_POST[ket]'		
			");
        } elseif ($_POST['aksi'] == "edit") {
            $mysqli->query("UPDATE tbl_budget SET
			    uraian          = '$_POST[uraian]',
				tgl 	        = '$_POST[tgl]',
			    kategori 	    = '$_POST[kategori]',
				nilai 	        = '$_POST[nilai]',
				ket	 		    = '$_POST[ket]'	
			WHERE id_budget='$_POST[id]'");
        }
        header('location:' . $link);
        break;

        //Menghapus data di database
    case "delete":
        $mysqli->query("DELETE FROM tbl_budget WHERE id_budget='$_GET[id]'");
        header('location:' . $link);
        break;
}
