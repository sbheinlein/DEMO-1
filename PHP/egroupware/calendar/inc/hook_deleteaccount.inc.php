<?php
	/**************************************************************************\
	* eGroupWare                                                               *
	* http://www.egroupware.org                                                *
	* --------------------------------------------                             *
	*  This program is free software; you can redistribute it and/or modify it *
	*  under the terms of the GNU General Public License as published by the   *
	*  Free Software Foundation; either version 2 of the License, or (at your  *
	*  option) any later version.                                              *
	\**************************************************************************/
	/* $Id: hook_deleteaccount.inc.php 20295 2006-02-15 12:31:25Z  $ */

	$socal =& CreateObject('calendar.socal');
	$socal->change_delete_user((int)$_POST['account_id'],(int)$_POST['new_owner']);
	unset($socal);
