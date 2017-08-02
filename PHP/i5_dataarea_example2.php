<html>
<?php
	define("PAGE_TITLE", "i5_dataarea");
	define("PHP_FILE_NAME", "i5_dataarea_example2.php")
?>

<title><?= PAGE_TITLE . " - " . PHP_FILE_NAME; ?></title>

<?php
/* Connect to server */
$conn = i5_connect("localhost", "PHPUSER", "PASSW0RD");
if (!$conn) die("<br>Connection failed. Error number =".i5_errno()." msg=".i5_errormsg()); 
$inputString = "'".$_POST["first"]." ".$_POST["last"]."'";
$start = intval($_POST["start"]);
$length = intval($_POST["length"]);
/* Create Data Area, write data to it, and then read data written */
if (i5_data_area_create("I5SCHEMA/DA", 256)) {
  if (i5_data_area_write("i5schema/da", $inputString, 1, 50)) {
   	$outputString =i5_data_area_read("I5SCHEMA/DA", $start, $length);
    echo "Data read from data queue = ".$outputString;
  }
  else {
    echo "<br>i5_data_area_write error";
    echo var_dump(i5_error());
  }
}
else {
  echo "<br>i5_data_area_create error";
  echo var_dump(i5_error());
}
/* Delete data area */
i5_data_area_delete("i5schema/da");
/* Close connection */
i5_close($conn);
?>