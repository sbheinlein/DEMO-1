<?php 
define("PAGE_TITLE","Registration");
?>
<html>
<title><?= PAGE_TITLE ?></title>
<body>

<p>You entered :</p>
<?php

function checkPassword($p1,$p2){
	if ($p1==$p2) 
		return "OK";
	else return "Nok";
	}

$form_names = array_keys($_POST);
$form_values = array_values($_POST);
foreach ($_POST as $key=>$value) {
	echo "<p>".$key."=".$value."</p>";
}
$pwd[0] = $_POST["pword"][0];
$pwd[1] = $_POST["pword"][1];
echo "<p>Password = '" . $pwd[0] . "'</p>";
echo "<p>Password2 = \"" . $pwd[1] . "\"</p>";
//echo "<p>Password = " . $password . "</p>";

 echo "<p> Password".checkPassword($pwd[0],$pwd[1]). "</p>";
?>
</body>
</html>