<html>
<?php
	define("PAGE_TITLE", "i5_program_call");
	define("PHP_FILE_NAME", "i5_program_call_example1.php");
	# phpinfo();
?>

<title><?= PAGE_TITLE . " - " . PHP_FILE_NAME; ?></title>
<body>
<h1>Register for an Account:</h1>
<p>Input a first and last name and an initial amount. The I5SCHEMA/INCRAMT CL program will set the account name 
to the last name, increment the amount entered by 42.22, and return. The resulting values are echoed to the screen.</p>
<form action="i5_program_call_example2.php" method="POST">
First Name: <input type="text" name="first" /> <br />
Last Name: <input type="text" name="last" /> <br />
Amount: <input type="text" name="amount"  /> <br />
<input type="submit" value="GO" />
</form>
</body>
</html>