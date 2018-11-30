# coding=utf-8
__author__ = 'bj'
import datetime
import ConfigParser
import threading
import DataBasePool
import random

cf = ConfigParser.ConfigParser() 
cf.read("./threadconf.ini")
g_thread_count = cf.getint("thread", "thread_count")
# g_totlenum=cf.getint("thread", "totlenum");

mu = threading.Lock()   # 通过工厂方法获取一个新的锁对象

class MyThread(threading.Thread):   # 类MyThread继承基类threading.Thread

    def __init__(self,func,args,name=''):
        threading.Thread.__init__(self)
        self.name=name
        self.func=func
        self.args=args

    def run(self):
        global mu
        apply(self.func,self.args)

class Task(DataBasePool.DBPool):
    def __init__(self):
        DataBasePool.DBPool.__init__(self)
    def taskfunc(self,args,name=''):
        conn=self.getconnect();
        cur = conn.cursor()
        for i in range(10000):
            SQL = "INSERT INTO `v_max_fundnav` VALUES ('4461', '000315', '2014-10-24 00:00:00', 0, 1.0050000000000001, 1.042, 0, 0.037000000000000005, '0', '0', '1', '0', 0, '2014-10-24 22:28:15', '2014-10-27 23:52:18', NULL)";
            r = cur.execute(SQL)
        cur.close()
        conn.close()

    def taskfunc2(self,args,name=''):
        conn=self.getconnect()
        cur = conn.cursor()
        for i in range(10000):
            SQL = "INSERT INTO `v_funddataopfundprofile` VALUES ('311', '184688', '南方开元封闭', '开元证券投资基金', 'NFKYFB', 19980327, 19980327, 20130218, 2000000000, 2000000000, 1, 1, 2, 0, '', 2000000000, 2000000000, 957919, 957919, '', 0, '投资收益。', '为投资者减少和分散投资风险', '', '', '投资收益。', '投资收益。', '', '', 2, '', 1, 1, 15, 0, '0', '0', '0', '1', '0', '2', '2', '1', '', '', '南方', '南方基金管理股份有限公司', '03', 19980327, '0', 1, '工商银行', '中国工商银行股份有限公司', 19840101, 20010801, 0, 0, 0, 0, '混合基金', '02', '封闭式偏股型基金', '0220', '封闭式偏股型基金', '022001', '2', '2.20', '2.20.1', '0', 19980407, 20130327, 0, '1', '0', '0', '0', '0', '0', '1', '1', '1', '1', '1', 0, '', '', '', '0')";
            r = cur.execute(SQL)
        cur.close()
        conn.close()

    def taskfunc3(self,args,name=''):
        conn=self.getconnect()
        cur = conn.cursor()
        for i in range(10000):
            SQL = "INSERT INTO `t_oc_pc_banner` VALUES (604, 'PcTest', 'http://www.chinastock.com.cn/pic_new_test/jrpt_index/banner3.png', 'http://local/?PRD_CODE=AA0006&PRD_CHNL_DISP_2CLASS=330300&action=B', 'pc_banner', 3, 1, NULL, '2010-1-1', '2030-1-1')";
            r = cur.execute(SQL)
        cur.close()
        conn.close()
    
    def taskfunc4(self,args,name=''):
        conn=self.getconnect()
        cur = conn.cursor()
        for i in range(10000):
            SQL = "INSERT INTO `cgs_adm.fund_co` VALUES (47, 'SHDJ', '上海登记', '上海登记', 0)";
            r = cur.execute(SQL)
        cur.close()
        conn.close()

    def taskfunc5(self,args,name=''):
        conn=self.getconnect()
        cur = conn.cursor()
        for i in range(10000):
            SQL = "INSERT INTO `cgs_adm.fund_his_net` VALUES ('3I1030', '博盛隆1期（优先）', 20141225, 1.0000, 1.0000, 0.00000, 0.00000, 0.00000000000000)";
            r = cur.execute(SQL)
        cur.close()
        conn.close()
    
    def taskfunc6(self,args,name=''):
        conn=self.getconnect()
        cur = conn.cursor()
        for i in range(10000):
            SQL = "INSERT INTO `cgs_adm.stk_fund_bigdata` VALUES ('519779', '交银沪港深价值精选混合', '交银沪港深价值精选混合', '020502', '3', 1.0110, 20181031, 0.011000, -0.141728, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, -0.050900, -0.105031, 0.226600, '', '')";
            r = cur.execute(SQL)
        cur.close()
        conn.close()

    def gettasklist(self):
        return [self.taskfunc, self.taskfunc2, self.taskfunc3, self.taskfunc4, self.taskfunc5, self.taskfunc6]

        
def test():
     thread_all = []
     global g_thread_count

     task=Task()
     tasklist=task.gettasklist()
     
     print datetime.datetime.now();
     for i in range(g_thread_count):  # 配置文件获取
         index=random.randint(0, len(tasklist)-1)
         print index
         t = MyThread(tasklist[index],[i,i])  # 创建线程
         thread_all.append(t)
         t.start()   ###启动线程
 
     for i in range(g_thread_count):
         thread_all[i].join()    ##等待线程结束
     print datetime.datetime.now();
     print "send totle number",g_thread_count

if __name__=="__main__":   
    test();