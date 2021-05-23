<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="javax.servlet.*"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>测试容器差异</title>
    
    <style type="text/css">
    .show{text-align:center;font-size:20px;}
	.title{text-align:center;font-size:50px;}
	.head{bgcolor:#515658;color:#ffffff;}
	.table{text-align:center;font-size:20px;color:#ffffff;margin:0px auto;bgcolor:#292929;}
	form{text-align:center;font-size:20px;}
	</style>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	  <%!
  			boolean isSetContext;
  			boolean isSetRequest;
  			boolean isSetSession;
  			int num=0;//访问次数
  			public String getCurrentTime(){
  				Date currentTime = new Date();
			   	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			   	return formatter.format(currentTime);
  			}
  		%>
  </head>

  <body>
  	<div class=show>连接ValidateSharedServlet</div>
    <form action="validate" method="get">
	  是否清除session: <input type="checkbox" name="isclearsession" value="on">
	  <input type="submit" value="连接(带请求转发)">
	</form>
	
	<form action="validate" method="post">
	  是否清除session: <input type="checkbox" name="isclearsession" value="on">
	  <input type="submit" value="连接(重定向)">
	</form>
	<HR style="border:1 double  #2a2a2a" width="80%" color=#2a2a2a SIZE=3>
	<%
		num+=1;
		response.setCharacterEncoding("utf-8");
		if(getServletContext().getAttribute("state")==null)
			getServletContext().setAttribute("state", String.format("第%d次访问页面", num));
		session = request.getSession();
		Object attributeOfSession=session.getAttribute("test");
		Object log = getServletContext().getAttribute("log");
		Object attributeOfContext=this.getServletContext().getAttribute("test");
		Object attributeOfRession=request.getAttribute("test");
	%>

	<% 
		if(attributeOfContext != null){
				isSetContext=true;
			}
		else{
				isSetContext=false;
			}
		if(attributeOfRession != null){
				isSetRequest=true;
			}
		else{
				isSetRequest=false;	
			}
		if(attributeOfSession != null){
				isSetSession=true;
			}
		else{
			isSetSession=false;
		}
		if(log==null){
			String logString=String.format("<div class=show>说明 : 在ValidateSharedServlet的init()中设置context的属性</div><div class=show>输出日志 : 是否可以访问容器属性-----------></div><div><table class=table bgcolor=#515658 cellspacing=10px> <tr bgcolor=#292929><td>时间</td><td>访问状态</td><td>context</td><td>request</td><td>session</td>	</tr> <tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr></table></div>",
										getCurrentTime(),
										getServletContext().getAttribute("state"),
										String.valueOf(isSetContext),
										String.valueOf(isSetRequest), 
										String.valueOf(isSetSession));
			getServletContext().setAttribute("log", logString);
		}else{
				StringBuffer logString = new StringBuffer(log.toString());
				logString.insert(logString.indexOf("</table>"), String.format("<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>", 
						getCurrentTime(),
						getServletContext().getAttribute("state"),
						String.valueOf(isSetContext),
						String.valueOf(isSetRequest),
						String.valueOf(isSetSession)));
				getServletContext().setAttribute("log", logString.toString());
		}
		out.println(getServletContext().getAttribute("log").toString());
		getServletContext().removeAttribute("state");
	 %>
  </body>
</html>
