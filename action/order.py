# python
# -*- coding: utf-8 -*-
# @Date	: 2022-11-13 08:38:07
# @Author  : Yooki (1486147017@qq.com or yooki.k613@gmail.com)
# @Link	: https://github.com/Yooki-K
# @Version : 2.2

import os, time
import requests
from datetime import datetime, timedelta
import json,base64
from smtplib import SMTP_SSL
from email.mime.text import MIMEText


result = []
log = []

cookie = os.environ["COOKIE"]


inc = 1
dtime = (datetime.now() + timedelta(days=inc)).strftime("%Y-%m-%d")
query_url = "http://wechat.njust.edu.cn/api/v2/appGym/listAreaPriceBySiteIdAndTime"
submit_url = 'http://wechat.njust.edu.cn/api/v2/appGym/submitAreaOrder'	
hh = {
	"Host": "wechat.njust.edu.cn",
	"Accept": "application/json, text/plain, */*",
	"Connection": "keep-alive",
	"Accept-Encoding": "gzip, deflate",
	"Accept-Language": "zh-CN,zh-Hans;q=0.9",
	"Content-Type": "application/json",
	"Origin": "http://wechat.njust.edu.cn",
	"User-Agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 15_7_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.29(0x18001d36) NetType/WIFI Language/zh_CN",
	"Referer": "http://wechat.njust.edu.cn/gymBooking/venueBooking.html",
	"Connection": "keep-alive",
	"Cookie": cookie
}

query_data = {
	"siteId": "e1f5c85e86c34c46a2d0935452094b77",
	"bookDate": dtime
}

def sendMail(message,Subject,to_addrs,recipient_show='',sender_show='yooki-github-actions',cc_show=''):
    '''
    :param message: str 邮件内容
    :param Subject: str 邮件主题描述
    :param to_addrs: str 实际收件人
    :param sender_show: str 发件人显示，不起实际作用如："xxx"
    :param recipient_show: str 收件人显示，不起实际作用 多个收件人用','隔开如："xxx,xxxx"
    :param cc_show: str 抄送人显示，不起实际作用，多个抄送人用','隔开如："xxx,xxxx"
    '''
    user = os.environ["EMAIL"]
    password = os.environ["MM"]
    # 邮件内容
    msg = MIMEText(message, 'plain', _charset="utf-8")
    # 邮件主题描述
    msg["Subject"] = Subject
    # 发件人显示，不起实际作用
    msg["from"] = sender_show
    # 收件人显示，不起实际作用
    msg["to"] = recipient_show
    # 抄送人显示，不起实际作用
    msg["Cc"] = cc_show
    with SMTP_SSL(host="smtp.qq.com",port=465) as smtp:
        # 登录发邮件服务器
        smtp.login(user = user, password = password)
        # 实际发送、接收邮件配置
        smtp.sendmail(from_addr = user, to_addrs=to_addrs.split(','), msg=msg.as_string())


def run_all(needList) -> [True, False]:
	r = requests.post(query_url, headers=hh, data=json.dumps(query_data))
	r = r.json()
	arr = []
	if 'success' in r['message']:
		for i in needList:
			x = r['data'][i]
			y = x['listAreaPrice']
			for j in range(1, len(y)):
				z = y[j]
				if z['use'] == None:
					d = {
						"areaId": z['areaId'],  #
						"areaName": z['areaName'],  #
						"bookingType": None,
						"bookingDate": dtime,
						"timeId": z['timeId'],  #
						"time": x['startTime'] + '~' + x['endTime'],  #
						"userType": 1,
						"price": int(z['price']),  #
						"areaPriceId": z['areaPriceId']  #
					}
					arr.append(d)
					break
		if len(arr) == 0:
			log.append('场地已被别人预定完！')
			return True
		submit_data = {
			"siteId": "e1f5c85e86c34c46a2d0935452094b77",  # fixed
			"gymId": "790c8055a06311e8a69022faa7560813",  # fixed
			"payAmount": 15 * len(arr),
			"payDuration": 60 * len(arr),
			"areaRecordList": arr,
			"bookTimes": 1
		}
		rr = requests.post(submit_url, headers=hh, data=json.dumps(submit_data))
		rr = rr.json()
		if 'success' in rr['message']:
			log.append(','.join(arr)+'场地预定成功！')
			return True
		else:
			print(r['message'])
			log.append(rr['message'])
			return False
	else:
		print(r['message'])
		log.append(r['message'])
		return False


def run(needList) -> [list, None]:
	r = requests.post(query_url, headers=hh, data=json.dumps(query_data))
	r = r.json()
	needList_copy = needList.copy()
	if r['status'] == 0:
		for i in needList:
			arr = []
			x = r['data'][i]
			y = x['listAreaPrice']
			for j in range(1, len(y)):
				z = y[j]
				if z['use'] == None:
					d = {
						"areaId": z['areaId'],  #
						"areaName": z['areaName'],  #
						"bookingType": None,
						"bookingDate": dtime,
						"timeId": z['timeId'],  #
						"time": x['startTime'] + '~' + x['endTime'],  #
						"userType": 1,
						"price": int(z['price']),  #
						"areaPriceId": z['areaPriceId']  #
					}
					arr.append(d)
					break
			if len(arr) == 0:
				log.append(x['startTime'] + '~' + x['endTime'] + '的场次已经订完了!')
				needList_copy.remove(i)
				continue
			submit_data = {
				"siteId": "e1f5c85e86c34c46a2d0935452094b77",  # fixed
				"gymId": "790c8055a06311e8a69022faa7560813",  # fixed
				"payAmount": 15 * len(arr),
				"payDuration": 60 * len(arr),
				"areaRecordList": arr,
				"bookTimes": 1
			}
			rr = requests.post(submit_url, headers=hh, data=json.dumps(submit_data))
			rr = rr.json()
			if rr['status'] == 0:
				log.append(x['startTime'] + '~' + x['endTime'] + '的场次预定成功!')
				needList_copy.remove(i)
			else:
				print(rr)
				log.append(rr['message'])
			if len(needList_copy) == 0:
				return None
			else:
				return needList_copy
	else:
		print(r['message'])
		log.append(r['message'])
		return needList_copy


if __name__ == '__main__':
	# 0 8-9 6 14-15  11 19-20   每人每天只能订两片场地
	log.append('\n' + datetime.now().strftime("%Y-%m-%d"))
	if datetime.now().weekday() in [4,5]:
		result = [1, 2]
	else:
		result = [11, 12]
	while True:
		# print(datetime.now().strftime("%H:%M:%S"))
		log.append(datetime.now().strftime("%H:%M:%S"))
		# 美国时间慢了我们8小时
		if ((datetime.now()).strftime("%H:%M")) >= '14:00' and ((datetime.now()).strftime("%H:%M"))<"16:00":
			log.append('场地预定已结束')
			break
		# if ((datetime.now()).strftime("%H:%M")) >= '00:00':
        #   run() demo
        #   result = run(result)
		#	if result is None:
		#		break
			# run_all() demo
		if run_all(result):
			break		
		time.sleep(0.5)
	sendMail('\n'.join(log),'NJUST羽毛球订场脚本运行情况','1486147017@qq.com','ky')

