#!/bin/bash
# 统计根分区使用率
# 2020年8月3日10:58:44


# 把根分区使用率赋给rate		↓截取第五列	↓以百分号为分割，截取第一列
rate=$(df -h | grep "/dev/sda2" | awk '{print $5}' | cut -d "%" -f 1)

if [ $rate -ge 10 ]
	then
		echo "---------------------------------------"
		echo "Warning! The rate of /dev/sda2 is $rate"
		echo "$(date)"
		echo "---------------------------------------"
fi
