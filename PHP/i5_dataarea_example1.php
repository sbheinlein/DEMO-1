<html>
<?php
	define("PAGE_TITLE", "i5_dataarea_call");
	define("PHP_FILE_NAME", "i5_dataarea_example1.php");
	# phpinfo();
?>

<title><?= PAGE_TITLE . " - " . PHP_FILE_NAME; ?></title>
<body>
<h1>Register for an Account:</h1>
<p>Input a first and last name you would like to enter into a data queue, and then the length of the string you 
would like to see returned and echoed to the screen</p>
<form action="i5_dataarea_example2.php" method="POST">
First Name: <input type="text" name="first" /> <br />
Last Name: <input type="text" name="last" /> <br />
Returned Data Area String <br>
Starting position of substring<input type="text" name="start"  /> <br />
Length of substring: <input type="text" name="length"  /> <br />
<input type="submit" value="GO" />
</form>

</body>
</html>