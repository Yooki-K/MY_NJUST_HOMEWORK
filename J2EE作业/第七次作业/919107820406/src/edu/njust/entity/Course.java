package edu.njust.entity;

import java.util.Date;

import edu.njust.utils.CalendarUtil;

public class Course {
	
	private String course;
	private String creator;
	private Date createDate;
	private String user;

	public Course() {
		// TODO Auto-generated constructor stub
	}
	
	public Course(String user,String course,String creator, Date date) {
		// TODO Auto-generated constructor stub
		this.course = course;
		this.creator = creator;
		this.createDate = date;
		this.user=user;
	}
	
	public Course(String user,String course,String creator) {
		// TODO Auto-generated constructor stub
		this.user=user;
		this.course = course;
		this.creator = creator;
		this.createDate = null;
	}
	
	public String getCourse(){
		return this.course;
	}
	public String toString() {
		String string = String.format("课程名：%s，创建者：%s，创建时间：%s",course,creator,getFormattedDate());
		return string;
		
	}
	public void setCourse(String course){
		this.course = course;
	}
	
	public String getCreator(){
		return this.creator;
	}
	
	public void setCreator(String creator){
		this.creator = creator;
	}
	
	public Date getCreateDate(){
		return this.createDate;
	}
	
	public String getFormattedDate(){
		String dateStr = CalendarUtil.dateFormat(this.createDate);
		//System.out.println(dateStr);
		return dateStr;
	}
	
	public void setCreateDate(Date date){
		this.createDate = date;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

}
