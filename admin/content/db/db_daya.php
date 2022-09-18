<script type="text/javascript">
    $(function() {
        Highcharts.chart('stat', {
            data: {
                table: 'tabel_stat'
            },
            chart: {
                type: 'column'
            },
            title: {
                text: 'Monitoring Daya Potensi vs Daya Realisasi (VA)'
            },
            subtitle: {
                text: 'Usaha Penggilingan Padi'
            },
            yAxis: {
                allowDecimals: false,
                title: {
                    text: 'Jumlah (VA)'
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
                        this.point.y + ' VA ';
                }
            }
        });
    });
</script>



<?php
include "../../library/config.php";
global $mysqli;





?>


<br>
<div id="stat"></div>
<table class="table table-striped" id="tabel_stat" style="display: none;">
    <thead>
        <tr>
            <th>Unit</th>
            <th>Daya Potensi (VA)</th>
            <th>Daya Realisasi (VA)</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <th>Potensi Daya Yang Akan Masuk</th>
            <td>33000</td>
        </tr>
        <tr>
            <th>Daya Yang Sudah Jadi Pelanggan</th>
            <td>55000</td>
        </tr>
    </tbody>
</table>