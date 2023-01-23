-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 23, 2023 at 01:47 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nekretnine`
--

-- --------------------------------------------------------

--
-- Table structure for table `korisnici`
--

CREATE TABLE `korisnici` (
  `id` int(11) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(256) DEFAULT NULL,
  `role` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `korisnici`
--

INSERT INTO `korisnici` (`id`, `first_name`, `last_name`, `email`, `password`, `role`) VALUES
(14, 'Administrator', 'Admin', 'admin@admin.com', 'pbkdf2:sha256:260000$YNYkOyTYvRFBuBZj$90eadfd8b592916088412e7d3ebe842f462063a0d41274e3e0a1d78147cbebe6', 'admin'),
(15, 'User', 'Juzeric', 'user@user.com', 'pbkdf2:sha256:260000$iLY6OnF37WvrK41l$4c2e22c19161a49ca6a07334a5d336eee580b3e66a317a8563832204747d21f4', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `kuce`
--

CREATE TABLE `kuce` (
  `id` int(11) NOT NULL,
  `cena` int(11) DEFAULT NULL,
  `adresa` varchar(50) DEFAULT NULL,
  `kvadratura` int(11) DEFAULT NULL,
  `cena_po_kvadratu` int(11) DEFAULT NULL,
  `oglasavac` varchar(50) DEFAULT NULL,
  `slika` varchar(50) NOT NULL DEFAULT 'https://picsum.photos/201/301',
  `broj_soba` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kuce`
--

INSERT INTO `kuce` (`id`, `cena`, `adresa`, `kvadratura`, `cena_po_kvadratu`, `oglasavac`, `slika`, `broj_soba`) VALUES
(2, 70544, '15th Floor', 370, 973, 'Greenfelder-Champlin', 'https://picsum.photos/201/301?grayscale', 4),
(3, 18681, 'Apt 1084', 470, 993, 'Klein-Pfannerstill', 'https://picsum.photos/201/301?grayscale', 4),
(4, 20611, '3rd Floor', 296, 938, 'Nader-Ledner', 'https://picsum.photos/201/301?grayscale', 7),
(5, 3545, 'Apt 1777', 430, 849, 'Sanford-Thompson', 'https://picsum.photos/201/301?grayscale', 1),
(6, 18640, 'Room 189', 70, 942, 'Cruickshank-Beahan', 'https://picsum.photos/201/301?grayscale', 3),
(7, 6337, 'Suite 77', 409, 732, 'Collier, Bergstrom and Medhurst', 'https://picsum.photos/201/301?grayscale', 3),
(8, 21978, 'PO Box 70382', 344, 730, 'Dickinson-Kerluke', 'https://picsum.photos/201/301?grayscale', 5),
(9, 20510, '17th Floor', 494, 799, 'Flatley Inc', 'https://picsum.photos/201/301?grayscale', 6),
(10, 73452, 'Suite 2', 97, 882, 'Hansen-Weber', 'https://picsum.photos/201/301?grayscale', 7),
(11, 47963, '2nd Floor', 465, 885, 'Sporer LLC', 'https://picsum.photos/201/301?grayscale', 7),
(12, 53892, 'PO Box 49747', 184, 783, 'MacGyver, Pollich and Doyle', 'https://picsum.photos/201/301?grayscale', 1),
(13, 44901, 'Room 1768', 331, 779, 'Veum, Reichel and Mayer', 'https://picsum.photos/201/301?grayscale', 2),
(14, 53448, 'Suite 89', 33, 932, 'Greenholt, Pacocha and Koss', 'https://picsum.photos/201/301?grayscale', 1),
(15, 19612, 'Apt 1572', 76, 715, 'Cormier LLC', 'https://picsum.photos/201/301?grayscale', 1),
(16, 89528, '9th Floor', 285, 956, 'Kutch Group', 'https://picsum.photos/201/301?grayscale', 6),
(17, 41050, 'Apt 820', 365, 884, 'Wilkinson Inc', 'https://picsum.photos/201/301?grayscale', 7),
(18, 2627, '14th Floor', 263, 904, 'Ernser, Monahan and Keebler', 'https://picsum.photos/201/301?grayscale', 6),
(19, 79655, 'Room 964', 414, 901, 'Johnson-Altenwerth', 'https://picsum.photos/201/301?grayscale', 6),
(20, 87472, 'Room 1604', 180, 882, 'Hahn-Casper', 'https://picsum.photos/201/301?grayscale', 6),
(21, 6787, 'Suite 35', 416, 756, 'Shields, Rolfson and Harvey', 'https://picsum.photos/201/301?grayscale', 3),
(22, 10633, 'Room 1963', 30, 867, 'Rogahn Inc', 'https://picsum.photos/201/301?grayscale', 3),
(23, 30831, 'PO Box 18595', 468, 836, 'Vandervort, Feil and Hegmann', 'https://picsum.photos/201/301?grayscale', 3),
(24, 98228, 'PO Box 3825', 161, 851, 'Botsford LLC', 'https://picsum.photos/201/301?grayscale', 7),
(25, 23283, 'Suite 83', 118, 827, 'Fay-Gorczany', 'https://picsum.photos/201/301?grayscale', 5);

