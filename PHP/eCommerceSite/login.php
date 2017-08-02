<?php
/*
 * Created on 3 oct. 06
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
session_start();

include_once "properties.inc.php";

$login = $_POST['login'] ;
$pass = $_POST['pass'];

if ($login == $login_admin and $pass==$pass_admin) {
	$_SESSION['log'] = true ;
	$_SESSION['login'] = $login ;
// accès à la page d'administration (admin.php) //
	header("location: index.php");
	
}else {
	
	// si l'identification n'est pas établi on envoi un mail et on affiche un message d'erreur //
$referer = $_SERVER['HTTP_REFERER'];
$uri = $_SERVER['REQUEST_URI']; 
$ip_visiteur = $_SERVER['REMOTE_ADDR']; 
$date = date('d/m/y',time());
$heure = date('h:m:s',time());
$MailTo = $mail_from; 
$MailSubject = "$date : connexion à l'espace téléchargement échoué";
$MailHeader = ("From: $mail_from");
$MailBody = "Tentative de connexion (Espace Administration) \n";
$MailBody .= "Le : $date a : $heure \n";
$MailBody .= "IP du visiteur : $ip_visiteur \n";
$MailBody .= "Referer : $referer \n";
$MailBody .= "URI : $uri \n";
mail($MailTo, $MailSubject, $MailBody, $MailHeader);
   die('<html>
<head>
<title>Administration</title>
</head>
<body>
<p><b>Identifiant ou mot de passe incorrect !</b></p>
<p>Vous ne pouvez pas acceder a votre espace reserve car l\'identifiant ou le mot de passe saisi n\'a pas ete reconnu.<br /><br /><a href="javascript:history.go(-1)">Retour</a> a la page precedente.</p>
</body>
</html>');
}


?>
