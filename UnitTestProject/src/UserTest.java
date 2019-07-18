import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Created by marcin on 15.04.19.
 */
public class UserTest {
    private int basicAge = 30;
    private int sampleAge = 45;
    private String phoneNumberOne = "444554231";
    private String phoneNumberTwo = "658893911";
    private User user;
    private User user1;
    private User user2;

    @Before
    public void setUp(){
        user = new User(basicAge,phoneNumberOne);
        user1 = new User(basicAge,phoneNumberOne);
        user2 = new User(basicAge,phoneNumberTwo);
    }

    @Test
    public void AgeComparationTest(){
        assertTrue(user.compareAge(sampleAge));
    }

    @Test
    public void PhoneNumberLengthTest(){
        assertEquals(user1.getPhoneNumberLength(),user2.getPhoneNumberLength());
    }

    @Test
    public void isPhoneNumberEmptyTest(){
        assertNotNull(user.isPhoneNumberEmpty());
    }
}
