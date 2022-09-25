<script type="text/javascript">
    $(function() {

        Highcharts.setOptions({
            colors: Highcharts.map(Highcharts.getOptions().colors, function(color) {
                return {
                    radialGradient: {
                        cx: 0.5,
                        cy: 0.3,
                        r: 0.7
                    },
                    stops: [
                        [0, color],
                        [1, Highcharts.color(color).brighten(-0.3).get('rgb')] // darken
                    ]
                };
            })
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

<?php
include "../../../library/config.php";
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

<div id="stat"></div>
<table class="table table-striped" id="tabel_stat" style="display: none;">
    <thead>
        <tr>
            <th>Unit</th>
            <th>Nilai Assets (Rp)</th>
        </tr>
    </thead>

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