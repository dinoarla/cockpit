<?php
function buka_tabel($judul)
{
	echo '<div class="table-responsive">
		<table class="table-data table table-striped" width="100%">
		<thead>
			<tr>
				<th style="width: 10px">No</th>';
	foreach ($judul as $jdl) {
		echo '<th>' . $jdl . '</th>';
	}

	echo '		<th style="width: 60px">Aksi</th>
			</tr>
		</thead>
		<tbody>';
}

function buka_tabel_k3l($judul)
{
	echo '<div class="table-responsive">
		<table class="table-data table table-striped" width="100%">
		<thead>
			<tr>
				<th style="width: 10px">No</th>';
	foreach ($judul as $jdl) {
		echo '<th>' . $jdl . '</th>';
	}

	echo '		<th>1</th>
				<th>2</th>
				<th>3</th>
				<th>4</th>
				<th>5</th>
				<th>6</th>
				<th style="width: 60px">Aksi</th>
			</tr>
		</thead>
		<tbody>';
}

function buka_tabel_ophar($judul)
{
	echo '<div class="table-responsive">
		<table class="table-data table table-striped" width="100%">
		<thead>
			<tr>
				<th style="width: 10px">No</th>';
	foreach ($judul as $jdl) {
		echo '<th>' . $jdl . '</th>';
	}

	echo '		<th>1</th>
				<th>2</th>
				<th>3</th>
				<th style="width: 60px">Aksi</th>
			</tr>
		</thead>
		<tbody>';
}

function isi_tabel($no, $data, $link, $id, $edit = true, $hapus = true)
{
	echo '<tr>
			<td valign="top">' . $no . '</td>';
	foreach ($data as $dt) {
		echo '<td valign="top">' . $dt . '</td>';
	}
	echo '<td valign="top">';
	if ($edit) {
		echo '<a href="' . $link . '&show=form&id=' . $id . '" class="btn btn-primary btn-sm" title="Detail Data">
				<i class="glyphicon glyphicon-search"></i>
			</a> ';
	}
	if ($hapus) {
		echo '<a href="' . $link . '&show=delete&id=' . $id . '" class="btn btn-danger btn-sm" title="Delete Data">
				<i class="glyphicon glyphicon-trash"></i>
			</a>';
	}
	echo '</td>
		</tr>';
}

function isi_tabel_coc($no, $data, $link, $id, $pdf, $edit = true, $hapus = true, $evidence = true)
{
	echo '<tr>
			<td valign="top">' . $no . '</td>';
	foreach ($data as $dt) {
		echo '<td valign="top">' . $dt . '</td>';
	}
	echo '<td valign="top">';
	if ($evidence) {
		echo '<a href="upload/' . $pdf . '" class="btn btn-success btn-sm" title="Evidence COC">
				<i class="glyphicon glyphicon-file"></i>
			</a> ';
	}
	if ($edit) {
		echo '<a href="' . $link . '&show=form&id=' . $id . '" class="btn btn-primary btn-sm" title="Detail COC">
				<i class="glyphicon glyphicon-search" ></i>
			</a> ';
	}
	if ($hapus) {
		echo '<a href="' . $link . '&show=delete&id=' . $id . '" class="btn btn-danger btn-sm" title="Delete COC">
				<i class="glyphicon glyphicon-trash" ></i>
			</a>';
	}
	echo '</td>
		</tr>';
}



function isi_tabel_diklat($no, $data, $link, $pdf_evidence, $pdf_sertifikat, $id, $edit = true, $hapus = true, $evidence = true, $sertifikat = true)
{
	echo '<tr>
			<td valign="top">' . $no . '</td>';
	foreach ($data as $dt) {
		echo '<td valign="top">' . $dt . '</td>';
	}
	echo '<td valign="top">';
	if ($evidence) {
		echo '<a href="upload/diklat/evidence/' . $pdf_evidence . '.pdf" class="btn btn-success btn-sm" title="Evidence Diklat">
				<i class="glyphicon glyphicon-file"></i>
			</a> ';
	}
	if ($sertifikat) {
		echo '<a href="upload/diklat/sertifikat/' . $pdf_sertifikat . '.pdf" class="btn btn-success btn-sm" title="Sertifikat Diklat">
				<i class="glyphicon glyphicon-file"></i>
			</a> ';
	}
	if ($edit) {
		echo '<a href="' . $link . '&show=form&id=' . $id . '" class="btn btn-primary btn-sm" title="Detail Diklat">
				<i class="glyphicon glyphicon-search" ></i>
			</a> ';
	}
	if ($hapus) {
		echo '<a href="' . $link . '&show=delete&id=' . $id . '" class="btn btn-danger btn-sm" title="Delete Diklat">
				<i class="glyphicon glyphicon-trash" ></i>
			</a>';
	}
	echo '</td>
		</tr>';
}

