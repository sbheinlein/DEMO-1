<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Agenda</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>

<?php


/*
 * Created on 21 nov. 06
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
$groupe = $_POST['groupe'];
$nom = $_POST['nom'];
$mois = $_POST['mois'];
$date_debut_mois = $_POST['date_debut_mois'];
$date_debut_jour = $_POST['date_debut_jour'];
$date_debut_annee = $_POST['date_debut_annee'];
$date_fin_mois = $_POST['date_fin_mois'];
$date_fin_jour = $_POST['date_fin_jour'];
$date_fin_annee = $_POST['date_fin_annee'];

$date_debut = mktime(0, 0, 0, $date_debut_mois, $date_debut_jour, $date_debut_annee);
$date_fin = mktime(0, 0, 0, $date_fin_mois, $date_fin_jour, $date_fin_annee);
#echo $date_debut;
#echo $date_fin;
#echo "date debut : " . $date_debut;
#echo "date fin : " . $date_fin;
#echo "nom : " . $nom;
#echo "groupe : " . $groupe;
#echo "mois : " . $mois;

if ($date_debut != '' and $date_fin != '' and $nom != '') {
	$etat = "cas_nom";
	$sql = "SELECT distinct cal_start, cal_end, cal_title, cal_location " .
	"FROM egw_cal, egw_accounts, egw_cal_dates, egw_cal_user " .
	"WHERE account_id=egw_cal_user.cal_user_id " .
	"and egw_cal_user.cal_id=egw_cal.cal_id " .
	"and egw_cal.cal_id=egw_cal_dates.cal_id " .
	"and account_lid='$nom' " .
	"and cal_start <= '$date_fin' " .
	"and cal_end >= '$date_debut' " .
	"order by cal_start; ";
}

if ($groupe=='Consulting'){
	if ($date_debut != '' and $date_fin != '' and $groupe != '') {
		$etat = "cas_groupe";
		$sql = "SELECT distinct account_lid, cal_start, cal_end, cal_title, cal_location, extra_hotel.cal_extra_value, extra_facturer.cal_extra_value " .
	    "FROM egw_cal, egw_accounts, egw_cal_dates, egw_cal_user, egw_cal_extra extra_facturer, egw_cal_extra extra_hotel " .
		"WHERE account_id=egw_cal_user.cal_user_id " .
		"and egw_cal_user.cal_id=egw_cal.cal_id " .
		"and egw_cal.cal_id=egw_cal_dates.cal_id " .
		"and extra_hotel.cal_id=egw_cal.cal_id " .
		"and extra_facturer.cal_id=egw_cal.cal_id " .
		"and egw_accounts.account_primary_group ='-26' " .
		"and cal_start <= '$date_fin' " .
		"and cal_end >= '$date_debut' " .
		"and extra_hotel.cal_extra_name='reservationHotel' " .
		"and extra_facturer.cal_extra_name='facturer' " .
		"order by cal_start; ";
	}
} else if ($groupe=='Commercial'){
	if ($date_debut != '' and $date_fin != '' and $groupe != '') {
		$etat = "cas_groupe";
		$sql = "SELECT distinct account_lid, cal_start, cal_end, cal_title, cal_location, extra_hotel.cal_extra_value, extra_facturer.cal_extra_value " .
	    "FROM egw_cal, egw_accounts, egw_cal_dates, egw_cal_user, egw_cal_extra extra_facturer, egw_cal_extra extra_hotel " .
		"WHERE account_id=egw_cal_user.cal_user_id " .
		"and egw_cal_user.cal_id=egw_cal.cal_id " .
		"and egw_cal.cal_id=egw_cal_dates.cal_id " .
		"and extra_hotel.cal_id=egw_cal.cal_id " .
		"and extra_facturer.cal_id=egw_cal.cal_id " .
		"and (egw_accounts.account_primary_group ='-55' or egw_accounts.account_primary_group ='-9') " .
		"and cal_start <= '$date_fin' " .
		"and cal_end >= '$date_debut' " .
		"and extra_hotel.cal_extra_name='reservationHotel' " .
		"and extra_facturer.cal_extra_name='facturer' " .
		"order by cal_start; ";
	}
}

?>

<?php


$dbconn = pg_connect("host=192.168.11.1 dbname=egroupware user=mlalaoui");
if ($dbconn == FALSE) {
	echo "probléme connexion à la base";
	exit;
}

if ($etat == "cas_nom") {

	echo "<table width=\"700\" border=\"1\"><tr>" .
	"<td>Nom : " . $nom . "</td>" .
	"<td>Date début : " . date('Y-m-d', $date_debut) . "</td>" .
	"<td>Date fin : " . date('Y-m-d', $date_fin) . "</td>" .
	" <td>Groupe : Consulting</td>" .
	"</tr>" .
	"</table>";

	$result = pg_exec($dbconn, $sql);
	$num = pg_numrows($result);

	echo "<br>";
	echo "<table width=\"700\" border=\"1\">";
	echo "<tr><td align=\"center\"><strong>Date Début</strong></td>" .
	"<td align=\"center\"><strong>Date Fin</strong></td>" .
	"<td align=\"center\"><strong>Titre</strong></td>" .
	"<td align=\"center\"><strong>Ville</strong></td></tr>";

	for ($i = 0; $i < $num; $i++) {
		echo "<tr><td align=\"center\">" . date('Y-m-d', pg_fetch_result($result, $i, 0)) . "</td>" .
		"<td align=\"center\">" . date('Y-m-d', pg_fetch_result($result, $i, 1)) . "</td>" .
		"<td align=\"center\">" . pg_fetch_result($result, $i, 2) . "</td>" .
		"<td align=\"center\">" . pg_fetch_result($result, $i, 3) . "</td></tr>";

	}
	echo "</table>";
}

if ($etat == "cas_groupe") {
	if($groupe=='Consulting'){
	echo "<table width=\"700\" border=\"1\"><tr>" .
	"<td><font size=\"1\">Plannig Consultants</font></td>" .
	"<td><font size=\"1\">Date début : " . date('Y-m-d', $date_debut) . "</font></td>" .
	"<td><font size=\"1\">Date fin : " . date('Y-m-d', $date_fin) . "</font></td></tr>" .
	"</table>";
	}else { echo "<table width=\"700\" border=\"1\"><tr>" .
	"<td><font size=\"1\">Plannig Commercial</font></td>" .
	"<td><font size=\"1\">Date début : " . date('Y-m-d', $date_debut) . "</font></td>" .
	"<td><font size=\"1\">Date fin : " . date('Y-m-d', $date_fin) . "</font></td></tr>" .
	"</table>";
	}

	$result = pg_exec($dbconn, $sql);
	$num = pg_numrows($result);

	
if ($groupe =='Consulting') {
	$noms[0] = "elombrez";
	$noms[1] = "fgrumeau";
	$noms[2] = "mpersoud";
	$noms[3] = "mmarrel";
	$noms[4] = "mmouchon";
	$noms[5] = "psiebens";
	$noms[6] = "jmolina";
	$noms[7] = "ejonvel";
	$noms[8] = "fpellissa";
	$noms[9] = "sgablier";
	$noms[10] = "fportier";
}else if($groupe =='Commercial'){
	$noms[0] = "gcasse";
	$noms[1] = "jbesnard";
	$noms[2] = "ovanschendel";
	$noms[3] = "gabid";
	$noms[4] = "nmalmqvist";
	$noms[5] = "rcano";
	$noms[6] = "msavine";
	$noms[7] = "cducret";
	$noms[8] = "vviollet";
	$noms[9] = "pmagne";
	$noms[10] = "agrillet";
}
	$i = 0;
	$date_courante = $date_debut;
	while ($date_courante < $date_fin) {

		$dates[$i] = $date_courante+1;
		$i++;
		$dates[$i] = $date_courante +43201;
		$i++;
		$date_courante = $date_courante +86400;	
	}

	while ($row = pg_fetch_row($result)) {
	
		foreach ($noms as $nom) {
			foreach ($dates as $date) {

				if ($row[0] == $nom and ($row[1] <= ($date+43195)) and ($row[2] >= $date)) {
					if (isset($resultat[$nom][$date])){
					$resultat[$nom][$date] = $resultat[$nom][$date] . "<br/>" . $row[3] . " <strong>" . $row[4] . "</strong>";
					}else {
						$resultat[$nom][$date] = $row[3] . " <strong>" . $row[4] . "</strong>";
					}
					if ($row[6]=='1'){ 
						$resultat[$nom][$date] = $resultat[$nom][$date] . " Facturé";
					}
					if ($row[5]=='1'){ 
						$resultat[$nom][$date] = $resultat[$nom][$date] . " Hotel";
					}
					#rajouter un tableau pour le "lieu"
					#$lieus[$nom][$date]= $row[4];
					#rajoute un tableau pour le "facturer"
					#if ($row[5]=='facturer' and $row[6]=='1'){ 
					#	$facturers[$nom][$date]= 'oui';
					#}else{
					#	$facturers[$nom][$date]= 'non';
					#} 
				}

			}
		}
	}
	echo "<table width=\"3000\" border=\"1\" cellspacing=\"1\" cellpadding=\"1\" rules=\"all\">";

	echo "<tr><th>" . date('F', $date_debut) . "</th>";

	foreach ($noms as $nom) {
		echo "<th><div align=\"center\">" . $nom . "</div></th>";
		#echo "<th><div align=\"center\">facturer?</div></th>";
	}

	echo "</tr>";

	foreach ($dates as $date) {
		if (date('l', $date)!='Saturday' and date('l', $date)!='Sunday'){
			echo "<tr><td width=\"100\" height=\"20\"><div align=\"left\"><strong><font size=\"2\">" . date('l-j', $date) . "</font></strong></div></td>";
			foreach ($noms as $nom) {
				#ajouter dans la ligne ci dessous le lieu du rdv
				echo "<td width=\"222\" height=\"20\"><div align=\"center\"><font size=\"2\">" . $resultat[$nom][$date] . "</font></div></td>";
				#ajouter une colone pour facturer
				#echo "<td width=\"50\"><div align=\"center\"><font size=\"1\">" . $facturers[$nom][$date] . "</font></div></td>";
			}
			echo "</tr>";
		}
	}
	echo "</table>";

}
?>


</body>
</html>