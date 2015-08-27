<cfinclude template="MenuBar.cfm" />


<!---cfquery 
	username="#request.myDBUserName#"
	password="#request.myDBPassword#"
	datasource="#request.myDSN#"
	name="LOCTN">
  SELECT UserMain.USERNAME, UserMain.LOCATION, Schools.SchID, Schools.SchDesc
  FROM UserMain LEFT JOIN Schools ON UserMain.LOCATION = Schools.SchID
  ORDER BY USERNAME
</cfquery--->


<div style="width:80%; margin:0 auto;" id="content">
	<form class="form-horizontal" action="./IncidentForm.cfm" method="post">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h2 class="text-center">Amazing Work</h2>
			</div>
			<div class="panel-body">
				<iframe width="545" height="308" src="https://www.youtube.com/embed/rC9C4rqVuz0" frameborder="0" allowfullscreen></iframe>
			</div>
		</div>
	</form>
</div>


<cfinclude template="asides/footer.cfm">


<script>		
	
	$(document).ready(function() {
			
	} );
	
	$.fn.dataTableExt.afnFiltering.push(
		function( oSettings, aData, iDataIndex ) {
			//var reportnumber = $('#reportNum').val();
			
			//return (aData[13].indexOf(reportnumber) >= 0);
		}
	);
	
</script>