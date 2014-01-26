<?
	require_once("lib/common.inc");
	require_once("lib/lib_switches.inc");
	require_once("lib/lib_lock.inc");
	require_once("lib/snmp.php");

	$session = User_Session::instance();
	$session->start();

	$action = $_REQUEST['action'];

	list($switchid, $switch) = Switches::get_selected();

	$session->response = $response = array(
		'time' => time(),
		'status' => TRUE,
		'action' => $action,
	); // the servlet response. 


	if ($action == "save_switch_settings") {
			
		$lockid = "device.$switchid";

		if(!Lock::check($lockid)) {
			Lock::failure($lockid);
		}
		

		$switch_data = Switches::get_switch_data($switchid, $cache = TRUE);
		$switch_fields = Switches::clean_switch_fields();

		$clean = Switches::clean_switch_data($switch_data);
		$form_data = $_REQUEST['switch_data'];


		// find what changed
		$updates = array();

		// echo "**CLEAN** "; var_dump($clean);
		// echo "**FORM** "; var_dump($form_data);
		// echo "**FIELDS** "; var_dump($switch_fields);

		$form_data_len = count($form_data);
		for($ifn=0; $ifn<$form_data_len; $ifn++) {
			foreach($switch_fields AS $field => $field_desc) {
				if (!isset($form_data[$ifn][$field])) continue;			// not in the form at all..
				if ($form_data[$ifn][$field] != $clean[$ifn][$field])		// nothing changed..

				$updates[] = array(
					'_set' => $field,
					'_val' => $form_data[$ifn][$field],
					'interface_data' => $clean[$ifn],
				);
			}
		}


		$timestamp = time();
		require_once("lib/lib_changelog.inc");
		// make snmp calls

		foreach($updates AS $update) {
			$oid_name = $update['_set'];
			$ifIndex = $update['interface_data']['ifIndex'];
			$value = $update['_val'];
		
			Changelog::append( $switchid, $timestamp, $session->AUTH_ID, $oid_name, $ifIndex, "OLD", $value);
			snmp_set_switch( $switch['ipaddress'], $switch['community'], $oid_name, $ifIndex, $value);
			
		}
		$response['message'] = count($updates)." change(s) made";

		$session->last_updates = $updates;

		// Lock::free($lockid);

	} else {

		$response['status'] = FALSE;
		$response['message'] = "Invalid action";
	}


	$session->response = $response;

	$return_url = $_SERVER['HTTP_REFERER'];
	header("Location: $return_url");
?>
