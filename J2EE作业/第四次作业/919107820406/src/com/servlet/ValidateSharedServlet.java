package com.servlet;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;





public class ValidateSharedServlet extends HttpServlet {

	/**
		 * Constructor of the object.
		 */
	private ServletContext context;
	private boolean isClearSession;
	static private HttpSession mySession=null;
	
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		this.context = this.getServletContext();
		context.setAttribute("test", "True");
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
		//带请求转发
		if(request.getParameter("isclearsession")==null)
			isClearSession=false;
		else {
			isClearSession=true;
		}
		getServletContext().setAttribute("state", String.format("带请求转发(是否清除会话:%s)", String.valueOf(isClearSession)));
		mySession = request.getSession();
		mySession.setAttribute("test", "True");
		request.setAttribute("test", "True");
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("/test.jsp");
		if(isClearSession){
			mySession.invalidate();
		}
		requestDispatcher.forward(request, response);
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
		//重定向
		if(request.getParameter("isclearsession")==null)
			isClearSession=false;
		else {
			isClearSession=true;
		}
		getServletContext().setAttribute("state", String.format("重定向(是否清除会话:%s)", String.valueOf(isClearSession)));
		mySession = request.getSession();
		mySession.setAttribute("test", "True");
		if(isClearSession){
			mySession.invalidate();
		}
		request.setAttribute("test", "True");
		response.sendRedirect("test.jsp");
	}
	
}
