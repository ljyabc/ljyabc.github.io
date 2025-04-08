---
title: Windows下安装Redis
tags: [redis]
date: 2019-04-01 13:36:08
categories: 理解
photos:
book:
---

# 1. 下载Redis Windows 安装包

下载地址：<https://github.com/dmajkic/redis/downloads>
选择redis版本进行下载

# 2. 解压安装包

解压后得到如下文件（见下图）
![Snip20170508_4.png](git2\4132965306.png)

- edis-server.exe：服务程序
- redis-check-dump.exe：本地数据库检查
- redis-check-aof.exe：更新日志检查
- redis-benchmark.exe：性能测试，用以模拟同时由N个客户端发送M个 SETs/GETs 查询 (类似于 Apache 的ab 工具).

把以上文件放入同一目录，这里放入redis目录，把redis目录放置到要安装的位置，这里将redis目录放入 C:/wamp/ 下

# 3.启动Redis服务

打开cmd 命令框 cd 到redis目录（如下图）
![2.png](git2\1082885070.png)

启动cmd窗口要一直开着，关闭后则Redis服务关闭。

# 4.登录客户端

重新打开cmd窗口 （如下图）
![3.png](git2\2271727717.png)

其中，6379为Redis服务的端口号