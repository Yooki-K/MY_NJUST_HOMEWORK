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
  <div><a href="#" onclick="back()">返回</a></div>
    <%
    	if(request.getAttribute("errorMes")!=null)
    		out.println(request.getAttribute("errorMes")+"<br>");
    	else if(request.getParameter("errorMes")!=null)
    		out.println(request.getParameter("errorMes")+"<br>");
     %>
  <script>
  	function back(){
    	window.location.replace("<%=path%>"+"/course");
  	}
  	
  </script>
  </body>
</html>
