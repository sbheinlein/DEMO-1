<?php
/*
 * Created on 29 sept. 06
 *
 * Définit tous les paramètres utilisables sur le site de téléchargement
 */
 
 // Date limite d'un téléchargement après la date de aisie de la demande.
 // Par défaut = 30 jours.
 $date_limite_jour = 30;
 $Date_Limite_De_Telechargement = 60*60*24  *  $date_limite_jour;
 
 $login_admin = "administrateur";
 $pass_admin = "quadra";
 
 $mail_subject = "Arcad Mail";
 $mail_subject_admin = "Confirmation de : ";
 $mail_from = "facturation@arcadsoftware.com";
 $adresse_administration = "mlalaoui@arcadsoftware.com";
 
 
 // A reporter partout !!!
 $mysql_hostname = 'localhost';
 $mysql_login = 'root';
 $mysql_passwd = '';
 $mysql_database = 'download';
 
 
 function mail_attachement($to , $sujet , $message , $fichier , $typemime , $nom , $reply , $from, $copie){
   $limite = "_parties_".md5(uniqid (rand()));
   
   $mail_mime = "Date: ".date("l j F Y, G:i")."\n";
   $mail_mime .= "MIME-Version: 1.0\n";
   $mail_mime .= "Content-Type: multipart/mixed;\n";
   $mail_mime .= " boundary=\"----=$limite\"\n\n";
   
   //Le message en texte simple pour les navigateurs qui n'acceptent pas le HTML
   $texte = "This is a multi-part message in MIME format.\n";
   $texte .= "Ceci est un message est au format MIME.\n";
   $texte .= "------=$limite\n";
   $texte .= "Content-Type: text/plain; charset=\"iso-8859-1\"\n";
   $texte .= "Content-Transfer-Encoding: 7bit\n\n";
   $texte .= $message;
   $texte .= "\n\n";
   
   //le fichier
   $attachement = "------=$limite\n";
   $attachement .= "Content-Type: $typemime; name=\"$nom\"\n";
   $attachement .= "Content-Transfer-Encoding: base64\n";
   $attachement .= "Content-Disposition: attachment; filename=\"$nom\"\n\n";
   
   $fd = fopen( $fichier, "r" );
   $contenu = fread( $fd, filesize( $fichier ) );
   fclose( $fd );
   $attachement .= chunk_split(base64_encode($contenu));
   
   $attachement .= "\n\n\n------=$limite\n";
   return mail($to, $sujet, $texte.$attachement, "Reply-to: $reply\nFrom:
   $from\nBcc: $copie\n".$mail_mime);
}


function get_ip() {
	if (isset ($_SERVER['HTTP_X_FORWARDED_FOR'])) {
		$ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
	}
	elseif (isset ($_SERVER['HTTP_CLIENT_IP'])) {
		$ip = $_SERVER['HTTP_CLIENT_IP'];
	} else {
		$ip = $_SERVER['REMOTE_ADDR'];
	}
	return $ip;
}
 
 
 
?>
