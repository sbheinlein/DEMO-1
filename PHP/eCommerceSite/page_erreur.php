<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Error</title>
<link rel="stylesheet" href="style.css" type="text/css">
</head>
<body>
<p class='erreur'>Il est impossible de donner suite à la demande.</p>
<?php
$code = $_GET['code'];
switch ($code)
{
	case 1 :
		echo "Address unknown."; //Address inconnu Mauvais code MD5
		break; 
	case 2 : 
		echo "Deadline for downloading has been exceeded, please contact ARCAD Software support."; //Date limite dépassée pour le télèchargement
		break;
	case 3 :
		echo "Invalid session. You need to activate the cookies."; //Session invalide. Vous devez activer les cookies
		break;
	case 12 : 
		echo "Error during mail send.";
		break;
	case 13 :
		echo "Error inserting in the database.";
		break;
	case 15 :
		echo "Unable to connect to MySql DBMS.";
		break;
	case 16 :
		echo "Unable to connect to the database."; //base de donnée Download
		break;
	case 50 :
		echo "The query has produced no results !";
		break;
	case 66 :
		echo "Error uploading file.";
		break;
	default :
		echo "Error occurred. Please retry.";
		break;
}

/*
switch ...

1 // Mauvais code MD5...
2 // Date limite dépassée.
3 // Session invalide (le client n'a pas activé les cookies).
12 // Erreur à l'envois d'un Email.
13 // Erreur lors d'une insertion dans la base de données.
*/

//echo $_GET['code'];

?>
</body>
</html>