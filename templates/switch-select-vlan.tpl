<select name="switch_data[{$k}][vmVlan]">
	<option value="">:: vlan ::</option>
	{foreach from=$switch_vlans item=vlan}
	<option {if $vlan == $sw.vmVlan} selected {/if} value="{$vlan}"> {$vlan} </option>
	{/foreach}
</select> 
