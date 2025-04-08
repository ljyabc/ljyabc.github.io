---
title: redis缓存技术
tags: [redis]
date: 2019-03-31 15:50:51
categories:
photos:
book:
---

# Redis缓存技术

#### 1. NoSQL产品

```
memcached
redis

```

#### 2. redis面试常问问题：功能介绍

```
高速读写
数据类型丰富    （笔试、面试）*****
支持持久化      （笔试、面试）*****
多种内存分配及回收策略
支持事务			（面试）  ****
消息队列、消息订阅 
支持高可用                     ****
支持分布式分片集群 （面试）   *****
缓存穿透\雪崩（笔试、面试）   *****
Redis API					   **
```

#### 3. 企业缓存产品介绍

##### 3.1 memcached

```
优点：高性能读写、单一数据类型、支持客户端式分布式集群、一致性	hash多核结构、多线程读写性能高。

缺点：
无持久化、节点故障可能出现缓存穿透、分布式需要客户端实现、跨机房数据同步困难、架构扩容复杂度高

```

##### 3.2 redis

```
优点：高性能读写、多数据类型支持、数据持久化、高可用架构、支持自定义虚拟内存、支持分布式分片集群、单线程读写性能极高

缺点：多线程读写较Memcached慢

应用的场景：
新浪、京东、直播类平台、网页游戏

```

##### 3.3 memcache与redis在读写性能的对比

```
memcached 适合,多用户访问,每个用户少量的rw
redis     适合,少用户访问,每个用户大量rw	
			
Tair：淘宝使用的
优点：高性能读写、支持三种存储引擎（ddb、rdb、ldb）、支持高可用、支持分布式分片集群、支撑了几乎所有淘宝业务的缓存。

缺点：单机情况下，读写性能较其他两种产品较慢

```

##### 3.4 Redis使用场景介绍

```
Memcached：多核的缓存服务，更加适合于多用户并发访问次数较少的应用场景

Redis：单核的缓存服务，单节点情况下，更加适合于少量用户，多次访问的应用场景。

Redis一般是单机多实例架构，配合redis集群出现。

```

#### 4. Redis安装部署

```python
下载：
wget http://download.redis.io/releases/redis-3.2.12.tar.gz
解压：
上传至 /data
tar xzf redis-3.2.12.tar.gz
mv redis-3.2.12 redis
安装：
cd redis
make
启动：
src/redis-server &


环境变量：
vim /etc/profile 
export PATH=/data/redis/src:$PATH
source /etc/profile 


redis-server & 

redis-cli 
127.0.0.1:6379> set num 10
OK
127.0.0.1:6379> get num
10
```

![1553340666820](E:/blog-git/ljy/source/_posts/%E6%95%B0%E6%8D%AE%E5%BA%93%E7%AC%94%E8%AE%B01/1553340666820.png)

#### 5. Redis基本管理操作

##### 5.1 基础配置文件介绍

```mysql
1.设置配置文件
[root@standby ~]# redis-cli  shutdown 

mkdir /data/6379

cat >>/data/6379/redis.conf <<EOF
daemonize yes #守护进程
port 6379 #端口
logfile /data/6379/redis.log # 日志
dir /data/6379 #文件目录
dbfilename dump.rdb #文件名字
EOF

2.重启redis
redis-cli shutdown 
redis-server /data/6379/redis.conf 
netstat -lnp|grep 63
```

##### 5.2 配置文件说明

```mysql
redis.conf
1.是否后台运行
daemonize yes

2.默认端口：
port 6379

3.日志文件位置
logfile /var/log/redis.log

4.持久化文件存储位置
dir /data/6379

5.RDB持久化数据文件:
dbfilename dump.rdb
```

##### 5.3 redis-cli 客户端命令常用参数说明

```python
redis-cli 刚装完,可以在redis服务器上直接登录redis
-p 6379   指定端口号
-h        指定链接地址
-a        指定链接密码
redis-cli  set num  10 ,无交互执行redis命令
cat /tmp/1.txt |redis-cli

[root@db01 ~]# redis-cli -h 10.0.0.51  -p 6379
10.0.0.51:6379> 
```

