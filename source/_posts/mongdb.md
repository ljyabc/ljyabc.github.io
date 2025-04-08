---
title: mongodb
tags: [mongodb]
date: 2019-03-31 13:30:10
categories: 整理
photos:
book:
---

# 三. Mongodb核心技术

#### 1. 逻辑结构

|  Mongodb 逻辑结构  | MySQL逻辑结构 |
| :----------------: | :-----------: |
|    库(database)    |      库       |
| 集合（collection） |      表       |
|  文档（document）  |    数据行     |

#### 2. 安装部署

##### 2.1 系统准备

```python
（1）redhat或cnetos6.2以上系统
（2）系统开发包完整
（3）ip地址和hosts文件解析正常
（4）iptables防火墙&SElinux关闭
（5）关闭大页内存机制
```

##### 2.2 关闭大页内存机制

```mysql
1.root用户下
在vi /etc/rc.local最后添加如下代码


cat >>/etc/rc.local <<EOF
if test -f /sys/kernel/mm/transparent_hugepage/enabled; then
  echo never > /sys/kernel/mm/transparent_hugepage/enabled
fi
if test -f /sys/kernel/mm/transparent_hugepage/defrag; then
   echo never > /sys/kernel/mm/transparent_hugepage/defrag
fi
EOF

2.生效取消大页内存
[root@standby opt]# echo never > /sys/kernel/mm/transparent_hugepage/enabled

[root@standby opt]# echo never > /sys/kernel/mm/transparent_hugepage/defrag
```

##### 2.3 MongoDB安装

```python
1.创建所需的用户和组：wan1314520
groupadd -g 800 mongod
useradd -u 801 -g mongod mongod
passwd mongod

2.创建MongoDB所需的目录结构
mkdir -p /mongodb/bin
mkdir -p /mongodb/conf
mkdir -p /mongodb/log
mkdir -p /mongodb/data

3.上传并解压软件到指定位置
上传到：
cd   /opt/
解压：
tar xf mongodb-linux-x86_64-rhel70-3.4.16.tgz

拷贝目录下bin程序到/mongodb/bin
cp -a /opt/mongodb-linux-x86_64-rhel70-3.4.16/bin/* /mongodb/bin

4.设置目录结构权限
chown -R mongod:mongod /mongodb

5.设置用户环境变量
su - mongod             #切换到mongod用户

cat >> .bash_profile << EOF         #加入环境变量
export PATH=/mongodb/bin:$PATH
EOF

source .bash_profile                #生效配置

6.启动MongoDB
mongod --dbpath=/mongodb/data --logpath=/mongodb/log/mongodb.log --port=27017 --logappend --fork

7.登录MongoDB
mongo

8.使用配置文件
vim /mongodb/conf/mongodb.conf

logpath=/mongodb/log/mongodb.log
dbpath=/mongodb/data 
port=27017
logappend=true
fork=true

+++++++++++++++++++
关闭mongodb
mongod -f /mongodb/conf/mongodb.conf --shutdown
使用配置文件启动mongodb
mongod -f /mongodb/conf/mongodb.conf

9.MongoDB的关闭方式
mongod -f mongodb.conf  --shutdown

```

```
注：连接之后会有warning，需要修改(使用root用户)
vim /etc/security/limits.conf 
#*       -       nofile       65535 

reboot重启生效

```

##### 2.4 YAML模式：非常经典的专门用作配置文件的格式

> **1. 一定不能出现有tab空格，不然解析不了**

> **2. 配置的介绍**

```python
--系统日志有关  
systemLog:
   destination: file        
   path: "/mongodb/log/mongodb.log"    --日志位置
   logAppend: true					   --日志以追加模式记录

--数据存储有关   
storage:
   journal:
      enabled: true
   dbPath: "/mongodb/data"            --数据路径的位置
   
 -- 进程控制  
processManagement:
   fork: true                         --后台守护进程
   pidFilePath: <string>			  --pid文件的位置，一般不用配置，可以去掉这行，自动生成到data中
   
   
--网络配置有关   
net:			
   bindIp: <ip>                       -- 监听地址，如果不配置这行是监听在0.0.0.0
   port: <port>						  -- 端口号,默认不配置端口号，是27017
   
-- 安全验证有关配置      #一定有用户的才能打开
security:
  authorization: enabled              --是否打开用户名密码验证
```

> **3. 复制集相关配置**

```python
replication:
 oplogSizeMB: <NUM>
 replSetName: "<REPSETNAME>"
 secondaryIndexPrefetch: "all"
sharding:
   clusterRole: <string>
   archiveMovedChunks: <boolean>
   
   
---for mongos only
replication:
   localPingThresholdMs: <int>

sharding:
   configDB: <string>
---
```

> **4. YAML例子**

```mysql
cat >> /mongodb/conf/mongo.conf << EOF
systemLog:
   destination: file
   path: "/mongodb/log/mongodb.log"
   logAppend: true
storage:
   journal:
      enabled: true
   dbPath: "/mongodb/data/"
processManagement:
   fork: true
net:
   port: 27017
EOF
   
   
mongod -f /mongodb/conf/mongo.conf --shutdown
mongod -f /mongodb/conf/mongo.conf   

```

