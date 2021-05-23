package DAO;

import java.sql.*;
import java.util.*;
import java.util.Date;

import javax.naming.NamingException;

import javaBean.*;


//实现课程course读写
public class CourseDAO extends baseDAO{
	public CourseDAO() throws ClassNotFoundException,SQLException {
		super();
	}
	public ResultSet getResultSet(String sql) throws SQLException {
		Connection con=getCon();
		Statement state=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
		return state.executeQuery(sql);
	}

	public List<Course> queryCourse(Login login) throws SQLException {
		StringBuffer sql;
		sql= new StringBuffer(String.format("select * from course where user=\"%s\";", login.getUser()));
		ResultSet resultSet;
		List<Course> cList=new ArrayList<Course>();
		resultSet=getResultSet(sql.toString());
		while(resultSet.next()){
			String id=resultSet.getString(1);
			String user=resultSet.getString(2);
			String creater=resultSet.getString(3);
			String courseName=resultSet.getString(4);
			Date time=resultSet.getTimestamp(5);
			Course course=new Course(id,user,creater,courseName,time);
			cList.add(course);
		}
		return cList;
	}
	public int[] insertCourse(List<Course> cList) throws SQLException {
		Connection con=getCon();
		PreparedStatement state = con.prepareStatement("INSERT INTO course values(?,?,?,?,?)");
		int[] array=new int[cList.size()];
		for (int i=0;i<array.length;i++) {
			array[i]=-1;
		}
		int index_1=-1;
		for (Course c : cList) {
			index_1++;
			int fResult=findCourseID(c);
			if(fResult!=0){
				array[index_1]=fResult;
				continue;
			}
			state.setString(1,c.getCourseID());
			state.setString(2,c.getUser());
			state.setString(3,c.getCreater());
			state.setString(4,c.getCourseName());
			state.setTimestamp(5,c.getCreateTime());
			state.addBatch();
		}
		int[] result=state.executeBatch();
		index_1=-1;
		for (int i : result) {
			index_1++;
			while(array[index_1]!=-1){
				index_1++;
			}
			if(index_1>=array.length) break;
			array[index_1]=i;
		}
		conCommit();
		return array;
	}
	public int findCourseID(Course c) throws SQLException{//未完
		String sql;ResultSet resultSet;
		sql=String.format("select course from course where courseID=\"%s\";", c.getCourseID());
		resultSet=getResultSet(sql);
		while(resultSet.next()){
			if(!resultSet.getString(1).equals(c.getCourseName())){
				return -2;//已经创建过该课程,且课程名不相同
			}
		}
		sql=String.format("select * from course where courseID=\"%s\" and user=\"%s\";", c.getCourseID(),c.getUser());	
		resultSet=getResultSet(sql);
		if(resultSet.isBeforeFirst()){
			return -3;//已经创建过该课程,且该用户已经拥有
		}
		return 0;
	}
	public int deleteCourse(String user,String id) throws SQLException {
		String sql=String.format("delete from course where courseID=\"%s\" and user=\"%s\";", id, user);
		Statement statement=getCon().createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		int result=statement.executeUpdate(sql);
		conCommit();
		return result;
	}
	public void conCommit() throws SQLException {
		getCon().commit();
	}
	public void conRollback() throws SQLException {
		getCon().rollback();
	}
}
