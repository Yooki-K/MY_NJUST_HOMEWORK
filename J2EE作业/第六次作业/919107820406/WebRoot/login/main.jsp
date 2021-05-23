<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page language="java" import="javaBean.*"%>
<%
boolean isRequest=false;
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>loginSuccess</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" charset="utf-8" src="https://s3.pstatp.com/cdn/expire-1-M/jquery/3.3.1/jquery.min.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body>
  <%
	 response.setCharacterEncoding("utf-8");
	 if(!isRequest){
	 Login login=(Login)session.getAttribute("user");
	 out.println("登陆成功，欢迎"+login.getName());
	 isRequest=true;
	 }else{
	 	request.getRequestDispatcher("login").forward(request, response);
	 	isRequest=false;
	 }
  %>
   <script type="text/javascript">
	 	setTimeout(function () {
	   		window.location.reload();//刷新
		}, 5000);
   </script>
  </body>
</html>
