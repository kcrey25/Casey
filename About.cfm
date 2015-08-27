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
<style>
	.backimg{
		background-image: url("images/Clouds.png") !important;
	}
</style>
	
<div style="width:80%; margin:0 auto;" id="content" style="z-index:3; background-color:white; border-radius:20px;">
	<form class="form-horizontal" id="signupform" action="./IncidentForm.cfm" method="post">
		<div class="panel panel-default">
			<div class="panel-heading backimg">
				<h2 class="text-center">About the Man!</h2>
			</div>
			<div class="panel-body">
				
				<div class="form-group text-center">
					<img src="images/KingCasey.jpg" alt="Smiley face">
				</div>
			</div>
		</div>
	</form>
</div>


<cfinclude template="asides/footer.cfm">


<script>		
	
	$(document).ready(function() {
			
	} );

	
	
</script>