------

#### 3. MongoDB常用的基本操作

##### 3.1 mongodb 默认存在的库

```python
1.登录后默认使用的库
test:
	登录时默认存在的库

2.管理mongodb有关的系统库
admin库:
	系统预留库,mongodb系统管理库
local库:
	本地预留库,存储关键日志
```

##### 3.2 命令分类

###### 3.2.1 逻辑对象

```
库(database)
show  databases 
show  dbs
use   oldguo
db

表(collection集合)
show tables
show collections

数据行(document)

```

##### 3.3 db.命令

###### 3.3.1 DB级别命令

```python
DB级别命令
db.[TAB]  类似于linux中的tab功能
db.help() db级别的命令使用帮助

collection级别操作
db.Collection_name.xxx

document级别操作:
db.t1.insert()
```

##### 3.4 复制集有关(replication set)

```
rs.

```

##### 3.5 分片集群(sharding cluster)

```
sh.

```

##### 3.6 常用操作

```mysql
--查看当前db版本
test> db.version()

--显示当前数据库

test> db
test
或
> db.getName()
test

--查询所有数据库
test> show dbs

– 切换数据库
> use local
switched to db local

- 查看所有的collection
show  tables;

– 显示当前数据库状态
test> use local
switched to db local

local> db.stats()


– 查看当前数据库的连接机器地址


> db.getMongo()
connection to 127.0.0.1
指定数据库进行连接
默认连接本机test数据库
```

##### 3.7 库的操作

```mysql
– 创建数据库：
当use的时候，系统就会自动创建一个数据库。
如果use之后没有创建任何集合。
系统就会删除这个数据库。

– 删除数据库
如果没有选择任何数据库，会删除默认的test数据库
//删除test数据库

test> show dbs
local 0.000GB
test 0.000GB

test> use test
switched to db test
test> db.dropDatabase()
{ "dropped" : "test", "ok" : 1 }
```

##### 3.8 集合的操作

```mysql
方法1
admin> use app
switched to db app
app> db.createCollection('a')
{ "ok" : 1 }
app> db.createCollection('b')
{ "ok" : 1 }
> show collections //查看当前数据下的所有集合
a b 或
> db.getCollectionNames()
[ "a", "b" ]

方法2：当插入一个文档的时候，一个集合就会自动创建。

 use oldguo
 db.test.insert({name:"zhangsan"})
 db.stu.insert({id:101,name:"zhangsan",age:20,gender:"m"})
 show tables;
 db.stu.insert({id:102,name:"lisi"})
 db.stu.insert({a:"b",c:"d"})
 db.stu.insert({a:1,c:2})
 
查询数据:
> db.stu.find({}).pretty()
db.stu.find({id:101}).pretty();
{
	"_id" : ObjectId("5b470168cfdebc16a5a82a97"),
	"id" : 101,
	"name" : "zhangsan",
	"age" : 20,
	"gender" : "m"
}

删除数据：
> show tables;
stu
test
> db.test.drop()
true
> show tables;
stu

重命名集合
//把log改名为log1
app> db.log.renameCollection("log1")
{ "ok" : 1 }
app> show collections
a b c
log1
app

批量插入数据
for(i=0;i<10000;i++){db.log.insert({"uid":i,"name":"mongodb","age":6,"date":new
Date()})}
```

#### 4. Mongodb数据查询语句

##### 4.1 查询集合中的记录数

```mysql
app> db.log.find() //查询所有记录

注：默认每页显示20条记录，当显示不下的的情况下，可以用it迭代命令查询下一页数据。
设置每页显示数据的大小：

> DBQuery.shellBatchSize=50; //每页显示50条记录

app> db.log.findOne() //查看第1条记录
app> db.log.count() //查询总的记录数
```

##### 4.2 删除集合中的记录数

```mysql
app> db.log.remove({}) //删除集合中所有记录
> db.log.distinct("name") //查询去掉当前集合中某列的重复数据
```

##### 4.3 查看集合存储信息

```mysql
app> db.log.stats()
app> db.log.dataSize() //集合中数据的原始大小
app> db.log.totalIndexSize() //集合中索引数据的原始大小
app> db.log.totalSize() //集合中索引+数据压缩存储之后的大小
app> db.log.storageSize() //集合中数据压缩存储的大小
```

------

#### 5.  用户管理

```
验证库，建立用户时use到的库，在使用用户时，要加上验证库才能登陆。
对于管理员用户,必须在admin下创建.

```

##### 5.1 基本语法

```mysql
use admin 
{
    user: "<name>",
    pwd: "<cleartext password>",
    roles: [
       { role: "<role>",
     db: "<database>" } | "<role>",
    ...
    ]
}
```

##### 5.2 基本语法说明

