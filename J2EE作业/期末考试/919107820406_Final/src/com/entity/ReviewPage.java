package com.entity;

import java.util.Vector;


public class ReviewPage {
	private static int numPage=5;
	private int pages=0;
	private int num=0;
	private Vector<Review> cList;
	private int curPage;
	
	public ReviewPage (int curpage) {
		this.cList = new Vector<Review>();
		setCurPage(curpage);
	}

	public Vector<Review> getcList() {
		return cList;
	}
	public boolean add(Review course) {
		if(getcList().size()>=numPage) return false;
		getcList().add(course);
		if(getcList().size()>=numPage) return false;
		return true;
	}
	
	public void setNum(int num) {
		this.num = num;
		setPages();
	}
	public void setPages() {
		int num = getNum();
		if(num%numPage==0)
			pages = num/numPage;
		else {
			pages = num/numPage + 1;
		}
	}
	
	public int getPages(){
		return pages;
	}
	
	public boolean setCurPage(int curPage) {
		if(curPage>getPages()) return false;
		this.curPage = curPage;
		return true;
	}
	
	public int getCurPage() {
		return curPage;
	}
	
	public int getNum() {
		return num;
	}

	
	
	public static int getBegin(int curPage) {
		return ReviewPage.numPage*(curPage-1);
	}
	

	public static int getNumPage(){
		return numPage;
	}

}
