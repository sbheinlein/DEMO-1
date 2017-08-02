$action = $_GET["action"];
/* if no value from $_GET, try $_POST */
if (!$action) {
	$action = $_POST["action"];
}