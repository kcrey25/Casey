<cfinclude template="CheckSecurityLoggedIn.cfm" />

<cfquery
	username="#request.myDBUserName#"
	password="#request.myDBPassword#"
	datasource="#request.myDSN#"
	name="GetUserID">
		SELECT * FROM UserMain WHERE USERNAME = '#Session.UName#'
</cfquery>

<cfset currentDirectory = getDirectoryFromPath( getCurrentTemplatePath() ) />
<cfset currentDirectory = currentDirectory & "User-Files\" & GetUserID.ID>
<!---
<!--- Insert File --->
<cfif isDefined("form.thefile") AND len(#form.thefile#) GT 0>
	<cffile 
		action="upload" 
		fileField="thefile"
		destination="#currentDirectory#" 
		nameConflict="MakeUnique"
		result="jason"
	>
</cfif>
<!--- End of insert File --->

<cflocation url="MyFiles.cfm">
--->

<!---
	The Name field represents the filename as it exists on the client
	machine.
--->
<cfparam name="form.name" type="string" />

<!---
	The File field represents the TMP file into which the binary 
	data of the upload is being stored. This can be accessed via 
	CFFile/Upload.
--->
<cfparam name="form.file" type="string" />


<!--- Sleep for a brief period to allow UI a chance to show. --->
<!--- ------------------------------------------------------ --->
<cfset sleep( 1000 ) />
<!--- ------------------------------------------------------ --->


<!--- Save the file to the uploads directory. --->
<cffile
	result="upload"
	action="upload"
	filefield="file"
	destination="#currentDirectory#"
	nameconflict="makeunique"
	/>

<!--- Return a success message. --->
<cfheader
	statuscode="201"
	statustext="Created"
	/>