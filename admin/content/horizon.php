<script type="text/javascript">
    $(document).ready(function() {

        //HORIZON PER PART
        $("#dbAssetCat").html('<div class="loader"></div>').load("/cockpit/admin/content/db/asset_cat.php");
        $("#dbAssetVs").html('<div class="loader"></div>').load("/cockpit/admin/content/db/asset_vs.php");
        $("#dbExpBud").html('<div class="loader"></div>').load("/cockpit/admin/content/db/expbud.php");
        $("#dbFunnelInc").html('<div class="loader"></div>').load("/cockpit/admin/content/db/funnel_inc.php");
        $("#dbExpCat").html('<div class="loader"></div>').load("/cockpit/admin/content/db/exp_cat.php");

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
            <i class="pe-7s-' . $icon . '"></i>
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
          <i class="pe-7s-' . $icon . '"></i>
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
          <i class="pe-7s-' . $icon . '"></i>
            <span class="pull-right" style="font-size: 30px">' . easy_number($jml_data['tot_nilai']) . '</span>        
          </div>
          <div class="panel-body">' . $name . '</div>
        </div>
      </a></div>';
}

function buat_tombol_sum_inc($name, $icon, $link, $warna)
{
    global $mysqli;
    $query = $mysqli->query("SELECT SUM(nilai) AS tot_inc FROM tbl_cashin WHERE YEAR(tgl) = YEAR(NOW())");
    $jml_data = $query->fetch_assoc();
    echo '<div class="col-md-3 col-xs-12"><a href="' . $link . '">
        <div class="panel panel-' . $warna . ' dashboard-panel">
          <div class="panel-heading">
          <i class="pe-7s-' . $icon . '"></i>
            <span class="pull-right" style="font-size: 30px">' . easy_number($jml_data['tot_inc']) . '</span>        
          </div>
          <div class="panel-body">' . $name . '</div>
        </div>
      </a></div>';
}

function buat_tombol_sum_exp($name, $icon, $link, $warna)
{
    global $mysqli;
    $query = $mysqli->query("SELECT SUM(nilai) AS tot_exp FROM tbl_cashout WHERE YEAR(tgl) = YEAR(NOW())");
    $jml_data = $query->fetch_assoc();
    echo '<div class="col-md-3 col-xs-12"><a href="' . $link . '">
        <div class="panel panel-' . $warna . ' dashboard-panel">
          <div class="panel-heading">
          <i class="pe-7s-' . $icon . '"></i>
            <span class="pull-right" style="font-size: 30px">' . easy_number($jml_data['tot_exp']) . '</span>        
          </div>
          <div class="panel-body">' . $name . '</div>
        </div>
      </a></div>';
}

function buat_tombol_avg_exp($name, $icon, $link, $warna)
{
    global $mysqli;
    $query = $mysqli->query("SELECT AVG(nilai) AS avg_exp FROM tbl_cashout WHERE YEAR(tgl) = YEAR(NOW())");
    $jml_data = $query->fetch_assoc();
    echo '<div class="col-md-3 col-xs-12"><a href="' . $link . '">
        <div class="panel panel-' . $warna . ' dashboard-panel">
          <div class="panel-heading">
          <i class="pe-7s-' . $icon . '"></i>
            <span class="pull-right" style="font-size: 30px">' . easy_number($jml_data['avg_exp']) . '</span>        
          </div>
          <div class="panel-body">' . $name . '</div>
        </div>
      </a></div>';
}
?>

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
        buat_tombol_nw("total net worth (idr)", "cash", "?content=horizon", "primary");
        buat_tombol_as("total assets (idr)", "wallet", "?content=asset", "success");
        buat_tombol_db("total debts (idr)", "credit", "?content=debt", "danger");
        ?>
    </div>
</div>

<div class="col-md-6">
    <div class="card">
        <div id="dbAssetCat"></div>
    </div>
</div>

<div class="col-md-6">
    <div class="card">
        <div id="dbAssetVs"></div>
    </div>
</div>

<div class="col-md-6">
    <div class="card">
        <div id="dbExpBud"></div>
    </div>
</div>

<div class="col-md-6">
    <div class="card">
        <div id="dbFunnelInc"></div>
    </div>
</div>

<div class="col-md-9">
    <div class="card">
        <div id="dbExpCat"></div>
    </div>
</div>

<div>
    <?php
    buat_tombol_sum_inc("sum income anually (idr)", "graph1", "?content=cashin", "success");
    buat_tombol_sum_exp("sum expenses anually (idr)", "cart", "?content=cashout", "danger");
    buat_tombol_avg_exp("avg expenses monthly (idr)", "graph", "?content=cashout", "warning");
    ?>
</div>

<div class="col-md-12">
    <h3 class="page-header"><b>Road to Jannah</b>
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
</div>