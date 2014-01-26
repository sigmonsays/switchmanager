<h2 align="center">Acquired Locks</h2>
<table width="500" align="center">

{foreach name=lock from=$locks item=lock}

	{if $smarty.foreach.lock.first}
	<tr>
		<td><b>UID</b></td>
		<td><b>Username</b></td>
		<td><b>Description</b></td>
		<td><b>Workstation IP</b></td>
		<td><b>Date Acquired</b></td>
		<td> </td>
	</tr>
	{/if}

	<tr>
		<td> {$lock.UID}</td>
		<td> {$lock.username}</td>
		<td> {$lock.description} </td>
		<td> {$lock.IP} </td>
		<td> {$lock.TIMESTAMP|date_format} </td>
		<td><a href="locks.php?action=remove&UID={$lock.UID}">remove</a> </td>
	</tr>
{foreachelse}

	No Locks Present 
{/foreach}

</table>
