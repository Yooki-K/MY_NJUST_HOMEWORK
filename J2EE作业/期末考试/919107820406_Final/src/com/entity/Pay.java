package com.entity;

import java.util.Calendar;
import java.util.Date;

public class Pay {
	private int payId;
	private String name;
	private int bankNumber;
	private Float amount;
	private Date payDate;
	private boolean isSuc;
	public Pay() {
		
	}
	public Pay(String name,int bankNumber,float amount) {
		setName(name);
		setBankNumber(bankNumber);
		setAmount(amount);
		setSuc(true);
		Calendar rightNow = Calendar.getInstance();
		rightNow.set(Calendar.YEAR, Calendar.MONTH, Calendar.DATE);
		setPayDate(rightNow.getTime());
	}
	public Pay(int id,String name,int bankNumber,float amount) {
		setPayId(id);
		setName(name);
		setBankNumber(bankNumber);
		setAmount(amount);
		setSuc(true);
		Calendar rightNow = Calendar.getInstance();
		rightNow.set(Calendar.YEAR, Calendar.MONTH, Calendar.DATE);
		setPayDate(rightNow.getTime());
	}
	public int getPayId() {
		return payId;
	}
	public void setPayId(int payId) {
		this.payId = payId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Float getAmount() {
		return amount;
	}
	public void setAmount(Float amount) {
		this.amount = amount;
	}
	public int getBankNumber() {
		return bankNumber;
	}
	public void setBankNumber(int bankNumber) {
		this.bankNumber = bankNumber;
	}
	public Date getPayDate() {
		return payDate;
	}
	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}
	public boolean isSuc() {
		return isSuc;
	}
	public void setSuc(boolean isSuc) {
		this.isSuc = isSuc;
	}
}
