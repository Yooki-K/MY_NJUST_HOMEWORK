package edu.njust.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import edu.njust.entity.*;
import edu.njust.service.CourseService;

public class CourseManageServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public CourseManageServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");	
		HttpSession session = request.getSession(false);
		if(session == null){
			request.getRequestDispatcher("login.jsp").forward(request,response);
			return;
		}
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter pw=response.getWriter();
		
		String operation = request.getParameter("operation");
		String curName = request.getParameter("cName");
		String user = ((Login)session.getAttribute("user")).getUser();
		int curPage=0;

		Course course = null;
		Course course_before=null;
		CourseService cs = new CourseService();
		if(request.getParameter("page")!=null)
			curPage = Integer.parseInt(request.getParameter("page"));
		else {
			curPage=1;
		}
		if(request.getParameter("numPage")!=null)
			cs.setPages(user,Integer.parseInt(request.getParameter("numPage")));
		else {
			cs.setPages(user);
		}
		int result = 0 ;
		if(operation.equals("add")){
			String curCreator = request.getParameter("cCreator");
			String curDate = request.getParameter("cDate");
			Date date = null;
			if(curDate!=null){
				//2020-04-07 12:43
				int year = Integer.parseInt(curDate.substring(0, 4));
				int month = Integer.parseInt(curDate.substring(5, 7));
				int day = Integer.parseInt(curDate.substring(8, 10));
				int hours = Integer.parseInt(curDate.substring(11, 13));
				int minutes = Integer.parseInt(curDate.substring(14, 16));
				
				Calendar rightNow = Calendar.getInstance();
				rightNow.set(year, month-1, day, hours, minutes);
				date = rightNow.getTime();
			    course = new Course(user,curName,curCreator,date);
			}else {
			  course = new Course(user,curName,curCreator);
			}
			if(course!=null && cs.addNewCourse(course)){
				result = 1;
			}else {
				result = -1; 
			}
		}else if(operation.equals("del")){
			course = new Course(user,curName,null,null);
			if(cs.delCourse(course)){
				result = 2; 
			}else{
				result = -2; 
			}	
		}else if(operation.equals("mod")){
			course_before = cs.findCourseByName(curName);
			String curCreator = request.getParameter("cCreator");
			String curDate = request.getParameter("cDate");
			if(curDate!=null){
				//2020-04-07 12:43
				int year = Integer.parseInt(curDate.substring(0, 4));
				int month = Integer.parseInt(curDate.substring(5, 7));
				int day = Integer.parseInt(curDate.substring(8, 10));
				int hours=0;
				int minutes=0;
				if(curDate.length()>10){
				   hours = Integer.parseInt(curDate.substring(11, 13));
				   minutes = Integer.parseInt(curDate.substring(14, 16));
				}
				Calendar rightNow = Calendar.getInstance();
				rightNow.set(year, month-1, day, hours, minutes);
				Date date = rightNow.getTime();
			    course = new Course(user,curName,curCreator,date);
			}
			if(cs.modifyCourse(course)){
				result = 5;
			}else {
				result = -5; 
			}
			
		}else if(operation.equals("modReq")){
			course = cs.findCourseByName(curName);
			if(course != null){
				result = 3;				
			}				
		}else if(operation.equals("query")){
			result = 4;
		}
		CoursePage curVec;
		switch(result){
			case 1://添加成功
				pw.println("<p>添加成功</p><p>"+course.toString()+"</p>");
				pw.println(String.format("<a href='courseManage?operation=%s'>返回课程管理</a>", "query"));
				break;
			case 4://查询
				curVec = cs.findAllCoursesByUser(user,curPage);
				request.setAttribute("allCourse", curVec);
				request.setAttribute("pages",CoursePage.getPages());
				request.setAttribute("page",curPage);
				request.getRequestDispatcher("manageCourseByPage.jsp?page="+curPage).forward(request,response);	
				break;
			case 2://删除
				pw.println("<p>删除成功</p><p>课程名："+course.getCourse()+"</p>");
				pw.println(String.format("<a href='courseManage?operation=%s'>返回课程管理</a>", "query"));
				break;	
			case 5://修改
				pw.println("<p>修改成功</p><p>改前课程信息："+course_before.toString()+"</p><p>当前课程信息："+course.toString()+"</p>");
				pw.println(String.format("<a href='courseManage?operation=%s'>返回课程管理</a>", "query"));
				break;
			case 3:
				request.setAttribute("curCourse", course);
				request.getRequestDispatcher("modifyCourse.jsp").forward(request,response);
				break;
			default://出错跳转
				request.setAttribute("error_code", result);
				request.getRequestDispatcher("failure.jsp").forward(request,response);
				break;
		}
		
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
