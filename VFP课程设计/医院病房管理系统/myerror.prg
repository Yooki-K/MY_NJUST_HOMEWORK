Parameter lnError,lcMessage,lcMessage1,lcProgram,lnLineno,lnLineno1
if lnerror=13&&�Ҳ��������Ĵ������
	bm=subst(allt(lcMessage1),8) 
	if messagebox("�Ҳ�������"+bm+",�Ƿ���������B",4+32+0,"�������")=6
			if !used(bm)
				select 0
				use &bm
			endif
	messagebox("�ɹ��������",64,"������")
	else
		messagebox("��ֹͣʹ��ϵͳ",64,"�ֶ�����")
	endif
else
	Messagebox("������������ϸ��Ϣ���£�"+Chr(10)+Chr(13)+"������ţ�"+ Alltrim(Str(lnError))+ Chr(13)+ "����λ�ã�" + lcProgram + Chr(13) + "�����кţ�" + Alltrim(Str(lnLineno))+ Chr(13) + "������룺" + lcMessage1 + Chr(13)+ "�����壺" + lcMessage,48,"����")
	do while .t.
	wait "         "+"��ֹ �밴1"+"         "+chr(13)+"         "+"���� �밴2"+"         "+chr(13)+"         "+"���� �밴3"+"         "+chr(13)+"         "+"���� �밴4"+"         " to nvalue window at 30,120
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