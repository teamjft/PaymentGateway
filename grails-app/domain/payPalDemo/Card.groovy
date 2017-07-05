package payPalDemo

import com.paypal.api.payments.CreditCard
import commandObject.CardType

class Card {

    String creditCardId
    String cardNumber
    CardType cardType
    static constraints = {
                creditCardId nullable: true
                cardNumber unique: true

    }
    static belongsTo = [user:User]
}
