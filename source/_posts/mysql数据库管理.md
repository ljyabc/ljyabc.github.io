---
title: mysql数据库管理
tags: [mysql]
date: 2019-03-31 15:52:52
categories: 记忆
photos:
book:
---

# 数据库管理

### 一.MySQL

#### 1.版本介绍和选择

##### 排名

https://db-engines.com/en/ranking

##### 1.1 版本

```
oracle mysql
mariadb 
perconadb
```

##### 1.2 主流版本

```
5.6 版本 5.6.36 5.6.38  5.6.40
通用的二进制版  rpm版  源码包（需要编辑）
5.7 版本 5.7.18  5.7.20  5.7.22
8.0 版本 最新的版本
		
企业版本选择：6-12月之间的GA 双数版
```

------

#### 2. MySQL的体系结构

##### 2.1 MySQL是典型的 c/s结构

##### 2.2 连接（linux）的2种方式

```python
方式一：tcp/ip（远程本地都可以）
方式二：socket（本地）
```

mysql -uroot -poldboy123 -h 10.0.0.200 -P3306

###### mysql -uroot -poldboy123 -S /tmp/mysql.sock

##### 2.3 MySQL实例

```python
1.程序不会关闭
2.内存先预支的
实例 = 后台运行的守护的进程mysqld + 内存结构
mysqld ---->master thread(经理)----->N thread（员工） ----->办公区域（内存结构）
```



##### 2.4 mysqld三层结构

![1553244169534](C:\Users\aaa\AppData\Local\Temp\1553244169534.png)

> **<font color=#00FA9A>1 连接层</font>**

```
提供连接协议（tcp/socket）
用户验证
提供专业连接线程
```



###### 测试

> desc mysql.user;
>
> select user ,authentication_string, host from mysql.user;

1.提供连接协议(TCP ,Socket)

2.用户验证

> mysql> show processlist;
> +----+------+-----------+------+---------+------+----------+------------------+
> | Id | User | Host      | db   | Command | Time | State    | Info             |
> +----+------+-----------+------+---------+------+----------+------------------+
> |  3 | root | localhost | NULL | Sleep   |  714 |          | NULL             |
> |  4 | root | localhost | NULL | Query   |    0 | starting | show processlist |
> +----+------+-----------+------+---------+------+----------+------------------+
> 2 rows in set (0.00 sec)

3.提供专用链接线程

> **<font color=#00FA9A>2 sql层</font>**

```
1.接受上层命令
2.进行语法检测
3.检查语义（sql类型）和权限
    sql类型：
    DDL ： 数据定义语言
    DCL ： 数据控制语言
    DML ： 数据操作语言
    DQL ： 数据查询语言
4.专用解析器解析sql，会将sql语句解析成多种执行计划(全盘还是索引)
5.优化器：会帮我们选择一个代价最低的执行的计划（cpu，io，mem）
6.执行器：按照优化器的选择，执行sql语句，得出获取数据的方法
7.查询缓存：默认是关闭的，有2个问题：数据更新/md5匹配
8.一般会使用（京东）redis产品，来替代查询缓存  淘宝用的tair
9.记录日志：查询日志  二进制日志（******）
```

> **<font color=#00FA9A>3 存储引擎层：事务，锁</font>**

```
按照sql层结论，找出相应数据，结构化成表的形式 (16进制连接连接层)
```

##### 2.5 mysql逻辑结构

```
库（schema）:存储表的地方（其实就是目录），库名和属性
表（table）：二维表
元数据：
    表名
    表的属性：大小，权限，字符集，存储引擎等
    列：列名字，列属性：（数据类型，约束，其他定义）
数据行：		
	记录：数据行

```

**<font color=#DC143C>注意：sql语句优化的核心：sql语句执行过程是否最优，干预优化器的选择，
少使用全表扫描</font>**

------

#### 3. sql语句（sql92/sql99标准）

##### 3.1 sql种类

```
DDL ： 数据定义语言

DCL ： 数据控制语言
DML ： 数据操作语言
DQL ： 数据查询语言
```

##### 3.2 sql语句的操作对象

```
库（schema）：
表（table）：
```

##### 3.3 DDL语句作用

> 1.库

```mysql
库
create database
drop database
alter database
```

**<font color=#DC143C>sql语句规范第一条：</font>**

```
sql语句规范第一条：
1.关键字大写，字面量小写
2.库名字，只能是小写，不能是数字开头，不能是预留关键字
3.库名和业务名有关，例如：his_user;
4.必须加字符集，生产环境和测试环境应该一致
```

> 2.表

```mysql
create table
drop table
alter table

eg:
CREATE TABLE t1 （
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '用户id号',
name VARCHAR(20) NOT NULL  COMMENT '用户姓名',
sex  ENUM('f','m','u') NOT NULL DEFAULT 'u' COMMENT '用户性别',
telnum CHAR(11) NOT NULL UNIQUE  COMMENT '手机号',
tmdate DATETIEM NOT NULL DEFAULT NOW() COMMENT '数据录入时间',
) ENGINE INNODB CHARSET utf8mb4;
```

