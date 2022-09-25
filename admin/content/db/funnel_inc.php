<script type="text/javascript">
    $(function() {
        Highcharts.chart('stat_fun_inc', {
            data: {
                table: 'tabel_income'
            },

            chart: {
                type: 'funnel3d',
                options3d: {
                    enabled: true,
                    alpha: 10,
                    depth: 50,
                    viewDistance: 50
                }
            },
            title: {
                text: 'Personal Income Funnel'
            },
            subtitle: {
                text: 'Anually'
            },
            exporting: {
                enabled: false
            },
            credits: {
                enabled: false
            },
            accessibility: {
                screenReaderSection: {
                    beforeChartFormat: '<{headingTagName}>{chartTitle}</{headingTagName}><div>{typeDescription}</div><div>{chartSubtitle}</div><div>{chartLongdesc}</div>'
                }
            },
            plotOptions: {
                series: {
                    dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b> ({point.y:,.0f})',
                        allowOverlap: true,
                        y: 10
                    },
                    neckWidth: '30%',
                    neckHeight: '25%',
                    width: '80%',
                    height: '80%'
                }
            },
            series: [{
                name: 'Unique users',
            }]
        });

    });
</script>

<?php
include "../../../library/config.php";
global $mysqli;

//Earned Income
$query = $mysqli->query("SELECT SUM(nilai) AS tot_earned FROM tbl_cashin WHERE kategori = 01 and YEAR(tgl) = YEAR(NOW())");
$earned = $query->fetch_assoc();

//Profit Income
$query = $mysqli->query("SELECT SUM(nilai) AS tot_profit FROM tbl_cashin WHERE kategori = 02 and YEAR(tgl) = YEAR(NOW())");
$profit = $query->fetch_assoc();

//Capital Gain
$query = $mysqli->query("SELECT SUM(nilai) AS tot_capital FROM tbl_cashin WHERE kategori = 03 and YEAR(tgl) = YEAR(NOW())");
$capital = $query->fetch_assoc();

//Dividend Income
$query = $mysqli->query("SELECT SUM(nilai) AS tot_dividend FROM tbl_cashin WHERE kategori = 04 and YEAR(tgl) = YEAR(NOW())");
$dividend = $query->fetch_assoc();

//Rental Income
$query = $mysqli->query("SELECT SUM(nilai) AS tot_rental FROM tbl_cashin WHERE kategori = 05 and YEAR(tgl) = YEAR(NOW())");
$rental = $query->fetch_assoc();

//Royalty Income
$query = $mysqli->query("SELECT SUM(nilai) AS tot_royalty FROM tbl_cashin WHERE kategori = 06 and YEAR(tgl) = YEAR(NOW())");
$royalty = $query->fetch_assoc();
?>

<div id="stat_fun_inc"></div>
<table class="table table-striped" id="tabel_income" style="display: none;">
    <thead>
        <tr>
            <th>Type of Income</th>
            <th>Rp</th>
        </tr>
    </thead>

    <tbody>
        <tr>
            <th>Earned Income</th>
            <?php echo "<td>" . $earned['tot_earned'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Profit Income</th>
            <?php echo "<td>" . $profit['tot_profit'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Capital Gain</th>
            <?php echo "<td>" . $capital['tot_capital'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Dividend Income</th>
            <?php echo "<td>" . $dividend['tot_dividend'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Rental Income</th>
            <?php echo "<td>" . $rental['tot_rental'] . "</td>"; ?>
        </tr>
        <tr>
            <th>Royalty Income</th>
            <?php echo "<td>" . $royalty['tot_royalty'] . "</td>"; ?>
        </tr>


    </tbody>
</table>