<cfinclude template="CheckSecurityLoggedIn.cfm" />

<cfquery
	username="#request.myDBUserName#"
	password="#request.myDBPassword#"
	datasource="#request.myDSN#"
	name="GetUserID">
		SELECT * FROM UserMain WHERE USERNAME = '#Session.UName#'
</cfquery>


<cfif IsDefined("url.id")>
	<cfset currentDirectory = getDirectoryFromPath( getCurrentTemplatePath() ) />
	<cfset currentDirectory = currentDirectory & "User-Files\" & GetUserID.ID & "\" & url.id>

	<cfscript> 
		FileDelete(#currentDirectory#);
	</cfscript>
	<cfoutput>
		<div class="alert-success">
			Success!!!
		</div>
	</cfoutput>
</cfif>

