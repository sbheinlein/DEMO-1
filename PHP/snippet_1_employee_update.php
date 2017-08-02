/* Display the initial Employee Search form and $_POST lastname field */
/* when Search button is selected.                                    */
print '<h1>Enter the first few characters of the employee records you wish to view/edit in the last name field.</h1>';
print '<h2>For example, "JO":</h2>';
print '<form action="employee_update.php" method="POST">';
print 'Last Name: <input type="text" name="lastname" /> <br />';
print '<input type="submit" name="action" value="Search" />';
print '</form>';