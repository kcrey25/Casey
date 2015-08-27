<!--- Store the user id in session variables and cookies. --->
    <!--cfset Session.userID = ""-->
	<cfset Session.UName = "">
	<cfset Session.ALevel = "">
	<cfset Session.isLoggedIn = false>
    <cflocation url="Start.cfm">
