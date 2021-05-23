package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entity.Pay;
import com.entity.Review;
import com.service.PayService;
import com.service.ReviewService;
import com.sun.org.apache.bcel.internal.generic.NEWARRAY;

public class PayServlet extends HttpServlet {
	Vector<Review> rList=null;
	/**
		 * Constructor of the object.
		 */
	public PayServlet() {
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
		ReviewService rs = new ReviewService();
		PayService ps = new PayService();
		PrintWriter pWriter = response.getWriter();
		response.setCharacterEncoding("utf-8");
		if(request.getParameter("name")==null){
			
			
			String[] list=request.getParameterValues("checkGet[]");
			if(list!=null){
			System.out.println(list);
			rList = rs.findById(list);
			}
			String path = request.getServletContext().getContextPath();
			pWriter.print(path+"/addPayInfo.jsp");
		}else{
			String name = request.getParameter("name");
			int bankNumber = Integer.parseInt(request.getParameter("bankNumber"));
			float sum = rs.payReviews(rList);
			Vector<Pay> pays = new Vector<Pay>();
			for (Review review : rList) {
				Pay pay = new Pay(name, bankNumber, review.getFee());
				pays.add(pay);
			}
			ps.add(pays);
			pWriter.print(String.format("successful!!! fee sum:%f",sum));
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
		doGet(request, response);
		
		
	}

}
