<select name="switch_data[{$k}][portAdminSpeed]">
	<option value="">:: port speed ::</option>
	{foreach from=$oid_translations.portAdminSpeed item=ps}
	<option {if $ps.key1 == $sw.portAdminSpeed} selected {/if} value="{$ps.key1}"> {$ps.value_desc} </option>
	{/foreach}
</select> 
