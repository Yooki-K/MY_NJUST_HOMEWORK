package com.service;
import java.util.Vector;

import com.dao.ReviewDao;
import com.entity.*;

public class ReviewService {
	private ReviewDao rDao = null;
	
	public ReviewService () {
		rDao = new ReviewDao();
	}
	
	public ReviewPage findByPage(int curPage) {
		ReviewPage cPage=rDao.findByPage(curPage);
		return cPage;
	}
	public float payReviews(Vector<Review> rList){
		float sum = 0;
		for (Review review : rList) {
			boolean isSuc = rDao.setReviewPayed(review);
			if (isSuc){
				sum = sum+review.getFee();
			}
		}
		return sum;		
	}
	public Vector<Review> findById(String[] idList){
		Vector<Review> rList = new Vector<Review>();
		for (String iString : idList) {
			int i = Integer.parseInt(iString);
			Review review =rDao.findById(i);
			rList.add(review);
		}
		return rList;
	}
}
