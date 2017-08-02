<html>
<?php
	define("PAGE_TITLE", "i5_field_example1");
	define("PHP_FILE_NAME", "i5_field_example1.php")
?>

<title><?= PAGE_TITLE . " - " . PHP_FILE_NAME; ?></title>

<?php
/* Connect to server */
$conn = i5_connect("localhost", "PHPUSER", "PASSW0RD");
if (!$conn) die("<br>Connection failed. Error number =".i5_errno()." msg=".i5_errormsg()); 

$file = i5_open("I5SCHEMA/EMPLOYEE", I5_OPEN_READ);
if (!$file) die("Error occurred while attempting to open file I5SCHEMA/EMPLOYEE mode=READ");

$fieldName = i5_field_name($file, 0);
$fieldType = i5_field_type($file, 0);
$fieldLen = i5_field_len($file, 0);
$fieldScale = i5_field_scale($file, 0);
#if (!$fieldType) die("Error retrieving field #0 type information using i5_field_type API");
echo "Output of i5_field APIs - using field value 0<br>EMPNO - CHARACTER(6):<br>";
print "Field Name = ".$fieldName."<br>Field Type = ".$fieldType."<br>Field Length = ".$fieldLen."<br>Field Scale = ".$fieldScale."<br><br>";

$fieldName = i5_field_name($file, 1);
$fieldType = i5_field_type($file, 1);
$fieldLen = i5_field_len($file, 1);
$fieldScale = i5_field_scale($file, 1);
#if (!$fieldType) die("Error retrieving field #1 type information using i5_field_type API");
echo "Output of i5_field APIs - using field value 1<br>FIRSTNME - VARCHAR(12):<br>";
print "Field Name = ".$fieldName."<br>Field Type = ".$fieldType."<br>Field Length = ".$fieldLen."<br>Field Scale = ".$fieldScale."<br><br>";

$fieldName = i5_field_name($file, "EDLEVEL");
$fieldType = i5_field_type($file, "EDLEVEL");
$fieldLen = i5_field_len($file, "EDLEVEL");
$fieldScale = i5_field_scale($file, "EDLEVEL");
if (!$fieldType) die("Error retrieving field \"EDLEVEL\" type information using i5_field_type API");
echo "Output of i5_field APIs - using UPPERCASE field value \"EDLEVEL\"<br>EDLEVEL - SMALLINT:<br>";
print "Field Name = ".$fieldName."<br>Field Type = ".$fieldType."<br>Field Length = ".$fieldLen."<br>Field Scale = ".$fieldScale."<br><br>";

$fieldName = i5_field_name($file, "hiredate");
$fieldType = i5_field_type($file, "hiredate");
$fieldLen = i5_field_len($file, "hiredate");
$fieldScale = i5_field_scale($file, "hiredate");
if (!$fieldType) die("Error retrieving field \"hiredate\" type information using i5_field_type API");
echo "Output of i5_field APIs - using lowercase field value \"hiredate\"<br>HIREDATE - DATE:<br>";
print "Field Name = ".$fieldName."<br>Field Type = ".$fieldType."<br>Field Length = ".$fieldLen."<br>Field Scale = ".$fieldScale."<br><br>";

$fieldName = i5_field_name($file, 11);
$fieldType = i5_field_type($file, 11);
$fieldLen = i5_field_len($file, 11);
$fieldScale = i5_field_scale($file, 11);
#if (!$fieldType) die("Error retrieving field #11 type information using i5_field_type API");
echo "Output of i5_field APIs - using field value 11 <br>SALARY - DECIMAL(9,2):<br>";
print "Field Name = ".$fieldName."<br>Field Type = ".$fieldType."<br>Field Length = ".$fieldLen."<br>Field Scale = ".$fieldScale."<br><br>";

i5_close($conn);
?>