##### 5.4 redis安全配置:指定IP/设置验证密码

```
redis默认开启了保护模式，只允许本地回环地址登录并访问数据库。

禁止protected-mode

protected-mode yes/no （保护模式，是否只允许本地访问）

```

```mysql
(1)Bind :指定IP进行监听
echo "bind 10.0.0.200  127.0.0.1" >>/data/6379/redis.conf
(2)增加requirepass  {password}
echo "requirepass 123" >>/data/6379/redis.conf

重启redis
redis-cli shutdown 
redis-server /data/6379/redis.conf 

----------验证-----
方法一：
[root@db03 ~]# redis-cli -a 123
127.0.0.1:6379> set name zhangsan 
OK
127.0.0.1:6379> exit
方法二：
[root@db03 ~]# redis-cli
127.0.0.1:6379> auth 123
OK
127.0.0.1:6379> set a b
```

##### 5.5 在线查看和修改配置

```mysql
CONFIG GET *
CONFIG GET requirepass
CONFIG SET requirepass 123 #修改密码,不会自动写入配置
```

------

![1553341990178](E:/blog-git/ljy/source/_posts/%E6%95%B0%E6%8D%AE%E5%BA%93%E7%AC%94%E8%AE%B01/1553341990178.png)

#### 6. redis持久化（内存数据保存到磁盘）

##### 6.1 作用

```
作用:可以有效防止,在redis宕机后,缓存失效的问题.

```

##### 6.2 RDB 持久化

> **1. 优缺点**

```
可以在指定的时间间隔内生成数据集的时间点快照（point-in-time snapshot）。

优点：
速度快，适合于用做备份，主从复制也是基于RDB持久化功能实现的。

缺点：
会有数据丢失

```

> **2.rdb持久化核心配置参数**

```mysql
vim /data/6379/redis.conf
dir /data/6379
dbfilename dump.rdb

save 900 1
save 300 10
save 60 10000

配置分别表示：
dir              ---redis持久化的文件目录
dbfilename       ----redis持久化的文件名
900秒（15分钟）内有1个更改
300秒（5分钟）内有10个更改
60秒内有10000个更改
```

##### 6.3 AOF 持久化(append-only log file)

> **1.优缺点**

```
记录服务器执行的所有写操作命令，并在服务器启动时，通过重新执行这些命令来还原数据集。 
AOF 文件中的命令全部以 Redis 协议的格式来保存，新命令会被追加到文件的末尾。

优点：可以最大程度保证数据不丢
缺点：日志记录量级比较大

```

> **2.AOF持久化配置**

```mysql
1.配置参数
appendonly yes
appendfsync everysec

appendfsync always
appendfsync no

2.配置介绍
是否打开aof日志功能
每1个命令,都立即同步到aof 
每秒写1次
写入工作交给操作系统,由操作系统判断缓冲区大小,统一写入到aof.

注意：
appendfsync 只需要配置一个就可以


3.配置
vim /data/6379/redis.conf
appendonly yes
appendfsync everysec 
```

##### 6.4 redis 持久化方式有哪些？有什么区别？

```
rdb：基于快照的持久化，速度更快，一般用作备份，主从复制也是依赖于rdb持久化功能

aof：以追加的方式记录redis操作日志的文件。可以最大程度的保证redis数据安全，类似于mysql的binlog

```

------

#### 7. Redis数据类型(笔试)

##### 7.1 介绍

```python
String ：     字符类型
Hash：        字典类型
List：        列表     
Set：         集合 
Sorted set：  有序集合

---------------------------
键      值
key     value

key     col1 value1  col2 value2 

key     [a,b,c,d]  
         0 1 2 3
		 		 
key1    (a,b,c,d)  

		  10	 20   30  40 ----打分
key1     ( a,    b,   c,  d)  
           0     1    2   3
```

##### 7.2 键的通用操作

