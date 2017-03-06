import pyotherside
import os
import socket
import time

def scanPort(port):
    sk = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sk.settimeout(3)
    flag=False
    while(flag is not True):
        try:
            sk.connect(('127.0.0.1',int(port)))
            flag=True
        except Exception:
            flag=False
        time.sleep(1)
    sk.close()
    pyotherside.send("OK")
