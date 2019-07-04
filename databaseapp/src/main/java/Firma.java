	import java.sql.Connection;
	import java.sql.DriverManager;
	import java.sql.PreparedStatement;
	import java.sql.ResultSet;
	import java.sql.SQLException;
	import java.sql.Statement;
	import java.util.LinkedList;
	import java.util.List;
	import java.sql.Date;
	 
	public class Firma {
	 
	    public static final String DRIVER = "org.sqlite.JDBC";
	    public static final String DB_URL = "jdbc:sqlite:Firma.db";
	 
	    private Connection conn;
	    private Statement stat;
	 
	    public Firma() {
	        try {
	            Class.forName(Firma.DRIVER);
	        } catch (ClassNotFoundException e) {
	            System.err.println("Brak sterownika JDBC");
	            e.printStackTrace();
	        }
	 
	        try {
	            conn = DriverManager.getConnection(DB_URL);
	            stat = conn.createStatement();
	        } catch (SQLException e) {
	            System.err.println("Problem z otwarciem polaczenia");
	            e.printStackTrace();
	        }
			prepareDatabase();
	    }
	 
	    public boolean prepareDatabase()  {
	        String createDzieci = "CREATE TABLE dzieci (id serial primary key,imie varchar not null,data_urodzenia date not null,rodzic1id integer references 	 			pracownicy(id),rodzic2id integer references pracownicy(id));";

			String inserttoDzieci1 = "INSERT INTO dzieci (imie,data_urodzenia,rodzic1id,rodzic2id) VALUES ('Cieszyrad','2005-05-21',1,NULL);";
		    String inserttoDzieci2 = "INSERT INTO dzieci (imie,data_urodzenia,rodzic1id,rodzic2id) VALUES ('Aurelia','2000-09-07',2,5);";
			String inserttoDzieci3 = "INSERT INTO dzieci (imie,data_urodzenia,rodzic1id,rodzic2id) VALUES ('Magda','2013-02-23',4,6);";
			String inserttoDzieci4 = "INSERT INTO dzieci (imie,data_urodzenia,rodzic1id,rodzic2id) VALUES ('Eufemia','2005-08-29',2, NULL);";
			String inserttoDzieci5 = "INSERT INTO dzieci (imie,data_urodzenia,rodzic1id,rodzic2id) VALUES ('Więcerad','2004-09-16',1,6);";
			String inserttoDzieci6 = "INSERT INTO dzieci (imie,data_urodzenia,rodzic1id,rodzic2id) VALUES ('Matron','2002-09-23',3, NULL);";

	        try {
	            stat.execute(createDzieci);
	            stat.execute(inserttoDzieci1);
	            stat.execute(inserttoDzieci2);
		    	stat.execute(inserttoDzieci3);
		    	stat.execute(inserttoDzieci4);
		    	stat.execute(inserttoDzieci5);
		    	stat.execute(inserttoDzieci6);

	        }catch (SQLException e) {
	            System.err.println("Blad przy operacjach początkowych");
	            e.printStackTrace();
	            return false;
	        }
	        return true;
	    }
	    
	    public boolean insertDzieci(String imie, String data_urodzenia, int rodzic1id, int rodzic2id) {
	        try {
	            PreparedStatement prepStmt = conn.prepareStatement(
	                    "insert into dzieci(imie,data_urodzenia,rodzic1id,rodzic2id) values (?, ?, ?, ?)");
	            prepStmt.setString(1, imie);
	            prepStmt.setString(2, data_urodzenia);
	            prepStmt.setInt(3, rodzic1id);
	            prepStmt.setInt(4, rodzic2id);
				prepStmt.execute();
	        }catch (SQLException e) {
	            System.err.println("Blad przy wstawianiu dziecka");
	            e.printStackTrace();
	            return false;
	        }
	        return true;
	    }
	    public List<Dzieci> selectDzieciByName(String imie){
	    	List<Dzieci> dzieci = new LinkedList<Dzieci>();
	    	String sql = "SELECT * FROM dzieci where imie = ?";
	    	try {
				PreparedStatement prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1,imie);
				ResultSet result = prepStmt.executeQuery();
				int id,rodzic1id,rodzic2id;
				Date data_urodzenia;
				while(result.next()) {
					id = result.getInt("id");
					data_urodzenia = Date.valueOf(result.getString("data_urodzenia"));
					rodzic1id = result.getInt("rodzic1id");
					rodzic2id = result.getInt("rodzic2id");
					dzieci.add(new Dzieci(id, imie, data_urodzenia, rodzic1id, rodzic2id));
				}
			}
			catch (SQLException e) {
				e.printStackTrace();
				return null;
			}
			return dzieci;
		}
		public List<Dzieci> selectDzieciByDateOfBirth(String data_urodzenia){
			List<Dzieci> dzieci = new LinkedList<Dzieci>();
			String sql = "SELECT * FROM dzieci where data_urodzenia = ?";
			try {
				PreparedStatement prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1,data_urodzenia);
				ResultSet result = prepStmt.executeQuery();
				String imie;
				Date data;
				int id,rodzic1id,rodzic2id;
				while(result.next()) {
					id = result.getInt("id");
					imie = result.getString("imie");
					data = Date.valueOf(result.getString("data_urodzenia"));
					rodzic1id = result.getInt("rodzic1id");
					rodzic2id = result.getInt("rodzic2id");
					dzieci.add(new Dzieci(id, imie, data, rodzic1id, rodzic2id));
				}
			}
			catch (SQLException e) {
				e.printStackTrace();
				return null;
			}
			return dzieci;
		}
	    public List<Dzieci> selectDzieci() {
	        List<Dzieci> dzieci = new LinkedList<Dzieci>();
	        try {
	            ResultSet result = stat.executeQuery("SELECT * FROM dzieci");
	            int id,rodzic1id,rodzic2id;
	            String imie;
                    Date data_urodzenia;
	            while(result.next()) {
	                id = result.getInt("id");
	                imie = result.getString("imie");
	                data_urodzenia = Date.valueOf(result.getString("data_urodzenia"));
	                rodzic1id = result.getInt("rodzic1id");
					rodzic2id = result.getInt("rodzic2id");
	                dzieci.add(new Dzieci(id, imie, data_urodzenia, rodzic1id, rodzic2id));
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	            return null;
	        }
	        return dzieci;
	    }
	    public void closeConnection() {
	        try {
	            String dropDzieci = "DROP TABLE dzieci";
	            stat.execute(dropDzieci);
				conn.close();
	        } catch (SQLException e) {
	            System.err.println("Problem z zamknieciem polaczenia");
	            e.printStackTrace();
	        }
	    }
	}
