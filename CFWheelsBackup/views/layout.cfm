<html>
<head>

<link rel="shortcut icon" href="../../media/images/favicon.ico.png" type="image/x-icon"/>
<title><cfoutput>WHEELS TEST</cfoutput></title>
<cfoutput>
#styleSheetLinkTag("http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.0/themes/cupertino/jquery-ui.css")#
#styleSheetLinkTag("//cdn.datatables.net/1.10.7/css/jquery.dataTables.min.css")#
#styleSheetLinkTag("../media/css/bootstrap.min.css")#
#styleSheetLinkTag("../media/css/bootstrap-theme.min.css")#
#styleSheetLinkTag("//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css")#
#styleSheetLinkTag("../media/css/vendor/sweet-alert.css")#
#styleSheetLinkTag("main")#
#javaScriptIncludeTag("https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js")#
#javaScriptIncludeTag("//code.jquery.com/jquery-1.11.3.min.js")#
#javaScriptIncludeTag("//code.jquery.com/jquery-migrate-1.2.1.min.js")#
#javaScriptIncludeTag("//cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js")#
#javaScriptIncludeTag("//code.jquery.com/jquery-1.11.3.min.js")#
#javaScriptIncludeTag("../media/DataTables-1.10.7/media/js/jquery.dataTables.min.js")#
#javaScriptIncludeTag("//code.jquery.com/jquery-migrate-1.2.1.min.js")#
</cfoutput>
</head>

<body>
<div id="container">
    
	
	<div class="container" id="content">
	<!--------------------- HEADER ------------------------------->
		<div class="row logo">
			<div class="col-lg-3 col-md-12">
				<a href="http://www.canyonsdistrict.org"><img class="logo" src="../../media/images/logo.jpg"/></a>
			</div>
		</div>   
	<!--------------------- Menu Bar ------------------------------->
		<div class="navbar navbar-inverse navbar-default" role="navigation">
			 <div class="navbar-header">
				  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
				  </button>
			 </div>
			 <div class="navbar-collapse collapse">
				  <ul class="nav navbar-nav">
						
						<li><cfoutput>#linkTo(text="Index", controller="users", action="index")#</cfoutput></li>
						<li><cfoutput>#linkTo(text="New", controller="users", action="new")#</cfoutput></li>
					
				  </ul>
			 <div class="navbar-form navbar-right">
				  <a href="Logout.cfm" class="btn btn-dark">Logout</a>
			 </div>
	   </div>   
	</div>
	
	
	
	<!--------------------- Page Content ------------------------------->
    <div id="content">
        <cfoutput>#includeContent()#</cfoutput>
    </div>
	
	<!--------------------- Footer ------------------------------->
	<footer>
		<div class="poly">
			<div class="container">
				<p class="footing-text">
					<img src="../../media/images/branding.png" alt="CSD" /> <br />
					&copy; Canyons School District. All Rights Reserved.
				</p>
			</div>
		</div>
	</footer>
</div>

</body>
</html>