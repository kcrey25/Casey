
<cfset request.StartTime= GetTickCount()>

<cfapplication
    name="CFWheels"
    sessionmanagement="Yes"
    clientmanagement="Yes"
    applicationtimeout= #CreateTimeSpan(0,2,0,0)#
    sessiontimeout= #CreateTimeSpan(0,0,60,0)#>

<cfif IsDefined( "Cookie.CFID" ) AND IsDefined( "Cookie.CFTOKEN" )>
    <cfset localCFID = Cookie.CFID>
    <cfset localCFTOKEN = Cookie.CFTOKEN>
    <cfcookie name="CFID" value="#localCFID#">
    <cfcookie name="CFTOKEN" value="#localCFTOKEN#">
</cfif>

<cfscript>
    request.myDBUserName = "";
    request.myDBPassword = "";
    request.myDSN = "CFWheels";
    request.shimWidth = "20";
</cfscript>

<cfparam name="Session.ALevel" default="">
<cfparam name="Session.UName" default="">


<cfparam name="Session.Csch" default="80">
<cfparam name="Session.Curyear" default="2015">

<cfset STATUS_NAMES=["Active", "Resolved"]>
<cfset RESOLVE_NAMES=["Acceptable Threshold", "Eliminated/Trapped", "Cleaning or Sanitation", "Eliminated Shelter", "Exclusion by Facility Modification", "Landscaping Modification", "Other"]>
<cfset POSITION_NAMES=["Student", "Teacher", "ESP", "Admin", "IPM Site Coordinator", "IPM Administrator"]>


<cfset LOC_NAMES=["Admin", "Teacher", "ESP", "Student", "IPM Site Coordinator"]>

<cfinclude template="../common/AntiSQLi.cfm" />


<!--- The following are notes on how the database is set up 

ID = unique

USER_ID = The ID of the actual user of the site.

FIRSTNAME = The first and any middle or given names of the family member.

LASTNAME = Just the last name of the family member.

SPOUSE_ID = The ID of the husband/wife of the family member.

CHILDREN_GROUP = Group ID of the children. This will be the id of the child that added the parent.

SIBLING_GROUP = Group of brothers and sisters. This will be the id of the first sibling. Is blank until a sibling is added.
	The SIBLING_GROUP will also be used to pull the kids of the parents Using the CHILDREN_GROUP.

PIC = the name and extension of the image uploaded for the family member.

STORIES = stored as html. These are the stories for the individual family member.

GENDER = The gender... M ... or ... F ... of the family member.

--->