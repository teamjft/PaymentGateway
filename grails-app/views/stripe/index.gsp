<%--
  Created by IntelliJ IDEA.
  User: prashantk
  Date: 4/7/17
  Time: 1:05 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Stripe</title>
    <asset:javascript src="bootstrap"/>
    <asset:stylesheet href="bootstrap"/>
    <asset:stylesheet href="mystyles"/>
    <asset:javascript src="stripe"/>
    <script src="https://js.stripe.com/v3/"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <style>
/* Padding - just for asthetics on Bootsnipp.com */
body { margin-top:20px; }

/* CSS for Credit Card Payment form */
.credit-card-box .panel-title {
    display: inline;
    font-weight: bold;
}
.credit-card-box .form-control.error {
    border-color: red;
    outline: 0;
    box-shadow: inset 0 1px 1px rgba(0,0,0,0.075),0 0 8px rgba(255,0,0,0.6);
}
.credit-card-box label.error {
    font-weight: bold;
    color: red;
    padding: 2px 8px;
    margin-top: 2px;
}
.credit-card-box .payment-errors {
    font-weight: bold;
    color: red;
    padding: 2px 8px;
    margin-top: 2px;
}
.credit-card-box label {
    display: block;
}
/* The old "center div vertically" hack */
.credit-card-box .display-table {
    display: table;
}
.credit-card-box .display-tr {
    display: table-row;
}
.credit-card-box .display-td {
    display: table-cell;
    vertical-align: middle;
    width: 50%;
}
/* Just looks nicer */
.credit-card-box .panel-heading img {
    min-width: 180px;
}

</style>

    <script>
        Stripe.setPublishableKey("${grailsApplication.config.grails.plugins.stripe.publishableKey}");

        var payment=false;
        function stripeResponseHandler(status, response) {

            if (response.error) {
                $(".payment-errors").html(response.error.message);
            } else {
                var token = response['id'];
                document.forms["f1"]["stripeToken"].value=token;
                var hidval=document.forms["f1"]["stripeToken"].value;
                payment=true;

                $("#payment-form").submit();
                return payment;
            }
        }

        $(document).ready(function() {

            $("input[type=submit]").click(function(event) {
                var chargeAmount = 1000;
                Stripe.createToken({
                    number: $('.card-number').val(),
                    cvc: $('.card-cvc').val(),
                    exp_month: $('.card-expiry-month').val(),
                    exp_year: $('.card-expiry-year').val()
                }, chargeAmount, stripeResponseHandler);


                if(payment === true){
                    $("#payment-form").submit();
                    return true;
                }else
                {
                    return false;
                }
            });

        });

        if (window.location.protocol === 'file:') {
            alert("stripe.js does not work when included in pages served over file:// URLs.");
        }

    </script>

</head>
<body>


<div class="container" >
    <div class="row">
        <div class="col-xs-12 col-md-4">
            <div class="panel panel-default credit-card-box">
                <div class="panel-heading display-table" >
                    <div class="row display-tr" >
                        <h3 class="panel-title display-td" >Payment Details</h3>
                        <div class="display-td" >
                            <img class="img-responsive pull-right" src="http://i76.imgup.net/accepted_c22e0.png">
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <g:form role="form" id="payment-form" method="POST" name="f1" controller="stripe" action="charge">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label>CARD NUMBER</label>
                                    <div class="input-group">
                                        <input type="text" placeholder="Valid Card Number" autocomplete="cc-number" required autofocus data-stripe="number" class="card-number form-control"/>
                                        <span class="input-group-addon"><i class="fa fa-credit-card"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label>Amount<label>
                                    <div class="input-group">
                                        <input type="text" placeholder="Amount" name="amount" class="form-control"/>
                                        <span class="input-group-addon"><i class="fa fa-credit-card"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-7 col-md-7">
                                <div class="form-group">
                                    <label><span class="hidden-xs">EXPIRATION</span><span class="visible-xs-inline">EXP</span> DATE</label>
                                    <input type="text" size="2" data-stripe="exp-month" class="card-expiry-month" style="width: 50px;" />
                                    <input type="text" size="4" data-stripe="exp-year" class="card-expiry-year" style="width: 50px;"/>
                                </div>
                            </div>
                            <div class="col-xs-5 col-md-5 pull-right">
                                <div class="form-group">
                                    <label >CV CODE</label>
                                    <input type="text" size="4" maxlength="3" data-stripe="cvc" class="card-cvc form-control" placeholder="CVV"/>
                                    <input type="hidden" name="stripeToken"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <span class="payment-errors" > </span>
                                <input type="submit" name="submit" value="Payment" class="subscribe btn btn-success btn-lg btn-block">
                            </div>
                        </div>
                    </g:form>
                </div>
            </div>
            <!-- CREDIT CARD FORM ENDS HERE -->
</div>

</div>
</body>
</html>