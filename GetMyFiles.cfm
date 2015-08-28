<cfinclude template="CheckSecurityLoggedIn.cfm" />

<cfparam name="url.iDisplayStart" default="0" type="integer" />
<cfparam name="url.iDisplayLength" default="10" type="integer" />
<cfparam name="url.sEcho" default="" type="string" />
<cfparam name="url.sSearch" default="" type="string" />
<cfparam name="url.iSortingCols" default="0" type="integer" />

<cfprocessingdirective suppresswhitespace="yes">
    
<cfquery
	username="#request.myDBUserName#"
	password="#request.myDBPassword#"
	datasource="#request.myDSN#"
	name="GetUserID">
		SELECT * FROM UserMain WHERE USERNAME = '#Session.UName#'
</cfquery>

<cffunction name="GetAlevel" returnType="string">
	<cfargument name="thelevel" required="yes">
    <cfsavecontent variable="actions">
        <cfoutput>
            <input class="alevel-input form-control" data-alevel="alevel" value="#thelevel#" data-id="#TheUsers['username'][i]#">
            <span style="display:none; padding: 5px;" data-id="#TheUsers['username'][i]#" class="alevel alert-success" title="Saved!">Saved! <span class="glyphicon glyphicon-ok"></span></span>
        </cfoutput>
    </cfsavecontent>
    
    <cfreturn Replace(Replace(Replace(jsStringFormat(actions), '\r\n', '', "ALL"), '\t', '', "ALL"), '\', '', "ALL") />
</cffunction>

<cffunction name="GetAction">
	<cfset currentDirectory = getDirectoryFromPath( getCurrentTemplatePath() ) />
	<cfset currentDirectory = currentDirectory & "User-Files\" & GetUserID.ID>

	<cfdirectory action="list" directory="#currentDirectory#" name="listRoot">
	
    <cfset filename = listRoot.name[i] />
    
    <cfsavecontent variable="actions">
        <cfoutput>
            <a class='event-action-link' onclick='javascript:deleteEvent("#filename#")' data-toggle='tooltip' title='Delete'><i class='fa fa-trash-o'></i> </a>
        </cfoutput>
    </cfsavecontent>
    
    <cfreturn Replace(Replace(Replace(jsStringFormat(actions), '\r\n', '', "ALL"), '\t', '', "ALL"), '\', '', "ALL") />
</cffunction>


<!--- Get and list of all the files in the user's folder --->
<cffunction name="GetModDate">
	<cfset currentDirectory = getDirectoryFromPath( getCurrentTemplatePath() ) />
	<cfset currentDirectory = currentDirectory & "User-Files\" & GetUserID.ID>

	<cfdirectory action="list" directory="#currentDirectory#" name="listRoot">
	<cfsavecontent variable="files">
		<cfoutput>
			#DateFormat(listRoot.datelastmodified[i], "medium")# At #TimeFormat(listRoot.datelastmodified[i], "medium")#<br />
		</cfoutput>
	</cfsavecontent>
    
    <cfreturn Replace(Replace(Replace(jsStringFormat(files), '\r\n', '', "ALL"), '\t', '', "ALL"), '\', '', "ALL") />
</cffunction>
<!--- End of list of all the files in the user's folder --->

<!--- Get and list of the file's modified date/time --->
<cffunction name="GettheFile">
	<cfset currentDirectory = getDirectoryFromPath( getCurrentTemplatePath() ) />
	<cfset currentDirectory = currentDirectory & "User-Files\" & GetUserID.ID>
	<cfset thelink = "http://localhost:8500/Casey/User-Files/" & GetUserID.ID>

	<cfdirectory action="list" directory="#currentDirectory#" name="listRoot">
	<cfsavecontent variable="files">
		<cfoutput>
			<a target="_blank" href="#thelink#/#listroot.name[i]#">#listroot.name[i]#</a><br />
		</cfoutput>
	</cfsavecontent>
    
    <cfreturn Replace(Replace(Replace(jsStringFormat(files), '\r\n', '', "ALL"), '\t', '', "ALL"), '\', '', "ALL") />
</cffunction>
<!--- End of list all of the files in the user's folder --->



<cfoutput>
	<cfset currentDirectory = getDirectoryFromPath( getCurrentTemplatePath() ) />
	<cfset currentDirectory = currentDirectory & "User-Files\" & GetUserID.ID>
	<cfdirectory action="list" directory="#currentDirectory#" name="listRoot">
	<cfset times = 0>
	<cfloop query="listRoot">
		<cfset times++>
	</cfloop>
    <cfscript>
        Users = StructNew();
        
        // Datatable defaults //
        Users["sEcho"] = url.sEcho;
        Users["aaData"] = ArrayNew(1);
        from = 1;
        to = times;
        for (i = from; i <= to; i++) 
		{
            LogData = StructNew();
			
            //WriteDump(TheUsers);
             
            logData["NUM"] = i;        
            logData["FILENAME"] = GettheFile();     
			logData["MODTIME"] = GetModDate();
			logData["ACTION"] = GetAction();
            
            // push the new structure onto the whole structure //
            ArrayAppend(Users.aaData, logData);
        }
    </cfscript>
   #SerializeJSON(Users)#
</cfoutput>
</cfprocessingdirective>