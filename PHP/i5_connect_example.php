<html>
<?php
	define("PAGE_TITLE", "i5_connect");
	define("PHP_FILE_NAME", "i5_connect_example.php")
?>

<title><?= PAGE_TITLE . " - " . PHP_FILE_NAME; ?></title>

<?php
/* Connect to server */
$conn1 = i5_connect("127.0.0.1", "PHPUSER", "PASSW0RD") || 
	die("<br>Connection using 127.0.0.1 with uppercase USERID and PASSWORD failed. Error number =".i5_errno()." msg=".i5_errormsg())."<br>"; 
echo "<br>Connection using 127.0.0.1 with uppercase USERID and PASSWORD OK!<br>\n";

/* Connect to server */
$conn = i5_connect("127.0.0.1", "phpuser", "passw0rd") || 
	die("<br>Connection using 127.0.0.1 with lowercase userid and password failed. Error number =".i5_errno()." msg=".i5_errormsg())."<br>"; 
echo "<br>Connection using 127.0.0.1 with lowercase userid and password OK!<br>\n";

/* Connect to server */
$conn = i5_connect("localhost", "PHPUSER", "PASSW0RD");
if (!$conn)
	die("<br>Connection using \"localhost\" with uppercase USERID and PASSWORD failed. Error number =".i5_errno()." msg=".i5_errormsg())."<br>"; 
else 
	echo "<br>Connection using \"localhost\" with uppercase USERID and PASSWORD OK!<br>\n";
	
/* Connect to server */
$conn = i5_connect("localhost", "phpuser", "passw0rd");
if (!$conn) 
	echo "<br>Connection using localhost with lowercase userid and password failed. Error number =".i5_errno()." msg=".i5_errormsg()."<br>"; 
else
	echo "<br>Connection using \"localhost\" with lowercase userid and password OK!<br>\n";

/* Connect to server */
$conn = i5_connect("<i5_system>", "PHPUSER", "PASSW0RD");
if (!$conn) 
	echo "<br>Connection using <i5_system> failed. Error number =".i5_errno()." msg=".i5_errormsg()."<br>"; 
else
	echo "<br>Connection using System Name <i5_system> OK!<br>\n";

/* Connect to server */	
$conn = i5_connect("<i5_system>.RCHLAND.IBM.COM", "PHPUSER", "PASSW0RD");
if (!$conn) 
	echo "<br>Connection using <i5_system>.<xxxxxxxx>.IBM.COM failed. Error number =".i5_errno()." msg=".i5_errormsg()."<br>"; 
else
	echo "<br>Connection using System Name <i5_system>.<xxxxxxxx>.IBM.COM OK!<br>\n";
	
/* Connect to server */
$conn = i5_connect("9.x.xxx.xxx", "PHPUSER", "PASSW0RD");
if (!$conn) 
	echo "<br>Connection using IP address 9.x.xxx.xxx failed. Error number =".i5_errno()." msg=".i5_errormsg()."<br>"; 
else 
	echo "<br>Connection using IP address 9.x.xxx.xxx OK!<br>\n";

?>