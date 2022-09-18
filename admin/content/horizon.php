<script type="text/javascript">
    $(function() {

        Highcharts.setOptions({
            colors: ['#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4']
        });

        Highcharts.chart('stat', {
            data: {
                table: 'tabel_stat'
            },
            chart: {
                type: 'pie'
            },
            title: {
                text: 'Total Assets Per Category'
            },
            subtitle: {
                text: 'Dino Arla'
            },
            exporting: {
                enabled: false
            },
            credits: {
                enabled: false
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        color: '#000000',
                        connectorColor: '#000000',
                        formatter: function() {
                            return '<b>' + this.point.name + '</b>: ' + Highcharts.numberFormat(this.percentage, 2) + ' %';
                        }
                    }
                }
            },
            tooltip: {
                formatter: function() {
                    return '<b>' + this.point.name + '</b><br/>' +
                        this.point.y;
                }
            }
        });
    });
</script>

<script type="text/javascript">
    $(function() {

        Highcharts.setOptions({
            colors: ['#50B432', '#ED561B', ]
        });

        Highcharts.chart('stat_ulp', {
            data: {
                table: 'tabel_stat_vs'
            },
            chart: {
                type: 'bar'
            },
            title: {
                text: 'Assets vs Debts'
            },
            subtitle: {
                text: 'Dino Arla'
            },
            yAxis: {
                allowDecimals: false,
                title: {
                    text: 'Rp'
                }
            },
            exporting: {
                enabled: false
            },
            credits: {
                enabled: false
            },
            tooltip: {
                formatter: function() {
                    return '<b>' + this.series.name + '</b><br/>' +
                        this.point.y;
                }
            }
        });
    });
</script>

<?php
if (!defined("INDEX")) header('location: index.php');

function buat_tombol_nw($name, $icon, $link, $warna)
{
    global $mysqli;
    $query_as = $mysqli->query("SELECT SUM(nilai) AS tot_nilai FROM tbl_asset WHERE status = '2'");
    $jml_data_as = $query_as->fetch_assoc();

    $query_db = $mysqli->query("SELECT SUM(nilai) AS tot_nilai FROM tbl_debt");
    $jml_data_db = $query_db->fetch_assoc();
    echo '<div class="col-md-6 col-xs-12"><a href="' . $link . '">
        <div class="panel panel-' . $warna . ' dashboard-panel">
          <div class="panel-heading">
            <i class="glyphicon glyphicon-' . $icon . '"></i>
            <span class="pull-right" style="font-size: 50px">Rp ' . number_format($jml_data_as['tot_nilai'] - $jml_data_db['tot_nilai']) . '</span>        
          </div>
          <div class="panel-body">' . $name . '</div>
        </div>
      </a></div>';
}

function buat_tombol_as($name, $icon, $link, $warna)
{
    global $mysqli;
    $query = $mysqli->query("SELECT SUM(nilai) AS tot_nilai FROM tbl_asset WHERE status = '2'");
    $jml_data = $query->fetch_assoc();
    echo '<div class="col-md-3 col-xs-12"><a href="' . $link . '">
        <div class="panel panel-' . $warna . ' dashboard-panel">
          <div class="panel-heading">
          <i class="glyphicon glyphicon-' . $icon . '"></i>
            <span class="pull-right" style="font-size: 30px">' . easy_number($jml_data['tot_nilai']) . '</span>        
          </div>
          <div class="panel-body">' . $name . '</div>
        </div>
      </a></div>';
}

function buat_tombol_db($name, $icon, $link, $warna)
{
    global $mysqli;
    $query = $mysqli->query("SELECT SUM(nilai) AS tot_nilai FROM tbl_debt");
    $jml_data = $query->fetch_assoc();
    echo '<div class="col-md-3 col-xs-12"><a href="' . $link . '">
        <div class="panel panel-' . $warna . ' dashboard-panel">
          <div class="panel-heading">
          <i class="glyphicon glyphicon-' . $icon . '"></i>
            <span class="pull-right" style="font-size: 30px">' . easy_number($jml_data['tot_nilai']) . '</span>        
          </div>
          <div class="panel-body">' . $name . '</div>
        </div>
      </a></div>';
}
?>

