<cfinclude template="CheckSecurityLoggedIn.cfm" />

<cfquery
		username="#request.myDBUserName#"
		password="#request.myDBPassword#"
		datasource="#request.myDSN#"
		name="GetMember">
		SELECT * FROM Family WHERE ID = '#url.id#'
</cfquery>

<!--- If this is true then it will update the picture on the usermain table because it is the original user. --->
<cfset orignalMember = (url.id EQ GetMember.USER_ID)? 1 : 0>

<cfif orignalMember>

<cfset oldpic = GetMember.PIC>

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


	
	<!--- This updates the spouse_id of the parent's spouse if they have one. --->
	<cfif GetParents.recordcount>
		<cfquery
				username="#request.myDBUserName#"
				password="#request.myDBPassword#"
				datasource="#request.myDSN#"
				name="UpdateMember">
				UPDATE Family SET FIRSTNAME = '#form.firstname#', LASTNAME = '#form.lastname#' WHERE ID = url.id
		</cfquery>
	</cfif>


<cflocation url="MyFamily.cfm?id=#url.id#">







