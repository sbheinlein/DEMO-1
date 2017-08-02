<html>
<?php
	define("PAGE_TITLE", "i5_command");
	define("PHP_FILE_NAME", "i5_command_example.php")
?>

<title><?= PAGE_TITLE . " - " . PHP_FILE_NAME; ?></title>

<?php
/* Connect to server */
$conn = i5_connect("localhost", "PHPUSER", "PASSW0RD");
if (!$conn) die("<br>Connection failed. Error number =".i5_errno()." msg=".i5_errormsg()); 

/* Retrieve Job Attributes example */
$ret = i5_command("rtvjoba", array(), array("curlib" => "curl",
											"user"=>"user",
											"usrlibl" => "userlib",
											"syslibl" => "syslib"));
if (!$ret) die("<br>Command failed. Error number =".i5_errno()." msg=".i5_errormsg()); 
print "<h1><b>Results of \"rtvobja\" command </b></h1><br>" ;
print "User : $user<br>" ;
print "User library : $userlib<br>" ;
print "System library list : $syslib <br>" ;
print "Current library : $curl<br>" ;

/* Retrieve Network Attributes example */
$ret = i5_command("rtvneta", array(), array("sysname" => "sysn",
											"lclnetid"=>"lclnet"));
if (!$ret) die("<br>rtvneta command failed. errno=".i5_errno()." msg=".i5_errormsg()); 
print "<h1><b>Results of \"rtvneta\" command </b></h1><br>" ;
print "System Name : $sysn<br>" ;
print "Local Net ID : $lclnet<br>" ;

/* Close connection */
i5_close($conn);
?>

<body>
	<p>==================== </p>
	<p>Call a System i command (ex. rtvjoba)</p>
	<p>=================</p>
	<p>i5_connect(server, user, password[, options]) returns resource </p>
	<p>- server is 127.0.0.1 or "localhost"</p>
	<p>- valid user/password for iSeries profile - PHPUSER/SNAPPLE in this example</p>
	<p>=================</p>
	<p>i5_command(command name[inputs, outputs, connection]) returns boolean </p>
	<p>-command name = rtvjoba</p>
	<p>-array inputs = none in this case</p>
	<p>-array outputs = OUT data</p>
	<p>-connection = not specified; defaults to last 15_connect connection</p>
	<p>================= </p>

	