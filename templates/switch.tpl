{include file="switchbar.tpl"}


{if $switchid > 0}

	<form method="post" action="servlet.php">
	<input type="hidden" name="action" value="save_switch_settings">
	<input type="hidden" name="switchid" value="{$switchid}">

	<div class="left">
		<h3>{$switch.description} General</h3>
		<div class="left_box">

			<b>IP</b>: {$switch.host} <br>
			<b>Description</b>: {$switch.description} <br>

			{foreach from=$switch_info key=k item=info}
			<b>{$k}</b>: {$info}<br>
			{/foreach}

		</div>
	</div>	


	<div class="left">
		<h3>{$switch.description} Interfaces</h3>
		<div class="left_box">

		<div id="save-box" style="padding-top: 5px; height: 50px;">
			<div style="float: right;">
				<input type="submit" value="Save Changes">
			</div>
		</div>

		<table width="100%" border="0" align="center">
		<tr>
		{foreach from=$switch_fields key=k item=sf }
			<td><b>{$sf}</b></td>
		{/foreach}
			<td><b>Admin Up</b></td>
		</tr>
		{foreach from=$switch_data key=k item=sw }
			<tr>
				<td><b>{$sw.ifName}</b></td>
				<td colspan=2>
					{if $sw.ifAdminStatus == "1" && $sw.ifOperStatus == "1"}
						<div style="color: white; background-color: green;">up/up</div>
					{elseif $sw.ifAdminStatus == "1" && $sw.ifOperStatus == "2"}
						<div style="color: white; background-color: red;">up/down</div>
					{elseif $sw.ifAdminStatus == "2" && $sw.ifOperStatus == "2"}
						<div style="color: white; background-color: grey;">down/down</div>
					{elseif $sw.ifAdminStatus == "2" && $sw.ifOperStatus == "1"}
						????
					{else}
						????
					{/if}
				</td>

				{if $sw.ifLastChange < 300}

					<td>{include file="switch-select-alias.tpl"}</td>
					<td>{include file="switch-select-vlan.tpl"}</td>
					<td>{include file="switch-select-port-admin-speed.tpl"}</td>
					<td>{include file="switch-select-port-duplex.tpl"}</td>
					<td>{include file="switch-select-admin-status.tpl"}</td>
				{else}
					<td colspan="5"> -- </td>
				{/if}
			</tr>
		{/foreach}
		</table>

		</div>
	</div>	

	</form>


{else}
	<h2>select a switch to continue</h2>
{/if}
