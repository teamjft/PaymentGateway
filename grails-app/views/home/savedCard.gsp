<%--
  Created by IntelliJ IDEA.
  User: prashantk
  Date: 15/6/17
  Time: 4:00 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>PayPalDemo</title>

    <asset:stylesheet src="bootstrap"/>
    <asset:stylesheet src="bootstrap.min"/>
    <asset:javascript src="bootstrap.min"/>
    <asset:stylesheet src="mystyles"/>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

</head>
<style>
.saved-card a{
    letter-spacing: 2px;
    font-weight: bold;
    font-size: large;
    text-decoration: none;

}
.saved-card div{
    border: 0px solid black;
    float: left;
}
 #number{
    color: black;
    letter-spacing: 1px;
    font-size: 18px;
    font-weight: bold;
    float: left;
    padding: 9px;
}
.saved-card img{
    height: 40px;
    width: 90px;
    border-radius: 4px;
}
 .saved-card    #remove{
       width: 17%;padding: 4px;margin: 1px;height: 42px;
    }
.saved-card div  #cardimage{
        width:auto;margin-top: 1px;

    }
    #type{
        padding: 6px;margin-left: 5px;
        font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
        color: #979391;
        font-size: large;
    }

    .demo{
        padding: 3%;
        margin-left: 10%;
        width: auto;

    }
    .demo table tr td{
        padding: 2%;
        border-top: 1px solid #CCCCCC;
        border-bottom: 1px solid #CCCCCC;

    }
    .modal-body p{
        padding: 2%;
        margin: 2%;
    }
    .modal-body p:first-child{
        font-size: 20px;
    }

    #del{
        border: none;
        padding: 3%;
        background-color: #2e6da4;
        color: white;
    }

</style>

<body>

<div class="container">
    <div>
        <g:render template="header"/>
    </div>

    <div class="demo">
    <g:if test="${cardList}">
        <table border="0" width="100%" class="table table-striped">
        <g:each in="${cardList}" status="i" var="it">
            <tr>
                <td>
                    <div id="cardimage" >
                        <img height="40px" width="90px" src="${resource(dir:'images', file:'Visa.png')}" />
                    </div>
                </td>
                <td>
                    <div id="number">
                        ${it.cardNumber}<br>
                        ${it.cardType}
                    </div>
                </td>
                <td>
                    <button name="signup" value="Sign Up" type="button" class="btn btn-info btn-lg signup" data-toggle="modal" data-target="#${i}">Remove</button>
                </td>
            </tr>
            <div class="modal fade" id="${i}" role="dialog">
                <div class="modal-dialog modal-lg" style="width: 550px;">
                    <div class="modal-content">
                        <div class="modal-body">
                            <p>
                                Are you sure want to remove  ${it.cardType} ${it.cardNumber}?
                            </p>
                            <p>
                                To use ${it.cardType} ${it.cardNumber} you will have to add it again
                            </p>
                            <p>
                                <img height="40px" width="90px" src="${resource(dir:'images', file:'Visa.png')}" /> ${it.cardType} ${it.cardNumber}
                            </p>
                            <p>
                                <g:link controller="home" action="removeCard" params="[cardId:it.creditCardId]" style="font-size: 12px;"><button id="del">Yes, remove</button> </g:link>
                            </p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </g:each>
        </table>
        </div>
    </g:if>
    <g:else>
        <g:message code="payPalDemo.savedcard.nosavedcard"/>
    </g:else>
</div>
</body>
</html>