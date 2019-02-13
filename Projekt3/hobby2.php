<?php
require_once(__DIR__."/PHP/MyPage.php");
$OPIS="Podstrona poświęcona drugiemu hobby.";
$P=new MyPage("Marcin Kowalski: Tenis ziemny","hobby2.css");
$P->SetDescription($OPIS);
echo $P->Begin();
?>
<header id="H">
	<a href="index.php">
		<h1>Marcin Kowalski</h1>
		<h1>Moje przygody z edukacją</h1>
	</a>
	<h2>Tenis ziemny</h2>
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
	 <a href="semestr5.php">Semestr V</a>
	</div>
	<div class="link">
	 <a href="hobby1.php">Kino</a>
	</div>
</nav>
 <article>
  <div class="description">
  <p>Jestem osobą ,która uprawia wiele sportów, jednak tenis jest jednym z moich ulubionych. Bardzo lubię zarówno grać w tenisa, jak
  i oglądać turnieje w telewizji czy internecie. Praktycznie przez cały rok śledzę rozgrywki tenisowe. Poniżej opiszę graczy, których cenię, a także
  najważniejsze turnieje tenisowe, które mam niekłamaną przyjemność oglądać.</p>
  </div>
  <div class="column">
	<div class="info">
		<h3>Roger Federer</h3>
                <p>&nbsp;&nbsp;Jeden z najlepszych, przez niektórych (także przeze mnie), uznawany za najepszego tenisistów w historii.
		Federer zdobył najwięcej turniejów wielkoszlemowych (najbardziej prestiżowe turnieje tenisowe) spośród kiedykolwiek grających zawodników. Wygrał także wiele mniej prestiżowych turniejów.
		<br><br>&nbsp;&nbsp;Jestem jego fanem  nie tylko ze względu na osiągnięcia, ale przede wszystkim z powodu jego stylu gry. Federer bowiem w przeciwieństwie do innych graczy nie używa 			niesamowitej siły przy uderzaniu piłki, tylko używa techniki, a tę ma wspaniałą. Jest znany z częstego grania przy siatcę, a także ze świetnego serwisu. Czasami potrafi zaskoczyć 			przeciwnika technicznym dropszotem(uderzeniem po ktorym piłka spada tuż za siatkę). Jego ulubioną nawierzchnią są korty trawiaste, a ulubionym turniejem Wimbledon, który wygrał 		siedmiorotnie.</p>
	</div>
        <div class="info">
		<h3>Rafael Nadal</h3>
           	<p>&nbsp;&nbsp;Uznawany za najlepszego tenisistę w historii na kortach ziemnych.
		Nadal pochodzi z Hiszpani, i tak jak większość jego rodaków uprawiających ten sport, jest mistrzem w grze z głębi kortu. Jednak to co go zawsze wyróżniało z poza grona innych graczy to 
		niezwykła waleczność i wola walki. W meczach z tym zawodnikiem inni gracze nigdy nie mogą być pewni zwycięstwa w danej wymianie nawet przy ewidentnej przewadzę sytuacyjnej. Nadal jest także
		znany z tego, że wielokrotnie po dłuższej kontuzji potrafił wrócić do formy i grać nawet lepiej niż wcześniej.<br><br>&nbsp;&nbsp;Jak już wspominałem jego ulubioną nawierzchnią jest 			nawierzchnia ziemna. Hiszpan  jest rekordzistą jeśli chodzi o największą liczbę zwyciestw w pojedynczym turnieju wielkoszlemowym. 10 razy wygrał bowiem Roland Garros, a więc wielkiego 		Szlema rozgrywanego w Paryżu (oczywiście na korcie ziemnym).</p>
	</div>
        <div class="info">
		<h3>Steffi Graff</h3>
		<p>&nbsp;&nbsp;Niemiecka tenisistka, jedna z najlepszych zawodniczek w historii.
		Graff dominowała w kobiecym tenisie pod koniec lat 80-tych i do połowy lat 90-tych. Ustanowiła wiele rekordów jednak najbardziej przeze mnie cenionym był tzw. "złoty wielki szlem". 			Zdarzenie to miało miejsce w 1988 roku. Mianowicie niemiecka zawodniczka wygrała w jednym roku wszystkie turnieje wielkoszlemowe (Australian Open, Roland Garros, Wimbledon i UsOpen), a 			oprócz tego zdobyła złoto olimpijskie na igrzyskach w Seulu.<br><br>&nbsp;&nbsp;Steffi Graf wyszła za mąż za innego wielkiego tenisistę Andre Agassiego. Obecnie wspólnie z mężem prowadzi 			akademię tenisową.
		</p>
	</div>
        <div class="info">
		<h3>Australian Open</h3>
		<p>&nbsp;&nbsp;Pierwszy z turniejów wielkoszlemowych, rozgrywany w drugiej połowie stycznia w Melbourne w Australii.
		Niegdyś turniej był rozgrywany na nawierzchnie trawiastej, jednak od kilkudziesięciu lat rozgrywany jest na nawierzchni asfaltowej. Podczas tego turnieju często zdarza się, że zawodniczki 			lub zawodnicy mają problemy z kontynuowaniem spotkania ze względu na bardzo wysokie temperatury, sięgające 40 stopni w cieniu.<br><br>&nbsp;&nbsp;Turniej jest godny uwagi ze względu na 			to, że często zwycięzca czy zwyciężczni tego turnieju dominuje w dalszej części sezonu.</p>
	</div>
        <div class="info">
		<h3>Roland Garros</h3>
		<p>&nbsp;&nbsp;Drugi z turniejów wielkoszlemowych, rozgrywany w Paryżu na przełomie maja i czerwca.
		Turniej rozgrywany jest na kortach ziemnych. Ogólnie ten turniej jest jednym z moich ulubionych, ale ma swoje minusy. Jako najważniejszy mogę podać brak dachu nad głównym kortem. Niestety 			w Paryżu podczas turnieju często pada, co powoduje duże opóźnienia w grze i transmisjach telewizyjnych. Jednak na szczęście jego budowa jest przewidziana za 				   			kilka lat.<br><br>&nbsp;&nbsp;Mogę jeszcze dodać, że urodziny podczas turnieju obchodzi Rafael Nadal co często zbiega się z jego zwycięstwami w tym turnieju.</p>
	</div>
        <div class="info">
		<h3>Wimbledon</h3>
		<p>&nbsp;&nbsp;Trzeci z turniejów wielkoszlemowych, rozgrywany w Londynie na przełomie czerwca i lipca.
		Nastarszy turniej tenisowy, rozgrywany od 1877r. na nawierzchni trawiastej. Jest moim ulubionym turniejem, pełnym tradycji i elegancji. Na korcie tenisiści i tenisistki grają ubrani w 		obowiązkowe białe stroje, publiczność jest w większości ubrana w eleganckie stroje, tak jak sędziowie.<br><br>&nbsp;&nbsp; Od 2009 roku nad kortem głównym wznosi się dach, co umożliwia grę 			na tym korcie podczas deszczu. Często zdarza się, że na mecze finałowe przybywają członkowie rodziny królewskiej.</p>
	</div>
        <div class="info">
		<h3>UsOpen</h3>
		<p>&nbsp;&nbsp;Ostatni z turniejów wielkoszlemowych, rozgrywany w Nowym Jorku na przełomie sierpnia i września.
		Podobie jak w Australian Open, w UsOpen również gra się na asfalcie. Turniej charakteryzuje sie największą pulą pienieżną za zwycięstwo. Niestety, ponieważ jest rozgrywany w USA, 			najważniejsze mecze są transmitowane o 1 w nocy co nie pomaga w ich oglądaniu.<br><br>&nbsp;&nbsp;Co ciekawe, w UsOpen w przeciwieństwie do innych turniejów wielkoszlemowych, w piątym 		secie rozgrywany jest tie-break, co ma na celu skrócenie meczów, które nie rzadko trwają nawet ponad 5 godzin.</p>
	</div>
     </div>
	<img src="img/federer.jpg" alt="federer">
	<img src="img/nadal.jpg" alt="nadal">
	<img src="img/graff.jpg" alt="graff">
	<img src="img/ausopen.jpg" alt="ausopen">
	<img src="img/roland_garros.jpg" alt="roland_garros">
	<img src="img/wimbledon.jpg" alt="wimbledon">
	<img src="img/usopen.jpg" alt="usopen">
</article>
<footer>
	<div class="return_to_top">
		<a href="#H">Up</a>
	</div>
</footer>
<?php
echo $P->End();
?>
