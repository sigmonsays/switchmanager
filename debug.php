<?
	require_once("lib/lib_session.inc");

	$session = User_Session::instance();
	$session->start(0);

	header("Content-Type: text/plain");
	print_r($_SESSION);
?>
