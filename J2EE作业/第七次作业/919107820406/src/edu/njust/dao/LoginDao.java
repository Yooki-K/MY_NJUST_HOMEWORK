package edu.njust.dao;

import edu.njust.entity.*;
import edu.njust.utils.*;

import java.sql.*;
import java.util.*;



public class LoginDao {
	public LoginDao(){
	
	}
	
	public int findByUser(Login login){
	   int result = 2; //用户不存在		   
	   Map<String, Object> map = null;
	   Map<String, Object> whereMap = new HashMap<>();
	   whereMap.put("user", login.getUser());
	   try {
		   List<Map<String, Object>> list = DBUtil.query("user",whereMap);
		   int size = list.size();
		   if(size == 1){
			   map = list.get(0);
			   String pwd = (String)map.get("password");
			   if(pwd.equals(login.getPwd())){
				   result=0;
			   }else{
				   result=1;
			   }
		   }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e){
            e.printStackTrace();
        }
		return result;		
	}
	   
}