```
基本语法说明：

user:用户名
pwd:密码
roles:
    role:角色名
    db:作用对象
	
role：root, readWrite,read   

验证数据库：

mongo -u oldguo -p 123 10.0.0.200/oldguo
总结：
1、在创建普通用户时，一般事先use 到想要设置权限的库下；或者所有普通用户使用同一个验证库，比如test
2、root角色的创建，要在admin下进行创建
3、创建用户时你use到的库，在将来登录时候，使用以下方式登录,否则是登录不了的

```

##### 5.3 验证数据库

```mysql
mongo -u oldguo -p 123 10.0.0.200/oldguo

总结：
1、在创建普通用户时，一般事先use 到想要设置权限的库下；或者所有普通用户使用同一个验证库，比如test
2、root角色的创建，要在admin下进行创建
3、创建用户时你use到的库，在将来登录时候，使用以下方式登录,否则是登录不了的
```

##### 5.4 用户管理的例子：创建超级管理员

###### 5.4.1 创建超级管理员：管理所有的数据库（必须use admin 再去创建）

```mysql
use admin

db.createUser(
{
    user: "root",
    pwd: "root123",
    roles: [ { role: "root", db: "admin" } ]
}
)
```

###### 5.4.2 验证用户

```mysql
db.auth('root','root123')
```

###### 5.4.3 配置文件中，加入以下配置（开启密码认证）

```mysql
security:
  authorization: enabled
```

###### 5.4.4 重启MongoDB

```mysql
mongod -f /mongodb/conf/mongo.conf --shutdown 
mongod -f /mongodb/conf/mongo.conf 
```

###### 5.4.5 登录验证

> **1.方式一**

```mysql
[mongod@zcg conf]$ mongo -uroot -proot123 admin

[mongod@zcg conf]$ mongo -uroot -proot123 10.0.0.100/admin
```

> **2.方式二**

```
mongo
use admin
db.auth('root','root123')

查看用户:
use admin
db.system.users.find().pretty()

```

##### 5.5 用户管理的例子：创建库管理用户

###### 5.5.1 首先root用户登录

```
mongo -uroot -proot123  admin

```

###### 5.5.2 创建库

```
use app

```

###### 5.5.3 创建库管理用户

```mysql
db.createUser(
{
user: "admin",
pwd: "admin",
roles: [ { role: "dbAdmin", db: "app" } ]
}
)
```

###### 5.5.4 验证

```
db.auth('admin','admin')

```

###### 5.5.5 登录测试

```
mongo -uadmin -padmin 10.0.0.100/app

```

##### 5.6 创建对app数据库，读、写权限的用户app01

###### 5.6.1 超级管理员登录

```
mongo -uroot -proot123 admin

```

###### 5.6.2 选择一个验证库

```
use app

```

###### 5.6.3 创建用户

```
db.createUser(
	{
		user: "app01",
		pwd: "app01",
		roles: [ { role: "readWrite" , db: "app" } ]
	}
)

```

###### 5.6.4 登录

```
mongo  -uapp01 -papp01 app

```

##### 5.7 创建app数据库读写权限的用户并对test数据库具有读权限

```
mongo -uroot -proot123 10.0.0.200/admin
use app
db.createUser(
{
user: "app03",
pwd: "app03",
roles: [ { role: "readWrite", db: "app" },
{ role: "read", db: "test" }
]
}
)

```

##### 5.8 查询MongoDB中的用户信息

```
mongo -uroot -proot123 10.0.0.200/admin
db.system.users.find().pretty()

```

##### 5.9 删除用户（root身份登录，use到验证库）

```mysql
# mongo -uroot -proot123 10.0.0.200/admin
use app
db.dropUser("app01")
```

------

#### 6. mongodb复制集RS

##### 6.1 基本原理

```
基本构成是1主2从的结构，自带互相监控投票机制（Raft（MongoDB）  Paxos（mysql MGR 用的是变种））
如果发生主库宕机，复制集内部会进行投票选举，选择一个新的主库替代原有主库对外提供服务。同时复制集会自动通知
客户端程序，主库已经发生切换了。应用就会连接到新的主库。

```

##### 6.2 Replcation Set配置过程详解

###### 6.2.1 规划

