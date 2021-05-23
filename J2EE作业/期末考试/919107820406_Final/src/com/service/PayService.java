package com.service;


import java.util.Vector;


import com.dao.PayDao;
import com.entity.*;

public class PayService {
	private PayDao pDao=null;
	public PayService () {
		pDao = new PayDao();
	}
	public void add(Vector<Pay> pList){
		for (Pay pay : pList) {
			pDao.add(pay);
		}
	}
}
