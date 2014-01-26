{debug}

<br>
<center>
	<div style="width: 400px; border: 2px solid red; text-align:center;">
		<h1>Locked Resource</h1>
		This resource has been locked by the user {$details.user.username},
		{if $details.user.admin}
			who is an administrator
		{else}
			who is a regular user
		{/if}
		<br><br>

		This lock is {$details.age|time_ago} old

		<h3>Details</h3>
		<b>Lock #</b> {$details.ID} <br>
		<b>Locked Resource:</b> {$details.UID} <br>
		<b>Locked Auth ID:</b> {$details.AUTH_ID} <br>
		<b>Locked Timestamp:</b> {$details.TIMESTAMP|date_format} ( {$details.TIMESTAMP} )<br>
		<b>Locked IP:</b> {$details.IP} <br>
		<b>Locked Description:</b> {$details.description} <br>
		<b>Lock Hits:</b> {$details.hits} <br>
	</div>
</center>
<br>

