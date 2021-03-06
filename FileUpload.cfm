<cfinclude template="CheckSecurityLoggedIn.cfm" />
<cfinclude template="MenuBar.cfm" />

<!-- Style our demo. -->
<link rel="stylesheet" type="text/css" href="./media/css/demo.css"></link>

<!-- Load RequireJS and our bootstrap file. -->
<script
	type="text/javascript"
	src="./assets/require/require.js"
	data-main="./assets/main.js">
</script>

<cfquery
	username="#request.myDBUserName#"
	password="#request.myDBPassword#"
	datasource="#request.myDSN#"
	name="GetUserID">
		SELECT * FROM UserMain WHERE USERNAME = '#Session.UName#'
</cfquery>

<!--- See if the directory exists for the user. If no, create the directory. ---> 
<cfset currentDirectory = getDirectoryFromPath( getCurrentTemplatePath() ) />
<cfset currentDirectory = currentDirectory & "User-Files\" & GetUserID.ID>
<cfif !DirectoryExists(currentDirectory)> 
    <cfdirectory action = "create" directory = "#currentDirectory#" > 
</cfif> 

<div class="container">

	<!-- BEGIN: Uploader. -->
	<div id="pluploadContainer" class="uploader col-sm-5 col-sm-offset-4">

		<!-- BEGIN: Dropzone + Browse Button. -->
		<a id="pluploadDropzone" class="dropzone html5Dropzone">
			
			<!-- If the HTML5 runtime engine is enabled, show this. -->
			<span class="instructions html5Instructions">
				Drag &amp; Drop Your Files Here!
			</span>
			
			<!-- If the Flash runtime engine is enabled, show this. -->
			<span class="instructions flashInstructions">
				Click Here To Select Files!
			</span>

		</a>
		<!-- END: Dropzone + Browse Button. -->


		<!-- BEGIN: File Queue. -->
		<div class="queue emptyQueue">

			<div class="noFiles">
				Please select some files to upload!
			</div>

			<ul class="files">
				<!-- To be populated dynamically. -->
			</ul>

		</div>
		<!-- END: File Queue. -->


		<!-- BEGIN: Templates For Uploader. -->
		<script type="application/template" class="templates">

			<li class="file">
				<span class="name">FILE-NAME</span>
				<span class="progress">
					(
						<span class="percentComplete">0%</span> of
						<span class="totalSize">0</span>
					)
				</span>
			</li>

		</script>
		<!-- END: Templates For Uploader. -->

	</div>
	<!-- END: Uploader. -->

</div>

<script>
</script>