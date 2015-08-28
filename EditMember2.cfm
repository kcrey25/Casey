<cfinclude template="CheckSecurityLoggedIn.cfm" />

<cfquery
		username="#request.myDBUserName#"
		password="#request.myDBPassword#"
		datasource="#request.myDSN#"
		name="GetMember">
		SELECT * FROM Family WHERE ID = '#url.id#'
</cfquery>

<cfquery
		username="#request.myDBUserName#"
		password="#request.myDBPassword#"
		datasource="#request.myDSN#"
		name="GetOriginalMember">
		SELECT * FROM UserMain WHERE USERNAME = '#Session.UName#'
</cfquery>

<!--- If this is true then it will update the picture on the usermain table because it is the original user. --->
<cfset orignalMember = (GetOriginalMember.ID EQ GetMember.USER_ID)? 1 : 0>


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
</cfif>
<!--- End of insert File --->

<!--- This will update the original member if the one being edited is that member. --->
<cfif orignalMember AND isDefined("jason.serverFile")>
	<cfquery
			username="#request.myDBUserName#"
			password="#request.myDBPassword#"
			datasource="#request.myDSN#"
			name="UpdateMember">
			UPDATE UserMain SET PIC = '#jason.serverFile#' WHERE ID = '#GetOriginalMember.ID#'
	</cfquery>
</cfif>
	
<!--- This updates the Member --->
<cfquery
		username="#request.myDBUserName#"
		password="#request.myDBPassword#"
		datasource="#request.myDSN#"
		name="UpdateMember">
		UPDATE Family SET FIRSTNAME = '#form.firstname#', LASTNAME = '#form.lastname#'<cfif isDefined("jason.serverFile")>, PIC = '#jason.serverFile#'</cfif> WHERE ID = '#url.id#'
</cfquery>


<cflocation url="MyFamily.cfm?id=#url.id#">



