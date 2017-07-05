<%--
  Created by IntelliJ IDEA.
  User: prashantk
  Date: 12/6/17
  Time: 5:11 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    %{--<meta name='layout' content='main'/>--}%
    <title><g:message code="springSecurity.login.title"/></title>
    <asset:javascript src="bootstrap"/>
    <asset:stylesheet href="bootstrap"/>
    <asset:stylesheet href="mystyles"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style type='text/css' media='screen'>
    #login {
        margin: 15px 0px;
        padding: 0px;
        text-align: center;

    }

    #login .inner {
        width: 350px;
        padding-bottom: 6px;
        margin: 60px auto;
        text-align: left;
        border: 0px solid #aab;
        background-color: white;
        -moz-box-shadow: 2px 2px 2px #eee;
        -webkit-box-shadow: 2px 2px 2px #eee;
        -khtml-box-shadow: 2px 2px 2px #eee;
        box-shadow: 2px 2px 2px white;
    }

    #login .inner .fheader {
        padding: 18px 26px 14px 26px;
        background-color: white;
        margin: 0px 0 14px 0;
        color: #2e3741;
        font-size: 18px;
        font-weight: bold;
        text-align: center;
    }

    #login .inner .cssform p {
        clear: left;
        margin: 0;
        height: 1%;
    }





    #login .inner .cssform label {
        font-weight: bold;
        float: left;
        text-align: right;
        margin-left: -105px;
        width: 110px;
        padding-top: 3px;
        padding-right: 10px;
    }

    #login #remember_me_holder {
        padding-left: 20px;
    }

    #login #submit {
        margin-left: 15px;
    }

    #login #remember_me_holder label {
        float: none;
        margin-left: 0;
        text-align: left;
        width: 200px;
        font-family: Arial, Helvetica, sans-serif;
        color: grey;

    }


    #login .inner .login_message {
        padding: 6px 25px 20px 25px;
        color: #c33;
    }

    #login .inner .text_ {
        width: 280px;
        height: 48px;
        padding-left: 10px;
        display: block;
        margin: 10px;
        margin-left: 30px;
        border: 1px solid #CCCCCC;
        border-radius: 4px;
    }
    #login .inner .cssform input[type='submit'] {
        height: 48px;
        width: 280px;
        margin-top: 15%;
        border: 0px solid #CCCCCC;
        border-radius: 4px;
        background-color: #0070BA;
        color: white;
        font-weight: bold;
        cursor: pointer;
    }

    #login .inner .cssform input[type='submit']:hover{
        background-color:rgba(76, 143, 255, 0.97)
    }
    #login .inner .chk {
        height: 12px;
        margin-left: 10px;
        margin-bottom: 20px;
        margin-top: 20px;

    }
    .signup{
        background-color: #CCCCCC;
        margin-top: 5%;

        width: 280px;
        margin-left: 9%;
        border:none;
        border-radius: 4px;
        padding:15px;
        text-align: center;
        cursor: pointer;
    }
        .error{
            color: red;
        }

    </style>
</head>

<body>
<div id='login'>
    <div class='inner'>
        <div class='fheader'>%{--<g:message code="springSecurity.login.header"/>--}%
            <span style="color:#003087;font-style: italic; ">Pay</span><span style="color: #009CDE;font-style: italic;">Pal</span> Demo
        </div>

        <g:if test='${flash.message}'>
            <div class='login_message'>${flash.message}</div>
        </g:if>

        <form action='${postUrl}'  method='POST' id='loginForm' class='cssform' autocomplete='off'>


            <input type='text' class='text_' name='j_username' id='username' placeholder="Username"/>

            <input type='password' class='text_' name='j_password' id='password' placeholder="Password"/>


            <p id="remember_me_holder">
                <input type='checkbox' class='chk' name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>
                <label for='remember_me'><g:message code="springSecurity.login.remember.me.label"/></label>
            </p>

            <input type='submit' style="margin-left: 30px;" id="submit" value='${message(code: "springSecurity.login.button")}'/>
        </form>
        <button name="signup" value="Sign Up" type="button" class="btn btn-info btn-lg signup" data-toggle="modal" data-target="#myModal" >Signup</button>
    </div>
</div>

<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg" style="width: 550px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Sign-Up for free</h4>
            </div>
            <div class="modal-body">
                <p>
                    <span> Send and receive money securely.</span>
                    <g:form method="post" controller="home" action="signUp">
                        <input class="signup_form" type="text" name="username" placeholder="Username">
                        <span class="error"> <g:renderErrors bean="${userCommand}" as="list" field="username"/></span>

                        <input class="signup_form" type="password" name="password" placeholder="Create your password">
                        <span class="error"> <g:renderErrors bean="${userCommand}" as="list" field="password"/></span>

                        <input class="signup_form" type="password" name="cpassword" placeholder="Confirm your password">
                        <span class="error"> <g:renderErrors bean="${userCommand}" as="list" field="cpassword"/></span>

                        <input type="submit" value="Signup" id="signup_submit"/>
                    </g:form>
                </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


<script type='text/javascript'>
    (function() {
        document.forms['loginForm'].elements['j_username'].focus();
    })();
</script>
</body>
</html>
