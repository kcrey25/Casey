<cfparam name="url.iDisplayStart" default="0" type="integer" />
<cfparam name="url.iDisplayLength" default="10" type="integer" />
<cfparam name="url.sEcho" default="" type="string" />
<cfparam name="url.sSearch" default="" type="string" />
<cfparam name="url.iSortingCols" default="0" type="integer" />

<cfprocessingdirective suppresswhitespace="yes">
    
<cfquery datasource="#request.myDSN#" name="TheUsers" >
	SELECT * 
	FROM UserMain
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
    <cfset userN = TheUsers["USERNAME"][i] />
    
    <cfsavecontent variable="actions">
        <cfoutput>
            <a class='event-action-link' onclick='javascript:deleteEvent("#userN#")' data-toggle='tooltip' data-placement='top' title='Delete'><i class='fa fa-trash-o'></i> </a>
        </cfoutput>
    </cfsavecontent>
    
    <cfreturn Replace(Replace(Replace(jsStringFormat(actions), '\r\n', '', "ALL"), '\t', '', "ALL"), '\', '', "ALL") />
</cffunction>


<cfoutput>
    <cfscript>
        Users = StructNew();
        
        // Datatable defaults //
        Users["sEcho"] = url.sEcho;
        Users["aaData"] = ArrayNew(1);
        from = 1;
        to = TheUsers.RecordCount;
        for (i = from; i <= to; i++) 
		{
            LogData = StructNew();
			
            //WriteDump(TheUsers);
             
            logData["ID"] = TheUsers["ID"][i];        
            logData["NAME"] = TheUsers["FIRSTNAME"][i] & ' ' & TheUsers["LASTNAME"][i];     
			logData["EMAIL"] = TheUsers["EMAIL"][i];
			logData["USERNAME"] = TheUsers["USERNAME"][i];
			logData["ALEVEL"] = GetAlevel(TheUsers["ALEVEL"][i]);
			logData["LAST_LOGIN"] = DateFormat(TheUsers["LAST_LOGIN"][i], "medium") & " " & TimeFormat(TheUsers["LAST_LOGIN"][i]); 
			logData["ACTION"] = GetAction(); 
			logData["STATUS"] = TheUsers["STATUS"][i]; 
            
            // push the new structure onto the whole structure //
            ArrayAppend(Users.aaData, logData);
        }
    </cfscript>
   #SerializeJSON(Users)#
</cfoutput>
</cfprocessingdirective>