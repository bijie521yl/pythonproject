# coding=utf-8
__author__ = 'bj'
import MySQLdb
from DBUtils.PooledDB import PooledDB
import ConfigParser

cf = ConfigParser.ConfigParser() 
cf.read("./threadconf.ini")
host = cf.get("mysql", "host");
print host;
user = cf.get("mysql", "user");
PASSWORD = cf.get("mysql", "PASSWORD");
DB = cf.get("mysql", "DB");
PORT = cf.getint("mysql", "PORT");

g_db_conf = {
    "MYSQL_HOST": host,
    "USER": user,
    "PASSWORD": PASSWORD,
    "DB": DB,
    "PORT": PORT,
    "mincached": 2,
    "maxcached": 10,
    "maxconnections": 100
}

class DBPool(object):
    pool=None
    def __init__(self):
        global g_db_conf
        self.pool = PooledDB(MySQLdb, 5, host=g_db_conf["MYSQL_HOST"], user=g_db_conf["USER"], passwd=g_db_conf["PASSWORD"],
        db=g_db_conf["DB"], port=g_db_conf["PORT"])  # 5为连接池里的最少连接数
        # ,mincached=g_db_conf["mincached"],maxcached=g_db_conf["maxcached"],
        # maxconnections=g_db_conf["maxconnections"]

    def getconnect(self):
        return self.pool.connection()