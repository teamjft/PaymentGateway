package commandObject

/**
 * Created by prashantk on 29/6/17.
 */

@grails.validation.Validateable
class SavedCardCommand {

    Integer cvc
    String cardId
    String amount

    static constraints={

        cvc nullable: false,matches: '^\\d{3,4}$'
        cvc validator: {
            return (it.toString().length() > 2)
        }
    }

}
