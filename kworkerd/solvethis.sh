#!/bin/bash
ps aux|grep "I2NvZGluZzogdXRmLTg"|grep -v grep|awk '{print $2}'|xargs kill -9

echo "" > /etc/cron.d/root
echo "" > /etc/cron.d/system
echo "" > /var/spool/cron/root
echo "" > /var/spool/cron/crontabs/root
rm -rf /etc/cron.hourly/oanacron
rm -rf /etc/cron.daily/oanacron
rm -rf /etc/cron.monthly/oanacron

rm -rf /bin/httpdns
sed -i '$d' /etc/crontab

sed -i '$d' /etc/ld.so.preload
rm -rf /usr/local/lib/libntp.so

ps aux|grep kworkerds|grep -v color|awk '{print $2}'|xargs kill -9
rm -rf /tmp/.tmph
rm -rf /bin/kworkerds
rm -rf /tmp/kworkerds
rm -rf /usr/sbin/kworkerds
rm -rf /etc/init.d/kworker
chkconfig --del kworker