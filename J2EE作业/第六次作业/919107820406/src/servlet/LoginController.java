package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.Login;
import service.LoginService;

public class LoginController extends HttpServlet {
	private LoginService lService;
	public LoginController() throws SQLException, NamingException, ClassNotFoundException {
		super();
		lService=new LoginService();
	}

	/**
		 * Destruction of the servlet. <br>
		 */
	public void destroy() {
		try {
			lService.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			super.destroy();
		}
		 // Just puts "destroy" string in log
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
		doPost(request, response);
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
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		if(request.getSession().getAttribute("user")!=null){//已经登录
			request.getRequestDispatcher("course").forward(request, response);
			return;
		}
		if(request.getParameter("user")==null){//未登录
			request.getRequestDispatcher("/login/login.jsp").forward(request, response);
			return;
		}
		String user=request.getParameter("user");
		String pwd=request.getParameter("pwd");
		String college=request.getParameter("college");
		String system=request.getParameter("system");
		
		Login login=new Login(user, pwd, college, system);
		String result=lService.searchUser(login);
		if(result.equalsIgnoreCase("登录成功")){
			request.getSession().setAttribute("user", login);
			request.getRequestDispatcher("/login/main.jsp").forward(request, response);
		}else{
			request.setAttribute("errorMes", result);
			request.getRequestDispatcher("/login/loginFailure.jsp").forward(request, response);
		}
	}
	/**
	 * @see Servlet#destroy()
	 */
}