```mysql
1.三个以上的mongodb节点（或多实例）
多实例
（1）多个端口：28017、28018、28019、28020
（2）多套目录：
mkdir -p /mongodb/28017/conf /mongodb/28017/data /mongodb/28017/log
mkdir -p /mongodb/28018/conf /mongodb/28018/data /mongodb/28018/log
mkdir -p /mongodb/28019/conf /mongodb/28019/data /mongodb/28019/log
mkdir -p /mongodb/28020/conf /mongodb/28020/data /mongodb/28020/log

(3) 多套配置文件
配置文件内容:
cat >>/mongodb/28017/conf/mongod.conf << EOF
systemLog:
  destination: file
  path: /mongodb/28017/log/mongodb.log
  logAppend: true
storage:
  journal:
    enabled: true
  dbPath: /mongodb/28017/data
  directoryPerDB: true
  #engine: wiredTiger
  wiredTiger:
    engineConfig:
      cacheSizeGB: 1
      directoryForIndexes: true
    collectionConfig:
      blockCompressor: zlib
    indexConfig:
      prefixCompression: true
processManagement:
  fork: true
net:
  port: 28017
replication:
  oplogSizeMB: 2048
  replSetName: my_repl
EOF		

cp  /mongodb/28017/conf/mongod.conf  /mongodb/28018/conf/
cp  /mongodb/28017/conf/mongod.conf  /mongodb/28019/conf/
cp  /mongodb/28017/conf/mongod.conf  /mongodb/28020/conf/

sed 's#28017#28018#g' /mongodb/28018/conf/mongod.conf -i
sed 's#28017#28019#g' /mongodb/28019/conf/mongod.conf -i
sed 's#28017#28020#g' /mongodb/28020/conf/mongod.conf -i

(5)启动多个实例备用
mongod -f /mongodb/28017/conf/mongod.conf
mongod -f /mongodb/28018/conf/mongod.conf
mongod -f /mongodb/28019/conf/mongod.conf
mongod -f /mongodb/28020/conf/mongod.conf

(6) 查看开启状态
netstat -lnp|grep 280
```

###### 6.2.2 配置复制集：一主两从（从库在默认情况下，只是实现了高可用，并没有实现高性能）

```mysql
1.随便登录其中一个节点
mongo --port 28017 admin

2.配置复制集
config = {_id: 'my_repl', members: [
                          {_id: 0, host: '10.0.0.100:28017'},
                          {_id: 1, host: '10.0.0.100:28018'},
                          {_id: 2, host: '10.0.0.100:28019'}]
          }
3.生效配置文件   		  
rs.initiate(config) 

4.查询复制集状态
rs.status()
```

###### 6.2.2 一主一从一个仲裁者

```mysql
mongo -port 28017 admin

config = {_id: 'my_repl', members: [
                          {_id: 0, host: '10.0.0.100:28017'},
                          {_id: 1, host: '10.0.0.100:28018'},
                          {_id: 2, host: '10.0.0.100:28019',"arbiterOnly":true}]
          }
                   
rs.initiate(config) 
```

###### 6.2.3 删除一个节点

```mysql
rs.remove("ip:port"); // 删除一个节点

例子：
my_repl:PRIMARY> rs.remove("10.0.0.100:28019");
{ "ok" : 1 }
my_repl:PRIMARY> rs.isMaster()
```

###### 6.2.4 新增一个节点

```mysql
rs.add("ip:port"); // 新增从节点

例子：
my_repl:PRIMARY> rs.add("10.0.0.100:28019")
{ "ok" : 1 }
my_repl:PRIMARY> rs.isMaster()
```

**<font color=#DC143C>注意</font>**

```mysql
添加特殊节点时，
1>可以在搭建过程中设置特殊节点
2>可以通过修改配置的方式将普通从节点设置为特殊节点 
/*找到需要改为延迟性同步的数组号*/;
```

##### 6.3 配置特殊节点

###### 6.3.1 特殊节点

```python
1.投票使用的
arbiter节点：主要负责选主过程中的投票，但是不存储任何数据，也不提供任何服务

2.数据恢复使用的
hidden节点：隐藏节点，不参与选主，也不对外提供服务。   #主要用来备份

3.处理删库使用的
delay节点：延时节点，数据落后于主库一段时间，因为数据是延时的，也不应该提供服务或参与选主，所以通常会配合hidden（隐藏） --#处理逻辑故障  删库
```

**<font color=#DC143C>注意: 一般情况下会将delay+hidden一起配置使用</font>**

###### 6.3.2 配置延时节点（一般延时节点也配置成hidden）

```mysql
cfg=rs.conf() 
cfg.members[0].priority=0
cfg.members[0].hidden=true
cfg.members[0].slaveDelay=120
rs.reconfig(cfg)    
----------------------
cfg=rs.conf() 
cfg.members[3].priority=0
cfg.members[3].hidden=true
cfg.members[3].slaveDelay=120
rs.reconfig(cfg)    


---------------------------
取消以上配置
cfg=rs.conf() 
cfg.members[3].priority=1
cfg.members[3].hidden=false
cfg.members[3].slaveDelay=0
rs.reconfig(cfg)    
--------------------------------

配置成功后，通过以下命令查询配置后的属性
rs.conf(); 
```

###### 6.3.3 副本集其他操作命令

```mysql
--查看副本集的配置信息
admin> rs.config()
或者
admin> rs.conf()

--查看副本集各成员的状态
admin> rs.status()
++++++++++++++++++++++++++++++++++++++++++++++++
--副本集角色切换（不要人为随便操作）
admin> rs.stepDown()
注：
admin> rs.freeze(300) //锁定从，使其不会转变成主库
freeze()和stepDown单位都是秒。
+++++++++++++++++++++++++++++++++++++++++++++
--设置副本节点可读：在副本节点执行
admin> rs.slaveOk()

eg：
admin> use app
switched to db app
app> db.createCollection('a')
{ "ok" : 0, "errmsg" : "not master", "code" : 10107 }

--查看副本节点（监控主从延时）
admin> rs.printSlaveReplicationInfo()
source: 192.168.1.22:27017
	syncedTo: Thu May 26 2016 10:28:56 GMT+0800 (CST)
	0 secs (0 hrs) behind the primary
```

