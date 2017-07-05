package paypaldemo

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
import commandObject.PayPalDemoCommand
import grails.transaction.Transactional
import org.codehaus.groovy.grails.commons.GrailsApplication
import payPalDemo.Card
import payPalDemo.Product
import payPalDemo.Role
import payPalDemo.User
import payPalDemo.UserRole

@Transactional
class PayPalDemoService {
    GrailsApplication grailsApplication

    def serviceMethod() {

    }
    void signup(String username,String password){
        User user=new User(username: username,password: password)
        user.save(flush: true,failOnError: true)
        Role role=Role.findByAuthority('consumer')
        UserRole userRole=new UserRole(user: user,role: role)
        userRole.save(flush: true,failOnError: true)
    }

    void removeCard(String creditCardId,User user){

        Card card=Card.findByCreditCardIdAndUser(creditCardId,user)
        card.delete(flush: true)
    }

    void addProduct(String name,String description,BigDecimal price,def productImage){

        try{
            String imageName=productImage.originalFilename
            println(imageName)

            Product product=new Product(name: name,description: description,price: price,productImage: imageName)
            product.save(flush: true,failOnError: true)
            productImage.transferTo(new File("/home/prashantk/project/paypaldemo/products/${imageName}"))

        }
        catch(Exception e){
            println("Image exception: "+e.message)
        }
    }

    String imageExtension(def image){

        String profileImagePath = "${grailsApplication.config.imagePath}"
        File imageFile =new File(profileImagePath+image)
        String extension=getFileExtension(imageFile)
        return extension;
    }
    private static String getFileExtension(File file) {
        String fileName = file.getName();
        if(fileName.lastIndexOf(".") != -1 && fileName.lastIndexOf(".") != 0)
            return fileName.substring(fileName.lastIndexOf(".")+1);
        else
            return "";
    }

}
