package paypaldemo


import com.paypal.api.payments.Credit
import com.paypal.api.payments.CreditCardToken
import com.paypal.api.payments.EventType
import com.paypal.api.payments.Webhook
import com.paypal.base.exception.PayPalException
import com.paypal.base.rest.PayPalResource
import commandObject.PayPalDemoCommand
import com.paypal.api.payments.Amount
import com.paypal.api.payments.CreditCard
import com.paypal.api.payments.Details
import com.paypal.api.payments.FundingInstrument
import com.paypal.api.payments.Payer
import com.paypal.api.payments.Payment
import com.paypal.api.payments.Transaction
import com.paypal.base.rest.APIContext
import com.paypal.base.rest.OAuthTokenCredential
import com.paypal.base.rest.PayPalRESTException
import commandObject.SavedCardCommand
import commandObject.UserCommand
import grails.plugin.springsecurity.annotation.Secured
import org.codehaus.groovy.grails.web.json.JSONObject
import org.springframework.http.MediaType
import payPalDemo.Card
import payPalDemo.Product
import payPalDemo.Role
import payPalDemo.User
import payPalDemo.UserRole

import javax.imageio.ImageIO
import java.awt.image.BufferedImage


class HomeController {

    def payPalDemoService
    def springSecurityService
    @Secured("IS_AUTHENTICATED_FULLY")
    def index() {

        List<Product> productList=Product.createCriteria().list {}
        [productList:productList]

    }
    @Secured("IS_AUTHENTICATED_FULLY")
    def payment(PayPalDemoCommand payPalDemoCommand,String saveDetails){


        payPalDemoCommand.validate();
        def  user=springSecurityService.getCurrentUser()
        List<Card> cardListOfUser=Card.findAllByUser(user)
        if(payPalDemoCommand.hasErrors()){

            render(view: 'shoppingCart',model: [payPalDemoCommand:payPalDemoCommand,price: payPalDemoCommand.amount,cardList:cardListOfUser])
            return
        }

        CreditCard creditCard = new CreditCard();

        try {

            creditCard.setCvv2( payPalDemoCommand.cvc as Integer);
            creditCard.setExpireMonth(payPalDemoCommand.expiryMonth as Integer);
            creditCard.setExpireYear(payPalDemoCommand.expiryYear as Integer);
            creditCard.setFirstName(payPalDemoCommand.firstName);
            creditCard.setLastName(payPalDemoCommand.lastName);
            creditCard.setNumber(payPalDemoCommand.cardNumber);
            creditCard.setType(payPalDemoCommand.cardType);
        }
        catch (PayPalRESTException payPalRestException){

            PayPalException

            Integer errorCode=payPalRestException.responsecode
            String msg=payPalRestException.details.details.issue.last()
            println("MSG: "+msg)

            switch (errorCode){
                case 400:println("Validation error")
                    flash.args = [msg]
                    break;
                case 401:println("Unauthorized request")
                    flash.args = [msg]
                    break;
                case 402:println("Failed request")
                    flash.args = [msg]
                    break;
                case 403:println("Forbidden")
                    flash.args = [msg]
                    break;
                case 404:println("Resource was not found")
                    flash.args = [msg]
                    break;
                default:println("Paypal Server error")
                    //flash.message="Paypal server error"
                    flash.default = "Paypal server error"
                    break;
            }
            render view: 'payment'
            return
        }


        Details details = new Details();
        details.setShipping("1");
        details.setSubtotal(payPalDemoCommand.amount.toString());
        details.setTax("1");



        String baseAmount=payPalDemoCommand.amount.toString()
        Double stringToDouble= Double.parseDouble(baseAmount);
        BigDecimal bigDecimal=BigDecimal.valueOf(stringToDouble)
        BigInteger finalAmount=bigDecimal+2;
        String finalAmountInString=finalAmount.toString()


        Amount amount = new Amount();
        amount.setCurrency("USD");
        amount.setTotal(finalAmountInString);
        amount.setDetails(details);



        Transaction transaction = new Transaction();
        transaction.setAmount(amount);
        transaction.setDescription("This is the payment transaction description.");



        List<Transaction> transactions = new ArrayList<Transaction>();
        transactions.add(transaction);

        FundingInstrument fundingInstrument = new FundingInstrument();
        fundingInstrument.setCreditCard(creditCard);

        List<FundingInstrument> fundingInstrumentList = new ArrayList<FundingInstrument>();
        fundingInstrumentList.add(fundingInstrument);



        Payer payer = new Payer();
        payer.setFundingInstruments(fundingInstrumentList);
        payer.setPaymentMethod("credit_card");



        Payment payment = new Payment();
        payment.setIntent("sale");
        payment.setPayer(payer);
        payment.setTransactions(transactions);
        Payment createdPayment = null;


        try {


            String clientID=grailsApplication.config.paypal.sandbox.clientId
            String clientSecret=grailsApplication.config.paypal.sandbox.clientSecret

            Map<String, String> sdkConfig = new HashMap<String, String>();
            sdkConfig.put("mode", "sandbox");

            Map<String, String> configurationMap = new HashMap<>();
            configurationMap.put("mode", "sandbox")
            String accessToken = new OAuthTokenCredential(clientID, clientSecret, configurationMap).getAccessToken();

            APIContext apiContext = new APIContext(accessToken);
            apiContext.setConfigurationMap(sdkConfig);

            String bearerToken=apiContext.getAccessToken();
            CreditCard createdCreditCard = creditCard.create(apiContext);


            try{
                if(saveDetails.equals("true")){

                    List<String> cardList=cardCredentials(createdCreditCard.getId(),bearerToken)

                    Card card=new Card(creditCardId: createdCreditCard.getId(),user: user,cardNumber:cardList.get(0),cardType: cardList.get(1) )
                    card.save(flush: true,failOnError: true)


                }

            }
            catch (Exception e){

                flash.message="This card has already been saved, Try another one!!"
                render(view: 'shoppingCart',model: [price: payPalDemoCommand.amount,cardList:cardListOfUser])
                return

            }

            createdPayment = payment.create(apiContext);


            println("Done payment with new card")



        } catch (PayPalRESTException ex) {


            Integer errorCode=ex.responsecode
            String msg=ex.details.details.issue.last()
            println("MSG: "+msg)

            switch (errorCode){
                case 400:println("Validation error")
                    flash.args = [msg]
                    break;
                case 401:println("Unauthorized request")
                    flash.args = [msg]
                    break;
                case 402:println("Failed request")
                    flash.args = [msg]
                    break;
                case 403:println("Forbidden")
                    flash.args = [msg]
                    break;
                case 404:println("Resource was not found")
                    flash.args = [msg]
                    break;
                default:println("Paypal Server error")
                    //flash.message="Paypal server error"
                    flash.default = "Paypal server error"
                    break;
            }
            render(view: 'payment')
            return

        }

        render(view: 'payment')

    }


