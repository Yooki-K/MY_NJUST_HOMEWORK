<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page language="java" import="javaBean.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<jsp:include page="base.jsp">
		<jsp:param value="DeleteCourse" name="title"/>
		<jsp:param value="课程删除" name="logo"/>
	</jsp:include>
	<%!int num=0;%>
	<%
		Login login=(Login)session.getAttribute("user");
		String basepath=request.getServletContext().getContextPath();
		request.setCharacterEncoding("utf-8");
	 %>
</head>
<body style="margin:0px;min-width: 1130px;" >	
	<%
		if(request.getAttribute("course")!=null){
			List<Course> list;
			list=(List<Course>)request.getAttribute("course");
			num=0;
			StringBuffer base=new StringBuffer("<div class=\"ZYCon\"><form id=\"delForm\" action=\"../course\" method=\"post\"><input type=\"hidden\" value=\"3\" name=\"operate\"/><table cellpadding=\"0\" cellspacing=\"0\" class=\"zlTable\" id=\"zlTable\"> <thead> <tr class=\"thread\"> <th width=\"50\" align=\"center\" class=\"brTR\">序号</th> <th width=\"400\" align=\"left\" class=\"brTR\"> <a><span>课程名称</span></a> </th> <th width=\"100\" align=\"center\" class=\"brTR\">创建者</th> <th width=\"150\" align=\"left\" class=\"brTR\">创建时间</th> </tr> </thead> <tbody id=\"tableId02\"></tbody></table></form></div>");
			for (Course c:list){
				num++;
				StringBuffer mes=new StringBuffer(String.format("<tr><td align=\"center\" class=\"font12\"><input type=\"checkbox\" name=\"checkdelete\" value=\"%s\">%d</td><td align=\"left\" class=\"font12\">%s</td><td align=\"center\" class=\"font12\">%s</td><td align=\"left\" class=\"font12\">%s</td></tr>",
				c.getCourseID(),num,c.getCourseName(),c.getCreater(),c.getCreateTime().toString()));
				base.insert(base.indexOf("</tbody>"), mes);
			}
			out.println(base.toString());
			request.removeAttribute("course");
		}else{
			request.setAttribute("operate", 4);
			request.getRequestDispatcher("/course").forward(request, response);
		}
	%>
	<div class="ZYCon">
		<input type="checkbox" id="selectAll" onchange="selectALL()"/>全选
		<input type="button" value="确定" id="" onclick="mysubmit()"/>
    	<span><a href="javascript:void(0)" onclick="back()">返回</a></span>
    </div>
    <script>
        function selectALL(){
          if ($("#selectAll").prop("checked") == true) {
              $("input[name='checkdelete']").prop("checked", true);
          } else {
              $("input[name='checkdelete']").prop("checked", false);
          }
        }
        function mysubmit(){
            var checkdelete=[];
    		$("input[name='checkdelete']").each(function(){
    			if ($(this).prop("checked") == true) {
    					checkdelete.push($(this).val());
    			}
    		});
        	$.ajax({
	             type: "get",
	             url: "<%=basepath%>"+"/course",
	             data: {
		             "deleteId":checkdelete,
		             "operate":"3"
	             },
	             dataType: "text",
	             success: function(data){
	             			if(!data.includes('errorMes')){
	             				alert(data);
	             				window.location.replace("../course");
	             			}else{
	             				console.log("<%=basepath%>"+"/course/failure.jsp?mesError="+encodeURIComponent(data));
	             				window.location.replace("<%=basepath%>"+"/course/failure.jsp?errorMes="+encodeURIComponent(data.replace("errorMes=","")));
	             			}
	                      }
	         	});
        }
        function back(){
        	window.location.replace("<%=basepath%>"+"/course");
        }
    </script>

</body>
</html>

