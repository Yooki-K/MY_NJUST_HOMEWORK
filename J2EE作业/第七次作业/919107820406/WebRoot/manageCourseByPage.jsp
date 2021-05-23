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
    
    <title>manageCourseByPage</title>
    
	<meta name="content-type" content="text/html; charset=UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">

		#main{

			position: absolute;
			top:10%;
			left:30%;
		}
		.inp{
		    outline-style: none ;
		    border: 1px solid #ccc; 
		    border-radius: 3px;
		    width: 30px;
		    font-size: 12px;
		    font-weight: 500;
	}
	</style>
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
	  
	  function next(){
		  if(<%=curpage%> < <%=allpage%>){
		  		window.location.replace("courseManage?operation=query&page=<%=curpage+1%>&numPage="+$("#numpage").val());
			  	return true;
		  	}
		  else{
		  	alert("已是最后一页");
		  	return false;
		  }
		  	
	  }
	  function pre(){
		  if(<%=curpage%> > 1){
		  		window.location.replace("courseManage?operation=query&page=<%=curpage-1%>&numPage="+$("#numpage").val());
			  	return true;
		  	}
		  else{
		  	alert("已是第一页");
		  	return false;
		  }	
	  }
	  function toPage(){
	  	var topage = $("#topage").val();
	  	if(topage<1) {
	  		alert("页数不能小于1！");
	  		return false;
	  	}
	  	if(topage > <%=allpage%>){
	  		alert("页数不能大于<%=allpage%>！");
	  		return false;
	  	}
	  	window.location.replace("courseManage?operation=query&page="+topage+"&numPage="+$("#numpage").val());
	  	return true;
	  }
	$(function () {
		$("#numpage").val(<%=CoursePage.getNumPage()%>);
        $("#topage").bind('input propertychange',function () {
	  	var value = $("#topage").val();
	     $("#topage").val(value.replace(/[^0-9]/g, ''));
        })
        $("#numpage").bind('input propertychange',function () {
	  	var value = $("#numpage").val();
	     $("#numpage").val(value.replace(/[^0-9]/g, ''));
        })
    })
	</script>
  </head>
  
  <body>
  <center>
  <div id="main">
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
          CoursePage curVec = (CoursePage)request.getAttribute("allCourse");
          Course course = null;
          if(curVec!=null){
             int size = curVec.getcList().size();
             int num = CoursePage.getNumPage();
             int index =CoursePage.getBegin(curpage)+1;
	      	 while (size> 0){	      	    
			    course =(Course) curVec.getcList().elementAt(size-1);
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
			    num = num-1;
			   }
			    while(num>0){
			   %>
			   	<tr>
		     	  <td align = "center" style="height:24.4px;"></td>
		     	  <td align = "center" style="height:24.4px;"></td>
		     	  <td align = "center" style="height:24.4px;"></td>
		     	  <td align = "center" style="height:24.4px;"></td>
		     	</tr>
			   <%
			   num = num-1;
			    }
		     
          }
        %>
       
      </table>

		    <a href="javascript:void(0)" onclick ="return pre();">上一页</a>
		    <span>当前页面<%=curpage %>/<%=allpage %></span>
		    <span><input type="text" id="topage" class="inp"><a href="javascript:void(0)" onclick="return toPage()">跳转</a></span>
		    <a href="javascript:void(0)" onclick ="return next();" >下一页</a>
		    <span>共有<%=CoursePage.getNumCourse()%>条记录</span>
		    <div>每页<input type="text" id="numpage" class="inp">条</div>
      </div>
      </center>
  </body>
</html>
