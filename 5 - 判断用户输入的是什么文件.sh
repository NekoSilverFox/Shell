#!/bin/bash
# 判断用户输入的是什么文件
# 2020年8月3日13:36:09

# 键盘接受输入，赋予变量file_name
read -t 30 -p "Please input the file name: " file_name

# 判断file_name 是否为空
if [ -z "$file_name"  ]
	then
		echo "Error! The file name can not be empty"

# 判断file的值是否存在
elif [ ! -e "$file_name" ]
	then
		echo "Not a file"
	exit 2

# 判断是否为普通文件
elif [ -f "$file_name" ]
	then
		echo "$file_name is a regulare file"
	exit 3

elif [ -d "$file_name" ]
	then
		echo "$file_name is a directory"
	exit 4

else
	echo "$file_name is other file"

fi
