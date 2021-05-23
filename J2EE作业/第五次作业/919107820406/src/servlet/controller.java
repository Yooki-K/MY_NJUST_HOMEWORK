package servlet;
import javaBean.*;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
public class controller extends HttpServlet {

	/**
		 * Constructor of the object.
		 */
	public controller() {
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
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

 		response.setCharacterEncoding("utf-8");
  		response.setContentType("application/text; charset=utf-8");
  		String name=request.getParameter("sql_name");
  		String college=request.getParameter("college");
  		try{
	  		javaBean jb = (javaBean) request.getSession().getAttribute("jb");
	  		Statement state=jb.getConn().createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY, ResultSet.HOLD_CURSORS_OVER_COMMIT);
	  		String sql;
	  		student stu;
	  		if(college.equals("jsj")){
	  			sql=String.format("select 学号,大一学年综合素质评测成绩,年级排名 from jsj_cj where 姓名=\"%s\"",name);
		  		ResultSet re=state.executeQuery(sql);
		  		re.first();
	  			stu=new student(name,re.getString("学号"),re.getFloat("大一学年综合素质评测成绩"),re.getInt("年级排名"));
	  		}else{
	  			sql=String.format("select 学号,学绩,排名 from jg_cj where 姓名=\"%s\"",name);
		  		ResultSet re=state.executeQuery(sql);
		  		re.first();
	  			stu=new student(name,re.getString("学号"),re.getFloat("学绩"),re.getInt("排名"));
	  		}
	  		
	  		request.setAttribute("result", stu);
  		}catch(Exception e){
  			request.setAttribute("result", e.getMessage());
  		}finally{
  			request.getRequestDispatcher("toforward.jsp").forward(request,response);
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
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.print(this.getClass());
		out.println(", using the POST method");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

	/**
		 * Initialization of the servlet. <br>
		 *
		 * @throws ServletException if an error occurs
		 */

}
