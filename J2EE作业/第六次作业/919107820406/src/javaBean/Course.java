package javaBean;


import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Course {
	private String courseID;
	private String user;
	private String courseName;
	private String creater;
	private Timestamp createTime;
	public Course () {
		
	}
	public Course (String ID,String user,String creater,String courseName,Date time) {
		setUser(user);
		setCourseName(courseName);
		setCreater(creater);
		setCreateTime(time);
		setCourseID(ID);
	}
	public String toString() {
		return String.format("课程号:%s 课程名:%s 创建者:%s", getCourseID(),getCourseName(),getUser());
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	public String getCreater() {
		return creater;
	}
	public void setCreater(String creater) {
		this.creater = creater;
	}
	public Timestamp getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String timeString = df.format(createTime);
		this.createTime = Timestamp.valueOf(timeString);
	}
	public String getCourseID() {
		return courseID;
	}
	public void setCourseID(String courseID) {
		this.courseID = courseID;
	}
}
