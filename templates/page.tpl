

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta name="author" content="{$author}" />
	<meta http-equiv="content-type" content="text/html;charset=iso-8859-1" />
	<link rel="stylesheet" href="css/style.css" type="text/css" />

	<title>{$title}</title>
</head>
<body>
	<div class="content">
		<div class="header">
			<div class="top_info">
				<div class="top_info_right">
					{if $session->response}
						<b>Last Update:</b><br>
						{$session->response.message}
					{/if}
				</div>		
				<div class="top_info_left">

					{if $session->logged_in}
					Logged in as <b>{$session->username}</b> on <b>{$session->login_time|date_format}</b>
					<a href="logout.php">Logout</a>
					{/if}

				</div>
			</div>
			<div class="logo">
				<h1><a href="{$self}" title="{$title}"><span class="dark">Switch</span>Manager</a></h1>
			</div>
		</div>
		
		{include file="navbar.tpl"}
		{include file="$template"}

		{** include file="rightbox.tpl" **}

		{** include file="footer.tpl" **}

	</div>
</body>
</html>
