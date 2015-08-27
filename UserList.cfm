<cfinclude template="CheckSecurityLoggedIn.cfm" />
<cfif Session.UName NEQ "casey">
	<cflocation url="start.cfm">
</cfif>
<cfinclude template="MenuBar.cfm" />


<cfquery 
	username="#request.myDBUserName#"
	password="#request.myDBPassword#"
	datasource="#request.myDSN#"
	name="Users">
	SELECT *
	FROM UserMain
</cfquery>

<style>
	td{
		text-align: center;
		vertical-align: middle !important;
	}
	th{
		
	}
</style>

<div style="width:80%; margin:0 auto;" id="content" style="z-index:3; background-color:white; border-radius:20px;">
	<form class="form-horizontal" action="./IncidentForm.cfm" method="post">	
		<div class="panel panel-default">
			<div class="panel-heading text-center"><h3>Users</h3></div>
			<div class="panel-body">
			
			
				<div class="form-group">
					<label class="control-label col-sm-2 col-sm-offset-2">Login Month</label>
					<div class="col-sm-2">
						<select class="form-control" id="theDate" name="theDate">
							<option value=""></option>
							<option value="Jan">Jan</option>
							<option value="Feb">Feb</option>
							<option value="Mar">Mar</option>
							<option value="Apr">Apr</option>
							<option value="May">May</option>
							<option value="Jun">Jun</option>
							<option value="Jul">Jul</option>
							<option value="Aug">Aug</option>
							<option value="Sept">Sept</option>
							<option value="Oct">Oct</option>
							<option value="Nov">Nov</option>
							<option value="Dec">Dec</option>
						</select>
					</div>
					<label class="control-label col-sm-1">Status</label>
					<div class="col-sm-2">
						<select class="form-control" id="status" name="status">
							<option value=""></option>
							<option value="Active" selected>Active</option>
							<option value="Inactive">Inactive</option>
						</select>
					</div>
				</div>
				
				<div>
					<table width="95%" class="table table-striped table-bordered table-justified" id="tblUsers">
						<thead>
							<td>ID</td>
							<td>Name</td>
							<td>Email</td>
							<td>User Name</td>
							<td>ALevel</td>
							<td>Last Login</td>
							<td>Action</td>
							<td class="hidden">Status</td>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
		</div>
			
	</form>
</div>


<cfinclude template="asides/footer.cfm">


<script>
	
	$(document).ready(function() {
		var table= $("#tblUsers").DataTable({
			"scrollY": "400px",
			"scrollX": "auto",
			renderer: 'bootstrap',
            tableTools: {
                "sSwfPath": "media/DataTables-1.10.7/extensions/TableTools/swf/copy_csv_xls_pdf.swf"
            },
            lengthMenu: [[10, 50, 100, 500, -1], [10, 50, 100, 500, "All"]],
            "bProcessing": false,
            "bServerSide": false,
			"sAjaxSource": "GetUsers.cfm",
            "bStateSave": true,
			"bAutoWidth": false,
            "aoColumns": [
				{ "mDataProp": "ID", "sWidth": "60px" },
                { "mDataProp": "NAME", "sWidth": "125px" },
                { "mDataProp": "EMAIL", "sWidth": "320px" },
                { "mDataProp": "USERNAME", "sWidth": "75px" },
                { "mDataProp": "ALEVEL", "sWidth": "80px" },
                { "mDataProp": "LAST_LOGIN", "sWidth" : "200px" },
                { "mDataProp": "ACTION", "sWidth": "70px" },
                { "mDataProp": "STATUS", "class": "hidden"}
            ]
        }).on("draw.dt", function() {
            $("[title]").tooltip();
            $(".ALevel-input").change(function(e) {
                var dataid = $(this).data("id");
                var ALevel = $(this).val();
                $.get("UpdateUser.cfm?username=" + dataid + "&value=" + ALevel).done(function(e) {
                    $("span.ALevel[data-id='" + dataid + "']").show().fadeOut(1500);
                });
            });
            
        });
		

		$("#theDate").on('change', function (){
			$('#tblUsers').dataTable().fnFilter(this.value);
		});
		
		$('#status').change( function() {table.draw(); } );
		
		
	} );
	
	$.fn.dataTableExt.afnFiltering.push(
		function( oSettings, aData, iDataIndex ) {
			var thestat = $('#status').val();
			
			return (thestat == "" || aData[7] == thestat);
		}
	);
	
	function deleteEvent(id) {
        var yes = confirm("Are you sure you want to delete " + id + "?");
		if (yes == true)
		{
			$.ajax("UpdateUser.cfm?username=" + id + "&action=delete");
			$("#tblUsers").DataTable().ajax.reload();
		}
    }
	
</script>