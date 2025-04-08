---
title: django之多对多的关系三种写法
tags: [lnhdjango基础]
date: 2021-05-05 14:40:51
categories: 理解
photos:
book:
---

# 多对多的关系,三种写法

## 1.手动创建第三张表(不创建关联关系)

```python
class Book(models.Model):
				# 默认会创建id
     name = models.CharField(max_length=32)
class Author(models.Model):
	name = models.CharField(max_length=32)
class Book2Author(models.Model):
	id = models.AutoField(primary_key=True)
	book=models.ForeignKey(to='Book',to_field='id')
	author=models.ForeignKey(to='Author',to_field='id')
			-不管是插入和查询,删除,都很麻烦(一般不用)
```

## 2.自动创建第三张表

**注意：**

- related_name 关联对象反向引用描述符 - 通过book可以引用到Book表中对象
- 只需要操作两个表在models内
- 以为未在models内操作第三张表，所以后期对第三张表的操作无法添加字段**（可以通过服务器，但是不推荐）**

```python
from django.db import models
 
class Book(models.Model):
    title = models.CharField(max_length=32, verbose_name="书名")
    # verbose_name admin中显示的表名称
 
 
class Author(models.Model):
    name = models.CharField(max_length=32, verbose_name="作者姓名")
    # 通过ORM自带的ManyToManyField自动创建第三张表
    books = models.ManyToManyField(to="Book", related_name="authors")
    # related_name 关联对象反向引用描述符 - 通过book可以引用到Book表中对象
    # Book.object.filter(name = '红楼梦').authors.all() - 获取book表内红楼梦的所有作者
    # 可解决外键重名问题
```

### models

```python
from app03 import models as m3

# 第三种方式，全自动创建

# 查询红楼梦这本书的所有作者

book = m3.Book.objects.filter(title='红楼梦').first()
print(book)

# 通过 related_name="authors"

print(book.authors.all())

# 通过反向查询 被relate_name代替无法操作

# print(book.author_set.all())

# 正向查询 查询作者名叫n1的所有书籍

a = m3.Author.objects.filter(name='n1').first()
print(a)
print(a.books.all())

#   给红楼梦这本书添加n这个作者

author = m3.Author.objects.filter(name='n1').first()
print(author)
book = m3.Book.objects.filter(title='红楼梦').first()

# 使用add添加

author.books.add(book)

-查询,插入,删除,都很方便

-缺点:字段是固定的,第三张表如果要添加字段,实现不了
```



## 方式三、半自动创建第三张表 -- 手动创建第三张表+ManyToMany建立关系（推荐使用）

**注意：**

- through('A2B表名') ：指定手动创建的中间关系表（A2B）
- through_fields('A2B表内当前表关系字段'，'A2B表内关系表的字段'):中介模型
- 三张表都建立了内部联系，可以使用双下划綫和基于对象的正方形查询方式

```python
from django.db import models
# Create your models here.
 
# 手动创建第三张表,查询还方便的查询
class Book(models.Model):
    # 默认会创建id
    name = models.CharField(max_length=32)
    # 中介模型,手动指定第三张中间表是Book2Author
    authors = models.ManyToManyField(to='Author', through='Book2Author', through_fields=('book', 'author'))
 
 
class Author(models.Model):
    name = models.CharField(max_length=32)
 
    def __str__(self):
        return self.name
 
 
class Book2Author(models.Model):
    id = models.AutoField(primary_key=True)
    book = models.ForeignKey(to='Book', to_field='id')
    author = models.ForeignKey(to='Author', to_field='id')
```

### models

```python
from app02 import models as mo2
 
#     第二种方式 半自动
 
# 基于对象的查询(存在正向反向)
# 查询红楼梦这本书所有的作者 -正向
book = mo2.Book.objects.filter(name='西游记').first()
print(book.authors.all())
 
# n1作者查书名 - 反向
a = mo2.Author.objects.filter(name='n1').first()
print(a.book_set.all())
 
 
# 基于双下划线的查询（可以简单忽视正反）
# 查询红楼梦这本书所有的作者的名字
ret=mo2.Author.objects.filter(book__name='西游记').values('name')
print(ret)
 
 
# 删除,给西游记这本书,删除n2这个作者
ret=mo2.Book2Author.objects.filter(book__name='西游记',author__name='n2').delete()
print(ret)
 
```

```python
class Book(models.Model):
				# 默认会创建id
				name = models.CharField(max_length=32)
				# 中介模型,手动指定第三张中间表是Book2Author
				authors=models.ManyToManyField(to='Author',through='Book2Author',through_fields=('book','author'))
			class Author(models.Model):
				name = models.CharField(max_length=32)
				def __str__(self):
					return self.name
			class Book2Author(models.Model):
				id = models.AutoField(primary_key=True)
				book=models.ForeignKey(to='Book',to_field='id')
				author=models.ForeignKey(to='Author',to_field='id')
				
			-through:来指定我的第三张表是哪个
			-through_fields:('book','author'),第一个值是:从中间表找到设置关联字段的表,通过哪个字段,第一个位置就写它
			-终极总结:防止混了:关联字段就是表名小写,第一个值:就是当前表的表名小写
			-查询,新增,删除,都很方便
			-第三张表,可以添加别的字段
```

