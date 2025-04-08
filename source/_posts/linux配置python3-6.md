---
title: linux配置python3.6
tags: [linux&git]
date: 2019-03-17 15:57:22
categories: 配置
photos:
book:
---

#  linux配置python3.6

## 一、服务器环境配置

```
在 CentOS 7 中安装 Python 之前，请确保系统中已经有了所有必要的开发依赖：
    
# yum -y groupinstall development

# yum -y install zlib-devel

在 Debian 中，我们需要安装 gcc、make 和 zlib 压缩/解压缩库：

# aptitude -y install gcc make zlib1g-dev
```

以上很重要，缺少服务器相应的环境会安装失败 

## 二、python-3.6.1安装方法

两种方法：

第一种在python官方页面下载安装包，winscp上传到服务器

![img](linux配置python3-6\1038573-20170503172523570-880159933.png)

第二种：服务器远程下载，使用命令：`wget https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz`

完整的第二种安装python-3.6.1的方法

```
[root@VM_58_11_centos ~]# wget https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz  获取安装包
[root@VM_58_11_centos ~]# tar -zxf Python-3.6.1.tgz  解压缩
[root@VM_58_11_centos ~]# cd Python-3.6.1   定位到文件夹

#查看安装包文件
[root@VM_58_11_centos Python-3.6.1]# ls
aclocal.m4    config.sub  configure.ac  Grammar  install-sh  LICENSE  Makefile.pre.in  Modules  Parser  PCbuild        Python  setup.py
config.guess  configure   Doc           Include  Lib         Mac      Misc             Objects  PC      pyconfig.h.in  README  Tools

[root@localhost Python-3.6.1]# ./configure  添加配置
[root@localhost Python-3.6.1]# make      编译源码
[root@localhost Python-3.6.1]# make install     执行安装
```

## 三、测试

```
[root@VM_58_11_centos Python-3.6.1]# python3
Python 3.6.1 (default, May  3 2017, 17:10:54)
[GCC 4.8.5 20150623 (Red Hat 4.8.5-11)] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

 

 