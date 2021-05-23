package edu.njust.entity;

import java.util.Vector;


public class CoursePage {
	private static int numPage=3;
	private static int pages=0;
	private static int numCourse=0;
	private Vector<Course> cList;
	private int curPage;
	
	public CoursePage (int curpage) {
		this.cList = new Vector<Course>();
		setCurPage(curpage);
	}

	public Vector<Course> getcList() {
		return cList;
	}
	public boolean add(Course course) {
		if(getcList().size()>=numPage) return false;
		getcList().add(course);
		if(getcList().size()>=numPage) return false;
		return true;
	}
	
	public static void setNumCourse(int numCourse) {
		CoursePage.numCourse = numCourse;
		setPages();
	}
	public static void setPages() {
		int numCourse = CoursePage.numCourse;
		if(numCourse%numPage==0)
			CoursePage.pages = numCourse/numPage;
		else {
			CoursePage.pages = numCourse/numPage + 1;
		}
	}

	public int getCurPage() {
		return curPage;
	}
	public static int getNumCourse() {
		return numCourse;
	}
	public boolean setCurPage(int curPage) {
		if(curPage>CoursePage.pages) return false;
		this.curPage = curPage;
		return true;
	}
	
	public static void setNumPage(int numPage) {
		CoursePage.numPage =numPage;
		setPages();
		
	}
	
	public static int getBegin(int curPage) {
		return CoursePage.numPage*(curPage-1);
	}
	
	public static int getPages(){
		return pages;
	}
	public static int getNumPage(){
		return numPage;
	}

}