**<font color=#DC143C>注意: OPlog日志（备份恢复章节）</font>**

------

#### 7. MongoDB Sharding Cluster 分片集群

##### 7.1 规划

```
10个实例：38017-38026

```

###### 7.1.1 configserver

```
3台构成的复制集（1主两从，不支持arbiter）38018-38020（复制集名字configsvr）

```

###### 7.1.2 shard节点

```
shard1：38021-23    （1主两从，其中一个节点为arbiter，复制集名字shard1）
shard2：38024-26    （1主两从，其中一个节点为arbiter，复制集名字shard2）

```

------

##### 7.2 分片集群配置过程

###### 7.2.1 shard复制集配置

> **1.目录创建**

```mysql
mkdir -p /mongodb/38021/conf  /mongodb/38021/log  /mongodb/38021/data
mkdir -p /mongodb/38022/conf  /mongodb/38022/log  /mongodb/38022/data
mkdir -p /mongodb/38023/conf  /mongodb/38023/log  /mongodb/38023/data
mkdir -p /mongodb/38024/conf  /mongodb/38024/log  /mongodb/38024/data
mkdir -p /mongodb/38025/conf  /mongodb/38025/log  /mongodb/38025/data
mkdir -p /mongodb/38026/conf  /mongodb/38026/log  /mongodb/38026/data
```

> **2.修改配置文件**

```mysql
1.shard1

cat >> /mongodb/38021/conf/mongodb.conf <<EOF
systemLog:
  destination: file
  path: /mongodb/38021/log/mongodb.log   
  logAppend: true
storage:
  journal:
    enabled: true
  dbPath: /mongodb/38021/data
  directoryPerDB: true
  #engine: wiredTiger
  wiredTiger:
    engineConfig:
      cacheSizeGB: 1
      directoryForIndexes: true
    collectionConfig:
      blockCompressor: zlib
    indexConfig:
      prefixCompression: true
net:
  port: 38021
replication:
  oplogSizeMB: 2048
  replSetName: sh1
sharding:
  clusterRole: shardsvr
processManagement: 
  fork: true
EOF



cp  /mongodb/38021/conf/mongodb.conf  /mongodb/38022/conf/
cp  /mongodb/38021/conf/mongodb.conf  /mongodb/38023/conf/

sed 's#38021#38022#g' /mongodb/38022/conf/mongodb.conf -i
sed 's#38021#38023#g' /mongodb/38023/conf/mongodb.conf -i

```

```python
2.shard2

cat >> /mongodb/38024/conf/mongodb.conf << EOF
systemLog:
  destination: file
  path: /mongodb/38024/log/mongodb.log   
  logAppend: true
storage:
  journal:
    enabled: true
  dbPath: /mongodb/38024/data
  directoryPerDB: true
  wiredTiger:
    engineConfig:
      cacheSizeGB: 1
      directoryForIndexes: true
    collectionConfig:
      blockCompressor: zlib
    indexConfig:
      prefixCompression: true
net:
  port: 38024
replication:
  oplogSizeMB: 2048
  replSetName: sh2
sharding:
  clusterRole: shardsvr
processManagement: 
  fork: true
EOF

cp  /mongodb/38024/conf/mongodb.conf  /mongodb/38025/conf/
cp  /mongodb/38024/conf/mongodb.conf  /mongodb/38026/conf/
sed 's#38024#38025#g' /mongodb/38025/conf/mongodb.conf -i
sed 's#38024#38026#g' /mongodb/38026/conf/mongodb.conf -i
```

> **3.启动所有的节点，并搭建复制集**

```
mongod -f  /mongodb/38021/conf/mongodb.conf 
mongod -f  /mongodb/38022/conf/mongodb.conf 
mongod -f  /mongodb/38023/conf/mongodb.conf 
mongod -f  /mongodb/38024/conf/mongodb.conf 
mongod -f  /mongodb/38025/conf/mongodb.conf 
mongod -f  /mongodb/38026/conf/mongodb.conf  

```

```mysql
mongo --port 38021

use  admin
config = {_id: 'sh1', members: [
                          {_id: 0, host: '10.0.0.100:38021'},
                          {_id: 1, host: '10.0.0.100:38022'},
                          {_id: 2, host: '10.0.0.100:38023',"arbiterOnly":true}]
           }

rs.initiate(config)
```

```python
mongo --port 38024 
use admin
config = {_id: 'sh2', members: [
                          {_id: 0, host: '10.0.0.100:38024'},
                          {_id: 1, host: '10.0.0.100:38025'},
                          {_id: 2, host: '10.0.0.100:38026',"arbiterOnly":true}]
           }
  
rs.initiate(config)
```