function isi_tabel_ks($no, $data, $link, $pdf_absensi, $pdf_materi, $id, $edit = true, $hapus = true, $absensi = true, $materi = true)
{
	echo '<tr>
			<td valign="top">' . $no . '</td>';
	foreach ($data as $dt) {
		echo '<td valign="top">' . $dt . '</td>';
	}
	echo '<td valign="top">';
	if ($absensi) {
		echo '<a href="upload/ks/absensi/' . $pdf_absensi . '" class="btn btn-success btn-sm" title="Absensi">
				<i class="glyphicon glyphicon-file"></i>
			</a> ';
	}
	if ($materi) {
		echo '<a href="upload/ks/materi/' . $pdf_materi . '" class="btn btn-success btn-sm" title="Materi">
				<i class="glyphicon glyphicon-file"></i>
			</a> ';
	}
	if ($edit) {
		echo '<a href="' . $link . '&show=form&id=' . $id . '" class="btn btn-primary btn-sm" title="Detail Diklat">
				<i class="glyphicon glyphicon-search" ></i>
			</a> ';
	}
	if ($hapus) {
		echo '<a href="' . $link . '&show=delete&id=' . $id . '" class="btn btn-danger btn-sm" title="Delete Diklat">
				<i class="glyphicon glyphicon-trash" ></i>
			</a>';
	}
	echo '</td>
		</tr>';
}

function isi_tabel_cop($no, $data, $link, $pdf_absensi, $pdf_form, $id, $edit = true, $hapus = true, $absensi = true, $form = true)
{
	echo '<tr>
			<td valign="top">' . $no . '</td>';
	foreach ($data as $dt) {
		echo '<td valign="top">' . $dt . '</td>';
	}
	echo '<td valign="top">';
	if ($absensi) {
		echo '<a href="upload/cop/absensi/' . $pdf_absensi . '" class="btn btn-success btn-sm" title="Absensi">
				<i class="glyphicon glyphicon-file"></i>
			</a> ';
	}
	if ($form) {
		echo '<a href="upload/cop/form/' . $pdf_form . '" class="btn btn-success btn-sm" title="Form COP">
				<i class="glyphicon glyphicon-file"></i>
			</a> ';
	}
	if ($edit) {
		echo '<a href="' . $link . '&show=form&id=' . $id . '" class="btn btn-primary btn-sm" title="Detail Diklat">
				<i class="glyphicon glyphicon-search" ></i>
			</a> ';
	}
	if ($hapus) {
		echo '<a href="' . $link . '&show=delete&id=' . $id . '" class="btn btn-danger btn-sm" title="Delete Diklat">
				<i class="glyphicon glyphicon-trash" ></i>
			</a>';
	}
	echo '</td>
		</tr>';
}

function isi_tabel_inovasi($no, $data, $link, $pdf_makalah, $id, $edit = true, $hapus = true, $makalah = true)
{
	echo '<tr>
			<td valign="top">' . $no . '</td>';
	foreach ($data as $dt) {
		echo '<td valign="top">' . $dt . '</td>';
	}
	echo '<td valign="top">';
	if ($makalah) {
		echo '<a href="upload/inovasi/' . $pdf_makalah . '" class="btn btn-success btn-sm" title="Makalah Inovasi">
				<i class="glyphicon glyphicon-file"></i>
			</a> ';
	}
	if ($edit) {
		echo '<a href="' . $link . '&show=form&id=' . $id . '" class="btn btn-primary btn-sm" title="Detail Diklat">
				<i class="glyphicon glyphicon-search" ></i>
			</a> ';
	}
	if ($hapus) {
		echo '<a href="' . $link . '&show=delete&id=' . $id . '" class="btn btn-danger btn-sm" title="Delete Diklat">
				<i class="glyphicon glyphicon-trash" ></i>
			</a>';
	}
	echo '</td>
		</tr>';
}

