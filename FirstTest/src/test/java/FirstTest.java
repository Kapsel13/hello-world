import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.Select;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * Created by marcin on 15.09.19.
 * Created by marcin on 15.09.19.
 */
public class FirstTest {
    WebDriver driver;
    @Before
    public void setUp(){
        System.setProperty("webdriver.gecko.driver","/home/marcin/IdeaProjects/sw_projects/FirstTest/src/test/java/geckodriver");
        driver= new FirefoxDriver();
        driver.manage().timeouts().implicitlyWait(10000, TimeUnit.MILLISECONDS);
        driver.manage().window().maximize();
        driver.get("http://automationpractice.com/index.php");
    }

    @Test
    public void userRegistrationWithValidData() throws InterruptedException {
        driver.findElement(By.cssSelector("[title=\"Log in to your customer account\"]")).click();
        Thread.sleep(5000);
        driver.findElement(By.id("email_create")).sendKeys("testowyemail@test.com");
        driver.findElement(By.id("SubmitCreate")).click();
        Thread.sleep(5000);
        driver.findElement(By.id("uniform-id_gender1")).click();
        driver.findElement(By.id("customer_firstname")).sendKeys("RandomowyPan");
        driver.findElement(By.id("customer_lastname")).sendKeys("RandomoweNazwisko");
        driver.findElement(By.id("email")).sendKeys("testowyemail@test.com");
        driver.findElement(By.id("passwd")).sendKeys("T#hgdguiiyi");
        Select dateOfBirth = new Select(driver.findElement(By.id("days")));
        dateOfBirth.selectByIndex(2);
        driver.findElement(By.id("uniform-newsletter")).click();
        driver.findElement(By.id("other")).sendKeys("Other information to mention ...");
        driver.findElement(By.id("submitAccount")).click();
        Thread.sleep(5000);

        boolean isAlertDisplayed = driver.findElement(By.className("alert")).isDisplayed();
        Assert.assertTrue(isAlertDisplayed);

    }
    @Test
        public void testReturnToMainPage() throws InterruptedException {
        driver.findElement(By.cssSelector("[title=\"Contact us\"]")).click();
        Thread.sleep(5000);
        driver.findElement(By.cssSelector("img[class=\"logo img-responsive\"]")).click();
        Thread.sleep(5000);
        boolean isMainPageDisplayed = driver.findElement(By.id("editorial_image_legend")).isDisplayed();
        Assert.assertTrue(isMainPageDisplayed);
    }
    @Test
        public void testContactWithValidData() throws InterruptedException {
        driver.findElement(By.cssSelector("[title=\"Contact us\"]")).click();
        Thread.sleep(5000);
        Select SubjectHeaing = new Select(driver.findElement(By.id("id_contact")));
        SubjectHeaing.selectByIndex(1);
        driver.findElement(By.id("id_order")).sendKeys("To me");
        driver.findElement(By.id("submitMessage")).click();
        Thread.sleep(5000);
        boolean isAlertDisplayed = driver.findElement(By.className("alert")).isDisplayed();
        Assert.assertTrue(isAlertDisplayed);
    }
    @Test
        public void testIfWomenPageHaveHeaderNamedWomen() throws InterruptedException {
            driver.findElement(By.cssSelector("[title='Women']")).click();
            Thread.sleep(5000);
            String headerName = driver.findElements(By.className("title_block")).get(0).getText();
            Assert.assertEquals("WOMEN",headerName);
    }

    @After
    public void tearDown(){
        driver.quit();
    }

}
