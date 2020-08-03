#!/bin/bash
# 判断Apache是否启动
# 2020年8月3日11:45:14

# 使用nmap命令扫描服务器，并截取Apache服务状态，赋予变量port
# 如果无法找到命令，请安装nmap命令
port=$(nmap -sT 192.168.0.6 | grep tcp | grep htpp | awk '{print $2}')

if [ "$port" == "open" ]
	then
		echo "$(date) Apache-httpd is running" >> /tmp/autostart-acc.log
		
	else
		# 适用于rpm包安装的阿帕奇
		#/etc/rc.d/init.d/httpd start $> /dev/null
		
		# 适用于源码包安装的阿帕奇
		/usr/local/apache/bin/apachectl start &> /dev/null

		echo "$(date) restart Apache-httpd" >> /tmp/autostart-err.log
fi
