/**
 * Created by marcin on 15.04.19.
 */
public class Item {
    private double price;
    private String name;

    public Item(double price, String name){
        this.price = price;
        this.name = name;
    }
    public String GetName(){
        return name;
    }

    public void SetName(String name){
        this.name = name;
    }

    public double GetPrice(){
        return price;
    }

    public void SetPrice(double price){
        this.price = price;
    }

}

