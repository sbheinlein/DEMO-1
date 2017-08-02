<html>
<?php
	define("PAGE_TITLE", "i5_field_example2");
	define("PHP_FILE_NAME", "i5_field_example2.php")
?>

<title><?= PAGE_TITLE . " - " . PHP_FILE_NAME; ?></title>

<?php
/* Connect to server */
$conn = i5_connect("localhost", "PHPUSER", "PASSW0RD");
if (!$conn) die("<br>Connection failed. Error number =".i5_errno()." msg=".i5_errormsg()); 

$file = i5_open("I5SCHEMA/EMPLOYEE", I5_OPEN_READ);
if (!$file) die("Error occurred while attempting to open file I5SCHEMA/EMPLOYEE mode=READ");

$list = i5_list_fields($file);
if (!$list) die("Error retrieving file/record information using i5_info API");
echo "Output of i5_list_fields APIs:<br>";
print "List of fields = ".$list."<br>";
echo var_dump($list)."<br><br>";

$numFields = i5_num_fields($file);
if (!$numFields) die("Error retrieving file/record information using i5_info API");
echo "Output of i5_num_fields API:<br>";
print "Number of fields = ".$numFields."<br><br>";

$rec = i5_fetch_row($file, I5_READ_FIRST);
if (!$rec) die("Error using i5_fetch_row command with I5_READ_FIRST option");
$result = i5_result($file, 3);
if (!$result) die("Error retrieving file/record information using i5_info API");
echo "Output of i5_result API - field = 3:<br>";
print "Value of field 3 (LASTNAME) = ".$result."<br><br>";

$result = i5_result($file, "WORKDEPT");
if (!$result) die("Error retrieving file/record information using i5_info API");
echo "Output of i5_result API - field = \"WORKDEPT\":<br>";
print "Value of field WORKDEPT = ".$result."<br><br>";

i5_close($conn);
?>