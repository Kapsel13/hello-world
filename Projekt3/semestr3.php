<?php
require_once(__DIR__."/PHP/MyPage.php");
$OPIS="Podstrona  poświęcona trzeciemu semestrowi.";
$P=new MyPage("Marcin Kowalski: Semestr3","semestry.css");
$P->SetDescription($OPIS);
echo $P->Begin();
?>
<header id="H">
	<a href="index.php">
		<h1>Marcin Kowalski</h1>
		<h1>Moje przygody z edukacją</h1>
	</a>
	<h2>Semestr III</h2>
</header>
<nav>
	<div class="link">
	 <a href="index.php">Strona główna</a>
	</div>
	<div class="link">
	 <a href="opinie.php">Opinie</a>
	</div>
	<div class="link">
	 <a href="semestr1.php">Semestr I</a>
	</div>
	<div class="link">
	 <a href="semestr2.php">Semestr II</a>
	</div>
	<div class="link">
	 <a href="semestr4.php">Semestr IV</a>
	</div>
	<div class="link">
	 <a href="semestr5.php">Semestr V</a>
	</div>
	<div class="link">
	 <a href="hobby1.php">Kino</a>
	</div>
	<div class="link">
	 <a href="hobby2.php">Tenis ziemny</a>
	</div>
</nav>
<article>
      <h2>Technologia Programowania</h2>
      <section>
	<div class="row">
	<div class="learned">
		<h3>Czego się dowiedziałem?</h3>
		<ul>
		 <li>Co to są wzorce projektowe</li>
		 <li>Diagramy UML</li>
		 <li>Podstawy aplikacji mobilnych</li>
	        </ul>
	</div>
	<div class="to_learn">
	      <h3>Czego warto się douczyć ?</h3>
	      <ul>
		<li>Systemy kontroli jakości kodu</li>
		<li>Wzorce projektowe</li>
	      </ul>
	</div>
       </div>
     </section>
     <h2>Bazy danych i zarządzanie Informacją</h2>
     <section>
	<div class="row">
	<div class="learned">
		<h3>Czego się dowiedziałem?</h3>
		<ul>
			<li>Poznałem język SQL</li>
			<li>Jakie są operatory algebry relacji</li>
			<li>Jak operować bazą danych</li>
	        </ul>
	</div>
	<div class="to_learn">
	      <h3>Czego warto się douczyć ?</h3>
	      <ul>
		<li>Łączenia sql i javy</li>
	      </ul>
	</div>
      </div> 
     </section>
     <h2>Architektura komputerów i systemy operacyjne</h2>
     <section>
       <div class="row">
	<div class="learned">
	     <h3>Czego się dowiedziałem?</h3>
	     <ul>
		<li>Poznałem bramki logiczne:or,and,nor,nand</li>
		<li>Jakie są podstawowe elementy architektury komputera</li>
		<li>Jak wygląda struktura plików a także katalogów</li>
		<li>Jakie są problemy związane ze współbieżnością</li>
	     </ul>
	</div>
	<div class="to_learn">
	      <h3>Czego warto się douczyć ?</h3>
	      <ul>
		<li>Operacji na plikach i katalogach</li>
		<li>Działania procesów i zarządzania nimi</li>
	   </ul>
	</div>
      </div>
     </section>
    <h2>Metody Probabilistyczne i statystyka</h2>
    <section>
     <div class="row">
	<div class="learned">
	     <h3>Czego się dowiedziałem?</h3>
	     <ul>
		<li>Poznałem pojęcie przestrzeni probabilistycznej</li>
		<li>Co to jest niezależność zdarzeń</li>
		<li>Jak liczyć wartość oczekiwaną</li>
	   </ul>
       </div>
       <div class="to_learn">
	      <h3>Czego warto się douczyć ?</h3>
	      <ul>
		<li>Zgłębić pojęcie wartości oczekiwanej</li>
	      </ul>
	</div>
      </div>
      <div class="row_t">
	<div class="formula">
			<h3>Wartość oczekiwana</h3>
			$$EX=\sum \limits_{i=1}^n x_ip_i$$
	</div>
     </div>
    </section>
</article>   
<footer>
	<div class="return_to_top">
		<a href="#H">Up</a>
	</div>
</footer>
<?php
echo $P->End();
?>
