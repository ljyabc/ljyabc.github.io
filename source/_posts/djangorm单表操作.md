---
title: djangorm单表操作
tags: [lnhdjango基础]
date: 2021-05-05 14:28:53
categories: 理解
photos:
book:
---

# orm单标操作

## 补充defer和only(数据库优化)

```
# 我就想queryset中套author的对象,但是只有name
    ret=models.Author.objects.all().only('name')
    print(ret)
    print(type(ret[0]))
    for i in ret:
        print(ret.first().sex)
    ret=models.Author.objects.all()
    for i in ret:
        print(ret.first().sex)
    # 一旦指定only,就不要再取没有的值了,否则会造成数据库压力
```

```python
# defer:除了指定之外的
    ret=models.Author.objects.all().defer('name')
    # print(ret[0].set)

    print(ret[0].name)
only:只取我指定的字段,返回值是queryset里套对象,只是对象里只有指定的字段
defer:反过来
```

## 1.配置文件settings.py

### mysql数据库

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'danbiaochaxun',
        'USER':'root',
        'PASSWORD':'',
        'HOST':'127.0.0.1',
        'PORT':'3306',
    }
}
```

### 静态文件

```python
STATICFILES_DIRS= [
    os.path.join(BASE_DIR,'static')
]
```

### app配置mysql

```python
import pymysql

pymysql.install_as_MySQLdb()
```

## 2.数据库迁移

```python
-python3 manage.py makemigrations   --->只是对变化做一个记录,记录文件在app的migrations
			-python3 manage.py migrate   ---->把更改提交到数据库
			-python3 manage.py showmigrations  ---->查看那个没有提交到数据库
```

## 3.在Python脚本中调用Django环境

在项目里面新建一个py文件

```python
import os
if __name__ == '__main__':
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "untitled15.settings")
    import django
    django.setup()
```

## 4.orm操作

### orm增加操作

#### 方法一 create

```python
import os
if __name__ == '__main__':
    os.environ.setdefault("DJANGO_SETTINGS_MODULE","danbiaochaxun.settings")
    import django
    django.setup() # 启动django
    from app01 import models
# 方法一: 直接 app01.Book.objects 对象 create返回一个结果是对象 Book object
    # 返回结果是一个对象
    print(models.Book)
    print(models.Book.objects)
    print(models.Book.objects.all())
    book=models.Book.objects.create(name='红楼梦',price=23.8,publish='人民出版社',author='曹雪芹',create_data='2020-12-25')
    print(book)   
    print(book.name)
    print(book.price)
    print(book.publish)
    print(book.author)
    print(book.create_data)
```

#### 方法二 实例化生成一个对象

```python
# 方法二  先 models.Book实例化生成一个对象 在 内存里面 然后通过save()写入数据库里
    book=models.Book(name='红楼梦2',price=23.8,publish='人民出版社',author='曹雪芹',create_data='2020-12-25')
    print(book)  # 只是在内存里面
    print(book.name)
    book.save() # 写入硬盘
```

#### 时间格式

```python
可以传字符串,可以传日期格式
    import datetime

    ctime = datetime.datetime.now()
    book = models.Book.objects.create(name='西游记', price=73.8, publish='北京出版社', author='吴承恩', create_data=ctime)
    print(book.name)
```

### orm删除操作

#### 原理先查后删

```python
先查询出装载QuerySet对象的列表
ret = models.Book.objects.filter(name='西游记')
```

#### 删除指定的全部数据（多条）

```python
ret = models.Book.objects.filter(name='西游记').delete()
    print(ret)
```

##### ret返回值

```python
返回的是行数
```

#### 删除指定的单条数据

```python
ret = models.Book.objects.filter(name='西游记').first()
    ret.delete()
    print(ret)
```

### orm修改操作

#### 修改指定的全部数据

```python
ret = models.Book.objects.filter(name= '西游记').update(price=20.9)
    print(ret)
```

#### 修改指定的单条数据

```python
# 对象修改(没有update方法,但是可以用save来修改)
    book = models.Book.objects.filter(name='西游记').first()
    book.price=89
    book.save()
```

### orm查询操作 查询API（重点哦）

#### all()  查询所有结果

```python
	print(models.Book.objects) # app01.Book.objects
    ret=models.Book.objects.all()
    print(ret)# <QuerySet [<Book: 书名:红楼梦,价格:23.80>, <Book: 书名:红楼梦,价格:23.80>]
