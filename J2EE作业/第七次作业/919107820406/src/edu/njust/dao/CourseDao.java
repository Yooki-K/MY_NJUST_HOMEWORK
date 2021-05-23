package edu.njust.dao;

import java.util.*;
import java.util.Date;

import edu.njust.entity.*;
import edu.njust.utils.*;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.ZoneOffset;


public class CourseDao {
	public CourseDao(){
	}	
	
	public boolean addCourse(Course course){ 
		Map<String, Object>valueMap = new HashMap<>();
		valueMap.put("user",course.getUser());
		valueMap.put("course",course.getCourse());
		valueMap.put("creator",course.getCreator());
		valueMap.put("cdate",course.getCreateDate());
		try {
			int count = DBUtil.insert("course", valueMap);
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
	

	public Course findByCourseName(String name){
	   Course course = null;
	   Map<String, Object> map = null;
	   Map<String, Object> whereMap = new HashMap<>();
	   whereMap.put("course", name);
	   try {
		   List<Map<String, Object>> list = DBUtil.query("course",whereMap);
		   int size = list.size();
		   if(size == 1){
			   map = list.get(0);
			   course = new Course(
					   (String)map.get("user"),
					   (String)map.get("course"),
					   (String)map.get("creator"),
					   Date.from(((LocalDateTime)map.get("cdate")).toInstant(ZoneOffset.UTC))
					   );
		   }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e){
            e.printStackTrace();
        }
       return course;
	}
	
	public Vector<Course> findAllCoursesByUser(String user){
		   Vector<Course> courseList=new Vector<Course>();
		   Map<String, Object> map = null;
		   Map<String, Object> whereMap = new HashMap<>();
		   whereMap.put("user", user);
		   try {
			   List<Map<String, Object>> list = DBUtil.query("course",whereMap);
			   int size = list.size();
			   for(int i=0;i<size;i++){
				   map = list.get(i);
				   Course course = new Course(
						   (String)map.get("user"),
						   (String)map.get("course"),
						   (String)map.get("creator"),
						   Date.from(((LocalDateTime)map.get("cdate")).toInstant(ZoneOffset.UTC))
						   );
					courseList.add(course);
			   }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } catch (Exception e){
	            e.printStackTrace();
	        }
	       return courseList;
	}	
	public int findAllCoursesNumByUser(String user){
		   try {
			   String[] sl = new String[1];
			   sl[0] = "count(*)";
			   List<Map<String, Object>> list = DBUtil.query("course", false, sl, null, null, "user", String.format("user='%s'", user), null, null);
			   return ((Long)list.get(0).get("count(*)")).intValue();
	        } catch (Exception e){
	            e.printStackTrace();
	        }
	       return -1;
	}
	public CoursePage findAllCoursesByUser(String user,int curPage){
		   CoursePage cPage=new CoursePage(curPage);
		   Map<String, Object> map = null;
		   Map<String, Object> whereMap = new HashMap<>();
		   whereMap.put("user", user);
		   try {
			   List<Map<String, Object>> list = DBUtil.query("course", whereMap,CoursePage.getBegin(curPage),CoursePage.getNumPage());
			   int size = list.size();
			   for(int i=0;i<size;i++){
				   map = list.get(i);
				   Course course = new Course(
						   (String)map.get("user"),
						   (String)map.get("course"),
						   (String)map.get("creator"),
						   Date.from(((LocalDateTime)map.get("cdate")).toInstant(ZoneOffset.UTC))
						   );
				   cPage.getcList().add(course);
			   }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } catch (Exception e){
	            e.printStackTrace();
	        }
	       return cPage;
	}	
	
	public boolean delCourse(Course course){
		Map<String, Object> whereMap = new HashMap<>();
	    whereMap.put("course", course.getCourse());
	    try {
            int count = DBUtil.delete("course", whereMap);
            if(count > 0){
            	return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
		return false;
	}
	
	public boolean modifyCourse(Course course){
		   Map<String, Object> whereMap = new HashMap<>();
		   whereMap.put("course", course.getCourse());
		   Map<String, Object> valueMap = new HashMap<>();
		   if( course.getUser()!=null ){
			  valueMap.put("user", course.getUser());
		   }
		   if( course.getCourse()!=null ){
			  valueMap.put("course", course.getCourse());
		   }
		   if( course.getCreator()!=null ){
		      valueMap.put("creator", course.getCreator());
		   }
		   if( course.getCreateDate()!=null ){
			  valueMap.put("cdate", course.getCreateDate());
		   }
		   try {
			   int count = DBUtil.update("course",valueMap, whereMap);
			   if(count > 0){
				   return true;
			   }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } catch (Exception e){
	            e.printStackTrace();
	        }
		    return false;
	}

}
