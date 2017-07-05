<%--
  Created by IntelliJ IDEA.
  User: prashantk
  Date: 16/6/17
  Time: 3:08 PM
--%>

<%@ page import="grails.converters.JSON" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>PayPalDemo</title>

    <asset:stylesheet src="bootstrap"/>
    <asset:stylesheet src="bootstrap.min"/>
    <asset:javascript src="bootstrap.min"/>
    <asset:stylesheet src="mystyles"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <style>
        .saved-card{
            height: 300px;
            width: 400px;
            margin-left: 28%;
            border-radius: 10px;
            background-color: white;
            border: 1px solid #CCCCCC;
        }
        .saved-card img{
            height: 100px;
            width: 100%;
        }
        .saved-card .card-details{

            padding: 2%;
            margin-top: 2%;
            font-size: 24px;
            font-weight: bolder;
            letter-spacing: 7px;

        }
        #cvc-error{
            color: red;
        }
    </style>

    <script>

        function checkCvv(){
         var check=0;
            var pat="^[0-9]{3}$"
         var cvc=document.forms["f1"]["cvc"].value

         if(cvc==null || cvc==""){
         check=1;
         document.getElementById("cvc-error").innerHTML="CVV cannot be empty"
         }
         else if(!cvc.match(pat)){
             check=1;
             document.getElementById("cvc-error").innerHTML="Invalid CVV number"
         }
         else{
             check=0;
         }

            if(check==1){
                return false
            }
            else{
                return true
            }
        }

    </script>
</head>

<body>
<div class="container">
    <div>
        <g:render template="header"/>
    </div>

    <div class="saved-card">
       <g:each in="${card}">
           <img src="${resource(dir: 'images',file: 'axisbank.png')}">
           <div class="card-details">
              ${it.cardNumber}
          </div>
           <div>
               ${it.cardType}
           </div>
       </g:each>
    </div>

    <div class="cvc-form">
        <span id="cvc-error"></span>
        <g:form controller="home" action="endPayment" name="f1">

            <input type="text" name="cvc" maxlength="3" placeholder="CVV"/>
            <input type="hidden" name="amount" value="${price}" style="width:100px; "/>
            <input type="submit" name="submit" value="Payment" id="submit" onclick="return checkCvv();" />
            <g:if test="${card}">
                <input type="hidden" name="cardId" value="${card.creditCardId}" />
            </g:if>
        </g:form>

        <div>
            <img style="margin-left: 18%;" src="https://www.paypalobjects.com/webstatic/en_US/i/buttons/cc-badges-ppmcvdam.png" alt="Credit Card Badges">
        </div>
    </div>
</div>

<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg" style="width: 550px;">
        <div class="modal-content">
            <div class="modal-body">
                <p>
                    <i class="fa fa-spinner fa-spin" style="font-size:24px"></i>
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