<%--
  Created by IntelliJ IDEA.
  User: prashantk
  Date: 12/6/17
  Time: 12:07 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>PayPalDemo</title>
    <asset:javascript src="bootstrap"/>
    <asset:stylesheet href="bootstrap"/>
    <asset:stylesheet href="mystyles"/>
</head>

<body>
<div class="container">
    <div>
        <g:render template="header"/>
    </div>

    <div class="acknowledgement">
        <div>
           <h2> <i style="color:#003087;"> Pay</i><i style="color:#009CDE;">Pal</i> Demo</h2>
        </div>
        <div>
            <g:if test="${flash}">
                <h3 class="alert alert-danger"><g:message code="payPalDemo.error.message" args="${flash.args}" default="${flash.default}"/></h3>
            </g:if>
            <g:else>
                <h3 class="alert alert-success"><g:message code="payPalDemo.payment.success"/></h3>
            </g:else>
        </div>
        <div>
            <h5> <g:message code="payPalDemo.payment.heading"/> </h5>
        </div>
        <div>
            <g:link controller="home" action="index"> <button type="button">Return </button></g:link>
        </div>
    </div>
</div>
</body>
</html>