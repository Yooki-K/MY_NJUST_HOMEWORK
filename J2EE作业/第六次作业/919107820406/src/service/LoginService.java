package service;

import java.sql.SQLException;

import javax.naming.NamingException;

import DAO.LoginDAO;
import javaBean.Login;

public class LoginService {
	private LoginDAO lDao;
	public LoginService() throws SQLException, NamingException, ClassNotFoundException {
		setlDao(new LoginDAO(1));
	}
	public String searchUser(Login login) {
		int result = getlDao().queryUser(login);
		String mes;
		switch (result) {
		case 0:
			mes="登录成功";
			break;
		case 1:
			mes="用户不存在";
			break;
		case 2:
			mes="密码错误";
			break;
		case 3:
			mes="院系信息填写错误";
			break;
		default:
			mes="连接失败";
			break;
		}
		return mes;
	}
	public LoginDAO getlDao() {
		return lDao;
	}
	public void setlDao(LoginDAO lDao) {
		this.lDao = lDao;
	}
	public void close() throws SQLException {
		getlDao().close();
	}
}
