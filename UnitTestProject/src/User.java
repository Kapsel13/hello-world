/**
 * Created by marcin on 15.04.19.
 */
public class User {
    private int age;
    private String phoneNumber;

    public User(int age, String phoneNumber){
        this.age = age;
        this.phoneNumber = phoneNumber;
    }

    public boolean compareAge(int age){
        return age > this.age ;
    }
    public int getPhoneNumberLength(){
        return this.phoneNumber.length();
    }
    public String isPhoneNumberEmpty(){
        if(this.phoneNumber.length() == 0){
            return null;
        }
        else{
            return this.phoneNumber;
        }
    }
}
