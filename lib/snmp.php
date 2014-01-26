<?

require_once("lib_db.inc");

function	parse_from_mib($str, $delim)
{

	$tmp = explode("$delim", $str);
	$nums = count($tmp)-1;

	return $tmp[$nums];
}

function	build_index_from_response($resp)
{
	foreach ($resp as $val => $key) {
		$if_index 	= parse_from_mib($val, ".");
		$val		= parse_from_mib($key, ":");
		$savedata[$if_index] = $val;
	}

	return $savedata;
}

function	get_os($host, $community)
{
	$oidnum = ".1.3.6.1.2.1.1.1.0";

	$tmp    = snmpget( $host, $community, $oidnum );
	
	if(strstr($tmp, "IOS (tm)")) {
		$os = "IOS";
	} else {
		$os = "CATOS";
	}

	return $os;
}

function	get_system($host, $community)
{
	$sysoid = "1.3.6.1.2.1.1";

	$tmp 	= snmprealwalk( $host, $community, $sysoid );

	return $tmp;
}

function	snmp_set_switch($host, $community, $oidname, $IF_INDEX, $val)
{

	if( (!$host) || (!$community) || (!$oidname) || (!$IF_INDEX) || (!$val) ) {

		echo "*something not passed right. check frontend bugs.<BR><BR>";
		die();

	} else {
		echo "awoke! snmp_set_switch( $host, $community, $oidname, $IF_INDEX, $val )" . "<BR>";
	}


	$db = DB::instance();
	
	$DEVICE_ID = get_device_id_by_host($host);

	$res_oid = $db->query("SELECT oid, mib_name, oid_type FROM oids LEFT JOIN devices_oid ON oids.ID = devices_oid.OID_ID WHERE devices_oid.DEVICE_ID = $DEVICE_ID AND UID = '$oidname'");
	$num_rows = mysql_num_rows($res_oid);

	if($num_rows <= 0 ) {
		echo "no records<BR>";
		return FALSE;
	}
	$row_oid = mysql_fetch_object($res_oid);
	
	$oid  = $row_oid->oid;
	$type = $row_oid->oid_type;

	$portindex = "$oid.$IF_INDEX";

	if(!snmpset($host, $community, $portindex, $type, $val)) {
		echo "This is shit. $val, $type, $portindex<BR>";
	}
}

function	get_vlan_list($host, $community)
{
	$vlanlistoid = ".1.3.6.1.4.1.9.9.46.1.3.1.1.2.1";

	$tmp 	= snmprealwalk( $host, $community, $vlanlistoid );
	$result = build_index_from_response( $tmp );
	
	return $result;
}

function	get_device_id_by_host($host)
{
	$db = DB::instance();

	$res_oid = $db->query("SELECT ID FROM devices WHERE ipaddress = '$host'");
	$row_oid = mysql_fetch_object($res_oid);

	$DEVICE_ID = $row_oid->ID;

	return $DEVICE_ID;
}


function	get_catos_portname_oid( $host, $community, $ifnameoid )
{
	$portnameoid = "1.3.6.1.4.1.9.5.1.4.1.1.4";

	$tmp    = snmpget( $host, $community, $ifnameoid );

	$tmpparse = explode("/", $tmp);
	
	$newoid = "$portnameoid.$tmpparse[0].$tmpparse[1]";

	return $newoid;
}

function	snmp_scan_switch($host, $community)
{
	$DEVICE_ID 	= get_device_id_by_host($host);
	$vlans_allocd 	= get_vlan_list($host, $community);
	$sys		= get_system($host, $community);
	$os 	      	= get_os($host, $community);


	$ostype = $os;

	
	$db = DB::instance();

	$result[SYSINFO] = $sys;
	$result[OSTYPE]  = $ostype;
	$result[VLANS] 	 = $vlans_allocd;
	
	$res_oid = $db->query("SELECT oid, mib_name, UID FROM oids LEFT JOIN devices_oid ON oids.ID = devices_oid.OID_ID WHERE devices_oid.DEVICE_ID = '$DEVICE_ID' AND oids.scanner = '1'");

	while($row_oid = mysql_fetch_object($res_oid)) {

		$oid[] = $row_oid->oid;
		$mib_name[] = $row_oid->mib_name;
		$uid_name[] = $row_oid->UID;
	}

	for($i = 0; $i < count($oid); $i++) {

		$name 	 = $uid_name[$i];
		$oidid	 = $oid_id[$i];

		$tmp 		= snmprealwalk( $host, $community, $oid[$i] );
		$result[$name] 	= build_index_from_response( $tmp );


	}

	/* Build ifIndex for other non-database oids we need (oids.scanner = 0)
	 */
	
	foreach ($result as $key => $val) {
		if($key == "ifName") {
			foreach ($val as $key2 => $val2) {
				$if_index[] = $key2;
			}
		break;
		}
	}

	/* if this is CatOS, fill description from ifName indexing (from val of)
	 */
	if($ostype == "CatOS") {
		// clear previous ifAlias 
		
		unset($result['ifAlias']);

		for($i = 0; $i < count($if_index); $i++) {
			$ifoid 		= ".1.3.6.1.2.1.31.1.1.1.1.$if_index[$i]";

			$portnameoid 	= get_catos_portname_oid($host, $community, $ifoid);

			echo "DEBUG: ifName val to portName indexing:  $portnameoid<BR>";

			$tmp = snmpget( $host, $community, $portnameoid );
			$result['ifAlias'] = build_index_from_response ( $tmp );
		}
	
	}

	

 return $result;
}


		$res = snmp_scan_switch("192.168.30.3", "test");
	//	snmp_set_switch("192.168.30.3", "test", "7", "8", "Set by switchmanager")
	//	var_export($res);


?>
