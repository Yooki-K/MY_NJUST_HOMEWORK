package com;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class HttpRequestTrain
 */
@WebServlet("/HttpRequestTrain")
public class HttpRequestTrain extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HttpRequestTrain() {
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
		PrintWriter pWriter=response.getWriter();
		pWriter.println(String.format("getContextPath: %s",request.getContextPath()));
		pWriter.println(String.format("getHeaderNames: %s",request.getHeaderNames()));
		pWriter.println(String.format("getPathInfo: %s", request.getPathInfo()));
		pWriter.println(String.format("getServletPath: %s", request.getServletPath()));
		pWriter.println(String.format("getRequestURI: %s", request.getRequestURI()));
		pWriter.println(String.format("getParameter: name=%s", request.getParameter("name")));
		pWriter.println(String.format("getParameter: 学号=%s", request.getParameter("id")));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}


}
