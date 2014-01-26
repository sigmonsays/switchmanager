<?
	require_once("lib/common.inc");
	require_once("lib/lib_db.inc");
	require_once("lib/lib_lock.inc");

	$session = User_Session::instance();
	$session->start();

	$page = Page::instance();

	$page->template = "locks.tpl";
	$page->session = $session;
	$page->title = "Switch Manager - Locks";

	$action = $_REQUEST['action'];

	if ($action == "") {

		$query = "SELECT * FROM locks "
			. "LEFT JOIN auth ON locks.AUTH_ID = auth.ID "
			. "ORDER BY description ";
		$locks = array();
		$res = DB::instance()->query($query);
		while ($row = mysql_fetch_assoc($res)) {
			$locks[] = $row;
		}

		$page->locks = $locks;

	} else if ($action == "remove") {
		$UID = $_REQUEST['UID'];
		Lock::free($UID);

		header("Location: locks.php");
		exit;
	}

	$page->display();


	exit(0);

?>


