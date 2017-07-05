<%--
  Created by IntelliJ IDEA.
  User: prashantk
  Date: 21/6/17
  Time: 12:05 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>PayPalDemo</title>
    <asset:stylesheet src="bootstrap"/>
    <asset:stylesheet src="bootstrap.min"/>
    <asset:javascript src="bootstrap.min"/>
    <asset:stylesheet src="mystyles"/>
</head>

<body>
<div class="container">
    <div>
        <g:render template="header"/>
    </div>
        <div class="jumbotron">
            %{--<g:form controller="home" action="addProduct">

                <input type="text" name="name" placeholder="Name of product">
                <input type="text" name="description" placeholder="Description">
                <input type="number" name="price" placeholder="price">
                <input type="submit" name="submit" value="Add Product" class="btn btn-success">
            </g:form>--}%

            <div class="row">

                <div class="col-md-6">
                    <g:uploadForm role="form" controller="home" action="addProduct">

                        <div class="form-group">
                            <label for="productname" class="loginFormElement">Product Name:</label>
                            <input type="text" class="form-control" id="productname" name="name" >
                        </div>

                        <div class="form-group">
                            <label for="productprice" class="loginFormElement">Product Price</label>
                            <input type="number" class="form-control" id="productprice" name="price" >
                        </div>

                        <div class="form-group">
                            <label class="control-label">Product Image</label>
                            <input type="file" class="filestyle" data-icon="false" name="productImage" multiple >
                        </div>

                        <div class="form-group">
                            <label class="loginformelement" for="productdescription">Product Description</label>
                            <input type="text" id="productdescription" class="form-control input-lg" placeholder="Large" name="description" >
                            <button type="submit" id="loginSubmit" class="btn btn-success loginFormElement">Add Product</button>
                        </div>
                    </g:uploadForm>
                </div>
        </div>
        </div>
</div>
</body>
</html>