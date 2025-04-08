---
title: django之手写orm
tags: [lnhdjango基础]
date: 2021-05-05 14:36:47
categories: 理解
photos:
book:
---

# 手写orm

## 介绍

```
1 ORM即Object Relational Mapping，全称对象关系映射。
# 思考一下
# 对象关系映射 ，
# 1.就是程序的类对应的我的mysql的表
# 2.类里面的数据属性对应的mysql字段 
# 3.那么我只需要写这些python语法就可以把数据查出来，爽死
# 4.其实就是把我们的sql语句翻译成sql,拿到数据库里面去执行，执行完以后再翻译回来
# 5。返回回来是一个字典的格式的数据，再回到程序，它就变成了类对应的对象，所以说查出来的数据是一个个的对象。
# 6.那么这样就爽了。我们拿到的是一个个对象，那么对象点什么就是什么的字段信息，
比如对象.name 就是name字段像这样
	优点: 
		1 不用写sql,不会sql的人也可以写程序,爽死
		2 开发效率高
	2 缺点:
		1 可能sql的效率低
1 ORM即Object Relational Mapping，全称对象关系映射。
	优点: 
		1 不用写sql,不会sql的人也可以写程序
		2 开发效率高
	2 缺点:
		1 可能sql的效率低
	3 如何使用:
		如果连接mysql:在setting里配置:
		    'default': {
				'ENGINE': 'django.db.backends.mysql',
				'HOST': '127.0.0.1',
				'PORT': 3306,
				'USER': 'root',
				'PASSWORD': 'admin',
				'NAME': 'lqz',
			}
		在app下的__init__.py里写:
		import pymysql
		pymysql.install_as_MySQLdb()
	
	4 django-orm:
		1 不能创建数据库(需要手动创建数据库)
		2 可以创建数据表
		3 可以创建字段
		
	5 数据库迁移
		1 python3 manage.py makemigrations   ----记录一下数据库的变化
		2 python3 manage.py migrate          ----将变化同步到数据库中
	6 增加字段
		注意:后来增加的字段,需要有默认值
		phone=models.CharField(max_length=64,default='120')	
```

## 思路

### 1.先定义一个类

```
1.可以用类的属性来表示表名
2.是否有主键
3.字段id，name，content，user_id，
它们的对应的字段的名字，比如id字段对应的名字是id，主键是True,默认值是0
那么这里又有三个映射关系，怎么办？
```

```python
class Notic()：
	table_name= 表名
	id = IntegerField(名字是id，字段的类型，主键是True,默认值是0)  # id字段的类型和主键需要约束
	name = StringField(名字是name，字段的类型，主键是False,默认值是None)
    content= StringField(名字是content，字段的类型，主键是False,默认值是None)
    user_id = IntegerField(名字是user_id，字段的类型，主键是False,默认值是None)
```

### 2.讲字段对应的属性写成类

```
4.回答第3个步骤的问题，把字段的对应的名字是id，字段的类型，主键是True,默认值是0定义到类里面，然后Notic对应的属性值进行调用就好了，发现字段的类型都不一样，所以我们要利用一个继承
减少一下代码的冗余
```

```python
class Field(object):
    def __init__(self, name, column_type, primary_key, default):
        self.name = name  # 列名
        self.column_type = column_type  # 数据类型
        self.primary_key = primary_key  # 是否为主键
        self.default = default  # 默认值

class StringField(Field):
    def __init__(self, name=None, ddl='varchar(100)', primary_key=False, default=None):
        super().__init__(name, ddl, primary_key, default)

class IntegerField(Field):
    def __init__(self, name=None, primary_key=False, default=0):
        super().__init__(name, 'int', primary_key, default)
```

#### 然后Notic对应的属性值进行调用就好了

```python
class Notic()：
	table_name= 'notice'
	id = IntegerField('id',primary_key=True)  # id字段的类型和主键需要约束
	name = StringField('name')
    content= StringField('content')
    user_id = IntegerField('user_id')
```

#### 我们测试一下创建出来的类

##### 加一个metaclass=ModelMetaclass

```python
class Notic(metaclass=ModelMetaclass):
    table_name = 'notice'
    id = IntegerField('id',primary_key=True)
    name = StringField('name')
    content= StringField('content')
    user_id = IntegerField('user_id')
```

##### 类属性attrs结果，id字段对应的对象IntegerField

