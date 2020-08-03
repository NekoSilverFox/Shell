#!/bin/bash
# 备份MySQL数据库
# 2020年8月3日11:29:26

# 同步系统时间
ntpdate asia.pool.ntp.org $> /dev/null # 类似于回收站

# 将当前系统时间赋给date
date=$(date +%y%m%d)

# 统计MySQL数据库大小，并将结果赋给size
size=$(du -sh /var/lib/mysql)

if [ -d /tmp/dbbak ]
	then
		echo "Data: $date" > /tmp/dbbak/dbinfo.txt
		echo "Size: $size" >> /tmp/dbbak/dbinfo.txt
		cd /tmp/dbbak
		tar -zcf mysql-lib-$date.tar.gz /var/lib/mysql dbinfo.txt $> /dev/null
		rm -rf /tmp/dbbak/dbinfo.txt

	else
		mkdir /tmp/dbbak
		echo "Data: $date" > /tmp/dbbak/dbinfo.txt
		echo "Size: $size" >> /tmp/dbbak/dbinfo.txt
		cd /tmp/dbbak
		tar -zcf mysql-lib-$date.tar.gz /var/lib/mysql dbinfo.txt $> /dev/null
		rm -rf /tmp/dbbak/dbinfo.txt
fi