------

##### 7.3 config节点配置

###### 7.3.1 目录创建

```
mkdir -p /mongodb/38018/conf  /mongodb/38018/log  /mongodb/38018/data
mkdir -p /mongodb/38019/conf  /mongodb/38019/log  /mongodb/38019/data
mkdir -p /mongodb/38020/conf  /mongodb/38020/log  /mongodb/38020/data

```

###### 7.3.2 修改配置文件

```mysql
cat >> /mongodb/38018/conf/mongodb.conf << EOF
systemLog:
  destination: file
  path: /mongodb/38018/log/mongodb.conf
  logAppend: true
storage:
  journal:
    enabled: true
  dbPath: /mongodb/38018/data
  directoryPerDB: true
  #engine: wiredTiger
  wiredTiger:
    engineConfig:
      cacheSizeGB: 1
      directoryForIndexes: true
    collectionConfig:
      blockCompressor: zlib
    indexConfig:
      prefixCompression: true
net:
  port: 38018
replication:
  oplogSizeMB: 2048
  replSetName: configReplSet
sharding:
  clusterRole: configsvr
processManagement: 
  fork: true
EOF

cp /mongodb/38018/conf/mongodb.conf /mongodb/38019/conf/
cp /mongodb/38018/conf/mongodb.conf /mongodb/38020/conf/
sed 's#38018#38019#g' /mongodb/38019/conf/mongodb.conf -i
sed 's#38018#38020#g' /mongodb/38020/conf/mongodb.conf -i
```

###### 7.3.3 启动节点，并配置复制集

> **1.启动节点**

```
mongod -f /mongodb/38018/conf/mongodb.conf 
mongod -f /mongodb/38019/conf/mongodb.conf 
mongod -f /mongodb/38020/conf/mongodb.conf 

```

> **2.配置复制集**

```mysql
mongo --port 38018
use  admin

config = {_id: 'configReplSet', members: [
                          {_id: 0, host: '10.0.0.100:38018'},
                          {_id: 1, host: '10.0.0.100:38019'},
                          {_id: 2, host: '10.0.0.100:38020'}]
           }
rs.initiate(config)  
```

**<font color=#DC143C>注意: </font>**

```
注：configserver 可以是一个节点，官方建议复制集。configserver不能有arbiter。
新版本中，要求必须是复制集。
注：mongodb 3.4之后，虽然要求config server为replica set，但是不支持arbiter

```

------

##### 7.4 mongos节点配置

###### 7.4.1 创建目录

```
mkdir -p /mongodb/38017/conf  /mongodb/38017/log

```

###### 7.4.2 配置文件

```mysql
cat >> /mongodb/38017/conf/mongos.conf <<EOF
systemLog:
  destination: file
  path: /mongodb/38017/log/mongos.log
  logAppend: true
net:
  port: 38017
sharding:
  configDB: configReplSet/10.0.0.100:38018,10.0.0.100:38019,10.0.0.100:38020
processManagement: 
  fork: true
EOF
```

###### 7.4.2 启动mongos

```
mongos -f /mongodb/38017/conf/mongos.conf 

```

##### 7.5 range 分片配置及测试

###### 7.5.1 激活数据库分片功能

```mysql
mongo --port 38017 admin

admin>  ( { enablesharding : "数据库名称" } )

eg：
admin> db.runCommand( { enablesharding : "test" } )
```

###### 7.5.2 指定分片建对集合分片

```mysql
eg：范围片键
--创建索引
use test
> db.vast.ensureIndex( { id: 1 } )

--开启分片
use admin
> db.runCommand( { shardcollection : "test.vast",key : {id: 1} } )
```

###### 7.5.3 集合分片验证

```python
admin> use test

test> for(i=1;i<500000;i++){ db.vast.insert({"id":i,"name":"shenzheng","age":70,"date":new Date()}); }

test> db.vast.stats()
```

###### 7.5.4 分片结果测试(连接到分片的主节点)

```python
shard1:
mongo --port 38021
db.vast.count();


shard2:
mongo --port 38024
db.vast.count();
```

##### 7.6 Hash分片例子

###### 7.6.1 对于oldguo开启分片功能

```
mongo --port 38017 admin
use admin
admin> db.runCommand( { enablesharding : "oldguo" } )

```

###### 7.6.2 对于oldguo库下的vast表建立hash索引

```
use oldguo
oldguo> db.vast.ensureIndex( { id: "hashed" } )

```

###### 7.6.3 开启分片

```msyql
use admin
admin > sh.shardCollection( "oldguo.vast", { id: "hashed" } )
```

###### 7.6.4 录入10w行数据测试

```mysql
use oldguo
for(i=1;i<=100000;i++){ db.vast.insert({"id":i,"name":"shenzheng","age":70,"date":new Date()}); }
```

###### 7.6.5 hash分片结果测试

```mysql
mongo --port 38021
use oldguo
db.vast.count();

mongo --port 38024
use oldguo
db.vast.count();
```

