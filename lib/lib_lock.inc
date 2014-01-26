<?
	class Lock {
		/**
		 * get a lock on $uid
		 * returns FALSE if lock was not obtained
		 **/
		static function get($uid, $AUTH_ID, $description) {
			$session = User_Session::instance();

			$ts = time();
			$IP = $_SERVER['REMOTE_ADDR'];

			$query = "INSERT INTO locks SET UID='$uid', AUTH_ID='$AUTH_ID', TIMESTAMP='$ts', "
				. "IP='$IP', description='$description' "
				. "ON DUPLICATE KEY UPDATE hits = hits + 1 ";
			$res = DB::instance()->query($query);

			$affected = mysql_affected_rows();
			$insert_id = mysql_insert_id();

			if ($affected == 0) {
				$retval = FALSE;
			} else if ($affected == 1) { // lock acquired
				$retval = TRUE;

			} else if ($affected == 2) { // no lock acquired because someone has it already
				$retval = FALSE;

				$query = "SELECT * FROM locks WHERE UID='$uid' ";
				$res = DB::instance()->query($query);
				$lock = mysql_fetch_assoc($res);
				// print_r($lock);
				if ($lock['AUTH_ID'] == $session->AUTH_ID) { // their lock
					$retval = TRUE;
				}

			} else {
				$retval = FALSE;
				throw new Exception("Logic Exception in Lock::get()");
			}
			// print_r(compact('retval', 'affected'));
			return $retval;
		}

		static	function check($uid) {

			$query = "SELECT ID FROM locks WHERE UID='$uid' ";
			$res = DB::instance()->query($query);

			$num = mysql_num_rows($res);

			if($num >= 1) {
				return TRUE;
			}

			return FALSE;
		}


		static	function remove_locks_on_logout($authid) {

			$query = "DELETE FROM locks WHERE AUTH_ID = '$authid'";
			$res = DB::instance()->query($query);

		}

		/**
		 * Free a lock
		 **/
		static function free($uid) {
			$query = "DELETE FROM locks WHERE UID='$uid' ";
			$res = DB::instance()->query($query);
			return $res ? TRUE : FALSE;
		}

		/**
		 * get details on a lock
		 **/
		function details($uid) {
			$query = "SELECT * FROM locks WHERE UID='$uid' ";
			$res = DB::instance()->query($query);
			if (!$res) return NULL;
			$details = mysql_fetch_assoc($res);
			$details['age'] = time() - $details['TIMESTAMP'];

			$query = "SELECT * FROM auth WHERE ID='{$details['AUTH_ID']}'  ";
			$res = DB::instance()->query($query);
			$user = mysql_fetch_assoc($res);

			$details['user'] = $user;

			return $details;
		}

		/**
		 * What to do when a lock acquire fails
		 **/
		function failure($lockid) {
			header("Location: main.php?resource_locked=$lockid");
			exit;
		}
	}
