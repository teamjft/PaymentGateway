package paypaldemo

import com.stripe.Stripe
import com.stripe.exception.APIConnectionException
import com.stripe.exception.AuthenticationException
import com.stripe.exception.InvalidRequestException
import com.stripe.exception.StripeException
import com.stripe.model.Charge
import grails.plugin.springsecurity.annotation.Secured

import javax.smartcardio.CardException


@Secured("permitAll")
class StripeController {

    def index() {

    }

    def charge(String stripeToken, Double amount) {

        Stripe.apiKey=grailsApplication.config.grails.plugins.stripe.secretKey

        def amountInCents = (amount * 100) as Integer

        def chargeParams = [
                'amount': amountInCents,
                'currency': 'inr',
                'card': stripeToken,
                'description': 'StripeDemo'
        ]

        def status=null
        def success=null
        try {
            Charge.create(chargeParams);

            success = 'Your purchase was successful.'

        } catch(CardException ex) {

            status = 'There was an error processing your credit card.'
        }catch(InvalidRequestException e){
            status='InvalidRequestException'
        }catch (AuthenticationException e) {
            status='AuthenticationException'
        } catch (APIConnectionException e) {
            status='APIConnectionException'
        } catch (StripeException e) {
            status='StripeException'
        }

        redirect(action: "stripeConfirmation", params: [msg: status,success:success])

    }


    def stripeConfirmation(){

        if(params.msg){
            flash.message=params.msg
            render(view: 'stripeConfirmation')
        }
        else {
            render(view: 'stripeConfirmation')
        }
    }

    def stripeElementDemo(){

    }
}
