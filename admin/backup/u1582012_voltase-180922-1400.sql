-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 18, 2022 at 12:40 PM
-- Server version: 10.5.16-MariaDB-cll-lve
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u1582012_voltase`
--

-- --------------------------------------------------------

--
-- Table structure for table `setting`
--

CREATE TABLE `setting` (
  `id_setting` int(5) NOT NULL,
  `parameter` varchar(50) COLLATE latin1_general_ci NOT NULL,
  `nilai` text COLLATE latin1_general_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `setting`
--

INSERT INTO `setting` (`id_setting`, `parameter`, `nilai`) VALUES
(1, 'judul', 'SOLIPAD'),
(2, 'deskripsi', 'Solusi Tuntas Usaha Penggilingan Padi'),
(3, 'url', 'http://localhost/solipad'),
(4, 'ikon', '13.png'),
(5, 'keyword', 'pln, solipad'),
(6, 'folder', '/solipad'),
(7, 'homepage', '0');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_entry`
--

CREATE TABLE `tbl_entry` (
  `id_entry` int(11) NOT NULL,
  `pny` varchar(10) NOT NULL,
  `tiang` varchar(15) NOT NULL,
  `alamat` text NOT NULL,
  `lat` text NOT NULL,
  `lng` text NOT NULL,
  `jenis_bahaya` varchar(20) NOT NULL,
  `potensi_bahaya` text NOT NULL,
  `foto` text NOT NULL,
  `preventif` text NOT NULL,
  `sudah_dilanjut` enum('1','2') NOT NULL,
  `kategori` enum('1','2','3','0') NOT NULL,
  `ulp` varchar(10) NOT NULL,
  `ket` text NOT NULL,
  `tgl_entry` datetime NOT NULL,
  `tgl_edit` datetime NOT NULL,
  `tgl_pelaksanaan` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_entry`
--

INSERT INTO `tbl_entry` (`id_entry`, `pny`, `tiang`, `alamat`, `lat`, `lng`, `jenis_bahaya`, `potensi_bahaya`, `foto`, `preventif`, `sudah_dilanjut`, `kategori`, `ulp`, `ket`, `tgl_entry`, `tgl_edit`, `tgl_pelaksanaan`) VALUES
(1, 'JNGA', '82', 'JL.RAYA TERISI - CIKAMURANG KEC.TERISI, INDRAMAYU JABAR 45262', '-6.2838', '108.925', 'Bangunan', 'BANGUNAN DEKAT DENGAN SUTM', 'ULP CIKEDUNG/PNY JNGA/WhatsApp Image 2022-05-19 at 14.17.18.jpeg', 'SUDAH DILAKSANAKAN SOSIALISASI BAHAYA LISTRIK', '1', '1', 'CIKEDUNG', 'AKTITAS PEMBANGUNAN  SUDAH SELESAI', '2022-07-25 09:38:37', '0000-00-00 00:00:00', '2022-05-19'),
(2, 'BONGAS ', 'BONGAS 75', 'Wanguk, Kec. Anjatan, Kabupaten Indramayu, Jawa Barat 45264', '-6.419056', '107.972972', 'Bangunan', 'BANGUNAN DEKAT DENGAN SUTM', 'ULP HAURGEULIS/P BONGAS/BNGS 75.jpg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'AKTITAS PEMBANGUNAN  SUDAH SELESAI', '2022-07-25 10:02:52', '2022-07-25 10:29:23', '0000-00-00'),
(3, 'BONGAS ', 'BONGAS 85', 'Sidodadi, Kec. Haurgeulis, Kabupaten Indramayu, Jawa Barat', '-6.419389', '107.976472', 'Bangunan', 'BANGUNAN DEKAT DENGAN SUTM', 'ULP HAURGEULIS/P BONGAS/BNGS 85.jpg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'AKTITAS PEMBANGUNAN  SUDAH SELESAI', '2022-07-26 12:35:27', '0000-00-00 00:00:00', '0000-00-00'),
(4, 'GANTAR', 'GANTAR 167', 'Haur Geulis Gantar 13, Gantar, Kec. Gantar, Kabupaten Indramayu, Jawa Barat 45264 ', '-6.514611', '107.973000', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P GANTAR/GNTR 167 (2).jpg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'AKTITAS PEMBANGUNAN  SUDAH SELESAI', '2022-07-26 12:44:44', '0000-00-00 00:00:00', '0000-00-00'),
(5, 'BUGIS ', 'BUGIS 145', 'Kopyah Salam Darma, Bugis, Kec. Anjatan, Kabupaten Indramayu, Jawa Barat 45256', '-6.389417', '107.931056', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P BUGIS/BUGIS 145 (2).jpg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'AKTITAS PEMBANGUNAN  SUDAH SELESAI', '2022-07-26 12:45:56', '0000-00-00 00:00:00', '0000-00-00'),
(6, 'BUGIS ', 'BUGIS 178', 'Kopyah Salam Darma, Bugis, Kec. Anjatan, Kabupaten Indramayu, Jawa Barat 45256', '-6.389778', '107.930444', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P BUGIS/BUGIS 178 (2).jpg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'AKTITAS PEMBANGUNAN  SUDAH SELESAI', '2022-07-26 12:49:00', '0000-00-00 00:00:00', '0000-00-00'),
(7, 'PATROL', 'PATROL 54', 'Jl. Haurgeulis - Patrol, Cipancuh, Kec. Haurgeulis, Kabupaten Indramayu, Jawa Barat 45264', '-6.412722', '107.959639', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P PATROL/PTRL54 (2).jpg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'AKTITAS PEMBANGUNAN  SUDAH SELESAI', '2022-07-26 12:51:37', '0000-00-00 00:00:00', '0000-00-00'),
(8, 'BONGAS ', 'BONGAS 83', 'Sidodadi, Kec. Haurgeulis, Kabupaten Indramayu, Jawa Barat', '-6.419361', '107.975889', 'Bangunan', 'PEMASANGAN BAJA RINGAN DEKAT SUTM', 'ULP HAURGEULIS/P BONGAS/BONGAS 83.jpg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'KORBAN TERSENGAT LISTRIK KONDISI LUKA MEMAR TANGAN', '2022-07-26 12:54:33', '2022-07-26 13:08:13', '0000-00-00'),
(9, 'BUGIS ', 'BUGIS 93L16 ', 'Kopyah Salam Darma, Bugis, Kec. Anjatan, Kabupaten Indramayu, Jawa Barat 45256', '', '', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P BUGIS/BUGIS 93L16 (2).jpg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'AKTITAS PEMBANGUNAN  SUDAH SELESAI', '2022-07-26 13:07:24', '0000-00-00 00:00:00', '0000-00-00'),
(10, 'PATROL', 'PATROL 95', 'Jl. Haurgeulis - Patrol, Kedungwungu, Kec. Anjatan, Kabupaten Indramayu, Jawa Barat 45256', '-6.405694', '107.964083', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P PATROL/PATROL 95.jpg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'AKTITAS PEMBANGUNAN  SUDAH SELESAI', '2022-07-26 13:21:40', '0000-00-00 00:00:00', '0000-00-00'),
(11, 'PATROL', 'PATROL 109', 'Jl. Haurgeulis - Patrol, Cipancuh, Kec. Haurgeulis, Kabupaten Indramayu, Jawa Barat 45264', '-6.402417', '107.964583', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P PATROL/PATROL 109.jpg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'AKTITAS PEMBANGUNAN  SUDAH SELESAI', '2022-07-26 13:22:42', '0000-00-00 00:00:00', '0000-00-00'),
(12, 'CHJF', '284L21', 'Cempeh Kec.Lohbener', '-6.2438', '108.1339132', 'Bangunan', 'Pembangunan dekat SUTM', 'ULP INDRAMAYU KOTA/P CHJF/CHJF 284L21.png', 'Sosialisasi / Himbauan Bahaya listrik bagi pemilik bangunan dan tukang bangunan', '1', '1', 'INDRAMAYU', 'Proses pembangunan masih berlangsung', '2022-07-26 14:30:19', '0000-00-00 00:00:00', '2022-07-13'),
(13, 'BALERAJA', 'BALERAJA 50', 'Jl. Ahmad Yani, Haurgeulis, Kec. Haurgeulis, Kabupaten Indramayu, Jawa Barat 45264', '-6.458889', '107.940333', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P BALERAJA/BALERAJA 50.jpg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'AKTITAS PEMBANGUNAN  SUDAH SELESAI', '2022-07-26 14:31:18', '0000-00-00 00:00:00', '0000-00-00'),
(14, 'BALERAJA', 'BALERAJA 57R40', 'Jl. Cipunagara - Haurgeulis, Kertanegara, Kec. Haurgeulis, Kabupaten Indramayu, Jawa Barat 45264', '-6.457750', '107.922750', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P BALERAJA/BALERAJA  57R40.jpg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'AKTITAS PEMBANGUNAN  SUDAH SELESAI', '2022-07-26 14:33:53', '0000-00-00 00:00:00', '0000-00-00'),
(15, 'BONGAS ', 'BONGAS 110L45', 'Drunten Wetan-Kedung Dawa, Kedungdawa, Kec. Gabuswetan, Kabupaten Indramayu, Jawa Barat 45263', '-6.434083', '108.034444', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P BONGAS/BONGAS 110L45.jpg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'AKTITAS PEMBANGUNAN  SUDAH SELESAI', '2022-07-26 14:36:11', '0000-00-00 00:00:00', '0000-00-00'),
(16, 'ERTN', '8', 'Ds Karanganyar Indramayu', '-6.2036', '108.2035282', 'Lain-Lain', 'Pekerjaan menggunakan alat berat dekat SUTM', 'ULP INDRAMAYU KOTA/P ERTN/ERTN 8.png', 'Sosialisasi / Himbauan Bahaya listrik bagi pengawas pekerjaan di lokasi', '1', '2', 'INDRAMAYU', 'Proses pekerjaan dengan alat berat masih berlangsung', '2022-07-28 15:33:09', '0000-00-00 00:00:00', '2022-07-27'),
(17, 'PMDA', '49', 'Jl. Jend. Sudirman No. 152', '-6.207', '108.202271', 'Bangunan', 'Pembangunan dekat SUTM', 'ULP INDRAMAYU KOTA/P PMDA/PMDA 49.png', 'Sosialisasi / Himbauan Bahaya listrik bagi pemilik bangunan dan tukang bangunan', '1', '2', 'INDRAMAYU', 'Proses pembangunan masih berlangsung', '2022-07-28 15:41:27', '0000-00-00 00:00:00', '2022-07-27'),
(18, 'KRSG', '133', 'Ds Karanganyar Indramayu', '-6.1713', '108.1855130', 'Bangunan', 'Pembangunan dekat SUTM', 'ULP INDRAMAYU KOTA/P KRSG/KRSG 133.png', 'Sosialisasi / Himbauan Bahaya listrik bagi pemilik bangunan dan tukang bangunan', '1', '2', 'INDRAMAYU', 'Proses pembangunan masih berlangsung', '2022-07-28 15:48:54', '0000-00-00 00:00:00', '2022-07-27'),
(19, 'GANTAR', 'GANTAR 86', 'Haurkolot, Kabupaten Indramayu, Jawa Barat', '-6.467417', '107.947667', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P GANTAR/GANTAR 86.jpg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'PROSES PEMBANGUNAN', '2022-07-28 16:08:17', '2022-08-03 20:43:54', '0000-00-00'),
(20, 'GANTAR', 'GANTAR 55', 'Jl. Jenderal Sudirman, Mekarjati, Kec. Haurgeulis, Kabupaten Indramayu, Jawa Barat 45264', '-6.449639', '107.942111', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P GANTAR/GANTAR 55.jpg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'AKTITAS PEMBANGUNAN  SUDAH SELESAI', '2022-07-28 16:11:49', '0000-00-00 00:00:00', '0000-00-00'),
(21, 'GANTAR', 'GANTAR 212R38', 'Gantar-Bantar Huni, Mekarjaya, Kec. Gantar, Kabupaten Indramayu, Jawa Barat 45264', '-6.539028', '107.969750', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P GANTAR/GANTAR 212R38.jpeg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'AKTITAS PEMBANGUNAN  SUDAH SELESAI', '2022-07-28 16:14:41', '0000-00-00 00:00:00', '0000-00-00'),
(22, 'SUKRA', 'SUKRA 216', ' Jl. Pusaka Jaya, Sukrawetan, Kec. Sukra, Kabupaten Indramayu, Jawa Barat 45257', '-6.306194', '107.937917', 'Baliho/Reklame', 'BALIHO DEKAT SUTM', 'ULP HAURGEULIS/P SUKRA/SUKRA 216.jpeg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR TGL. 28/07/2022', '1', '1', 'HAURGEULIS', 'JARAK < 3 METER PERLU INSPEKSI BERKALA UNTUK KEGIATAN SOSIALISASI', '2022-07-28 16:16:51', '2022-09-15 18:50:25', '2022-07-28'),
(23, 'BALERAJA', 'BALERAJA 52', 'Jl. Ahmad Yani 1-47, Haurgeulis, Kec. Haurgeulis, Kabupaten Indramayu, Jawa Barat 45264', '-6.458944', '107.941361', 'Baliho/Reklame', 'BALIHO DEKAT SUTM', 'ULP HAURGEULIS/P BALERAJA/BALERAJA 52.jpeg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'JARAK < 3 METER PERLU INSPEKSI BERKALA UNTUK KEGIATAN SOSIALISASI', '2022-07-28 16:19:20', '2022-09-15 18:50:09', '2022-07-24'),
(24, 'PATROL', 'PATROL 32', 'Jl. Haurgeulis - Patrol, Sumbermulya, Kec. Haurgeulis, Kabupaten Indramayu, Jawa Barat 45264', '-6.421056', '107.953667', 'Layangan', 'KEGIATAN LAYANG LAYANG', 'ULP HAURGEULIS/P PATROL/PATROL SUMBERMULYA.jpeg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'AKTITAS  SUDAH SELESAI', '2022-07-28 16:27:29', '0000-00-00 00:00:00', '2022-07-25'),
(25, 'KDKN', '-', 'Desa Kedokan Bunder', '-6.50081', '108.419817', 'Bangunan', 'Pembangunan Bangunan mendekati SUTM', 'ULP JATIBARANG/WhatsApp Image 2022-07-28 at 16.46.10.jpeg', 'Sosialisasi bahaya listrik masyarakat umum', '1', '2', 'JATIBARANG', 'Pembangunan masih berlangsung', '2022-07-28 16:47:53', '0000-00-00 00:00:00', '2022-07-26'),
(26, 'PATROL', 'PATROL 14', 'Jl. Haurgeulis - Patrol, Cipancuh, Kec. Haurgeulis, Kabupaten Indramayu, Jawa Barat 45264', '-6.434000', '107.947056', 'Antena', 'PEMASANGAN ANTENA DEKAT SUTM', '', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '3', 'HAURGEULIS', 'KORBAN TERSENGAT LISTRIK KONDISI MENINGGAL DUNIA', '2022-07-28 22:07:15', '0000-00-00 00:00:00', '2022-05-10'),
(27, 'PATROL', 'ZONA 1', 'Jl. Haurgeulis - Patrol, Cipancuh, Kec. Haurgeulis, Kabupaten Indramayu, Jawa Barat 45264', '6.424975', '107.955728', 'Layangan', 'KEGIATAN LAYANG LAYANG', 'ULP HAURGEULIS/P PATROL/WhatsApp Image 2022-08-01 at 22.19.01.jpeg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'AKTIVITAS LAYANGAN TERPANTAU MASIH ADA', '2022-08-01 22:24:05', '2022-08-10 10:53:11', '2022-08-01'),
(28, 'BONGAS ', 'BONGAS 77', 'Wanguk, Kec. Anjatan, Kabupaten Indramayu, Jawa Barat 45264', '-6.418085', '107.963829', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P BONGAS/BONGAS 77_1.jpeg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'AKTITAS PEMBANGUNAN  MASIH BERLANGSUNG', '2022-08-01 22:27:03', '2022-08-25 14:19:15', '2022-08-01'),
(29, 'MARGAMULYA', 'MARGAMULYA 39', 'Jl. Haurgeulis - Patrol, Cipancuh, Kec. Haurgeulis, Kabupaten Indramayu, Jawa Barat 45264', '-6.424235', '107.951317', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P MARGAMULYA/MGMA 39.jpeg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'AKTITAS PEMBANGUNAN  MASIH BERLANGSUNG', '2022-08-01 22:35:57', '2022-08-09 18:52:45', '2022-07-29'),
(30, 'PATROL', 'PATROL 26', 'Jl. Haurgeulis - Patrol, Cipancuh, Kec. Haurgeulis, Kabupaten Indramayu, Jawa Barat 45264', '-6.428717', '107.948873', 'Bangunan', 'BANGUNAN DEKAT DENGAN SUTM', 'ULP HAURGEULIS/P PATROL/PTRL 26.jpeg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'AKTITAS  SUDAH SELESAI', '2022-08-01 22:42:58', '0000-00-00 00:00:00', '2022-07-29'),
(31, 'GABUSWETAN', 'GABUSWETAN 15', 'Sidodadi, Kec. Haurgeulis, Kabupaten Indramayu, Jawa Barat', '-6.430779', '107.956522', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P GABUSWETAN/GBWN 15.jpeg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'PROSES PEMBANGUNAN', '2022-08-02 12:07:41', '2022-08-22 23:20:33', '2022-08-02'),
(32, 'JNGA', '79', 'JL.RAYA TERISI - CIKAMURANG KEC.TERISI, INDRAMAYU JABAR 45262', '-06.2822', '108.928', 'Bangunan', 'PEMBANGUNGAN RUMAH DEKAT SUTM', 'ULP CIKEDUNG/PNY JNGA/WhatsApp Image 2022-08-03 at 12.40.39.jpeg', 'SUDAH DILAKSANAKAN SOSIALISASI BAHAYA LISTRIK', '1', '1', 'CIKEDUNG', 'AKTITAS PEMBANGUNAN  MASIH BERLANGSUNG', '2022-08-03 13:45:31', '2022-08-26 08:40:39', '2022-08-03'),
(33, 'JNGA', '175L117', 'DESA TEMPEL WETAN KEC.CIKEDUNG', '-06.2658', '108.1237', 'Bangunan', 'PEMBANGUNGAN RUMAH DEKAT SUTM', 'ULP CIKEDUNG/PNY JNGA/WhatsApp Image 2022-08-03 at 12.40.36.jpeg', 'SUDAH DILAKSANAKAN SOSIALISASI BAHAYA LISTRIK', '1', '2', 'CIKEDUNG', 'AKTITAS PEMBANGUNAN  MASIH BERLANGSUNG', '2022-08-03 13:51:18', '0000-00-00 00:00:00', '2022-08-03'),
(34, 'JNGA', '175L105', 'DESA TEMPEL KULON KEC.CIKEDUNG', '-06.2659', '108.1220', 'Baliho/Reklame', 'BALIHO 17 AGUSTUS DEKAT SUTM', 'ULP CIKEDUNG/PNY JNGA/WhatsApp Image 2022-08-03 at 12.40.33.jpeg', 'SUDAH DILAKSANAKAN SOSIALISASI BAHAYA LISTRIK', '1', '1', 'CIKEDUNG', 'AKAN DITINDAKLANJUTI PEMUDA SEKITAR UNTUK PENURUNAN BALIHO SESUAI JARAK AMAN', '2022-08-03 13:53:39', '0000-00-00 00:00:00', '2022-08-03'),
(35, 'PGGN', '84', 'JL.RAYA JANGGA - TERISI DESA CILOGOG KEC.LOSARANG, INDRAMAYU JABAR 45262', '-06.2529', '108.1011', 'Bangunan', 'PEMBANGUNGAN RUMAH DEKAT SUTM', 'ULP CIKEDUNG/PNY PGGN/WhatsApp Image 2022-08-03 at 12.40.39 (1).jpeg', 'SUDAH DILAKSANAKAN SOSIALISASI BAHAYA LISTRIK', '1', '1', 'CIKEDUNG', 'AKTITAS PEMBANGUNAN  MASIH BERLANGSUNG', '2022-08-03 13:55:56', '2022-08-26 08:40:15', '2022-08-03'),
(36, 'PGGN', '48', 'JL.RAYA JANGGA - TERISI DESA PEGAGAN KEC.LOSARANG, INDRAMAYU JABAR 45262', '-06.2633', '108.102', 'Bangunan', 'PEMBANGUNGAN RUMAH DEKAT SUTM', 'ULP CIKEDUNG/PNY PGGN/WhatsApp Image 2022-08-03 at 12.40.37.jpeg', 'SUDAH DILAKSANAKAN SOSIALISASI BAHAYA LISTRIK', '1', '2', 'CIKEDUNG', 'AKTITAS PEMBANGUNAN  MASIH BERLANGSUNG', '2022-08-03 13:57:11', '0000-00-00 00:00:00', '2022-08-03'),
(37, 'GANTAR', 'GANTAR 4', 'Jl. Haurgeulis - Patrol, Cipancuh, Kec. Haurgeulis, Kabupaten Indramayu, Jawa Barat 45264', '-6.440762', '107.946250', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P GANTAR/GNTR 4.jpeg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'AKTITAS PEMBANGUNAN  MASIH BERLANGSUNG', '2022-08-03 20:37:34', '2022-08-22 23:20:03', '2022-08-03'),
(38, 'PATROL', 'PATROL 33', 'Jl. Haurgeulis - Patrol, Cipancuh, Kec. Haurgeulis, Kabupaten Indramayu, Jawa Barat 45264', '-6.417025', '107.956924', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P PATROL/PTRL 33.jpeg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '2', 'HAURGEULIS', 'PROSES PEMBANGUNAN', '2022-08-03 20:47:24', '0000-00-00 00:00:00', '2022-08-03'),
(39, 'SLYG', '60-61', 'DESA MAJASARI, KECAMATAN SLIYEG KAB.INDRAMAYU', '-6.454434', '108.339967', 'Bangunan', 'Pekerja bangunan tersengat SUTM', 'ULP JATIBARANG/WhatsApp Image 2022-08-05 at 09.22.33.jpeg', 'Sudah dilaksanakan Sosialisasi Bahaya Listrik', '1', '2', 'JATIBARANG', 'bangunan masjid masih tahap pengerjaan', '2022-08-05 09:25:00', '0000-00-00 00:00:00', '2022-05-18'),
(40, 'PLSI', '27', 'JALAN RAYA JATIBARANG KEC.SLIYEG KAB.INDRAMAYU', '-6.475877', '108.334157', 'Antena', 'jika rubuh antena mengenai SUTM', 'ULP JATIBARANG/WhatsApp Image 2022-08-05 at 09.26.34.jpeg', 'Sudah dilaksanakan Sosialisasi Bahaya Listrik', '1', '2', 'JATIBARANG', 'Antena berdiri kokoh dan tiang terbuat dr besi hollow', '2022-08-05 09:29:41', '0000-00-00 00:00:00', '2022-05-18'),
(41, 'JNTI', '67', 'JALAN K.H HASBULLAH NO.324 , TAMBI,KEC SLIYEG KAB.INDRAMAYU', '-6.479396', '108.34757', 'Bangunan', 'Pekerja bangunan tersengat SUTM', 'ULP JATIBARANG/WhatsApp Image 2022-08-05 at 09.38.42.jpeg', 'Sudah dilaksanakan Sosialisasi Bahaya Listrik', '1', '2', 'JATIBARANG', 'bangunan masih tahap pengerjaan', '2022-08-05 09:39:29', '0000-00-00 00:00:00', '2022-05-18'),
(42, 'KSMY', '278', 'KERTASMAYA', '-6', '108', 'Bangunan', 'Pekerja bangunan dekat SUTM', 'ULP JATIBARANG/WhatsApp Image 2022-08-05 at 09.42.32.jpeg', 'Sudah dilaksanakan Sosialisasi Bahaya Listrik', '1', '1', 'JATIBARANG', 'bangunan telah selesai pengerjaan', '2022-08-05 09:43:11', '2022-08-12 15:33:13', '2022-03-08'),
(43, 'LNGT', '104', 'Ds Sindang', '-6.206', '108.19346', 'Bangunan', 'Pembangunan dekat SUTM', 'ULP INDRAMAYU KOTA/P LNGT/WhatsApp Image 2022-08-05 at 09.39.37.jpeg', 'Sosialisasi Himbauan Bahayas Listrik bagi pekerja bangunan', '', '1', 'INDRAMAYU', 'Pekerjaan sudah selesai ', '2022-08-05 09:46:01', '0000-00-00 00:00:00', '2022-07-14'),
(44, 'KSMY', '275', 'DESA TERSANA', '-6', '108', 'Lain-Lain', 'Baliho dekat SUTM', 'ULP JATIBARANG/WhatsApp Image 2022-08-08 at 16.26.11.jpeg', 'Sudah dilaksanakan Sosialisasi Bahaya Listrik', '1', '1', 'JATIBARANG', 'Baliho yang dekat SUTM sudah di turunkan', '2022-08-08 17:11:33', '0000-00-00 00:00:00', '2022-08-08'),
(45, 'MARGAMULYA', 'MARGAMULYA 98', 'Plawangan Lempuyang 30, Kertamulya, Kec. Bongas, Kabupaten Indramayu, Jawa Barat 45255', '-6.362342', '108.000607', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P MARGAMULYA/MGMA 98.jpeg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'PROSES PEMBANGUNAN', '2022-08-09 18:57:13', '2022-08-31 08:55:57', '2022-08-09'),
(46, 'GANTAR', 'GANTAR 62', 'Haurgeulis, Kec. Haurgeulis, Kabupaten Indramayu, Jawa Barat 45266', '-6.4644037', '107.9477092', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P GANTAR/GNTR 62.jpeg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'PROSES PEMBANGUNAN', '2022-08-09 19:07:47', '2022-08-25 14:18:51', '2022-08-08'),
(47, 'KRYA', 'GBKA 303', 'Jl. Raya Pu Saradan, Sekarmulya, Kec. Gabuswetan, Kabupaten Indramayu, Jawa Barat 45265', '6.448510', '108.077026', 'Bangunan', 'PEMBANGUNGAN RUMAH DEKAT SUTM', 'ULP CIKEDUNG/PNY KRYA/WhatsApp Image 2022-08-09 at 16.54.16.jpeg', 'SUDAH DILAKSANAKAN SOSIALISASI BAHAYA LISTRIK', '1', '2', 'CIKEDUNG', 'AKTITAS PEMBANGUNAN  MASIH BERLANGSUNG', '2022-08-10 10:21:09', '0000-00-00 00:00:00', '2022-08-10'),
(48, 'PLSI', '02', 'DESA TAMBI', '-6.1', '108.1', 'Bangunan', 'Pekerja bangunan dekat SUTM', 'ULP JATIBARANG/FotoJet.jpg', 'Sudah dilaksanakan Sosialisasi Bahaya Listrik', '1', '2', 'JATIBARANG', 'bangunan masih tahap pengerjaan', '2022-08-18 09:45:30', '0000-00-00 00:00:00', '2022-08-05'),
(49, 'JNTI', '172L92R49', 'DESA LOMBANG', '-6.1', '108.1', 'Bangunan', 'Pekerja bangunan dekat SUTM', 'ULP JATIBARANG/FotoJet (1).jpg', 'Sudah dilaksanakan Sosialisasi Bahaya Listrik', '1', '2', 'JATIBARANG', 'bangunan masih tahap pengerjaan', '2022-08-18 09:46:35', '0000-00-00 00:00:00', '2022-08-16'),
(50, 'KRSG', '127', 'Ds Pabean Ilir', '-6.1717', '108.18.59.204', 'Bangunan', 'Pembangunan rumah bertingkat dekat SUTM', 'ULP INDRAMAYU KOTA/P KRSG/KRSG 127.jpg', 'Sosialisasi / Himbauan Bahaya listrik bagi pemilik bangunan dan tukang bangunan', '1', '1', 'INDRAMAYU', 'Proses pembangunan sudah hampir selesai', '2022-08-18 10:08:49', '0000-00-00 00:00:00', '2022-08-16'),
(51, 'CHJF', '212', 'Ds Larangan', '-6.24.27', '108.15.33.115', 'Bangunan', 'Pembangunan dekat SUTM', 'ULP INDRAMAYU KOTA/P CHJF/CHJF 212.jpg', 'Sosialisasi / Himbauan Bahaya listrik bagi pemilik bangunan dan tukang bangunan', '1', '2', 'INDRAMAYU', 'Pembangunan masih berlangsung ', '2022-08-18 15:10:06', '0000-00-00 00:00:00', '2022-08-16'),
(52, 'LBNR', '16', 'Ds Bojongsari', '-6.2114', '108.194201', 'Bangunan', 'Pembuatan garasi dekat SUTM', 'ULP INDRAMAYU KOTA/P LBNR/LBNR 16.jpg', 'Sosialisasi Himbauan Bahayas Listrik bagi pemilik bangunan', '1', '2', 'INDRAMAYU', 'Proses pembuatan kanopi dengan kerangka atap dari baja ringan, pekerjaan belum selesai.', '2022-08-18 15:24:18', '2022-08-18 15:32:18', '2022-08-09'),
(53, 'LNGT', '104R68', 'Jl MT. Haryono Ds Dermayu', '-6.2013', '108.19.0.115', 'Bangunan', 'Pembangunan dekat SUTM', 'ULP INDRAMAYU KOTA/P LNGT/LNGT 104R68.jpg', 'Sosialisasi / Himbauan Bahaya listrik bagi pemilik bangunan dan tukang bangunan', '1', '2', 'INDRAMAYU', 'Pembangunan Masih berlangsung', '2022-08-19 14:57:58', '0000-00-00 00:00:00', '2022-08-09'),
(54, 'KDHR', '413', 'JL.RAYA KANDANGHAUR DS.KARANGANYAR ', '-6.2214', '108.716', 'Bangunan', 'PEMBANGUNGAN RUMAH DEKAT SUTM', 'ULP CIKEDUNG/PNY KRSM/WhatsApp Image 2022-08-19 at 15.15.36.jpeg', 'SUDAH DILAKSANAKAN SOSIALISASI BAHAYA LISTRIK', '1', '2', 'CIKEDUNG', 'AKTITAS PEMBANGUNAN  MASIH BERLANGSUNG', '2022-08-19 15:46:44', '0000-00-00 00:00:00', '2022-08-19'),
(55, 'LSRG', '-', 'DESA WIDASARI', '-6', '108', 'Bangunan', 'Pekerja bangunan dekat SUTR', 'ULP JATIBARANG/WhatsApp Image 2022-08-19 at 11.13.41.jpeg', 'Sudah dilaksanakan Sosialisasi Bahaya Listrik', '1', '2', 'JATIBARANG', 'bangunan masih tahap pengerjaan', '2022-08-19 17:38:24', '0000-00-00 00:00:00', '2022-08-19'),
(56, 'PATROL', 'PATROL 44', 'Jl. Haurgeulis - Patrol, Cipancuh, Kec. Haurgeulis, Kabupaten Indramayu, Jawa Barat 45264', '-6.421876', '107.952921', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P PATROL/PTRL44.jpg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'AKTITAS PEMBANGUNAN  MASIH BERLANGSUNG', '2022-08-24 11:35:30', '2022-09-15 18:49:06', '2022-08-24'),
(57, 'JNTI', '-', 'DESA JUNTI', '-6', '108', 'Bangunan', 'Pekerja bangunan dekat SUTM', 'ULP JATIBARANG/WhatsApp Image 2022-08-23 at 16.33.47.jpeg', 'Sudah dilaksanakan Sosialisasi Bahaya Listrik', '1', '2', 'JATIBARANG', 'bangunan masih tahap pengerjaan', '2022-08-25 19:54:20', '0000-00-00 00:00:00', '2022-08-25'),
(58, 'GANTAR', 'GANTAR 85', 'Haur Geulis Gantar 13, Gantar, Kec. Gantar, Kabupaten Indramayu, Jawa Barat 45264 ', '', '', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P GANTAR/GANTAR 86 v2.jpeg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'AKTITAS PEMBANGUNAN  SUDAH SELESAI', '2022-09-06 23:59:54', '2022-09-14 15:29:32', '2022-09-06'),
(59, 'GANTAR', 'GANTAR 92', 'Haur Geulis Gantar 13, Gantar, Kec. Gantar, Kabupaten Indramayu, Jawa Barat 45264 ', '-6.469065', '107.947535', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P GANTAR/GANTAR 92.jpeg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '2', 'HAURGEULIS', 'PROSES PEMBANGUNAN', '2022-09-07 00:03:17', '2022-09-09 12:52:02', '2022-09-06'),
(60, 'LBNR', 'Gardu PRKA', 'Ds Panyingkiran Kidul', '-6.332486413631272', '108.26043796796358', 'Bangunan', 'Pembangunan rumah dekat SUTM', 'ULP INDRAMAYU KOTA/P LBNR/Pnl LBNR Gardu PRKA.jpeg', 'Sosialisasi / Himbauan Bahaya listrik bagi pemilik bangunan dan tukang bangunan', '1', '2', 'INDRAMAYU', 'Pembangunan masih berlangsung ', '2022-09-09 08:58:06', '0000-00-00 00:00:00', '2022-09-07'),
(61, 'LBNR', 'Gardu PDKL', 'Ds Penyindangan Blok Pecuk', '6.3459210307837655', '108.2914095045764', 'Bangunan', 'Pembangunan sekolah dekat SUTM', 'ULP INDRAMAYU KOTA/P LBNR/Pnl%20LBNR%20Gadu%20PDKL.jpeg', 'Sosialisasi / Himbauan Bahaya listrik bagi pemilik bangunan dan tukang bangunan', '1', '2', 'INDRAMAYU', 'Pembangunan masih berlangsung ', '2022-09-09 09:17:30', '0000-00-00 00:00:00', '2022-09-07'),
(62, 'PATROL', 'PATROL 23', 'Jl. Haurgeulis - Patrol, Cipancuh, Kec. Haurgeulis, Kabupaten Indramayu, Jawa Barat 45264', '-6.429707', '107.948429', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P PATROL/PTRL 23.jpeg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '1', 'HAURGEULIS', 'PROSES PEMBANGUNAN', '2022-09-09 12:49:57', '2022-09-15 18:49:34', '2022-09-09'),
(63, 'GABUSWETAN', 'GABUSWETAN 203', 'Jl. Raya Kedung Dawa, Kedungdawa, Kec. Gabuswetan, Kabupaten Indramayu, Jawa Barat 45263', '-6.434428', '108.016516', 'Bangunan', 'PEMBANGUNAN DEKAT SUTM', 'ULP HAURGEULIS/P GABUSWETAN/GBWN 203.jpeg', 'SUDAH DILAKSANAKAN  SOSIALISASI DOOR TO DOOR', '1', '2', 'HAURGEULIS', 'PROSES PEMBANGUNAN', '2022-09-13 22:18:59', '2022-09-13 22:20:13', '2022-09-13'),
(64, 'LYNG', 'LYNG 37', 'JL.RAYA TERISI - CIKAMURANG KEC.TERISI, INDRAMAYU JABAR 45262', '-06.2956', '108.858', 'Bangunan', 'PEMBANGUNGAN RUMAH DEKAT SUTM', 'ULP CIKEDUNG/PNY LYNG/WhatsApp Image 2022-09-14 at 10.31.54.jpeg', 'SUDAH DILAKSANAKAN SOSIALISASI BAHAYA LISTRIK', '1', '2', 'CIKEDUNG', 'AKTITAS PEMBANGUNAN  MASIH BERLANGSUNG', '2022-09-14 10:52:20', '0000-00-00 00:00:00', '2022-09-14');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_logging`
--

CREATE TABLE `tbl_logging` (
  `id_logging` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `ip_add` text NOT NULL,
  `mac_add` text NOT NULL,
  `device` text NOT NULL,
  `location` text NOT NULL,
  `time_in` datetime NOT NULL,
  `time_out` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

CREATE TABLE `tbl_user` (
  `id_user` int(11) NOT NULL,
  `nama_lengkap` varchar(50) NOT NULL,
  `nip` varchar(10) NOT NULL,
  `email` varchar(20) NOT NULL,
  `no_hp` varchar(13) NOT NULL,
  `perusahaan` text NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(50) NOT NULL,
  `level` varchar(5) NOT NULL,
  `note` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_user`
--

INSERT INTO `tbl_user` (`id_user`, `nama_lengkap`, `nip`, `email`, `no_hp`, `perusahaan`, `username`, `password`, `level`, `note`) VALUES
(1, 'Dino Arla', '9419758ZY', 'dino.arla@pln.co.id', '085285714075', 'PT PLN (Persero) UP3 Indramayu', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin', 'Super Admin / Author'),
(2, 'Danang Setiawan', '', 'danang.setiawan@pln.', '', '', '5300.danang', '827ccb0eea8a706c4c34a16891f84e7b', 'admin', ''),
(7, 'K3L ULP Jatibarang', '', '-', '', '', '53401.jtb', 'e10adc3949ba59abbe56e057f20f883e', 'admin', ''),
(8, 'K3L ULP Haurgeulis', '', '-', '', '', '53402.hrg', 'e10adc3949ba59abbe56e057f20f883e', 'admin', ''),
(9, 'K3L ULP Indramayu Kota', '', '-', '', '', '53403.iko', 'e10adc3949ba59abbe56e057f20f883e', 'admin', ''),
(10, 'K3L ULP Cikedung', '', '-', '', '', '53404.ckd', 'e10adc3949ba59abbe56e057f20f883e', 'admin', ''),
(11, 'K3L UP3 Indramayu', '', '-', '', '', '5300.up3', 'e10adc3949ba59abbe56e057f20f883e', 'admin', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `setting`
--
ALTER TABLE `setting`
  ADD PRIMARY KEY (`id_setting`);

--
-- Indexes for table `tbl_entry`
--
ALTER TABLE `tbl_entry`
  ADD PRIMARY KEY (`id_entry`);

--
-- Indexes for table `tbl_logging`
--
ALTER TABLE `tbl_logging`
  ADD PRIMARY KEY (`id_logging`);

--
-- Indexes for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `setting`
--
ALTER TABLE `setting`
  MODIFY `id_setting` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_entry`
--
ALTER TABLE `tbl_entry`
  MODIFY `id_entry` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `tbl_logging`
--
ALTER TABLE `tbl_logging`
  MODIFY `id_logging` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
