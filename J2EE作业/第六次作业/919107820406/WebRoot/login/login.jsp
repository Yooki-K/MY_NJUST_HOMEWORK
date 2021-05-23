<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <meta charset="UTF-8">
    <title>login</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0"/>
    <link rel="stylesheet" href="./css/jquery.bxslider.css"/>
    <link rel="stylesheet" href="./css/web-index.css?v=10"/>
    <link rel="stylesheet" href="./css/lx-index.css?v=10"/>
    <script type="text/javascript" charset="utf-8" src="https://s3.pstatp.com/cdn/expire-1-M/jquery/3.3.1/jquery.min.js"></script>
</head>
<body class="lx_bgColor">
<div class="lx_login">
    <div class="lx_absolute">
        <div class="lx_mainWidth lx_flex lx_rowBetween">
            <div class="lx_loginBox">
                <div class="lx_tabs lx_pFlex lx_pTabs">
                    <a class="active" id="l-account-target" card="l-account">账户登录</a>
                </div>

                <div class="lx_tabContent lx_content l-account" style="display: block;">
                    <!--pc账号登录begin--->
                    <form id="form-account" action="login" method="post">
                        <div class="lx_relative">
                            <img src="Img/phone.png" class="l-inputbg">
                            <input class="lx_input lx_bindInput lx_pInput lx_pBottom40 lx_pAccount lx_pPhone" type="text" id="user-name"
                                   size=20 onkeydown="if(event.keyCode==32) return false"
                                   value="" placeholder="学号" name="user"/>
                        </div>
                        <div class="lx_relative">
                            <img src="Img/password.png" class="l-inputbg ">
                            <input class="lx_input lx_bindInput lx_passwordInput lx_pInput lx_pBottom40 lx_pAccount lx_pPassword"
                                   type="password" id="pass-word" onkeydown="if(event.keyCode==32) return false"
                                   placeholder="请输入密码" name="pwd"/>
                        </div>

                        <div class="lx_relative">验证码：<input class="lx_capcha" type="text" name="capcha" id="capcha" placeholder="验证码"/><p id="setCapcha" class="l_getcapcha"></p></div>
			    		<!-- college  system -->
			    		<div><br></div>
			    		<div class="lx_relative">
			    		所在学院：<select id="college" onchange="setSys()" name="college"></select><br>
			    		所 在 系：<select id="system" name="system"></select><br>
			    		</div>

                        <p class="l_errtip" id="error-account"></p>
                    </form>
                    <div class="lx_submit lx_toLogin">
                        <a href="javascript:void(0)" id="login-account" class="lx_pSubmit lx_pAccount_btn" onclick="mysubmit()">登&nbsp;录</a>
                    </div>
                </div>
                <!--pc账号登录end--->

                <div class="lx_flex lx_rowBetween lx_loginRow">
                    <a class="lx_flex" href="#">
                        	帮助
                    </a>
                    <a class="lx_flex" href="#">
                        	忘密
                    </a>
                </div>

            </div>
        </div>
    </div>
    <div class="lx_footer lx_flex">
        <div class="lx_mainWidth">
        </div>
    </div>
</div>
<script>
    var code;
	function setCapcha(){
            var newCode = '';
            //设置随机字符
            var random = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, '9');
            for (var i = 0; i < 4; i++) {
                var index = Math.floor(Math.random() * 10);
                newCode += random[index];
            }
            document.getElementById("setCapcha").innerHTML=newCode;
            code=newCode;
	}
	//验证验证码
	 function mysubmit() {
            var oValue = $("#capcha").val();
            if (oValue != code) {
                alert('验证码不正确');
                setCapcha();
            } else {
                $("#form-account").submit();
            }
        }
    window.onload=function()//用window的onload事件，窗体加载完毕的时候
	{

		// 账户登录输入内容按钮改变颜色
        $('.lx_pAccount').on('input propertychange', function () {
            if (($.trim($('.lx_pPhone').val()) !== "") && ($.trim($('.lx_pPassword').val()) !== "")) {
                $('.lx_pAccount_btn').css('backgroundColor', '#0047ae')
            }
            else {
                $('.lx_pAccount_btn').css('backgroundColor', '#7fa3d6')
            }
        })
	   var list=new Array("计算机学院","经济管理学院","理学院");
	   var college=document.getElementById("college");
	  for (var i = 0; i < list.length; i++) {
	  	console.log(list[i]);
		college.options.add(new Option(list[i],list[i]));
	 }
	 setSys();
	setCapcha();
	   
	}

	function setSys(){
		var index=document.getElementById("college").selectedIndex;
		var sys=document.getElementById("system");
		var major=new Array(new Array("计算机","软件工程","人工智能","网络安全"),new Array("信息管理","会计","金融","人力资源","工商管理"),new Array("应用物理","应用数学","土木工程"))
		if(index!=-1){
			$("#system").empty();//清空
			for (var i = 0; i < major[index].length; i++) {
				sys.options.add(new Option(major[index][i],major[index][i]));
	  		}
		}else{
			alert("ERROR:不存在此系！！！");
		}
	}


</script>
</body>

</html>
