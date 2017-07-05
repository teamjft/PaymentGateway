package commandObject

/**
 * Created by prashantk on 13/6/17.
 */

@grails.validation.Validateable
class UserCommand {

    String username;
    String password;
    String cpassword
    static constraints={

        username nullable: false;
        password nullable: false,minSize: 5,maxSize: 8

        cpassword(nullable: false,
                validator: { passwd2, urc ->
                    return passwd2 == urc.password
                })

    }
}
