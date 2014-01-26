<div style="text-align: center;">
	<form method="post" action="login.php">
	<input type="hidden" name="action" value="login">

	{if $retval == FALSE && $action == "login" }
		<span style="color: red;"><b>Invalid Login. Please try again.</b></span>
	{/if}

	{if $logged_out}
		<h2>Your locks have been cleared.</h2>
	{/if}
	{if $session->logged_in}
		<span style="color: blue;"><b>You are already logged in.
			<a href="logout.php">Logout</a>
		</span>
	{/if}
	<table width="200" align="center">

		<tr>
			<td colspan=2 align="center">
				<b>Login required to access</b>
			</td>
		</tr>
		<tr>
			<td><b>Username</b></td>
			<td><input type="text" name="username" value="{$username}"></td>
		</tr>
		<tr>
			<td><b>Password</b></td>
			<td><input type="password" name="password"></td>
		</tr>
		<tr>
			<td colspan=2 align="center">
			<input type="submit" value="Login">
			</td>
		</tr>
	</table>
	</form>
</div>