```python
first_class={'__module__': '__main__', '__qualname__': 'Notic',
'table_name': 'notice', 
'id': '<__main__.IntegerField object at 0x00000222C5234B00>',
'name': '<__main__.StringField object at 0x00000222C5234AC8>', 
'content': '<__main__.StringField object at 0x00000222C5234A90>', 
'user_id': '<__main__.IntegerField object at 0x00000222C5234A58>'}
```

### 3.思考一下这样好不好

一个id字段对应它的属性

### 4.所以我们把Notic它的属性放到一个字典里面，在生成它的时候进行new重置

```python
class ModelMetaclass(type):
    def __new__(cls, name, bases, attrs):
        print('+++++')
        print(attrs)
        if name == "Model":
            return type.__new__(cls, name, bases, attrs)
        table_name = attrs.get('table_name', None)
        if not table_name:
            raise TypeError('没有表名')
        primary_key = None  # 查找primary_key字段
        # 保存列类型的对象
        mappings = dict()
        for k, v in attrs.items():
            # 是列名的就保存下来
            if isinstance(v, Field):
                mappings[k] = v
                if v.primary_key:
                    # 找到主键:
                    if primary_key:
                        raise TypeError('主键重复: %s' % k)
                    primary_key = k
        print(mappings)
        for k in mappings.keys():
            attrs.pop(k)
        if not primary_key:
            raise TypeError('没有主键')
        print('----')
        print(attrs)
        # 给cls增加一些字段：
        attrs['mapping'] = mappings
        attrs['primary_key'] = primary_key
        attrs['table_name'] = table_name
        print(attrs)
        return type.__new__(cls, name, bases, attrs)
```

#### 结果attrs把字段的属性放到字典mapping里面

```python
new__class={'__module__': '__main__',
'__qualname__': 'Notic',
'table_name': 'notice',
'mapping': {'id': '<__main__.IntegerField object at 0x00000220331F3400>',
'name': '<__main__.IntegerField object at 0x00000220331F3400>',
'content': '<__main__.StringField object at 0x00000220331ECEF0>',
'user_id': '<__main__.IntegerField object at 0x00000220331ECE80>'},
'primary_key': 'id'}
```

### 5.实例化的时候会生成对象，最好还是一个字典，所以用继承

#### 比如

Notic(id='22',name=1233222,content='11ddsad11',user_id=9)

#### 先继承Model

```python
class Notic(Model):
    table_name = 'notice'
    id = IntegerField('id',primary_key=True)
    name = StringField('name')
    content= StringField('content')
    user_id = IntegerField('user_id')
```

#### 再Model继承dict，控制Model和Notic类的创建

```python
class Model(dict, metaclass=ModelMetaclass):
    def __init__(self, **kw):
        super(Model, self).__init__(**kw)
    def __getattr__(self, key):  # .访问属性触发
        try:
            return self[key]
        except KeyError:
            raise AttributeError('没有属性：%s' % key)
    def __setattr__(self, key, value):
        self[key] = value
```

### 6.连接数据库

#### 这个时候就要用到pymysql

##### 写一个连接池fuckorm_pool.py，导入db_pool

```python
import pymysql
from ormpool import db_pool
from threading import current_thread

class MysqlPool:
    def __init__(self):
        self.conn = db_pool.POOL.connection()
        # print(db_pool.POOL)
        # print(current_thread().getName(), '拿到连接', self.conn)
        # print(current_thread().getName(), '池子里目前有', db_pool.POOL._idle_cache, '\r\n')
        self.cursor = self.conn.cursor(cursor=pymysql.cursors.DictCursor)

    def close_db(self):
        self.cursor.close()
        self.conn.close()

    def select(self, sql, args=None):
        # 执行查询的sql语句
        self.cursor.execute(sql, args)
        rs = self.cursor.fetchall()
        return rs

    def execute(self, sql, args):
		# 执行插入和修改的sql语句
        try:
            # 执行sql语句
            self.cursor.execute(sql, args)
            affected = self.cursor.rowcount
            # self.conn.commit()
        except BaseException as e:
            print(e)
        finally:
            self.close_db()
        return affected
```

##### db_pool.py导入setting.py

