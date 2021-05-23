package edu.njust.controller;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import edu.njust.dao.*;
import edu.njust.entity.*;
import edu.njust.service.LoginService;

@SuppressWarnings("serial")
public class LoginServlet extends HttpServlet {
	
	public LoginServlet() {
		super();
	}

	
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        
        HttpSession session = request.getSession();
        //System.out.println(session);
        
        String checkcode = (String)session.getAttribute("CKECKCODE");
        int result = 3; //У���벻��ȷ
        String user = request.getParameter("uname");
        String pwd = request.getParameter("upwd");
        String code = request.getParameter("checkcode");
        
        if(checkcode!= null && code.equals(checkcode)){        	
        	Login login =  new Login(user,pwd);  
        	LoginService ls = new LoginService();        	
            result = ls.validateLoginInfo(login);
            if(result == 0){ 
            	session.setAttribute("status", "1");// "1" 登陆成功
            	session.setAttribute("user", login);
            	response.sendRedirect("courseManage?operation=query");
            }else{
            	request.setAttribute("error_code", new Integer(result));
            	request.getRequestDispatcher("loginFailure.jsp").forward(request,response);          	
            }
        }else {
        	request.setAttribute("error_code", new Integer(result));
        	request.getRequestDispatcher("loginFailure.jsp").forward(request,response);   
        }
      
	}

	public void init() throws ServletException {
		// Put your code here
	}
	

}
