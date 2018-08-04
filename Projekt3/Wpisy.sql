-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 11 Cze 2018, 19:55
-- Wersja serwera: 5.7.22-0ubuntu0.16.04.1
-- Wersja PHP: 7.2.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `Baza`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `Wpisy`
--

CREATE TABLE `Wpisy` (
  `ID` bigint(25) UNSIGNED NOT NULL,
  `Nick` varchar(20) CHARACTER SET utf16 COLLATE utf16_polish_ci NOT NULL DEFAULT 'anonim',
  `Data` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Subject` varchar(10) CHARACTER SET utf16 COLLATE utf16_polish_ci DEFAULT NULL,
  `Info` text CHARACTER SET utf16 COLLATE utf16_polish_ci NOT NULL,
  `Display` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `Wpisy`
--

INSERT INTO `Wpisy` (`ID`, `Nick`, `Data`, `Subject`, `Info`, `Display`) VALUES
(1, 'first', '2018-06-11 11:19:00', 'Semestr1', 'Dobry semestr', 1),
(2, 'second', '2018-06-11 11:29:00', 'Semestr2', 'Niezły Semestr', 1),
(3, 'third', '2018-06-11 11:39:00', 'Semestr3', 'Ergonomiczna strona', 1);

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `Wpisy`
--
ALTER TABLE `Wpisy`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `Wpisy`
--
ALTER TABLE `Wpisy`
  MODIFY `ID` bigint(25) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
