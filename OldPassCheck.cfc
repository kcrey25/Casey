<cfcomponent>  

  <!--- This function gets the old password and compares it with the one entered by the user. --->  

  <cffunction name="compare_pass" access="remote" returnformat="plain">  

	<cfargument name="thepass" default="" required="yes">
  
    <cfquery 
		username="#request.myDBUserName#"
		password="#request.myDBPassword#"
		datasource="#request.myDSN#"
		name="CurrentPassword">
			SELECT *
			FROM UserMain
			WHERE USERNAME = '#Session.UName#';
	</cfquery>
	<!--- This will Hash and salt the given password --->
	<cfset currentPass = Hash(thepass & CurrentPassword.SALT, "SHA-512") />
	
    <cfreturn currentPass EQ CurrentPassword.PASSWORD>
  </cffunction>  

</cfcomponent>