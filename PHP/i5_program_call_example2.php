<html>
<?php
	define("PAGE_TITLE", "i5_program_call");
	define("PHP_FILE_NAME", "i5_program_call_example2.php")
?>

<title><?= PAGE_TITLE . " - " . PHP_FILE_NAME; ?></title>
<body>

<?php
/* Connect to server */
$conn = i5_connect("localhost", "PHPUSER", "PASSW0RD");
if (!$conn) die("<br>Connection failed. Error number =".i5_errno()." msg=".i5_errormsg()); 

$description = array(
	array("Name"=>"FIRST", "IO"=>I5_IN, "Type"=>I5_TYPE_CHAR, "Length"=>"15"),
	array("Name"=>"LAST", "IO"=>I5_IN, "Type"=>I5_TYPE_CHAR, "Length"=>"15"),
	array("Name"=>"ACCOUNT", "IO"=>I5_OUT, "Type"=>I5_TYPE_CHAR, "Length"=>"15"),
	array("Name"=>"AMOUNT", "IO"=>I5_INOUT, "Type"=>I5_TYPE_PACKED, "Length"=>"5.2")
	);
				
$pgm = i5_program_prepare("I5SCHEMA/INCRAMT", $description);
if (!$pgm) die("<br>Program prepare error. Error number =".i5_errno()." msg=".i5_errormsg());
$parmIn = array(
	"FIRST"=>$_POST["first"],
	"LAST"=>$_POST["last"],
	"AMOUNT"=>$_POST["amount"] 
	);
$parmOut = array(
	"FIRST"=>"FIRST", 
	"LAST"=>"LAST", 
 	"ACCOUNT"=>"ACCOUNT",
	"AMOUNT"=>"AMOUNT"
	);
	
$ret = i5_program_call($pgm, $parmIn, $parmOut);
if (!$ret) die("<br>Program call error. Error number=".i5_errno()." msg=".i5_errormsg());
echo "<BR>FIRST :". $FIRST;
echo "<BR>LAST : $LAST";
echo "<BR>AMOUNT : $AMOUNT";
echo "<BR>ACCOUNT : $ACCOUNT";

/* Close program call */
i5_program_close($pgm);

/* Close connection */
i5_close($conn);
?>

<p>=================</p>
<p>Call CL program call demo (PHPLIB/INCRAMT)</p>
<p>=================</p>
<p>resource i5_connect(server, user, password[, options])</p>
<p>- server is 127.0.0.1 or "localhost"</p>
<p>- valid user/passowrd for iSeries profile</p>
<p>=================</p>
<p>resource i5_program_prepare(name[, description][, connection])</p>
<p>-program name (PHP/CLNAME)</p>
<p>-description array of IN, INOUT, OUT parms (see CL program below)</p>
<p>=================</p>
<p>bool i5_program_call(program, params[, retvals])</p>
<p>-resource program is output of i5_program_prepare</p>
<p>-array params IN,INOUT parms to the program</p>
<p>-array retvals return value array</p>
<p>=================</p>
<p>CL program</p>
<p>PGM PARM(&FIRST &LAST &ACCOUNT &AMOUNT)</p>
<p>DCL VAR(&FIRST) TYPE(*CHAR) LEN(15)</p>
<p>DCL VAR(&LAST) TYPE(*CHAR) LEN(15)</p>
<p>DCL VAR(&ACCOUNT) TYPE(*CHAR) LEN(15)</p>
<p>DCL VAR(&AMOUNT) TYPE(*DEC) LEN(5 2)</p>
<p>CHGVAR VAR(&ACCOUNT) VALUE(&LAST)</p>
<p>CHGVAR VAR(&AMOUNT) VALUE(&AMOUNT + 42.42)</p>
<p>ENDPGM</p>
<p>================= </p>