<script type="text/javascript">
    $(function() {

        Highcharts.setOptions({
            colors: ['#DDDF00', '#24CBE5']
        });

        Highcharts.chart('stat_exp_bud', {
            data: {
                table: 'tabel_stat_exp_bud'
            },
            chart: {
                type: 'column'
            },
            title: {
                text: 'Budget vs Expenses'
            },
            subtitle: {
                text: 'Anually'
            },
            yAxis: [{
                allowDecimals: false,
                title: {
                    text: 'Expenses (Rp)'
                }
            }, {
                allowDecimals: false,
                title: {
                    text: 'Budget (Rp)'
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

//BUDGET
$query = $mysqli->query("SELECT SUM(nilai) AS tot_bud_jan FROM tbl_budget WHERE MONTH(tgl) = 01 and YEAR(tgl) = YEAR(NOW())");
$bud_jan = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_bud_feb FROM tbl_budget WHERE MONTH(tgl) = 02 and YEAR(tgl) = YEAR(NOW())");
$bud_feb = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_bud_mar FROM tbl_budget WHERE MONTH(tgl) = 03 and YEAR(tgl) = YEAR(NOW())");
$bud_mar = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_bud_apr FROM tbl_budget WHERE MONTH(tgl) = 04 and YEAR(tgl) = YEAR(NOW())");
$bud_apr = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_bud_mei FROM tbl_budget WHERE MONTH(tgl) = 05 and YEAR(tgl) = YEAR(NOW())");
$bud_mei = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_bud_jun FROM tbl_budget WHERE MONTH(tgl) = 06 and YEAR(tgl) = YEAR(NOW())");
$bud_jun = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_bud_jul FROM tbl_budget WHERE MONTH(tgl) = 07 and YEAR(tgl) = YEAR(NOW())");
$bud_jul = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_bud_agt FROM tbl_budget WHERE MONTH(tgl) = 08 and YEAR(tgl) = YEAR(NOW())");
$bud_agt = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_bud_sep FROM tbl_budget WHERE MONTH(tgl) = 09 and YEAR(tgl) = YEAR(NOW())");
$bud_sep = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_bud_okt FROM tbl_budget WHERE MONTH(tgl) = 10 and YEAR(tgl) = YEAR(NOW())");
$bud_okt = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_bud_nov FROM tbl_budget WHERE MONTH(tgl) = 11 and YEAR(tgl) = YEAR(NOW())");
$bud_nov = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_bud_des FROM tbl_budget WHERE MONTH(tgl) = 12 and YEAR(tgl) = YEAR(NOW())");
$bud_des = $query->fetch_assoc();

//EXPENSES
$query = $mysqli->query("SELECT SUM(nilai) AS tot_exp_jan FROM tbl_cashout WHERE MONTH(tgl) = 01 and YEAR(tgl) = YEAR(NOW())");
$exp_jan = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_exp_feb FROM tbl_cashout WHERE MONTH(tgl) = 02 and YEAR(tgl) = YEAR(NOW())");
$exp_feb = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_exp_mar FROM tbl_cashout WHERE MONTH(tgl) = 03 and YEAR(tgl) = YEAR(NOW())");
$exp_mar = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_exp_apr FROM tbl_cashout WHERE MONTH(tgl) = 04 and YEAR(tgl) = YEAR(NOW())");
$exp_apr = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_exp_mei FROM tbl_cashout WHERE MONTH(tgl) = 05 and YEAR(tgl) = YEAR(NOW())");
$exp_mei = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_exp_jun FROM tbl_cashout WHERE MONTH(tgl) = 06 and YEAR(tgl) = YEAR(NOW())");
$exp_jun = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_exp_jul FROM tbl_cashout WHERE MONTH(tgl) = 07 and YEAR(tgl) = YEAR(NOW())");
$exp_jul = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_exp_agt FROM tbl_cashout WHERE MONTH(tgl) = 08 and YEAR(tgl) = YEAR(NOW())");
$exp_agt = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_exp_sep FROM tbl_cashout WHERE MONTH(tgl) = 09 and YEAR(tgl) = YEAR(NOW())");
$exp_sep = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_exp_okt FROM tbl_cashout WHERE MONTH(tgl) = 10 and YEAR(tgl) = YEAR(NOW())");
$exp_okt = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_exp_nov FROM tbl_cashout WHERE MONTH(tgl) = 11 and YEAR(tgl) = YEAR(NOW())");
$exp_nov = $query->fetch_assoc();

$query = $mysqli->query("SELECT SUM(nilai) AS tot_exp_des FROM tbl_cashout WHERE MONTH(tgl) = 12 and YEAR(tgl) = YEAR(NOW())");
$exp_des = $query->fetch_assoc();


?>

<div id="stat_exp_bud"></div>
<table class="table table-striped" id="tabel_stat_exp_bud" style="display: none;">
    <thead>
        <tr>
            <th>Bulan</th>
            <th>Budget</th>
            <th>Expenses (Actual)</th>
        </tr>
    </thead>

    <tbody>
        <tr>
            <th>Jan</th>
            <?php echo "<td>" . $bud_jan['tot_bud_jan'] . "</td>"; ?>
            <?php echo "<td>" . $exp_jan['tot_exp_jan'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Feb</th>
            <?php echo "<td>" . $bud_feb['tot_bud_feb'] . "</td>"; ?>
            <?php echo "<td>" . $exp_feb['tot_exp_feb'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Mar</th>
            <?php echo "<td>" . $bud_mar['tot_bud_mar'] . "</td>"; ?>
            <?php echo "<td>" . $exp_mar['tot_exp_mar'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Apr</th>
            <?php echo "<td>" . $bud_apr['tot_bud_apr'] . "</td>"; ?>
            <?php echo "<td>" . $exp_apr['tot_exp_apr'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Mei</th>
            <?php echo "<td>" . $bud_mei['tot_bud_mei'] . "</td>"; ?>
            <?php echo "<td>" . $exp_mei['tot_exp_mei'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Jun</th>
            <?php echo "<td>" . $bud_jun['tot_bud_jun'] . "</td>"; ?>
            <?php echo "<td>" . $exp_jun['tot_exp_jun'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Jul</th>
            <?php echo "<td>" . $bud_jul['tot_bud_jul'] . "</td>"; ?>
            <?php echo "<td>" . $exp_jul['tot_exp_jul'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Agt</th>
            <?php echo "<td>" . $bud_agt['tot_bud_agt'] . "</td>"; ?>
            <?php echo "<td>" . $exp_agt['tot_exp_agt'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Sep</th>
            <?php echo "<td>" . $bud_sep['tot_bud_sep'] . "</td>"; ?>
            <?php echo "<td>" . $exp_sep['tot_exp_sep'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Okt</th>
            <?php echo "<td>" . $bud_okt['tot_bud_okt'] . "</td>"; ?>
            <?php echo "<td>" . $exp_okt['tot_exp_okt'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Nov</th>
            <?php echo "<td>" . $bud_nov['tot_bud_nov'] . "</td>"; ?>
            <?php echo "<td>" . $exp_nov['tot_exp_nov'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Des</th>
            <?php echo "<td>" . $bud_des['tot_bud_des'] . "</td>"; ?>
            <?php echo "<td>" . $exp_des['tot_exp_des'] . "</td>"; ?>
        </tr>

    </tbody>
</table>