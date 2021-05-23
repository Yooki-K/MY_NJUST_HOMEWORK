package com;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.net.URLEncoder;

/**
 * Servlet implementation class HttpResponseTrain
 */

public class HttpResponseTrain extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HttpResponseTrain() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/plain;charset=utf-8");
		PrintWriter pWriter = response.getWriter();
		response.addHeader("name", "况宇");
		response.addHeader("学号", "919107820406");
		String n="况宇";
		String id="919107820406";
		if( request.getParameter("name").equals(n)&& request.getParameter("id").equals(id)){
			request.setAttribute("isLogin", "True");
			pWriter.println(String.format("headernames: %s", response.getHeaderNames()));
			pWriter.println(String.format("%s %s同学,访问是否成功: %s",request.getParameter("id"),request.getParameter("name"), request.getAttribute("isLogin")));
		}else{
			response.sendRedirect(String.format("/919107820406/httprequest?name=%s&id=%s", URLEncoder.encode(request.getParameter("name"),"utf-8"),request.getParameter("id")));
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
