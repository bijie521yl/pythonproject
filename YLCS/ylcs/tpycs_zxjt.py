# coding=GBK
from time import sleep
__author__ = 'bj'
# import httplib
# import urllib

import urllib2
import json
import datetime

import ConfigParser
import threading

#test big data for China Securities Co., Ltd.
import csv


cf = ConfigParser.ConfigParser() 
cf.read("ylcs.ini")
# opts = cf.options("thread")
# db_port = cf.getint("db", "db_port")

g_thread_count=cf.getint("thread", "thread_count");
g_requrl=cf.get("http", "url");
g_totlenum=cf.getint("thread", "totlenum");
g_useid=cf.get("use", "useid").strip(',').split(',');
g_usetpye=cf.get("use", "usetype");
g_column=cf.get("msg", "column");
g_devices=cf.get("msg", "devices").strip(',').split(',');

csv_file=cf.get("csv","filepath");
cvsobj=csv.reader(open(csv_file,"r"));#创建CSV对象

mu = threading.Lock()   ###通过工厂方法获取一个新的锁对象


 
class MyThread(threading.Thread):   ###类MyThread继承基类threading.Thread
    
    def __init__(self,func,args,name=''):
        threading.Thread.__init__(self)
        self.name=name
        self.func=func
        self.args=args
    
    def run(self):
        global mu
        apply(self.func,self.args)
        
def test(funcname):
     thread_all = []
     global g_thread_count,g_totlenum
     
     print datetime.datetime.now();
     for i in range(g_thread_count):  ##配置文件获取
         t = MyThread(funcname,[i,g_totlenum])  ##创建线程
         thread_all.append(t)
         t.start()   ###启动线程
 
     for i in range(g_thread_count):
         thread_all[i].join()    ##等待线程结束
     print datetime.datetime.now();
     print "send totle number",g_totlenum*g_thread_count
#      sleep(5000);
 
 
def MsgOnetoALL(i,endnum):
    start_index=1
    end_index=endnum+start_index
    global g_requrl,g_useid,g_usetpye,g_column,g_devices
    global cvsobj
    content=str(datetime.datetime.now())
    
    #HTTPConnection(host[, port[, strict[, timeout]]])
    test_data = [{"task_info":{"message_info":
                               {"column":g_column,
                                "title":content,
                                "abstract":content,
                                "source":"zxjt",
                                "content":content,
                                "keyboarder":0,
                                "other":{}
                                },
                                "sender":{"system":"CMS","account":"SYSTEM"},
                                "receiver":{"pul":{"ATYPE":g_usetpye,"list":g_useid}},
                                "devices":g_devices,
                                "push_by_task_queue":True,
                                "user_feedback_required":True,
                                "save_message_required":1,
                                "task_review_required": False
                                },
                  "msg_id": "2018013113584396000"
                  }];
    row=0
    for khhlist in cvsobj:
        test_data[0]["task_info"]["receiver"]["pul"]["list"]=[khhlist[0]]
        test_data_urlencode=json.dumps(test_data)
        req = urllib2.Request(url = g_requrl,data =test_data_urlencode)
        res_data = urllib2.urlopen(req)
#         res = res_data.read()
#         print res                          

def MsgtoOne(i,endnum):
    start_index=1
    end_index=endnum+start_index
    global g_requrl,g_useid,g_usetpye,g_column,g_devices
    #HTTPConnection(host[, port[, strict[, timeout]]])
    test_data = [{"task_info":{"message_info":
                               {"column":g_column,
                                "title":"",
                                "abstract":"",
                                "source":"",
                                "template":"",
                                "content":"",
                                "other":{"OPEN":""},
                                "img_list":[],"attach_list":"","keyboarder":None
                                },
                                "sender":{"system":"CMS","account":"TDX10275"},
                                "receiver":{"pul":{"ATYPE":g_usetpye,"name":"","list":g_useid}},
                                "devices":g_devices,
                                "push_by_task_queue":True,
                                "user_feedback_required":True,
                                "save_message_required":True,
                                "push_timer":{"type":"0","time":""}
                                }
                  }];
    for index in range(start_index,end_index):
        test_data[0]["task_info"]["message_info"]["title"]=str(i)+str(index)+str(datetime.datetime.now());
        test_data[0]["task_info"]["message_info"]["abstract"]=str(i)+str(index)+str(datetime.datetime.now());
        test_data[0]["task_info"]["message_info"]["content"]=str(i)+str(index)+str(datetime.datetime.now());
        
        
        
        test_data_urlencode=json.dumps(test_data)
        req = urllib2.Request(url = g_requrl,data =test_data_urlencode)
        res_data = urllib2.urlopen(req)
#         res = res_data.read()
#         print res
                                
                                
def Msg_toall(i,endnum):
    start_index=1
    end_index=endnum+start_index
    global g_requrl,g_useid,g_usetpye,g_column,g_devices
    #HTTPConnection(host[, port[, strict[, timeout]]])
    test_data = [{"task_info":{"message_info":
                               {"column":g_column,
                                "title":"",
                                "abstract":"",
                                "source":"",
                                "template":"",
                                "content":"",
                                "other":{"OPEN":""},
                                "img_list":[],"attach_list":"","keyboarder":None
                                },
                                "sender":{"system":"CMS","account":"TDX10275"},
                                "receiver":{"group":"@all"},
                                "devices":g_devices,
                                "push_by_task_queue":True,
                                "user_feedback_required":True,
                                "save_message_required":True,
                                "push_timer":{"type":"0","time":""}
                                }
                  }];
    for index in range(start_index,end_index):
        test_data[0]["task_info"]["message_info"]["title"]=str(i)+str(index)+str(datetime.datetime.now());
        test_data[0]["task_info"]["message_info"]["abstract"]=str(i)+str(index)+str(datetime.datetime.now());
        test_data[0]["task_info"]["message_info"]["content"]=str(i)+str(index)+str(datetime.datetime.now());
        
        test_data_urlencode=json.dumps(test_data)
        req = urllib2.Request(url = g_requrl,data =test_data_urlencode)
        res_data = urllib2.urlopen(req)
#         res = res_data.read()
#         print res

    
def IM_jb():
    for y in range(0,1000):
        test_data={"khh":250006629+y}
        test_data_urlencode=json.dumps(test_data)
        requrl = "http://111.203.51.73:7610/TQLEx?Entry=XSD_IMSMM:GetKHInfo"
        req = urllib2.Request(url = requrl,data =test_data_urlencode)
        res_data = urllib2.urlopen(req)
        res = res_data.read()
        print y
        print res

if __name__=="__main__":   
    flag=1
    MsgOnetoALL(0,0);

#     while flag:
#         print "============请输入你的操作=============="
#         print "============1 针对单个用户推送=================="
#         print "============2 针对所有用户推送=================="
#         print "============3 退出=================="
#         operate=raw_input("Enter your input: ");  
#         if operate=="1":
#             test(MsgtoOne)
#         elif operate=="2":
#             test(Msg_toall)
#         else:
#             flag=0
#             print  "退出"