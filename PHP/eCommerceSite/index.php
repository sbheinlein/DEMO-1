<?php
session_start();
if ($_SESSION['log'] != true) {
	header("location: authentification.html");
}
if ($_POST['reponse'] == 1) {

	if ($_POST['X_mail_client'] <> '') {
		$_SESSION['X_mail_client'] = $_POST['X_mail_client'];
	}
	if ($_POST['X_num_facture'] <> '') {
		$_SESSION['X_num_facture'] = $_POST['X_num_facture'];
	}
	if ($_POST['X_montant_facture'] <> '') {
		$_SESSION['X_montant_facture'] = $_POST['X_montant_facture'];
	}
	if ($_POST['X_nom_societe'] <> '') {
		$_SESSION['X_nom_societe'] = $_POST['X_nom_societe'];
	}
	if ($_POST['X_nom'] <> '') {
		$_SESSION['X_nom'] = $_POST['X_nom'];
	}
	if ($_POST['X_message_mail'] <> '') {
		$_SESSION['X_message_mail'] = $_POST['X_message_mail'];
	}
	if (isset ($_FILES['X_facture'])) {

		move_uploaded_file($_FILES['X_facture']['tmp_name'], './upload/' . $_SESSION['login'] . '.tmp');
		$_SESSION['X_facture'] = $_FILES['X_facture']['name'];
		$_SESSION['X_facture_chemin'] = './upload/' . $_SESSION['login'] . '.tmp';
		$_SESSION['X_facture_type'] = $_FILES['X_facture']['type'];
		$_SESSION['X_facture_error'] = $_FILES['X_facture']['error'];
	}
	if ($_POST['X_produit'] <> '') {
		$_SESSION['X_produit'] = $_POST['X_produit'];
	}
	if (($_POST["X_mail_client"] == '') OR ($_POST["X_num_facture"] == '') OR ($_POST["X_nom"] == '') OR ($_POST["X_montant_facture"] == '') OR ($_POST["X_nom_societe"] == '') OR ($_POST["X_produit"] == '')) {
		$completed = '0';
	} else {
		// 
		$lienRetour = "dataenreg.php";
		header("Location: $lienRetour");
		exit ();
	}
} else {
	$_SESSION['X_message_mail'] = "For the attention of: ###societe###\r\n\r\nDear ###nom###,  \r\n\r\nThankyou very much for your order, which has now been entered successfully. \r\n\r\n" .
	"Your invoice ###numfacture### is attached to this message (###nomfacture###).\r\n\r\n" .
	"In order to download your ARCAD software, please click on the link below : ###lien### before the ###expdate###.\r\n\r\n" .
	"In case of any problems, please contact our technical support on : \r\nsupport-eu@arcadsoftware.com \r\nTel : 33 (0)4 50 57 28 00 \r\n\r\n" .
	"www.arcadsoftware.com";
}
?>
<html>
  <head>
    <title>
      Formulaire
    </title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link rel="stylesheet" href="style.css" type="text/css">
<SCRIPT language="JavaScript"><!--
function controle(){
b=(4000-document.form1.X_message_mail.value.length);
if(b>0)document.getElementById("nbre").innerHTML="Il ne vous reste que "+b+" caractères.";
else document.getElementById("nbre").innerHTML="<b>Vous dépassez la longueur limite de 4000 caractères.</b>";
}
--></SCRIPT> 
  </head>
  <BODY topmargin="0" leftmargin="0" bgcolor="#ffffff">
    <!--BANDEAU TITRE SLOGAN-->
    <TABLE align="Center"><tr><td>
    <TABLE height="87" width="600" cellspacing="0" cellpadding="0" class='fond_image'>
      <tr class="mini" height="20">
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td width="160">&nbsp;</td>
        <td class="societe" valign="top">Arcad Software<br><span class="slogan">Formulaire de demande de t&eacute;léchargement</span></td>
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
        <td class="PTTexteHaut">Remplir :</td>
      </tr>
    </table>
    <!--FIN - Grand TITRE et Petit Texte Haut-->
    <!--FORMULAIRE-->
    <TABLE width="600" bgcolor="#ffffff" cellspacing="10" cellpadding="0" >
      <form name="form1" action="index.php" method="POST" enctype="multipart/form-data">
      	<input name="reponse" type="hidden" value="1">
    <?php


