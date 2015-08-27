<cfquery
		username="#request.myDBUserName#"
		password="#request.myDBPassword#"
		datasource="#request.myDSN#"
		name="GetUser">
		SELECT *
		FROM UserMain
		WHERE USERNAME = '#Session.UName#';
</cfquery>

<cfquery
		username="#request.myDBUserName#"
		password="#request.myDBPassword#"
		datasource="#request.myDSN#"
		name="GetFamily">
		SELECT *
		FROM Family
		WHERE USER_ID = '#GetUser.ID#';
</cfquery>

<div style="width:80%; margin:0 auto;">
	<cfinclude template="asides/header.cfm" />
	<div class="navbar navbar-default" role="navigation">
		 <div class="navbar-header" >
			  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
			  </button>
		 </div>
		 <div class="navbar-collapse collapse navbar-nav-background">
			<ul class="nav navbar-nav ">
				<li><a href="./Start.cfm">Home</a></li>
				<li><a href="./SignUp.cfm">Sign Up</a></li>
				<li class="dropdown">
				<a class="dropdown-toggle whitetext" data-toggle="dropdown" href="#">About<span class="caret"></span></a>
					<ul class="dropdown-menu navbar-nav-ul" style="background-color:#B0B0B0">
						<li><a class="whitetext" href="Mission.cfm">Mission</a></li>
						<li><a class="whitetext" href="About.cfm">About the Man</a></li>
					</ul>
				</li>
				<cfif isDefined('session.UName') AND session.UName NEQ "">
					<li><a class="whitetext" href="MyFamily.cfm?id=<cfoutput>#GetFamily.ID#</cfoutput>">My Family</a></li>
					<li><a class="whitetext" href="MyFiles.cfm">My Files</a></li>
					<li class="dropdown">
					<a class="dropdown-toggle whitetext" data-toggle="dropdown" href="#">Your Account<span class="caret"></span></a>
						<ul class="dropdown-menu navbar-nav-ul" style="background-color:#B0B0B0">
							<li><a class="whitetext" href="Account.cfm">My Account</a></li>
							<li><a class="whitetext" href="ResetPass.cfm">Change Password</a></li>
						</ul>
					</li>
				</cfif>
				<cfif Session.UName EQ "casey">
					<li><a href="./UserList.cfm">Site Users</a></li>
				</cfif>
			</ul>
			<cfif isDefined("Session.isLoggedIn") AND Session.isLoggedIn NEQ false>
				<div class="navbar-form navbar-right">
					  Logged in as: <cfoutput>#Session.Name#</cfoutput> &nbsp
					  <a href="Logout.cfm" class="btn btn-logout">Logout</a>
				 </div>
			<cfelse>
				<div class="navbar-form">
					<cfif isDefined('session.UName') AND session.UName NEQ "">
						<div class="pull-right">
							<span class="text-muted" style="padding: 0 8px; color:white;">Logged in as: <cfoutput>#Session.Name#</cfoutput></span>
							<a href="Logout.cfm" class="btn btn-default">Logout</a>
						</div>
					<cfelse>
						<form name="logform" action="login2.cfm" method="POST" class="form-horizontal"  style="padding:1px">
							<div style="float:right">
								<div class="form-group col-sm-6">
									<div class="col-sm-12">
									<input type="text" name="UserName" id="UserName" placeholder="Username" class="form-control">
									</div>
								</div>
								<div class="form-group col-sm-6">
									<div class="col-sm-12">
										<input type="password" name="Password" id="Password" placeholder="Password" class="form-control">
									</div>
								</div>
								<div class="col-sm-1">
									<button type="submit" class="btn btn-success">Sign in</button>
								</div>
							</div>
						</form>
					</cfif>
				</div>
			</cfif>
		</div>
   </div>   
</div>
