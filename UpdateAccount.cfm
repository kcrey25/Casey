
<cfquery
		username="#request.myDBUserName#"
		password="#request.myDBPassword#"
		datasource="#request.myDSN#"
		name="UNameExists">
		SELECT *
		FROM UserMain
		WHERE USERNAME = '#form.theUserName#'
</cfquery>

<!--- Insert File --->
<cfif isDefined("form.pic") AND len(#form.pic#) GT 0>
	<cfset currentDirectory = getDirectoryFromPath( getCurrentTemplatePath() ) />
	<cfset currentDirectory = currentDirectory & "User-Uploads\">
	<cffile 
		action="upload" 
		fileField="pic"
		destination="#currentDirectory#" 
		nameConflict="MakeUnique" 
		accept="image/*" 
		result="jason"
	>
	<cfif UNameExists.PIC NEQ "">
		<cffile action="delete"	file="#currentDirectory##UNameExists.PIC#">
	</cfif>
</cfif>
<!--- End of insert File --->

<cfif UNameExists.recordcount && (form.theUserName NEQ Session.UName)>
	<cflocation url="Account.cfm?message=2">
<cfelse>
	<cfquery							
			username="#request.myDBUserName#"
			password="#request.myDBPassword#"
			datasource="#request.myDSN#"
			name="Userstuff">
			Update UserMain
			SET FIRSTNAME = '#form.thefName#', LASTNAME = '#form.thelName#', EMAIL = '#form.theEmail#', USERNAME = '#form.theUserName#', ACCOUNT_INFO = '#form.editor1#'<cfif isDefined("jason.serverFile")>, PIC = '#jason.serverFile#'</cfif>
			WHERE USERNAME = '#Session.UName#'
	</cfquery>
	<cfif isDefined("jason.serverFile")>	
		<cfquery
			username="#request.myDBUserName#"
			password="#request.myDBPassword#"
			datasource="#request.myDSN#"
			name="forID">
				SELECT *
				FROM UserMain
				WHERE USERNAME = '#form.theUserName#'
		</cfquery>
		<cfquery							
			username="#request.myDBUserName#"
			password="#request.myDBPassword#"
			datasource="#request.myDSN#"
			name="UpdateFamilyPic">
				Update Family
				SET PIC = '#jason.serverFile#'
				WHERE USER_ID = '#forID.ID#' AND FIRSTNAME = '#form.thefName#' AND LASTNAME = '#form.thelName#'
		</cfquery>
	</cfif>
	<cfset Session.UName = form.theUserName>
	<cfset Session.Name = form.thefName & ' ' & form.thelName>
	
</cfif>

<cflocation url="Account.cfm?message=3">