if ($completed == '0') {
	echo "<tr><td colspan=\"3\" class=\"etoile\">Les champs marqués d'une étoile (*), doivent être renseignés!</td></tr>";
}
if ($_POST["X_nom_societe"] == '') {
	echo "<tr>
							<td width=\"2%\" class=\"FormLib\">Société<span class=\"etoile\">&nbsp;*</span></td>
							<td width=\"98%\"><input type='text' name='X_nom_societe' size='30' value='' class=\"FormChamp\" maxlength=\"50\"></td>
						</tr>";
} else {
	echo "<tr>
							<td width=\"2%\" class=\"FormLib\">Société<span class=\"etoile\">&nbsp;*</span></td>
							<td width=\"98%\"><input type='text' name='X_nom_societe' size='30' value='" . $_POST["X_nom_societe"] . "' class='FormChamp' maxlength='50'></td>
						</tr>";

	/*"<tr>
							<td width=\"2%\" class=\"FormLib\">Société<span class=\"etoile\">&nbsp;*</span></td>
							<td width=\"98%\" class=\"FormLib\">" . $_POST["X_nom_societe"] . "</td>
						</tr>";*/
}
if ($_POST["X_nom"] == '') {
	echo "<tr>
							<td width=\"2%\" class=\"FormLib\">Nom<span class=\"etoile\">&nbsp;*</span></td>
							<td width=\"98%\"><input type='text' name='X_nom' size='30' value='' class=\"FormChamp\" maxlength=\"50\"></td>
						</tr>";
} else {
	echo "<tr>
							<td width=\"2%\" class=\"FormLib\">Nom<span class=\"etoile\">&nbsp;*</span></td>
							<td width=\"98%\"><input type='text' name='X_nom' size='30' value='" . $_POST["X_nom"] . "' class=\"FormChamp\" maxlength=\"50\"></td>
						</tr>";

	/*"<tr>
							<td width=\"2%\" class=\"FormLib\">Nom<span class=\"etoile\">&nbsp;*</span></td>
							<td width=\"98%\" class=\"FormLib\">" . $_POST["X_nom"] . "</td>
						</tr>";*/
}
if ($_POST["X_num_facture"] == '') {
	echo "<tr>
							<td width=\"2%\" class=\"FormLib\">Numero de facture<span class=\"etoile\">&nbsp;*</span></td>
							<td width=\"98%\"><input type='text' name='X_num_facture' size='30' value='' class=\"FormChamp\" maxlength=\"50\"></td>
						</tr>";
} else {
	echo "<tr>
							<td width=\"2%\" class=\"FormLib\">Numero de facture<span class=\"etoile\">&nbsp;*</span></td>
							<td width=\"98%\"><input type='text' name='X_num_facture' size='30' value='" . $_POST["X_num_facture"] . "' class=\"FormChamp\" maxlength=\"50\"></td>
						</tr>";

	/*"<tr>
							<td width=\"2%\" class=\"FormLib\">Numero de facture<span class=\"etoile\">&nbsp;*</span></td>
							<td width=\"98%\" class=\"FormLib\">" . $_POST["X_num_facture"] . "</td>
						</tr>";*/
}
if ($_POST["X_montant_facture"] == '') {
	echo "<tr>
							<td width=\"2%\" class=\"FormLib\">Montant facture<span class=\"etoile\">&nbsp;*</span></td>
							<td width=\"98%\"><input type='text' name='X_montant_facture' size='30' value='' class=\"FormChamp\" maxlength=\"50\"></td>
						</tr>";
} else {
	echo "<tr>
							<td width=\"2%\" class=\"FormLib\">Montant facture<span class=\"etoile\">&nbsp;*</span></td>
							<td width=\"98%\"><input type='text' name='X_montant_facture' size='30' value='" . $_POST["X_montant_facture"] . "' class=\"FormChamp\" maxlength=\"50\"></td>
						</tr>";

	/*"<tr>
							<td width=\"2%\" class=\"FormLib\">Montant facture<span class=\"etoile\">&nbsp;*</span></td>
							<td width=\"98%\" class=\"FormLib\">" . $_POST["X_montant_facture"] . "</td>
						</tr>";*/
}