    @Secured('permitAll')
    def signUp(UserCommand userCommand){

       userCommand.validate()

        if (userCommand.hasErrors()){
            render(view: 'auth',model: [userCommand:userCommand])
            return
        }

        payPalDemoService.signup(userCommand.username,userCommand.password)
        redirect(controller: 'home',action: 'index')

    }

    @Secured('permitAll')
    def savedCard(){
        def user=springSecurityService.getCurrentUser()
        List<Card> cardList=Card.findAllByUser(user)
        [cardList:cardList]
    }


    @Secured('permitAll')
    def savedCardPayment(){

        def card=Card.findByCreditCardId(params.cardId)
        [card:card,price: params.price]

    }

    @Secured('permitAll')
    def  endPayment(params){
        String cardId=params.cardId
        Integer cvc=params.cvc as Integer


        String clientID=grailsApplication.config.paypal.sandbox.clientId
        String clientSecret=grailsApplication.config.paypal.sandbox.clientSecret


        Map<String, String> configurationMap = new HashMap<>();
        configurationMap.put("mode", "sandbox")
        String accessToken = new OAuthTokenCredential(clientID, clientSecret, configurationMap).getAccessToken();


        String baseAmount=params.amount.toString()
        Double stringToDouble= Double.parseDouble(baseAmount);
        BigDecimal bigDecimal=BigDecimal.valueOf(stringToDouble)
        BigInteger finalAmount=bigDecimal+2;
        String finalAmountInString=finalAmount.toString()

        CreditCard creditCard = new CreditCard();
        creditCard.setCvv2(cvc);

        CreditCardToken creditCardToken = new CreditCardToken()
        creditCardToken.setCreditCardId(cardId)

        Details details = new Details();
        details.setShipping("1");
        details.setSubtotal(baseAmount);
        details.setTax("1");

        Amount amount = new Amount();
        amount.setCurrency("USD");
        amount.setTotal(finalAmountInString);
        amount.setDetails(details);

        Transaction transaction = new Transaction();
        transaction.setAmount(amount);
        transaction.setDescription("This is the payment transaction description.");

        List<Transaction> transactions = new ArrayList<Transaction>();
        transactions.add(transaction);

        FundingInstrument fundingInstrument = new FundingInstrument();
        fundingInstrument.setCreditCardToken(creditCardToken)


        List<FundingInstrument> fundingInstrumentList = new ArrayList<FundingInstrument>();
        fundingInstrumentList.add(fundingInstrument);

        Payer payer = new Payer();
        payer.setFundingInstruments(fundingInstrumentList);
        payer.setPaymentMethod("credit_card");

        Payment payment = new Payment();
        payment.setIntent("sale");
        payment.setPayer(payer);
        payment.setTransactions(transactions);
        Payment createdPayment = null;
        try {

                APIContext apiContext = new APIContext(accessToken);
                apiContext.setConfigurationMap(configurationMap);
                createdPayment = payment.create(apiContext);
                println("Done payment with saved card")
                render(view: 'payment')

            }
            catch (PayPalRESTException e){

                Integer errorCode=e.responsecode
                String msg=e.details.details.issue.last()

                switch (errorCode){
                    case 400:println("Validation error")
                        flash.args = [msg]
                        break;
                    case 401:println("Unauthorized request")
                        flash.args = [msg]
                        break;
                    case 402:println("Failed request")
                        flash.args = [msg]
                        break;
                    case 403:println("Forbidden")
                        flash.args = [msg]
                        break;
                    case 404:println("Resource was not found")
                        flash.args = [msg]
                        break;
                    default:println("Paypal Server error")
                        //flash.message="Paypal server error"
                        flash.default = "Paypal server error"
                        break;
                }

            }
        render(view: 'payment')


    }