-- --------------------------------------------------------

--
-- Table structure for table `lokali`
--

CREATE TABLE `lokali` (
  `id` int(11) NOT NULL,
  `cena` int(11) DEFAULT NULL,
  `adresa` varchar(50) DEFAULT NULL,
  `kvadratura` int(11) DEFAULT NULL,
  `cena_po_kvadratu` int(11) DEFAULT NULL,
  `oglasavac` varchar(50) DEFAULT NULL,
  `slika` varchar(50) NOT NULL DEFAULT 'https://picsum.photos/202/302',
  `broj_soba` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lokali`
--

INSERT INTO `lokali` (`id`, `cena`, `adresa`, `kvadratura`, `cena_po_kvadratu`, `oglasavac`, `slika`, `broj_soba`) VALUES
(1, 43003, 'Apt 1975', 227, 732, 'Haley-Mueller', 'https://picsum.photos/202/302?grayscale', 3),
(2, 70544, '15th Floor', 370, 973, 'Greenfelder-Champlin', 'https://picsum.photos/202/302?grayscale', 4),
(3, 18681, 'Apt 1084', 470, 993, 'Klein-Pfannerstill', 'https://picsum.photos/202/302?grayscale', 4),
(4, 20611, '3rd Floor', 296, 938, 'Nader-Ledner', 'https://picsum.photos/202/302?grayscale', 7),
(5, 3545, 'Apt 1777', 430, 849, 'Sanford-Thompson', 'https://picsum.photos/202/302?grayscale', 1),
(6, 18640, 'Room 189', 70, 942, 'Cruickshank-Beahan', 'https://picsum.photos/202/302?grayscale', 3),
(7, 6337, 'Suite 77', 409, 732, 'Collier, Bergstrom and Medhurst', 'https://picsum.photos/202/302?grayscale', 3),
(8, 21978, 'PO Box 70382', 344, 730, 'Dickinson-Kerluke', 'https://picsum.photos/202/302?grayscale', 5),
(9, 20510, '17th Floor', 494, 799, 'Flatley Inc', 'https://picsum.photos/202/302?grayscale', 6),
(10, 73452, 'Suite 2', 97, 882, 'Hansen-Weber', 'https://picsum.photos/202/302?grayscale', 7),
(11, 47963, '2nd Floor', 465, 885, 'Sporer LLC', 'https://picsum.photos/202/302?grayscale', 7),
(12, 53892, 'PO Box 49747', 184, 783, 'MacGyver, Pollich and Doyle', 'https://picsum.photos/202/302?grayscale', 1),
(13, 44901, 'Room 1768', 331, 779, 'Veum, Reichel and Mayer', 'https://picsum.photos/202/302?grayscale', 2),
(14, 53448, 'Suite 89', 33, 932, 'Greenholt, Pacocha and Koss', 'https://picsum.photos/202/302?grayscale', 1),
(15, 19612, 'Apt 1572', 76, 715, 'Cormier LLC', 'https://picsum.photos/202/302?grayscale', 1),
(16, 89528, '9th Floor', 285, 956, 'Kutch Group', 'https://picsum.photos/202/302?grayscale', 6),
(17, 41050, 'Apt 820', 365, 884, 'Wilkinson Inc', 'https://picsum.photos/202/302?grayscale', 7),
(18, 2627, '14th Floor', 263, 904, 'Ernser, Monahan and Keebler', 'https://picsum.photos/202/302?grayscale', 6),
(19, 79655, 'Room 964', 414, 901, 'Johnson-Altenwerth', 'https://picsum.photos/202/302?grayscale', 6),
(20, 87472, 'Room 1604', 180, 882, 'Hahn-Casper', 'https://picsum.photos/202/302?grayscale', 6),
(21, 6787, 'Suite 35', 416, 756, 'Shields, Rolfson and Harvey', 'https://picsum.photos/202/302?grayscale', 3),
(22, 10633, 'Room 1963', 30, 867, 'Rogahn Inc', 'https://picsum.photos/202/302?grayscale', 3),
(23, 30831, 'PO Box 18595', 468, 836, 'Vandervort, Feil and Hegmann', 'https://picsum.photos/202/302?grayscale', 3),
(24, 98228, 'PO Box 3825', 161, 851, 'Botsford LLC', 'https://picsum.photos/202/302?grayscale', 7),
(25, 23283, 'Suite 83', 118, 827, 'Fay-Gorczany', 'https://picsum.photos/202/302?grayscale', 5);

-- --------------------------------------------------------

--
-- Table structure for table `stanovi`
--

CREATE TABLE `stanovi` (
  `id` int(11) NOT NULL,
  `cena` int(11) DEFAULT NULL,
  `adresa` varchar(50) DEFAULT NULL,
  `kvadratura` int(11) DEFAULT NULL,
  `cena_po_kvadratu` int(11) DEFAULT NULL,
  `oglasavac` varchar(50) DEFAULT NULL,
  `slika` varchar(50) NOT NULL DEFAULT 'https://picsum.photos/200/300',
  `broj_soba` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stanovi`
--

INSERT INTO `stanovi` (`id`, `cena`, `adresa`, `kvadratura`, `cena_po_kvadratu`, `oglasavac`, `slika`, `broj_soba`) VALUES
(2, 70544, '15th Floor', 370, 973, 'Greenfelder-Champlin', 'https://picsum.photos/200/300?grayscale', 4),
(3, 2123, 'TESTING STANAAA', 122, 800, 'Klein-Pfannerstill', 'https://picsum.photos/200/300?grayscale', 3),
(4, 20611, '3rd Floor', 296, 938, 'Nader-Ledner', 'https://picsum.photos/200/300?grayscale', 7),
(5, 3545, 'NoVIIIIII', 430, 849, 'Sanford-Thompson', 'https://picsum.photos/200/300?grayscale', 1),
(6, 18640, 'Room 189', 70, 942, 'Cruickshank-Beahan', 'https://picsum.photos/200/300?grayscale', 3),
(7, 6337, 'Suite 77', 409, 732, 'Collier, Bergstrom and Medhurst', 'https://picsum.photos/200/300?grayscale', 3),
(9, 20510, '17th Floor', 494, 799, 'Flatley Inc', 'https://picsum.photos/200/300?grayscale', 6),
(10, 73452, 'Suite 2', 97, 882, 'Hansen-Weber', 'https://picsum.photos/200/300?grayscale', 7),
(11, 47963, '2nd Floor', 465, 885, 'Sporer LLC', 'https://picsum.photos/200/300?grayscale', 7),
(12, 53892, 'PO Box 49747', 184, 783, 'MacGyver, Pollich and Doyle', 'https://picsum.photos/200/300?grayscale', 1),
(13, 44901, 'Room 1768', 331, 779, 'Veum, Reichel and Mayer', 'https://picsum.photos/200/300?grayscale', 2),
(14, 53448, 'Suite 89', 33, 932, 'Greenholt, Pacocha and Koss', 'https://picsum.photos/200/300?grayscale', 1),
(15, 19612, 'Apt 1572', 76, 715, 'Cormier LLC', 'https://picsum.photos/200/300?grayscale', 1),
(17, 41050, 'Apt 820', 365, 884, 'Wilkinson Inc', 'https://picsum.photos/200/300?grayscale', 7),
(18, 2627, '14th Floor', 263, 904, 'Ernser, Monahan and Keebler', 'https://picsum.photos/200/300?grayscale', 6),
(23, 30831, 'PO Box 18595', 468, 836, 'Vandervort, Feil and Hegmann', 'https://picsum.photos/200/300?grayscale', 3),
(24, 98228, 'PO Box 3825', 161, 851, 'Botsford LLC', 'https://picsum.photos/200/300?grayscale', 7),
(25, 345, 'ohjasdiouash', 49, 499, 'djaois', 'https://picsum.photos/200/300.jpg', 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `korisnici`
--
ALTER TABLE `korisnici`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kuce`
--
ALTER TABLE `kuce`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lokali`
--
ALTER TABLE `lokali`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stanovi`
--
ALTER TABLE `stanovi`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `korisnici`
--
ALTER TABLE `korisnici`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `kuce`
--
ALTER TABLE `kuce`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `lokali`
--
ALTER TABLE `lokali`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `stanovi`
--
ALTER TABLE `stanovi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
