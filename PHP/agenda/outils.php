<?php
/*
 * Created on 6 déc. 06
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 
#$dbconn = pg_connect("host=192.168.11.1 dbname=egroupware user=mlalaoui");
if ($dbconn == FALSE) {
	echo "probléme connexion à la base";
	exit;
}

$sql="select cal_id from egw_cal_dates where cal_id not in (select cal_id from egw_cal_extra where cal_extra_name='facturer');";

$result = pg_exec($dbconn, $sql);
$num = pg_numrows($result);

while ($row = pg_fetch_row($result)) {
	$id=$row[0];
	$sql_insert="insert into egw_cal_extra values ($id,'facturer',0)";
	pg_exec($dbconn, $sql_insert);
	echo "insertion du facturer pour id : $id \n\r ";
}

?>
