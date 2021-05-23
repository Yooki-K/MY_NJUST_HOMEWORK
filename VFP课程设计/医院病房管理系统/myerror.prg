Parameter lnError,lcMessage,lcMessage1,lcProgram,lnLineno,lnLineno1
if lnerror=13&&找不到别名的错误代码
	bm=subst(allt(lcMessage1),8) 
	if messagebox("找不到别名"+bm+",是否启动方案B",4+32+0,"紧急情况")=6
			if !used(bm)
				select 0
				use &bm
			endif
	messagebox("成功处理错误",64,"错误解决")
	else
		messagebox("请停止使用系统",64,"手动处理")
	endif
else
	Messagebox("程序发生错误！详细信息如下："+Chr(10)+Chr(13)+"错误代号："+ Alltrim(Str(lnError))+ Chr(13)+ "出错位置：" + lcProgram + Chr(13) + "错误行号：" + Alltrim(Str(lnLineno))+ Chr(13) + "错误代码：" + lcMessage1 + Chr(13)+ "错误含义：" + lcMessage,48,"错误")
	do while .t.
	wait "         "+"中止 请按1"+"         "+chr(13)+"         "+"挂起 请按2"+"         "+chr(13)+"         "+"忽略 请按3"+"         "+chr(13)+"         "+"重试 请按4"+"         " to nvalue window at 30,120
	do case 
		case nvalue="1" 
			clear events

			exit
		case nvalue="2"
			debug
			suspend
			exit
		case nvalue="3"
			return
			exit
		case nvalue="4"
			retry
			exit
	endcase	
	if type("nvalue")='C'
	loop
	endif
	enddo
endif