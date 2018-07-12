<html>
<?php
define("PAGE_TITLE", "Employee_Update!");
define("PHP_FILE_NAME", "employee_update.php")
?>

<title><?= PAGE_TITLE . " - " . PHP_FILE_NAME; ?></title>
<body>
<?php 

/* Set up connection for each pass through this application */
$user='PHPUSER';
$password='PASSW0RD';
$db='I520002';
$dbh = db2_connect($db, $user, $password);

if (!$dbh) :
die ("Problems connecting to the database.");
endif;

/* Query file using input from form and deliver results to client */
/* Construct the SQL statement, using lastname as the search substring */
$sql = 'select * from i5schema.employee where lastname like \'JO%\'';
/* Execute the DB2 SQL statement, place results into $stmt */
$stmt = db2_exec($dbh, $sql, array('cursor' => DB2_SCROLLABLE));
/* Print Employee Search Results header and table setup */
print '<h1>Employee Records On System i starting with JO</h1>';
print '<br><table border=1 cellpadding=5 cellspacing=5>';
/* Iterate through result set, printing one table line per record returned. */
/* Note that the customerNumber field will be an "active field" which will  */
/* $_GET the customerNumber and reinvoke the employee_update.php application*/
while ($row = db2_fetch_array($stmt)) {
	if (!$row=="") {
		$customerNumber = $row[0];
		$customerName = $row[3];
		$customerFirst = $row[1];
		$workdept = $row[4];
		$job = $row[7];
		$salary = $row[11];
		print '<tr><td align=center><a href=employee_update.php?customerNumber=' . $customerNumber . '>' . $customerNumber .
		'</a><td>'.$customerName.'<td>'.$customerFirst.'<td>'.$workdept.'<td>'.$job.'<td>'.$salary.'</td></tr>';
	}
}
/* Close table */
print '</table><br>';
/* Print the DB2 SQL statement which was executed - Informational */
print "<p>Echo of dynamically-built sql: ".$sql."</p>";

?>
	
</body>
</html>