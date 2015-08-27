<cfoutput>

<h1>Users</h1>

<cfif flashKeyExists("success")>
	<p class="success">#flash("success")#</p>
</cfif>
<div class="row">
	<div class="col-sm-3">
		<button class="btn btn-block">#linkTo(text="+ Add New User", action="new")#</button><br>
	</div>
</div>

<table id="TheTable" class="table table-bordered table-responsive" cellspacing="0" width="100%">
    <thead>
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th class="text-center">Edit</th>
			<th class="text-center">Delete</th>
        </tr>
    </thead>
    <tbody>
        <cfloop query="users">
            <tr>
                <td>#users.name#</td>
                <td>#users.email#</td>
                <td class="text-center">
                    #buttonTo(
						image="edit.PNG",
                        text="Edit", action="edit", key=users.id
                    )#
                </td>
                <td class="text-center">
                    #buttonTo(
                        text="Delete", action="delete", key=users.id,
						image="delete.PNG",
                        confirm="Are you sure that you want to delete
                            #users.name#?"
                    )#
                </td>
            </tr>
        </cfloop>
    </tbody>
</table>

</cfoutput>


<script>
	$(document).ready(function() {
		var table = $('#TheTable');
	} );

</script>