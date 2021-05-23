*       *********************************************************
*       *                                                         
*       * 2020.04.01             ���˵�.MPR              11:34:29  
*       *                                                         
*       *********************************************************
*       *                                                         
*       * ��������                                                
*       *                                                         
*       * ��Ȩ���� (C) 2020 ��˾����                             
*       * ��ַ                                                    
*       * ����,     �ʱ�                                          
*       * ����                                              
*       *                                                         
*       * ˵��:                                            
*       * �˳����� GENMENU �Զ����ɡ�    
*       *                                                         
*       *********************************************************

* To attach this menu to your Top-Level form, 
* call it from the Init event of the form:

* Syntax: DO <mprname> WITH <oFormRef> [,<cMenuname>|<lRename>][<lUniquePopups>]

*	oFormRef - form object reference (THIS)
*	cMenuname - name for menu (this is required for Append menus - see below)
*	lRename - renames Name property of your form
*	lUniquePopups - determines whether to generate unique ids for popup names
			
* 	example:

*	PROCEDURE Init
*		DO mymenu.mpr WITH THIS,.T.
*	ENDPROC

* Use the optional 2nd parameter if you plan on running multiple instances
* of your Top-Level form. The preferred method is to create an empty string
* variable and pass it by reference so you can receive the form name after
* the MPR file is run. You can later use this reference to destroy the menu.

*	PROCEDURE Init
*		LOCAL cGetMenuName
*		cGetMenuName = ""
*		DO mymenu.mpr WITH THIS, m.cGetMenuName
*	ENDPROC

* The logical lRename parameter will change the name property of your 
* form to the same name given the menu and may cause conflicts in your 
* code if you directly reference the form by name.

* You will also need to remove the menu when the form is destroyed so that it does 
* not remain in memory unless you wish to reactivate it later in a new form.

* If you passed the optional lRename parameter as .T. as in the above example, 
* you can easily remove the menu in the form's Destroy event as shown below.
* This strategy is ideal when using multiple instances of Top-Level forms.

*	example:

*	PROCEDURE Destroy
*		RELEASE MENU (THIS.Name) EXTENDED
*	ENDPROC

* Using Append/Before/After location options:

*   You might want to append a menu to an existing Top-Level form by setting 
*   the Location option in the General Options dialog. In order to do this, you 
*   must pass the name of the menu in which to attach the new one. The second
*   parameter is required here. If you originally created the menu with the lRename 
*   parameter = .T., then you can update the menu with code similar to the following:

*	example:

*	DO mymenu2.mpr WITH THISFORM,THISFORM.name
*
* Using lUniquePopups:

*   If you are running this menu multiple times in your application, such as in multiple 
*   instances of the same top-level form, you should pass .T. to the lUniquePopups 
*   parameter so that unique popup names are generated to avoid possible conflicts.

*	example:

*	PROCEDURE Init
*		DO mymenu.mpr WITH THIS,.T.,.T.
*	ENDPROC
*
* Note: Parm4-Parm9 are not reserved and freely available for use with your menu code.
*

LPARAMETERS oFormRef, getMenuName, lUniquePopups, parm4, parm5, parm6, parm7, parm8, parm9
LOCAL  nTotPops, a_menupops, cTypeParm2, cSaveFormName
IF TYPE("m.oFormRef") # "O" OR ;
  LOWER(m.oFormRef.BaseClass) # 'form' OR ;
  m.oFormRef.ShowWindow # 2
	MESSAGEBOX([ֻ�ܴӶ�������øò˵�����ȷ�������� ShowWindow ��������Ϊ 2���Ķ��˲˵� MPR �ļ���ͷ���֣����Ի����ϸ��Ϣ��])
	RETURN
ENDIF
m.cTypeParm2 = TYPE("m.getMenuName")
m.cMenuName = SYS(2015)
m.cSaveFormName = m.oFormRef.Name
IF m.cTypeParm2 = "C" OR (m.cTypeParm2 = "L" AND m.getMenuName)
	m.oFormRef.Name = m.cMenuName
ENDIF
IF m.cTypeParm2 = "C" AND !EMPTY(m.getMenuName)
	m.cMenuName = m.getMenuName
ENDIF
DIMENSION a_menupops[1]
IF TYPE("m.lUniquePopups")="L" AND m.lUniquePopups
	FOR nTotPops = 1 TO ALEN(a_menupops)
		a_menupops[m.nTotPops]= SYS(2015)
	ENDFOR
ELSE
	a_menupops[1]="�ǲ�ס����"
