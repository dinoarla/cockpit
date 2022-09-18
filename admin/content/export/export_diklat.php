<?php
session_start();
include "../../../library/config.php";
// Fungsi header dengan mengirimkan raw data excel
  header("Content-type: application/vnd-ms-excel");
   
  // header("Content-Disposition: attachment; filename=Rekap-Kuisioner_".$tgl.".xls");
  header("Content-Disposition: attachment; filename=EXPORT-DIKLAT.xls");

ini_set('display_errors', 1); ini_set('error_reporting', E_ERROR);

$result = $mysqli->query("select count(1) FROM diklat");
$row = $result->fetch_array();
$total_data = $row[0];
?>

            

            <table align="center">
                <thead>
                  <tr>
                    <th colspan=12 rowspan=1 style="font-size:14pt">
                    EXPORT DIKLAT
                    </th>
                  </tr>

                  <tr>
                    <th colspan=12 rowspan=1 style="font-size:11pt; font-weight:normal;">
                    Total Data: <b><?php echo $total_data;?></b> | Di export oleh: <b><?php echo " ".$_SESSION['namalengkap']; ?></b> | Pada hari <b><?php echo date(DATE_RFC2822); ?></b>
                    </th>
                  </tr>

                  <tr>
                  </tr>
                </thead>
            
           
            <table border="1" class="table table-bordered data-table">
              <thead>
                <tr>
                 <th>No</th>
                  <th>NIP</th>
                  <th>Nama</th>
                  <th>Jabatan</th>
                  <th>Unit</th>
                  <th>Judul Diklat</th>
                  <th>Tanggal Pelaksanaan</th>
                  <th>Tanggal Selesai</th>
                  <th>Jenis Diklat</th>
                  <th>URL Materi</th>
                  <th>Kehadiran</th>
                  <th>Alasan</th>
                </tr>
              </thead>
              <tbody>
                <?php
                ini_set('display_errors', 1); ini_set('error_reporting', E_ERROR);
			          $no = 1;
                $query = $mysqli->query("SELECT * FROM diklat 
                                          JOIN unit ON diklat.id_unit = unit.id_unit
                                          ORDER BY id_diklat");
                while($result = $query->fetch_array()){
				echo "<tr>
             <td align='center'>$no</td>
             <td align='center'>$result[nip]</td>
             <td align='center'>$result[nama]</td>
             <td align='center'>$result[jabatan]</td> 
             <td align='center'>$result[unit]</td> 
             <td align='center'>$result[judul]</td> 
             <td align='center'>$result[tgl_awal]</td> 
             <td align='center'>$result[tgl_akhir]</td>  
             <td align='center'>$result[jenis_diklat]</td>
             <td align='center'>$result[materi]</td>
             <td align='center'>$result[kehadiran]</td>
             <td align='center'>$result[alasan]</td>
					</tr>";
					$no++;
					}
				?>
              </tbody>
            </table>
        </table>