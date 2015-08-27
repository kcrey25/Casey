<div style="width:80%; margin:0 auto;">
<cfinclude template="asides/header.cfm" />
</div>
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
		<div class="jumbotron text-center">
			<big>Thank you for signing-up. An email has been sent to the site administrator. You will be notified when you have been accepted. Enjoy The Wonderful Works of Casey!</big><div id="sec">You will be redirected in 7 seconds.</div>
			<META http-equiv="refresh" content="7;URL=start.cfm">
		</div>
	</form>
</div>
<cfmail	from="casey@christensen.org"
			to="casey.christensen2@canyonsdistrict.org"
			subject="New Site User!"
			server = "email.canyonsdistrict.org"
			type = "HTML">
	<cfoutput>
		#Session.Name# created a new account on #DateFormat(now(), "long")# at #TimeFormat(now())#. Please review his/her account.
	</cfoutput>
</cfmail>


<cfinclude template="asides/footer.cfm">

<script>
<!--- This all is used just to count down the seconds until the redirect. --->
	var a = "You will be redirected in ";
	var s = " seconds.";
	var text = [];
	for (i=9;i>-1;i--)
	{
		text[i] = a + i + s;
	}
    var counter = 6;
    var elem = document.getElementById("sec");
    setInterval(change, 1000);
    function change() {
     elem.innerHTML = text[counter];
        counter--;
        if(counter >= text.length) { counter = 0; }
    }
	
</script>