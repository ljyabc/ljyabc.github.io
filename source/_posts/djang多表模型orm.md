---
title: djang多表模型orm
tags: [lnhdjango基础]
date: 2021-05-05 14:26:10
categories: 理解
photos:
book:
---

# 多表模型

## 创建表

### 表的关系：

```python
Author表和AuthorDetail表是一对一
Publish表和Book表示一对多
Book表和Author表是多对多
```

### 一对一的关系 OneToOneField

#### 第一种OneToOneField

```python
class Author(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=32)
    # 数字类型
    sex = models.IntegerField()
    # 可以用ForeignKey,但是得设置唯一性约束,会报警告,不建议用,建议用OneToOneField
    # authordetail=models.ForeignKey(unique=True)
    # to='AuthorDetail'  加引号,这个表能找到就可以,不用引号,类必须在上面定义
    authordetail = models.OneToOneField(to='AuthorDetail', to_field='id')
    def __str__(self):
        return self.name
class AuthorDetail(models.Model):
    id = models.AutoField(primary_key=True)
    phone = models.CharField(max_length=32)
    addr = models.CharField(max_length=64)
```

#### 第二种ForeignKey(unique=True)

```python
authordetail=models.ForeignKey(unique=True)
```

### 一对多和多对多的关系 ForeignKey ManyToManyField

```python
class Publish(models.Model):
    # id如果不写,会自动生成,名字叫nid,并且自增
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=32)
    addr = models.CharField(max_length=64)
    email = models.EmailField()
class Book(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=32)
    price = models.DecimalField(max_digits=5, decimal_places=2)
    publish = models.ForeignKey(to=Publish, to_field='id')
    authors = models.ManyToManyField(to=Author)
    def __str__(self):
        return self.name
```

### 注意

```python
#用了OneToOneField和ForeignKey,模型表的字段,后面会自定加_id
# ManyToManyField会自动创建第三张表
```

## 插入表

### 启动django

```python
import os
if __name__ == '__main__':
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "duobiaomoxing.settings")
    import django
    django.setup()
    from app01.models import *
```

### orm增加操作多对一

#### 最终对象修改

##### 增加方式一

```python
book=Book(name='金瓶梅',price=34.5,publish_id=1)
book.save()
```

##### 增加方式二

```python
ret = Book.objects.create(name='红楼梦',price=34.5,publish_id=1)
print(ret.name)
```

##### 增加方式三

```python
publish = Publish.objects.get(pk=2)
ret = Book.objects.create(name='西游记', price=34.5, publish=publish)
print(ret.name)
```

### orm修改操作多对一

#### 最终对象修改

##### 修改方式一

```python
publish = Publish.objects.get(pk=2)
book=Book.objects.get(pk = 1)
book.publish =publish
book.save()
```

##### 修改方式二

```python
publish = Publish.objects.get(pk=2)
book=Book.objects.get(pk = 1)
# book.publish =publish
book.publish_id=3
book.save()
```

#### queryset对象修改

##### 修改方式三

```python
# 一先拿到publish对象
publish = Publish.objects.get(pk=2)
# 二filter查出queryset对象然后执行update
Book.objects.filter(pk=1).update(publish=publish)
```

### 多对一删除

```python
# 一先拿到publish对象
publish = Publish.objects.get(pk=2)
# 二filter查出queryset对象然后执行update
Book.objects.filter(pk=1).delete(publish=publish)
```

### orm增加操作多对多

#### 增加方式一 add传入对象

```python
shouyue = Author.objects.get(pk=1)
douli = Author.objects.get(pk=2)
book = Book.objects.get(pk=1)
book.authors.add(shouyue,douli)
```

#### 增加方式一 add传入id

```python
book = Book.objects.get(pk=1)
book.authors.add(2,3)
```

### orm删除操作多对多

#### 删除方式一 remove传入对象

```python
shouyue = Author.objects.get(pk=1)
douli = Author.objects.get(pk=2)
book=Book.objects.get(pk=1)
book.authors.remove(shouyue,douli)
```

#### 删除方式一 remove传入id

```python
book=Book.objects.get(pk=1)
book.authors.remove(1,2)
```

#### 清空clear

```python
book = Book.objects.get(pk=1)
book.authors.clear()
```

#### 先清空在修改set

```python
shouyue = Author.objects.get(pk=1)
douli = Author.objects.get(pk=2)
book = Book.objects.get(pk=3)
book.authors.set([shouyue,douli])
# 也可以
book.authors.set([1,2])
```

## 基于基于对象的跨表查询的查询

基于对象的查询实质上是子查询

### 正向

关联字段在谁那里

### 一对一正向查询

查询shouyue作者的手机号

 手机号在AuthorDetail里面   正向查询  跨表的话,按字段

```python
shouyue=Author.objects.get(pk=2)
authordetail=shouyue.authordetail
print(authordetail.phone)
```

### 一对一反向查询

跨表的话,按表名小写

```python
authordetail=AuthorDetail.objects.get(pk=1)
author=authordetail.author
print(author.name)
```

