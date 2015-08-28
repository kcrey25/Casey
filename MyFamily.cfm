<cfinclude template="CheckSecurityLoggedIn.cfm" />
<cfinclude template="MenuBar.cfm" />
<cfinclude template="OldPassCheck.cfc" />

<script type="text/javascript" src="/CFIDE/scripts/wddx.js"></script>
<script src="media/ckeditor/ckeditor.js"></script>

<cfquery
		username="#request.myDBUserName#"
		password="#request.myDBPassword#"
		datasource="#request.myDSN#"
		name="GetSessionUser">
		SELECT *
		FROM UserMain
		WHERE USERNAME = '#Session.UName#';
</cfquery>

<cfquery
		username="#request.myDBUserName#"
		password="#request.myDBPassword#"
		datasource="#request.myDSN#"
		name="GetUser">
		SELECT *
		FROM UserMain
		WHERE ID = '#url.id#';
</cfquery>

<cfquery
		username="#request.myDBUserName#"
		password="#request.myDBPassword#"
		datasource="#request.myDSN#"
		name="GetFamily">
		SELECT *
		FROM Family
		WHERE ID = '#url.ID#'
</cfquery>



<!-------------------------------- Start of Person Picture Upload ----------------------------------------->
<cffunction name="imageupload">
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
</cffunction>
<!-------------------------------- End of Profile Picture Upload -------------------------------------------------->

<cffunction name="addperson">
	<cfargument name="newid" default="">
	<cfargument name="famName" default="">
	<cfquery
		username="#request.myDBUserName#"
		password="#request.myDBPassword#"
		datasource="#request.myDSN#"
		name="newUser">
			SELECT *
			FROM Family
			WHERE ID = '#newid#';
	</cfquery>
	<cfif newUser.recordcount>
		<cfoutput>
				<b>#famName#</b><br><br>
			<div id="primaryUser" class="col-sm-12 text-center">
				<a href="MyFamily.cfm?id=#newUser.ID#"><img src="User-Uploads/#newUser.PIC#" height="200px"></a>
			</div><br>
			<button id="editbutton" name="editbutton" class="btn btn-success" formaction="EditMember.cfm?id=#newid#">Edit</button>
		</cfoutput>
	</cfif>
</cffunction>

<cffunction name="GetFamilyMember" returnType="query">
	<cfargument name="famid" default="">
	<cfargument name="thecol" default="">
	<cfquery
		username="#request.myDBUserName#"
		password="#request.myDBPassword#"
		datasource="#request.myDSN#"
		name="newUser">
			SELECT *
			FROM Family
			WHERE #thecol# = '#famid#';
	</cfquery>
	<cfreturn newUser>
</cffunction>


