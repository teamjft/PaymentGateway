<%--
  Created by IntelliJ IDEA.
  User: prashantk
  Date: 12/6/17
  Time: 5:45 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Check</title>
    <asset:javascript src="bootstrap"/>
    <asset:stylesheet href="bootstrap"/>
    <asset:stylesheet href="mystyles"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>

<body>
<button name="signup" value="Sign Up" type="button" class="btn btn-info btn-lg signup" data-toggle="modal" data-target="#myModal" >Signup</button>

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
                    <g:form method="post" url="[action:'myaction',controller:'home']">
                        <input class="signup_form" type="text" name="username" placeholder="Username">
                        <input class="signup_form" type="password" name="password" placeholder="Create your password">
                        <input class="signup_form" type="password" name="confirmPassword" placeholder="Confirm your password">
                        <input type="submit" value="Signup"/>
                    </g:form>
                </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>