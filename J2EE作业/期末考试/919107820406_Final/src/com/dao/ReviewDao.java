package com.dao;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.entity.*;
import com.utils.DBUtil;


public class ReviewDao {
	public int findAll(){
		Map<String, Object> whereMap = new HashMap<>();
		whereMap.put("isPayed", "F");
		int size=0;
		try {
		   List<Map<String, Object>> list = DBUtil.query("review_log",whereMap);
		  size = list.size();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e){
            e.printStackTrace();
        }
       return size;
	}
	public boolean setReviewPayed(Review review){
		   Map<String, Object> whereMap = new HashMap<>();
		   whereMap.put("reviewId", review.getReviewId());
		   Map<String, Object> valueMap = new HashMap<>();
		   if( review.getReviewId()!=null ){
			  valueMap.put("reviewId", review.getReviewId());
		   }
		   if( review.getOrganization()!=null ){
			  valueMap.put("organization", review.getOrganization());
		   }
		   if( review.getPaperTitle()!=null ){
		      valueMap.put("paperTitle", review.getPaperTitle());
		   }
		   if( review.getFee()!=null ){
			  valueMap.put("fee", review.getFee());
		   }
		   if( review.getDate()!=null ){
			  valueMap.put("date", review.getDate());
		   }
		   valueMap.put("isPayed", "T");
		   try {
			   int count = DBUtil.update("review_log",valueMap, whereMap);
			   if(count > 0){
				   return true;
			   }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } catch (Exception e){
	            e.printStackTrace();
	        }
		    return false;
	}
	public ReviewPage findByPage(int curPage){
		ReviewPage cPage=new ReviewPage(curPage);
		   Map<String, Object> map = null;
		   Map<String, Object> whereMap = new HashMap<>();
		   whereMap.put("isPayed", "F");
		   try {
			   List<Map<String, Object>> list = DBUtil.query("review_log", whereMap,ReviewPage.getBegin(curPage),ReviewPage.getNumPage());
			   int size = list.size();
			   for(int i=0;i<size;i++){
				   map = list.get(i);
				   Review review = new Review(
						   (int)map.get("reviewId"),
						   (String)map.get("organization"),
						   (String)map.get("paperTitle"),
						   (float)map.get("fee"),
						   Date.from(((LocalDateTime)map.get("date")).toInstant(ZoneOffset.UTC))
						  );
				   cPage.getcList().add(review);
				   cPage.setNum(findAll());
			   }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } catch (Exception e){
	            e.printStackTrace();
	        }
	       return cPage;
	}
	public Review findById(int id){
		Review review = null;
		   Map<String, Object> map = null;
		   Map<String, Object> whereMap = new HashMap<>();
		   whereMap.put("isPayed", "F");
		   whereMap.put("reviewId", id);
		   try {
			   List<Map<String, Object>> list = DBUtil.query("review_log", whereMap);
			   int size = list.size();
			   if(size==1){
				   map = list.get(0);
				   review = new Review(
						   (int)map.get("reviewId"),
						   (String)map.get("organization"),
						   (String)map.get("paperTitle"),
						   (float)map.get("fee"),
						   Date.from(((LocalDateTime)map.get("date")).toInstant(ZoneOffset.UTC))
						  );
			   }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } catch (Exception e){
	            e.printStackTrace();
	        }
	       return review;
	}
}
