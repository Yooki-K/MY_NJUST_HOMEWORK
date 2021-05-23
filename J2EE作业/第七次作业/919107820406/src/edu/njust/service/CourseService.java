package edu.njust.service;

import java.util.Vector;

import edu.njust.dao.CourseDao;
import edu.njust.entity.*;


public class CourseService {
	private CourseDao  cdao = null;

	public CourseService() {
		cdao = new CourseDao();
	}
	
	public Vector<Course> findAllCoursesByUser(String user){
		Vector<Course> vecCur = cdao.findAllCoursesByUser(user);
		return vecCur;
	}
	
	public CoursePage findAllCoursesByUser(String user ,int curpage){
		CoursePage vecCur = cdao.findAllCoursesByUser(user,curpage);
		return vecCur;
	}
	
	public void setPages(String user) {
		CoursePage.setNumCourse(cdao.findAllCoursesNumByUser(user));
	}
	public void setPages(String user,int numPage) {
		setPages(user);
		CoursePage.setNumPage(numPage);
	}
	public Course findCourseByName(String name){
		Course course;
		course = cdao.findByCourseName(name);
		return course;
	}
	
	public boolean addNewCourse(Course course){
		boolean flag = false;
		if(cdao.findByCourseName(course.getCourse())==null){
			cdao.addCourse(course);		
			flag = true;
		}
		return flag;		
	}
	
	public boolean delCourse(Course course){
		boolean flag = false;
		if(cdao.findByCourseName(course.getCourse())!=null){
			cdao.delCourse(course);		
			flag = true;
		}
		return flag;		
	}
	
	public boolean modifyCourse(Course course){
		boolean flag = false;
		if(cdao.findByCourseName(course.getCourse())!=null){
			cdao.modifyCourse(course);	
			flag = true;
		}
		return flag;		
	}

}
