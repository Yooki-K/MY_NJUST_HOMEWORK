package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import com.entity.*;
import com.utils.*;


public class PayDao {
	
	public boolean add(Pay pay){ 
		Map<String, Object>valueMap = new HashMap<>();
		valueMap.put("name",pay.getName());
		valueMap.put("bankNumber",pay.getBankNumber());
		valueMap.put("amount",pay.getAmount());
		valueMap.put("payDate",pay.getPayDate());
		try {
			int count = DBUtil.insert("pay_log", valueMap);
			if(count>0){
				return true;
			}
		} 
		catch (SQLException e) {
			e.printStackTrace();
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
