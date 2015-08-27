<cfinclude template="CheckSecurityLoggedIn.cfm" />
<cfinclude template="MenuBar.cfm" />

<style>
	td {
		vertical-align: middle !important;
		text-align: center;
	}
</style>

<div style="width:80%; margin:0 auto;" id="content" style="z-index:3; background-color:white; border-radius:20px;">
	<form class="form-horizontal" id="personForm" name="personForm" method="post" enctype="multipart/form-data">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h2 class="text-center">My Files <a href="FileUpload.cfm"><img src="images/add.png"></a></h2>
				<div id="messageBox"></div>
				<div id="message_post"></div>
			</div>
			<div class="panel-body">
				<div style="margin:0 auto; width:85%;">
					<table class="table table-striped table-bordered table-justified" id="tblFiles">
						<thead>
							<td class="text-center">File<br>Num</td>
							<td>Name</td>
							<td>Last Modified</td>
							<td>Action</td>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</form>
</div>


<cfinclude template="asides/footer.cfm" />



<script>
	var table;
	$(document).ready(function() {
		table = $("#tblFiles").DataTable({
		"scrollY": "400px",
		renderer: 'bootstrap',
		tableTools: {
			"sSwfPath": "media/DataTables-1.10.7/extensions/TableTools/swf/copy_csv_xls_pdf.swf"
		},
		lengthMenu: [[10, 50, 100, 500, -1], [10, 50, 100, 500, "All"]],
		"bProcessing": false,
		"bServerSide": false,
		"sAjaxSource": "GetMyFiles.cfm",
		"bStateSave": true,
		"aoColumns": [
			{ "mDataProp": "NUM" },
			{ "mDataProp": "FILENAME" },
			{ "mDataProp": "MODTIME" },
			{ "mDataProp": "ACTION" }
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
		
	} ); // End of Ready Function.
	
	function deleteEvent(id) {
        var yes = confirm("Are you sure you want to delete " + id + "?");
		if (yes)
		{
			$.ajax("DeleteFile.cfm?id=" + id);
			table.ajax.reload();
		}
    }
	
</script>