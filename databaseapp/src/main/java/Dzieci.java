import java.util.Date;
public class Dzieci {
    private int id;
    private String imie;
    private Date data_urodzenia;
    private int rodzic1id;
    private int rodzic2id;
 
    public int getId() {
        return id;
    }
    public String getImie() {
        return imie;
    }
    public Date getDataUrodzenia() {
       return data_urodzenia;
    }
    public int getRodzic1id() {
        return rodzic1id;
    }
    public int getRodzic2id() {
        return rodzic2id;
    }
 
    public Dzieci() {}
    public Dzieci(int id, String imie, Date data_urodzenia, int rodzic1id, int rodzic2id) {
        this.id = id;
        this.imie = imie;
        this.data_urodzenia = data_urodzenia;
        this.rodzic1id = rodzic1id;
        this.rodzic2id = rodzic2id;
    }

}
