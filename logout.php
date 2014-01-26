<?
	require_once("lib/common.inc");
	require_once("lib/lib_db.inc");
	require_once("lib/lib_lock.inc");

	$session = User_Session::instance();
	$session->start($redirect = FALSE);
	$session->logged_in = FALSE;

	$AUTH_ID = $session->AUTH_ID;
	Lock::remove_locks_on_logout($AUTH_ID);

	User_Session::destroy();

	header("Location: login.php?logged_out=1");
?>


