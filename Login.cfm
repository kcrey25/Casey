<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width">
    <meta name="keywords" content="Canyons School District"/>
    <meta name="description" content="Canyons School District"/>

    <link rel="shortcut icon" href="media/images/favicon.ico.png" type="image/x-icon"/>
    <link rel="stylesheet" href="media/css/bootstrap.min.css">
    <link rel="stylesheet" href="media/css/bootstrap-theme.min.css">

    <title>Casey's Page</title>

    <!-- Custom styles for this template -->
    <style>
        body {
            padding-top: 100px;
            padding-bottom: 40px;
            background-color: #fff;
        }

        .form-signin-top {
            position: relative;
            padding: 39px 19px 24px;
            margin: 15px 0;
            background-color: #fff;
            border: 1px solid #e5e5e5;
            -webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
            -moz-box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
            box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
        }

        .form-signin {
            max-width: 500px;
            padding: 19px 29px 29px;
            margin: 0 auto 20px;
        }

        #logo {
            background: url("media/images/logo.jpg") no-repeat center center;
            width: 100%;
            height: 130px;
        }

        .form-signin-bottom {
            margin-top: -20px;
            border: 1px solid #e1e1e8;
            background-color: #f5f5f5;
            padding: 30px 40px 40px;
        }

        .form-signin-bottom input[type="text"],
        .form-signin-bottom input[type="password"] {
            font-size: 16px;
            margin-bottom: 10px;
        }

        .form-signin-bottom button {
            margin-top: 25px;
        }
    </style>

    <!--[if lt IE 9]>
    <script src="js/vendor/html5-3.6-respond-1.1.0.min.js"></script>
    <![endif]-->
</head>

<body>

    <div style="width:80%; margin:0 auto;">

        <cfform action="login2.cfm" method="post" name="LogBox" class="form-signin">
            <div class="form-signin-top">
                <div id="logo"></div>
                <h3 class="text-center">Casey's Awesome Login</h3>
                
            </div>
            <div class="form-signin-bottom">
                <cfif IsDefined("URL.Message")>
                    <div class="alert alert-danger">
                        <cfif url.message eq 1>
                            Timed Out
                        <cfelseif url.message eq 2>
                            Access Denied
                        <cfelseif url.message eq 3>
                            Username and/or Password is incorrect.
                        <cfelseif url.message eq 4>
                            You must login to access these features.
                        <cfelseif url.message eq 5>
                            You must enter a user name and password.
                        </cfif>
                    </div>
                </cfif>   
                <div class="form-horizontal">
                    <div class="form-group">
                        <label for="UserName" class="col-sm-3 control-label">Username:</label>
                        <div class="col-sm-9">
                            <cfif IsDefined("URL.UserName")>
                                <cfoutput><input type="Text" class="form-control" id="UserName" name="UserName" maxlength="50" autocomplete="off" value="#URL.UserName#" required autofocus></cfoutput>
                            <cfelse>
                                <input type="Text" class="form-control" id="UserName" name="UserName" maxlength="50" autocomplete="off "required autofocus>
                            </cfif>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="Password" class="col-sm-3 control-label">Password:</label>
                        <div class="col-sm-9">
                            <input type="Password" class="form-control" id="Password" name="Password" maxlength="25" autocomplete="off" required>
                        </div>
                    </div>
                </div>
                <button class="btn btn-lg btn-primary btn-block" type="submit">Login</button>
            </div>
        </cfform>

    </div>
<!-- /container -->

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script>window.jQuery || document.write('<script src="media/js/vendor/jquery-1.10.1.min.js"><\/script>')</script>

<script src="media/js/bootstrap.min.js"></script>

<script src="media/js/main.js"></script>
</body>
</html>
