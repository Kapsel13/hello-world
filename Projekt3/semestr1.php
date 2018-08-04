<?php
require_once(__DIR__."/PHP/MyPage.php");
$OPIS="Podstrona  poświęcona pierwszemu semestrowi.";
$P=new MyPage("Marcin Kowalski: Semestr1","semestry.css");
$P->SetDescription($OPIS);
echo $P->Begin();
?>
<header id="H">
	<a href="index.php">
		<h1>Marcin Kowalski</h1>
		<h1>Moje przygody z edukacją</h1>
	</a>
	<h2>Semestr I</h2>
</header>
<nav>
	<div class="link">
	 <a href="index.php">Strona główna</a>
	</div>
	<div class="link">
	 <a href="opinie.php">Opinie</a>
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
	<h2>Analiza Matematyczna I</h2>
	<section>
       	  <div class="row">
		<div class="learned">
			<h3>Czego się dowiedziałem?</h3>
			<ul>
		  	  <li>Zapoznałem się z szeregami liczbowymi</li>
		 	   <li>Nauczyłem się pojęcia granicy funkcji</li>
		 	   <li>Wiem jak liczyć podstawowe pochodne i całki</li>
			 </ul>
		</div>
		<div class="to_learn">
			<h3>Czego warto się douczyć ?</h3>
			<ul>
		 	  <li>Liczenia zaawansowanych całek</li>
			   <li>Powtórzyć granicę funkcji</li>
			</ul>
		</div>
	    </div>
	    <div class="row_t">
		<div class="formula">
			<h3>Całkowanie przez części</h3>
			$$\int f(x)g'(x) \,dx=f(x)g(x)-\int f'(x)g(x) \,dx$$
		</div>
	    </div>
	</section>
	  <h2>Logika i struktury formalne</h2>
          <section>
	   <div class="row">
		<div class="learned">
			<h3>Czego się dowiedziałem?</h3>
			<ul>
		  	  <li>Poznałem pojęcie tautologii</li>
		  	  <li>Jakie są rodzaje kwantyfikatorów</li>
		 	   <li>Co to są dobre porządki</li>
			</ul>
		</div>
		<div class="to_learn">
			<h3>Czego warto się douczyć ?</h3>
			<ul>
		          <li>Moce zbiorów</li>
		          <li>Aksjomatyki Peano</li>
			</ul>
		</div>
	     </div>
	     <div class="row_t">
		<div class="formula">
			<h3>Prawa de'Morgana</h3>
			$$\lnot(x \land y) \iff (\lnot x \lor \lnot y)$$
			$$\lnot(x \lor y) \iff (\lnot x \land \lnot y)$$
		</div>
	     </div>
	</section>
	 <h2>Algebra z geometrią Analityczną</h2>
	 <section>
	  <div class="row">
		<div class="learned">
			<h3>Czego się dowiedziałem?</h3>
			<ul>
	   		 <li>Co to są grupy ,ciała.</li>
	   		 <li>Działania na macierzach</li>
			</ul>
		</div>	
		<div class="to_learn">
			<h3>Czego warto się douczyć ?</h3>
			<ul>
	      		  <li>Wartości własne i wektory własne macierzy</li>
	        	  <li>Eliminacja Gaussa</li>
			</ul>
		</div>	
	   </div>
	   <div class="row_t">
		<div class="formula">
			<h3>Wyznacznik iloczynu macierzy</h3>
			$$\det(A*B)=\det(A)*\det(B)$$
		</div>
	  </div>
	</section>
	 <h2>Wstęp do Informatyki i Programowania</h2>
         <section>
	   <div class="row">
		<div class="learned">
				<h3>Czego się dowiedziałem?</h3>
			<ul>
	   	 		<li>Poznałem podstawowe struktury danych: tablica ,stos,kolejka</li>
	   			<li>Na czym polega rekurencja</li>
	   	 		<li>Jak programować w języku C</li>
	   	 		<li>Co to są automaty skończone</li>
			</ul>	
		</div>
		<div class="to_learn">
				<h3>Czego warto się douczyć ?</h3>
			<ul>
	   			<li>Programowanie dynamiczne</li>
	   			<li>Programowanie przy użyciu rekurencji</li>
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
