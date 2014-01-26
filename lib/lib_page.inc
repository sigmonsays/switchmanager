<?
	class Page {

		private $page_data;
		private $_page_data;

		function get_smarty() {
			static $smarty_instance;
			if (!$smarty_instance) {
				$smarty_instance = new Smarty();
				$smarty->plugins_dir[] = 'plugins';
			}
			return $smarty_instance;
		}

		function get_template() {
			if (empty($this->_template)) $this->_template = "page.tpl";
			return $this->_template;
		}
		function set_template($template) {
			$this->_template = $template;
		}

		function __get($k) {
			return $this->page_data[$k];
		}
		function __set($k, $v) {
			$this->page_data[$k] = $v;
		}
		function display() {
			$smarty = self::get_smarty();
			$template = $this->get_template();

			foreach($this->page_data AS $k => $v) {
				$smarty->assign($k, $v);
			}
			echo $smarty->fetch($template);
		}

		function instance() {
			static $inst;
			if (!$inst) {
				$inst = new Page();
				$inst->navbar = array(
					array( 	'url' 	=> "/switchmanager/main.php",
						'title'	=> "Main",
						'key' 	=> "i",
					),

					array( 	'url' 	=> "/switchmanager/devices.php",
						'title'	=> "Devices",
						'key' 	=> "d",
					),

					array( 	'url' 	=> "/switchmanager/locks.php",
						'title'	=> "Locks",
						'key' 	=> "l",
					),

				);

				$inst->author = "Switch Man Dude";

			}
			return $inst;
		}

		function set_multi($hash) {
			foreach($hash AS $k => $v) {
				$this->$k = $v;
			}
			return TRUE;
		}
	}

?>