```
KEYS * 	 keys a  keys a*	查看已存在所有键的名字   ****
TYPE						返回键所存储值的类型     ****
EXISTS 				        检查是否存在             *****
再get
EXPIRE\ PEXPIRE 			以秒\毫秒设定生存时间       ***
设置EXPIRE
TTL\ PTTL 					以秒\毫秒为单位返回生存时间 ***
显示
PERSIST 					取消生存实现设置            ***
DEL							删除一个key
RENAME 				        变更KEY名

```

![1553452880488](E:/blog-git/ljy/source/_posts/%E6%95%B0%E6%8D%AE%E5%BA%93%E7%AC%94%E8%AE%B01/1553452880488.png)

##### 7.3 string类型的应用场景

```mysql
应用场景

常规计数：
微博数，粉丝数等。
订阅、礼物、页游
key:value

计数器
每点一次关注，都执行以下命令一次
127.0.0.1:6379> incr fans_count
(integer) 10003
INCRBY num 100000
127.0.0.1:6379> get fans_count
"10003"
127.0.0.1:6379> incrby fans_count 1000
(integer) 11003
127.0.0.1:6379> decr fans_count 
(integer) 11002
127.0.0.1:6379> decrby  fans_count 1000
```

##### 7.4 hash类型的应用场景

```
hash类型（字典类型）

应用场景：
存储部分变更的数据，如用户信息等。
最接近mysql表结构的一种类型

```

##### 7.5 list列表的应用场景

```
消息队列系统：后进先出
比如sina微博:在Redis中我们的最新微博ID使用了常驻缓存，这是一直更新的。
但是做了限制不能超过5000个ID，因此获取ID的函数会一直询问Redis。
只有在start/count参数超出了这个范围的时候，才需要去访问数据库。
系统不会像传统方式那样“刷新”缓存，Redis实例中的信息永远是一致的。
SQL数据库（或是硬盘上的其他类型数据库）只是在用户需要获取“很远”的数据时才会被触发，
而主页或第一个评论页是不会麻烦到硬盘上的数据库了。

```

##### 7.6 SET 集合类型（类似于mysql中的join）应用场景

```
应用场景：
案例：在微博应用中，可以将一个用户所有的关注人存在一个集合中，将其所有粉丝存在一个集合。
Redis还为集合提供了求交集、并集、差集等操作，可以非常方便的实现如共同关注、共同喜好、二度好友等功能，
对上面的所有集合操作，你还可以使用不同的命令选择将结果返回给客户端还是存集到一个新的集合中。

```

> **1.经典案例**

```mysql
-------------
127.0.0.1:6379> sadd lxl pg1 pg2 songlaoban oldnie oldchen marong
(integer) 6
127.0.0.1:6379> sadd jnl baoqiang yufan oldchen songzhe
(integer) 4
127.0.0.1:6379> sadd jnl baoqiang yufan oldchen songzhe oldguo  alexdsb 
(integer) 2
127.0.0.1:6379> 
127.0.0.1:6379> smembers lxl
1) "pg2"
2) "pg1"
3) "oldnie"
4) "songlaoban"
5) "marong"
6) "oldchen"
127.0.0.1:6379> smembers jnl
1) "alexdsb"
2) "yufan"
3) "oldguo"
4) "songzhe"
5) "baoqiang"
6) "oldchen"
127.0.0.1:6379> 

127.0.0.1:6379> SUNION lxl jnl  #-------合集（去重）
 1) "marong"
 2) "pg2"
 3) "pg1"
 4) "oldchen"
 5) "alexdsb"
 6) "yufan"
 7) "songlaoban"
 8) "baoqiang"
 9) "oldnie"
10) "songzhe"
11) "oldguo"

127.0.0.1:6379> SINTER lxl jnl  #-----并集
1) "oldchen"


127.0.0.1:6379> 
127.0.0.1:6379> SDIFF lxl jnl   # ----差集
1) "songlaoban"
2) "oldnie"
3) "pg1"
4) "pg2"
5) "marong"
127.0.0.1:6379> SDIFF  jnl lxl 
1) "alexdsb"
2) "yufan"
3) "songzhe"
4) "oldguo"
5) "baoqiang"
-----------------
```

##### 7.7 SortedSet（有序集合）应用场景

