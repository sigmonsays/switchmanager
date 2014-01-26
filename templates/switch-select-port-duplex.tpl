
<select name="switch_data[{$k}][portDuplex]">
	<option value="">:: duplex ::</option>
	{foreach from=$oid_translations.portDuplex item=pd}
	<option {if $sw.portDuplex == $pd.key1} selected {/if} value="{$pd.key1}"> {$pd.value_desc} </option>
	{/foreach}
</select> 
