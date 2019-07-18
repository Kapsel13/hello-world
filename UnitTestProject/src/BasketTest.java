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
    public void removingWhenListisEmpty(){
        assertFalse(basket.removeItemsFromBasket(item,1));
    }
    @Test
    public void removingNegativeAmountOfItems(){
        basket.addItemsToBasket(item,2);
        assertFalse(basket.removeItemsFromBasket(item,-1));
    }
    @Test
    public void removingTooManyItems(){
        basket.addItemsToBasket(item2,3);
        assertFalse(basket.removeItemsFromBasket(item2,4));
    }
    @Test
    public void removingNotFoundItem(){
        basket.addItemsToBasket(item,1);
        assertFalse(basket.removeItemsFromBasket(item2,2));
    }
    @Test
    public void addingNegativeAmountOfItems(){
       assertFalse(basket.addItemsToBasket(item,-1));
    }
    @Test
    public void addingItemWithNegativePrice(){
        assertFalse(basket.addItemsToBasket(item6,2));
    }
    @Test
    public void addingExistingItem(){
       basket.addItemsToBasket(item2,3);
       assertFalse(basket.addItemsToBasket(item2,2));
    }
    @Test
    public void goodAdding(){
        basket.addItemsToBasket(item,2);
        assertEquals(1,basket.getOrderedItems().size());
    }
    @Test
    public void goodRemoving(){
        basket.addItemsToBasket(item,8);
        basket.removeItemsFromBasket(item,3);
        assertEquals(5,basket.getOrderedItems().get(item));
    }
}