```
应用场景：
排行榜应用，取TOP N操作

这个需求与上面需求的不同之处在于，前面操作以时间为权重，这个是以某个条件为权重，比如按顶的次数排序，这时候就需要我们的sorted set出马了，将你要排序的值设置成sorted set的score，将具体的数据设置成相应的value，每次只需要执行一条ZADD命令即可。

```

> **1.经典案例**

```mysql
--------------
127.0.0.1:6379> zadd topN 0 smlt 0 fskl 0 fshkl 0 lzlsfs 0 wdhbx 0 wxg 
(integer) 6
127.0.0.1:6379> ZINCRBY topN 100000 smlt #手动设置点播数
"100000"
127.0.0.1:6379> ZINCRBY topN 10000 fskl
"10000"
127.0.0.1:6379> ZINCRBY topN 1000000 fshkl
"1000000"
127.0.0.1:6379> ZINCRBY topN 100 lzlsfs
"100"
127.0.0.1:6379> ZINCRBY topN 10 wdhbx
"10"
127.0.0.1:6379> ZINCRBY topN 100000000 wxg
"100000000"

127.0.0.1:6379> ZREVRANGE topN 0 2 
1) "wxg"
2) "fshkl"
3) "smlt"
127.0.0.1:6379> ZREVRANGE topN 0 2 withscores
1) "wxg"
2) "100000000"
3) "fshkl"
4) "1000000"
5) "smlt"
6) "100000"
127.0.0.1:6379> 

--------------
```

------

#### 8. redis的发布订阅

##### 8.1 发布订阅系统的相关指令

领事回话关了没了

![1553455706534](E:/blog-git/ljy/source/_posts/%E6%95%B0%E6%8D%AE%E5%BA%93%E7%AC%94%E8%AE%B01/1553455706534.png)

![1553455764675](E:/blog-git/ljy/source/_posts/%E6%95%B0%E6%8D%AE%E5%BA%93%E7%AC%94%E8%AE%B01/1553455764675.png)

```python
1.PUBLISH channel msg
将信息 message 发送到指定的频道 channel

2.SUBSCRIBE channel [channel ...]
订阅频道，可以同时订阅多个频道

3.UNSUBSCRIBE [channel ...]
取消订阅指定的频道, 如果不指定频道，则会取消订阅所有频道

4.PSUBSCRIBE pattern [pattern ...]
订阅一个或多个符合给定模式的频道，每个模式以 * 作为匹配符，比如 it* 匹配所	有以 it 开头的频道( it.news 、 it.blog 、 it.tweets 等等)， news.* 匹配所有	以 news. 开头的频道( news.it 、 news.global.today 等等)，诸如此类

5.PUNSUBSCRIBE [pattern [pattern ...]]
退订指定的规则, 如果没有参数则会退订所有规则

6.PUBSUB subcommand [argument [argument ...]]
查看订阅与发布系统状态

注意：
使用发布订阅模式实现的消息队列，当有客户端订阅channel后只能收到后续发布到该频道的消息，之前发送的不会缓存，必须Provider和Consumer同时在线。
```

##### 8.2 实例

```mysql
发布订阅例子：

窗口1：

127.0.0.1:6379> SUBSCRIBE baodi 

窗口2：

127.0.0.1:6379> PUBLISH baodi "jin tian zhen kaixin!"

订阅多频道：
窗口1：
127.0.0.1:6379> PSUBSCRIBE wang*
窗口2：
127.0.0.1:6379> PUBLISH wangbaoqiang "jintian zhennanshou "
```

------

#### 9. Redis事务

![155345959728](E:/blog-git/ljy/source/_posts/%E6%95%B0%E6%8D%AE%E5%BA%93%E7%AC%94%E8%AE%B01/1553455959728.png)

![1553456485956](E:/blog-git/ljy/source/_posts/%E6%95%B0%E6%8D%AE%E5%BA%93%E7%AC%94%E8%AE%B01/1553456485956.png)

![1553456593470](E:/blog-git/ljy/source/_posts/%E6%95%B0%E6%8D%AE%E5%BA%93%E7%AC%94%E8%AE%B01/1553456593470.png)

