import paramiko
import os
 
# ������Ϣ
host = '61.152.168.229'
port = 22
username = 'admin'
password = 'root'
 
# ���Ե�Ŀ¼
skipArry = ['kai.xxxx.com','demo.xxxx.com']
 
fullpathArry = []
currentIndex = ''
 
 
# �ж��ļ��Ƿ����
def judgeFileExist():
 global currentIndex;
 currentIndex = os.getcwd() + '/Index.php'
 if os.path.isfile(currentIndex) == False:
  print('Index�ļ�������')
  exit()
 print('�ļ����ɹ�,׼�����ӷ�����...')
 
 
 
def creatConnect():
 try:
  print('��ʼ���ӷ�����...')
  s = paramiko.Transport((host, port))
  s.connect(username=username, password=password)
  sftp = paramiko.SFTPClient.from_transport(s)
  print('����:' + host + '�ɹ�')
  return sftp,s
 except Exception as e:
  print('���ӷ�����ʧ��:' + str(e))
 
 
 
#
 
# ��ȡĿ¼����Ϊ����
def getDirectory(sftp):
 print('��ʼ��ȡĿ¼...')
 sftp.chdir('/www/wwwroot')
 pathlist = sftp.listdir(path='.')
 for path in pathlist:
  fullpath = '/www/wwwroot/' + path + '/application/index/controller'
  if path in skipArry:
   continue
  fullpathArry.append(fullpath)
 print('Ŀ¼��ȡ���')
 
# �ϴ�Index�ļ�
def uploadIndex(sftp):
 for fullpathitem in fullpathArry:
   remoteIndex = fullpathitem + '/Index.php'
   print('��ʼ�ϴ�:' + remoteIndex)
   try:
    sftp.put(currentIndex, remoteIndex)
    try:
     sftp.file(remoteIndex)
     sftp.chmod(remoteIndex, int("775", 8))
     print('�޸�' + remoteIndex + 'Ȩ��Ϊ755')
     print(fullpathitem + '�ϴ��ɹ�')
    except:
     print(fullpathitem + '�ϴ�ʧ��')
     continue
   except Exception as e:
    print('������Ϣ:' + str(e))
    continue
   
 
if __name__ == "__main__":
 judgeFileExist()
 sftp,s = creatConnect()
 getDirectory(sftp)
 uploadIndex(sftp)
 s.close()