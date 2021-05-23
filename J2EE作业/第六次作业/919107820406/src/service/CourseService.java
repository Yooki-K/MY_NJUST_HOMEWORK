package service;

import java.sql.SQLException;
import java.util.List;

import DAO.CourseDAO;
import javaBean.*;

public class CourseService {
	private CourseDAO cDao;
	public CourseService () throws ClassNotFoundException, SQLException {
		setcDao(new CourseDAO());
	}
	public List<Course> searchCourse(Login login) throws SQLException {
		return getcDao().queryCourse(login);
	}
	public int[] insertCourse(List<Course> cList) throws SQLException {
		int[] result=getcDao().insertCourse(cList);
		return result;
	}
	public int deleteCourses(Login login,List<String> sList) throws SQLException{
		int num=0;
		for (String id : sList) {
			int result=getcDao().deleteCourse(login.getUser(),id);
			if(result!=-1){
				num=num+result;
			}
		}
		return num;
	}
	public CourseDAO getcDao() {
		return cDao;
	}
	public void setcDao(CourseDAO cDao) {
		this.cDao = cDao;
	}
	public void commit() throws SQLException {
		getcDao().conCommit();
	}
	public void rollBack() throws SQLException{
		getcDao().conRollback();
	}
	public void close() throws SQLException {
		getcDao().close();
	}
}