![1553456758673](E:/blog-git/ljy/source/_posts/%E6%95%B0%E6%8D%AE%E5%BA%93%E7%AC%94%E8%AE%B01/1553456758673.png)

##### 9.1 redis和mysql事务实现的原理

```
redis的事务是基于队列实现的。---queue
mysql的事务是基于事务日志实现的。---undo redo

```

##### 9.2 开启事务

```mysql
1.开启事务功能时（multi）
multi 
command1      
command2
command3
command4

注意：
4条语句作为一个组，并没有真正执行，而是被放入同一队列中。
如果，这是执行discard，会直接丢弃队列中所有的命令，而不是做回滚。

2.当执行exec时，对列中所有操作，要么全成功要么全失败
exec
```

> **1.实例**

```mysql
----------
127.0.0.1:6379> set a b
OK
127.0.0.1:6379> MULTI
OK
127.0.0.1:6379> set a b
QUEUED
127.0.0.1:6379> set c d
QUEUED
127.0.0.1:6379> exec
1) OK
2) OK

--------------------
```

##### 9.3 redis乐观锁实现（模拟买票）

```mysql
发布一张票
set ticket 1

窗口1：
watch ticket  # 监听其他事务是否提交
multi
set ticket 0       1---->0

窗口2：
multi 
set ticket 0 
exec 

窗口1：
exec
```

------

#### 10. 服务器管理命令

```
Info
Clinet list
Client kill ip:port
config get *
CONFIG RESETSTAT 重置统计
CONFIG GET/SET 动态修改
Dbsize
FLUSHALL 清空所有数据 
select 1
FLUSHDB 清空当前库

MONITOR 监控实时指令
SHUTDOWN 关闭服务器

关闭数据库：
redis-cli -a root shutdown

```

#### 11. redis（master-replicaset）主从复制

##### 11.1 原理

```python
原理：
1. 从服务器向主服务器发送 SYNC 命令。
2. 接到 SYNC 命令的主服务器会调用BGSAVE 命令，创建一个 RDB 文件，并使用缓冲区记录接下来执行的所有写命令。
3. 当主服务器执行完 BGSAVE 命令时，它会向从服务器发送 RDB 文件，而从服务器则会接收并载入这个文件。
4. 主服务器将缓冲区储存的所有写命令（广播形式）发送给从服务器执行。


-------------
1、在开启主从复制的时候，使用的是RDB方式的，同步主从数据的
2、同步开始之后，通过主库命令传播的方式，主动的复制方式实现
3、2.8以后实现PSYNC的机制，实现断线重连
```

##### 11.2 主从数据一致性保证

```
min-slaves-to-write 1
min-slaves-max-lag 

```

```
这个特性的运作原理：
从服务器以每秒一次的频率 PING 主服务器一次， 并报告复制流的处理情况。
主服务器会记录各个从服务器最后一次向它发送 PING 的时间。

用户可以通过配置， 指定网络延迟的最大值 min-slaves-max-lag ，

以及执行写操作所需的至少从服务器数量 min-slaves-to-write 。

如果至少有 min-slaves-to-write 个从服务器， 并且这些服务器的延迟值都少于 min-slaves-max-lag秒，

那么主服务器就会执行客户端请求的写操作。

你可以将这个特性看作 CAP 理论中的 C 的条件放宽版本： 尽管不能保证写操作的持久性， 
但起码丢失数据的窗口会被严格限制在指定的秒数中。

另一方面， 如果条件达不到 min-slaves-to-write 和 min-slaves-max-lag 所指定的条件， 那么写操作就不会被执行
主服务器会向请求执行写操作的客户端返回一个错误。

```

##### 11.3 主库是否要开启持久化？

```
如果不开有可能，主库重启操作，造成所有主从数据丢失！

解决办法：
down掉的主服务器，不要使用了

```

##### 11.4 主从复制实现

> **1.环境：准备两个或两个以上redis实例**

