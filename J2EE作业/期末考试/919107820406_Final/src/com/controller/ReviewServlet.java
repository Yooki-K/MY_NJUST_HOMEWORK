package com.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entity.ReviewPage;
import com.service.ReviewService;


public class ReviewServlet extends HttpServlet {

	/**
		 * Constructor of the object.
		 */
	public ReviewServlet() {
		super();
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
		int curPage;
		request.setCharacterEncoding("utf-8");	
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");
		if(request.getParameter("page")!=null)
			curPage = Integer.parseInt(request.getParameter("page"));
		else {
			curPage = 1;
		}
		ReviewService rs = new ReviewService();
		ReviewPage curVec = rs.findByPage(curPage);
		request.setAttribute("allReview", curVec);
		request.setAttribute("page",curPage);
		request.getRequestDispatcher("manageReviewByPage.jsp?page="+curPage).forward(request,response);	
		
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
		doGet(request, response);
	}

}
