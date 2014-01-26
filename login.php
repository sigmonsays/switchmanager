<?
	require_once("lib/common.inc");
	require_once("lib/lib_db.inc");

	$session = User_Session::instance();
	$session->start($redirect = FALSE);

	$action = $_REQUEST['action'];

	if ($action == "login") {
		$retval = FALSE;

		$username = $_REQUEST['username'];
		$password = $_REQUEST['password'];
		$md5_password = md5($password);

		$query = "SELECT * FROM auth WHERE username='$username' AND password = '$md5_password' ";
		$res = DB::instance()->query($query);

		if ($res && $row = mysql_fetch_assoc($res)) {
			if ($username == $row['username']) {
				$retval = TRUE;
				$session->logged_in = TRUE;
				$session->username = $username;
				$session->login_time = time();
				$session->AUTH_ID = $row['ID'];
			}
			unset($row);
		}

		if ($retval) {
			header("Location: main.php");
			exit;
		}
	}

	$page = Page::instance();

	$page->template = "login.tpl";
	$page->session = $session;
	$page->action = $action;
	$page->retval = $retval;
	$page->username = $username;

	$page->title = "Switch Manager - Login";

	$page->logged_out = $_REQUEST['logged_out'];

	$page->display();

?>


