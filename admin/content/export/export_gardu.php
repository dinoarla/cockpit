<?php
session_start();
include "../../../library/config.php";
// Fungsi header dengan mengirimkan raw data excel
  header("Content-type: application/vnd-ms-excel");
   
  // header("Content-Disposition: attachment; filename=Rekap-Kuisioner_".$tgl.".xls");
  header("Content-Disposition: attachment; filename=EXPORT-DATA-GARDU.xls");

ini_set('display_errors', 1); ini_set('error_reporting', E_ERROR);

$result = $mysqli->query("select count(1) FROM mr_gardu");
$row = $result->fetch_array();
$total_data = $row[0];
?>

            

            <table align="center">
                <thead>
                  <tr>
                    <th colspan=7 rowspan=1 style="font-size:14pt">
                    EXPORT DATA GARDU
                    </th>
                  </tr>

                  <tr>
                    <th colspan=7 rowspan=1 style="font-size:11pt; font-weight:normal;">
                    Total Data: <b><?php echo $total_data;?>
                    <!--Total Data: <b><?php echo $total_data;?></b> | Di export oleh: <b><?php echo " ".$_SESSION['namalengkap']; ?></b> | Pada hari <b><?php echo date(DATE_RFC2822); ?></b>-->
					</th>
                  </tr>

                  <tr>
                  </tr>
                </thead>
            
           
            <table border="1" class="table table-bordered data-table">
              <thead>
                <tr>
                 <th>No</th>
                  <th>No. Gardu</th>
                  <th>Alamat</th>
                  <th>Kapasitas Trafo (KVA)</th>
                  <th>Penyulang</th>
                  <th>Lat</th>
                  <th>Lng</th>
                </tr>
              </thead>
              <tbody>
                <?php
                ini_set('display_errors', 1); ini_set('error_reporting', E_ERROR);
			          $no = 1;
                $query = $mysqli->query("SELECT * FROM mr_gardu ORDER BY id_gardu");
                while($result = $query->fetch_array()){
				echo "<tr>
            <td align='center'>$no</td>
           <td align='center'>$result[no_gardu]</td>
           <td align='center'>$result[alamat]</td>
           <td align='center'>$result[kap_trafo]</td> 
           <td align='center'>$result[penyulang]</td> 
           <td align='center'>$result[lat]</td> 
           <td align='center'>$result[lng]</td> 
					</tr>";
					$no++;
					}
				?>
              </tbody>
            </table>
        </table>