<!---
  Created by brayden.lopez on 11/6/13.
--->

<!--- Clean escapes all reserved characters --->

<cffunction name="CleanWhereEq" access="public" returntype="any">
    <cfargument name="toClean" required="yes" type="any"/>

    <cfset toClean = replace(toClean, "'", "''", "All")/>
    <cfreturn toClean/>
</cffunction>

<cffunction name="CleanWhereLike" access="public" returntype="any">
    <cfargument name="toClean" required="yes" type="any"/>

    <cfset toClean = replace(toClean, "'", "''", "All")/>
    <cfset toClean = replace(toClean, "[", "[[]", "All")/>
    <cfset toClean = replace(toClean, "_", "[_]", "All")/>
    <cfset toClean = replace(toClean, "%", "[%]", "All")/>
    <cfreturn toClean/>
</cffunction>

<cffunction name="CleanLdap" access="public" returntype="any">
    <cfargument name="toClean" required="yes" type="any"/>

    <cfset toClean = replace(toClean, "'", "\'", "All")/>
    <cfset toClean = replace(toClean, "\", "\\", "All")/>
    <cfset toClean = replace(toClean, "##", "\##", "All")/>
    <cfset toClean = replace(toClean, "+", "\+", "All")/>
    <cfset toClean = replace(toClean, "<", "\<", "All")/>
    <cfset toClean = replace(toClean, ">", "\>", "All")/>
    <cfset toClean = replace(toClean, ";", "\;", "All")/>
    <cfset toClean = replace(toClean, '"', '\"', "All")/>
    <cfset toClean = replace(toClean, "=", "\=", "All")/>

    <cfreturn toClean/>
</cffunction>

<!--- Purge removes all reserved characters --->

<cffunction name="PurgeWhereEq" access="public" returntype="any">
    <cfargument name="toClean" required="yes" type="any"/>

    <cfset toClean = replace(toClean, "'", "", "All")/>
    <cfreturn trim(toClean)/>
</cffunction>

<cffunction name="PurgeWhereLike" access="public" returntype="any">
    <cfargument name="toClean" required="yes" type="any"/>

    <cfset toClean = replace(toClean, "'", "", "All")/>
    <cfset toClean = replace(toClean, "[", "", "All")/>
    <cfset toClean = replace(toClean, "_", "", "All")/>
    <cfset toClean = replace(toClean, "%", "", "All")/>
    <cfreturn trim(toClean)/>
</cffunction>

<cffunction name="PurgeLdap" access="public" returntype="any">
    <cfargument name="toClean" required="yes" type="any"/>

    <cfset toClean = replace(toClean, "'", "", "All")/>
    <cfset toClean = replace(toClean, "\", "", "All")/>
    <cfset toClean = replace(toClean, "##", "", "All")/>
    <cfset toClean = replace(toClean, "+", "", "All")/>
    <cfset toClean = replace(toClean, "<", "", "All")/>
    <cfset toClean = replace(toClean, ">", "", "All")/>
    <cfset toClean = replace(toClean, ";", "", "All")/>
    <cfset toClean = replace(toClean, '"', '', "All")/>
    <cfset toClean = replace(toClean, "=", "", "All")/>

    <cfreturn trim(toClean)/>
</cffunction>



<!--- Make sure _cleans are not in the form params --->
<cfif IsDefined('form._cleanEq')>
    <cfset structDelete(form, "_cleanEq") />
</cfif>
<cfif IsDefined('form._cleanLike')>
    <cfset structDelete(form, "_cleanLike") />
</cfif>
<cfif IsDefined('form._cleanLdap')>
    <cfset structDelete(form, "_cleanLdap") />
</cfif>

<cfif IsDefined('form._purgeEq')>
    <cfset structDelete(form, "_purgeEq") />
</cfif>
<cfif IsDefined('form._purgeLike')>
    <cfset structDelete(form, "_purgeLike") />
</cfif>
<cfif IsDefined('form._purgeLdap')>
    <cfset structDelete(form, "_purgeLdap") />
</cfif>

<!---Make sure _cleans are not in the url params--->
<cfif IsDefined('url._cleanEq')>
    <cfset structDelete(url, "_cleanEq") />
</cfif>
<cfif IsDefined('url._cleanLike')>
    <cfset structDelete(url, "_cleanLike") />
</cfif>
<cfif IsDefined('url._cleanLdap')>
    <cfset structDelete(url, "_cleanLdap") />
</cfif>

<cfif IsDefined('url._purgeEq')>
    <cfset structDelete(url, "_purgeEq") />
</cfif>
<cfif IsDefined('url._purgeLike')>
    <cfset structDelete(url, "_purgeLike") />
</cfif>
<cfif IsDefined('url._purgeLdap')>
    <cfset structDelete(url, "_purgeLdap") />
</cfif>


<cfloop collection="#form#" item="item">
    <cfset form._cleanEq[#item#] = #CleanWhereEq(form[item])#/>
    <cfset form._cleanLike[#item#] = #CleanWhereLike(form[item])#/>
    <cfset form._cleanLdap[#item#] = #CleanLdap(form[item])#/>

    <cfset form._purgeEq[#item#] = #PurgeWhereEq(form[item])#/>
    <cfset form._purgeLike[#item#] = #PurgeWhereLike(form[item])#/>
    <cfset form._purgeLdap[#item#] = #PurgeLdap(form[item])#/>
</cfloop>

<cfloop collection="#url#" item="item">
    <cfset url._cleanEq[#item#] = #CleanWhereEq(url[item])#/>
    <cfset url._cleanLike[#item#] = #CleanWhereLike(url[item])#/>
    <cfset url._cleanLdap[#item#] = #CleanLdap(url[item])#/>

    <cfset url._purgeEq[#item#] = #PurgeWhereEq(url[item])#/>
    <cfset url._purgeLike[#item#] = #PurgeWhereLike(url[item])#/>
    <cfset url._purgeLdap[#item#] = #PurgeLdap(url[item])#/>
</cfloop>

<!---<cfdump var="#url#" />--->

<!------>
<!---<cfoutput>--->
<!---    <table border="1">--->
<!---        <thead>--->
<!---            <tr>--->
<!---                <td><b>OG</b></td>--->
<!---                <td><b>Where Eq</b></td>--->
<!---                <td><b>Where Like</b></td>--->
<!---                <td><b>LDAP</b></td>--->
<!---            </tr>--->
<!---        </thead>--->
<!---        <tbody>--->
<!---            <tr>--->
<!---                <td>test</td>--->
<!---                <td>#CleanWhereEq('test')#</td>--->
<!---                <td>#CleanWhereLike('test')#</td>--->
<!---                <td>#CleanLdap('test')#</td>--->
<!---            </tr>--->
<!---            <tr>--->
<!---                <td>,\##+<>;"=</td>--->
<!---                <td>#CleanWhereEq(',\##+<>;"=')#</td>--->
<!---                <td>#CleanWhereLike(',\##+<>;"=')#</td>--->
<!---                <td>#CleanLdap(',\##+<>;"=')#</td>--->
<!---            </tr>--->
<!---            <tr>--->
<!---                <td>'[][]}{`~'"}</td>--->
<!---                <td>#CleanWhereEq('''[][]}{`~''"}')#</td>--->
<!---                <td>#CleanWhereLike('''[][]}{`~''"}')#</td>--->
<!---                <td>#CleanLdap('''[][]}{`~''"}')#</td>--->
<!---            </tr>--->
<!---            <tr>--->
<!---                <td>My mom's dad's uncle's brother told him then he dun m***'ed up. Thats right, he dun messed up.</td>--->
<!---                <td>#CleanWhereEq('My mom''s dad''s uncle''s brother told him then he dun m***''ed up. Thats right, he dun messed up.')#</td>--->
<!---                <td>#CleanWhereLike('My mom''s dad''s uncle''s brother told him then he dun m***''ed up. Thats right, he dun messed up.')#</td>--->
<!---                <td>#CleanLdap('My mom''s dad''s uncle''s brother told him then he dun m***''ed up. Thats right, he dun messed up.')#</td>--->
<!---            </tr>--->
<!---            <tr>--->
<!---                <td>!@##$%^&*()-=_+</td>--->
<!---                <td>#CleanWhereEq('!@##$%^&*()-=_+')#</td>--->
<!---                <td>#CleanWhereLike('!@##$%^&*()-=_+')#</td>--->
<!---                <td>#CleanLdap('!@##$%^&*()-=_+')#</td>--->
<!---            </tr>--->
<!---        </tbody>--->
<!---    </table>--->
<!---</cfoutput>--->
