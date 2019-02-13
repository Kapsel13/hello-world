<?php
require_once(__DIR__."/PHP/MyPage.php");
$OPIS="Podstrona  poświęcona piątemu semestrowi.";
$P=new MyPage("Marcin Kowalski: Semestr5","semestry.css");
$P->SetDescription($OPIS);
echo $P->Begin();
?>
<header id="H">
	<a href="index.php">
		<h1>Marcin Kowalski</h1>
		<h1>Moje przygody z edukacją</h1>
	</a>
	<h2>Semestr V</h2>
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
	 <a href="semestr4.php">Semestr IV</a>
	</div>
	<div class="link">
	 <a href="hobby1.php">Kino</a>
	</div>
	<div class="link">
	 <a href="hobby2.php">Tenis ziemny</a>
	</div>
</nav>
<article>
	<h2>Programowanie Zespołowe</h2>
	<section>
	<div class="row">
	<div class="learned">
	   <h3>Czego się dowiedziałem?</h3>
	   <ul>
		<li>Podstaw gita i operacji na lokalnym repozytorium</li>
		<li>Jak współpracować w obrębie tworzenia projektu</li>
	   </ul>
        </div>
	<div class="to_learn">
	      <h3>Czego warto się douczyć ?</h3>
	      <ul>
		<li>Pogłębić wiedzę na temat gita i systemów kontroli wersji</li>
		<li>Poznać takie narzędzia jak Trello czy slack</li>
	   </ul>
	</div>
       </div>
      </section>
      <h2>Obliczenia naukowe</h2>
      <section>
       <div class="row">
	<div class="learned">
	   <h3>Czego się dowiedziałem?</h3>
	   <ul>
		<li>Co to jest epsilon maszynowy</li>
		<li>Jakie znamy arytmetyki zmiennopozycyjne</li>
		<li>Co to jest zadanie źle uwarunkowane</li>
		<li>Jak wygląda interpolacja wielomianowa</li>
		<li>Jak korzystać z eliminacji Gaussa do rozwiązywania układów równań</li>
	   </ul>
	</div>
	<div class="to_learn">
	      <h3>Czego warto się douczyć ?</h3>
	      <ul> 
		<li>Rozkład LU</li>
		<li>Aproksymacja średniokwadratowa</li>
		<li>Oceniania numerycznej poprawności algorytmów</li>
	   </ul>
	</div>
       </div> 
      </section> 
      <h2>Języki formalne i techniki translacji</h2>
      <section>
       <div class="row">
	<div class="learned">
	   <h3>Czego się dowiedziałem?</h3>
	   <ul>
		<li>Co to jest język regularny,bezkontekstowy</li>
		<li>Jak udowadniać ,ze język nie jest regularny lub nie jest bezkontekstowy</li>
		<li>Jak wygląda postać normalna Chomskiego i Greibach</li>
		<li>Co to jest parser operatorowy,LL(1),LR(1),LALR</li>
	   </ul>
	</div>
	<div class="to_learn">
		<h3>Czego warto się douczyć ?</h3>
	      <ul>   
		<li>Warto zdecydowanie przerobić konstrukcję automatów minimalnych</li>
		<li>Zdecydowanie nauczyć się tworzenia gramatyk bezkontekstowych</li>
	   </ul>
	</div>
       </div>  
      </section>
      <h2>Systemy wbudowane</h2>
      <section>
       <div class="row">
	<div class="learned">
		<h3>Czego się dowiedziałem?</h3>
	   <ul>
		<li>Poznałem budowę procesora</li>
		<li>Jak tworzyć układy za pomocą języka vhdl</li>
		<li>Jakie są techniki szeregowania zadań</li>
	   </ul>
        </div>
	<div class="to_learn">
		<h3>Czego warto się douczyć ?</h3>
	      <ul>   
		<li>Pogłębić wiedzę na temat vhdl-a</li>
		<li>Poczytać o budowie procesora</li>
	      </ul>
	</div>
       </div>
      </section>   
      <h2>Topologia</h2>
      <section>
       <div class="row">
	<div class="learned">
		<h3>Czego się dowiedziałem?</h3>
	   <ul>
		<li>Poznałem przestrzenie metryczne</li>
		<li>Co to są zbiory zwarte,otwate,domknięte</li>
		<li>Sigma algebry i algebry zbiorów</li>
		<li>Miara Lebes'quea</li>
	   </ul>
	</div>
	<div class="to_learn">
		<h3>Czego warto się douczyć ?</h3>
	      <ul>      
		<li>Zgłębić pojęcie całki w przestrzeniach mierzalnych</li>
		<li>Poczytać o twierdzeniu Fubiniego</li>
	     </ul>
	</div>
      </div>
      <div class="row_t">
	<div class="formula">
			<h3>Brzeg zbioru</h3>
			$$Fr(A)=\overline{A} \cap \overline{A^c}$$
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
