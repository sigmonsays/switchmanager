
<h2>Switches</h2>
Click a switch to administrate<br>
{foreach from=$switches key=switchid item=switch}
	 <a href="main.php?switchid={$switchid}">{$switch.description}</a> <br>
{/foreach}
