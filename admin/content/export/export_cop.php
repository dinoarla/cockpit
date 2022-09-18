<?php
session_start();
include "../../../library/config.php";
// Fungsi header dengan mengirimkan raw data excel
  header("Content-type: application/vnd-ms-excel");
   
  // header("Content-Disposition: attachment; filename=Rekap-Kuisioner_".$tgl.".xls");
  header("Content-Disposition: attachment; filename=EXPORT-COP.xls");

ini_set('display_errors', 1); ini_set('error_reporting', E_ERROR);

$result = $mysqli->query("select count(1) FROM cop");
$row = $result->fetch_array();
$total_data = $row[0];
?>

            

            <table align="center">
                <thead>
                  <tr>
                    <th colspan=8 rowspan=1 style="font-size:14pt">
                    EXPORT COMMUNITY OF PRACTICE (COP)
                    </th>
                  </tr>

                  <tr>
                    <th colspan=8 rowspan=1 style="font-size:11pt; font-weight:normal;">
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
                  <th>Nama CoP</th>
                  <th>Lingkup Keanggotaan</th>
                  <th>Sponsor</th>
                  <th>Subjek Pengetahuan</th>
                  <th>Unit</th>
                  <th>Target</th>
                  <th>Tujuan</th>
                  <th>Tanggal</th>
                </tr>
              </thead>
              <tbody>
                <?php
                ini_set('display_errors', 1); ini_set('error_reporting', E_ERROR);
			          $no = 1;
                $query = $mysqli->query("SELECT * FROM cop 
                                          JOIN unit ON cop.id_unit = unit.id_unit
                                          ORDER BY id_cop");
                while($result = $query->fetch_array()){
				echo "<tr>
            <td align='center'>$no</td>
           <td align='center'>$result[nama]</td>
           <td align='center'>$result[lingkup_keanggotaan]</td>
           <td align='center'>$result[sponsor]</td> 
           <td align='center'>$result[subjek]</td> 
           <td align='center'>$result[unit]</td> 
           <td align='center'>$result[target]</td>  
           <td align='center'>$result[tujuan]</td>
           <td align='center'>$result[tgl]</td>
					</tr>";
					$no++;
					}
				?>
              </tbody>
            </table>
        </table>