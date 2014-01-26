<?
/**
	$db = DB::instance();
	$result = $db->query("SELECT... ");
	while ($row = mysql_fetch_object($result)) {
	}


*/
	class DB {

		static $host = "localhost";
		static $user = "admin";
		static $pass = "admin123";
		static $database = "switchmanager";

		function __construct($host, $user, $pass) {
			$this->conn = mysql_connect($host, $user, $pass);
			$this->host = $host;
			$this->user = $user;
			$this->pass = $pass;
			mysql_select_db(self::$database, $this->conn);
		}
		function instance() {
			static $inst;
			if (!$inst) {
				$inst = new DB(self::$host, self::$user, self::$pass);
			}
			return $inst;
		}
		function query($query) {
			$res = mysql_query($query, $this->conn);
			if (!$res) {
				$msg = "<h1>YOU SUCK AT SQL:<h1>\n";
				$msg .= "MYSQL ERROR: ". mysql_error($this->conn);
				$msg .= "MYSQL QUERY: $query";
				throw new Exception($msg);
			}
			return $res;
		}
	}
?>
