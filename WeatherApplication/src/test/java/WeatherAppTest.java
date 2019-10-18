import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

import java.util.concurrent.TimeUnit;

public class WeatherAppTest {

    WebDriver driver;

    @Before
    public void setUp() {
        System.setProperty("webdriver.chrome.driver","/Users/mkowal/IdeaProjects/WeatherApplication/src/test/java/chromedriver");
        driver = new ChromeDriver();
        driver.manage().timeouts().implicitlyWait(10000, TimeUnit.MILLISECONDS);
        driver.manage().window().maximize();
        driver.get("https://dev.opsdashboard.ibm.com/");
    }

    @Test
    public void testResponseOnInvalidUsername() throws InterruptedException {
        driver.findElement(By.className("text-line")).sendKeys("TWCTestOrg1");
        driver.findElement(By.className("login-button")).click();
        Thread.sleep(5000);

        boolean isErrorDisplayed = driver.findElement(By.className("error")).isDisplayed();
        Assert.assertTrue(isErrorDisplayed);

    }

    @Test
    public void testResponseOnValidUsername() throws InterruptedException {
        driver.findElement(By.className("text-line")).sendKeys("test11@test.com");
        driver.findElement(By.className("login-button")).click();
        Thread.sleep(5000);

        boolean isPasswordInputDisplayed = driver.findElement(By.cssSelector("input[type='password']")).isDisplayed();
        Assert.assertTrue(isPasswordInputDisplayed);

    }

    @Test
    public void testResponseOnInvalidPassword() throws InterruptedException {
        driver.findElement(By.className("text-line")).sendKeys("test11@test.com");
        driver.findElement(By.className("login-button")).click();
        Thread.sleep(5000);

        driver.findElement(By.className("text-line")).sendKeys("Tghe#V");
        driver.findElement(By.className("login-button")).click();
        boolean isErrorDisplayed = driver.findElement(By.className("error")).isDisplayed();
        Assert.assertTrue(isErrorDisplayed);

    }

    @Test
    public void testResponseOnValidPassword() throws InterruptedException {
        driver.findElement(By.className("text-line")).sendKeys("test11@test.com");
        driver.findElement(By.className("login-button")).click();
        Thread.sleep(5000);

        driver.findElement(By.className("text-line")).sendKeys("%6dS4jD3");
        driver.findElement(By.className("login-button")).click();
        Thread.sleep(5000);

        boolean isLogoDisplayed= driver.findElement(By.id("twc-logo")).isDisplayed();
        Assert.assertTrue(isLogoDisplayed);
    }
    /*
    @Test
    public void testResponseOnEmptyLocation() throws InterruptedException {
        driver.findElement(By.className("text-line")).sendKeys("test11@test.com");
        driver.findElement(By.className("login-button")).click();
        Thread.sleep(5000);

        driver.findElement(By.className("text-line")).sendKeys("%6dS4jD3");
        driver.findElement(By.className("login-button")).click();
        Thread.sleep(5000);

        driver.findElement(By.id("dashboard-dropdown")).click();
        Thread.sleep(5000);

       driver.findElements(By.className("dropdown-item dropdown-action-item ng-star-inserted")).get(0).click();
       Thread.sleep(5000);

       driver.findElement(By.className("button-highlight")).click();
       Thread.sleep(5000);

       driver.findElement(By.className("button-highlight")).click();
       Thread.sleep(5000);

       String nameOfSelectedRadioButton = driver.findElement(By.cssSelector("mat-step-header[aria-selected='true']")).getText();
       Assert.assertEquals(nameOfSelectedRadioButton,"Location");
    }*/


    @After
    public void tearDown() {
        driver.quit();
    }
}
