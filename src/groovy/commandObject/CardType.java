package commandObject;

/**
 * Created by prashantk on 19/6/17.
 */
public enum CardType {

    visa("Visa"),
    mastercard("MasterCard"),
    amex("AmericanExpress");
    String id;

    CardType(String id){
        this.id=id;
    }

    public String getValue(){
        return this.id;
    }
    @Override
    public String toString() {
        return this.id;
    }


}