**<font color=#DC143C>sql语句规范第二条：</font>**

```
sql语句规范第二条：
1.关键字大写，字面量小写
2.表名必须小写，不能数字开头，不能是预留的关键字
3.表名必须和业务有关
4.必须加存储引擎
5.使用合适的数据类型
6.必须要有主键
7.尽量非空选项
8.字段唯一性
9.必须加注释
10.尽量避免外键
11.建立合理的索引
```

##### 3.4 DCL语句作用

```
grant  授权
revoke 回收
lock   用的少
```

##### 3.5 DML语句作用

```
insert：插入数据
update
delete
```

**<font color=#DC143C>sql语句规范第三条：</font>**

```
sql语句规范第三条：
1.insert语句按批量插入数据
2.update必须加where条件
3.delete尽量替换成update，加个状态列
4.清空全表，不要使用delete推荐使用truncate
```

##### 3.6 DQL语句的作用

```
select
show
```

**<font color=#DC143C>sql语句规范第四条：</font>**

```
sql语句规范第四条：
1.避免使用select * from t1;
2.select语句尽量加where 条件，例如select *  from t1 where name = 'zzz';
3.select 语句对于范围的查询，例如：select * from t1 where id >200;
	可以使用limit，或者区间查询
4.select 的where条件，不要使用<> like '%name' not in not exist
5.表连接不要出现3表以上的表连接，避免子查询
6.where条件中不要出现函数操作
```



# 三.忘记密码处理

## 6.忘记密码处理

### 1.设置本地的密码

> mysqladmin -uroot -p password 123

### 2.登陆就需要密码

> mysql -uroot -p123
>
> ###### 手动输入安全些
>
> mysql -uroot -p

> select user,authentication_string,host from mysql.user;

+---------------+-------------------------------------------+-----------+
| user          | authentication_string                     | host      |
+---------------+-------------------------------------------+-----------+
| root          | *23AE809DDACAF96AF0FD78ED04B6A265E05AA257 | localhost |
| mysql.session | *THISISNOTAVALIDPASSWORDTHATCANBEUSEDHERE | localhost |
| mysql.sys     | *THISISNOTAVALIDPASSWORDTHATCANBEUSEDHERE | localhost |
| root          | *23AE809DDACAF96AF0FD78ED04B6A265E05AA257 | 10.0.0.%  |
| bbs           | *23AE809DDACAF96AF0FD78ED04B6A265E05AA257 | 10.0.0.%  |
+---------------+-------------------------------------------+-----------+
5 rows in set (0.00 sec)

 *23AE809DDACAF96AF0FD78ED04B6A265E05AA257代表123密码

### 3.停数据库

/etc/init.d/mysqld stop

### 4.启动数据库为无密码验证模式

###### 关闭授权和tcp的ip

> mysqld_safe --skip-grant-tables --skip-networking  &

###### 所有不能执行修改密码已经关闭了授权

> grant all on *.* to root@'localhost' identified by '456';

###### 只能改

> update mysql.user set authentication_string=PASSWORD('456') where user='root' and host='localhost';

mysql> select user ,authentication_string, host from mysql.user;
+---------------+-------------------------------------------+-----------+
| user          | authentication_string                     | host      |
+---------------+-------------------------------------------+-----------+
| root          | *531E182E2F72080AB0740FE2F2D689DBE0146E04 | localhost |
| mysql.session | *THISISNOTAVALIDPASSWORDTHATCANBEUSEDHERE | localhost |
| mysql.sys     | *THISISNOTAVALIDPASSWORDTHATCANBEUSEDHERE | localhost |
| root          | *23AE809DDACAF96AF0FD78ED04B6A265E05AA257 | 10.0.0.%  |
| bbs           | *23AE809DDACAF96AF0FD78ED04B6A265E05AA257 | 10.0.0.%  |
+---------------+-------------------------------------------+-----------+
5 rows in set (0.00 sec)

> /etc/init.d/mysqld restart

#### 测试

> [root@standby ~]# mysql -uroot -p123
> [root@standby ~]# mysql -uroot -p456

# 4.mysql数据类型和字符集

##### 4.1 数据类型

```python
1.整型：	
	int 最多存10数字
    -2^31 ~ 2^31 -1  
    2^32 10位数  11
2.浮点型
	float 一般用decimal
	
3.字符串类型
    char      定长：存效率较高，对于变化较多字段，空间浪费较多
    varchar   变长： 存储时判断长度，会有额外开销，空间按需分配
    enum      枚举类型  能用枚举尽量用枚举类型 性能高

4.时间类型：
    datatime
    timestamp
    data  年月日
    time  十分秒
```

**<font color=#DC143C>sql语句规范第五条：</font>**

```
sql语句规范第五条
1.少于10位的数字  int 相较于varchar占空间少的多
2.大于10位数字，一般用char
3.char和varchar选择时，字符长度一定不变，使用char；可变的尽量使用varchar
在可变长度的存储时，将来使用不同的数据类型可能会影响索引树的高度
4.选择合适的数据类型
5.选择合适长度
```

------

# 