<cfinclude template="CheckSecurityLoggedIn.cfm" />
<cfinclude template="MenuBar.cfm" />
<cfinclude template="OldPassCheck.cfc" />

<script type="text/javascript" src="/CFIDE/scripts/wddx.js"></script>
<script src="media/ckeditor/ckeditor.js"></script>

<cfquery
	username="#request.myDBUserName#"
	password="#request.myDBPassword#"
	datasource="#request.myDSN#"
	name="getUser">
		SELECT *
		FROM Family
		WHERE ID = '#url.id#'
</cfquery>

<cfoutput>
<div style="width:80%; margin:0 auto;" id="content" style="z-index:3; background-color:white; border-radius:20px;">
	<form class="form-horizontal" id="signupform" name="signupform" method="post" enctype="multipart/form-data" action="AddFamilyMember2.cfm?id=#url.id#">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h2 class="text-center"><cfoutput>Add Family Member</cfoutput></h2>
			</div>
			<div class="panel-body">
				<div class="form-group">
					<label class="col-sm-2 control-label" for="firstname">First Name</label>
					<div class="col-sm-3">
						<input id="firstname" class="form-control" required name="firstname" type="text">
					</div>
					<label class="col-sm-2 control-label" for="lastname">Last Name</label>
					<div class="col-sm-3">
						<input id="lastname" class="form-control" required name="lastname" type="text">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label" for="relation">Relation To #getUser.FIRSTNAME# #getUser.LASTNAME#</label>
					<div class="col-sm-2">
						<select id="relation" class="form-control" required name="relation" type="text">
							<option value="Brother">Brother</option>
							<option value="Daughter">Daughter</option>
							<option value="Father">Father</option>
							<option value="Mother">Mother</option>
							<option value="Sister">Sister</option>
							<option value="Son">Son</option>
							<option value="Spouse">Spouse</option>
						</select>
					</div>
				
			
		
<!-------------------------------- Start of Profile Picture Upload ----------------------------------------->

					<cfset currentDirectory = getDirectoryFromPath( getCurrentTemplatePath() ) />
				
						<div class = "col-sm-3">
							<label class="control-label" style="text-align:center" id="fileText" for="pic">
								Upload Your Profile Picture.
							</label>
							<input required type="file" name="pic" id="pic" accept="image/*" onchange="readURL(this);">
						</div>
						<div class = "col-sm-3">
							<div id="userpic">
								<img id="blah" src="./User-Uploads/" height="200px" width="200px" onerror="this.src='./User-Uploads/no-image.jpg'">
							</div>
						</div>
				</div><br><br><br><br><br><br>
<!-------------------------------- End of Profile Picture Upload -------------------------------------------------->
				<div class="form-group">
					<div class="pull-right" style="margin-right:35px;">
						<button type="submit" class="btn btn-primary">Submit</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>
</cfoutput>


<cfinclude template="asides/footer.cfm">



<script>		
	
	$(document).ready(function() {
		$('#userpic').blur(function(){
			document.body.appendChild(img);
		});
		
		document.getElementById("firstname").focus();
			
	} );
	
	
	//This function will let the user preview the image.
	function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#blah')
                    .attr('src', e.target.result)
                    .width(200)
                    .height(200);
            };

            reader.readAsDataURL(input.files[0]);
        }
		$("#fileText").html("<font color='red'>Press Submit to upload image</font>");
    }
	
	
</script>

