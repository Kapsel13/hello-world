	import java.sql.Connection;
	import java.sql.DriverManager;
	import java.sql.PreparedStatement;
	import java.sql.ResultSet;
	import java.sql.SQLException;
	import java.sql.Statement;
	import java.util.LinkedList;
	import java.util.List;
	import java.sql.Date;
	 
	public class Company {
	 
	    public static final String DRIVER = "org.sqlite.JDBC";
	    public static final String DB_URL = "jdbc:sqlite:Company.db";
	 
	    private Connection conn;
	    private Statement stat;
	 
	    public Company() {
	        try {
	            Class.forName(Company.DRIVER);
	        } catch (ClassNotFoundException e) {
	            System.err.println("Error JDBC driver");
	            e.printStackTrace();
	        }
	 
	        try {
	            conn = DriverManager.getConnection(DB_URL);
	            stat = conn.createStatement();
	        } catch (SQLException e) {
	            System.err.println("Problem with open connection");
	            e.printStackTrace();
	        }
			prepareDatabase();
	    }
	 
	    public boolean prepareDatabase()  {
	        String createChildrenTable = "CREATE TABLE Children (id serial primary key,name varchar not null,dateOfBirth date not null,parent1id integer references employees(id),parent2id integer references employees(id));";

			String insertToChildrenTable = "INSERT INTO Children (name,dateOfBirth,parent1id,parent2id) VALUES ('Cieszyrad','2005-05-21',1,NULL);";
		    String insertToChildrenTable2 = "INSERT INTO Children (name,dateOfBirth,parent1id,parent2id) VALUES ('Aurelia','2000-09-07',2,5);";
			String insertToChildrenTable3 = "INSERT INTO Children (name,dateOfBirth,parent1id,parent2id) VALUES ('Magda','2013-02-23',4,6);";
			String insertToChildrenTable4 = "INSERT INTO Children (name,dateOfBirth,parent1id,parent2id) VALUES ('Eufemia','2005-08-29',2, NULL);";
			String insertToChildrenTable5 = "INSERT INTO Children (name,dateOfBirth,parent1id,parent2id) VALUES ('Więcerad','2004-09-16',1,6);";
			String insertToChildrenTable6 = "INSERT INTO Children (name,dateOfBirth,parent1id,parent2id) VALUES ('Matron','2002-09-23',3, NULL);";

	        try {
	            stat.execute(createChildrenTable);
	            stat.execute(insertToChildrenTable);
	            stat.execute(insertToChildrenTable2);
		    	stat.execute(insertToChildrenTable3);
		    	stat.execute(insertToChildrenTable4);
		    	stat.execute(insertToChildrenTable5);
		    	stat.execute(insertToChildrenTable6);

	        }catch (SQLException e) {
	            System.err.println("Create operations error");
	            e.printStackTrace();
	            return false;
	        }
	        return true;
	    }
	    
	    public boolean insertToChildren(String name, String dateOfBirth, int parent1id, int parent2id) {
	        try {
	            PreparedStatement prepStmt = conn.prepareStatement(
	                    "insert into Children(name,dateOfBirth,parent1id,parent2id) values (?, ?, ?, ?)");
	            prepStmt.setString(1, name);
	            prepStmt.setString(2, dateOfBirth);
	            prepStmt.setInt(3, parent1id);
	            prepStmt.setInt(4, parent2id);
				prepStmt.execute();
	        }catch (SQLException e) {
	            System.err.println("Insertion error");
	            e.printStackTrace();
	            return false;
	        }
	        return true;
	    }
	    public List<Child> selectChildByName(String name){
	    	List<Child> children = new LinkedList<Child>();
	    	String sql = "SELECT * FROM Children where name = ?";
	    	try {
				PreparedStatement prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1,name);
				ResultSet result = prepStmt.executeQuery();
				int id,parent1id,parent2id;
				Date dateOfBirth;
				while(result.next()) {
					id = result.getInt("id");
					dateOfBirth = Date.valueOf(result.getString("dateOfBirth"));
					parent1id = result.getInt("parent1id");
					parent2id = result.getInt("parent2id");
					children.add(new Child(id, name, dateOfBirth, parent1id, parent2id));
				}
			}
			catch (SQLException e) {
				e.printStackTrace();
				return null;
			}
			return children;
		}
		public List<Child> selectChildByDateOfBirth(String dateOfBirth){
			List<Child> children = new LinkedList<Child>();
			String sql = "SELECT * FROM Children where dateOfBirth = ?";
			try {
				PreparedStatement prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1,dateOfBirth);
				ResultSet result = prepStmt.executeQuery();
				String name;
				Date date;
				int id,parent1id,parent2id;
				while(result.next()) {
					id = result.getInt("id");
					name = result.getString("name");
					date = Date.valueOf(result.getString("dateOfBirth"));
					parent1id = result.getInt("parent1id");
					parent2id = result.getInt("parent2id");
					children.add(new Child(id, name, date, parent1id, parent2id));
				}
			}
			catch (SQLException e) {
				e.printStackTrace();
				return null;
			}
			return children;
		}
	    public List<Child> selectChildren() {
	        List<Child> children = new LinkedList<Child>();
	        try {
	            ResultSet result = stat.executeQuery("SELECT * FROM children");
	            int id,parent1id,parent2id;
	            String name;
				Date dateOfBirth;
	            while(result.next()) {
	                id = result.getInt("id");
	                name = result.getString("name");
					dateOfBirth= Date.valueOf(result.getString("dateOfBirth"));
	                parent1id = result.getInt("parent1id");
					parent2id = result.getInt("parent2id");
	                children.add(new Child(id, name, dateOfBirth, parent1id, parent2id));
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	            return null;
	        }
	        return children;
	    }
	    public void closeConnection() {
	        try {
	            String dropChildren = "DROP TABLE Children";
	            stat.execute(dropChildren);
				conn.close();
	        } catch (SQLException e) {
	            System.err.println("Problem with closing connection");
	            e.printStackTrace();
	        }
	    }
	}
