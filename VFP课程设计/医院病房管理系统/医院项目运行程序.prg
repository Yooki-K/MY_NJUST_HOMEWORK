IF SET("TALK")=="ON"
SET TALK OFF
m.gltalkison=.T.
ELSE
m.gltalkison=.F.
ENDIF
m.gntimebegin=SECO() &&将时间转换为秒

m.gcOldCent=SET("century")
m.gcOLdClas=SET("classlib")
m.gcOldDele=SET("delete")
m.gcOldEsca=SET("escape")
m.gcOldExac=SET("exact")
m.gcOldExcl=SET("exclusive")
m.gcOldMult=SET("multilocks")
m.gcOldProc=SET("procedure")
m.gcOldRepr=SET("reprocess")
m.gcOldSafe=SET("safety")
m.gcOldStat=SET("status bar")
m.gcOldHelp=SET("help",1)
m.gcOldReso=SYS(2005)
m.gcOldOnEr=ON("error")

RELEASE ALL EXCEPT g*
CLOSE ALL
CLEAR MENU
CLEAR POPU
CLEAR WIND
CLEAR

m.gcNameSystem="火神山医院住院部"
m.gcDefDataloc=curdir()

m.gmenu1=.F.
m.gmenu2=.F.
m.gmenu3=.F.

m.gcNameUser="gakki"
m.gcPermLevel="AAAAA"
m.gcExitMethod=""

IF m.gcPermLevel="AAAAA"
On Error Do myError.prg With Error(),Message(),Message(1),Program(),Lineno(),Lineno(1)
*\\\on error
ELSE
on error *
*\\\on error
ENDIF
IF m.gcPermLevel="AAAAA"
SET ESCAPE ON
ELSE
SET ESCAPE OFF
ON ESCAPE *
ENDIF

ON KEY LABEL F2 keyb "919107820406"
ON KEY LABEL F9 keyb "李玟"
ON KEY LABEL F6 keyb "919107820407"
ON KEY LABEL F4 keyb "919107820408"
ON KEY LABEL F1 keyb "况宇"
ON KEY LABEL F3 keyb "刘欢"
ON KEY LABEL F5 keyb "李游"
ON KEY LABEL F7 keyb "管理员"
ON KEY LABEL F8 keyb "123456"
ON KEY LABEL F10 keyb "荨麻疹"
ON KEY LABEL F11 keyb "123456789"

SET CENTURY ON
SET CLOCK STATUS
SET DELETED ON
SET EXACT OFF
SET CONSOLE ON
SET STATUS BAR ON
SET SYSMENU OFF
SET MESSAGE TO ""
SET EXCLUSIVE on
SET MULTILOCKS ON
SET REPROCESS TO 5
SET SAFETY OFF
SET DATE ANSI
SET RESOURCE ON
publi jd
*****************************************************************
*****************************************************************

*****************************************************************
set default to D:\game
set path to D:\game
DO Form 登录表单.scx
WITH _Screen
.Visible=.f.
.Closable=.T.
.ControlBox=.T.
.MaxButton=.T.
.Movable=.T.
.ScrollBars=3
.AlwaysonTop=.F.
.Top=0
.Left=0
.WindowState=2
.Caption="医院住院管理系统"
.Icon='Icon.ico'
ENDWITH
public cmenuname,padname
padname="_5qg0lmn4y"
do 主菜单.prg with 登录表单 
set skip of pad padname of (cmenuname) .t. 
*******************************************************************************
MODIFY WINDOWS SCREEN FONT "楷体",15 CLOSE TITLE m.gcNameSystem &&改变字体和大小
PUSH MENU _MSYSMENU
*****************************************************
clear
*****************************************************************
read events


SET SYSMENU TO DEFAULT 
MODIFY WINDOWS SCREEN FONT "Foxfont",9 CLOSE TITLE "Microsoft Visual Foxpro"

SET CENTURY &gcOldCent
SET CLASSLIB TO &gcOldClas
SET DELETED &gcOldDele
SET ESCAPE &gcOldEsca
SET EXACT &gcOldExac
SET EXCLUSIVE &gcOldExcl
SET MULTILOCKS &gcOldMult
SET PROCEDURE TO &gcOldProc
IF m.gcOldRepr <> 0
SET REPROCESS TO (gcOldRepr)
ENDIF
SET SAFETY &gcOldSafe
SET STATUS BAR &gcOldStat
IF ! EMPTY(m.gcOldHelp)
SET help to &gcOldHelp
ENDIF
IF ! EMPTY(m.gcOldReso)
SET RESOURCE TO &gcOldReso
ENDIF
ON error 

CLOSE ALL
CLEAR MENU
CLEAR POPU
CLEAR PROG
CLEAR WIND
CLEAR
clear memory

