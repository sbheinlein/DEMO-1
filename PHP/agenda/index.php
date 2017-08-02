<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Planning Consulting</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<p>Calendrier :</p>

<p>&nbsp;</p>
<form name="form1" method="post" action="affichage.php"> 
  <p>Date de d&eacute;but (jma): 
    <select name="date_debut_jour" id="date_debut_jour">
      <option value=""></option>
      <option value="1" selected>1</option>
      <option value="2">2</option>
      <option value="3">3</option>
      <option value="4">4</option>
      <option value="5">5</option>
      <option value="6">6</option>
      <option value="8">8</option>
      <option value="9">9</option>
      <option value="10">10</option>
      <option value="11">11</option>
      <option value="12">12</option>
      <option value="13">13</option>
      <option value="14">14</option>
      <option value="15">15</option>
      <option value="16">16</option>
      <option value="17">17</option>
      <option value="18">18</option>
      <option value="19">19</option>
      <option value="20">20</option>
      <option value="21">21</option>
      <option value="22">22</option>
      <option value="23">23</option>
      <option value="24">24</option>
      <option value="25">25</option>
      <option value="26">26</option>
      <option value="27">27</option>
      <option value="28">28</option>
      <option value="29">29</option>
      <option value="30">30</option>
      <option value="31">31</option>
    </select>
    <select name="date_debut_mois" id="date_debut_mois">
      <option value=""></option>
      <option value="01">Janvier</option>
      <option value="02">F&eacute;vier</option>
      <option value="03">Mars</option>
      <option value="04">Avril</option>
      <option value="05">Mai</option>
      <option value="06">Juin</option>
      <option value="07">Juillet</option>
      <option value="08">Ao&ucirc;t</option>
      <option value="09">Septembre</option>
      <option value="10">Octobre</option>
      <option value="11">Novembre</option>
      <option value="12">D&eacute;cembre</option>
    </select>
    <select name="date_debut_annee" id="date_debut_annee">
      <option value=></option>
      <option value="2000">2000</option>
      <option value="2001">2001</option>
      <option value="2002">2002</option>
      <option value="2003">2003</option>
      <option value="2004">2004</option>
      <option value="2005">2005</option>
      <option value="2006">2006</option>
      <option value="2007">2007</option>
      <option value="2008">2008</option>
      <option value="2009">2009</option>
    </select>
  </p>
<p>Date de fin (jma): 
    <select name="date_fin_jour" id="date_fin_jour">
      <option value=""></option>
      <option value="1" selected>1</option>
      <option value="2">2</option>
      <option value="3">3</option>
      <option value="4">4</option>
      <option value="5">5</option>
      <option value="6">6</option>
      <option value="8">8</option>
      <option value="9">9</option>
      <option value="10">10</option>
      <option value="11">11</option>
      <option value="12">12</option>
      <option value="13">13</option>
      <option value="14">14</option>
      <option value="15">15</option>
      <option value="16">16</option>
      <option value="17">17</option>
      <option value="18">18</option>
      <option value="19">19</option>
      <option value="20">20</option>
      <option value="21">21</option>
      <option value="22">22</option>
      <option value="23">23</option>
      <option value="24">24</option>
      <option value="25">25</option>
      <option value="26">26</option>
      <option value="27">27</option>
      <option value="28">28</option>
      <option value="29">29</option>
      <option value="30">30</option>
      <option value="31">31</option>
    </select>
    <select name="date_fin_mois" id="date_fin_mois">
      <option value=""></option>
      <option value="01">Janvier</option>
      <option value="02">F&eacute;vier</option>
      <option value="03">Mars</option>
      <option value="04">Avril</option>
      <option value="05">Mai</option>
      <option value="06">Juin</option>
      <option value="07">Juillet</option>
      <option value="08">Ao&ucirc;t</option>
      <option value="09">Septembre</option>
      <option value="10">Octobre</option>
      <option value="11">Novembre</option>
      <option value="12">D&eacute;cembre</option>
    </select>
    <select name="date_fin_annee" id="date_fin_annee">
      <option value=""></option>
      <option value="2000">2000</option>
      <option value="2001">2001</option>
      <option value="2002">2002</option>
      <option value="2003">2003</option>
      <option value="2004">2004</option>
      <option value="2005">2005</option>
      <option value="2006">2006</option>
      <option value="2007">2007</option>
      <option value="2008">2008</option>
      <option value="2009">2009</option>
    </select>    
</p>
<p>&nbsp;</p>
<p>
  Groupe consulting :
  <input type="checkbox" name="groupe" value="Consulting">
</p>
<p>
  Groupe commercial :
  <input type="checkbox" name="groupe" value="Commercial">
</p>
<p>&nbsp;</p>
  <p>Nom : 
 <select name="nom" id="nom">
    <option value=""></option>
    <option value="elombrez">Eric Lombrez</option>
    <option value="fgrumeau">Frédéric Grumeau</option>
    <option value="mpersoud">Michel Persoud</option>
    <option value="mmarrel">Maurice Marrel</option>
    <option value="mmouchon">Michel Mouchon</option>
    <option value="psiebens">Pascal Siebenschuch</option>
    <option value="jmolina">José Molina</option>
    <option value="ejonvel">Eric Jon Vel</option>
    <option value="fpelissa">François Pellissa</option>
    <option value="sgablier">Sophie Gablier</option>
    <option value="fportier">François Portier</option>
 </select>
  </p>
<p>
    <input type="submit" name="Submit" value="Valider">
</p>    
    
</form>
</body>
</html>
