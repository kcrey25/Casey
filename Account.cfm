<cfinclude template="CheckSecurityLoggedIn.cfm" />
<cfinclude template="MenuBar.cfm" />
<cfinclude template="OldPassCheck.cfc" />

<script type="text/javascript" src="/CFIDE/scripts/wddx.js"></script>
<script src="media/ckeditor/ckeditor.js"></script>

<cfquery
		username="#request.myDBUserName#"
		password="#request.myDBPassword#"
		datasource="#request.myDSN#"
		name="GetUser">
		SELECT *
		FROM UserMain
		WHERE USERNAME='#Session.UName#';
</cfquery>
<div style="width:80%; margin:0 auto;" id="content" style="z-index:3; background-color:white; border-radius:20px;">
	<form class="form-horizontal" id="signupform" name="signupform" method="post" enctype="multipart/form-data" action="UpdateAccount.cfm">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h2 class="text-center"><cfoutput>#Session.Name#'s Account</cfoutput></h2>
				<cfif IsDefined("URL.Message") && url.message NEQ 3>
                    <div class="alert alert-danger text-center">
                        <cfif url.message eq 1>
                            Timed Out
                        <cfelseif url.message eq 2>
                            The username you have changed to has already been taken. Please Choose Another.
                        <cfelseif url.message eq 3>
                            You have successfully updated your account!
                        <cfelseif url.message eq 4>
                            You must login to access these features.
                        <cfelseif url.message eq 5>
                            You must enter a user name and password.
                        </cfif>
                    </div>
				<cfelseif IsDefined("URL.Message") && url.message EQ 3>
					<div class="alert alert-success text-center">
                        You have successfully updated your account!
                    </div>
                </cfif> 
				
				<div id="messageBox"></div>
				<div id="message_post"></div>
			</div>
			<div class="panel-body">
				<cfoutput>
				<div class="col-sm-5">
					<div class="form-group">
						<label class="control-label col-sm-4">First Name:<span style="color:red">*</span></label>
						<div class="col-sm-6">
							<input id="thefName" value="#GetUser.FIRSTNAME#" class="form-control" name="thefName" type="text" required>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-4">Last Name:<span style="color:red">*</span></label>
						<div class="col-sm-6">
							<input id="thelName" value="#GetUser.LASTNAME#" class="form-control" name="thelName" type="text" required>
						</div>
					</div>
					
					<div class="form-group">
						<label class="control-label col-sm-4">User Name:<span style="color:red">*</span></label>
						<div class="col-sm-6">
							<input id="theUserName" class="form-control" value="#Session.UName#" name="theUserName" type="text" required>
						</div>
					</div>
					
					<div class="form-group">
						<label class="control-label col-sm-4">Email:<span style="color:red">*</span></label>
						<div class="col-sm-6">
							<input id="theEmail" class="form-control" value="#GetUser.EMAIL# "name="theEmail" type="text" required>
						</div>
					</div>
				</div>
				

		<!-------------------------------- Start of Profile Picture Upload ----------------------------------------->

				<cfset currentDirectory = getDirectoryFromPath( getCurrentTemplatePath() ) />
				<div class="col-sm-7">
					<div class="form-group">
						<cfif FileExists("#currentDirectory#/User-Uploads/#GetUser.ID#.jpg") >
							<div class="row">
								<div class="col-sm-6">
									<label class="control-label" style="text-align:center" for="pic" id="fileText">
										Change Your Profile Picture.
									</label>
									<input type="file" name="pic" id="pic" accept="image/*" onchange="readURL(this);">
								</div>
								<div class="col-sm-6">
									<div id="userpic">
										<img id="blah" src="./User-Uploads/#GetUser.PIC#" height="200px" width="200px" onerror="this.src='./User-Uploads/no-image.jpg'">
									</div>
								</div>
							</div>
						<cfelse>
							<div class="row">
								<div class = "col-sm-6">
									<label class="control-label" style="text-align:center" id="fileText" for="pic">
										Upload Your Profile Picture.
									</label>
									<input type="file" name="pic" id="pic" accept="image/*" onchange="readURL(this);">
								</div>
								<div class = "col-sm-6">
									<div id="userpic">
										<img id="blah" src="./User-Uploads/#GetUser.PIC#" height="200px" width="200px" onerror="this.src='./User-Uploads/no-image.jpg'">
									</div>
								</div>
							</div>
						</cfif>
					</div>
				</div><br><br><br><br><br><br><br><br>
				
	<!-------------------------------- End of Profile Picture Upload -------------------------------------------------->
				
				
				</cfoutput>
				<b>Personal Info:<b>
				<textarea name="editor1" id="editor1" rows="10" cols="80">
					<cfoutput>#GetUser.ACCOUNT_INFO#</cfoutput>
				</textarea><br>
			
				<div class="form-group pull-right">
					<div class="col-sm-1">
						<button class="btn btn-primary" id="thebutton" name="thebutton" formaction="TestEmail.cfm">Send Email</button>
					</div>
				</div>
				<div class="form-group pull-left">
					<div class="col-sm-1">
						<button class="btn btn-primary" type="submit" id="updatebutton" name="updatebutton" formaction="UpdateAccount.cfm">Update Account</button>
					</div>
				</div>
			</div>
		</div>
				
	</form>
</div>



<cfinclude template="asides/footer.cfm">



<script>		
	
	$(document).ready(function() {
		$('#userpic').blur(function(){
			document.body.appendChild(img);
		});
			
	} );
	
	// Replace the <textarea id="editor1"> with a CKEditor
	// instance, using default configuration.
	CKEDITOR.replace( 'editor1' );
	
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
		$("#fileText").html("<font color='red'>Press Update Account to upload image</font>");
    }

	<!---window.onload = function() 
	{ 
		<cfloop list="#GetUser.ColumnList#" index="col">
			<cfoutput>#GetUser[col][1]#</cfoutput><br>
		</cfloop>
	}--->
	

	/*$("#subbut").click( function(e){
		var txtpass = document.getElementById('txtpass').value;
		var txtpconf = document.getElementById('txtpconf').value;
		var txtpcur = document.getElementById('confirmOldPass').value;
		
		if(txtpass != txtpconf)
		{
			$('#messageBox').html('<div class="text-center alert alert-danger fade in"><a href="#" class="close" ' + 
				'data-dismiss="alert"></a> Your new passwords do not match.</div>')
					.delay(1500).fadeOut(complete=function(){$(this).html('');}).show();
			e.preventDefault();
		}
		else
		{
			window.location.href = 'ResetPass2.cfm?curp=' + txtpcur + '&newp=' + txtpass + '&conp=' + txtpconf;
		}
	});*/
	
	
</script>

