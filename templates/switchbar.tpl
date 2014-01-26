<div class="search_field">
	<form method="get" action="?">

	Select switch  <select name="switchid" onchange="this.form.submit();">
		<option value="">:: Select Switch ::</option>
		{foreach from=$switches key=id item=sw}
		<option {if $switchid == $id}selected{/if} value="{$sw.switchid}">{$sw.description}</option>
		{/foreach}
	</select>
	</form>
</div>

