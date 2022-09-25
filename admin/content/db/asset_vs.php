<script type="text/javascript">
    $(function() {

        Highcharts.setOptions({
            colors: ['#50B432', '#ED561B']
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
include "../../../library/config.php";
global $mysqli;

//ASSETS
$query = $mysqli->query("SELECT SUM(nilai) AS tot_nilai FROM tbl_asset WHERE status = '2'");
$jml_data_as = $query->fetch_assoc();

//DEBTS
$query = $mysqli->query("SELECT SUM(nilai) AS tot_nilai FROM tbl_debt");
$jml_data_db = $query->fetch_assoc();
?>

<div id="stat_ulp"></div>
<table class="table table-striped" id="tabel_stat_vs" style="display: none;">
    <thead>
        <tr>
            <th>Unit</th>
            <th>Assets</th>
            <th>Debts</th>
        </tr>
    </thead>

    <tbody>
        <tr>
            <th>Versus</th>
            <?php echo "<td>" . $jml_data_as['tot_nilai'] . "</td>"; ?>
            <?php echo "<td>" . $jml_data_db['tot_nilai'] . "</td>"; ?>
        </tr>


    </tbody>
</table>