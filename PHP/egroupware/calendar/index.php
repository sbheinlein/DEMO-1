<?php
/**************************************************************************\
* eGroupWare - Calendar                                                    *
* http://www.egroupware.org                                                *
* Written and (c) 2005 by Ralf Becker <RalfBecker@outdoor-training.de>     *
* --------------------------------------------                             *
*  This program is free software; you can redistribute it and/or modify it *
*  under the terms of the GNU General Public License as published by the   *
*  Free Software Foundation; either version 2 of the License, or (at your  *
*  option) any later version.                                              *
\**************************************************************************/

/* $Id: index.php 20295 2006-02-15 12:31:25Z  $ */

$GLOBALS['egw_info'] = array('flags' => array(
	'currentapp'=>	'calendar',
	'noheader'	=>	True,
	'nonavbar'	=>	True,
));

include('../header.inc.php');

ExecMethod('calendar.uiviews.index');

$GLOBALS['egw']->common->egw_footer();
