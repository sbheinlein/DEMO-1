<html>
<?php
define("PAGE_TITLE", "db223_ apis");
define("PHP_FILE_NAME", "db2_connect_example.php")
?>

<title><?= PAGE_TITLE . " - " . PHP_FILE_NAME; ?></title>
<body>
<?php 

/* Set up connection for each pass through this application */
$user='PHPUSER';
$password='PASSW0RD';
$db='I520002';
$dbh = db2_connect($db, $user, $password);

if (!$dbh) {
	die ("Problems connecting to the database.");
}else {
	print "<h1><b>Results of connecting to database successful! </b></h1><br>" ;
	print "User : $user<br>" ;
	print "Password : $password<br>" ;
	print "Database Name : $db <br>" ;
}
?>
	
</body>
</html>