<?
	class Changelog {
		function append($device_id, $timestamp, $auth_id, $uid, $ifIndex, $old_value, $new_value) {
			$query = "INSERT INTO changelog SET DEVICE_ID='$device_id', timestamp='$timestamp', AUTH_ID='$auth_id',  "
				. "UID='$uid', old_value='$old_value', new_value='$new_value', ifIndex='$ifIndex'  ";
			$res = DB::instance()->query($query);
			return $res ? TRUE : FALSE;
		}
	}
?>
