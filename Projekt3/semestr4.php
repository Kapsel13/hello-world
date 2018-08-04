<?php
require_once(__DIR__."/PHP/MyPage.php");
$OPIS="Podstrona  poświęcona czwartemu semestrowi.";
$P=new MyPage("Marcin Kowalski: Semestr4","semestry.css");
$P->SetDescription($OPIS);
echo $P->Begin();
?>
<header id="H">
	<a href="index.php">
		<h1>Marcin Kowalski</h1>
		<h1>Moje przygody z edukacją</h1>
	</a>
        <h2>Semestr IV</h2>
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
	 <a href="semestr3.php">Semestr III</a>
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
	<h2>Algorytmy i struktury danych</h2>
	<section>
	 <div class="row">
	 <div class="learned">
	   <h3>Czego się dowiedziałem?</h3>
	   <ul>
		<li>Poznałem algorytmy sortowania</li>
		<li>Jakie są rodzaje złożoności asymptotycznej</li>
		<li>Co to są drzewa czerwono-czarne</li>
		<li>Operację na kopcu</li>
	   </ul>
	</div>
	<div class="to_learn">
	      <h3>Czego warto się douczyć ?</h3>
	      <ul>
		<li>Kodowanie Hufmana</li>
		<li>Operacje usuwania w drzewie binarnym</li>
		<li>Algorytm Prima i Kruskala</li>
	      </ul>
	 </div>
       </div>
      </section>
      <h2>Technologie Sieciowe</h2>
      <section>
	<div class="row">
	<div class="learned">
	   <h3>Czego się dowiedziałem?</h3>
	   <ul>
		<li>Jak wygląda wymiana danych w sieci Ethernet</li>
		<li>Jakie znamy protokoły sieciowe</li>
	   </ul>
	</div>
	<div class="to_learn">
	      <h3>Czego warto się douczyć ?</h3>
	      <ul>
		<li>Jak tworzyć systemy sieciowe klient-serwer</li>
	      </ul>
	</div>
       </div> 
      </section>
      <h2>Programowanie w logice</h2>
      <section>
       <div class="row">
	<div class="learned">
	   <h3>Czego się dowiedziałem?</h3>
	   <ul>
		<li>Poznałem programowanie w języku Prolog</li>
		<li>Poznałem podstawy gramatyk bezkontekstowych</li>
	   </ul>
        </div>
	<div class="to_learn">
	      <h3>Czego warto się douczyć ?</h3>
	      <ul>
		<li>Używanie korutyn w Prologu</li>
	      </ul>
	</div>
       </div>
      </section>  
      <h2>Algorytmy równoległe</h2>
      <section>
       <div class="row">
	<div class="learned">
	   <h3>Czego się dowiedziałem?</h3>
	   <ul>
		<li>Co to jest model PRAM,EREW,CREW</li>
		<li>Jak wygląda metoda cyklu Eulera</li>
		<li>Co to jest sieć bitoniczna</li>
	   </ul>
	</div>
	<div class="to_learn">
	      <h3>Czego warto się douczyć ?</h3>
	      <ul>
		<li>Poznać jeszcze inne ciekawe algorymty równoległe</li>
	   </ul>
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