#### 相同地址有不同的作者和电话2组一对一

```python
authordetail=AuthorDetail.objects.filter(addr= '长沙')
    print(authordetail)
    for i in authordetail:
        print(i)
        author=i.author
        print(author.name)
```

### 多对多正向查询  按字段.all()

```python
book=Book.objects.filter(name='红楼梦').first()
authors=book.authors.all()
print(authors)
```

### 多对多反向查询得到的是queryset对象

```python
shouyue=Author.objects.filter(name='shouyue').first()
books = shouyue.book_set.all()
print(books)
```

## 打印查询的sql

```python
# 在settings里面配置

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'handlers': {
        'console':{
            'level':'DEBUG',
            'class':'logging.StreamHandler',
        },
    },
    'loggers': {
        'django.db.backends': {
            'handlers': ['console'],
            'propagate': True,
            'level':'DEBUG',
        },
    }
}
```

## 基于双下划线的查询

### 双下划线正向的理解

字段__字段 

### 双下划线反向的理解

表名__字段

### 基于双下划线的查询一对一

#### 正向查询跨表按values（字段__字段 ）

```python
phone=Author.objects.filter(name ='shouyue').values('authordetail__phone') 
print(phone)
```

#### 反向查询跨表按表名小写filter(表名__字段)

```python
authordetail=AuthorDetail.objects.filter(author__name='shouyue').values('phone')
print(authordetail)
```

##### 注意也可以查询多个字段

```python
phone=Author.objects.filter(name='shouyue').values('sex','authordetail__phone')
print(phone)
```

无论是正向和反向 filter values都可以跨表

##### 练习

```python
查询手机号是123333333 作者的性别
正向  按字段
sex=Author.objects.filter(authordetail__phone='123333333').values('sex')
print(sex)
反向  按表名
sex = AuthorDetail.objects.filter(phone= '123333333').values('author__sex')
print(sex)
```

### 基于双下划线的查询一对多

#### 正向查询

```python
# 正向查询
books=Book.objects.filter(publish__name='北京出版社').values('name','price')
print(books)
```

##### 正向查询增加模糊查询gt大于

```python
# 正向查询北京出版社大于100元的书
books=Book.objects.filter(publish__name='北京出版社',price__gt=100).values('name')
print(books)
```

#### 反向查询

```python
# 反向查询
    books=Publish.objects.filter(name='北京出版社').values('book__name','book__price')
    print(books)
```

##### 反向查询增加模糊查询gt大于

```python
# 反向查询北京出版社大于100元的书
books=Publish.objects.filter(name='北京出版社',book__price__gt=100).values('book__name')
print(books)
```

### 基于双下划线的查询多对多

#### 查询红楼梦所有作者的名字

##### 正向

```python
authors=Book.objects.filter(name='红楼梦').values('authors__name')
print(authors)
```

##### 反向

```python
authors = Author.objects.filter(book__name= '红楼梦').values('name')
print(authors)
```

#### 查询红楼梦所有作者的名字对应其他书的名字

###### 正向

```python
# 正向
authors = Book.objects.filter(name='红楼梦').values('authors__book__name', 'authors__name')
print(authors)
```

###### 反向

```python
# 反向
authors=Author.objects.filter(book__name='红楼梦').values('name','book__name')
print(authors)
```

#### 查询北京出版社出版过所有作者出版过的书籍的名字以及作者的名字

```python
books=Publish.objects.filter(name='北京出版社').values('book__authors__name','book__name')
    print(books)
```

#### 查询以12开头的作者出版过的所有书籍名字以及出版社的名字

##### 通过AuthorDetail表开始查询

```python
ret=AuthorDetail.objects.filter(phone__startswith=12).values('author__book__name','author__book__publish__name')
print(ret)
```

##### 通过Book表开始查询

```python
ret=Book.objects.filter(authors__authordetail__phone__startswith=12).values('name','publish__name')
print(ret)
```



## django之on_delete

### on_delete=None

```python
 删除关联表中的数据时,当前表与其关联的field的行为 
```

### on_delete=models.CASCADE

```python
级联删除

 删除关联数据,与之关联也删除 
```

### on_delete=models.DO_NOTHING

```python
删除关联数据,什么也不做 
```

### on_delete=models.PROTECT

```python
删除关联数据,引发错误ProtectedError 
```

### on_delete=models.SET_NULL

```python
models.ForeignKey('关联表', on_delete=models.SET_NULL, blank=True, null=True) 

 \# 删除关联数据,与之关联的值设置为null（前提FK字段需要设置为可空,一对一同理） 
```

### on_delete=models.SET_DEFAULT

```python
 models.ForeignKey('关联表', on_delete=models.SET_DEFAULT, default='默认值') 

 \# 删除关联数据,与之关联的值设置为默认值（前提FK字段需要设置默认值,一对一同理） 
```

### on_delete=models.SET

```python
# 删除关联数据,
a. 与之关联的值设置为指定值,设置：models.SET(值)
b. 与之关联的值设置为可执行对象的返回值,设置：models.SET(可执行对象)
```

