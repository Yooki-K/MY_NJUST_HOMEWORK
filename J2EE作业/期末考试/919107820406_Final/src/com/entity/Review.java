package com.entity;

import java.util.Calendar;
import java.util.Date;

public class Review {
	private int reviewId;
	private String organization;
	private String paperTitle;
	private Float fee;
	private Date date;
	private boolean isPayed;
	public Review() {
		
	}
	public Review(int reviewId,String organization,String paperTitle,Float fee) {
		setReviewId(reviewId);
		setOrganization(organization);
		setPaperTitle(paperTitle);
		setFee(fee);
		setPayed(false);
		Calendar rightNow = Calendar.getInstance();
		rightNow.set(Calendar.YEAR, Calendar.MONTH, Calendar.DATE);
		setDate(rightNow.getTime());
		
	}
	public Review(int reviewId,String organization,String paperTitle,Float fee,Date date) {
		setReviewId(reviewId);
		setOrganization(organization);
		setPaperTitle(paperTitle);
		setFee(fee);
		setPayed(false);
		setDate(date);
		
	}
	public Integer getReviewId() {
		return reviewId;
	}
	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}
	public String getPaperTitle() {
		return paperTitle;
	}
	public void setPaperTitle(String paperTitle) {
		this.paperTitle = paperTitle;
	}
	public String getOrganization() {
		return organization;
	}
	public void setOrganization(String organization) {
		this.organization = organization;
	}
	public boolean isPayed() {
		return isPayed;
	}
	public void setPayed(boolean isPayed) {
		this.isPayed = isPayed;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public Float getFee() {
		return fee;
	}
	public void setFee(Float fee) {
		this.fee = fee;
	}
}
