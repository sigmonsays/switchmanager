<div class="bar">
<ul>
{foreach from=$navbar item=nav}
	<li {if $SCRIPT_NAME == $nav.url} class="active" {/if}><a href="{$nav.url}" accesskey="{$nav.key}">{$nav.title}</a></li>
{/foreach}
</ul>
</div>
