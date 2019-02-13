<?php
/*.
  require_module 'standard';
  require_module 'mysqli';
.*/

/**
*  konstruktor połączenia z bazą danych
*  @return void
*/

class mydb extends mysqli {

  public function __construct() {
    parent::__construct('127.0.0.1', 'root', '1234', 'Baza');
  
    if (mysqli_connect_errno() != 0) {
      die('Connect Error (' . mysqli_connect_errno() . ') ' . mysqli_connect_error());
    }
    parent::query("SET NAMES utf8");
    parent::query("SET CHARACTER SET utf8");
    parent::query("SET collation_connection = utf16_polish_ci");
  }
}

$sessionKEY = "key";
$sessionVAL = "3.141";

$skroty = [
  "S1"    => "Semestr I",
  "S2"    => "Semestr II",
  "S3"    => "Semestr III",
  "S4"    => "Semestr IV",
  "S5"	  => "Semestr V",
  "mainpage"  => "Strona główna",
  "movies" => "Kino",
  "tenis" => "Tenis ziemny"
];

function Kody2Napisy($kod) {
  global $skroty;
  return (string) isset($skroty[$kod])?$skroty[$kod]:$kod;
}


function ZalozTabeleWpisy() {
  $s =<<<EOT
CREATE TABLE `Wpisy` (
  `ID` bigint(25) UNSIGNED NOT NULL,
  `Nick` varchar(20) CHARACTER SET utf16 COLLATE utf16_polish_ci NOT NULL DEFAULT 'anonim',
  `Data` datetime NOT NULL,
  `Subject` varchar(10) CHARACTER SET utf16 COLLATE utf16_polish_ci DEFAULT NULL,
  `Info` text CHARACTER SET utf16 COLLATE utf16_polish_ci NOT NULL,
  `Display` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_polish_ci;

ALTER TABLE `Wpisy`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE  KEY `ID` (`ID`);

ALTER TABLE `Wpisy`
  MODIFY `ID` bigint(25) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
EOT;
  return $s;
}

function DodajWpis() {
  $s = <<<EOT
INSERT INTO `Wpisy` (`Nick`, `Data`, `Subject`, `Info`, `Display`) VALUES
('First', '2018-06-11 11:19:00', 'Semestr I', 'To jest mój pierwszy wpis dotyczący Semestr I', 1);
EOT;
  return $s;
}

?>
