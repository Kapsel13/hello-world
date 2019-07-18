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
    public String getName(){
        return name;
    }

    public void setName(String name){
        this.name = name;
    }

    public double getPrice(){
        return price;
    }

    public void setPrice(double price){
        this.price = price;
    }

}

