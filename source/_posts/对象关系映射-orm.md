---
title: 对象关系映射(orm)
tags: [mysql]
date: 2019-03-02 21:37:53
categories: 数据库
photos:
---

### 对象关系映射（ORM）

```
数据库中的表---->ORM----->类的对象
核心：
将表中的记录，变成一个个表类的对象，可以.属性拿到这些记录的值
将对象的属性，转成表中的一个个记录，可以插入到表中，完成对表的增删改查
```



#### 1.定义字段

```python
# 定义字段的基类 
class Field:
    # 每个字段都应该有字段名，是否是主键，字段的类型，初始值
    def __init__(self, name, primary_key, type, default):
        self.name = name
        self.primary_key = primary_key
        self.type = type
        self.default = default
# 定义字段类继承基类
class IntField(Field):
    def __init__(self, name, primary_key=True, type='int', default=0):
        # 去基类里面完成初始化
        super().__init__(name, primary_key=True, type='Int', default=0)


class CharField(Field):
    def __init__(self, name, primary_key=False, type='varchar(32)', default=None):
        super().__init__(name, primary_key=False, type='varchar(32)', default=None)
```

#### 2.定义model（数据库中的表）

```python
# 定义model的元类，控制类的产生过程，规范每个model类，让其拥有的共同的属性，table_name/mappings/primary_key

class MyModelMeta(type):
    def __new__(cls, name, bases, attrs):
        if name == 'Model':
            return type.__new__(cls, name, bases, attrs)
        table_name = attrs.get('table_name', None)
        if not table_name:
            table_name = name
        primary_key = None
        mappings = dict()
        for k, v in attrs.items():
            if isinstance(v, Field):
                mappings[k] = v
                if v.primary_key:
                    if primary_key:
                        raise TypeError('主键重复')
                    primary_key = k
        for k in mappings.keys():
            attrs.pop(k)
        # 最终每个类，都有以下三个属性，对象和类均可以访问这三个属性
        attrs['table_name'] = table_name
        attrs['primary_key'] = primary_key
        attrs['mappings'] = mappings
        return type.__new__(cls, name, bases, attrs)
```



```python
# 定义基表
class Model(dict, metaclass=MyModelMeta):
	# 表中对象的特有属性，到dict中完成初始化，就可以按照字典取值的方式取值dict[key]
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
	# 重写此方法，可以在对象点属性时获取值，self.item
    def __getattr__(self, item):
        try:
            return self[item]
        except KeyError:
            raise TypeError('没有这个属性%s' % item)
	# 重写此方法，在对象通过点属性设置值时，可以调用，self.name = name;小心递归的坑
    def __setattr__(self, key, value):
        self[key] = value
	
    # 每张表都应该有查询，更新，创建的方法
    @classmethod
    def filter_one(cls, **kwargs):
        ms = Mysql().singleton()
        key = list(kwargs.keys())[0]
        value = kwargs.get(key, None)
        sql = 'select * from %s where %s= ?' % (cls.table_name, key)
        sql.replace('?', '%s')
        re = ms.select(sql, value)
        if not re:
            res = None
        else:
            # 将查询的结果实例化成对象，这样对象的属性中就有字段的值
            res = cls(**re[0])
        return res

    @classmethod
    def filter_many(cls, **kwargs):
        ms = Mysql().singleton()
        if not kwargs:
            sql = 'select * from %s' % (cls.table_name)
            re = ms.select(sql)
        else:
            key = list(**kwargs)[0]
            value = kwargs.get(key, None)
            sql = 'select * from %s where %s= ?' % (cls.table_name, key)
            sql.replace('?', '%s')
            re = ms.select(sql, value)
        return [cls(**r) for r in re]

    def save(self):
        ms = Mysql.singleton()
        fields = list()
        params = list()
        args = list()
        for k, v in self.mappings.items():
            fields.append(k)
            params.append('?')
            # 当self.k没有获取到值时，使用默认值
            args.append(getattr(self, k, v.default))
        sql = 'insert into %s (%s) values (%s)' % (self.table_name, ','.join(fields), ','.join(params))
        sql = sql.replace("?", '%s')
        re = ms.execute(sql, args)
        if re:
            return '插入成功'
        return '插入失败'

    def table_update(self):
        ms = Mysql.singleton()
        pr = None
        args = list()
        fields = list()
        for k, v in self.mappings.items():
            if v.primary_key:
                pr = getattr(self, k, v.default)
            else:
                fields.append(v.name + '=?')
                args.append(getattr(self, k, v.default))
        sql = 'update %s set %s where %s = %s' % (self.table_name, ','.join(fields), self.primary_key, pr)
        sql = sql.replace('?', '%s')
        # update User set name=%s,password=%s where id = 3
        print(sql)
        res = ms.execute(sql, args)
        if res:
            return '更新成功'

```

#### 3.定义自定义的表

```python
# 继承model的基类
class User(Model):
    id = IntField(name='id', primary_key=True, default=0)
    name = CharField(name='name')
    password = CharField(name='password')
```

```python
#使用
if __name__ == '__main__':
    user = User(id=3, name='jinshu', password='88823488')
    res = user.table_update()
    print(res)
```

#### 4.定义数据库查询的接口

```python
import pymysql


class Mysql:
    __instance = None

    def __init__(self):
        # 直接初始化建立数据库的连接
        self.conn = pymysql.connect(host='127.0.0.1',
                                    port=3306,
                                    user='root',
                                    password='123',
                                    database='youku',
                                    charset='utf8',
                                    autocommit=True)
        # 直接初始化产生游标，cursor=pymysql.cursors.DictCursor定义查询的结果以{}/[{}]出现
        self.cursor = self.conn.cursor(cursor=pymysql.cursors.DictCursor)
	# 关闭连接
    def close_db(self):
        self.conn.close()
	# 查询
    def select(self, sql, args=None):
        self.cursor.execute(sql, args)
        rs = self.cursor.fetchall()
        return rs
	# 更新和添加
    def execute(self, sql, args):
        try:
            self.cursor.execute(sql, args)
            affected = self.cursor.rowcount
            # self.conn.commit()
        except BaseException as e:
            print(e)
            affected = 0
        return affected
	# 单例，优化查询效率
    @classmethod
    def singleton(cls):
        if not cls.__instance:
            cls.__instance = cls()
        return cls.__instance
```

#### 5.数据库中的表

```mysql
"id"	"name"	"password"
"1"	"wang"	"8888888888"
"2"	"jinshu"	"88823488"

```


