<?
	require_once("lib/common.inc");

	$session = User_Session::instance();
	$session->start();

	$page = Page::instance();

	$page->template = "switch.tpl";
	$page->session = $session;

	$page->title = "Switch Manager";

	require_once("lib/lib_switches.inc");	
	$switches = Switches::get_list();
	$page->switches = $switches;

	list($switchid, $switch) = Switches::get_selected();

	// clear responses older than 30 sec
	if ($session->response && (time() - $session->response['time'] ) > 30 ) {
		$session->response = array();
	}

	require_once("lib/lib_lock.inc");
	if ($_REQUEST['resource_locked']) {
		$lockid = $_REQUEST['resource_locked'];
		$details = Lock::details($lockid);
		$page->template = "resource_locked.tpl";
		$page->set_multi(compact('lockid', 'details'));
		$page->display();
		exit;
	}

	if ($switchid > 0) {

		$lockid = "device.$switchid";
		if (!Lock::get($lockid, $session->AUTH_ID, "devices lock")) {
			$session->response['status'] = FALSE;
			$session->response['message'] = "Unable to obtain lock.";
			Lock::failure($lockid);
			exit;
		}

		$switch_data = Switches::get_switch_data($switchid);

		$page->switches = $switches;
		$page->switchid = $switchid;
		$page->switch_fields = Switches::clean_switch_fields();
		$page->switch_vlans = array_keys($switch_data['VLANS']);
		$page->switch_data = Switches::clean_switch_data($switch_data);
		$page->switch = $switch;
		$page->switch_info = $switch_data['SYSINFO'];

		// print_r($switch_data);
		// print_r($page->switch_data);

		$query ="SELECT oid_values.*,UID "
			. "FROM oid_values "
			. "LEFT JOIN devices_oid ON oid_values.OID_ID = devices_oid.OID_ID "
			. "LEFT JOIN oids ON oid_values.OID_ID = oids.ID "
			. " WHERE devices_oid.DEVICE_ID = $switchid ";


		$res = DB::instance()->query($query);
		$oid_translations = array();
		while ($row = mysql_fetch_assoc($res)) {
			$oid_translations[$row['UID']][$row['key1']] = $row;
		}
		$page->oid_translations = $oid_translations;
	}


	$page->display();


	exit(0);

?>


