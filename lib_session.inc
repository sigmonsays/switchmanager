<?
	class User_Session {

		function start($redirect = 1) {
			session_start();
			if ($this->logged_in == 0 && $redirect == 1) {
				header("Location: login.php");
				exit;
			}
		}

		function __get($k) {
			return $_SESSION[$k];
		}
		function __set($k, $v) {
			$_SESSION[$k] = $v;
		}

		function instance() {
			static $inst;
			if (!$inst) {
				$inst = new User_Session();
			}
			return $inst;
		}

		function destroy() {
			session_destroy();
		}
	}
