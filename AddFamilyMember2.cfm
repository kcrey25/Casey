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

<cfquery
		username="#request.myDBUserName#"
		password="#request.myDBPassword#"
		datasource="#request.myDSN#"
		name="GetParents">
		SELECT * FROM Family WHERE CHILDREN_GROUP = '#url.id#'
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
	<cfset currentDirectory = currentDirectory & jason.serverFile>
	<cfset FileDir = getDirectoryFromPath( getCurrentTemplatePath() ) />
	<cfset FileDir = FileDir & "User-Files\" & GetOriginalMember.ID & "\">
	<cffile 
		action="copy" 
		source="#currentDirectory#"
		destination="#FileDir#"
	>
</cfif>
<!--- End of insert File --->

<!--- This is the Gender col --->
<cfset thegender = (form.relation EQ "Brother" OR form.relation EQ "Father" OR form.relation EQ "Son")? "M" : "F">


<!---------------------------- This is for Adding PARENTS. -------------------------->
<cfif form.relation EQ "Mother" OR form.relation EQ "Father">
	
	<!--- This inserts the new Parent --->
	<cfquery
			username="#request.myDBUserName#"
			password="#request.myDBPassword#"
			datasource="#request.myDSN#"
			name="AddMember"
			result="addpar">
			INSERT INTO Family (USER_ID, FIRSTNAME, LASTNAME, CHILDREN_GROUP, PIC, GENDER<cfif GetParents.recordcount>, SPOUSE_ID</cfif>)
				VALUES ('#GetMember.USER_ID#', '#form.firstname#', '#form.lastname#', '#url.id#', '#jason.serverFile#', '#thegender#'
				<cfif GetParents.recordcount>, '#GetParents.ID#'</cfif>)
	</cfquery>
	
	<!--- This updates the spouse_id of the parent's spouse if they have one. --->
	<cfif GetParents.recordcount>
		<cfquery
				username="#request.myDBUserName#"
				password="#request.myDBPassword#"
				datasource="#request.myDSN#"
				name="UpdateParentSpouse">
				UPDATE Family SET SPOUSE_ID = '#addpar.IdentityCol#' WHERE CHILDREN_GROUP = '#url.id#' AND ID <> '#addpar.IdentityCol#'
		</cfquery>
	</cfif>
<!---------------------------- This is for Adding a Spouse. -------------------------->
<cfelseif form.relation EQ "Spouse">
	<cfset thegender = (GetMember.GENDER EQ "M")? "F" : "M">
	<cfquery
			username="#request.myDBUserName#"
			password="#request.myDBPassword#"
			datasource="#request.myDSN#"
			name="AddTheSpouse"
			result="addspouse">
			INSERT INTO Family (USER_ID, FIRSTNAME, LASTNAME, SPOUSE_ID, PIC, GENDER, CHILDREN_GROUP)
				VALUES ('#GetMember.USER_ID#', '#form.firstname#', '#form.lastname#', '#url.id#', '#jason.serverFile#', '#thegender#', 
				'#GetMember.CHILDREN_GROUP#')
	</cfquery>
	<cfquery
			username="#request.myDBUserName#"
			password="#request.myDBPassword#"
			datasource="#request.myDSN#"
			name="UpdateSpouse">
			UPDATE Family SET SPOUSE_ID = '#addspouse.IdentityCol#' WHERE ID = '#url.id#'
	</cfquery>
	
<!---------------------------- This is for Adding Siblings. -------------------------->
<cfelseif form.relation EQ "Brother" OR form.relation EQ "Sister">
	<cfset thesiblinggroup = GetMember.SIBLING_GROUP>
	<cfif GetMember.SIBLING_GROUP EQ "">
		<cfquery
				username="#request.myDBUserName#"
				password="#request.myDBPassword#"
				datasource="#request.myDSN#"
				name="UpdateSibling">
				UPDATE Family SET SIBLING_GROUP = '#url.id#' WHERE ID = '#url.id#'
		</cfquery>
		<cfset thesiblinggroup = url.id>
	</cfif>
	
	<cfquery
			username="#request.myDBUserName#"
			password="#request.myDBPassword#"
			datasource="#request.myDSN#"
			name="AddSibling"
			result="addthesibling">
			INSERT INTO Family (USER_ID, FIRSTNAME, LASTNAME, PIC, GENDER, SIBLING_GROUP)
				VALUES ('#GetMember.USER_ID#', '#form.firstname#', '#form.lastname#', '#jason.serverFile#', '#thegender#', 
				'#thesiblinggroup#')
	</cfquery>
	
<!---------------------------- This is for Adding Children. -------------------------->
<cfelseif form.relation EQ "Daughter" OR form.relation EQ "Son">
	<cfquery
			username="#request.myDBUserName#"
			password="#request.myDBPassword#"
			datasource="#request.myDSN#"
			name="AddChild"
			result="addthekid">
			INSERT INTO Family (USER_ID, FIRSTNAME, LASTNAME, PIC, GENDER<cfif GetMember.CHILDREN_GROUP NEQ "">, SIBLING_GROUP</cfif>)
				VALUES ('#GetMember.USER_ID#', '#form.firstname#', '#form.lastname#', '#jason.serverFile#', '#thegender#' 
				<cfif GetMember.CHILDREN_GROUP NEQ "">, '#GetMember.CHILDREN_GROUP#'</cfif>)
	</cfquery>
	
	<cfquery
			username="#request.myDBUserName#"
			password="#request.myDBPassword#"
			datasource="#request.myDSN#"
			name="GetTheChild">
			SELECT * FROM Family WHERE ID = '#GetMember.CHILDREN_GROUP#'
	</cfquery>
	
	<cfif GetMember.CHILDREN_GROUP EQ "">
		<cfquery
				username="#request.myDBUserName#"
				password="#request.myDBPassword#"
				datasource="#request.myDSN#"
				name="UpdateParents">
				UPDATE Family SET CHILDREN_GROUP = '#addthekid.IdentityCol#' WHERE ID = '#url.id#'
					<cfif GetMember.SPOUSE_ID NEQ ""> OR ID = '#GetMember.SPOUSE_ID#'</cfif>
		</cfquery>
	<cfelseif GetMember.CHILDREN_GROUP NEQ "" AND GetTheChild.SIBLING_GROUP EQ "">
		<cfquery
				username="#request.myDBUserName#"
				password="#request.myDBPassword#"
				datasource="#request.myDSN#"
				name="UpdateNewChildsSiblings">
				UPDATE Family SET SIBLING_GROUP = '#GetMember.CHILDREN_GROUP#' WHERE ID = '#GetTheChild.ID#'
		</cfquery>
	</cfif>
	
</cfif>



<cflocation url="MyFamily.cfm?id=#url.id#">







