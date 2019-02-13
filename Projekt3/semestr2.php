<?php
require_once(__DIR__."/PHP/MyPage.php");
$OPIS="Podstrona  poświęcona drugiemu semestrowi.";
$P=new MyPage("Marcin Kowalski: Semestr2","semestry.css");
$P->SetDescription($OPIS);
echo $P->Begin();
?>
<header id="H">
	<a href="index.php">
		<h1>Marcin Kowalski</h1>
		<h1>Moje przygody z edukacją</h1>
	</a>
        <h2>Semestr II</h2>
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
	 <a href="semestr3.php">Semestr III</a>
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
	<h2>Problemy społeczne i zawodowe informatyki</h2>
	<section>
		<div class="row">
			<div class="learned">
				<h3>Czego się dowiedziałem?</h3>
				<ul>
					<li>Jakie są zasady prawa cywilnego</li>
					<li>Jak funkcjonuje system karny</li>
		 			<li>Co to jest prawo autorskie,co to jest prawo patentowe</li>
	        		</ul>
			</div>
			<div class="to_learn">
				<h3>Czego warto się douczyć ?</h3>
	      			<ul>
					<li>Zasady umów o dzieło,czy o pracę</li>
					<li>Ochrony własności intelektualnej</li>
	      			</ul>
			</div>
		</div>
	</section>
	<h2>Fizyka</h2>
	<section>
	  <div class="row">
		<div class="learned">
			<h3>Czego się dowiedziałem?</h3>
			<ul>
			  <li>Jakie pojęcia są związane z kinematyką</li>
	          	  <li>Prawo zachowania pędu i prawo zachowania energii</li>
		 	  <li>Poznałem pojęcie ruchu drgającego</li>
	      		</ul>
	 	</div>
	 	<div class="to_learn">
			  <h3>Czego warto się douczyć ?</h3>
	    		  <ul>
				<li>Zadania z równią pochyłą</li>
				<li>Pojęcia związane z fizyką kwantową</li>
	  		 </ul>
		</div>
	  </div>
	  <div class="row_t">
		<div class="formula">
			<h3>Definicja pędu</h3>
			$$\vec{p}=m\vec{v}$$
		</div>
	 </div> 
	</section>
	<h2>Kurs Programowania</h2>
	<section>
	  <div class="row">
		<div class="learned">
			<h3>Czego się dowiedziałem?</h3>
			<ul>
				<li>Poznałem programowanie obiektowe</li>
				<li>Jak programować w języku Java</li>
	   		</ul>
		</div>
	 	<div class="to_learn">
			<h3>Czego warto się douczyć ?</h3>
	      		<ul>
				<li>Dokumentacja kodu</li>
				<li>Stosowanie wątków</li>
				<li>Graficzny Interfejs Użytkownika</li>
	      		</ul>
	 	</div>
       	 </div>
	</section>	   
	<h2>Matematyka Dyskretna</h2>
	<section>
          <div class="row">
		<div class="learned">
			<h3>Czego się dowiedziałem?</h3>
	    		 <ul>
				<li>Co to jest wzór Stirlinga</li>
				<li>Własności permutacji</li>
				<li>Co to jest funkcja tworząca</li>
	   		</ul>
       		</div>
		<div class="to_learn">
			  <h3>Czego warto się douczyć ?</h3>
	    		  <ul>
				<li>Definitywnie zadań z funkcją tworzącą</li>
				<li>Rozwiązywania równań rekurencyjnych</li>
	   		</ul>
		</div>
	  </div>
	  <div class="row_t">
		<div class="formula">
			<h3>Wzór Stirlinga</h3>
			$$n!\approx \left(\frac{n}{e}\right)^n \sqrt{2 \pi n}$$
		</div>
	 </div>
	</section>    
	<h2>Analiza Matematyczna II</h2>
	<section>
	 <div class="row">
		<div class="learned">
			  <h3>Czego się dowiedziałem?</h3>
	  		  <ul>
				<li>Pochodne funkcji wielu zmiennych</li>
				<li>Całki podwójne</li>
	   		 </ul>
		</div>
		<div class="to_learn">
			<h3>Czego warto się douczyć ?</h3>
	  		<ul>
				<li>Całki krzywoliniowe</li>
	  		</ul>
		</div>
	</div>
	<div class="row_t">
		<div class="formula">
			<h3>Pochodna kierunkowa</h3>
			$$D_bf(a)=\lim\limits_{t \to 0^+}\frac{f(a+tb)-f(a)}{t}$$
		</div>
    	 </div>
	</section>	       
	<h2>Algebra Abstrakcyjna i kodowanie</h2>
	<section>
	 <div class="row">
		<div class="learned">
			<h3>Czego się dowiedziałem?</h3>
	    		<ul>
				<li>Bardziej dogłębnie poznałem pojęcie grupy</li>
				<li>Jakie są związki pomiędzy pierścieniami i ciałami</li>
				<li>Chińskie twierdzenie o resztach</li>
				<li>Co to są kody korekcyjne</li>
	   		</ul>
		</div>
		<div class="to_learn">
			<h3>Czego warto się douczyć ?</h3>
	   		<ul>
				<li>Kody Hamminga</li>
				<li>Wykrywanie i korekcja błędów</li>
	   		</ul>
		</div>
	 </div>
	 <div class="row_t">
		<div class="formula">
			<h3>Warstwa lewostronna i prawostronna grupy przez element</h3>
			$$aH=\lbrace ah:h \in H \rbrace$$
			$$Ha=\lbrace ha:h \in H \rbrace$$
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
