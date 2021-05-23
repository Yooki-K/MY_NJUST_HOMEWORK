<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ page import= "edu.njust.entity.*,edu.njust.dao.*" %>

<%
String path = request.getServletContext().getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>manageCourse</title>
    
	<meta name="content-type" content="text/html; charset=UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<%
		int curpage = (Integer)request.getAttribute("page"); 
		int allpage = (Integer)request.getAttribute("pages"); 
	%>
	<script type="text/javascript" charset="utf-8" src="https://s3.pstatp.com/cdn/expire-1-M/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript" >
	  function inValidateSession(){
	    session.invalidate();
	  }
	  
	  function delConfirm(){
	    if(confirm("确定删除吗？")){
	      return true;
	    }
	    else{
	      return false;
	    }
	  
	  }

	</script>
  </head>
  
  <body>
  <center>
     <table border="1" width="600">
        <tr>
          <td align = "center"><a href ="addCourse.jsp"> 新     增</a>
          <td align = "center"><a href ="login.jsp" onclick="inValidateSession()"> 退出登录</a>
        </tr>
   </table>
   <table border="1" width="600" id = "courseT">       
      <tr>
          <td align = "center">序号</td>
          <td align = "center">课程名称</td>
          <td align = "center">创建者</td>
          <td align = "center">创建时间</td>
        </tr>
        <% 
          Vector<Course> curVec = (Vector<Course>)request.getAttribute("allCourse");
          Course course = null;
          if(curVec!=null){
             int size = curVec.size();
             int index =1; //starting from 1
	      	 while (size> 0){	      	    
			    course =(Course) curVec.elementAt(size-1);
		     	if(course != null){
		%>
		     	<tr>
		     	  <td align = "center"><%=index%></td>
		     	  <td align = "center"><%=course.getCourse() %></td>
		     	  <td align = "center"><%=course.getCreator()%></td>
		     	  <% Date date = course.getCreateDate();
		     	     if(date != null){
		     	  %>
		     	    <td align = "center"><%=date.toLocaleString() %></td>
		     	  <% }else { %>
		     	     <td align = "center">未填写日期</td>
		     	  <% } %>
		     	      <td align = "center"><a href="courseManage?operation=del&cName=<%=course.getCourse() %>" onclick ="return delConfirm();" >删除</a></td>
		     	      <td align = "center"><a href="courseManage?operation=modReq&cName=<%=course.getCourse() %>">修改</a></td>
		     
		     	</tr>
		     	<%
			    	}
			    	index = index +1;
			    	size = size -1;
			   		}
			    }
		     
       			 %>
      </table>
      </center>
  </body>
</html>
