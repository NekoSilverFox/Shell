# Shell 编程

## 零. 该知道的

1. 什么是Shell脚本？

- 一句话概括

简单来说就是将==需要执行的命令==保存到文本中，==按照顺序执行==。它是解释型的，意味着不需要编译。

- 准确叙述

  **若干命令 + 脚本的基本格式 + 脚本特定语法 + 思想= shell脚本**

2. 什么时候用到脚本?

   **重复化**、复杂化的工作，通过把工作的命令写成脚本，以后仅仅需要执行脚本就能完成这些工作。

3. shell脚本能干啥?

    ① 自动化软件部署	LAMP/LNMP/Tomcat...	

    ② 自动化管理	   系统初始化脚本、批量更改主机密码、推送公钥...

    ③ 自动化分析处理 	 统计网站访问量

    ④ 自动化备份 	    数据库备份、日志转储...

    ⑤ 自动化监控脚本

## 一. 执行Shell的五种方式

1. chmod a+x 然后执行 shell.sh
2. /bin/sh shell.sh
3. **.**  shell.sh
4. source shell.sh
5. 非标准的执行方法（不建议）

- 直接在命令行指定解释器执行

```powershell
[root@MissHou shell01]# bash first_shell.sh
[root@MissHou shell01]# sh first_shell.sh
[root@MissHou shell01]# bash -x first_shell.sh
+ echo 'hello world'
hello world
+ echo 'hello world'
hello world
+ echo 'hello world'
hello world

-x:一般用于排错，查看脚本的执行过程
-n:用来查看脚本的语法是否有问题
```

2. 使用`source`命令读取脚本文件,执行文件里的代码

## 二. 编写时的注意事项

1. 要以 **#! /bin/sh** 开头

2. 文件中的命令最好用绝对路径

3. 注释以 **#** 开头

4. 命令分为内建命令

5. Shell 的种类

   ~~~powershell
   [root@MissHou ~]# cat /etc/shells 
   /bin/sh				#是bash的一个快捷方式
   /bin/bash			#bash是大多数Linux默认的shell，包含的功能几乎可以涵盖shell所有的功能
   /sbin/nologin		#表示非交互，不能登录操作系统
   /bin/dash			#小巧，高效，功能相比少一些
   
   /bin/csh			#具有C语言风格的一种shell，具有许多特性，但也有一些缺陷
   /bin/tcsh			#是csh的增强版，完全兼容csh
   ~~~

   

## 三、bash的特性

### 3.1 命令和文件自动补全

Tab只能补全 **命令和文件**

### 1、常见的快捷键

~~~powershell
^c   			终止前台运行的程序
^z	  			将前台运行的程序挂起到后台
^d   			退出 等价exit
^l   			清屏 
^a |home  		光标移到命令行的最前端
^e |end  		光标移到命令行的后端
^u   			删除光标前所有字符
^k   			删除光标后所有字符
^r	 			搜索历史命令
~~~

### 2 、常用的通配符（重点）

~~~powershell
*:	匹配0或多个任意字符
?:	匹配任意单个字符
[list]:	匹配[list]中的任意单个字符,或者一组单个字符   [a-z]
[!list]: 匹配除list中的任意单个字符
{string1,string2,...}：匹配string1,string2或更多字符串


# rm -f file*
# cp *.conf  /dir1
# touch file{1..5}
~~~

### 3、bash中的引号（重点）

- **双引号" "**	 : 会把引号的内容当成整体来看待，**允许通过$符号引用其他变量值**
- **单引号' '**     : 会把引号的内容当成整体来看待，**禁止引用其他变量值**，**shell中特殊符号都被视为普通字符**
- **反撇号``**  : **反撇号和$()一样**，引号或括号里的命令会优先执行，如果存在嵌套，反撇号不能用

~~~powershell
[root@MissHou  dir1]# echo "$(hostname)"
server
[root@MissHou  dir1]# echo '$(hostname)'
$(hostname)
[root@MissHou  dir1]# echo "hello world"
hello world
[root@MissHou  dir1]# echo 'hello world'
hello world

[root@MissHou  dir1]# echo $(date +%F)
2020-9-22
[root@MissHou  dir1]# echo `echo $(date +%F)`
2020-9-22
[root@MissHou  dir1]# echo `date +%F`
2020-9-22
[root@MissHou  dir1]# echo `echo `date +%F``
date +%F
[root@MissHou  dir1]# echo $(echo `date +%F`)
~~~



## 四. 变量

### 4.1变量的定义

**一. 变量的命名**

   1. 变量名区分大小写

   2. 变量名不能用数字开头

   3. 变量名不能有特殊符号

   4. **等号两遍不能有空格！**

   5. - 环境变量（$PATH）--> 相当于全局变量
        - `VAR=hrllo`
        - `echo $VAR`
      - 本地变量  --> 相当于局部变量

   6. `temp=123`

   `echo $temp`

## 五.文件名代换**

   用于匹配的字符成为通配符（Wildcard），如： * ? []

   - `*` 匹配零个或若干字符
   - `?` 匹配任意一个字符
   - `[若干字符]` 匹配方括号中一个任意一个字符

## 六. 命令代换**

   由 **`** **反引号**或者**$(命令)**括起来的也是一条命令，Shell先执行该命令，然后将输出结果代换到当前命令中。列入定义一个变量存放date命令的输出：

  ~~~powershell
 user$ DATE=`date`
 user$ echo $DATE
 user$ DATE=$(date)
 user$ echo $DATE
  ~~~

## 七. 算数代换

~~~powershell
user$ VAR=40
user$ echo $VAR+30
40+30
user$ echo $(VAR+30)
VAR+30 Command nor found
user$ echo $((VAR+30))	# 正确
70
user$ echo $(($VAR+30))	# 正确
70
user$ echo $[VAR+30]	# 正确
70
user$ echo $[$VAR+30]	# 正确
70
~~~

## **八. 算数代换**

​	$[几进制#数字]，代表几进制中的数字

~~~powershell
user$ echo $[2#10+11]	# 代表二进制中的10 加十进制的11
13
user$ echo $[8#11+12]	# 代表8进制中的11 加十进制中的12
21
~~~

## **九. 转义字符**

转义符：**\\**（反斜杠）

~~~powershell
user$ touch ./---abc	# 创建一个奇葩文件名的文件必须用 ./奇葩文件名
user$ rm ./---abc		# 删除奇葩文件
user$ rm -- ---abc		# 另一种删除方法
~~~

## 十. 双引号

被双引号括住的内容，被视为单一字串。禁止通配符扩展，但是允许变量扩展。这与单引号的处理方式不同

变量建议用双引号括起来

## 十一. 单引号

单引号用于保持引用引号内所有字符的字面值，即使引号内的\和回车也不例外 

## 十二. 基本语法

### 12.1 条件测试

​	命令 `test` 或 `[` 可以测试一个条件是否成立，如果测试结果为**真**，则该命令的Exit Status**为0，如果测试结果为**假**，则命令的Exit Status**为1**。注意与c语言的逻辑正好相反

假如测试的两个数的大小关系：

~~~powershell
user$ VAR=77
user$ test $VAR -gt 100
user$ echo $?			# 获取上一条命令的执行结果
user$ [ $? ]			# 虽然看起来很奇怪，但是 [] 确实是一个命令，注意空格
~~~

![image-20201008232343341](C:\Users\mi\AppData\Roaming\Typora\typora-user-images\image-20201008232343341.png)

![image-20201008233244548](C:\Users\mi\AppData\Roaming\Typora\typora-user-images\image-20201008233244548.png)