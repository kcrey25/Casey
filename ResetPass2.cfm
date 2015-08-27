

<cfif isDefined('url.conp') AND isDefined('url.newp') AND isDefined('url.curp')>
	
	<cfinvoke component = "OldPassCheck" method = "compare_pass" returnVariable = "isConf">		
		<cfinvokeargument name="thepass" value="#url.curp#">
	</cfinvoke>
		
		
	<cfif !isConf>
		<cflocation url="ResetPass.cfm?message=6">
	<cfelseif len(url.newp) LT 4>
		<cflocation url="ResetPass.cfm?message=5">
	</cfif>
	<cfset variables.salt = Hash(GenerateSecretKey("AES"), "SHA-512") /> 
	<!--- could use Rand("SHA1PRNG") instead of GenerateSecertKey() --->

	<cfset variables.hashedPassword = Hash(url.newp & variables.salt, "SHA-512") />
	<!--- insert both variables.salt and variables.hashedPassword into table --->
	<cfquery
			username="#request.myDBUserName#"
			password="#request.myDBPassword#"
			datasource="#request.myDSN#"
			name="checkDupEntry">
			UPDATE UserMain
			SET PASSWORD = '#variables.hashedPassword#', SALT = '#variables.salt#'
			WHERE UserName = '#Session.UName#'
	</cfquery>
	<cflocation url="ResetPass.cfm?message=1">
<cfelse>
	<cflocation url="ResetPass.cfm?message=4">
</cfif>