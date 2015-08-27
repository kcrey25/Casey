<cfinclude template="CheckSecurityLoggedIn.cfm" />
<cfinclude template="MenuBar.cfm" />
<cfinclude template="OldPassCheck.cfc" />

<script type="text/javascript" src="/CFIDE/scripts/wddx.js"></script>


<div style="width:80%; margin:0 auto;" id="content" style="z-index:3; background-color:white; border-radius:20px;">
	<form class="form-horizontal" id="signupform" name="signupform" method="post" action="ResetPass2.cfm">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h2 class="text-center">Change Password</h2>
				<cfif IsDefined("URL.Message") && url.message neq 1>
                    <div class="alert alert-danger text-center">
                        <cfif url.message eq 2>
                            Test 2
                        <cfelseif url.message eq 3>
							Test 3
                        <cfelseif url.message eq 4>
                            You must Enter a User name and Password.
                        <cfelseif url.message eq 5>
                            Your password must be at least 5 characters.
						<cfelseif url.message eq 6>
                            Your current Password does not match.
                        </cfif>
                    </div>
				</cfif>
				<cfif IsDefined("URL.Message") && url.message eq 1>
					<div class="alert alert-success text-center">
                            Password Reset Successfully!
					</div>
                </cfif> 
				<div id="messageBox"></div>
				<div id="message_post"></div>
			</div>
			<div class="panel-body">
				<div class="form-group">
					<label class="control-label col-sm-2">Current Password:<span style="color:red">*</span></label>
					<div class="col-sm-3">
						<input id="confirmOldPass" class="form-control" name="confirmOldPass" type="password" required onchange="checkOldPass();"><span id="messageoldpass" class="messageoldpass"></span>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-2">Password:<span style="color:red">*</span></label>
					<div class="col-sm-3">
						<input id="txtpass" class="form-control" name="txtpass" type="password" onchange="checkPass();" required>
					</div>
					<label class="control-label col-sm-2">Confirm Password:<span style="color:red">*</span></label>
					<div class="col-sm-3">
						<input id="txtpconf" class="form-control" name="txtpconf" type="password" required onkeyup="checkPass();"><span id="confirmMessage" class="confirmMessage"></span>
					</div>
				</div>
				<div class="row">
					<label class="control-label col-sm-offset-1" style="color:gray;"><font color="red">*Note:</font> must be at least 5 characters long.</label>
					<div class="pull-right" style="padding-right:15px;">
						<button type="button" id="subbut" class="btn btn-primary">Change Password</button>
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

	$("#subbut").click( function(e){
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
			txtpconf.style.backgroundColor = badColor;
			message.style.color = badColor;
			message.innerHTML = "Passwords Do Not Match!"
		}
	}  
	
	
	/*$('#subbut').click(function(){
		checkPass();
		jQuery.ajax({ url: "ResetPass2.cfm", 
				 data: $("#signupform").serialize(),
				type: "POST"
		})
	});*/
	
	
	// Use WDDX to move from CFML data to JavaScript 
    <cfwddx action="cfml2js" input="checkOldPass()" topLevelVariable="results"> 
	
	function checkOldPass(){
		var objSelf = this;
		var confirmOldPass = $("#confirmOldPass").val();
		$.get('OldPassCheck.cfc?method=compare_pass&thepass=' + confirmOldPass).done(
			function(results) {
				if(results == "true")
				{
					$('#messageBox').html('<div class="text-center alert alert-success fade in"><a href="#" class="close" ' + 
						'data-dismiss="alert"></a> This matches your current password</div>')
							.delay(1500).fadeOut(complete=function(){$(this).html('');}).show();
					document.getElementById("subbut").disabled = false;
				}
				else
				{
					$('#messageBox').html('<div class="text-center alert alert-danger fade in"><a href="#" class="close" ' + 
						'data-dismiss="alert"></a> This does not match your current password.</div>')
							.delay(1500).fadeOut(complete=function(){$(this).html('');}).show();
					
					document.getElementById("subbut").disabled = true;
				}
			});
	}
</script>














