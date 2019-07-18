/**
 * Created by marcin on 24.04.19.
 */
public class ItemTest {
        public static void main(String[] args) {
            Item item = new Item(12, "sok");
            System.out.println("Cena: " + item.getPrice());
            System.out.println("Nazwa: " + item.getName());
            item.setName("rower");
            item.setPrice(400);
            System.out.println("Cena: " + item.getPrice());
            System.out.println("Nazwa: " + item.getName());
        }
    }