```mysql
mkdir /data/638{0..2}

配置文件示例：
cat >> /data/6380/redis.conf << EOF 
port 6380
daemonize yes
pidfile /data/6380/redis.pid
loglevel notice
logfile "/data/6380/redis.log"
dbfilename dump.rdb
dir /data/6380
requirepass 123
masterauth 123
EOF

cp /data/6380/redis.conf /data/6381/redis.conf
cp /data/6380/redis.conf /data/6382/redis.conf

sed -i 's#6380#6381#g' /data/6381/redis.conf
sed -i 's#6380#6382#g' /data/6382/redis.conf


启动：
redis-server /data/6380/redis.conf
redis-server /data/6381/redis.conf
redis-server /data/6382/redis.conf

netstat -lnp|grep 638
 
 
主节点：6380
从节点：6381、6382

```

> **2.开启主从**

```mysql
6381/6382命令行:

redis-cli -p 6381 -a 123 SLAVEOF 127.0.0.1 6380
redis-cli -p 6382 -a 123 SLAVEOF 127.0.0.1 6380
```

> **3.查询主从状态**

```
redis-cli -p 6380 -a 123 info replication
redis-cli -p 6381 -a 123 info replication
redis-cli -p 6382 -a 123 info replication

```

> **4.模拟主库故障: 从库切为主库**

```mysql
redis-cli -p 6380 -a 123 shutdown

redis-cli -p 6381 -a 123
info replication
slaveof no one

6382连接到6381：
[root@db03 ~]# redis-cli -p 6382 -a 123
127.0.0.1:6382> SLAVEOF no one
127.0.0.1:6382> SLAVEOF 127.0.0.1 6381
```

##### 11.5 redis-sentinel（哨兵）

> **1.作用**

```
1、监控
2、自动选主，切换（6381 slaveof no one）
3、2号从库（6382）指向新主库（6381）
4、应用透明 

```

> **2.搭建**

```mysql
sentinel搭建过程

mkdir /data/26380
cd /data/26380

cat >> sentinel.conf << EOF
port 26380
dir "/data/26380"
sentinel monitor mymaster 127.0.0.1 6380 1
sentinel down-after-milliseconds mymaster 5000
sentinel auth-pass mymaster 123 
EOF
启动：
redis-sentinel /data/26380/sentinel.conf &
```

> **3.如果有问题**

```python
1、重新准备1主2从环境
2、kill掉sentinel进程
3、删除sentinel目录下的所有文件
4、重新搭建sentinel
```

> **4.停主库测试**

```mysql
停主库测试：

[root@db01 ~]# redis-cli -p 6380 -a 123
shutdown

[root@db01 ~]# redis-cli -p 6381 -a 123
info replication

启动源主库（6380），看状态。


Sentinel管理命令：

redis-cli -p 26380

PING ：返回 PONG 。
SENTINEL masters ：列出所有被监视的主服务器
SENTINEL slaves <master name> 
SENTINEL get-master-addr-by-name <master name> ： 返回给定名字的主服务器的 IP 地址和端口号。 
SENTINEL reset <pattern> ： 重置所有名字和给定模式 pattern 相匹配的主服务器。 
SENTINEL failover <master name> ： 当主服务器失效时， 在不询问其他 Sentinel 意见的情况下， 强制开始一次自动故障迁移。
```

------

#### 12. redis cluster(集群)

##### 12.1 高性能

```python
1、在多分片节点中，将16384个槽位，均匀分布到多个分片节点中

2、存数据时，将key做crc16(key),然后和16384进行取模，得出槽位值（0-16383之间）

3、根据计算得出的槽位值，找到相对应的分片节点的主节点，存储到相应槽位上

4、如果客户端当时连接的节点不是将来要存储的分片节点，分片集群会将客户端连接切换至真正存储节点进行数据存储
```

##### 12.2 高可用

```python
在搭建集群时，会为每一个分片的主节点，对应一个从节点，实现slaveof的功能，同时当主节点down，实现类似于sentinel的自动failover的功能。

1、redis会有多组分片构成（3组）

2、redis cluster 使用固定个数的slot存储数据（一共16384slot）

3、每组分片分得1/3 slot个数（0-5500  5501-11000  11001-16383）

4、基于CRC16(key) % 16384 ====》值 （槽位号）。
```

