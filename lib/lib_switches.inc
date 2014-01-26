<?
	require_once("lib/lib_db.inc");

	class Switches {

		function get_list() {
			$res = DB::instance()->query("SELECT * FROM devices");
			while ($row = mysql_fetch_assoc($res)) {
				$ls[ $row['ID'] ] = array(
					'host' => $row['hostname'],
					'community' => $row['snmp_community'],
					'description' => $row['description'],
					'ipaddress' => $row['ipaddress'],
					'switchid' => $row['ID'],
				);
			}
			// print_r($ls);
			return $ls;
		}

		function get_selected() {
			$switches = Switches::get_list();
			$switchid = intval($_REQUEST['switchid']);
			$switch = $switches[$switchid];

			$res = DB::instance()->query("SELECT * FROM devices WHERE ID=$switchid");
			$device = mysql_fetch_assoc($res);
			$switch['__device_info'] = $device;

			return array($switchid, $switch);
		}

		function get_switch_data($switchid, $cache = FALSE) {
			list($switchid, $switch) = Switches::get_selected();

			$session = User_Session::instance();

			$switch_data_age = time() - intval($session->switch_data_timestamp); // how old the cache is in seconds

			// update cache if it's gone or older than 300 seconds
			if ($cache == FALSE) $session->switch_data_timestamp = 0; // do not cache

			if ($session->switch_data_timestamp == 0 || $switch_data_page > 300) {
				require_once("lib/snmp.php");
				$switch_data = snmp_scan_switch($switch['ipaddress'], $switch['community']);

				$session->switch_data = $switch_data;
				$session->switch_data_timestamp = time();

			} else { // cached data
				$switch_data = $session->switch_data;
			}
			return $switch_data;
		}


		static function clean_switch_fields() {
			$fields = array(
			 'ifName' => "Interface",
			 // 'ifDesc' => "Name",
			 'ifAdminStatus' => "Admin / ",
			 'ifOperStatus' => "Op Status",
			 'ifAlias' => "Alias",
			 'vmVlan' => "VLan",
			 'portAdminSpeed' => "Speed",
			 'portDuplex' => "Duplex",
			);
			return $fields;
		}
		static function clean_switch_data($switch_data) {
			$clean = array();
			$idx_list = array_keys($switch_data['ifName']);
			$fields = array_keys(self::clean_switch_fields());
			$field_types = array( 'i', 's');
			foreach($idx_list AS $n => $idx) {
				$interface = array();
				foreach($fields AS $field) {
					if (in_array($switch_data[$field][$idx], $field_types)) continue; // skip 'i' and 's'
					$interface[$field] = trim($switch_data[$field][$idx]);
				}
				$interface['ifIndex'] = $idx;
				$interface['ifOperStatus'] = ($interface['ifOperStatus'] == "up(1)") ? 1 : 2;
				$interface['ifAdminStatus'] = ($interface['ifAdminStatus'] == "up(1)") ? 1 : 2;
				
				$clean[] = $interface;
			}
			// print_r($clean);
			return $clean;
		}


	}
