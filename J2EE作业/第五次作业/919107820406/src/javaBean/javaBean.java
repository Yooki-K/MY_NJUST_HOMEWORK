package javaBean;
import java.sql.Connection;
import java.sql.DriverManager;

public class javaBean {
	private String name;
	private String id;
	private String className="com.mysql.cj.jdbc.Driver";
	private Connection conn;
	public javaBean(){
		
	}
	public boolean setConn(String user,String password) {
		String url="jdbc:mysql://localhost:3306/cj";
		try {
			Class.forName(className);
			this.conn=DriverManager.getConnection(url, user, password);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Connection getConn() {
		return conn;
	}

}
