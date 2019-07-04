import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Created by marcin on 15.04.19.
 */
public class UserTest {
    private int basicage = 30;
    private int sampleage = 45;
    private String phoneNumberone = "444554231";
    private String phoneNumbertwo = "658893911";
    private User user;
    private User user1;
    private User user2;

    @Before
    public void setUp(){
        user = new User(basicage,phoneNumberone);
        user1 = new User(basicage,phoneNumberone);
        user2 = new User(basicage,phoneNumbertwo);
    }

    @Test
    public void AgecomparationTest(){
        assertTrue(user.Agecompration(sampleage));
    }

    @Test
    public void PhoneNumberLengthTest(){
        assertEquals(user1.PhoneNumberLength(),user2.PhoneNumberLength());
    }

    @Test
    public void isPhoneNumberEmptyTest(){
        assertNotNull(user.isPhoneNumberEmpty());
    }
}