<br>
<div class="col-md-12">
    <h3 class="page-header"><b>Financial Health Station</b>
        <a href="#" class="btn btn-success btn-sm pull-right top-button" style="margin-left:10px;">
            <i class="glyphicon glyphicon-list-alt"></i> Quicklink 1
        </a>
        <a href="#" class="btn btn-primary btn-sm pull-right top-button" style="margin-left:10px;">
            <i class="glyphicon glyphicon-list-alt"></i> Quicklink 2
        </a>
        <a href="#" class="btn btn-warning btn-sm pull-right top-button" style="margin-left:10px;">
            <i class="glyphicon glyphicon-list-alt"></i> Quicklink 3
        </a>
    </h3>
    <div class="row">
        <?php
        //Memanggil fungsi buat_tombol untuk membuat 4 tombol
        buat_tombol_nw("total net worth (idr)", "usd", "?content=horizon", "primary");
        buat_tombol_as("total assets (idr)", "home", "?content=asset", "success");
        buat_tombol_db("total debts (idr)", "credit-card", "?content=debt", "danger");
        ?>
    </div>
</div>

<div class="col-md-6">
    <div class="card">
        <div id="stat"></div>
        <table class="table table-striped" id="tabel_stat" style="display: none;">
            <thead>
                <tr>
                    <th>Unit</th>
                    <th>Nilai Assets (Rp)</th>
                </tr>
            </thead>
            <?php
            global $mysqli;
            //PROPERTIES
            $query = $mysqli->query("SELECT SUM(nilai) AS tot_nilai FROM tbl_asset WHERE kategori = 'PROPERTIES'");
            $jml_data_prop = $query->fetch_assoc();

            //VEHICLES
            $query = $mysqli->query("SELECT SUM(nilai) AS tot_nilai FROM tbl_asset WHERE kategori = 'VEHICLES'");
            $jml_data_vehi = $query->fetch_assoc();

            //INVESTMENTS
            $query = $mysqli->query("SELECT SUM(nilai) AS tot_nilai FROM tbl_asset WHERE kategori = 'INVESTMENTS'");
            $jml_data_inve = $query->fetch_assoc();

            //RETIREMENT-SAVINGS
            $query = $mysqli->query("SELECT SUM(nilai) AS tot_nilai FROM tbl_asset WHERE kategori = 'RETIREMENT-SAVINGS'");
            $jml_data_reti = $query->fetch_assoc();

            //CASH
            $query = $mysqli->query("SELECT SUM(nilai) AS tot_nilai FROM tbl_asset WHERE kategori = 'CASH'");
            $jml_data_cash = $query->fetch_assoc();

            ?>
            <tbody>
                <tr>
                    <th>Properties</th>
                    <?php echo "<td>" . $jml_data_prop['tot_nilai'] . "</td>"; ?>
                </tr>
                <tr>
                    <th>Vehicles</th>
                    <?php echo "<td>" . $jml_data_vehi['tot_nilai'] . "</td>"; ?>
                </tr>
                <tr>
                    <th>Investments</th>
                    <?php echo "<td>" . $jml_data_inve['tot_nilai'] . "</td>"; ?>
                </tr>
                <tr>
                    <th>Retirement Savings</th>
                    <?php echo "<td>" . $jml_data_reti['tot_nilai'] . "</td>"; ?>
                </tr>
                <tr>
                    <th>Cash</th>
                    <?php echo "<td>" . $jml_data_cash['tot_nilai'] . "</td>"; ?>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<div class="col-md-6">
    <div class="card">
        <div id="stat_ulp"></div>
        <table class="table table-striped" id="tabel_stat_vs" style="display: none;">
            <thead>
                <tr>
                    <th>Unit</th>
                    <th>Assets</th>
                    <th>Debts</th>
                </tr>
            </thead>
            <?php
            global $mysqli;
            //ASSETS
            $query = $mysqli->query("SELECT SUM(nilai) AS tot_nilai FROM tbl_asset WHERE status = '2'");
            $jml_data_as = $query->fetch_assoc();

            //DEBTS
            $query = $mysqli->query("SELECT SUM(nilai) AS tot_nilai FROM tbl_debt");
            $jml_data_db = $query->fetch_assoc();

            ?>
            <tbody>
                <tr>
                    <th>Versus</th>
                    <?php echo "<td>" . $jml_data_as['tot_nilai'] . "</td>"; ?>
                    <?php echo "<td>" . $jml_data_db['tot_nilai'] . "</td>"; ?>
                </tr>


            </tbody>
        </table>
    </div>
</div>