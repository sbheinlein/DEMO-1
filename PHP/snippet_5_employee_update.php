} else { /* Edit the selected customer number record */
	/* Construct SQL statement, using customerNumber to select the record */
	$sql = 'select * from i5schema.employee where empno = \'' .$_GET["customerNumber"]. '\'';
	/* Execute the DB2 SQL statement, place results into $stmt */
	$stmt = db2_exec($dbh, $sql, array('cursor' => DB2_SCROLLABLE));
	/* Place the field information returned into array $row */
	$row = db2_fetch_array($stmt);
	/* If there is data, move information from result array into fields */
	/* which will be used for screen display                            */
	if (!$row=="") {
		$customerNumber = $row[0];
		$customerName = $row[3];
		$customerFirst = $row[1];
		$workdept = $row[4];
		$job = $row[7];
		$salary = $row[11];
	}
	/* Display the Employee Edit form and $_GET all fields */
	/* when Update button is selected.                     */
	print '<h1>Edit an Employee record:</h1>';
	print '<form action="employee_update.php" method="GET">';
	print 'Customer Number: <input type="text" name="customerNumber" value="'.$customerNumber.'" /> <br />';
	print 'Last Name: <input type="text" name="customerName" value="'.$customerName.'" /> <br />';
	print 'First Name: <input type="text" name="customerFirst" value="'.$customerFirst.'"/> <br />';
	print 'Work Department: <input type="text" name="workdept" value="'.$workdept.'"/>';
	print 'Job Type: <input type="text" name="job" value="'.$job.'"/> <br />';
	print 'Salary: <input type="text" name="salary" value="'.$salary.'"/> <br />';
	print '<input type="submit" name="action" value="Update" /><a href=employee_update.php?customerNumber=' .
	$customerNumber .'&customerName=' .$customerName.'&customerFirst='.$customerFirst.'&workdept='.
	$workdept.'&job='.$job.'&salary='.$salary.'&action='.$submit.'></a>';
	print '</form>';
	}