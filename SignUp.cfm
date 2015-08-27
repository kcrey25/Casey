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


<div style="width:80%; margin:0 auto;" id="content" style="z-index:3; background-color:white; border-radius:20px;">
	<form class="form-horizontal" id="signupform" action="./AddUser.cfm" method="post">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h2 class="text-center">Sign Up</h2>
				<cfif IsDefined("URL.Message")>
                    <div class="alert alert-danger text-center">
                        <cfif url.message eq 1>
                            Timed Out
                        <cfelseif url.message eq 2>
                            User name is already taken. Please select another.
                        <cfelseif url.message eq 3>
                            An error occured. Please try again later.
                        <cfelseif url.message eq 4>
                            You must login to access these features.
                        <cfelseif url.message eq 5>
                            You must enter a user name and password.
                        </cfif>
                    </div>
                </cfif> 
			</div>
			<div class="panel-body">
				<div class="form-group">
					<label class="control-label col-sm-2" for="txtfname">First Name:<span style="color:red">*</span></label>
					<div class="col-sm-3">
						<input id="txtfname" class="form-control" name="txtfname" type="text" required>
					</div>
					<label class="control-label col-sm-2" for="txtlname">Last Name:<span style="color:red">*</span></label>
					<div class="col-sm-3">
						<input id="txtlname" class="form-control" name="txtlname" type="text" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-2" for="txtemail">Email:<span style="color:red">*</span></label>
					<div class="col-sm-3">
						<input id="txtemail" class="form-control" name="txtemail" type="text" required>
					</div>
					<label class="control-label col-sm-2" for="theuser">User Name:<span style="color:red">*</span></label>
					<div class="col-sm-3">
						<input id="theuser" class="form-control" name="theuser" type="text" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-2" for="txtpass">Password:<span style="color:red">*</span></label>
					<div class="col-sm-3">
						<input id="txtpass" class="form-control" name="txtpass" type="password" onkeyup="checkPass();" required>
					</div>
					<label class="control-label col-sm-2" for="txtpconf">Confirm Password:<span style="color:red">*</span></label>
					<div class="col-sm-3">
						<input id="txtpconf" class="form-control" name="txtpconf" type="password" required onkeyup="checkPass();"><span id="confirmMessage" class="confirmMessage"></span>
					</div>
				</div>
				<div class="row">
					<div class="pull-right" style="padding-right:15px;">
						<button type="submit" class="btn btn-primary" onclick="checkPass();">Submit</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>


<div style="position: fixed; bottom: 0px; width:100%;">
	<cfinclude template="asides/footer.cfm" />
</div>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="media/Plugins/jQuery-Passtest-Plugin/jquery-passtest-0.2-alpha.js"></script>

<script>		
	
	$(document).ready(function() {
			
	} );

	$("form").submit( function(e){
		var txtpass = document.getElementById('txtpass');
		var txtpconf = document.getElementById('txtpconf');
		if(txtpass.value != txtpconf.value)
		{
			e.preventDefault();
		}
	});
	
	function checkPass()
	{
		//Store the txtpass field objects into variables ...
		var txtpass = document.getElementById('txtpass');
		var txtpconf = document.getElementById('txtpconf');
		//Store the Confimation Message Object ...
		var message = document.getElementById('confirmMessage');
		//Set the colors we will be using ...
		var goodColor = "#66cc66";
		var badColor = "#ff6666";
		//Compare the values in the txtpass field 
		//and the confirmation field
		
		if(txtpass.value == "" & txtpconf.value == "")
		{
		}
		else if(txtpass.value == txtpconf.value)
		{
			//The passwords match. 
			//Set the color to the good color and inform
			//the user that they have entered the correct password 
			txtpconf.style.backgroundColor = goodColor;
			message.style.color = goodColor;
			message.innerHTML = "Passwords Match!"
		}
		else
		{
			//The passwords do not match.
			//Set the color to the bad color and
			//notify the user.
			console.log(txtpass.value);
			txtpconf.style.backgroundColor = badColor;
			message.style.color = badColor;
			message.innerHTML = "Passwords Do Not Match!"
		}
	}  
	
	
	
</script>














