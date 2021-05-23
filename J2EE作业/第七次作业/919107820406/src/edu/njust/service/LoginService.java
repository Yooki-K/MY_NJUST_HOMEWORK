package edu.njust.service;

import edu.njust.entity.Login;
import edu.njust.dao.LoginDao;

public class LoginService {

	public LoginService() {
		// TODO Auto-generated constructor stub
	}
	
	public int validateLoginInfo(Login login){
		LoginDao dao = new LoginDao();		
		return dao.findByUser(login);
	}

}