##### 7.7 判断是否是shard集群

```
admin> db.runCommand({ isdbgrid : 1})

```

##### 7.8 列出所有分片信息

```
admin> db.runCommand({ listshards : 1})

```

##### 7.9 列出开启分片的数据库

```
admin> use config

config> db.databases.find( { "partitioned": true } )
或者：
config> db.databases.find() //列出所有数据库分片情况

```

##### 8.0 查看分片的片键

```mysql
config> db.collections.find().pretty()
{
	"_id" : "test.vast",
	"lastmodEpoch" : ObjectId("58a599f19c898bbfb818b63c"),
	"lastmod" : ISODate("1970-02-19T17:02:47.296Z"),
	"dropped" : false,
	"key" : {
		"id" : 1
	},
	"unique" : false
}
```

##### 8.1 查看分片的详细信息

```
admin> db.printShardingStatus()
或
admin> sh.status()

```

##### 8.2 删除分片节点（谨慎）

```
（1）确认blance是否在工作
sh.getBalancerState()

（2）删除shard2节点(谨慎)
mongos> db.runCommand( { removeShard: "shard2" } )

注意：删除操作一定会立即触发blancer。

```

##### 8.3 balancer操作

```
介绍：
mongos的一个重要功能，自动巡查所有shard节点上的chunk的情况，自动做chunk迁移。
什么时候工作？
1、自动运行，会检测系统不繁忙的时候做迁移
2、在做节点删除的时候，立即开始迁移工作
3、balancer只能在预设定的时间窗口内运行

有需要时可以关闭和开启blancer（备份的时候）
mongos> sh.stopBalancer()
mongos> sh.startBalancer()

```

##### 8.4 自定义 自动平衡进行的时间段

```mysql
https://docs.mongodb.com/manual/tutorial/manage-sharded-cluster-balancer/#schedule-the-balancing-window
// connect to mongos

use config
sh.setBalancerState( true )

db.settings.update({ _id : "balancer" }, { $set : { activeWindow : { start : "3:00", stop : "5:00" } } }, true )

sh.getBalancerWindow()
sh.status()
```

```
关于集合的balance（了解下）

关闭某个集合的balance
sh.disableBalancing("students.grades")
打开某个集合的balance
sh.enableBalancing("students.grades")
确定某个集合的balance是开启或者关闭
db.getSiblingDB("config").collections.findOne({_id : "students.grades"}).noBalance;

```

------

#### 8. 备份恢复

##### 8.1 备份恢复工具介绍

```
（1）**   mongoexport/mongoimport
（2）***** mongodump/mongorestore

```

##### 8.2 备份工具区别在哪里

```python
2.1.	mongoexport/mongoimport  导入/导出的是JSON格式或者CSV格式，
		mongodump/mongorestore导入/导出的是BSON格式。
		
2.2.	JSON可读性强但体积较大，BSON则是二进制文件，体积小但对人类几乎没有可读性。

2.3.	在一些mongodb版本之间，BSON格式可能会随版本不同而有所不同，所以不同版本之间用mongodump/mongorestore可能不会成功，
		具体要看版本之间的兼容性。当无法使用BSON进行跨版本的数据迁移的时候，
		使用JSON格式即mongoexport/mongoimport是一个可选项。
		跨版本的mongodump/mongorestore个人并不推荐，实在要做请先检查文档看两个版本是否兼容（大部分时候是的）。

2.4.	JSON虽然具有较好的跨版本通用性，但其只保留了数据部分，不保留索引，账户等其他基础信息。使用时应该注意。


mongoexport/mongoimport:json csv 
1、异构平台迁移  mysql  <---> mongodb
2、同平台，跨大版本：mongodb 2  ----> mongodb 3
```

##### 8.3 导出工具mongoexport

```
Mongodb中的mongoexport工具可以把一个collection导出成JSON格式或CSV格式的文件。
可以通过参数指定导出的数据项，也可以根据指定的条件导出数据。
（1）版本差异较大
（2）异构平台数据迁移


mongoexport具体用法如下所示：

$ mongoexport --help  
参数说明：
-h:指明数据库宿主机的IP

-u:指明数据库的用户名

-p:指明数据库的密码

-d:指明数据库的名字

-c:指明collection的名字

-f:指明要导出那些列

-o:指明到要导出的文件名

-q:指明导出数据的过滤条件

--authenticationDatabase admin


1.单表备份至json格式
mongoexport -uroot -proot123 --port 27017 --authenticationDatabase admin -d oldguo -c log -o /mongodb/log.json


注：备份文件的名字可以自定义，默认导出了JSON格式的数据。

2. 单表备份至csv格式
如果我们需要导出CSV格式的数据，则需要使用----type=csv参数：

 mongoexport -uroot -proot123 --port 27017 --authenticationDatabase admin -d oldguo -c log --type=csv -f uid,name,age,date  -o /mongodb/log.csv

二、导入工具mongoimport
Mongodb中的mongoimport工具可以把一个特定格式文件中的内容导入到指定的collection中。该工具可以导入JSON格式数据，也可以导入CSV格式数据。具体使用如下所示：
$ mongoimport --help
参数说明：
-h:指明数据库宿主机的IP

-u:指明数据库的用户名

-p:指明数据库的密码

-d:指明数据库的名字

-c:指明collection的名字

-f:指明要导入那些列

-j, --numInsertionWorkers=<number>  number of insert operations to run concurrently                                                  (defaults to 1)
//并行

```

