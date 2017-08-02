<?php
//echo "Resultat = ".$_GET['key'];
//exit;
session_start();

// Paramètres.
include_once "properties.inc.php";

// Fonction  utilisé pou vérifier qu'on ne dépasse pas la date limite de téléchargement. 
function compareDate($SQLdate,$limite) {
	$DateRef = time() - $limite;
//	echo $DateRef."<br>";
	$DateRef = date("Y-m-d",$DateRef);
//	echo $DateRef."<br>";
	return ($SQLdate >= $DateRef);
}

$_SESSION['md5'] = $_GET['key'];

$connexion = mysql_connect($mysql_hostname, $mysql_login, $mysql_passwd); // authentification sur mysql

if ($connexion == '') {
	header("Location: page_erreur.php?code=15");
	exit;
	
	//echo "Probléme de connexion à mysql, ressayer";
	//exit;
}
if (mysql_select_db($mysql_database, $connexion)) { // Bien authentifié à la base download
	$md5 = $_GET['key'];

	$sql = "select * from client where md5='$md5';";

	$result = mysql_query($sql, $connexion);

	if (mysql_num_rows($result) != 1) {
		header("Location: page_erreur.php?code=50");
		exit;
	}

	$result = mysql_fetch_array($result);

	$nom_societe = $result['nom_societe'];
	$num_facture = $result['num_facture'];
	$montant_facture = $result['montant_facture'];
	$produit = $result['produit'];
	$envoi_cd = $result['envoi_cd'];
	
	$date_saisie = $result['date_saisie'];

//echo "Date saisie=".$date_saisie;
//exit;

	
	if (!compareDate($date_saisie,$Date_Limite_De_Telechargement)) {
		header("Location: page_erreur.php?code=2");
		exit;
	}

	

} else {
	header("Location: page_erreur.php?code=16");
	exit;
	//echo "Probléme de connexion à la base download, ressayer";
	//exit;
}
?>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Confirmation Form</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="style.css" type="text/css">
</head>

<BODY topmargin="0" leftmargin="0" bgcolor="#ffffff">
    <!--BANDEAU TITRE SLOGAN-->
    <TABLE width="620" align="Center"><tr><td>
    <TABLE height="87" width="600" cellspacing="0" cellpadding="0" class='fond_image'>
      <tr class="mini" height="20">
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td width="160">&nbsp;</td>
        <td class="societe" valign="top">Arcad Software<br>
        <span class="slogan">Confirmation Form</span></td>
      </tr>
    </table>
    <!--FIN - BANDEAU TITRE SLOGAN-->
    <!--Grand TITRE et Petit Texte Haut-->
	<br>
    <TABLE width="600" bgcolor="#ffffff" cellspacing="0" cellpadding="0" >
      <tr class="GDTitre">
        <td>&nbsp;Download</td>
      </tr>
	</table>
    <TABLE width="600" bgcolor="#ffffff" cellspacing="10" cellpadding="0" >
      <tr>
        <td class="PTTexteHaut">Welcome to the confirmation page : </td>
      </tr>
    </table>
    <!--FIN - Grand TITRE et Petit Texte Haut-->
    <table width="604" border="0">
  <tr>
    <td width="35%"><strong>Company :</strong></td>
    <td width="65%" bgcolor="#F8F8F8"><?php echo"$nom_societe"?></td>
  </tr>
  <tr>
    <td><strong>Invoice number :</strong></td>
    <td bgcolor="#F8F8F8"><?php echo"$num_facture"?></td>
  </tr>
  <tr>
    <td><strong>Product to download :</strong></td>
    <td bgcolor="#F8F8F8"><?php echo"$produit"?></td>
  </tr>
  <tr>
    <td><strong>Invoice amount :</strong></td>
    <td bgcolor="#F8F8F8"><?php echo"$montant_facture"?></td>
  </tr>
  <tr>
    <td colspan="2"><p><font size="2"><strong><br>
              In the case of products dispatched outside of the EU and DOM-TOM, the pre-tax price will be calculated on the invoice. Customs duties, local taxes or import duties may apply. In this case we advise you to consult with your local authorities.</strong></font></p></td>
    </tr>
  <tr>
    <td colspan="2"><p>&nbsp; </p>      <form name="form1" method="post" action="validation.php">
          <?php


/*if ($envoi_cd == 1) {
	echo "<p><strong><font color=\"#FF0000\">Le CD est en cours d'envoi.</font></strong></p>" .
			" <input type=\"hidden\" name=\"envoi_cd\" value=\"1\"> ";
} else {
	echo "<p><input name=\"envoi_cd\" type=\"checkbox\" value=\"1\" checked>
				  Voulez-vous recevoir un CD-ROM GRATUIT.  </p>";
}

//étais aprés le <br> ci dessous
<font size="2">Cliquer ici pour valider l'envoi du CD Gratuit, et
            passer &agrave; l'&eacute;tape de
      t&eacute;lechargement. </font>
**/
?>
          <p align="center">
            <input type="submit" name="Submit" value="Valider">
            <br>
            </p>
      </form>      
      <p>If you find any errors in the information above, please contact ARCAD Software (email : <a href="mailto:<?php echo $adresse_administration; ?>"><?php echo $adresse_administration; ?></a>).</p>
    </td>
    </tr>
  <tr>
    <td colspan="2"><font size="1">According to law # 78-17 of 6th January 1978 modified by law # 2004-801 of 6th August 2004, the consumer has, at any time, the rights to access, contest and modify this information.</font></td>
    </tr>
</table>
    <p>&nbsp;</p>    </td></tr>
      <tr>
        <td>&nbsp;</td>
      </tr>
</table>
</body>
</html>