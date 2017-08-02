} else { /* Update Employee table, or edit the selected customer record */
	if ($action == "Update") {
		$sql = 'update i5schema.employee set lastname = \''.$_GET["customerName"].'\','.
		' firstnme = \''.$_GET["customerFirst"].'\','.
		' workdept = \''.$_GET["workdept"].'\','.
		' job = \''.$_GET["job"].'\','.
		' salary = '.$_GET["salary"].
		' where empno = \'' .$customerNumber.'\'';
		$result = db2_exec($dbh, $sql);
		if (!$result) {
			echo '<p>There was a problem inserting the user into the database.</p>';
			print '<p>Echo of dynamically-built sql:<br>'.$sql.'</p>';
		} else {
			print '<h1>Update Successful</h1>';
			print '<form action="employee_update.php" method="POST">';
			print '<p>Echo of dynamically-built sql:<br>'.$sql.'</p>';
			print '<input type="submit" name="action" value="Continue" /><a href=employee_update.php></a>';
			print '</form>';
		}
	}