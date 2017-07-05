<%--
  Created by IntelliJ IDEA.
  User: prashantk
  Date: 5/7/17
  Time: 12:05 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Stripe</title>
    <asset:javascript src="bootstrap"/>
    <asset:stylesheet href="bootstrap"/>
    <asset:stylesheet href="mystyles"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://js.stripe.com/v3/"></script>





    <style>
    * {
        font-family: "Helvetica Neue", Helvetica;
        font-size: 15px;
        font-variant: normal;
        padding: 0;
        margin: 0;
    }

    html {
        height: 100%;
    }

    body {
        background: #E6EBF1;
        align-items: center;
        min-height: 100%;
        display: flex;
        width: 100%;
    }

    form {
        width: 480px;
        margin: 20px auto;
    }

    .group {
        background: white;
        box-shadow: 0 7px 14px 0 rgba(49,49,93,0.10),
        0 3px 6px 0 rgba(0,0,0,0.08);
        border-radius: 4px;
        margin-bottom: 20px;
    }

    label {
        position: relative;
        color: #8898AA;
        font-weight: 300;
        height: 40px;
        line-height: 40px;
        margin-left: 20px;
        display: block;
    }

    .group label:not(:last-child) {
        border-bottom: 1px solid #F0F5FA;
    }

    label > span {
        width: 20%;
        text-align: right;
        float: left;
    }

    .field {
        background: transparent;
        font-weight: 300;
        border: 0;
        color: #31325F;
        outline: none;
        padding-right: 10px;
        padding-left: 10px;
        cursor: text;
        width: 70%;
        height: 40px;
        float: right;
    }

    .field::-webkit-input-placeholder { color: #CFD7E0; }
    .field::-moz-placeholder { color: #CFD7E0; }
    .field:-ms-input-placeholder { color: #CFD7E0; }

    button {
        float: left;
        display: block;
        background: #666EE8;
        color: white;
        box-shadow: 0 7px 14px 0 rgba(49,49,93,0.10),
        0 3px 6px 0 rgba(0,0,0,0.08);
        border-radius: 4px;
        border: 0;
        margin-top: 20px;
        font-size: 15px;
        font-weight: 400;
        width: 100%;
        height: 40px;
        line-height: 38px;
        outline: none;
    }

    button:focus {
        background: #555ABF;
    }

    button:active {
        background: #43458B;
    }

    .outcome {
        float: left;
        width: 100%;
        padding-top: 8px;
        min-height: 24px;
        text-align: center;
    }

    .success, .error {
        display: none;
        font-size: 13px;
    }

    .success.visible, .error.visible {
        display: inline;
    }

    .error {
        color: #E4584C;
    }

    .success {
        color: #666EE8;
    }

    .success .token {
        font-weight: 500;
        font-size: 13px;
    }
        input[type=submit]{
            border: none;
            color: white;;
            background-color: #666EE8;
            padding: 2%;
            width: 100%;
            border-radius: 2px;
            box-shadow: 0 7px 14px 0 rgba(49,49,93,0.10),
            0 3px 6px 0 rgba(0,0,0,0.08);
            font-weight: bold;
            text-transform: capitalize;
        }
    </style>

</head>

<body>
<div class="container">
    <div>
        <h1> Stripe Elements Demo</h1>
    </div>
    <g:form controller="stripe" action="charge" name="payment-form">
        <div class="group">
            <label>
                <span>Name</span>
                <input name="cardholder-name" class="field" placeholder="Jane Doe" />
            </label>
            <label>
                <span>Phone</span>
                <input class="field" placeholder="(123) 456-7890" type="tel" />
            </label>
            <label>
                <span>Amount</span>
                <input class="field" placeholder="Amount" type="tel" name="amount" />
                <input type="hidden" name="stripeToken" id="stoken"/>
            </label>
        </div>
        <div class="group">
            <label>
                <span>Card</span>
                <div id="card-element" class="field"></div>
            </label>
        </div>
        <input type="submit"  value="pay"/>
        <div class="outcome">
            <div class="error" role="alert"></div>
            <div class="success">
                Success! Your Stripe token is <span class="token"></span>
            </div>
        </div>
    </g:form>
</div>
<script>

    var stripe = Stripe('${grailsApplication.config.grails.plugins.stripe.publishableKey}');
    var elements = stripe.elements();

    var card = elements.create('card', {
        style: {
            base: {
                iconColor: '#666EE8',
                color: '#31325F',
                lineHeight: '40px',
                fontWeight: 300,
                fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
                fontSize: '15px',

                '::placeholder': {
                    color: '#CFD7E0',
                },
            },
        }
    });
    card.mount('#card-element');

    function setOutcome(result) {

        var successElement = document.querySelector('.success');
        var errorElement = document.querySelector('.error');
        successElement.classList.remove('visible');
        errorElement.classList.remove('visible');

        if (result.token) {

            document.getElementById("stoken").value=result.token.id;

            successElement.querySelector('.token').textContent = result.token.id;
            successElement.classList.add('visible');
            $("#payment-form")[0].submit();
            return true;

        } else if (result.error) {
            errorElement.textContent = result.error.message;
            errorElement.classList.add('visible');
            return false;
        }
        return false;

    }
    $("input[type=submit]").on('click',function(e) {

        e.preventDefault();

        var form = document.querySelector('#payment-form');
       var extraDetails = {
            name: form.querySelector('input[name=cardholder-name]').value,
        };
        var cname=document.getElementsByName("cardholder-name")[0].value;
        var amount=document.getElementsByName("amount")[0].value;

        if(cname==null || cname=="" ||amount==null || amount==""){
            alert("Fill all the details");
            return false;
        }
        else{
            stripe.createToken(card, extraDetails).then(setOutcome);
        }
    });

</script>
</body>
</html>