<div style="width:80%; margin:0 auto;" id="content" style="z-index:3; background-color:white; border-radius:20px;">
	<form class="form-horizontal" id="personForm" name="personForm" method="post" enctype="multipart/form-data">
		<div class="panel panel-default">
			<div class="panel-heading">
				<cfoutput>
					<h2>
						<div class="text-center">
							#Session.Name#'s Family
						</div>
						<div class="text-center">
							<button formaction="AddFamilyMember.cfm?id=#GetFamily.ID#" class="btn alert-success">Add Family Member</button>
						</div>
					</h2>
				</cfoutput>
				<div id="messageBox"></div>
				<div id="message_post"></div>
			</div>
			<div class="panel-body">
				<cfoutput>
					<div class="form-group">
						<!---------------------------- Husband/Wife Row ----------------------------------------->
						<div class="form-group">
							<div class="col-sm-6 text-center">
								#addperson(GetFamily.ID, "#GetFamily.FirstName# #GetFamily.LastName#")#
							</div>
							<div class="col-sm-6 text-center">
								<cfset spousequery = GetFamilyMember(GetFamily.SPOUSE_ID, "ID")>
								#addperson(GetFamily.SPOUSE_ID, "#spousequery.FirstName# #spousequery.LastName# (Spouse)")#
							</div>
						</div><br>
						
						<!------------------------------- Parents' Row ----------------------------------------->
						<div class="form-group">
							<cfset parentquery = GetFamilyMember(((GetFamily.SIBLING_GROUP EQ "")? url.id : GetFamily.SIBLING_GROUP), "CHILDREN_GROUP")>
							<cfloop query="parentquery">
								<div class="col-sm-6 text-center">
									#addperson(ID, "#parentquery.FirstName# #parentquery.LastName# (Parent)")#
								</div>
							</cfloop>
						</div><br>
						
						<!------------------------------- Siblings and Children Row ----------------------------------------->
						<div class="form-group">
							<cfif GetFamily.SIBLING_GROUP NEQ "">
								<div class="col-sm-6 text-center">
									<h4><b>SIBLINGS:<b/></h4><br>
									<cfset thesibs = GetFamilyMember(GetFamily.SIBLING_GROUP, "SIBLING_GROUP") />
									<cfloop query="thesibs">
									<!--- Just list the names of siblings as links with their ID --->
									<cfif ID NEQ url.id>
										<a href="MyFamily.cfm?id=#ID#">#FIRSTNAME# #LASTNAME#</a><br>
									</cfif>
									</cfloop>
								</div>
							</cfif>
							
							<cfif GetFamily.CHILDREN_GROUP NEQ "">
								<div class="col-sm-6 text-center">
									<h4><b>CHILDREN:<b/></h4><br>
									<cfset childsinfo = GetFamilyMember(GetFamily.CHILDREN_GROUP, "ID")>
									<cfset gettherightchild = (childsinfo.SIBLING_GROUP EQ "")?  #GetFamily.CHILDREN_GROUP# : #childsinfo.SIBLING_GROUP#>
									<cfset gettherightcol = (childsinfo.SIBLING_GROUP EQ "")? "ID" : "SIBLING_GROUP">
									<cfset thesibs = GetFamilyMember(gettherightchild, gettherightcol) />
									<cfloop query="thesibs">
									<!--- Just list the names of siblings as links with their ID --->
									<cfif ID NEQ url.id>
										<a href="MyFamily.cfm?id=#ID#">#FIRSTNAME# #LASTNAME#</a><br>
									</cfif>
									</cfloop>
								</div>
							</cfif>
						</div>
					</div><br>
					<b>Stories About #GetFamily.FirstName# #GetFamily.LastName#:<b><br>
					<textarea name="editor1" id="editor1">
						#GetFamily.STORIES#
					</textarea><br><br>
					<div class="row">
						<input type="button" class="btn btn-success pull-right" onclick="updateStory()" style="margin-right:15px;" value="Save Story">
					</div>
				</cfoutput>
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
	function CKupdate(){
    for ( instance in CKEDITOR.instances )
			CKEDITOR.instances[instance].updateElement();
	}

	function updateStory() {
		CKupdate();
		$.ajax({
           type: "POST",
           url: "UpdateFamily.cfm?update=story&id=<cfoutput>#url.id#</cfoutput>",
           data: $("#personForm").serialize(), // serializes the form's elements.
           success: function(data)
           {
               $('#messageBox').html('<div class="text-center alert alert-success fade in"><a href="#" class="close" ' + 
				'data-dismiss="alert"></a> The Story has been saved Successfully.</div>')
					.delay(2000).fadeOut(complete=function(){$(this).html('');}).show();
           }
         });

		return false; // avoid to execute the actual submit of the form..done( function() {
	}
	
	function updateName(thename, thencol) {
		var realname = document.getElementById(thename).value;
		var yes = confirm("Are you sure you want to change the name to " + realname + "?");
		if (yes) {
			$.ajax({
			   type: "POST",
			   url: "UpdateFamily.cfm?update=name&id=<cfoutput>#url.id#&name=" + realname + "&namecol=" + thencol</cfoutput>,
			   data: $("#personForm").serialize(), // serializes the form's elements.
			 });
		}
		return false; 
	}
	
</script>

