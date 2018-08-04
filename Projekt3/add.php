<?php
  session_start();
  require_once(__DIR__."/PHP/MyDb.php");
  $OK = isset($_POST["NICK"]) && isset($_POST["SUBJ"]) && isset($_POST["INFO"]) && 
        isset($_SESSION[$sessionKEY]) && ($_SESSION[$sessionKEY] === $sessionVAL);
  
  if (!$OK){
    header("location: opinie.php");
  }

  //$NICK = $_POST["NICK"]; 
  //$SUBJ = $_POST["SUBJ"];
  //$INFO = $_POST["INFO"];
  
  $NICK = substr(trim($_POST["NICK"]),0,15);
  $SUBJ = substr($_POST["SUBJ"],0,10);
  $INFO = strip_tags(trim($_POST["INFO"]),"<p><strong>");
  
  $db = new mydb();

  $polecenie = $db->prepare("INSERT INTO Wpisy (Nick, Subject, Info) VALUES (?, ?, ?)");

/* Bind parameters. Types: s = string, i = integer, d = double,  b = blob */
  $polecenie->bind_param("sss", $NICK, $SUBJ, $INFO);

  $polecenie->execute();
  
  $polecenie->close();
  $db->close();
  $_SESSION = [];
  session_destroy();   
  session_unset();
  header("location: opinie.php");
?>
