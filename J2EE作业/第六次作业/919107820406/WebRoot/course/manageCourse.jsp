<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page language="java" import="javaBean.*"%>
<%@ page language="java" import="java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<jsp:include page="base.jsp">
		<jsp:param value="ManageCourse" name="title"/>
		<jsp:param value="课程管理" name="logo"/>
	</jsp:include>
	<%!int num; %>
	<% request.setAttribute("operate", 1);%>
</head>
	<body>
    <div class="ZYCon">
    <form action="course/addCourse.jsp" id="add" method="get"></form>
    <form action="course/delCourse.jsp" id="del" method="get"></form>
    	<span><a href="javascript:void(0)" onclick="add()">新增</a></span>
    	<span><a href="javascript:void(0)" onclick="del()">删除</a></span>
    </div>
	<%
		List<Course> list=(List<Course>)request.getAttribute("course");
		num=0;
		StringBuffer base=new StringBuffer("<div class=\"ZYCon\"> <table cellpadding=\"0\" cellspacing=\"0\" class=\"zlTable\" id=\"zlTable\"> <thead> <tr class=\"thread\"> <th width=\"50\" align=\"center\" class=\"brTR\">序号</th> <th width=\"400\" align=\"left\" class=\"brTR\"> <a><span>课程名称</span></a> </th> <th width=\"100\" align=\"center\" class=\"brTR\">创建者</th> <th width=\"150\" align=\"left\" class=\"brTR\">创建时间</th> </tr> </thead> <tbody id=\"tableId02\"></tbody></table>");
		for (Course c:list){
			num++;
			StringBuffer mes=new StringBuffer(String.format("<tr><td align=\"center\" class=\"font12\">%d</td><td align=\"left\" class=\"font12\">%s</td><td align=\"center\" class=\"font12\">%s</td><td align=\"left\" class=\"font12\">%s</td></tr>",
			num,c.getCourseName(),c.getCreater(),new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(c.getCreateTime())));
			base.insert(base.indexOf("</tbody>"), mes);
		}
		out.println(base.toString());
		String mes=(String)request.getAttribute("result");
		if(mes!=null){
			String[]m=mes.split("#");
			for(String s:m){
				out.println(String.format("<p class=\"zlMes\">%s</p>", s));
			}
		}
		out.println("</div>");
		request.removeAttribute("course");
	%>
	 <script>
        function add(){
        	$("#add").submit();
        }
        function del(){
        	$("#del").submit();
        }
    </script>

</body>
</html>

