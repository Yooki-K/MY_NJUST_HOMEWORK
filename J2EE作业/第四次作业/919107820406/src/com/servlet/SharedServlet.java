package com.servlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



public class SharedServlet extends HttpServlet {

	/**
		 * Constructor of the object.
		 */
	private ServletContext context;
	private ServletConfig config;
	
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		this.config=config;
		this.context = this.getServletContext();
		this.context.setAttribute("setAttribute_by_context", Integer.parseInt(this.context.getInitParameter("id"))+1);
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

		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		Date date=new Date();
		HttpSession session = request.getSession();
		session.setAttribute("setAttribute_by_session", Integer.parseInt(this.context.getInitParameter("id"))+2);
		request.setAttribute("setAttribute_by_request", Integer.parseInt(this.context.getInitParameter("id"))+3);
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>SharedServlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.println(String.format("<p style=\"text-align:center;font-family:黑体;\">当前时间为: %s</p>", date));
		out.println("<form style=\"text-align:center;font-family:黑体;\">");
		out.println(String.format("<p style=\"text-align:center;font-family:黑体;\">id: %s</p>", this.context.getInitParameter("id")));
		out.println(String.format("<p style=\"text-align:center;font-family:黑体;\">name: %s</p>", this.context.getInitParameter("name")));
		out.println("getAttribute_by_context: <input type=\"text\" name=\"input1\" value="
		+context.getAttribute("setAttribute_by_context")+" readonly=\"true\"><br>");
		out.println("getAttribute_by_session: <input type=\"text\" name=\"input2\" value="
		+session.getAttribute("setAttribute_by_session")+" readonly=\"true\">"
				+ "<input><br>");
		out.println("getAttribute_by_request: <input type=\"text\" name=\"input3\" value="
		+request.getAttribute("setAttribute_by_request")+" readonly=\"true\"><br>");
		out.println("</form>");
		out.println("  </BODY>");
		out.println("</HTML>");
//		request.getRequestDispatcher("")
		out.flush();
		out.close();
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
