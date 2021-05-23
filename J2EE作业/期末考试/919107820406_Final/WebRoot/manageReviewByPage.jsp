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
    
    <title>论文评审费管理</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<%
		int curPage;
		if((Integer)request.getAttribute("page") == null){
			response.sendRedirect(path+"/review");
		}
		else{
		   	curPage = (Integer)request.getAttribute("page"); 
	%>
	<script type="text/javascript" charset="utf-8" src="https://s3.pstatp.com/cdn/expire-1-M/jquery/3.3.1/jquery.min.js"></script>
  </head>
  
  <body>
  <center>
  <div id="main">
  	<form action="<%=path %>/pay" method="get">
   <input type="button" onclick="mysubmit()" value="提取费用"/>
   <table border="1" width="600" id = "ReviewT">       
      <tr>
          <td align = "center">是否提取</td>
          <td align = "center">送审机构</td>
          <td align = "center">论文标题</td>
          <td align = "center">费用</td>
          <td align = "center">送审时间</td>
          <td align = "center">是否支付</td>
        </tr>
        <% 
          ReviewPage curVec = (ReviewPage)request.getAttribute("allReview");
          int allPage = 0;
          int reviewNum = 0;
          Review review = null;
          if(curVec!=null){
          	 allPage = curVec.getPages();
          	 reviewNum = curVec.getNum();
             int size = curVec.getcList().size();
             int num = ReviewPage.getNumPage();
             int index =ReviewPage.getBegin(curPage)+1;
	      	 while (size> 0){	      	    
			    review =(Review) curVec.getcList().elementAt(size-1);
		     	if(review != null){
		%>
		     	<tr>
		     	  <td align = "center"><input type="checkbox" name="checkGet" value="<%=review.getReviewId()%>"></td>
		     	  <td align = "center"><%=review.getOrganization() %></td>
		     	  <td align = "center"><%=review.getPaperTitle() %></td>
		     	  <td align = "center"><%=review.getFee() %></td>
		     	  <% Date date = review.getDate();
		     	     if(date != null){
		     	  %>
		     	    <td align = "center"><%=date.toLocaleString() %></td>
		     	  <% }else { %>
		     	     <td align = "center">未填写日期</td>
		     	  <% } %>
		     	  <td align = "center"><%=review.isPayed() %></td>
		     	</tr>
		     	<%
				  }
				    index = index +1;
				    size = size -1;
				    num = num-1;
			}
				    while(num>0){
					   %>
					   	<tr>
				     	  <td align = "center" style="height:24.4px;"></td>
				     	  <td align = "center" style="height:24.4px;"></td>
				     	  <td align = "center" style="height:24.4px;"></td>
				     	  <td align = "center" style="height:24.4px;"></td>
				     	</tr>
					   <%
			   			num = num-1;
			 		 }
		     
          }
        %>
       
      </table>
		</form>	
		    <a href="javascript:void(0)" onclick ="return pre();">上一页</a>
		    <span>当前页面<%=curPage %>/<%=allPage %></span>
		    <span><input type="text" id="topage" class="inp"><a href="javascript:void(0)" onclick="return toPage()">跳转</a></span>
		    <a href="javascript:void(0)" onclick ="return next();" >下一页</a>
		    <span>共有<%=reviewNum%>条记录</span>
		    <div>每页<input type="text" id="numpage" class="inp" style="width:50px;"disabled=true>条</div>
      </div>
      </center>
      	<script type="text/javascript" >
		
	  function inValidateSession(){
	    session.invalidate();
	  }
	  
	   function mysubmit(){
            var checkGet=[];
    		$("input[name='checkGet']").each(function(){
    			if ($(this).prop("checked") == true) {
    					checkGet.push($(this).val());
    			}
    		});
        	$.ajax({
	             type: "get",
	             url: "<%=path%>/pay",
	             data: {
		             "checkGet":checkGet
	             },
	             dataType: "text",
	             success:function(data){
	             	window.location.href=data;
	             }
	         	});
        }
	  
	  function next(){
		  if(<%=curPage%> < <%=allPage%>){
		  		window.location.replace("review?page=<%=curPage+1%>");
			  	return true;
		  	}
		  else{
		  	alert("已是最后一页");
		  	return false;
		  }
		  	
	  }
	  function pre(){
		  if(<%=curPage%> > 1){
		  		window.location.replace("review?page=<%=curPage-1%>");
			  	return true;
		  	}
		  else{
		  	alert("已是第一页");
		  	return false;
		  }	
	  }
	  function toPage(){
	  	var topage = $("#topage").val();
	  	if(topage<1) {
	  		alert("页数不能小于1！");
	  		return false;
	  	}
	  	if(topage > <%=allPage%>){
	  		alert("页数不能大于<%=allPage%>！");
	  		return false;
	  	}
	  	window.location.replace("review?page="+topage);
	  	return true;
	  }
	$(function () {
		$("#numpage").val(<%=ReviewPage.getNumPage()%>);
        $("#topage").bind('input propertychange',function () {
	  	var value = $("#topage").val();
	     $("#topage").val(value.replace(/[^0-9]/g, ''));
        })
        $("#numpage").bind('input propertychange',function () {
	  	var value = $("#numpage").val();
	     $("#numpage").val(value.replace(/[^0-9]/g, ''));
        })
    })
	</script>
	<%} %>
  </body>
</html>
</html>
