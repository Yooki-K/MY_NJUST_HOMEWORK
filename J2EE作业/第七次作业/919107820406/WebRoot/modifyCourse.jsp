<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="edu.njust.entity.*,java.text.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>修改课程</title>
    
    <meta name="content-type" content="text/html; charset=UTF-8">
    <?xml encoding="UTF-8"?>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
      .selectCSS{ width:200px}
    </style>
    
	<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" >
    
      function validateForm(){
		  var cName = document.forms["modCourse"]["cName"].value;
		  var cCreator = document.forms["modCourse"]["cCreator"].value;
		  if (cName ==null || cName =="")
		  {
		    alert("课程名称必须填写！");
		    return false;
		  }else if (cCreator ==null || cCreator =="")
		  {
		    alert("创建者不能为空！");
		    return false;
		  }	  
	  }
    </script>
    
  </head>
  
 <body>
  <br>
  <br>
  <center>
  <H2>修改课程信息</H2>
  <%
     Course course = (Course)request.getAttribute("curCourse");
   %>
  <form name="modCourse"  action="courseManage" onsubmit="return validateForm()" method = "get">
    <table>
      <tr>  <td><input type = "hidden" name = "operation" value="mod"> </td> </tr>
      <tr>  <td><input type = "hidden" name = "cName" value = "<%=course.getCourse()%>"></td> </tr>
      <tr>  <td> 课程名：   </td><td><input  type = "text" name = "cName-2" disabled = "true" value="<%=course.getCourse()%>"> </td> </tr>
      <tr>  <td> 创建者：   </td><td><input  type = "text" name = "cCreator" value ="<%=course.getCreator()%>"></td> </tr>
      <tr>  <td> 开设时间：</td> 
     
            <td><input type="text" name="cDate" style="width: 90%" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" value= <%=course.getFormattedDate()%>>  </td>          
      </tr>
    
    </table>
      <input  type = "submit" value = "修改"><br/>
  </form>
  </center>
 </body> 

</html>
