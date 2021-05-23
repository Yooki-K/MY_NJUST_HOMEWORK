package DAO;
import java.sql.*;

import javax.naming.*;
import javax.sql.DataSource;
public class baseDAO {
	private Connection con;
	public baseDAO() throws SQLException, ClassNotFoundException  {
		String url ="jdbc:mysql://localhost:3306/coursemanagement?serverTimezone=GMT%2B8&useUnicode=true&characterEncoding=UTF-8";
		String user = "root";
		String pwd = "123";
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection cn = DriverManager.getConnection(url,user,pwd);
		cn.setAutoCommit(false);
		setCon(cn);
	}
	public baseDAO(int a) throws NamingException, SQLException  {
		String jndi = "java:comp/env/jdbc/lib";
		Context ctx;
		ctx = (Context) new InitialContext();
		DataSource ds=(DataSource) ctx.lookup(jndi);
		setCon(ds.getConnection());
	}
	public Connection getCon() {
		return con;
	}
	public void setCon(Connection con){
		this.con = con;	
	}
	public void  close() throws SQLException {
		getCon().close();
	}
}
