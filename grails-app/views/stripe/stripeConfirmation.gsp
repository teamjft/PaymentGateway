<%--
  Created by IntelliJ IDEA.
  User: prashantk
  Date: 4/7/17
  Time: 2:27 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <asset:javascript src="bootstrap"/>
    <asset:stylesheet href="bootstrap"/>
    <asset:stylesheet href="mystyles"/>
</head>

<body>
<div class="container">

    <div class="acknowledgement">
        <div>
            <g:if test="${flash}">
                <h3 class="alert alert-danger">${flash.message}</h3>
            </g:if>
            <g:else>
                <h3 class="alert alert-success"><g:message code="payPalDemo.payment.success"/></h3>
            </g:else>
        </div>
        <div>
            <h5> <g:message code="payPalDemo.payment.heading"/> </h5>
        </div>
        <div>
            <g:link controller="stripe" action="index"> <button type="button">Return </button></g:link>
        </div>
    </div>
</div>
</body>
</html>