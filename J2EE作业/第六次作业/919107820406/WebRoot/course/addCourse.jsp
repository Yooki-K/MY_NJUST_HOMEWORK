<%@page import="javaBean.Login"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <% 
    	request.setCharacterEncoding("utf-8");
    	response.setCharacterEncoding("utf-8");
    	request.setAttribute("operate", 2);
    %>
	<jsp:include page="base.jsp">
		<jsp:param value="AddCourse" name="title"/>
		<jsp:param value="课程添加" name="logo"/>
	</jsp:include>
  </head>
 <%
 	Login login=(Login)session.getAttribute("user");
 	String basepath=request.getServletContext().getContextPath();
  %>
<body style="margin:0px;min-width: 1130px;">	
    <div style="text-align:center; magin-top:20px;">
    <form action="../course" method="post" id="addForm">
    	<input type="hidden" value="<%=login.getUser()%>" name="user" id="user">
    	<input type="hidden" value="2" name="operate"/>
    	<p>提示：课程ID输入格式：[A-Z]{1}+[0-9]{4}，如：A0001</p>
    	<table id="main" class="zlTable">
    		<tr class="thread">
    			<td>序号</td>
    			<td>课程编号</td>
    			<td>课程名称</td>
    			<td>创建者</td>
    		</tr>
    		<tr>
    			<td align="center">1</td>
    			<td><!-- 只能输入大写字母和数字 -->
    				<input type="text" id="Text1" name="id"/>
    			</td>
    			<td><input type="text" name="courseName"/></td>
    			<td><input type="text" name="creater"/></td>
    		</tr>
    	    <tr id="bottom">
    	    <th align="center"></th>
    		<th align="center"><input type="button" value="确定" onclick="mysubmit()"/></th>
    		<th align="center"><input type="button" value="继续添加" onclick="next()"/></th>
    		<th align="center">
    			<input type="reset" value="重置"/>
    			<input type="button" value="返回" onclick="back()"/>
    		</th>
    		</tr>
    	</table>
    </form>
    </div>
    <script type="text/javascript">
    	var num=1;
    	function back(){
    		window.location.replace("<%=basepath%>"+"/course");
    	}
    	function next(){
    		num=num+1;
    		$("#bottom").before("<tr><td align=\"center\">"+num+"</td><td><input type=\"text\" id=\"Text1\" name=\"id\"/></td><td><input type=\"text\" name=\"courseName\"/></td><td><input type=\"text\" name=\"creater\"/></td></tr>");
    	}
    	function checkInputId(){
    		var value=$(this).val();
    		if(value.length>5){
    			value=value.substring(0,5);
    		}
    		value=value.replace(/([\u4e00-\u9fa5a-z])/g,"");
    		$(this).val(value);
    	}
    	$("input[name='id']").on('input propertychange',checkInputId);
    	function mysubmit(){
    		var c=1;
    		$("input[name='id']").each(function(){
    			if($(this).val().replace(" ","")==""){
    				alert("课程号不能为空!");
    				c=0;
    			}else{
    			var n=$(this).val().search(/([A-Z]\d\d\d\d)/g);
    				console.log(n);
    				console.log($(this).val());
    				if(n==-1){
    					alert("课程号格式错误!");
    					c=0;
    				}
    			}
    		});
    		$("input[name='courseName']").each(function(){
    			if($(this).val().replace(" ","")==""){
    				alert("课程名不能为空!");
    				c=0;
    			}
    		});
    		$("input[name='creater']").each(function(){
    			if($(this).val().replace(" ","")==""){
    				alert("课程名不能为空!");
    				c=0;
    			}
    		});
    		if(c==1){
	    		var id=[];
	    		var courseName=[];
	    		var creater=[];
	    		
	    		$("input[name='id']").each(function(){
	    			id.push($(this).val());
	    		});
	    		$("input[name='courseName']").each(function(){
	    			courseName.push($(this).val());
	    		});
	    		$("input[name='creater']").each(function(){
	    			creater.push($(this).val());
	    		});
		  			$.ajax({
		             type: "get",
		             url: "../course",
		             data: {
			             "operate":"2",
			             "id":id,
			             "courseName":courseName,
			             "creater":creater
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
    	}
    </script>
  </body>
</html>
