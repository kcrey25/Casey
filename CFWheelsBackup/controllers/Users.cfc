<cfcomponent extends="Controller">

	<!------------------ New Method --------------------->
    <cffunction name="new">
    
        <cfset user = model("user").new()>
    
    </cffunction>
	
	<!------------------ Create Method --------------------->
	<cffunction name="create">

		<cfset user = model("user").create(params.user)>
		<cfset redirectTo(
			action="index",
			key=user.id,
			success="User #user.name# created successfully."
		)>

	</cffunction>
	
	<!------------------ Index Method --------------------->
	<cffunction name="index">

		<cfset users = model("user").findAll(order="name")>

	</cffunction>
	
	<!------------------ Edit Method --------------------->
	<cffunction name="edit">

		<cfset user = model("user").findByKey(params.key)>
		
	</cffunction>
	
	<!------------------ Update Method --------------------->
	<cffunction name="update">

		<cfset user = model("user").findByKey(params.user.id)>
		<cfset user.update(params.user)>
		<cfset redirectTo(
			action="edit",
			key=user.id,
			success="User #user.name# updated successfully.",
			controller="users",
			action="index"
		)>
	
	<!------------------ Delete Method --------------------->
	</cffunction>
	
	<cffunction name="delete">

		<cfset user = model("user").findByKey(params.key)>
		<cfset user.delete()>
		<cfset redirectTo(
			action="index",
			success="#user.name# was successfully deleted."
		)>

	</cffunction>

</cfcomponent>