##### 12.3 规划、搭建过程：

> **1.注意事项**

```python
注：
1.在企业规划中，一个分片的两个分到不同的物理机，防止硬件主机宕机造成的整个分片数据丢失。

2.6个redis实例，一般会放到3台硬件服务器
```

> **2.安装集群插件**

```mysql
EPEL源安装ruby支持
yum install ruby rubygems -y

使用国内源
gem sources -l
gem sources -a http://mirrors.aliyun.com/rubygems/ 
gem sources  --remove https://rubygems.org/
gem sources -l
gem install redis -v 3.3.3
```

> **3.集群节点准备**

```mysql
mkdir /data/700{0..5}

cat >> /data/7000/redis.conf << EOF
port 7000
daemonize yes
pidfile /data/7000/redis.pid
loglevel notice
logfile "/data/7000/redis.log"
dbfilename dump.rdb
dir /data/7000
protected-mode no
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
appendonly yes
EOF

cp /data/7000/redis.conf /data/7001/redis.conf
cp /data/7000/redis.conf /data/7002/redis.conf
cp /data/7000/redis.conf /data/7003/redis.conf
cp /data/7000/redis.conf /data/7004/redis.conf
cp /data/7000/redis.conf /data/7005/redis.conf

sed -i 's#7000#7001#g' /data/7001/redis.conf
sed -i 's#7000#7002#g' /data/7002/redis.conf
sed -i 's#7000#7003#g' /data/7003/redis.conf
sed -i 's#7000#7004#g' /data/7004/redis.conf
sed -i 's#7000#7005#g' /data/7005/redis.conf

启动节点：

redis-server /data/7000/redis.conf 
redis-server /data/7001/redis.conf 
redis-server /data/7002/redis.conf 
redis-server /data/7003/redis.conf 
redis-server /data/7004/redis.conf 
redis-server /data/7005/redis.conf 



[root@db01 ~]# ps -ef |grep redis
root       8854      1  0 03:56 ?        00:00:00 redis-server *:7000 [cluster]     
root       8858      1  0 03:56 ?        00:00:00 redis-server *:7001 [cluster]     
root       8860      1  0 03:56 ?        00:00:00 redis-server *:7002 [cluster]     
root       8864      1  0 03:56 ?        00:00:00 redis-server *:7003 [cluster]     
root       8866      1  0 03:56 ?        00:00:00 redis-server *:7004 [cluster]     
root       8874      1  0 03:56 ?        00:00:00 redis-server *:7005 [cluster] 
```

> **4.将节点加入集群管理**

```mysql
redis-trib.rb create --replicas 1 127.0.0.1:7000 127.0.0.1:7001 \
127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005
```

> **5.集群状态查看**

```mysql
集群主节点状态
redis-cli -p 7000 cluster nodes | grep master
集群从节点状态
redis-cli -p 7000 cluster nodes | grep slave
```

> **6.集群节点管理: 增加新的节点**

```mysql
#1 增加新的节点

mkdir /data/7006
mkdir /data/7007

vim /data/7006/redis.conf
port 7006
daemonize yes
pidfile /data/7006/redis.pid
loglevel notice
logfile "/data/7006/redis.log"
dbfilename dump.rdb
dir /data/7006
protected-mode no
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
appendonly yes


vim /data/7007/redis.conf
port 7007
daemonize yes
pidfile /data/7007/redis.pid
loglevel notice
logfile "/data/7007/redis.log"
dbfilename dump.rdb
dir /data/7007
protected-mode no
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
appendonly yes


redis-server /data/7006/redis.conf 
redis-server /data/7007/redis.conf 

#2 添加主节点：
redis-trib.rb add-node 127.0.0.1:7006 127.0.0.1:7000

#3 转移slot（重新分片）
redis-trib.rb reshard 127.0.0.1:7000

#4 添加一个从节点
redis-trib.rb add-node --slave --master-id 1c98b2b2ce18f88c76821cdb82dba4defaa5eb48 127.0.0.1:7007 127.0.0.1:7000

```

> **7.集群节点管理: 删除一个节点**

