<script type="text/javascript">
    $(function() {

        Highcharts.setOptions({
            colors: ['#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4']
        });

        Highcharts.chart('stat_exp_cat', {
            data: {
                table: 'tabel_stat_exp_cat'
            },
            chart: {
                type: 'column'
            },
            title: {
                text: 'Expenses Per Category'
            },
            subtitle: {
                text: 'Anually'
            },
            plotOptions: {
                column: {
                    stacking: 'normal'
                }
            },
            yAxis: [{
                allowDecimals: false,
                title: {
                    text: 'Expenses (Rp)'
                }
            }],
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

//JAN
$query = $mysqli->query("SELECT SUM(nilai) AS tot_jan_01 FROM tbl_cashout WHERE kategori = 01 AND MONTH(tgl) = 01 AND YEAR(tgl) = YEAR(NOW())");
$jan_01 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jan_02 FROM tbl_cashout WHERE kategori = 02 AND MONTH(tgl) = 01 AND YEAR(tgl) = YEAR(NOW())");
$jan_02 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jan_03 FROM tbl_cashout WHERE kategori = 03 AND MONTH(tgl) = 01 AND YEAR(tgl) = YEAR(NOW())");
$jan_03 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jan_04 FROM tbl_cashout WHERE kategori = 04 AND MONTH(tgl) = 01 AND YEAR(tgl) = YEAR(NOW())");
$jan_04 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jan_05 FROM tbl_cashout WHERE kategori = 05 AND MONTH(tgl) = 01 AND YEAR(tgl) = YEAR(NOW())");
$jan_05 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jan_06 FROM tbl_cashout WHERE kategori = 06 AND MONTH(tgl) = 01 AND YEAR(tgl) = YEAR(NOW())");
$jan_06 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jan_07 FROM tbl_cashout WHERE kategori = 07 AND MONTH(tgl) = 01 AND YEAR(tgl) = YEAR(NOW())");
$jan_07 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jan_08 FROM tbl_cashout WHERE kategori = 08 AND MONTH(tgl) = 01 AND YEAR(tgl) = YEAR(NOW())");
$jan_08 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jan_09 FROM tbl_cashout WHERE kategori = 09 AND MONTH(tgl) = 01 AND YEAR(tgl) = YEAR(NOW())");
$jan_09 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jan_10 FROM tbl_cashout WHERE kategori = 10 AND MONTH(tgl) = 01 AND YEAR(tgl) = YEAR(NOW())");
$jan_10 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jan_11 FROM tbl_cashout WHERE kategori = 11 AND MONTH(tgl) = 01 AND YEAR(tgl) = YEAR(NOW())");
$jan_11 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jan_12 FROM tbl_cashout WHERE kategori = 12 AND MONTH(tgl) = 01 AND YEAR(tgl) = YEAR(NOW())");
$jan_12 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jan_13 FROM tbl_cashout WHERE kategori = 13 AND MONTH(tgl) = 01 AND YEAR(tgl) = YEAR(NOW())");
$jan_13 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jan_14 FROM tbl_cashout WHERE kategori = 14 AND MONTH(tgl) = 01 AND YEAR(tgl) = YEAR(NOW())");
$jan_14 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jan_15 FROM tbl_cashout WHERE kategori = 15 AND MONTH(tgl) = 01 AND YEAR(tgl) = YEAR(NOW())");
$jan_15 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jan_16 FROM tbl_cashout WHERE kategori = 16 AND MONTH(tgl) = 01 AND YEAR(tgl) = YEAR(NOW())");
$jan_16 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jan_17 FROM tbl_cashout WHERE kategori = 17 AND MONTH(tgl) = 01 AND YEAR(tgl) = YEAR(NOW())");
$jan_17 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jan_18 FROM tbl_cashout WHERE kategori = 18 AND MONTH(tgl) = 01 AND YEAR(tgl) = YEAR(NOW())");
$jan_18 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jan_19 FROM tbl_cashout WHERE kategori = 19 AND MONTH(tgl) = 01 AND YEAR(tgl) = YEAR(NOW())");
$jan_19 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jan_20 FROM tbl_cashout WHERE kategori = 20 AND MONTH(tgl) = 01 AND YEAR(tgl) = YEAR(NOW())");
$jan_20 = $query->fetch_assoc();

//FEB
$query = $mysqli->query("SELECT SUM(nilai) AS tot_feb_01 FROM tbl_cashout WHERE kategori = 01 AND MONTH(tgl) = 02 AND YEAR(tgl) = YEAR(NOW())");
$feb_01 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_feb_02 FROM tbl_cashout WHERE kategori = 02 AND MONTH(tgl) = 02 AND YEAR(tgl) = YEAR(NOW())");
$feb_02 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_feb_03 FROM tbl_cashout WHERE kategori = 03 AND MONTH(tgl) = 02 AND YEAR(tgl) = YEAR(NOW())");
$feb_03 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_feb_04 FROM tbl_cashout WHERE kategori = 04 AND MONTH(tgl) = 02 AND YEAR(tgl) = YEAR(NOW())");
$feb_04 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_feb_05 FROM tbl_cashout WHERE kategori = 05 AND MONTH(tgl) = 02 AND YEAR(tgl) = YEAR(NOW())");
$feb_05 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_feb_06 FROM tbl_cashout WHERE kategori = 06 AND MONTH(tgl) = 02 AND YEAR(tgl) = YEAR(NOW())");
$feb_06 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_feb_07 FROM tbl_cashout WHERE kategori = 07 AND MONTH(tgl) = 02 AND YEAR(tgl) = YEAR(NOW())");
$feb_07 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_feb_08 FROM tbl_cashout WHERE kategori = 08 AND MONTH(tgl) = 02 AND YEAR(tgl) = YEAR(NOW())");
$feb_08 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_feb_09 FROM tbl_cashout WHERE kategori = 09 AND MONTH(tgl) = 02 AND YEAR(tgl) = YEAR(NOW())");
$feb_09 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_feb_10 FROM tbl_cashout WHERE kategori = 10 AND MONTH(tgl) = 02 AND YEAR(tgl) = YEAR(NOW())");
$feb_10 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_feb_11 FROM tbl_cashout WHERE kategori = 11 AND MONTH(tgl) = 02 AND YEAR(tgl) = YEAR(NOW())");
$feb_11 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_feb_12 FROM tbl_cashout WHERE kategori = 12 AND MONTH(tgl) = 02 AND YEAR(tgl) = YEAR(NOW())");
$feb_12 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_feb_13 FROM tbl_cashout WHERE kategori = 13 AND MONTH(tgl) = 02 AND YEAR(tgl) = YEAR(NOW())");
$feb_13 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_feb_14 FROM tbl_cashout WHERE kategori = 14 AND MONTH(tgl) = 02 AND YEAR(tgl) = YEAR(NOW())");
$feb_14 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_feb_15 FROM tbl_cashout WHERE kategori = 15 AND MONTH(tgl) = 02 AND YEAR(tgl) = YEAR(NOW())");
$feb_15 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_feb_16 FROM tbl_cashout WHERE kategori = 16 AND MONTH(tgl) = 02 AND YEAR(tgl) = YEAR(NOW())");
$feb_16 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_feb_17 FROM tbl_cashout WHERE kategori = 17 AND MONTH(tgl) = 02 AND YEAR(tgl) = YEAR(NOW())");
$feb_17 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_feb_18 FROM tbl_cashout WHERE kategori = 18 AND MONTH(tgl) = 02 AND YEAR(tgl) = YEAR(NOW())");
$feb_18 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_feb_19 FROM tbl_cashout WHERE kategori = 19 AND MONTH(tgl) = 02 AND YEAR(tgl) = YEAR(NOW())");
$feb_19 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_feb_20 FROM tbl_cashout WHERE kategori = 20 AND MONTH(tgl) = 02 AND YEAR(tgl) = YEAR(NOW())");
$feb_20 = $query->fetch_assoc();

//MAR
$query = $mysqli->query("SELECT SUM(nilai) AS tot_mar_01 FROM tbl_cashout WHERE kategori = 01 AND MONTH(tgl) = 03 AND YEAR(tgl) = YEAR(NOW())");
$mar_01 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mar_02 FROM tbl_cashout WHERE kategori = 02 AND MONTH(tgl) = 03 AND YEAR(tgl) = YEAR(NOW())");
$mar_02 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mar_03 FROM tbl_cashout WHERE kategori = 03 AND MONTH(tgl) = 03 AND YEAR(tgl) = YEAR(NOW())");
$mar_03 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mar_04 FROM tbl_cashout WHERE kategori = 04 AND MONTH(tgl) = 03 AND YEAR(tgl) = YEAR(NOW())");
$mar_04 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mar_05 FROM tbl_cashout WHERE kategori = 05 AND MONTH(tgl) = 03 AND YEAR(tgl) = YEAR(NOW())");
$mar_05 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mar_06 FROM tbl_cashout WHERE kategori = 06 AND MONTH(tgl) = 03 AND YEAR(tgl) = YEAR(NOW())");
$mar_06 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mar_07 FROM tbl_cashout WHERE kategori = 07 AND MONTH(tgl) = 03 AND YEAR(tgl) = YEAR(NOW())");
$mar_07 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mar_08 FROM tbl_cashout WHERE kategori = 08 AND MONTH(tgl) = 03 AND YEAR(tgl) = YEAR(NOW())");
$mar_08 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mar_09 FROM tbl_cashout WHERE kategori = 09 AND MONTH(tgl) = 03 AND YEAR(tgl) = YEAR(NOW())");
$mar_09 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mar_10 FROM tbl_cashout WHERE kategori = 10 AND MONTH(tgl) = 03 AND YEAR(tgl) = YEAR(NOW())");
$mar_10 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mar_11 FROM tbl_cashout WHERE kategori = 11 AND MONTH(tgl) = 03 AND YEAR(tgl) = YEAR(NOW())");
$mar_11 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mar_12 FROM tbl_cashout WHERE kategori = 12 AND MONTH(tgl) = 03 AND YEAR(tgl) = YEAR(NOW())");
$mar_12 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mar_13 FROM tbl_cashout WHERE kategori = 13 AND MONTH(tgl) = 03 AND YEAR(tgl) = YEAR(NOW())");
$mar_13 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mar_14 FROM tbl_cashout WHERE kategori = 14 AND MONTH(tgl) = 03 AND YEAR(tgl) = YEAR(NOW())");
$mar_14 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mar_15 FROM tbl_cashout WHERE kategori = 15 AND MONTH(tgl) = 03 AND YEAR(tgl) = YEAR(NOW())");
$mar_15 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mar_16 FROM tbl_cashout WHERE kategori = 16 AND MONTH(tgl) = 03 AND YEAR(tgl) = YEAR(NOW())");
$mar_16 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mar_17 FROM tbl_cashout WHERE kategori = 17 AND MONTH(tgl) = 03 AND YEAR(tgl) = YEAR(NOW())");
$mar_17 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mar_18 FROM tbl_cashout WHERE kategori = 18 AND MONTH(tgl) = 03 AND YEAR(tgl) = YEAR(NOW())");
$mar_18 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mar_19 FROM tbl_cashout WHERE kategori = 19 AND MONTH(tgl) = 03 AND YEAR(tgl) = YEAR(NOW())");
$mar_19 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mar_20 FROM tbl_cashout WHERE kategori = 20 AND MONTH(tgl) = 03 AND YEAR(tgl) = YEAR(NOW())");
$mar_20 = $query->fetch_assoc();

//APR
$query = $mysqli->query("SELECT SUM(nilai) AS tot_apr_01 FROM tbl_cashout WHERE kategori = 01 AND MONTH(tgl) = 04 AND YEAR(tgl) = YEAR(NOW())");
$apr_01 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_apr_02 FROM tbl_cashout WHERE kategori = 02 AND MONTH(tgl) = 04 AND YEAR(tgl) = YEAR(NOW())");
$apr_02 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_apr_03 FROM tbl_cashout WHERE kategori = 03 AND MONTH(tgl) = 04 AND YEAR(tgl) = YEAR(NOW())");
$apr_03 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_apr_04 FROM tbl_cashout WHERE kategori = 04 AND MONTH(tgl) = 04 AND YEAR(tgl) = YEAR(NOW())");
$apr_04 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_apr_05 FROM tbl_cashout WHERE kategori = 05 AND MONTH(tgl) = 04 AND YEAR(tgl) = YEAR(NOW())");
$apr_05 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_apr_06 FROM tbl_cashout WHERE kategori = 06 AND MONTH(tgl) = 04 AND YEAR(tgl) = YEAR(NOW())");
$apr_06 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_apr_07 FROM tbl_cashout WHERE kategori = 07 AND MONTH(tgl) = 04 AND YEAR(tgl) = YEAR(NOW())");
$apr_07 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_apr_08 FROM tbl_cashout WHERE kategori = 08 AND MONTH(tgl) = 04 AND YEAR(tgl) = YEAR(NOW())");
$apr_08 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_apr_09 FROM tbl_cashout WHERE kategori = 09 AND MONTH(tgl) = 04 AND YEAR(tgl) = YEAR(NOW())");
$apr_09 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_apr_10 FROM tbl_cashout WHERE kategori = 10 AND MONTH(tgl) = 04 AND YEAR(tgl) = YEAR(NOW())");
$apr_10 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_apr_11 FROM tbl_cashout WHERE kategori = 11 AND MONTH(tgl) = 04 AND YEAR(tgl) = YEAR(NOW())");
$apr_11 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_apr_12 FROM tbl_cashout WHERE kategori = 12 AND MONTH(tgl) = 04 AND YEAR(tgl) = YEAR(NOW())");
$apr_12 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_apr_13 FROM tbl_cashout WHERE kategori = 13 AND MONTH(tgl) = 04 AND YEAR(tgl) = YEAR(NOW())");
$apr_13 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_apr_14 FROM tbl_cashout WHERE kategori = 14 AND MONTH(tgl) = 04 AND YEAR(tgl) = YEAR(NOW())");
$apr_14 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_apr_15 FROM tbl_cashout WHERE kategori = 15 AND MONTH(tgl) = 04 AND YEAR(tgl) = YEAR(NOW())");
$apr_15 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_apr_16 FROM tbl_cashout WHERE kategori = 16 AND MONTH(tgl) = 04 AND YEAR(tgl) = YEAR(NOW())");
$apr_16 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_apr_17 FROM tbl_cashout WHERE kategori = 17 AND MONTH(tgl) = 04 AND YEAR(tgl) = YEAR(NOW())");
$apr_17 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_apr_18 FROM tbl_cashout WHERE kategori = 18 AND MONTH(tgl) = 04 AND YEAR(tgl) = YEAR(NOW())");
$apr_18 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_apr_19 FROM tbl_cashout WHERE kategori = 19 AND MONTH(tgl) = 04 AND YEAR(tgl) = YEAR(NOW())");
$apr_19 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_apr_20 FROM tbl_cashout WHERE kategori = 20 AND MONTH(tgl) = 04 AND YEAR(tgl) = YEAR(NOW())");
$apr_20 = $query->fetch_assoc();

//MEI
$query = $mysqli->query("SELECT SUM(nilai) AS tot_mei_01 FROM tbl_cashout WHERE kategori = 01 AND MONTH(tgl) = 05 AND YEAR(tgl) = YEAR(NOW())");
$mei_01 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mei_02 FROM tbl_cashout WHERE kategori = 02 AND MONTH(tgl) = 05 AND YEAR(tgl) = YEAR(NOW())");
$mei_02 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mei_03 FROM tbl_cashout WHERE kategori = 03 AND MONTH(tgl) = 05 AND YEAR(tgl) = YEAR(NOW())");
$mei_03 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mei_04 FROM tbl_cashout WHERE kategori = 04 AND MONTH(tgl) = 05 AND YEAR(tgl) = YEAR(NOW())");
$mei_04 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mei_05 FROM tbl_cashout WHERE kategori = 05 AND MONTH(tgl) = 05 AND YEAR(tgl) = YEAR(NOW())");
$mei_05 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mei_06 FROM tbl_cashout WHERE kategori = 06 AND MONTH(tgl) = 05 AND YEAR(tgl) = YEAR(NOW())");
$mei_06 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mei_07 FROM tbl_cashout WHERE kategori = 07 AND MONTH(tgl) = 05 AND YEAR(tgl) = YEAR(NOW())");
$mei_07 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mei_08 FROM tbl_cashout WHERE kategori = 08 AND MONTH(tgl) = 05 AND YEAR(tgl) = YEAR(NOW())");
$mei_08 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mei_09 FROM tbl_cashout WHERE kategori = 09 AND MONTH(tgl) = 05 AND YEAR(tgl) = YEAR(NOW())");
$mei_09 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mei_10 FROM tbl_cashout WHERE kategori = 10 AND MONTH(tgl) = 05 AND YEAR(tgl) = YEAR(NOW())");
$mei_10 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mei_11 FROM tbl_cashout WHERE kategori = 11 AND MONTH(tgl) = 05 AND YEAR(tgl) = YEAR(NOW())");
$mei_11 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mei_12 FROM tbl_cashout WHERE kategori = 12 AND MONTH(tgl) = 05 AND YEAR(tgl) = YEAR(NOW())");
$mei_12 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mei_13 FROM tbl_cashout WHERE kategori = 13 AND MONTH(tgl) = 05 AND YEAR(tgl) = YEAR(NOW())");
$mei_13 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mei_14 FROM tbl_cashout WHERE kategori = 14 AND MONTH(tgl) = 05 AND YEAR(tgl) = YEAR(NOW())");
$mei_14 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mei_15 FROM tbl_cashout WHERE kategori = 15 AND MONTH(tgl) = 05 AND YEAR(tgl) = YEAR(NOW())");
$mei_15 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mei_16 FROM tbl_cashout WHERE kategori = 16 AND MONTH(tgl) = 05 AND YEAR(tgl) = YEAR(NOW())");
$mei_16 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mei_17 FROM tbl_cashout WHERE kategori = 17 AND MONTH(tgl) = 05 AND YEAR(tgl) = YEAR(NOW())");
$mei_17 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mei_18 FROM tbl_cashout WHERE kategori = 18 AND MONTH(tgl) = 05 AND YEAR(tgl) = YEAR(NOW())");
$mei_18 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mei_19 FROM tbl_cashout WHERE kategori = 19 AND MONTH(tgl) = 05 AND YEAR(tgl) = YEAR(NOW())");
$mei_19 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_mei_20 FROM tbl_cashout WHERE kategori = 20 AND MONTH(tgl) = 05 AND YEAR(tgl) = YEAR(NOW())");
$mei_20 = $query->fetch_assoc();

//JUN
$query = $mysqli->query("SELECT SUM(nilai) AS tot_jun_01 FROM tbl_cashout WHERE kategori = 01 AND MONTH(tgl) = 06 AND YEAR(tgl) = YEAR(NOW())");
$jun_01 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jun_02 FROM tbl_cashout WHERE kategori = 02 AND MONTH(tgl) = 06 AND YEAR(tgl) = YEAR(NOW())");
$jun_02 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jun_03 FROM tbl_cashout WHERE kategori = 03 AND MONTH(tgl) = 06 AND YEAR(tgl) = YEAR(NOW())");
$jun_03 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jun_04 FROM tbl_cashout WHERE kategori = 04 AND MONTH(tgl) = 06 AND YEAR(tgl) = YEAR(NOW())");
$jun_04 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jun_05 FROM tbl_cashout WHERE kategori = 05 AND MONTH(tgl) = 06 AND YEAR(tgl) = YEAR(NOW())");
$jun_05 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jun_06 FROM tbl_cashout WHERE kategori = 06 AND MONTH(tgl) = 06 AND YEAR(tgl) = YEAR(NOW())");
$jun_06 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jun_07 FROM tbl_cashout WHERE kategori = 07 AND MONTH(tgl) = 06 AND YEAR(tgl) = YEAR(NOW())");
$jun_07 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jun_08 FROM tbl_cashout WHERE kategori = 08 AND MONTH(tgl) = 06 AND YEAR(tgl) = YEAR(NOW())");
$jun_08 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jun_09 FROM tbl_cashout WHERE kategori = 09 AND MONTH(tgl) = 06 AND YEAR(tgl) = YEAR(NOW())");
$jun_09 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jun_10 FROM tbl_cashout WHERE kategori = 10 AND MONTH(tgl) = 06 AND YEAR(tgl) = YEAR(NOW())");
$jun_10 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jun_11 FROM tbl_cashout WHERE kategori = 11 AND MONTH(tgl) = 06 AND YEAR(tgl) = YEAR(NOW())");
$jun_11 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jun_12 FROM tbl_cashout WHERE kategori = 12 AND MONTH(tgl) = 06 AND YEAR(tgl) = YEAR(NOW())");
$jun_12 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jun_13 FROM tbl_cashout WHERE kategori = 13 AND MONTH(tgl) = 06 AND YEAR(tgl) = YEAR(NOW())");
$jun_13 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jun_14 FROM tbl_cashout WHERE kategori = 14 AND MONTH(tgl) = 06 AND YEAR(tgl) = YEAR(NOW())");
$jun_14 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jun_15 FROM tbl_cashout WHERE kategori = 15 AND MONTH(tgl) = 06 AND YEAR(tgl) = YEAR(NOW())");
$jun_15 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jun_16 FROM tbl_cashout WHERE kategori = 16 AND MONTH(tgl) = 06 AND YEAR(tgl) = YEAR(NOW())");
$jun_16 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jun_17 FROM tbl_cashout WHERE kategori = 17 AND MONTH(tgl) = 06 AND YEAR(tgl) = YEAR(NOW())");
$jun_17 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jun_18 FROM tbl_cashout WHERE kategori = 18 AND MONTH(tgl) = 06 AND YEAR(tgl) = YEAR(NOW())");
$jun_18 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jun_19 FROM tbl_cashout WHERE kategori = 19 AND MONTH(tgl) = 06 AND YEAR(tgl) = YEAR(NOW())");
$jun_19 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jun_20 FROM tbl_cashout WHERE kategori = 20 AND MONTH(tgl) = 06 AND YEAR(tgl) = YEAR(NOW())");
$jun_20 = $query->fetch_assoc();

//JUL
$query = $mysqli->query("SELECT SUM(nilai) AS tot_jul_01 FROM tbl_cashout WHERE kategori = 01 AND MONTH(tgl) = 07 AND YEAR(tgl) = YEAR(NOW())");
$jul_01 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jul_02 FROM tbl_cashout WHERE kategori = 02 AND MONTH(tgl) = 07 AND YEAR(tgl) = YEAR(NOW())");
$jul_02 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jul_03 FROM tbl_cashout WHERE kategori = 03 AND MONTH(tgl) = 07 AND YEAR(tgl) = YEAR(NOW())");
$jul_03 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jul_04 FROM tbl_cashout WHERE kategori = 04 AND MONTH(tgl) = 07 AND YEAR(tgl) = YEAR(NOW())");
$jul_04 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jul_05 FROM tbl_cashout WHERE kategori = 05 AND MONTH(tgl) = 07 AND YEAR(tgl) = YEAR(NOW())");
$jul_05 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jul_06 FROM tbl_cashout WHERE kategori = 06 AND MONTH(tgl) = 07 AND YEAR(tgl) = YEAR(NOW())");
$jul_06 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jul_07 FROM tbl_cashout WHERE kategori = 07 AND MONTH(tgl) = 07 AND YEAR(tgl) = YEAR(NOW())");
$jul_07 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jul_08 FROM tbl_cashout WHERE kategori = 08 AND MONTH(tgl) = 07 AND YEAR(tgl) = YEAR(NOW())");
$jul_08 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jul_09 FROM tbl_cashout WHERE kategori = 09 AND MONTH(tgl) = 07 AND YEAR(tgl) = YEAR(NOW())");
$jul_09 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jul_10 FROM tbl_cashout WHERE kategori = 10 AND MONTH(tgl) = 07 AND YEAR(tgl) = YEAR(NOW())");
$jul_10 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jul_11 FROM tbl_cashout WHERE kategori = 11 AND MONTH(tgl) = 07 AND YEAR(tgl) = YEAR(NOW())");
$jul_11 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jul_12 FROM tbl_cashout WHERE kategori = 12 AND MONTH(tgl) = 07 AND YEAR(tgl) = YEAR(NOW())");
$jul_12 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jul_13 FROM tbl_cashout WHERE kategori = 13 AND MONTH(tgl) = 07 AND YEAR(tgl) = YEAR(NOW())");
$jul_13 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jul_14 FROM tbl_cashout WHERE kategori = 14 AND MONTH(tgl) = 07 AND YEAR(tgl) = YEAR(NOW())");
$jul_14 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jul_15 FROM tbl_cashout WHERE kategori = 15 AND MONTH(tgl) = 07 AND YEAR(tgl) = YEAR(NOW())");
$jul_15 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jul_16 FROM tbl_cashout WHERE kategori = 16 AND MONTH(tgl) = 07 AND YEAR(tgl) = YEAR(NOW())");
$jul_16 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jul_17 FROM tbl_cashout WHERE kategori = 17 AND MONTH(tgl) = 07 AND YEAR(tgl) = YEAR(NOW())");
$jul_17 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jul_18 FROM tbl_cashout WHERE kategori = 18 AND MONTH(tgl) = 07 AND YEAR(tgl) = YEAR(NOW())");
$jul_18 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jul_19 FROM tbl_cashout WHERE kategori = 19 AND MONTH(tgl) = 07 AND YEAR(tgl) = YEAR(NOW())");
$jul_19 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_jul_20 FROM tbl_cashout WHERE kategori = 20 AND MONTH(tgl) = 07 AND YEAR(tgl) = YEAR(NOW())");
$jul_20 = $query->fetch_assoc();

//AGT
$query = $mysqli->query("SELECT SUM(nilai) AS tot_agt_01 FROM tbl_cashout WHERE kategori = 01 AND MONTH(tgl) = 08 AND YEAR(tgl) = YEAR(NOW())");
$agt_01 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_agt_02 FROM tbl_cashout WHERE kategori = 02 AND MONTH(tgl) = 08 AND YEAR(tgl) = YEAR(NOW())");
$agt_02 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_agt_03 FROM tbl_cashout WHERE kategori = 03 AND MONTH(tgl) = 08 AND YEAR(tgl) = YEAR(NOW())");
$agt_03 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_agt_04 FROM tbl_cashout WHERE kategori = 04 AND MONTH(tgl) = 08 AND YEAR(tgl) = YEAR(NOW())");
$agt_04 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_agt_05 FROM tbl_cashout WHERE kategori = 05 AND MONTH(tgl) = 08 AND YEAR(tgl) = YEAR(NOW())");
$agt_05 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_agt_06 FROM tbl_cashout WHERE kategori = 06 AND MONTH(tgl) = 08 AND YEAR(tgl) = YEAR(NOW())");
$agt_06 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_agt_07 FROM tbl_cashout WHERE kategori = 07 AND MONTH(tgl) = 08 AND YEAR(tgl) = YEAR(NOW())");
$agt_07 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_agt_08 FROM tbl_cashout WHERE kategori = 08 AND MONTH(tgl) = 08 AND YEAR(tgl) = YEAR(NOW())");
$agt_08 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_agt_09 FROM tbl_cashout WHERE kategori = 09 AND MONTH(tgl) = 08 AND YEAR(tgl) = YEAR(NOW())");
$agt_09 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_agt_10 FROM tbl_cashout WHERE kategori = 10 AND MONTH(tgl) = 08 AND YEAR(tgl) = YEAR(NOW())");
$agt_10 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_agt_11 FROM tbl_cashout WHERE kategori = 11 AND MONTH(tgl) = 08 AND YEAR(tgl) = YEAR(NOW())");
$agt_11 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_agt_12 FROM tbl_cashout WHERE kategori = 12 AND MONTH(tgl) = 08 AND YEAR(tgl) = YEAR(NOW())");
$agt_12 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_agt_13 FROM tbl_cashout WHERE kategori = 13 AND MONTH(tgl) = 08 AND YEAR(tgl) = YEAR(NOW())");
$agt_13 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_agt_14 FROM tbl_cashout WHERE kategori = 14 AND MONTH(tgl) = 08 AND YEAR(tgl) = YEAR(NOW())");
$agt_14 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_agt_15 FROM tbl_cashout WHERE kategori = 15 AND MONTH(tgl) = 08 AND YEAR(tgl) = YEAR(NOW())");
$agt_15 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_agt_16 FROM tbl_cashout WHERE kategori = 16 AND MONTH(tgl) = 08 AND YEAR(tgl) = YEAR(NOW())");
$agt_16 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_agt_17 FROM tbl_cashout WHERE kategori = 17 AND MONTH(tgl) = 08 AND YEAR(tgl) = YEAR(NOW())");
$agt_17 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_agt_18 FROM tbl_cashout WHERE kategori = 18 AND MONTH(tgl) = 08 AND YEAR(tgl) = YEAR(NOW())");
$agt_18 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_agt_19 FROM tbl_cashout WHERE kategori = 19 AND MONTH(tgl) = 08 AND YEAR(tgl) = YEAR(NOW())");
$agt_19 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_agt_20 FROM tbl_cashout WHERE kategori = 20 AND MONTH(tgl) = 08 AND YEAR(tgl) = YEAR(NOW())");
$agt_20 = $query->fetch_assoc();

//SEP
$query = $mysqli->query("SELECT SUM(nilai) AS tot_sep_01 FROM tbl_cashout WHERE kategori = 01 AND MONTH(tgl) = 09 AND YEAR(tgl) = YEAR(NOW())");
$sep_01 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_sep_02 FROM tbl_cashout WHERE kategori = 02 AND MONTH(tgl) = 09 AND YEAR(tgl) = YEAR(NOW())");
$sep_02 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_sep_03 FROM tbl_cashout WHERE kategori = 03 AND MONTH(tgl) = 09 AND YEAR(tgl) = YEAR(NOW())");
$sep_03 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_sep_04 FROM tbl_cashout WHERE kategori = 04 AND MONTH(tgl) = 09 AND YEAR(tgl) = YEAR(NOW())");
$sep_04 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_sep_05 FROM tbl_cashout WHERE kategori = 05 AND MONTH(tgl) = 09 AND YEAR(tgl) = YEAR(NOW())");
$sep_05 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_sep_06 FROM tbl_cashout WHERE kategori = 06 AND MONTH(tgl) = 09 AND YEAR(tgl) = YEAR(NOW())");
$sep_06 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_sep_07 FROM tbl_cashout WHERE kategori = 07 AND MONTH(tgl) = 09 AND YEAR(tgl) = YEAR(NOW())");
$sep_07 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_sep_08 FROM tbl_cashout WHERE kategori = 08 AND MONTH(tgl) = 09 AND YEAR(tgl) = YEAR(NOW())");
$sep_08 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_sep_09 FROM tbl_cashout WHERE kategori = 09 AND MONTH(tgl) = 09 AND YEAR(tgl) = YEAR(NOW())");
$sep_09 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_sep_10 FROM tbl_cashout WHERE kategori = 10 AND MONTH(tgl) = 09 AND YEAR(tgl) = YEAR(NOW())");
$sep_10 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_sep_11 FROM tbl_cashout WHERE kategori = 11 AND MONTH(tgl) = 09 AND YEAR(tgl) = YEAR(NOW())");
$sep_11 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_sep_12 FROM tbl_cashout WHERE kategori = 12 AND MONTH(tgl) = 09 AND YEAR(tgl) = YEAR(NOW())");
$sep_12 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_sep_13 FROM tbl_cashout WHERE kategori = 13 AND MONTH(tgl) = 09 AND YEAR(tgl) = YEAR(NOW())");
$sep_13 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_sep_14 FROM tbl_cashout WHERE kategori = 14 AND MONTH(tgl) = 09 AND YEAR(tgl) = YEAR(NOW())");
$sep_14 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_sep_15 FROM tbl_cashout WHERE kategori = 15 AND MONTH(tgl) = 09 AND YEAR(tgl) = YEAR(NOW())");
$sep_15 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_sep_16 FROM tbl_cashout WHERE kategori = 16 AND MONTH(tgl) = 09 AND YEAR(tgl) = YEAR(NOW())");
$sep_16 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_sep_17 FROM tbl_cashout WHERE kategori = 17 AND MONTH(tgl) = 09 AND YEAR(tgl) = YEAR(NOW())");
$sep_17 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_sep_18 FROM tbl_cashout WHERE kategori = 18 AND MONTH(tgl) = 09 AND YEAR(tgl) = YEAR(NOW())");
$sep_18 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_sep_19 FROM tbl_cashout WHERE kategori = 19 AND MONTH(tgl) = 09 AND YEAR(tgl) = YEAR(NOW())");
$sep_19 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_sep_20 FROM tbl_cashout WHERE kategori = 20 AND MONTH(tgl) = 09 AND YEAR(tgl) = YEAR(NOW())");
$sep_20 = $query->fetch_assoc();

//OKT
$query = $mysqli->query("SELECT SUM(nilai) AS tot_okt_01 FROM tbl_cashout WHERE kategori = 01 AND MONTH(tgl) = 10 AND YEAR(tgl) = YEAR(NOW())");
$okt_01 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_okt_02 FROM tbl_cashout WHERE kategori = 02 AND MONTH(tgl) = 10 AND YEAR(tgl) = YEAR(NOW())");
$okt_02 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_okt_03 FROM tbl_cashout WHERE kategori = 03 AND MONTH(tgl) = 10 AND YEAR(tgl) = YEAR(NOW())");
$okt_03 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_okt_04 FROM tbl_cashout WHERE kategori = 04 AND MONTH(tgl) = 10 AND YEAR(tgl) = YEAR(NOW())");
$okt_04 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_okt_05 FROM tbl_cashout WHERE kategori = 05 AND MONTH(tgl) = 10 AND YEAR(tgl) = YEAR(NOW())");
$okt_05 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_okt_06 FROM tbl_cashout WHERE kategori = 06 AND MONTH(tgl) = 10 AND YEAR(tgl) = YEAR(NOW())");
$okt_06 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_okt_07 FROM tbl_cashout WHERE kategori = 07 AND MONTH(tgl) = 10 AND YEAR(tgl) = YEAR(NOW())");
$okt_07 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_okt_08 FROM tbl_cashout WHERE kategori = 08 AND MONTH(tgl) = 10 AND YEAR(tgl) = YEAR(NOW())");
$okt_08 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_okt_09 FROM tbl_cashout WHERE kategori = 09 AND MONTH(tgl) = 10 AND YEAR(tgl) = YEAR(NOW())");
$okt_09 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_okt_10 FROM tbl_cashout WHERE kategori = 10 AND MONTH(tgl) = 10 AND YEAR(tgl) = YEAR(NOW())");
$okt_10 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_okt_11 FROM tbl_cashout WHERE kategori = 11 AND MONTH(tgl) = 10 AND YEAR(tgl) = YEAR(NOW())");
$okt_11 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_okt_12 FROM tbl_cashout WHERE kategori = 12 AND MONTH(tgl) = 10 AND YEAR(tgl) = YEAR(NOW())");
$okt_12 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_okt_13 FROM tbl_cashout WHERE kategori = 13 AND MONTH(tgl) = 10 AND YEAR(tgl) = YEAR(NOW())");
$okt_13 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_okt_14 FROM tbl_cashout WHERE kategori = 14 AND MONTH(tgl) = 10 AND YEAR(tgl) = YEAR(NOW())");
$okt_14 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_okt_15 FROM tbl_cashout WHERE kategori = 15 AND MONTH(tgl) = 10 AND YEAR(tgl) = YEAR(NOW())");
$okt_15 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_okt_16 FROM tbl_cashout WHERE kategori = 16 AND MONTH(tgl) = 10 AND YEAR(tgl) = YEAR(NOW())");
$okt_16 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_okt_17 FROM tbl_cashout WHERE kategori = 17 AND MONTH(tgl) = 10 AND YEAR(tgl) = YEAR(NOW())");
$okt_17 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_okt_18 FROM tbl_cashout WHERE kategori = 18 AND MONTH(tgl) = 10 AND YEAR(tgl) = YEAR(NOW())");
$okt_18 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_okt_19 FROM tbl_cashout WHERE kategori = 19 AND MONTH(tgl) = 10 AND YEAR(tgl) = YEAR(NOW())");
$okt_19 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_okt_20 FROM tbl_cashout WHERE kategori = 20 AND MONTH(tgl) = 10 AND YEAR(tgl) = YEAR(NOW())");
$okt_20 = $query->fetch_assoc();

//NOV
$query = $mysqli->query("SELECT SUM(nilai) AS tot_nov_01 FROM tbl_cashout WHERE kategori = 01 AND MONTH(tgl) = 11 AND YEAR(tgl) = YEAR(NOW())");
$nov_01 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_nov_02 FROM tbl_cashout WHERE kategori = 02 AND MONTH(tgl) = 11 AND YEAR(tgl) = YEAR(NOW())");
$nov_02 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_nov_03 FROM tbl_cashout WHERE kategori = 03 AND MONTH(tgl) = 11 AND YEAR(tgl) = YEAR(NOW())");
$nov_03 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_nov_04 FROM tbl_cashout WHERE kategori = 04 AND MONTH(tgl) = 11 AND YEAR(tgl) = YEAR(NOW())");
$nov_04 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_nov_05 FROM tbl_cashout WHERE kategori = 05 AND MONTH(tgl) = 11 AND YEAR(tgl) = YEAR(NOW())");
$nov_05 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_nov_06 FROM tbl_cashout WHERE kategori = 06 AND MONTH(tgl) = 11 AND YEAR(tgl) = YEAR(NOW())");
$nov_06 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_nov_07 FROM tbl_cashout WHERE kategori = 07 AND MONTH(tgl) = 11 AND YEAR(tgl) = YEAR(NOW())");
$nov_07 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_nov_08 FROM tbl_cashout WHERE kategori = 08 AND MONTH(tgl) = 11 AND YEAR(tgl) = YEAR(NOW())");
$nov_08 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_nov_09 FROM tbl_cashout WHERE kategori = 09 AND MONTH(tgl) = 11 AND YEAR(tgl) = YEAR(NOW())");
$nov_09 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_nov_10 FROM tbl_cashout WHERE kategori = 10 AND MONTH(tgl) = 11 AND YEAR(tgl) = YEAR(NOW())");
$nov_10 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_nov_11 FROM tbl_cashout WHERE kategori = 11 AND MONTH(tgl) = 11 AND YEAR(tgl) = YEAR(NOW())");
$nov_11 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_nov_12 FROM tbl_cashout WHERE kategori = 12 AND MONTH(tgl) = 11 AND YEAR(tgl) = YEAR(NOW())");
$nov_12 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_nov_13 FROM tbl_cashout WHERE kategori = 13 AND MONTH(tgl) = 11 AND YEAR(tgl) = YEAR(NOW())");
$nov_13 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_nov_14 FROM tbl_cashout WHERE kategori = 14 AND MONTH(tgl) = 11 AND YEAR(tgl) = YEAR(NOW())");
$nov_14 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_nov_15 FROM tbl_cashout WHERE kategori = 15 AND MONTH(tgl) = 11 AND YEAR(tgl) = YEAR(NOW())");
$nov_15 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_nov_16 FROM tbl_cashout WHERE kategori = 16 AND MONTH(tgl) = 11 AND YEAR(tgl) = YEAR(NOW())");
$nov_16 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_nov_17 FROM tbl_cashout WHERE kategori = 17 AND MONTH(tgl) = 11 AND YEAR(tgl) = YEAR(NOW())");
$nov_17 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_nov_18 FROM tbl_cashout WHERE kategori = 18 AND MONTH(tgl) = 11 AND YEAR(tgl) = YEAR(NOW())");
$nov_18 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_nov_19 FROM tbl_cashout WHERE kategori = 19 AND MONTH(tgl) = 11 AND YEAR(tgl) = YEAR(NOW())");
$nov_19 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_nov_20 FROM tbl_cashout WHERE kategori = 20 AND MONTH(tgl) = 11 AND YEAR(tgl) = YEAR(NOW())");
$nov_20 = $query->fetch_assoc();

//DES
$query = $mysqli->query("SELECT SUM(nilai) AS tot_des_01 FROM tbl_cashout WHERE kategori = 01 AND MONTH(tgl) = 12 AND YEAR(tgl) = YEAR(NOW())");
$des_01 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_des_02 FROM tbl_cashout WHERE kategori = 02 AND MONTH(tgl) = 12 AND YEAR(tgl) = YEAR(NOW())");
$des_02 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_des_03 FROM tbl_cashout WHERE kategori = 03 AND MONTH(tgl) = 12 AND YEAR(tgl) = YEAR(NOW())");
$des_03 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_des_04 FROM tbl_cashout WHERE kategori = 04 AND MONTH(tgl) = 12 AND YEAR(tgl) = YEAR(NOW())");
$des_04 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_des_05 FROM tbl_cashout WHERE kategori = 05 AND MONTH(tgl) = 12 AND YEAR(tgl) = YEAR(NOW())");
$des_05 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_des_06 FROM tbl_cashout WHERE kategori = 06 AND MONTH(tgl) = 12 AND YEAR(tgl) = YEAR(NOW())");
$des_06 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_des_07 FROM tbl_cashout WHERE kategori = 07 AND MONTH(tgl) = 12 AND YEAR(tgl) = YEAR(NOW())");
$des_07 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_des_08 FROM tbl_cashout WHERE kategori = 08 AND MONTH(tgl) = 12 AND YEAR(tgl) = YEAR(NOW())");
$des_08 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_des_09 FROM tbl_cashout WHERE kategori = 09 AND MONTH(tgl) = 12 AND YEAR(tgl) = YEAR(NOW())");
$des_09 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_des_10 FROM tbl_cashout WHERE kategori = 10 AND MONTH(tgl) = 12 AND YEAR(tgl) = YEAR(NOW())");
$des_10 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_des_11 FROM tbl_cashout WHERE kategori = 11 AND MONTH(tgl) = 12 AND YEAR(tgl) = YEAR(NOW())");
$des_11 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_des_12 FROM tbl_cashout WHERE kategori = 12 AND MONTH(tgl) = 12 AND YEAR(tgl) = YEAR(NOW())");
$des_12 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_des_13 FROM tbl_cashout WHERE kategori = 13 AND MONTH(tgl) = 12 AND YEAR(tgl) = YEAR(NOW())");
$des_13 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_des_14 FROM tbl_cashout WHERE kategori = 14 AND MONTH(tgl) = 12 AND YEAR(tgl) = YEAR(NOW())");
$des_14 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_des_15 FROM tbl_cashout WHERE kategori = 15 AND MONTH(tgl) = 12 AND YEAR(tgl) = YEAR(NOW())");
$des_15 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_des_16 FROM tbl_cashout WHERE kategori = 16 AND MONTH(tgl) = 12 AND YEAR(tgl) = YEAR(NOW())");
$des_16 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_des_17 FROM tbl_cashout WHERE kategori = 17 AND MONTH(tgl) = 12 AND YEAR(tgl) = YEAR(NOW())");
$des_17 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_des_18 FROM tbl_cashout WHERE kategori = 18 AND MONTH(tgl) = 12 AND YEAR(tgl) = YEAR(NOW())");
$des_18 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_des_19 FROM tbl_cashout WHERE kategori = 19 AND MONTH(tgl) = 12 AND YEAR(tgl) = YEAR(NOW())");
$des_19 = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_des_20 FROM tbl_cashout WHERE kategori = 20 AND MONTH(tgl) = 12 AND YEAR(tgl) = YEAR(NOW())");
$des_20 = $query->fetch_assoc();
?>

<div id="stat_exp_cat" style="height: 470px;"></div>
<table class="table table-striped" id="tabel_stat_exp_cat" style="display: none;">
    <thead>
        <tr>
            <th>Bulan</th>
            <th>BRI Credit Anuity</th>
            <th>Birrul Walidain</th>
            <th>My Lovely Liebling</th>
            <th>Shofiyyah Meccara</th>
            <th>House Rent</th>
            <th>House Routine</th>
            <th>Gallon Routine</th>
            <th>Groceries</th>
            <th>Util. Electricity</th>
            <th>Util. Internet</th>
            <th>Util. Gas</th>
            <th>Util. Water</th>
            <th>Fuel</th>
            <th>Emergency Fund</th>
            <th>Drive/Cloud Subscription</th>
            <th>Hosting/Domain Subscription</th>
            <th>Vacation</th>
            <th>Vehicle Routine Service</th>
            <th>Vehicle Taxes</th>
            <th>Home Supplies</th>
        </tr>
    </thead>

    <tbody>
        <tr>
            <th>Jan</th>
            <?php echo "<td>" . $jan_01['tot_jan_01'] . "</td>"; ?>
            <?php echo "<td>" . $jan_02['tot_jan_02'] . "</td>"; ?>
            <?php echo "<td>" . $jan_03['tot_jan_03'] . "</td>"; ?>
            <?php echo "<td>" . $jan_04['tot_jan_04'] . "</td>"; ?>
            <?php echo "<td>" . $jan_05['tot_jan_05'] . "</td>"; ?>
            <?php echo "<td>" . $jan_06['tot_jan_06'] . "</td>"; ?>
            <?php echo "<td>" . $jan_07['tot_jan_07'] . "</td>"; ?>
            <?php echo "<td>" . $jan_08['tot_jan_08'] . "</td>"; ?>
            <?php echo "<td>" . $jan_09['tot_jan_09'] . "</td>"; ?>
            <?php echo "<td>" . $jan_10['tot_jan_10'] . "</td>"; ?>
            <?php echo "<td>" . $jan_11['tot_jan_11'] . "</td>"; ?>
            <?php echo "<td>" . $jan_12['tot_jan_12'] . "</td>"; ?>
            <?php echo "<td>" . $jan_13['tot_jan_13'] . "</td>"; ?>
            <?php echo "<td>" . $jan_14['tot_jan_14'] . "</td>"; ?>
            <?php echo "<td>" . $jan_15['tot_jan_15'] . "</td>"; ?>
            <?php echo "<td>" . $jan_16['tot_jan_16'] . "</td>"; ?>
            <?php echo "<td>" . $jan_17['tot_jan_17'] . "</td>"; ?>
            <?php echo "<td>" . $jan_18['tot_jan_18'] . "</td>"; ?>
            <?php echo "<td>" . $jan_19['tot_jan_19'] . "</td>"; ?>
            <?php echo "<td>" . $jan_20['tot_jan_20'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Feb</th>
            <?php echo "<td>" . $feb_01['tot_feb_01'] . "</td>"; ?>
            <?php echo "<td>" . $feb_02['tot_feb_02'] . "</td>"; ?>
            <?php echo "<td>" . $feb_03['tot_feb_03'] . "</td>"; ?>
            <?php echo "<td>" . $feb_04['tot_feb_04'] . "</td>"; ?>
            <?php echo "<td>" . $feb_05['tot_feb_05'] . "</td>"; ?>
            <?php echo "<td>" . $feb_06['tot_feb_06'] . "</td>"; ?>
            <?php echo "<td>" . $feb_07['tot_feb_07'] . "</td>"; ?>
            <?php echo "<td>" . $feb_08['tot_feb_08'] . "</td>"; ?>
            <?php echo "<td>" . $feb_09['tot_feb_09'] . "</td>"; ?>
            <?php echo "<td>" . $feb_10['tot_feb_10'] . "</td>"; ?>
            <?php echo "<td>" . $feb_11['tot_feb_11'] . "</td>"; ?>
            <?php echo "<td>" . $feb_12['tot_feb_12'] . "</td>"; ?>
            <?php echo "<td>" . $feb_13['tot_feb_13'] . "</td>"; ?>
            <?php echo "<td>" . $feb_14['tot_feb_14'] . "</td>"; ?>
            <?php echo "<td>" . $feb_15['tot_feb_15'] . "</td>"; ?>
            <?php echo "<td>" . $feb_16['tot_feb_16'] . "</td>"; ?>
            <?php echo "<td>" . $feb_17['tot_feb_17'] . "</td>"; ?>
            <?php echo "<td>" . $feb_18['tot_feb_18'] . "</td>"; ?>
            <?php echo "<td>" . $feb_19['tot_feb_19'] . "</td>"; ?>
            <?php echo "<td>" . $feb_20['tot_feb_20'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Mar</th>
            <?php echo "<td>" . $mar_01['tot_mar_01'] . "</td>"; ?>
            <?php echo "<td>" . $mar_02['tot_mar_02'] . "</td>"; ?>
            <?php echo "<td>" . $mar_03['tot_mar_03'] . "</td>"; ?>
            <?php echo "<td>" . $mar_04['tot_mar_04'] . "</td>"; ?>
            <?php echo "<td>" . $mar_05['tot_mar_05'] . "</td>"; ?>
            <?php echo "<td>" . $mar_06['tot_mar_06'] . "</td>"; ?>
            <?php echo "<td>" . $mar_07['tot_mar_07'] . "</td>"; ?>
            <?php echo "<td>" . $mar_08['tot_mar_08'] . "</td>"; ?>
            <?php echo "<td>" . $mar_09['tot_mar_09'] . "</td>"; ?>
            <?php echo "<td>" . $mar_10['tot_mar_10'] . "</td>"; ?>
            <?php echo "<td>" . $mar_11['tot_mar_11'] . "</td>"; ?>
            <?php echo "<td>" . $mar_12['tot_mar_12'] . "</td>"; ?>
            <?php echo "<td>" . $mar_13['tot_mar_13'] . "</td>"; ?>
            <?php echo "<td>" . $mar_14['tot_mar_14'] . "</td>"; ?>
            <?php echo "<td>" . $mar_15['tot_mar_15'] . "</td>"; ?>
            <?php echo "<td>" . $mar_16['tot_mar_16'] . "</td>"; ?>
            <?php echo "<td>" . $mar_17['tot_mar_17'] . "</td>"; ?>
            <?php echo "<td>" . $mar_18['tot_mar_18'] . "</td>"; ?>
            <?php echo "<td>" . $mar_19['tot_mar_19'] . "</td>"; ?>
            <?php echo "<td>" . $mar_20['tot_mar_20'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Apr</th>
            <?php echo "<td>" . $apr_01['tot_apr_01'] . "</td>"; ?>
            <?php echo "<td>" . $apr_02['tot_apr_02'] . "</td>"; ?>
            <?php echo "<td>" . $apr_03['tot_apr_03'] . "</td>"; ?>
            <?php echo "<td>" . $apr_04['tot_apr_04'] . "</td>"; ?>
            <?php echo "<td>" . $apr_05['tot_apr_05'] . "</td>"; ?>
            <?php echo "<td>" . $apr_06['tot_apr_06'] . "</td>"; ?>
            <?php echo "<td>" . $apr_07['tot_apr_07'] . "</td>"; ?>
            <?php echo "<td>" . $apr_08['tot_apr_08'] . "</td>"; ?>
            <?php echo "<td>" . $apr_09['tot_apr_09'] . "</td>"; ?>
            <?php echo "<td>" . $apr_10['tot_apr_10'] . "</td>"; ?>
            <?php echo "<td>" . $apr_11['tot_apr_11'] . "</td>"; ?>
            <?php echo "<td>" . $apr_12['tot_apr_12'] . "</td>"; ?>
            <?php echo "<td>" . $apr_13['tot_apr_13'] . "</td>"; ?>
            <?php echo "<td>" . $apr_14['tot_apr_14'] . "</td>"; ?>
            <?php echo "<td>" . $apr_15['tot_apr_15'] . "</td>"; ?>
            <?php echo "<td>" . $apr_16['tot_apr_16'] . "</td>"; ?>
            <?php echo "<td>" . $apr_17['tot_apr_17'] . "</td>"; ?>
            <?php echo "<td>" . $apr_18['tot_apr_18'] . "</td>"; ?>
            <?php echo "<td>" . $apr_19['tot_apr_19'] . "</td>"; ?>
            <?php echo "<td>" . $apr_20['tot_apr_20'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Mei</th>
            <?php echo "<td>" . $mei_01['tot_mei_01'] . "</td>"; ?>
            <?php echo "<td>" . $mei_02['tot_mei_02'] . "</td>"; ?>
            <?php echo "<td>" . $mei_03['tot_mei_03'] . "</td>"; ?>
            <?php echo "<td>" . $mei_04['tot_mei_04'] . "</td>"; ?>
            <?php echo "<td>" . $mei_05['tot_mei_05'] . "</td>"; ?>
            <?php echo "<td>" . $mei_06['tot_mei_06'] . "</td>"; ?>
            <?php echo "<td>" . $mei_07['tot_mei_07'] . "</td>"; ?>
            <?php echo "<td>" . $mei_08['tot_mei_08'] . "</td>"; ?>
            <?php echo "<td>" . $mei_09['tot_mei_09'] . "</td>"; ?>
            <?php echo "<td>" . $mei_10['tot_mei_10'] . "</td>"; ?>
            <?php echo "<td>" . $mei_11['tot_mei_11'] . "</td>"; ?>
            <?php echo "<td>" . $mei_12['tot_mei_12'] . "</td>"; ?>
            <?php echo "<td>" . $mei_13['tot_mei_13'] . "</td>"; ?>
            <?php echo "<td>" . $mei_14['tot_mei_14'] . "</td>"; ?>
            <?php echo "<td>" . $mei_15['tot_mei_15'] . "</td>"; ?>
            <?php echo "<td>" . $mei_16['tot_mei_16'] . "</td>"; ?>
            <?php echo "<td>" . $mei_17['tot_mei_17'] . "</td>"; ?>
            <?php echo "<td>" . $mei_18['tot_mei_18'] . "</td>"; ?>
            <?php echo "<td>" . $mei_19['tot_mei_19'] . "</td>"; ?>
            <?php echo "<td>" . $mei_20['tot_mei_20'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Jun</th>
            <?php echo "<td>" . $jun_01['tot_jun_01'] . "</td>"; ?>
            <?php echo "<td>" . $jun_02['tot_jun_02'] . "</td>"; ?>
            <?php echo "<td>" . $jun_03['tot_jun_03'] . "</td>"; ?>
            <?php echo "<td>" . $jun_04['tot_jun_04'] . "</td>"; ?>
            <?php echo "<td>" . $jun_05['tot_jun_05'] . "</td>"; ?>
            <?php echo "<td>" . $jun_06['tot_jun_06'] . "</td>"; ?>
            <?php echo "<td>" . $jun_07['tot_jun_07'] . "</td>"; ?>
            <?php echo "<td>" . $jun_08['tot_jun_08'] . "</td>"; ?>
            <?php echo "<td>" . $jun_09['tot_jun_09'] . "</td>"; ?>
            <?php echo "<td>" . $jun_10['tot_jun_10'] . "</td>"; ?>
            <?php echo "<td>" . $jun_11['tot_jun_11'] . "</td>"; ?>
            <?php echo "<td>" . $jun_12['tot_jun_12'] . "</td>"; ?>
            <?php echo "<td>" . $jun_13['tot_jun_13'] . "</td>"; ?>
            <?php echo "<td>" . $jun_14['tot_jun_14'] . "</td>"; ?>
            <?php echo "<td>" . $jun_15['tot_jun_15'] . "</td>"; ?>
            <?php echo "<td>" . $jun_16['tot_jun_16'] . "</td>"; ?>
            <?php echo "<td>" . $jun_17['tot_jun_17'] . "</td>"; ?>
            <?php echo "<td>" . $jun_18['tot_jun_18'] . "</td>"; ?>
            <?php echo "<td>" . $jun_19['tot_jun_19'] . "</td>"; ?>
            <?php echo "<td>" . $jun_20['tot_jun_20'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Jul</th>
            <?php echo "<td>" . $jul_01['tot_jul_01'] . "</td>"; ?>
            <?php echo "<td>" . $jul_02['tot_jul_02'] . "</td>"; ?>
            <?php echo "<td>" . $jul_03['tot_jul_03'] . "</td>"; ?>
            <?php echo "<td>" . $jul_04['tot_jul_04'] . "</td>"; ?>
            <?php echo "<td>" . $jul_05['tot_jul_05'] . "</td>"; ?>
            <?php echo "<td>" . $jul_06['tot_jul_06'] . "</td>"; ?>
            <?php echo "<td>" . $jul_07['tot_jul_07'] . "</td>"; ?>
            <?php echo "<td>" . $jul_08['tot_jul_08'] . "</td>"; ?>
            <?php echo "<td>" . $jul_09['tot_jul_09'] . "</td>"; ?>
            <?php echo "<td>" . $jul_10['tot_jul_10'] . "</td>"; ?>
            <?php echo "<td>" . $jul_11['tot_jul_11'] . "</td>"; ?>
            <?php echo "<td>" . $jul_12['tot_jul_12'] . "</td>"; ?>
            <?php echo "<td>" . $jul_13['tot_jul_13'] . "</td>"; ?>
            <?php echo "<td>" . $jul_14['tot_jul_14'] . "</td>"; ?>
            <?php echo "<td>" . $jul_15['tot_jul_15'] . "</td>"; ?>
            <?php echo "<td>" . $jul_16['tot_jul_16'] . "</td>"; ?>
            <?php echo "<td>" . $jul_17['tot_jul_17'] . "</td>"; ?>
            <?php echo "<td>" . $jul_18['tot_jul_18'] . "</td>"; ?>
            <?php echo "<td>" . $jul_19['tot_jul_19'] . "</td>"; ?>
            <?php echo "<td>" . $jul_20['tot_jul_20'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Agt</th>
            <?php echo "<td>" . $agt_01['tot_agt_01'] . "</td>"; ?>
            <?php echo "<td>" . $agt_02['tot_agt_02'] . "</td>"; ?>
            <?php echo "<td>" . $agt_03['tot_agt_03'] . "</td>"; ?>
            <?php echo "<td>" . $agt_04['tot_agt_04'] . "</td>"; ?>
            <?php echo "<td>" . $agt_05['tot_agt_05'] . "</td>"; ?>
            <?php echo "<td>" . $agt_06['tot_agt_06'] . "</td>"; ?>
            <?php echo "<td>" . $agt_07['tot_agt_07'] . "</td>"; ?>
            <?php echo "<td>" . $agt_08['tot_agt_08'] . "</td>"; ?>
            <?php echo "<td>" . $agt_09['tot_agt_09'] . "</td>"; ?>
            <?php echo "<td>" . $agt_10['tot_agt_10'] . "</td>"; ?>
            <?php echo "<td>" . $agt_11['tot_agt_11'] . "</td>"; ?>
            <?php echo "<td>" . $agt_12['tot_agt_12'] . "</td>"; ?>
            <?php echo "<td>" . $agt_13['tot_agt_13'] . "</td>"; ?>
            <?php echo "<td>" . $agt_14['tot_agt_14'] . "</td>"; ?>
            <?php echo "<td>" . $agt_15['tot_agt_15'] . "</td>"; ?>
            <?php echo "<td>" . $agt_16['tot_agt_16'] . "</td>"; ?>
            <?php echo "<td>" . $agt_17['tot_agt_17'] . "</td>"; ?>
            <?php echo "<td>" . $agt_18['tot_agt_18'] . "</td>"; ?>
            <?php echo "<td>" . $agt_19['tot_agt_19'] . "</td>"; ?>
            <?php echo "<td>" . $agt_20['tot_agt_20'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Sep</th>
            <?php echo "<td>" . $sep_01['tot_sep_01'] . "</td>"; ?>
            <?php echo "<td>" . $sep_02['tot_sep_02'] . "</td>"; ?>
            <?php echo "<td>" . $sep_03['tot_sep_03'] . "</td>"; ?>
            <?php echo "<td>" . $sep_04['tot_sep_04'] . "</td>"; ?>
            <?php echo "<td>" . $sep_05['tot_sep_05'] . "</td>"; ?>
            <?php echo "<td>" . $sep_06['tot_sep_06'] . "</td>"; ?>
            <?php echo "<td>" . $sep_07['tot_sep_07'] . "</td>"; ?>
            <?php echo "<td>" . $sep_08['tot_sep_08'] . "</td>"; ?>
            <?php echo "<td>" . $sep_09['tot_sep_09'] . "</td>"; ?>
            <?php echo "<td>" . $sep_10['tot_sep_10'] . "</td>"; ?>
            <?php echo "<td>" . $sep_11['tot_sep_11'] . "</td>"; ?>
            <?php echo "<td>" . $sep_12['tot_sep_12'] . "</td>"; ?>
            <?php echo "<td>" . $sep_13['tot_sep_13'] . "</td>"; ?>
            <?php echo "<td>" . $sep_14['tot_sep_14'] . "</td>"; ?>
            <?php echo "<td>" . $sep_15['tot_sep_15'] . "</td>"; ?>
            <?php echo "<td>" . $sep_16['tot_sep_16'] . "</td>"; ?>
            <?php echo "<td>" . $sep_17['tot_sep_17'] . "</td>"; ?>
            <?php echo "<td>" . $sep_18['tot_sep_18'] . "</td>"; ?>
            <?php echo "<td>" . $sep_19['tot_sep_19'] . "</td>"; ?>
            <?php echo "<td>" . $sep_20['tot_sep_20'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Okt</th>
            <?php echo "<td>" . $okt_01['tot_okt_01'] . "</td>"; ?>
            <?php echo "<td>" . $okt_02['tot_okt_02'] . "</td>"; ?>
            <?php echo "<td>" . $okt_03['tot_okt_03'] . "</td>"; ?>
            <?php echo "<td>" . $okt_04['tot_okt_04'] . "</td>"; ?>
            <?php echo "<td>" . $okt_05['tot_okt_05'] . "</td>"; ?>
            <?php echo "<td>" . $okt_06['tot_okt_06'] . "</td>"; ?>
            <?php echo "<td>" . $okt_07['tot_okt_07'] . "</td>"; ?>
            <?php echo "<td>" . $okt_08['tot_okt_08'] . "</td>"; ?>
            <?php echo "<td>" . $okt_09['tot_okt_09'] . "</td>"; ?>
            <?php echo "<td>" . $okt_10['tot_okt_10'] . "</td>"; ?>
            <?php echo "<td>" . $okt_11['tot_okt_11'] . "</td>"; ?>
            <?php echo "<td>" . $okt_12['tot_okt_12'] . "</td>"; ?>
            <?php echo "<td>" . $okt_13['tot_okt_13'] . "</td>"; ?>
            <?php echo "<td>" . $okt_14['tot_okt_14'] . "</td>"; ?>
            <?php echo "<td>" . $okt_15['tot_okt_15'] . "</td>"; ?>
            <?php echo "<td>" . $okt_16['tot_okt_16'] . "</td>"; ?>
            <?php echo "<td>" . $okt_17['tot_okt_17'] . "</td>"; ?>
            <?php echo "<td>" . $okt_18['tot_okt_18'] . "</td>"; ?>
            <?php echo "<td>" . $okt_19['tot_okt_19'] . "</td>"; ?>
            <?php echo "<td>" . $okt_20['tot_okt_20'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Nov</th>
            <?php echo "<td>" . $nov_01['tot_nov_01'] . "</td>"; ?>
            <?php echo "<td>" . $nov_02['tot_nov_02'] . "</td>"; ?>
            <?php echo "<td>" . $nov_03['tot_nov_03'] . "</td>"; ?>
            <?php echo "<td>" . $nov_04['tot_nov_04'] . "</td>"; ?>
            <?php echo "<td>" . $nov_05['tot_nov_05'] . "</td>"; ?>
            <?php echo "<td>" . $nov_06['tot_nov_06'] . "</td>"; ?>
            <?php echo "<td>" . $nov_07['tot_nov_07'] . "</td>"; ?>
            <?php echo "<td>" . $nov_08['tot_nov_08'] . "</td>"; ?>
            <?php echo "<td>" . $nov_09['tot_nov_09'] . "</td>"; ?>
            <?php echo "<td>" . $nov_10['tot_nov_10'] . "</td>"; ?>
            <?php echo "<td>" . $nov_11['tot_nov_11'] . "</td>"; ?>
            <?php echo "<td>" . $nov_12['tot_nov_12'] . "</td>"; ?>
            <?php echo "<td>" . $nov_13['tot_nov_13'] . "</td>"; ?>
            <?php echo "<td>" . $nov_14['tot_nov_14'] . "</td>"; ?>
            <?php echo "<td>" . $nov_15['tot_nov_15'] . "</td>"; ?>
            <?php echo "<td>" . $nov_16['tot_nov_16'] . "</td>"; ?>
            <?php echo "<td>" . $nov_17['tot_nov_17'] . "</td>"; ?>
            <?php echo "<td>" . $nov_18['tot_nov_18'] . "</td>"; ?>
            <?php echo "<td>" . $nov_19['tot_nov_19'] . "</td>"; ?>
            <?php echo "<td>" . $nov_20['tot_nov_20'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Des</th>
            <?php echo "<td>" . $des_01['tot_des_01'] . "</td>"; ?>
            <?php echo "<td>" . $des_02['tot_des_02'] . "</td>"; ?>
            <?php echo "<td>" . $des_03['tot_des_03'] . "</td>"; ?>
            <?php echo "<td>" . $des_04['tot_des_04'] . "</td>"; ?>
            <?php echo "<td>" . $des_05['tot_des_05'] . "</td>"; ?>
            <?php echo "<td>" . $des_06['tot_des_06'] . "</td>"; ?>
            <?php echo "<td>" . $des_07['tot_des_07'] . "</td>"; ?>
            <?php echo "<td>" . $des_08['tot_des_08'] . "</td>"; ?>
            <?php echo "<td>" . $des_09['tot_des_09'] . "</td>"; ?>
            <?php echo "<td>" . $des_10['tot_des_10'] . "</td>"; ?>
            <?php echo "<td>" . $des_11['tot_des_11'] . "</td>"; ?>
            <?php echo "<td>" . $des_12['tot_des_12'] . "</td>"; ?>
            <?php echo "<td>" . $des_13['tot_des_13'] . "</td>"; ?>
            <?php echo "<td>" . $des_14['tot_des_14'] . "</td>"; ?>
            <?php echo "<td>" . $des_15['tot_des_15'] . "</td>"; ?>
            <?php echo "<td>" . $des_16['tot_des_16'] . "</td>"; ?>
            <?php echo "<td>" . $des_17['tot_des_17'] . "</td>"; ?>
            <?php echo "<td>" . $des_18['tot_des_18'] . "</td>"; ?>
            <?php echo "<td>" . $des_19['tot_des_19'] . "</td>"; ?>
            <?php echo "<td>" . $des_20['tot_des_20'] . "</td>"; ?>
        </tr>

    </tbody>
</table>