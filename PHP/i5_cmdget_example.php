<html>
<?php
	define("PAGE_TITLE", "i5_cmdget");
	define("PHP_FILE_NAME", "i5_cmdget_example.php")
?>

<title><?= PAGE_TITLE . " - " . PHP_FILE_NAME; ?></title>
<?php

/* Connect to server */
$conn = i5_connect("localhost", "PHPUSER", "PASSW0RD");
if (i5_command("rtvjoba", array(), array("curlib" => "curl",
		"user"=>"user",
		"usrlibl" => "userlib",
		"syslibl" => array("syslib", "char(165)")))) 
{
	$user2 = i5_cmdget("user");
	$curlib2 = i5_cmdget("curl");
	$userlib2 = i5_cmdget("userlib");
	$syslib2 = i5_cmdget("syslib");
	print "<h1><b>Results of \"rtvobja\" command using i5_cmdget</b></h1><br>" ;
	print "User : $user2<br>" ;
	print "User library : $userlib2<br>" ;
	print "System library list : $syslib2<br>" ;
	print "Current library : $curlib2<br>" ;
}
else {
  print var_dump(i5_error());
}

/* Close connection */
i5_close($conn);
?>