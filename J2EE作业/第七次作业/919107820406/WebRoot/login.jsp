<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>登录</title>
    
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
    
	<script type="text/javascript" src="jquery"></script>
    <script type="text/javascript" >
    
      function validateForm(){
		  var uname = document.forms["login"]["uname"].value;
		  var upwd = document.forms["login"]["upwd"].value;
		  var code = document.forms["login"]["checkcode"].value;
		  if (uname ==null || uname =="")
		  {
		    alert("姓名必须填写！");
		    return false;
		  }else if (upwd ==null || upwd =="")
		  {
		    alert("密码不能为空！");
		    return false;
		  }else if (code ==null || code ==""){
		    alert("必须输入验证码！");
		    return false;
		  }		  
	  }
	  
	  var schoolName = [{label:"cs",value:"计算机学院"},{label:"auto",value:"自动化学院"},{label:"mech",value:"机械学院"}];
	  //var school ={"计算机学院","自动化学院","机械学院"};
	  var csDep = new Array("软件工程","计算机科学与技术","网络空间安全","智能科学与技术");
	  var autoDep = new Array("电力工程","电气自动化","轨道编程");
	  var mechDep = new Array("汽车制造","工业互联网","智能制造");	  
	  
	  function initDep(){
	    var school=document.getElementById("school");
	    var i =0;
	    var s ="";
	    for(i=0;i<schoolName.length;i++){
	      s += "<option value="+schoolName[i].label +">"+schoolName[i].value+"</option>";  
	    }
	    school.innerHTML=s;
	    
	    var department=document.getElementById("department");
	    i =0;
	    s ="";
	    for(i=0;i<csDep.length;i++){
	      s += "<option>"+csDep[i]+"</option>";
	   //   var op=document.createElement("option");
	   //   op.setAttribute("label", s.label); 
	   //   op.setAttribute("value", s.value); 
	   //   department.appendChild(op);	  
	    }
	    department.innerHTML=s;
	  }
	  
	  function changeDepartment(){
	    var school =document.getElementById("school");
 		var t=school.value;
 		var s ="";
 		var i = 0;
 		switch(t){
	  		case "cs": 
	  		   for(i=0;i<csDep.length;i++){
			     s += "<option>"+csDep[i]+"</option>";
		       }
	  		   break;
	  		case "auto":
	  		   for(i=0;i<autoDep.length;i++){
			     s += "<option>"+autoDep[i]+"</option>";
		       }
	  		   break;
	  		case "mech":
	  		   for(i=0;i<mechDep.length;i++){
			     s += "<option>"+mechDep[i]+"</option>";
		       }
	  		   break;
        }
        
 		var department=document.getElementById("department");
        department.innerHTML=s;
	      
	  }
    
      function reloadCheckImg()
      {
          $("img").attr("src","img.jsp?t="+(new Data().getTime()));
      }
      
      $(document).ready(function()
      {
         $("checkcodeId").blur(function()
         {
            var $checkcode = $("#checkcodeId").val();
            $.post(
            "LoginServlet",
            "checcode="+$checkcode,
            function(result)
            {
                var result = $("<img src = '"+result+"' height='15' width='15px' />");
            });
         });
      });
    </script>
    
  </head>
  
 <body onload="initDep()">
 <%
 	Object login = session.getAttribute("user");
 	if(login!=null){
 		request.getRequestDispatcher("courseManage?operation=query").forward(request, response);
 	}
  %>
  <br>
  <br>
  <center>
  <form name="login"  action="LoginServlet" onsubmit="return validateForm()" method = "get">
    <table>
      <tr>  <td> 用户名：</td><td><input  type = "text" name = "uname"> </td> </tr>
      <tr>  <td> 密码：</td><td><input  type = "password" name = "upwd"></td> </tr>
      <tr> <td> 所在学院：</td> 
           <td>
              <select name = "school" id ="school" onchange = "changeDepartment()"  class ="selectCSS" >
               	 
			  </select>           
           </td>  
      </tr>
      
      <tr> <td> 所在系：</td> 
           <td>
              <select name = "department" id="department" class ="selectCSS">

			  </select>           
           </td>   
      <tr> 
      
      <tr>    
        <td>验证码：</td>
        <td><input type="text" name="checkcode" id= "checkcode" size="4">  </td>
        <td><a href="javascript:reloadCheckImg();"><img src="img.jsp"/></a> </td>
      </tr>  
    </table>
      <input  type = "submit" value = "登录"><br/>
  </form>
  </center>
 </body>
  

</html>
