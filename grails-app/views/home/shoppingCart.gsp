<%--
  Created by IntelliJ IDEA.
  User: prashantk
  Date: 19/6/17
  Time: 11:39 AM
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

    <div class="row">
        <div class="col-md-3">
            <div class="card-list">
                <div id="window-header">My saved cards</div>
                <g:if test="${cardList}">
                    <g:each in="${cardList}">
                        <div>
                            <img src="${resource(dir: 'images',file: 'Visa.png')}"/>
                            <span class="btn btn-success" style="float: right;"><g:link controller="home"  action="savedCardPayment" params="[cardId:it.creditCardId,price:price]">Pay</g:link></span>
                            <span>${it.cardNumber}</span>
                            <span>${it.cardType}</span>
                        </div>
                    </g:each>
                </g:if>
                <g:else>
                    <div>
                       <g:message code="payPalDemo.savedcard.nosavedcard"/>
                    </div>
                </g:else>


            </div>
        </div>
        <div class="col-md-6">
            <div class="card">
                <g:form controller="home" action="payment">


                    <input type="text" name="cardNumber" placeholder="Card Number" maxlength="16">
                    <div class="error">
                        <g:renderErrors bean="${payPalDemoCommand}" as="list" field="cardNumber" />
                    </div>
                    <g:if test="${flash.message}">
                        <div class="alert alert-danger" style="display: block;margin-left:2%;max-width:88%; ">${flash.message}</div>
                    </g:if>


                    <input type="text" name="firstName" placeholder="First Name">

                    <input type="text" name="lastName" placeholder="Last Name">
                    <g:hasErrors bean="${payPalDemoCommand}">
                    <div class="error" style="width: 300px;height: 148px;margin-top: 70px;">
                        <g:renderErrors bean="${payPalDemoCommand}" as="list" field="firstName" />
                        <g:renderErrors bean="${payPalDemoCommand}" as="list" field="lastName" />
                        <g:renderErrors bean="${payPalDemoCommand}" as="list" field="cvc" />
                        <g:renderErrors bean="${payPalDemoCommand}" as="list" field="expiryMonth" />
                        <g:renderErrors bean="${payPalDemoCommand}" as="list" field="expiryYear" />
                    </div>
                    </g:hasErrors>



                    <div>
                        <input type="text" name="cvc" maxlength="3" placeholder="CVC">
                        <img style="height: 40px; width: 90px;"src="${resource(dir:'images', file:'cvv.png')}"/>
                    </div>

                    <div id="expiry">
                        <label>Expiry Date</label>
                        <select name="expiryMonth">
                            <option value="MM">MM</option>
                            <option value="01">01</option>
                            <option value="02">02</option>
                            <option value="03">03</option>
                            <option value="04">04</option>
                            <option value="05">05</option>
                            <option value="06">06</option>
                            <option value="07">07</option>
                            <option value="08">08</option>
                            <option value="09">09</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                        </select>
                        <select name="expiryYear">
                            <option value="YY">YY</option>
                            <option value="2015">2015</option>
                            <option value="2018">2018</option>
                            <option value="2019">2019</option>
                            <option value="2020">2020</option>
                            <option value="2021">2021</option>
                            <option value="2022">2022</option>
                            <option value="2023">2023</option>
                            <option value="2024">2024</option>
                            <option value="2025">2025</option>
                            <option value="2026">2026</option>
                            <option value="2027">2027</option>
                            <option value="2028">2028</option>
                        </select>
                    </div>

                    <span id="amount">

                        <g:select name="cardType" style="margin-left: -21%;width: 460px;" from="${commandObject.CardType?.values()}" keys="${commandObject.CardType.values()*.name()}" required="" value="${fieldValue(bean: cardType, field: 'cardType')}"/>
                        <input type="hidden" name="amount" value="${price}"/>
                    </span>

                    <div class="checkandsubmit" style="margin-left: 15%;padding: 1%;">
                        <label>I want to save my credit card/debit card details</label>  <input type="checkbox" name="saveDetails" value="true"/>
                    </div>


                    <div class="checkandsubmit"  style="width: 100%;">
                        <input type="submit" name="submit" value="Payment">
                    </div>

                </g:form>
                <img style="margin-left: 18%;" src="https://www.paypalobjects.com/webstatic/en_US/i/buttons/cc-badges-ppmcvdam.png" alt="Credit Card Badges">
            </div>
        </div>
        <div class="col-md-3">
            <div class="amount-payable">
                <div class="amount-payable-header">Amount Summary</div>
                <div class="amount-payable-body">
                    Amount payable
                    <span> &#8377; ${price}</span>
                </div>
            </div>
        </div>
    </div>

</div>

</body>
</html>