# coding=GBK
# when set coding=utf8,tips NOT ENOUGH SPACE
__author__ = 'bj'

import urllib2
request = urllib2.Request("https://www.baidu.com")
response = urllib2.urlopen(request)
print response.read()
