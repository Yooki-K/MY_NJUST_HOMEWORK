<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page language="java" import="javaBean.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <%String basepath=request.getServletContext().getContextPath(); %>
    <title><%=request.getParameter("title") %></title>
	<link rel="stylesheet" href="<%=basepath+"/css/h_index.css"%>"/>
	<script type="text/javascript" charset="utf-8" src="https://s3.pstatp.com/cdn/expire-1-M/jquery/3.3.1/jquery.min.js"></script>
	<%Login login=(Login)session.getAttribute("user"); 
		if(login==null){
			response.sendRedirect(basepath+"/login");
		}
	%>
</head>
<body style="margin:0px;min-width: 1130px;" >	
	<div class="zt_center">
    	<div class="zt_logo"><%=request.getParameter("logo") %></div>
        <div class="zt_user" style="padding-right: 20px;">
           	<p class="zt_u_b">
           	<span class="zt_u_name" id="user-name"><%=login.getName() %></span>
			</p>
           	<ul class="zt_u_bg" id="zt_u_bg">
           		<li class="zt_u_exit">
           			<a href="javascript:void(0)" onclick="logout()">退出登录</a>
           		</li>
           	</ul>
        </div>
    </div>
    <script>
    	function logout(){
    		window.location.replace("<%=basepath%>"+"/course/logOut.jsp");
    	}
    </script>
</body>
</html>