```



#### filter(**kwargs):  它包含了与所给筛选条件相匹配的对象

相当于where

##### queryset对象打印sql

```
ret=models.Book.objects.filter(name='西游记',price='73.8')
ret.query -->queryset对象打印sql
print(ret.query)
```

#### 和first()指定查询出第一个结果

```python
ret=models.Book.objects.filter(name='西游记').first()
print(ret)
```

#### 和last()指定查询出最后一个结果

```python
ret=models.Book.objects.filter(name='西游记').last()
print(ret)
```

#### exists判断queryset对象是否存在

```python
ret = models.Book.objects.filter(name='西游记3355').exists()
print(ret)
```

##### filter指定查询出全部结果

```python
ret=models.Book.objects.filter(name='西游记')
    print(type(ret))
    for i in ret:
        print(type(i))
```

#### get查询多个结果或者0个结果会报错

```python
# get  有且只有一个结果,才能用,如果有一个,返回的是对象,不是queryset对象,通常用在,用id查询的情况
    ret=models.Book.objects.get(name="西游记2")
    print(ret)
    ret=models.Book.objects.get(id="1")
    print(ret)

```

#### exclude查询，筛选出不是该条件的数据

```python
 ret = models.Book.objects.exclude(name='西游记')
 print(ret)
 print(ret.query)
```

#### order_by(*args)查询 排序

##### 正序

```python
ret=models.Book.objects.order_by('price')
print(ret)
```

##### 多个参数优先第一个order_by参数

```python
ret=models.Book.objects.filter(name='西游记3338').order_by('price','-id')
print(ret)
```

#### 倒叙reverse

order_by 负号能解决，但是提供了 reverse

```python
ret = models.Book.objects.filter(name='西游记3338').order_by('-id').reverse()
print(ret)
```

#### count个数返回一个int类型

```python
ret = models.Book.objects.filter(name='西游记3338').count()
print(ret)
```

#### values(*field)queryset对象里套字典

```python
# values(*field): queryset对象里套字典
ret=models.Book.objects.all().values('name','price')
ret=models.Book.objects.all().values('name')
print(ret)
```

#### value_listqueryset对象里套元组

```python
ret=models.Book.objects.all().values_list('name','price')
print(ret)
```

#### distinct() 必须完全一样,才能去重只要带了id,去重就没有意义了

```python
ret=models.Book.objects.all().values('name').distinct()
print(ret)
```

### filter模糊查询

#### __lt 小于

```python
ret=models.Book.objects.filter(price__gt='89')
print(ret)
```

#### __gt 大于

```python
 ret=models.Book.objects.filter(price__gt='89')
 print(ret)
```

#### __lte小于等于

```python
ret = models.Book.objects.filter(price__lte='89')
```

#### __gte大于等于

```python
ret = models.Book.objects.filter(price__gte='89')
print(ret)
```

#### __in在什么容器里面

```python
ret=models.Book.objects.filter(price__in=['23.8','89','100'])
print(ret)
print(ret.query)
```

#### __range在什么范围

```python
ret=models.Book.objects.filter(price__range=[50,100])
print(ret.query)
```

#### __contains 查询名字有'%红%'的书

```python
ret=models.Book.objects.filter(name__contains='红')
print(ret)
print(ret.query)
```

#### __icontains 查询名字带p的书,忽略大小写

```python
ret=models.Book.objects.filter(name__icontains='P')
print(ret)
print(ret.query)
```

#### __startswith以XX开头

```python
ret=models.Book.objects.filter(name__startswith='红')
print(ret)
print(ret.query)
```

#### __endswith以XX开头

```python
ret=models.Book.objects.filter(name__endswith='梦')
print(ret)
```

#### pub_date__year按年查询

```python
ret=models.Book.objects.filter(create_data__year='2017')
print(ret)
```

#### pub_date__day按天查询

```python
ret = models.Book.objects.filter(create_data__day='25')
print(ret)
```

## 作业

```
1 查询守约出版社出版过的价格大于200的书籍
		 
2 查询2017年8月出版的所有以py开头的书籍名称

3 查询价格为50,100或者150的所有书籍名称及其出版社名称

4 查询价格在100到200之间的所有书籍名称及其价格

5 查询所有人民出版社出版的书籍的价格（从高到低排序，去重）

```