    @Secured('permitAll')
    List<String> cardCredentials(String creditCardId,String bearerToken){

        String cardId=creditCardId
        String cardNumber=null
        String cardType=null

        try {
            URL url = new URL("https://api.sandbox.paypal.com/v1/vault/credit-cards/"+cardId+"");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Accept", "application/json");
        conn.setRequestProperty("Authorization", bearerToken);


        if (conn.getResponseCode() != 200) {
            throw new RuntimeException("Failed : HTTP error code : "
                    + conn.getResponseCode());
        }

        BufferedReader br = new BufferedReader(new InputStreamReader(
                (conn.getInputStream())));

        JSONObject json = new JSONObject(br.readLine());

            cardNumber=json.getString("number")
            cardType =json.getString("type")
        }catch (Exception e){
            println("====Error in cardCredentials")
        }
        List<String> stringList=new ArrayList<>()
        stringList.add(0,cardNumber)
        stringList.add(1,cardType)
        return stringList
    }

    @Secured('permitAll')
    def shoppingCart(){

        def  user=springSecurityService.getCurrentUser()
        List<Card> cardList=Card.findAllByUser(user)

        [price:params.price,cardList:cardList]
    }
    @Secured('permitAll')
    def removeCard(){

        String creditCardId=params.cardId
        def user=springSecurityService.getCurrentUser()
        payPalDemoService.removeCard(creditCardId,user)
        redirect(controller: 'home',action: 'savedCard')
    }

    @Secured('permitAll')
    def product(){


    }

    @Secured('permitAll')
    def addProduct(){

        try {
            String name=params.name
            String description=params.description
            String price=params.price
            def productImage=request.getFile("productImage")
            Double stringToDouble=price as Double
            BigDecimal priceInBigDecimal=stringToDouble as BigDecimal
            payPalDemoService.addProduct(name,description,priceInBigDecimal,productImage)

        }
        catch(Exception ex){
            println("error in product"+ex.message)
        }
        redirect(controller: 'home',action: 'index')
    }
    @Secured('permitAll')
    def renderImage(params){

        try {

            String image=params.productImage
            String profileImagePath = "${grailsApplication.config.imagePath}"

            String ext=payPalDemoService.imageExtension(image)
            File imageFile =new File(profileImagePath+"/"+image)
            BufferedImage originalImage=ImageIO.read(imageFile)
            ByteArrayOutputStream baos=new ByteArrayOutputStream();
            ImageIO.write(originalImage, ext , baos );
            byte[] imageInByte=baos.toByteArray();
            response.setHeader('Content-length', imageInByte.length.toString())
            response.contentType = 'image/jpg'
            response.outputStream << imageInByte
            response.outputStream.flush()
        }
        catch (Exception){
            println("Render image exception")
        }
    }

    @Secured('permitAll')
    def demoAction(){

        render(view: 'payment')
    }
}
