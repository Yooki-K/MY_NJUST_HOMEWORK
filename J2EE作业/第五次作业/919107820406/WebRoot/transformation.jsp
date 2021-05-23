<%@ page language="java" import="java.util.*" pageEncoding="utf-8" errorPage="/error.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%!String state="我是声明"; %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>MYSQL</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style>
		form{
			text-align:center;
		}
	</style>
  </head>
  
  <body>
  <%
  	Object user=request.getSession().getAttribute("user");
  	Object pwd=request.getSession().getAttribute("pwd");
  	if(user!=null && pwd!=null){
  		response.sendRedirect("toforward.jsp");
  	}
   %>
    	<form id="form" action="toforward.jsp" method="get">
    	用户名:<input id="inp_name" name="name" type="text"/><br>
    	密码: <input id="inp_id" name="pwd" type="password"/><br>
    	连接数据库<input type="submit"/><br>
    	</form>
    	<%--<%=1/0%>出错导致页面跳转 --%>
  </body>
<script type="text/javascript" charset="utf-8" src="https://s3.pstatp.com/cdn/expire-1-M/jquery/3.3.1/jquery.min.js" ></script>
<script type="text/javascript">
function submit() {
   $.ajax({
               url : "http://localhost:8080/919107820406/toforward.jsp",
               //cache : false,
               type : 'get',
               data : {
               },
               success : function(data) {
                     //跳转到用户详情处理方法，将数据传过去
                     $("#form").submit();
               }
          });
}
</script>
</html>
