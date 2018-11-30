# coding=GBK
from time import sleep
__author__ = 'bj'
# import httplib
# import urllib

import urllib2
import json
import datetime
import time

import ConfigParser
import threading

#test big data for China Securities Co., Ltd.


cf = ConfigParser.ConfigParser() 
cf.read("ylcs.ini")
# opts = cf.options("thread")
# db_port = cf.getint("db", "db_port")

g_thread_count=cf.getint("thread", "thread_count");
g_requrl=cf.get("http", "url");
g_totlenum=cf.getint("thread", "totlenum");
g_totlenum_1=cf.getint("use", "totlenum")
g_useid=cf.get("use", "useid").strip(',').split(',');
g_usetpye=cf.get("use", "usetype");
g_column=cf.get("msg", "column");
g_devices=cf.get("msg", "devices").strip(',').split(',');



mu = threading.Lock()   ###通过工厂方法获取一个新的锁对象
totlnum=0


 
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

def MsgtoWhile():

    global g_requrl,g_useid,g_usetpye,g_column,g_devices,totlnum
    print g_useid
    for i in range(len(g_useid)):
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
        test_data[0]["task_info"]["message_info"]["title"]=str(g_useid[i])+"-"+str(datetime.datetime.now());
        test_data[0]["task_info"]["message_info"]["abstract"]=str(g_useid[i])+"-"+str(datetime.datetime.now());
        test_data[0]["task_info"]["message_info"]["content"]=str(g_useid[i])+"-"+str(datetime.datetime.now());
        test_data_urlencode=json.dumps(test_data)
        req = urllib2.Request(url = g_requrl,data =test_data_urlencode)
        res_data = urllib2.urlopen(req)
        totlnum=totlnum+1
                                
                                
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


if __name__=="__main__":   
    global totlnum,g_totlenum_1
    flag=True;
#     print "起始时间:"+datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S") 
#     print totlnum
#     for j in range(g_totlenum_1):
#         MsgtoWhile()
#         time.sleep(1)
#     print totlnum
#     print "结束时间:"+datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S") 
#     time.sleep(100)
#     return False;
    while flag:
        print "============请输入你的操作=============="
        print "============1 针对单个用户推送=================="
        print "============2 针对所有用户推送=================="
        print "============3 退出=================="
        operate=raw_input("Enter your input: ");
         
        if operate=="1":
            test(MsgtoOne)
        elif operate=="2":
            test(Msg_toall)
        else:
            flag=0
            print  "退出"