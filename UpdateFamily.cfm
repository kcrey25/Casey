<cfparam name="url.namecol" default="">
<cfparam name="url.name" default="">
<cfparam name="url.id" default="">
<cfoutput>
	<cfif url.update EQ "name">
		<cfquery
			username="#request.myDBUserName#"
			password="#request.myDBPassword#"
			datasource="#request.myDSN#"
			name="UpdateName">
				UPDATE Family SET #url.namecol# = '#url.name#' WHERE ID = '#url.id#'
		</cfquery>
	<cfelseif url.update EQ "story">
		<cfquery
			username="#request.myDBUserName#"
			password="#request.myDBPassword#"
			datasource="#request.myDSN#"
			name="UpdateFamily">
				UPDATE Family SET STORIES = '#form.editor1#' WHERE ID = '#url.id#';
		</cfquery>
	</cfif>
</cfoutput>