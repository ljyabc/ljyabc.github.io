---
title: mysql多实例
tags: [mysql]
date: 2019-03-31 15:47:08
categories: 理解
photos:
book:
---

# 二.mysql多实例管理

## 什么使多实例呢？

多实例就是在一台机器上开启多个不同的服务端口（如：3306,3307）；

运行多个MySQL服务进程，这些进程通过不同的socket监听不同的服务端口来提供各自的服务。

MySQL多实例共用一个 MySQL 的安装程序，使用不同（也可相同）的 my.cnf 配置文件，启动程序和数据文件。

在提供服务时，多实例 MySQL 在逻辑上是各自独立的，多个实例的本身是根据配置文件对应的设定值，来获得服务器的相关硬件资源多少。

**注意：其实很多服务器都可以由多实例，甚至在门户网站用的很广泛，例如Nginx****，Apache****、Haproxy****、Redis****、Memcached****，都可以多实例。**

### 1.2MySQL多实例的作用与问题

q  **有效利用服务器资源**

当单个服务器资源有剩余时,可以充分利用剩余的资源提供更多的服务，且可以实现资源的逻辑隔离。

q  **节约服务器资源**

当公司资金紧张，但是数据库又需要各自尽量独立地提供服务，而且，需要主从复制等技术时,多实例就再好不过了。

MySQL多实例有它的好处，但也有其弊端，比如：会存在资源互相枪占的问题。

q  **资源互相枪占问题**

当某个数据库实例并发很高或者有SQL慢查询时，整个实例会消耗大量的系统CPU、磁盘I/O等资源，导致服务器上的其他数据库实例提供服务的质量一起下降。

## 2.MySQL多实例生产应用场景

### 2.1资金紧张型公司的选择

当公司业务访问量不太大，又不舍得花钱，但又希望不同业务的数据库服务各自尽量独立的听过服务互相不受影响，而且，需要主从同步进行等技术提供备份或读写分离服务，多实例就再好不过了。如：可以通过3台服务器部署6-9个实例，交叉做主从同步备份及读写分离，实现6-9台服务器才有的效果。这里要强调的是，所谓的尽量独立是相对的。

### 2.2并发访问不是特别大的业务

当公司业务访问量不太大的时候，服务器的资源基本都是浪费的，这时就很适合多实例的应用，如果对SQL语句优化做的比较好，MySQL多实例一个很值得使用的技术，即使并发很大，合理分配好系统资源，也不会有太大问题。

### 2.3门户网应用MySQL多实例场景

 

百度搜索引擎的数据库就是多实例，一般是从库，48核，内存96G，跑3-4个实例，sina网也是用的多实例，内存48G左右。门户网站使用多实例的目的是配硬件好的服务器节省IDC机柜空间，同时，跑多实例让硬件资源不浪费。

## 5.3 多实例(3307  3308  3309)

> ###### cd /opt/mysql/data

### 5.3.1 创建相关目录

> mkdir -p /data/330{7..9}/data 
>
> 

### 5.3.2 创建配置文件

> cat>> /data/3307/my.cnf<<EOF
> [mysqld]
> basedir=/opt/mysql              
> datadir=/data/3307/data
> user=mysql
> socket=/data/3307/mysql.sock
> port=3307 
> server_id=3307
> EOF
>
> cd 3307

###### 拷贝一份但还要替换

> cp /data/3307/my.cnf /data/3308 
> cp /data/3307/my.cnf /data/3309 

> sed -i 's#3307#3308#g' /data/3308/my.cnf 
> sed -i 's#3307#3309#g' /data/3309/my.cnf 

##### 检查

[root@standby ~]# cat /data/3308/my.cnf

[mysqld]

basedir=/opt/mysql              

datadir=/data/3308/data

user=mysql

socket=/data/3308/mysql.sock

port=3308 

server_id=3308

### 5.3.3 初始化数据

> mysqld --initialize-insecure  --user=mysql --datadir=/data/3307/data --basedir=/opt/mysql
> mysqld --initialize-insecure  --user=mysql --datadir=/data/3308/data --basedir=/opt/mysql
> mysqld --initialize-insecure  --user=mysql --datadir=/data/3309/data --basedir=/opt/mysql

### 5.3.4 启动多实例

#### 先授权

> ###### chown -R mysql.mysql /data/*
>
>  mysqld_safe --defaults-file=/data/3307/my.cnf &
>  mysqld_safe --defaults-file=/data/3308/my.cnf &
>  mysqld_safe --defaults-file=/data/3309/my.cnf &

###### 关闭

> mysqladmin -S /data/3307/mysql.sock shutdown
>
> mysqladmin -S /data/3308/mysql.sock shutdown
>
> mysqladmin -S /data/3309/mysql.sock shutdown

### 5 .3.5 测试

> netstat -lnp|grep 330
>
>  mysql -S /data/3307/mysql.sock
>  mysql -S /data/3308/mysql.sock
>  mysql -S /data/3309/mysql.sock

### 5.3.6 systemd管理多实例(启动方便)

> cat >> /etc/systemd/system/mysqld3307.service <<EOF
> [Unit]
> Description=MySQL Server
> Documentation=man:mysqld(8)
> Documentation=http://dev.mysql.com/doc/refman/en/using-systemd.html
> After=network.target
> After=syslog.target
> [Install]
> WantedBy=multi-user.target
> [Service]
> User=mysql
> Group=mysql
> ExecStart=/opt/mysql/bin/mysqld --defaults-file=/data/3307/my.cnf
> LimitNOFILE = 5000
> EOF
> cp  /etc/systemd/system/mysqld3307.service   /etc/systemd/system/mysqld3308.service 
> cp  /etc/systemd/system/mysqld3307.service   /etc/systemd/system/mysqld3309.service 
> sed -i 's#3307#3308#g'   /etc/systemd/system/mysqld3308.service
> sed -i 's#3307#3309#g'   /etc/systemd/system/mysqld3309.service

###### 检查

> cat /etc/systemd/system/mysqld3307.service
>
> ###### 
>
> cat /etc/systemd/system/mysqld3308.service
>
> ###### 
>
> cat /etc/systemd/system/mysqld3309.service

###### 方便启动

> systemctl start mysqld3307
> systemctl start mysqld3308
> systemctl start mysqld3309
> netstat -lnp|grep 330
>
> systemctl stop mysqld3309
> systemctl stop mysqld3308
> systemctl stop mysqld3307

###### 开机启动

> systemctl enable  mysqld3307
> systemctl enable  mysqld3308
> systemctl enable  mysqld3309