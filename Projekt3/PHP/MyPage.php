<?php
$HEADER=<<<EOT
<!DOCTYPE html>
<html lang="pl">
<head>
  <meta charset="utf-8">
  <title>{{TITLE}}</title> 
  <meta name="description" content= "{{DESCRIPTION}}">
  <meta name="author" content="Marcin Kowalski">
  <meta name="viewport" content = "width=device-width, initial-scale=1.0"/>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.4/MathJax.js?config=TeX-MML-AM_CHTML">
  </script>
{{STYLES}}
</head>
<body>
EOT;
$FOOTER =<<<EOT
</body>
</html>   
EOT;

class MyPage{
	private $title = "";
	private $description  = "";
	private $cssfiles     = [];


	public function AddCSS($filename) {
    		$this->cssfiles[] = $filename;
 	}

	public function SetDescription($d) {
   		 $this->description = $d;
 	}

	public function __construct($title = "", $cssfile="") {
   		$this->title = $title;
        	$this->AddCSS($cssfile);
  	}
        
	public function Begin() {
		 global $HEADER;
    		 $s = str_replace(["{{TITLE}}", "{{DESCRIPTION}}"], [$this->title, $this->description], $HEADER);
		 $X = [];
   		 $C = $this->cssfiles;
   		 $TMP = '  <link rel="stylesheet" href="css/{{CSS}}">' . "\n";
    		 for ($i = 0; $i < count($C); $i++){
     			 $X[]= (string) str_replace(["{{CSS}}"], [(string) $C[$i]], $TMP);
    		 } 
    		 $s= str_replace("{{STYLES}}", join("\n",$X), $s);
		 return preg_replace('/^\h*\v+/m', '', $s);
	}

	public function End() {
       		global $FOOTER;
    		return $FOOTER;    
 	}  
}
?>
