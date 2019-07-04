import java.util.HashMap;
import java.util.Map;

/**
 * Created by marcin on 15.04.19.
 */
public class Basket {
    private Map<Item,Integer> orderedItems = new HashMap<>();

    public Map GetOrderedItems(){
        return orderedItems;
    }

    public boolean addItemstoBasket(Item itemtoadd, Integer quantity){
        if((quantity <= 0) || (itemtoadd.GetPrice()<= 0)){
            return false;
        }
        for(Item item: orderedItems.keySet()){
            if(item.GetName() == itemtoadd.GetName()){
                return false;
            }
        }
        orderedItems.put(itemtoadd,quantity);
        return true;
    }

    public boolean removeItemsfromBasket(Item itemtoremove,Integer quantity){
        if((orderedItems.isEmpty())||(quantity <= 0)){
            return false;
        }

        int itemisfound = 0;
        Item itemfound = null;
        Integer itemfoundquantity = 0;
        for(Item item: orderedItems.keySet()){
            if(item.GetName() == itemtoremove.GetName()){
                itemisfound = 1;
                itemfoundquantity = orderedItems.get(item);
                itemfound = item;
            }
        }
        if((itemisfound == 1)) {
            if (itemfoundquantity < quantity) {
                return false;
            }
        }
        else{
            return false;
        }
        if(quantity == itemfoundquantity){
            orderedItems.remove(itemtoremove);
        }
        else{
            orderedItems.replace(itemfound,itemfoundquantity-quantity);
        }
        return true;
    }
    public double summarCost(){
        double costofOrder = 0;
        for(Map.Entry<Item,Integer> mapitem: orderedItems.entrySet()){
            costofOrder += mapitem.getKey().GetPrice()*mapitem.getValue();
        }
        return costofOrder;
    }
    public void displayOrderedItems(){
        System.out.println("Ordered items: ");
        for(Map.Entry<Item,Integer> mapitem: orderedItems.entrySet()){
            System.out.println(mapitem.getKey().GetName() + ": " + mapitem.getValue());
        }
    }
}
