<%@page import="com.entity.*"%>
<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getServletContext().getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>提取页面</title>
    
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
     <form action="<%=path %>/pay" method="get" id="form">
     <table border="1" width="400" id = "ReviewT"> 
        <tr>
          <td align = "center">姓名</td>
          <td align = "center"><input type="text" name="name" value=""></td>
        </tr>
        <tr>
          <td align = "center">银行卡号</td>
          <td align = "center"><input type="text" name="bankNumber" value=""></td>
        </tr>
        <tr>
        <input type="button" onclick="mysubmit()" value="确定">
        </tr>
        </table>
     </form>
     <script>
   		function mysubmit(){
        	$.ajax({
	             type: "get",
	             url: "<%=path%>/pay",
	             data: {
		             "name":$("input[name=name]").val(),
		             "bankNumber":$("input[name=bankNumber]").val()
	             },
	             dataType: "text",
	             success:function(data){
	             	alert(data);
	             	window.location.href="<%=path%>/manageReviewByPage.jsp";
	             }
	         	});
        }
     </script>
  </body>
</html>