function isi_tabel_k3l($no, $data, $link, $doc_lap_debit_air, $doc_lap_neraca_lb, $doc_lap_bbm, $doc_lap_kwh, $doc_lap_cems, $doc_lap_kerja_cems, $id, $edit = true, $hapus = true)
{
	echo '<tr>
			<td valign="top">' . $no . '</td>';
	foreach ($data as $dt) {
		echo '<td valign="top">' . $dt . '</td>';
	}

	if ($doc_lap_debit_air == null) {
		echo '<td><a class="btn btn-danger btn-sm disabled">
				<i class="glyphicon glyphicon-remove" ></i>
			</a></td>';
	} else {
		echo '<td><a href="upload/k3l/' . $doc_lap_debit_air . '" class="btn btn-success btn-sm" title="Laporan Debit Air Limbah">
				<i class="glyphicon glyphicon-file"></i>
			</a></td>';
	}

	if ($doc_lap_neraca_lb == null) {
		echo '<td><a class="btn btn-danger btn-sm disabled">
				<i class="glyphicon glyphicon-remove" ></i>
			</a></td>';
	} else {
		echo '<td><a href="upload/k3l/' . $doc_lap_neraca_lb . '" class="btn btn-success btn-sm" title="Laporan Neraca LB3">
				<i class="glyphicon glyphicon-file"></i>
			</a></td> ';
	}
	if ($doc_lap_bbm == null) {
		echo '<td><a class="btn btn-danger btn-sm disabled">
				<i class="glyphicon glyphicon-remove" ></i>
			</a></td>';
	} else {
		echo '<td><a href="upload/k3l/' . $doc_lap_bbm . '" class="btn btn-success btn-sm" title="Data Pemakaian BBM dan Jam Kerja Boiler Per Hari">
				<i class="glyphicon glyphicon-file"></i>
			</a></td> ';
	}
	if ($doc_lap_kwh == null) {
		echo '<td><a class="btn btn-danger btn-sm disabled">
				<i class="glyphicon glyphicon-remove" ></i>
			</a></td>';
	} else {
		echo '<td><a href="upload/k3l/' . $doc_lap_kwh . '" class="btn btn-success btn-sm" title="Data Produksi kWh, Jam Kerja dan Pemakaian BBM Per Hari">
				<i class="glyphicon glyphicon-file"></i>
			</a></td> ';
	}
	if ($doc_lap_cems == null) {
		echo '<td><a class="btn btn-danger btn-sm disabled">
				<i class="glyphicon glyphicon-remove" ></i>
			</a></td>';
	} else {
		echo '<td><a href="upload/k3l/' . $doc_lap_cems . '" class="btn btn-success btn-sm" title="Data CEMS Perjam / Hari">
				<i class="glyphicon glyphicon-file"></i>
			</a></td> ';
	}
	if ($doc_lap_kerja_cems == null) {
		echo '<td><a class="btn btn-danger btn-sm disabled">
				<i class="glyphicon glyphicon-remove" ></i>
			</a></td>';
	} else {
		echo '<td><a href="upload/k3l/' . $doc_lap_kerja_cems . '" class="btn btn-success btn-sm" title="Data Kerja Alat CEMS / Hari">
				<i class="glyphicon glyphicon-file"></i>
			</a></td> ';
	}

	echo '<td valign="top">';
	if ($edit) {
		echo '<a href="' . $link . '&show=form&id=' . $id . '" class="btn btn-primary btn-sm" title="Detail Data">
				<i class="glyphicon glyphicon-search" ></i>
			</a> ';
	}
	if ($hapus) {
		echo '<a href="' . $link . '&show=delete&id=' . $id . '" class="btn btn-danger btn-sm" title="Delete Data">
				<i class="glyphicon glyphicon-trash" ></i>
			</a>';
	}
	echo '</td>
		</tr>';
}

function isi_tabel_ophar($no, $data, $link, $doc_lap_pengusahaan, $doc_lap_gangguan, $doc_lap_manajemen, $id, $edit = true, $hapus = true, $lap_pengusahaan = true, $lap_gangguan = true, $lap_manajemen = true)
{
	echo '<tr>
			<td valign="top">' . $no . '</td>';
	foreach ($data as $dt) {
		echo '<td valign="top">' . $dt . '</td>';
	}

	if ($doc_lap_pengusahaan == null) {
		echo '<td><a class="btn btn-danger btn-sm disabled">
				<i class="glyphicon glyphicon-remove" ></i>
			</a></td>';
	} else {
		echo '<td><a href="upload/ophar/' . $doc_lap_pengusahaan . '" class="btn btn-success btn-sm" title="Laporan Pengusahaan">
				<i class="glyphicon glyphicon-file"></i>
			</td></a> ';
	}
	if ($doc_lap_gangguan == null) {
		echo '<td><a class="btn btn-danger btn-sm disabled">
				<i class="glyphicon glyphicon-remove" ></i>
			</a></td>';
	} else {
		echo '<td><a href="upload/ophar/' . $doc_lap_gangguan . '" class="btn btn-success btn-sm" title="Laporan Gangguan Pembangkit">
				<i class="glyphicon glyphicon-file"></i>
			</td></a> ';
	}
	if ($doc_lap_manajemen == null) {
		echo '<td><a class="btn btn-danger btn-sm disabled">
				<i class="glyphicon glyphicon-remove" ></i>
			</a></td>';
	} else {
		echo '<td><a href="upload/ophar/' . $doc_lap_manajemen . '" class="btn btn-success btn-sm" title="Laporan Manajemen">
				<i class="glyphicon glyphicon-file"></i>
			</td></a> ';
	}

	echo '<td valign="top">';
	if ($edit) {
		echo '<a href="' . $link . '&show=form&id=' . $id . '" class="btn btn-primary btn-sm" title="Detail Data">
				<i class="glyphicon glyphicon-search" ></i>
			</a> ';
	}
	if ($hapus) {
		echo '<a href="' . $link . '&show=delete&id=' . $id . '" class="btn btn-danger btn-sm" title="Delete Data">
				<i class="glyphicon glyphicon-trash" ></i>
			</a>';
	}
	echo '</td>
		</tr>';
}

function tutup_tabel()
{
	echo '		</tbody>	
			</table>
		</div>';
}
