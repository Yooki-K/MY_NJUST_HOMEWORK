package com;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.ServletConfig;
import javax.servlet.Servlet;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;




public class HelloWorldServlet implements Servlet {
//	private static final long serialVersionUID = 1L;
	private ServletConfig config;
	public void init(ServletConfig arg0) throws ServletException{
		this.config=arg0;
    }
	public ServletConfig getServletConfig() {
		return this.config;
	}
	public String getServletInfo() {
		return String.format("学号为%s的%s同学，你好！",this.config.getInitParameter("student_no"),this.config.getInitParameter("name"));
	}
	public void service(ServletRequest req,ServletResponse res) throws ServletException,IOException{
		res.setCharacterEncoding("utf-8");
		res.setContentType("text/html;charset=utf-8"); 
		PrintWriter pWriter=res.getWriter();
		pWriter.println(getServletInfo());
	}
	public void destroy() {
		
	}
}
