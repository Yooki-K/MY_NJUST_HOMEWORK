<%@page import="javaBean.student"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%!String name;String pwd;%>
<%--解决jsp:getProperty中文乱码问题--%>
<%
	request.setCharacterEncoding("utf-8");
	name=request.getParameter("name");
	this.pwd=request.getParameter("pwd");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'MyJsp.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<jsp:useBean id="jb" class="javaBean.javaBean" scope="session"/>
  </head>
  <body>
         <div>
            <form action="controller" method="get">
	        	查询姓名：<input type="text" name="sql_name"/><br>
	        	选择学院：<select name="college">
	        		<option value="jsj">计算机科学与技术学院</option>
	        		<option value="jg">经济管理学院</option>
	        	</select><br>
	        	<input type="submit" value="查询"/><br>
        	</form>
        </div>
       <%
               if(request.getParameter("isclear")!=null&&request.getParameter("isclear").equals("1")){
               	session.removeAttribute("out");
               }
          	Object user=session.getAttribute("user");
  			Object pwd=session.getAttribute("pwd");
        	if(user!=null && pwd!=null){
					name=user.toString();
					this.pwd=pwd.toString();
        	}else{
        		session.setAttribute("user", name);
	        	session.setAttribute("pwd", this.pwd);
        	}
        	Object re=request.getAttribute("result");
        	if(re!=null){
        		try{
        			student stu=(student) re;
        			Object pw=session.getAttribute("out");
        			if(pw==null){
        				session.setAttribute("out", "<div><table border=1><tr><th>学号</th><th>姓名</th><th>成绩</th><th>年级排名</th></tr></table></div>");
        			}
       				StringBuffer sb=new StringBuffer(session.getAttribute("out").toString());
       				sb.insert(sb.indexOf("</table>"),String.format("<tr><td>%s</td><td>%s</td><td>%f</td><td>%d</td></tr>",
       						stu.getId(),stu.getName(),stu.getScore(),stu.getRank()));
       				session.setAttribute("out", sb.toString());
        			out.println(session.getAttribute("out"));
        			}
        		catch(Exception e){
        			out.println(e.getMessage());
        			out.println(re.toString());
        		}
        	}else{
        	      if(jb.setConn(name, this.pwd)){
       					out.println("登录成功");
	       			}
	       			else{
	       				session.removeAttribute("jb");
	       				response.sendError(404, "登录失败");
	       			}
        		}
        	
         %>
  </body>
</html>