ENDIF


*       *********************************************************
*       *                                                         
*       *                         �˵�����                        
*       *                                                         
*       *********************************************************
*

DEFINE MENU (m.cMenuName) IN (m.oFormRef.Name) BAR

DEFINE PAD padname OF (m.cMenuName) PROMPT "�ǲ�ס���룿" COLOR SCHEME 3
DEFINE PAD _5qg0ot499 OF (m.cMenuName) PROMPT "����" COLOR SCHEME 3 ;
	KEY ALT+H, "ALT+H"
DEFINE PAD _5qg0ot49a OF (m.cMenuName) PROMPT "����" COLOR SCHEME 3 ;
	KEY ALT+N, "ALT+N"
DEFINE PAD _5qg0ot49b OF (m.cMenuName) PROMPT "�˳�ϵͳ" COLOR SCHEME 3 ;
	KEY ALT+E, "ALT+E"
ON PAD padname OF (m.cMenuName) ACTIVATE POPUP (a_menupops[1])
ON SELECTION PAD _5qg0ot499 OF (m.cMenuName) ;
	DO _5qg0ot49c ;
	IN LOCFILE("\GAME\���˵�" ,"MPX;MPR|FXP;PRG" ,"WHERE is ���˵�?")
ON SELECTION PAD _5qg0ot49a OF (m.cMenuName) ;
	DO _5qg0ot49n ;
	IN LOCFILE("\GAME\���˵�" ,"MPX;MPR|FXP;PRG" ,"WHERE is ���˵�?")
ON SELECTION PAD _5qg0ot49b OF (m.cMenuName) ;
	DO _5qg0ot49o ;
	IN LOCFILE("\GAME\���˵�" ,"MPX;MPR|FXP;PRG" ,"WHERE is ���˵�?")

DEFINE POPUP (a_menupops[1]) MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF (a_menupops[1]) PROMPT "�����޸�" ;
	KEY ALT+A, "ALT+A"
DEFINE BAR 2 OF (a_menupops[1]) PROMPT "�����һ�" ;
	KEY ALT+B, "ALT+B"
ON SELECTION BAR 1 OF (a_menupops[1]) do form �����޸ı�.scx
ON SELECTION BAR 2 OF (a_menupops[1]) do form �����һر�.scx

ACTIVATE MENU (m.cMenuName) NOWAIT

IF m.cTypeParm2 = "C"
	m.getMenuName = m.cMenuName
	m.oFormRef.Name = m.cSaveFormName 
ENDIF


*       *********************************************************
*       *                                                         
*       * _5QG0OT49C  ON SELECTION PAD                            
*       *                                                         
*       * Procedure Origin:                                       
*       *                                                         
*       * From Menu:  ���˵�.MPR,            Record:    7          
*       * Called By:  ON SELECTION PAD                            
*       * Prompt:     ����                                        
*       * Snippet:    1                                           
*       *                                                         
*       *********************************************************
*
PROCEDURE _5qg0ot49c
??chr(7)
p=messagebox("��������",4+48+0,"����")
if p==7
do form ������.scx
endif


*       *********************************************************
*       *                                                         
*       * _5QG0OT49N  ON SELECTION PAD                            
*       *                                                         
*       * Procedure Origin:                                       
*       *                                                         
*       * From Menu:  ���˵�.MPR,            Record:    8          
*       * Called By:  ON SELECTION PAD                            
*       * Prompt:     ����                                        
*       * Snippet:    2                                           
*       *                                                         
*       *********************************************************
*
PROCEDURE _5qg0ot49n
**��_SCREEN�����һ��HyperLink����
_SCREEN.AddObject('oAppHyperLink','HyperLink')
**���ӵ�http://www.qlsh.net��ַ
_SCREEN.oAppHyperLink.NavigateTo('https://m.look.360.cn/subject/400?sign=360dh')
**��ȥoAppHyperLink����
_SCREEN.RemoveObject('oAppHyperLink')
RETURN


*       *********************************************************
*       *                                                         
*       * _5QG0OT49O  ON SELECTION PAD                            
*       *                                                         
*       * Procedure Origin:                                       
*       *                                                         
*       * From Menu:  ���˵�.MPR,            Record:    9          
*       * Called By:  ON SELECTION PAD                            
*       * Prompt:     �˳�ϵͳ                                    
*       * Snippet:    3                                           
*       *                                                         
*       *********************************************************
*
PROCEDURE _5qg0ot49o
clear events
quit
