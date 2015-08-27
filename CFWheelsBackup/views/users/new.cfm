<cfoutput>

<h1>Create a New User</h1>

#startFormTag(action="create")#

    <div>#textField(objectName="user", class="form-control", property="name", label="Name")#</div>

    <div>#textField(objectName="user", class="form-control", property="email", label="Email")#</div>

    <div>#passwordField(objectName="user", class="form-control", property="password", label="Password")#</div>

    <div>#submitTag(class="btn btn-primary", text="Create User")#</div>

#endFormTag()#

</cfoutput>