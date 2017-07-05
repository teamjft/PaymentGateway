<%--
  Created by IntelliJ IDEA.
  User: prashantk
  Date: 8/6/17
  Time: 6:47 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>PaypalDemo</title>

    <asset:stylesheet src="bootstrap"/>
    <asset:stylesheet src="bootstrap.min"/>
    <asset:javascript src="bootstrap.min"/>
    <asset:stylesheet src="mystyles"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>

<body>

<div class="container">
    <div>
        <g:render template="header"/>
    </div>
    <div class="shopping">
        <g:each in="${productList}">
            <div class="col-md-2 column productbox">
                <img src="${createLink(controller: 'home',action: 'renderImage',params: [productImage:it.productImage])}" alt="product-image" class="img-responsive">
                <div class="producttitle">${it.name}${it.description}</div>
                <div class="productprice"><div class="pull-right"><g:link controller="home" action="shoppingCart" params="[price:it.price]" class="btn btn-success btn-sm" role="button">BUY</g:link></div><div class="pricetext">&#8377; ${it.price}</div></div>
            </div>
        </g:each>
    </div>
</div>

</body>
</html>