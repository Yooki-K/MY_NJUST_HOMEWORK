package edu.njust.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class CalendarUtil {

	/**
	* ���ڸ�ʽ��
	* @param date
	* @return
	*/
	public static String dateFormat(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:ss:mm");
		return sdf.format(date);
	}
	
	/****
	* ����������� ���ʹ�����޸�ʱ�䣬���ؾ������ڼӼ���
	*
	*/
	public static String subMonth(String date,int monthCount) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date dt = sdf.parse(date);
		Calendar rightNow = Calendar.getInstance();
		rightNow.setTime(dt);
	
		rightNow.add(Calendar.MONTH, monthCount);
		Date dt1 = rightNow.getTime();
		String reStr = sdf.format(dt1);
	
		return reStr;
	}
	
	/***
	* ���ڼ�һ�졢��һ��
	*/
	public static String checkOption(String option, String _date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cl = Calendar.getInstance();
		Date date = null;
	
		try {
			date = (Date) sdf.parse(_date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		cl.setTime(date);
		if ("pre".equals(option)) {
		// ʱ���һ��
			cl.add(Calendar.DAY_OF_MONTH, -1);
		
		} else if ("next".equals(option)) {
		// ʱ���һ��
			cl.add(Calendar.DAY_OF_YEAR, 1);
		} else {
		// do nothing
		}
		date = cl.getTime();
		return sdf.format(date);
	}


/**����
* @param args
* @throws Exception
*/
}
