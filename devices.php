<?
	require_once("lib/common.inc");

	$session = User_Session::instance();
	$session->start();

	$page = Page::instance();

	$page->template = "devices.tpl";
	$page->session = $session;

	$page->title = "Switch Manager - Devices";

	require_once("lib/lib_switches.inc");	
	$switches = Switches::get_list();
	$page->switches = $switches;


	$page->display();


	exit(0);

?>


