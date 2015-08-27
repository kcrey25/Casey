<cfmail	from="casey@christensen.org"
			to="casey.christensen2@canyonsdistrict.org"
			subject="Personal Account Info"
			server = "email.canyonsdistrict.org"
			type = "HTML">
	<cfoutput>
		#form.editor1#
	</cfoutput>
</cfmail>
<cflocation url="Account.cfm">