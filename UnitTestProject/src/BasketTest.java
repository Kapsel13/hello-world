import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Created by marcin on 15.04.19.
 */
public class BasketTest {

    private Basket basket;
    private Item item;
    private Item item2;
    private Item item3;
    private Item item4;
    private Item item5;
    private Item item6;

    @Before
    public void setUp(){
        basket = new Basket();
        item = new Item(45,"ball");
        item2 = new Item(400,"racket");
        item3 = new Item(200,"net");
        item4 = new Item(300,"shoe");
        item5 = new Item(80,"t-shirt");
        item6 = new Item(-350,"jacket");
    }

    @Test
    public void removingwhenListisEmpty(){
        assertFalse(basket.removeItemsfromBasket(item,1));
    }
    @Test
    public void removingNegativeAmountofItems(){
        basket.addItemstoBasket(item,2);
        assertFalse(basket.removeItemsfromBasket(item,-1));
    }
    @Test
    public void removingtooManyItems(){
        basket.addItemstoBasket(item2,3);
        assertFalse(basket.removeItemsfromBasket(item2,4));
    }
    @Test
    public void removingNotFoundItem(){
        basket.addItemstoBasket(item,1);
        assertFalse(basket.removeItemsfromBasket(item2,2));
    }
    @Test
    public void addingNegativeAmountofItems(){
       assertFalse(basket.addItemstoBasket(item,-1));
    }
    @Test
    public void addingItemwithNegativePrice(){
        assertFalse(basket.addItemstoBasket(item6,2));
    }
    @Test
    public void addingexistingItem(){
       basket.addItemstoBasket(item2,3);
       assertFalse(basket.addItemstoBasket(item2,2));
    }
    @Test
    public void goodadding(){
        basket.addItemstoBasket(item,2);
        assertEquals(1,basket.GetOrderedItems().size());
    }
    @Test
    public void goodremoving(){
        basket.addItemstoBasket(item,8);
        basket.removeItemsfromBasket(item,3);
        assertEquals(5,basket.GetOrderedItems().get(item));
    }
}