<cfoutput>

<h1>Edit User #user.name#</h1>

<cfif flashKeyExists("success")>
    <p class="success">#flash("success")#</p>
</cfif>

#startFormTag(action="update")#

    <div>#hiddenField(objectName="user", property="id")#</div>

    <div>#textField(objectName="user", property="name", class="form-control", label="Name")#</div>

    <div>#textField(objectName="user", property="email", class="form-control", label="Email")#</div>

    <div>
        #passwordField(objectName="user", property="password", class="form-control", label="Password")#
    </div><br>

    <div>#submitTag(class="btn btn-primary")#</div>

#endFormTag()#

</cfoutput>