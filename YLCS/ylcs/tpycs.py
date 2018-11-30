# coding=GBK
__author__ = 'bj'
# import httplib
# import urllib
import urllib2
import json,time
import datetime

requrl = "http://220.165.246.202:7616/TQLEx?Entry=CMS.1001"


def Msg1(start_index,end_index):
    #single client mul message
    global requrl
    #HTTPConnection(host[, port[, strict[, timeout]]])
    test_data = [{"task_info":{"message_info":
                               {"column":"TDXTDXCOL-SYSID-00000003-000",
                                "title":"129",
                                "abstract":"129",
                                "source":"129",
                                "template":"",
                                "content":"129",
                                "other":{"OPEN":""},
                                "img_list":[],"attach_list":"","keyboarder":None
                                },
                                "sender":{"system":"CMS","account":"TDX10275"},
                                "receiver":{"pul":{"ATYPE":"340","name":"","list":["13131313131"]}},
                                "devices":["iOS","Android","PC"],
                                "push_by_task_queue":True,
                                "user_feedback_required":True,
                                "save_message_required":True,
                                "push_timer":{"type":"0","time":""}
                                }
                  }];
    
#     print time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time()))
    print datetime.datetime.now();
    count=0
    
    for index in range(start_index,end_index):
        test_data[0]["task_info"]["message_info"]["title"]=index;
        test_data[0]["task_info"]["message_info"]["abstract"]=index;
        test_data[0]["task_info"]["message_info"]["content"]=index;
        for y in range(0,50):
            print test_data[0]["task_info"]["message_info"]
            test_data[0]["task_info"]["receiver"]["pul"]["list"]=[];
            for k in range(0,200):
                khh=15801457006+y*200+k
                test_data[0]["task_info"]["receiver"]["pul"]["list"].append(khh)
            print y
            test_data_urlencode=json.dumps(test_data)
#             requrl = "http://111.203.51.73:7610/TQLEx?Entry=CMS.1001"
            req = urllib2.Request(url = requrl,data =test_data_urlencode)
            res_data = urllib2.urlopen(req)
            res = res_data.read()
            count=count+1
            print "当前条数:" ,count
        
#     print time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time()))
    print datetime.datetime.now();
                                

def MsgtoOne(start_index,end_index):
    global requrl
    #HTTPConnection(host[, port[, strict[, timeout]]])
    test_data = [{"task_info":{"message_info":
                               {"column":"TDXTDXCOL-6102-59b661a2-000",
                                "title":"129",
                                "abstract":"129",
                                "source":"129",
                                "template":"",
                                "content":"129",
                                "other":{"OPEN":""},
                                "img_list":[],"attach_list":"","keyboarder":None
                                },
                                "sender":{"system":"CMS","account":"TDX10275"},
                                "receiver":{"pul":{"ATYPE":"340","name":"","list":["13131313131"]}},
                                "devices":["iOS","Android","PC"],
                                "push_by_task_queue":True,
                                "user_feedback_required":True,
                                "save_message_required":True,
                                "push_timer":{"type":"0","time":""}
                                }
                  }];
#     print time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time()))
    print datetime.datetime.now();
    count=0
    for index in range(start_index,end_index):
        test_data[0]["task_info"]["message_info"]["title"]=index;
        test_data[0]["task_info"]["message_info"]["abstract"]=index;
        test_data[0]["task_info"]["message_info"]["content"]=index;
        test_data[0]["task_info"]["receiver"]["pul"]["list"]=[13131313131]
        test_data_urlencode=json.dumps(test_data)
#         requrl = "http://111.203.51.73:7610/TQLEx?Entry=CMS.1001"
        req = urllib2.Request(url = requrl,data =test_data_urlencode)
        res_data = urllib2.urlopen(req)
        res = res_data.read()
#         print res
        count=count+1
        print "当前条数:" ,count
        
#     print time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time()))
    print datetime.datetime.now();
                                
                                
def Msg_toall(start_index,end_index):
    #HTTPConnection(host[, port[, strict[, timeout]]])
    # to all
#     return
    global requrl
    test_data =[{"task_info":{"message_info":
                               {"column":"TDXTDXCOL-6102-59b661a2-000",
                                "title":"0001","abstract":"0001","source":"0001",
                                "template":"","content":"00001","other":{"OPEN":""},
                                "sign":"","img_list":[],"attach_list":"","keyboarder":None},
                               "sender":{"system":"CMS","account":"TDX10275"},
                               "receiver":{"group":"@all"},
                               "devices":["iOS","Android","PC"],"apps":[],
                               "push_by_task_queue":True,"user_feedback_required":True,
                               "save_message_required":True,"push_timer":{"type":"0","time":""}}}]
    
#     print time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time()))
    print datetime.datetime.now();
    count=0
    for index in range(start_index,end_index):
        test_data[0]["task_info"]["message_info"]["title"]=index;
        test_data[0]["task_info"]["message_info"]["abstract"]=index;
        test_data[0]["task_info"]["message_info"]["content"]=index;
        test_data_urlencode=json.dumps(test_data)
        req = urllib2.Request(url = requrl,data =test_data_urlencode)
        res_data = urllib2.urlopen(req)
        res = res_data.read()
#         print res
        count=count+1
        print "当前条数:" ,count
#     print time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time()))
    print datetime.datetime.now();
    
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
    global requrl 
    
    print "当前压力测试环境的IP为220.165.246.202:7616N"
    IPFlag=raw_input("是否需要更改当前地址Y\N:");
    if IPFlag=="Y":
        IP=raw_input("请输入当前IP:PORT:\r\n ");
        requrl="http://"+IP+"/TQLEx?Entry=CMS.1001"
    flag=1
    while flag:
        print "============请输入你的操作=============="
        print "============1 针对单个用户推送=================="
        print "============2 针对所有用户推送=================="
        print "============3 退出=================="
        operate=raw_input("Enter your input: ");  
        if operate=="1":
            linenum=raw_input("请输入起始行与结束行，以逗号分隔:\r\n ");  
            linenum=linenum.split(",")  
            MsgtoOne(int(linenum[0]),int(linenum[1]))
        elif operate=="2":
            linenum=raw_input("请输入起始行与结束行，以逗号分隔:\r\n ");  
            linenum=linenum.split(",")  
            Msg_toall(int(linenum[0]),int(linenum[1]))
        else:
            flag=0
            print  "退出"
        