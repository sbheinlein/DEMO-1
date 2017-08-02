<html>
<?php
	define("PAGE_TITLE", "i5_fetch_example");
	define("PHP_FILE_NAME", "i5_fetch_example.php")
?>

<title><?= PAGE_TITLE . " - " . PHP_FILE_NAME; ?></title>

<?php
/* Connect to server */
$conn = i5_connect("localhost", "PHPUSER", "PASSW0RD");
if (!$conn) die("<br>Connection failed. Error number =".i5_errno()." msg=".i5_errormsg()); 

$file = i5_open("I5SCHEMA/EMPLOYEE", I5_OPEN_READ);
if (!$file) die("Error occurred while attempting to open file I5SCHEMA/EMPLOYEE mode=READ");

$rec = i5_fetch_row($file, I5_READ_FIRST);
if (!$rec) die("Error using i5_fetch_row command with I5_READ_FIRST option");
echo "Output of i5_fetch_row command with I5_READ_FIRST option:<br>";
echo var_dump($rec)."<br><br>";

$rec = i5_fetch_assoc($file, I5_READ_LAST);
if (!$rec) die("Error using i5_fetch_assoc command with I5_READ_LAST option");
echo "Output of i5_fetch_assoc command with I5_READ_LAST option:<br>";
echo var_dump($rec)."<br><br>";

$rec = i5_fetch_array($file, I5_READ_PREV);
if (!$rec) die("Error using i5_fetch_array command with I5_READ_PREV option");
echo "Output of i5_fetch_array command with I5_READ_PREV option:<br>";
echo var_dump($rec)."<br><br>";

$rec = i5_fetch_object($file, I5_READ_NEXT);
if (!$rec) die("Error using i5_fetch_object command with I5_READ_NEXT option");
echo "Output of i5_fetch_object command with I5_READ_NEXT option:<br>";
echo var_dump($rec)."<br><br>";

i5_close($conn);
?>