##### 8.4 数据恢复

```mysql
1.恢复json格式表数据到log
mongoimport -uroot -proot123 --port 27017 --authenticationDatabase admin -d oldguo -c log1 /mongodb/log.json


2.恢复csv格式的文件到log2
上面演示的是导入JSON格式的文件中的内容，如果要导入CSV格式文件中的内容，则需要通过--type参数指定导入格式，具体如下所示：
错误的恢复
```

##### 8.5 注意

```python
注意：
（1）csv格式的文件头行，有列名字
mongoimport   -uroot -proot123 --port 27017 --authenticationDatabase admin   -d oldguo -c log2 --type=csv --headerline --file  /mongodb/log.csv

（2）csv格式的文件头行，没有列名字
mongoimport   -uroot -proot123 --port 27017 --authenticationDatabase admin   -d oldguo -c log3 --type=csv -f id,name,age,date --file  /mongodb/log1.csv


--headerline:指明第一行是列名，不需要导入。


补：导入CSV文件P_T_HISTXN_20160616.csv（csv文件中没有列明，fields指定列明）
$ tail -5 P_T_HISTXN_20160616.csv 
```

------

#### 9. 异构平台迁移案例

##### 9.1 mysql   -----> mongodb

###### 9.1.1 mysql开启安全路径

```mysql
vim /etc/my.cnf   --->添加以下配置
secure-file-priv=/tmp

--重启数据库生效
/etc/init.d/mysqld restart
```

###### 9.1.2 导出mysql的city表数据

```mysql
source /root/world.sql

select * from world.city into outfile '/tmp/city1.csv' fields terminated by ',';
```

###### 9.1.2 处理备份文件(表的字段：mysql不会导出字段)

```
password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,id,phone,avatar,blog_id

```

###### 9.1.3 vim /tmp/city.csv   ----> 添加第一行列名信息

```
password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,id,phone,avatar,blog_id

```

###### 9.1.4 在mongodb中导入备份

```mysql
mongoimport -uroot -proot123 --port 27017 --authenticationDatabase admin -d world  -c city --type=csv -f ID,Name,CountryCode,District,Population --file  /tmp/city1.csv
```

###### 9.1.5 查看

```
use world
db.city.find({CountryCode:"CHN"})

```

------

##### 9.2 mysql导出csv

```mysql
select * from test_info   
into outfile '/tmp/test.csv'   
fields terminated by ','　　　 ------字段间以,号分隔
optionally enclosed by '"'　　 ------字段用"号括起
escaped by '"'   　　　　　　  ------字段中使用的转义符为"
lines terminated by '\r\n';　　------行以\r\n结束
```

##### 9.3 mysql导入csv

```mysql
load data infile '/tmp/test.csv'   

into table test_info    

fields terminated by ','  

optionally enclosed by '"' 

escaped by '"'   

lines terminated by '\r\n'; 
```

------

#### 10. python连接使用MongoDB

##### 10.1 单机链接

```python
client = MongoClient('mongodb://localhost:27017/')
```

##### 10.2 replication set 链接

```python
from pymongo import MongoReplicaSetClient
conn = MongoReplicaSetClient("10.0.0.100:28017,10.0.0.100:28018,10.0.0.100:28019", replicaset='my_repl')

print (conn)
print (conn.primary)
print (conn.seeds)
print (conn.secondaries)
print (conn.read_preference)
print (conn.server_info())
```

##### 10.3 分片集群连接

```python
conn = pymongo.Connection('192.168.1.1', 27017) 
db = conn['test'] #假定名为test的db已经存在 
db_admin = conn['admin'] #command的执行必须通过名为admin的db才能进行 
col_data = db["data"] 
for i in range(1, 50): 

col_data.insert({'_id':i, 'value':(i*200)}) 
#插入测试数据，必须在分片之前保证shard key的存在，本例中为_id 
db_admin.command('enablesharding', 'test') 
#确认目标db的sharding功能开启(这行代码一个数据库只执行一次有效，如果已经#设置，则会抛出异常)

db_admin.command('shardcollection', 'test.data', key = {'_id':1}) 
#指定目标collection和对应的shard key（这行一个表执行一次，如果出现多表，表名不同的情况下，应该每张表都执行一次）

conn.close() 

如何查看已经分片成功：
在linux中进入mongo命令界面，
use test
db.test.data.stats()

会打印出分片信息。

并且shard key可以指定多个，同建立复合索引类似：
db_admin.command('shardcollection', 'test.data', key = {'_id':1, 'a':1, 'b':1})

```