```mysql
删除master节点之前首先要使用reshard移除master的全部slot,然后再删除当前节点
redis-trib.rb del-node 127.0.0.1:7006 1c98b2b2ce18f88c76821cdb82dba4defaa5eb48
redis-trib.rb del-node 127.0.0.1:7007 00185d1cf069b23468d5863202ac651f0d02a9f8
```

> **8.设置redis最大内存**

```
config set maxmemory 102400000

```

------

#### 13. redis的多API支持:python为例

##### 13.1 软件驱动下载

```python
https://redis.io/clients

下载redis-py-master.zip


1.安装驱动redis-py-master：

unzip redis-py-master.zip

cd redis-py-master
python3 setup.py install


2.安装redis-cluser的客户端程序

cd redis-py-cluster-unstable
python3 setup.py install

```

##### 13.2  对redis的单实例进行连接操作

```python
python3
>>>import redis
>>>r = redis.StrictRedis(host='10.0.0.100', port=6379, db=0,password='123')
>>>r.set('foo', 'bar')
True
>>>r.get('foo')
'bar'
```

##### 13.3   sentinel集群连接并操作

```mysql
1. 服务和sentinel服务开启
[root@db01 ~]# redis-server /data/6380/redis.conf
[root@db01 ~]# redis-server /data/6381/redis.conf
[root@db01 ~]# redis-server /data/6382/redis.conf 
[root@db01 ~]# redis-sentinel /data/26380/sentinel.conf &
```

```python
## 导入redis sentinel包
>>>from redis.sentinel import Sentinel  
##指定sentinel的地址和端口号
>>> sentinel = Sentinel([('localhost', 26380)], socket_timeout=0.1)  
##测试，获取以下主库和从库的信息
>>> sentinel.discover_master('mymaster')  
>>> sentinel.discover_slaves('mymaster')  

##配置读写分离
#写节点
>>> master = sentinel.master_for('mymaster', socket_timeout=0.1,password="123")  
#读节点
>>> slave = sentinel.slave_for('mymaster', socket_timeout=0.1,password="123")  
###读写分离测试   key     
>>> master.set('oldboy', '123')  
>>> slave.get('oldboy')  
'123'
```

##### 13.4  [redis cluster的连接并操作（python2.7.2以上版本才支持redis cluster，我们选择的是3.5）](https://github.com/Grokzen/redis-py-cluster)

```python
python3
>>> from rediscluster import StrictRedisCluster  
>>> startup_nodes = [{"host": "127.0.0.1", "port": "7000"},{"host": "127.0.0.1", "port": "7001"},{"host": "127.0.0.1", "port": "7002"}]  
### Note: decode_responses must be set to True when used with python3  
>>> rc = StrictRedisCluster(startup_nodes=startup_nodes, decode_responses=True)  
>>> rc.set("foo0000", "bar0000")  
True  
>>> print(rc.get("foo0000"))  
'bar'
```

------

#### 14. redis可能会出现的问题

##### 14.1 缓存穿透

> **1.概念**

```
访问一个不存在的key，缓存不起作用，请求会穿透到DB，流量大时DB会挂掉。

```

> **2.解决方案**

```python
1.采用部署过滤器，使用一个足够大的bitmap，用于存储可能访问的key，不存在的key直接被过滤；

2.访问key未在DB查询到值，也将空值写进缓存，但可以设置较短过期时间。
```

##### 14.2 缓存雪崩

> **1.概念**

```
大量的key设置了相同的过期时间，导致在缓存在同一时刻全部失效，造成瞬时DB请求量大、压力骤增，引起雪崩。

```

> **2.解决方案**

```
可以给缓存设置过期时间时加上一个随机值时间，使得每个key的过期时间分布开来，不会集中在同一时刻失效。

```

##### 14.3 缓存击穿

> **1.概念**

```
在访问key之前，在缓存过期的一刻，同时有大量的请求，这些请求都会击穿到DB，造成瞬时DB请求量大、压力骤增。

```

> **2.解决方案**

```
在访问key之前，采用SETNX（set if not exists）来设置另一个短期key来锁住当前key的访问，访问结束再删除该短期key。
```

