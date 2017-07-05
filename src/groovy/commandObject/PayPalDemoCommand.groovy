package commandObject
/**
 * Created by prashantk on 9/6/17.
 */

@grails.validation.Validateable
class PayPalDemoCommand {
    String firstName
    String lastName
    String cardNumber
    String cvc
    BigDecimal amount
    String expiryMonth
    String expiryYear
    String cardType

    static constraints={
        firstName nullable:false
        lastName nullable:false
        cardNumber nullable:false ,maxSize: 16,minSize: 16,unique: true,creditCard: true;
        cvc nullable: false,minSize: 3,matches: '^[0-9]*$'
        expiryMonth matches: '^[0-9]*$',nullable: true
        expiryYear matches: '^[0-9]*$',nullable: true

    }

}
