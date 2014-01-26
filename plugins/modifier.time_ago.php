<?
	function smarty_modifier_time_ago($seconds) {
		$str = "";
		if ($seconds > 86400) {
			$str .= floor($seconds / 86400 ). " days ";
			$seconds = $seconds % 86400;
		}
		if ($seconds > 3600) {
			$str .= floor($seconds / 3600 ) . " hours ";
			$seconds = $seconds % 3600;
		}
		if ($seconds > 60) {
			$str .= floor($seconds / 60 ) . " minutes ";
			$seconds = $seconds % 60;
		}
		return $str;
	}
?>
