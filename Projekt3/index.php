<?php
require_once(__DIR__."/PHP/MyPage.php");
$OPIS="Główna strona Marcina Kowalskiego poświęcona przygodom edukacyjnym.";
$P=new MyPage("Marcin Kowalski: edukacja","projekt1.css");
$P->SetDescription($OPIS);
echo $P->Begin();
?>
<header id="H">
<h1>Marcin Kowalski</h1>
<h1>Moje przygody z edukacją</h1>
<h2>Strona główna</h2>
</header>
<nav>
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
 <div class="column">
  <div class="info">
      <h3>Krótki opis mojej edukacji</h3>
         <p>&nbsp;&nbsp;W 2013 r. ukończyłem naukę w II Liceum Ogólnokształcącym we Wrocławiu. Bardzo dobrze wspominam spędzone tam 3 lata w klasie matematyczno-informatycznej.
         Po zdaniu matury postanowiłem zarekrutować się na kierunek Informatyka na Uniwersytecie Wrocławskim. Udało mi się to, jednak spędziłem na tej uczelni tylko jeden semestr.<br><br>&nbsp;&nbsp;
         Po pół roku postanowiłem tym razem, rozpocząć studia na wydziale WPPT w semetrze zimowym 2014/2015. Program studiów na WPPT okazał się bardziej mi odpowiadać i udaję mi
         się ,pomimo zdarzających się kursów powtórkowych, dążyć w kierunku zostania inżynierem.</p>
  </div>
  <div class="sides">
	<h3>Semestry</h3>
	<p>&nbsp;&nbsp;Na stronie głównej umieściłem linki do podstron z opisem semestrów w których realizowałem kursy podczas mojej przygody edukacyjnej na PWR:</p>
	<ul>
	  <li>Semestr I</li>                
	  <li>Semestr II</li>
	  <li>Semestr III</li>
	  <li>Semestr IV</li>
	  <li>Semestr V</li>
	</ul>
	 <p>&nbsp;&nbsp;Na każdej podstronie znajdują się, oprócz nazwy kursu który realizowałem w danym semsestrze, także inne elementy tak jak np: lista pojęć których się nauczyłem na danym semestrze ,a 		także lista pojęć ,których muszę się douczyć.</p>
   </div>
   <div class="sides">
	<h3>Hobby</h3>
	<p>&nbsp;&nbsp;Na stronie głównej umieściłem linki do podstron z opisem moich hobby:</p>
	<ul>
	  <li>Kino lat 70-tych i 80-tych</li>
	  <li>Tenis ziemny</li>
	</ul>
	<p>&nbsp;&nbsp;Na obydwu podstronach umieściłem krótki opis mojego hobby, oprócz tego znajdują się tam też informacje dotyczace konkretnego hobby jak np. opis filmu czy krótka charakterystyka
	danego gracza tenisowego. Poza tym dodałem też na każdej podstronie po kilka zdjęć.</p>
  </div>
   <div class="sides">
	<h3>Opinie</h3>
	<p>&nbsp;&nbsp;Na stronie głównej umieściłem link do podstrony gdzie użytkownicy mogą wyrazić swoją opinie na temat portalu:</p>
	<ul>
	    <li>Opinie</li>
	</ul>
	<p>&nbsp;&nbsp;Na podstronie użytkownik może wyrazić opinie o każdej podstronie portalu i dodać ją do aktulalnych opini innych użytkowników.</p>
  </div>
 </div>
 <img src="s" id="myimage" alt="MyPhoto">                                            
 <img src="img/pwr2.jpg" alt="Pwr">                          
</article>
<footer>
	<div class="return_to_top">
		<a href="#H">Up</a>
	</div>
</footer>	
<script>
function getImage(url){
    return new Promise (
      function(resolve, reject) {
        var img = new Image()
        img.onload  = function(){ resolve(url); }
        img.onerror = function(){ reject(url);  }
        img.src     = url
      }
    )
}
function onSuccess(url) { document.getElementById('myimage').src = url;}
function onFailure(url) { console.log('Error loading ' + url)}
//ładujemy obrazek za pomocą obietnic
getImage('img/marcin.jpg').then(onSuccess, onFailure);
</script>
<?php
echo $P->End();
?>
