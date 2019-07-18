import java.util.HashMap;
import java.util.Map;

/**
 * Created by marcin on 15.04.19.
 */
public class Basket {
    private Map<Item,Integer> orderedItems = new HashMap<>();

    public Map getOrderedItems(){
        return orderedItems;
    }

    public boolean addItemsToBasket(Item itemToAdd, Integer quantity){
        if((quantity <= 0) || (itemToAdd.getPrice()<= 0)){
            return false;
        }
        for(Item item: orderedItems.keySet()){
            if(item.getName() == itemToAdd.getName()){
                return false;
            }
        }
        orderedItems.put(itemToAdd,quantity);
        return true;
    }

    public boolean removeItemsFromBasket(Item itemToRemove,Integer quantity){
        if((orderedItems.isEmpty())||(quantity <= 0)){
            return false;
        }

        int itemIsFound = 0;
        Item itemFound = null;
        Integer itemFoundQuantity = 0;
        for(Item item: orderedItems.keySet()){
            if(item.getName() == itemToRemove.getName()){
                itemIsFound = 1;
                itemFoundQuantity = orderedItems.get(item);
                itemFound = item;
            }
        }
        if((itemIsFound == 1)) {
            if (itemFoundQuantity < quantity) {
                return false;
            }
        }
        else{
            return false;
        }
        if(quantity == itemFoundQuantity){
            orderedItems.remove(itemToRemove);
        }
        else{
            orderedItems.replace(itemFound,itemFoundQuantity-quantity);
        }
        return true;
    }
    public double calculateSummarCost(){
        double costOfOrder = 0;
        for(Map.Entry<Item,Integer> mapItem: orderedItems.entrySet()){
            costOfOrder += mapItem.getKey().getPrice()*mapItem.getValue();
        }
        return costOfOrder;
    }
    public void displayOrderedItems(){
        System.out.println("Ordered items: ");
        for(Map.Entry<Item,Integer> mapItem: orderedItems.entrySet()){
            System.out.println(mapItem.getKey().getName() + ": " + mapItem.getValue());
        }
    }
}
