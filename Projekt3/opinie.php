<?php
require_once(__DIR__."/PHP/MyPage.php");
require_once(__DIR__."/PHP/MyDb.php");
session_start();
$_SESSION[$sessionKEY] = $sessionVAL;
$OPIS="Podstrona  poświęcona opiniom użytkowników";
$P=new MyPage("Marcin Kowalski: Opinie użytkowników","opinie.css");
$P->SetDescription($OPIS);
echo $P->Begin();
?>
<header id="H">
	<a href="index.php">
		<h1>Marcin Kowalski</h1>
		<h1>Moje przygody z edukacją</h1>
	</a>
	<h2>Opinie użytkowników</h2>
</header>
<nav>
	<div class="link">
	 <a href="index.php">Strona główna</a>
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
	<h2>Nowy wpis</h2>
	    <form method = "post" action="add.php">
		<div class="new_opinion">
			<div class="new_opinion_p1">
   				<div class="item_row">
   				 <label>Nick:</label>
   				 <input type= "text" name= "NICK" maxlength="15" placeholder="Podaj nick:" required>
  			        </div>
				<div class="item_row">
				 <label>Temat:</label>
				 <select name="SUBJ">
      				 <option value="S1">Semestr I</option>
      				 <option value="S2">Semestr II</option>
      				 <option value="S3">Semestr III</option>
     				 <option value="S4">Semestr IV</option>
     				 <option value="S5">Semestr V</option>
      				 <option value="mainpage">Strona główna</option>
      				 <option value="Kino">Kino</option>
      				 <option value="Tenis">Tenis ziemny</option>
    				 </select>
  			       </div>
			       <div class="button_row">
  					  <input type="submit" value="Dodaj wpis">
   				</div>
			</div>
			<div class="new_opinion_p2">
				<div class="item_row">
					<label>Opinia:</label>
  				</div>
				<div class="info_row">
    					<textarea name="INFO" rows="20" cols="70" placeholder="Podaj opinię:" required></textarea>
   				</div>
			</div>
		</div>	
	  </form>
	<h2>Aktualne wpisy</h2>
		 <table><tr><th>Nick</th><th>Data</th><th>Temat</th><th>Info</th></tr>
		<?php
		$TMPL = "<tr><td>{{NICK}}</td><td>{{DATE}}</td><td>{{SUBJ}}</td><td>{{INFO}}</td></tr>\n\n";
 		$mydb = new mydb();
  		$query    = "select * from Wpisy where Display = 1 order by Data DESC LIMIT 30;";
  		$result   = $mydb->query($query);

  		while (($row = $result -> fetch_assoc()) !== null) {
    			$kopiaTMPL = $TMPL;
    			$s= str_replace(
     			["{{NICK}}",  "{{DATE}}",       "{{SUBJ}}",    "{{INFO}}"],
      			[$row['Nick'],$row['Data'],Kody2Napisy($row['Subject']), $row['Info']], 
      			$kopiaTMPL);
    			echo $s;
  		}
  		$result->close();
  		$mydb->close();
		?>
		</table>
</article>
<footer>
	<div class="return_to_top">
		<a href="#H">Up</a>
	</div>
</footer>
<?php
echo $P->End();
?>
