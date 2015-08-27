<cfif not isDefined("minAlevel")>
	<cfset minALevel = 1 />
</cfif> 

<cfif (not isDefined("Session.UName") or not isDefined("Session.ALevel")) or (Session.UName eq "")>
    <cflocation url="login.cfm?message=4" />
<cfelseif session.ALevel LT minALevel>
    <cflocation url="login.cfm?message=2&id=#Session.ALevel#" />
</cfif>
    
   