```python
import pymysql
import setting
from DBUtils.PooledDB import PooledDB

POOL = PooledDB(
    creator=pymysql,  # 使用链接数据库的模块
    maxconnections=6,  # 连接池允许的最大连接数，0和None表示不限制连接数
    mincached=6,  # 初始化时，链接池中至少创建的空闲的链接，0表示不创建
    maxcached=5,  # 链接池中最多闲置的链接，0和None不限制
    maxshared=3,
    # 链接池中最多共享的链接数量，0和None表示全部共享。PS: 无用，因为pymysql和MySQLdb等模块的 threadsafety都为1，所有值无论设置为多少，_maxcached永远为0，所以永远是所有链接都共享。
    blocking=True,  # 连接池中如果没有可用连接后，是否阻塞等待。True，等待；False，不等待然后报错
    maxusage=None,  # 一个链接最多被重复使用的次数，None表示无限制
    setsession=[],  # 开始会话前执行的命令列表。
    ping=0,
    # ping MySQL服务端，检查是否服务可用。
    host=setting.host,
    port=setting.port,
    user=setting.user,
    password=setting.password,
    database=setting.database,
    charset=setting.charset,
    autocommit=setting.autocommit
)
```

##### setting.py

```python
import os

host = '127.0.0.1'
port = 3306
user = 'root'
password = ''
database = 'orm'
charset = 'utf8'
autocommit = True

```

### 7.要实现Notic.select_one(id=1)查询id=1的字典怎么办？

还有查询所有select_all，利用绑定类的方法classmethod

update方法，save方法

```python
class Model(dict, metaclass=ModelMetaclass):
    def __init__(self, **kw):
        super(Model, self).__init__(**kw)
    def __getattr__(self, key):  # .访问属性触发
        try:
            return self[key]
        except KeyError:
            raise AttributeError('没有属性：%s' % key)
    def __setattr__(self, key, value):
        self[key] = value

    @classmethod
    def select_all(cls, **kwargs):
        ms = mysql_pool.MysqlPool()
        if kwargs:  # 当有参数传入的时候
            key = list(kwargs.keys())[0]
            value = kwargs[key]
            sql = "select * from %s where %s=?" % (cls.table_name, key)
            sql = sql.replace('?', '%s')
            re = ms.select(sql, value)
        else:  # 当无参传入的时候查询所有
            sql = "select * from %s" % cls.table_name
            re = ms.select(sql)
        if re:
            # 实例化添加属性，并生成对象，放入一个列表里面
            lis_obj=[cls(**r) for r in re]
            return lis_obj
        else:
            return

    @classmethod
    def select_one(cls, **kwargs):
        # 此处只支持单一条件查询
        key = list(kwargs.keys())[0]
        value = kwargs[key]
        # 建立pymysql连接
        ms = mysql_pool.MysqlPool()
        # 拼凑出select语句
        sql = "select * from %s where %s=?" % (cls.table_name, key)
        sql = sql.replace('?', '%s')
        print(sql)
        re = ms.select(sql, value)
        if re:
            # 实例化添加属性，并生成对象
            return cls(**re[0])
        else:
            return None
    def save(self):
        ms = mysql_pool.MysqlPool()
        fields = []
        params = []
        args = []
        for k, v in self.mapping.items():
             # 因为这里有mapping对象
            """
'mapping': {'id': '<__main__.IntegerField object at 0x00000220331F3400>',
            'name': '<__main__.IntegerField object at 0x00000220331F3400>',
            'content': '<__main__.StringField object at 0x00000220331ECEF0>',
            'user_id': '<__main__.IntegerField object at 0x00000220331ECE80>'},	
            """
            fields.append(v.name)
            params.append('?')
            print(k)
            print('--------')
            print(v.default)
            #拿到该实例化的对象的属性id,name,content,user_id
            args.append(getattr(self, k, v.default))
        print(args)
        # 然后进行拼接sql语句
        sql = "insert into %s (%s) values (%s)" % (self.table_name, ','.join(fields), ','.join(params))
        # insert into notice (id,name,content,user_id) values (?,?,?,?)
        sql = sql.replace('?', '%s')
		# insert into notice (id,name,content,user_id) values (%s,%s,%s,%s)
        ms.execute(sql, args)

    def update(self):
        ms = mysql_pool.MysqlPool()
        fields = []
        args = []
        pr = None
        for k, v in self.mapping.items():
            if v.primary_key:
                # 
                pr = getattr(self, k, None)
            else:
                fields.append(v.name + '=?')
                args.append(getattr(self, k, v.default))
        sql = "update %s set %s where %s = %s" % (
            self.table_name, ', '.join(fields), self.primary_key, pr)
        sql = sql.replace('?', '%s')
        print(sql)
        ms.execute(sql, args)
        
```

