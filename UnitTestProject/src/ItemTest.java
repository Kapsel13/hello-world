/**
 * Created by marcin on 24.04.19.
 */
public class ItemTest {
        public static void main(String[] args) {
            Item item = new Item(12, "sok");
            System.out.println("Cena: " + item.GetPrice());
            System.out.println("Nazwa: " + item.GetName());
            item.SetName("rower");
            item.SetPrice(400);
            System.out.println("Cena: " + item.GetPrice());
            System.out.println("Nazwa: " + item.GetName());
        }
    }