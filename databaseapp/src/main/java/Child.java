import java.util.Date;
public class Child {
    private int id;
    private String name;
    private Date dateOfBirth;
    private int parent1id;
    private int parent2id;
 
    public int getId() {
        return id;
    }
    public String getName() {
        return name;
    }
    public Date getDateOfBirth() {
       return dateOfBirth;
    }
    public int getParent1id() {
        return parent1id;
    }
    public int getParent2id() {
        return parent2id;
    }
 
    public Child() {}
    public Child(int id, String name, Date dateOfBirth, int parent1id, int parent2id) {
        this.id = id;
        this.name = name;
        this.dateOfBirth = dateOfBirth;
        this.parent1id = parent1id;
        this.parent2id = parent2id;
    }

}
