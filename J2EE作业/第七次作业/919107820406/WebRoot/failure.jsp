<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>failure</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
      课程管理错误信息 <br>
    <%
    int code = ((Integer)request.getAttribute("error_code")).intValue();
    switch(code){
      case -1:
         out.println("增加失败，原因同名的课程已存在");
         break;
      case -2:
         out.println("删除失败，课程不存在");
         break;
      case -3:
         out.println("验证码有误");
         break;
    }   
     %>
     <br>
     <a href="courseManage?operation=query">返回课程管理</a>
  </body>
</html>
