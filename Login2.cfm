<cfset Session.Alevel = 0>
<cfset Session.isLoggedIn = false>
<cfset Session.Uname = "">
<cfif isDefined('form.UserName') AND isDefined('form.Password')>	
	<!--- Do some validation here--->
	<cfquery
		username="#request.myDBUserName#"
		password="#request.myDBPassword#"
		datasource="#request.myDSN#"
		name="GetUser">
		SELECT *
		FROM UserMain
		WHERE UserMain.USERNAME='#Form.UserName#';
	</cfquery>
	
	<cfset variables.salt = GetUser.SALT /> 
	<!--- could use Rand("SHA1PRNG") instead of GenerateSecertKey() --->

	<cfset variables.hashedPassword = Hash(form.Password & variables.salt, "SHA-512") />
	<!--- insert both variables.salt and variables.hashedPassword into table --->
	
	
	<cfif GetUser.recordcount GT 0 AND form.UserName EQ GetUser.USERNAME AND variables.hashedPassword EQ GetUser.PASSWORD>
		<cfset Session.isLoggedIn = true>
		<cfset Session.Uname = form.UserName>
		<cfset Session.Name = GetUser.FIRSTNAME & ' ' & GetUser.LASTNAME>
		<cfset Session.Alevel = GetUser.ALEVEL>
		<!--- This updates the Last Login Date. --->
		<cfquery
			username="#request.myDBUserName#"
			password="#request.myDBPassword#"
			datasource="#request.myDSN#"
			name="updateLogin">
			UPDATE UserMain
			SET LAST_LOGIN = GetDate()
			WHERE USERNAME = '#Form.UserName#';
		</cfquery>
		<cflocation url="Start.cfm">
	</cfif>
	<cfif GetUser.recordcount EQ 0 || !Session.isLoggedIn>
		<cfset Session.isLoggedIn = false>
		<cfset UserSearchFailed = true>
		<cfset loginpage = "Login.cfm?Message=3">
		<cfset loginpage = loginpage & "&UserName=" & URLEncodedFormat(Form.UserName)>
		<cflocation url="#loginpage#">
	</cfif>
<cfelse>
	<cflocation url="login.cfm?message=5">
</cfif>