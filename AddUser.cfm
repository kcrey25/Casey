<cfif isDefined('form.theuser') AND isDefined('form.txtpass')>

	<cfset variables.salt = Hash(GenerateSecretKey("AES"), "SHA-512") /> 
	<!--- could use Rand("SHA1PRNG") instead of GenerateSecertKey() --->

	<cfset variables.hashedPassword = Hash(form.txtpass & variables.salt, "SHA-512") />
	<!--- insert both variables.salt and variables.hashedPassword into table --->

	<cfquery
			username="#request.myDBUserName#"
			password="#request.myDBPassword#"
			datasource="#request.myDSN#"
			name="checkDupEntry">
			SELECT *
			FROM UserMain
			WHERE USERNAME = '#form.theuser#'
	</cfquery>
	<cfif checkDupEntry.recordcount GT 0>
		<cflocation url="SignUp.cfm?message=2">
	</cfif>

	<cfquery
			username="#request.myDBUserName#"
			password="#request.myDBPassword#"
			datasource="#request.myDSN#"
			name="InsertUser">
			INSERT INTO UserMain(FIRSTNAME, LASTNAME, EMAIL, USERNAME, PASSWORD, ALEVEL, LAST_LOGIN, SALT, STATUS)
			VALUES('#form.txtfName#',
					'#form.txtlName#',
					'#form.txtEmail#',
					'#form.theuser#',
					'#variables.hashedPassword#',
					0,
					getDate(),
					'#variables.salt#',
					'Active')
	</cfquery>
	<cfquery
			username="#request.myDBUserName#"
			password="#request.myDBPassword#"
			datasource="#request.myDSN#"
			name="GetUserID">
			SELECT *
			FROM UserMain
			WHERE USERNAME = '#form.theuser#'
	</cfquery>
	<cfquery
			username="#request.myDBUserName#"
			password="#request.myDBPassword#"
			datasource="#request.myDSN#"
			name="setFamilyID">
			UPDATE UserMain
			SET FAMILY_ID = '#GetUserID.ID#'
			WHERE USERNAME = '#form.theuser#'
	</cfquery>
	<cfset Session.UName = form.theuser>
	<cfset Session.Name = form.txtfName & ' ' & form.txtlName>
	<cfset Session.ALevel = 0>
	<cfquery
			username="#request.myDBUserName#"
			password="#request.myDBPassword#"
			datasource="#request.myDSN#"
			name="GetUserID">
			INSERT INTO Family(USER_ID, FIRSTNAME, LASTNAME)
			VALUES('#GetUserID.ID#', '#form.txtfName#', '#form.txtlName#')
	</cfquery>
	
	<cflocation url="SignUpThanks.cfm">
</cfif>
<cflocation url="SignUp.cfm?message=3">