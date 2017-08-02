/* Set up connection for each pass through this application */
$user='PHPUSER';
$password='PASSW0RD';
$db='I520002';
$dbh = db2_connect($db, $user, $password);

if (!$dbh) :
die ("Problems connecting to the database.");
endif;

/* Get value of parameters which help determine the state of the application */
$action = $_POST["action"];

/* Determine which form to display based upon the state of the application */
if (!$action) {