if ($_POST["X_mail_client"] == '') {
	echo "<tr>
							<td width=\"2%\" class=\"FormLib\">Adresse eMail<span class=\"etoile\">&nbsp;*</span></td>
							<td width=\"98%\"><input type='text' name='X_mail_client' size='30' value='' class=\"FormChamp\" maxlength=\"100\"></td>
						</tr>";
} else {
	echo "<tr>
							<td width=\"2%\" class=\"FormLib\">Adresse eMail<span class=\"etoile\">&nbsp;*</span></td>
							<td width=\"98%\"><input type='text' name='X_mail_client' size='30' value='" . $_POST["X_mail_client"] . "' class=\"FormChamp\" maxlength=\"100\"></td>
						</tr>";

	/*"<tr>
							<td width=\"2%\" class=\"FormLib\">Adresse eMail<span class=\"etoile\">&nbsp;*</span></td>
							<td width=\"98%\" class=\"FormLib\">" . $_POST["X_mail_client"] . "</td>
						</tr>";*/
}

echo "<tr>
		<td width=\"2%\" class=\"FormLib\">Message mail</td>
		<td width=\"98%\"><TEXTAREA onKeyPress=\"controle()\" class=\"FormChamp\" NAME='X_message_mail' ROWS='10' COLS='78'>" . $_SESSION['X_message_mail'] . "</TEXTAREA></td>
	</tr>";
echo "<tr><td width=\"2%\" class=\"FormLib\">&nbsp;</td>" .
"<td width=\"98%\" class=\"FormComment\"><p><span id=\"nbre\"></span>
<SCRIPT language=\"JavaScript\"><!--
controle();
--></SCRIPT></p><p>Conservez au moins les références ###lien### et ###expdate### dans le corps du message. Ces balises seront automatiquement" .
" remplacées par un lien vers le formulaire de validation et une date.</p></td></tr>";

echo "<tr>
						<td width=\"2%\" class=\"FormLib\">Facture</td>
						<td width=\"98%\"><input type=\"file\" name='X_facture' class=\"FormChamp\"></td>
					</tr>";

echo "<tr>
	          <td width=\"2%\" class=\"FormLib\">Produit<span class=\"etoile\">&nbsp;*</span></td>
	          <td width=\"98%\">&nbsp;</td>
	        </tr>";
$folder = "download";
$dossier = opendir($folder);
while ($Fichier = readdir($dossier)) {
	if ($Fichier != "." and $Fichier != ".." and $Fichier != ".htaccess") {
		echo "<tr>
		          <td width=\"2%\" class=\"FormLib\">&nbsp;</td>
		          <td width=\"98%\"><input type=\"radio\" name=\"X_produit\" value=\"$Fichier\"";
		if ($_POST["X_produit"] == $Fichier) {
			echo "checked";
		}
		echo ">$Fichier</td></tr>";

	}
}
closedir($dossier);
?>
        <!-- Validation -->
        <tr>
          <td colspan="2" align="right"><input name="cancel1" type="reset" value="Annuler" />&nbsp;<input name="valid1" type="submit" value="Valider" /></td>
        </tr>
      </form>
    </table>
    <!--FIN - FORMULAIRE-->
    <!--Petit Texte BAS-->
    <TABLE width="600" bgcolor="#ffffff" cellspacing="10" cellpadding="0" >
      <tr>
        <td class="PTTexteBas">* Les champs précédés d'une étoile sont obligatoires.</td>
      </tr>
    </table>
    </td></tr></table>
    <!--Texte BAS-->
  </body>
</html>