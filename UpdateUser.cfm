<cfif isDefined("url.action") AND url.action EQ "delete">
	<cfquery	
		username="#request.myDBUserName#"
		password="#request.myDBPassword#"
		datasource="#request.myDSN#"
		name="Userstuff">
		Update UserMain
		SET ALEVEL = 0, STATUS = 'Inactive'
		WHERE USERNAME = '#url.username#'
	</cfquery>
<cfelse>
	<cfquery
			username="#request.myDBUserName#"
			password="#request.myDBPassword#"
			datasource="#request.myDSN#"
			name="Userstuff">
			Update UserMain
			SET ALEVEL = '#url.value#'
			WHERE USERNAME = '#url.username#'
	</cfquery>
</cfif>