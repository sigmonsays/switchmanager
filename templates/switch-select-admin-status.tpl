<span style="background-color: green; padding: 5px;">
	<input type="radio" {if $sw.ifAdminStatus == "1"}checked{/if} name="switch_data[{$k}][ifAdminStatus]" value="1">
</span>
<span style="background-color: red; padding: 5px;">
	<input type="radio" {if $sw.ifAdminStatus == "2"}checked{/if} name="switch_data[{$k}][ifAdminStatus]" value="2">
</span>
