<html>
<?php
	define("PAGE_TITLE", "i5_systemvalue");
	define("PHP_FILE_NAME", "i5_systemvalue_example.php")
?>

<title><?= PAGE_TITLE . " - " . PHP_FILE_NAME; ?></title>

<?php
/* Connect to server */
$conn = i5_connect("localhost", "PHPUSER", "PASSW0RD");
if (!$conn) die("<br>Connection failed. Error number =".i5_errno()." msg=".i5_errormsg()); 
/* Retrieve System DATE value */
print "Date is: ".i5_get_system_value("QDATE");
/* Close connection */
i5_close($conn);
?>