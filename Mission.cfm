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
	<form class="form-horizontal" id="signupform" action="./IncidentForm.cfm" method="post">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h2 class="text-center">Mission</h2>
			</div>
			<div class="panel-body">
				<div class="form-group">
					
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
	/*function validatePass()
	{
		//Store the password field objects into variables ...
		var txtpass = document.getElementById('txtpass');
		var txtpconf = document.getElementById('txtpconf');
		//Store the Confimation Message Object ...
		var message = document.getElementById('confirmMessage');
		//Set the colors we will be using ...
		var badColor = "#ff6666";
		//Compare the values in the password field 
		//and the confirmation field
		if(txtpass.value != txtpconf.value){
			//The passwords match. 
			//Set the color to the good color and inform
			//the user that they have entered the correct password 
			txtpconf.style.backgroundColor = goodColor;
			message.style.color = goodColor;
			message.innerHTML = "Passwords Do Not Match!"
		}
	}*/
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
		//Store the password field objects into variables ...
		var txtpass = document.getElementById('txtpass');
		var txtpconf = document.getElementById('txtpconf');
		//Store the Confimation Message Object ...
		var message = document.getElementById('confirmMessage');
		//Set the colors we will be using ...
		var goodColor = "#66cc66";
		var badColor = "#ff6666";
		//Compare the values in the password field 
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
	
	
	
</script>














