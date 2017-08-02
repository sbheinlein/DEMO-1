<?php
session_start();
if($_SESSION['log'] != true) {
	header("location: authentification.html");
}
if (!isset($_SESSION["X_nom_societe"]) OR $_SESSION["X_nom_societe"]=='') {
	header("Location: page_erreur.php?code=3");
	exit;
}

include_once "properties.inc.php";


$X_date_saisie = date("Y-m-d");
$expdate = date("d F Y",mktime(0, 0, 0, date("m")  , date("d")+$date_limite_jour, date("Y")));
$X_nom_societe = $_SESSION['X_nom_societe'];
$X_numero_facture = $_SESSION['X_num_facture'];
$X_montant_facture = $_SESSION['X_montant_facture'];
$X_produit = $_SESSION['X_produit'];
$X_mail_client = $_SESSION['X_mail_client'];
$X_message_mail = $_SESSION['X_message_mail'];
$X_facture = $_SESSION['X_facture'];
$X_facture_chemin = $_SESSION['X_facture_chemin'];
$X_facture_type = $_SESSION['X_facture_type'];
$X_facture_error = $_SESSION['X_facture_error'];
$X_md5 = md5("$X_nom_societe" . "$X_numero_facture" . date("Y-m-d h:i:s"));
$X_nom = $_SESSION['X_nom'];


if ($X_facture_fichier['error'] != UPLOAD_ERR_OK) {
	header("Location: page_erreur.php?code=66");
	exit;
}

//envoi du mail.
if (isset ($X_mail_client) and $X_mail_client <> '' and $mail_from <> '') {
	
	if (isset ($_SERVER['HTTPS'])) {
		$adresse_site = "https://" . $_SERVER['HTTP_HOST'] . "/X" . $X_md5;
	} else {
		$adresse_site = "http://" . $_SERVER['HTTP_HOST'] . "/X" . $X_md5;
	}

	$X_message_mail = str_replace("###lien###", $adresse_site, $X_message_mail);
	$X_message_mail = str_replace("###expdate###", $expdate, $X_message_mail);
	$X_message_mail = str_replace("###nom###", $X_nom, $X_message_mail);
	$X_message_mail = str_replace("###numfacture###", $X_numero_facture, $X_message_mail);
	$X_message_mail = str_replace("###nomfacture###", $X_facture, $X_message_mail);
	$X_message_mail = str_replace("###societe###", $X_nom_societe, $X_message_mail);
	
	#$headers = 'From: ' . $mail_from . "\r\n" .
	#'Reply-To: ' . $mail_from . "\r\n" .
	#'Bcc: ' . $adresse_administration . "\r\n" .
	#'X-Mailer: PHP/' . phpversion();
	
	//'Bcc: ' . $adresse_administration . "/r/n" .
	
	#mail($X_mail_client, $mail_subject, $X_message_mail, $headers)
	if (!mail_attachement($X_mail_client , $mail_subject , $X_message_mail , $X_facture_chemin , $X_facture_type , $X_facture , $adresse_administration , $adresse_administration, $adresse_administration)) {
		echo "problème lors de l'envoi du mail. Mail non envoyé.";
		
		//header("Location: page_erreur.php?code=12");
		exit;
	}
}

$connexion = mysql_connect($mysql_hostname, $mysql_login, $mysql_passwd); // Bien Authentifié sur mysql
if ($connexion == '') {
	header("Location: page_erreur.php?code=15");
	exit;
	
	//echo "Probléme de connexion à mysql, ressayer";
	//exit;
}

if (mysql_select_db($mysql_database, $connexion)) { // Bien authentifié à la base download
	$message_mail = addslashes($message_mail);
	$nom_societe = addslashes($nom_societe);
	$sql = "insert into client(nom_societe,num_facture,montant_facture,date_saisie,mail_client,message_mail,md5,produit,nom) " .
	"values ('$X_nom_societe','$X_numero_facture','$X_montant_facture','$X_date_saisie','$X_mail_client','$X_message_mail','$X_md5','$X_produit','$X_nom');";
	if (mysql_query($sql, $connexion) == FALSE) {
		header("Location: page_erreur.php?code=13");
		exit;
	}
	mysql_close($connexion);
} else {
	header("Location: page_erreur.php?code=16");
	exit;
	//echo "Probléme de connexion à la base download, ressayer";
	//exit;
}
header("Location: mailok.html");
?>

