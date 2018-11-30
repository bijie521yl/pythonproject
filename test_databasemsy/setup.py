# coding=GBK

from PyInstaller.__main__ import run

if __name__ == '__main__':
    opts = ['./PushDB.py', '-F']
    # opts = ['tpycs.py', '-F', '-w']
    # opts = ['tpycs.py', '-F', '-w', '--icon=TargetOpinionMain.ico','--upx-dir','upx391w']
    run(opts)
