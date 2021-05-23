package DAO;

import java.sql.*;

import javax.naming.NamingException;

import javaBean.Login;

//实现用户信息user读写
public class LoginDAO extends baseDAO{
	public LoginDAO() throws ClassNotFoundException,SQLException {
		super();
	}
	public LoginDAO(int a) throws SQLException, NamingException {
		super(a);
	}
	public ResultSet getResultSet(String sql) throws SQLException {
		Connection con=getCon();
		Statement state=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
		return state.executeQuery(sql);
	}
	
	public int queryUser(Login login) {
		StringBuffer sql;
		sql= new StringBuffer(String.format("select name from user where user=\"%s\";", login.getUser()));
		ResultSet resultSet;
		int type;
		try {
			resultSet=getResultSet(sql.toString());
			if (resultSet.isBeforeFirst()) {//用户存在
				sql.insert(sql.indexOf(";"),String.format(" and password=\"%s\"",login.getPwd()));
				resultSet=getResultSet(sql.toString());
				if(resultSet.isBeforeFirst()){//密码正确
					sql.insert(sql.indexOf(";"),String.format(" and college=\"%s\" and sys=\"%s\"", login.getCollege(),
							login.getSystem()));
					resultSet=getResultSet(sql.toString());
					if(resultSet.isBeforeFirst()){//院系正确
						type=0;
						resultSet.next();
						login.setName(resultSet.getString(1));
					}else{
						type=3;//院系信息错误
					}
				}else{
					type=2;//密码错误
				}
			}else{
				type=1;//不存在此用户
			}
		} catch (SQLException e) {
			e.printStackTrace();
			type=4;
		}
		return type;
	}

}
