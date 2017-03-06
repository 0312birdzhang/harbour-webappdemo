import http.server
import pyotherside
import os
import socket
import time
import random


#随机端口号
def randomport():
    port=9527
    pflag = scan(port)
    #如果端口开启,则更换随机端口
    while (pflag):
        port = random.randint(9000,50000)
        pflag = scan(port)
    return port



def start_server(port, bind="", cgi=True):
    if cgi==True:
        http.server.test(HandlerClass=http.server.CGIHTTPRequestHandler, port=port, bind=bind)
    else:
        http.server.test(HandlerClass=http.server.SimpleHTTPRequestHandler,port=port,bind=bind)



def scan(port):
    sk = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sk.settimeout(3)
    flag=False
    try:
        sk.connect(('127.0.0.1',port))
        flag=True
    except Exception:
        flag=False
    sk.close()
    return flag

def start():
    os.chdir("/usr/share/harbour-littletouhou-arcade/qml/pages")
    startport = randomport()
    pyotherside.send(startport)
    start_server(startport)
start()
