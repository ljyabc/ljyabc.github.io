---
title: django之聚合函数
tags: [lnhdjango基础]
date: 2021-04-30 16:26:28
categories: 理解
photos:
book:
---

# django之聚合函数之分组查询

## 聚合查询aggregate

```python
# 计算图书的最高价格, 最低价格, 平均价格, 总价
from django.db.models import Avg,Count,Max,Min,Sum
ret = Book.objects.all().aggregate(Avg('price'))
print(ret)

ret = Book.objects.all().aggregate(Max('price'))
print(ret)
ret=Book.objects.all().aggregate(Max('price'),Min('price'),Avg('price'),Sum('price'))
print(ret)
```

## 聚合查询Count

```python
# 统计每一本书作者的个数
ret = Book.objects.all().annotate(c=Count('authors')).values('name','c')
print(ret)
```

## 以谁group by 就以谁为基表

```python
# 统计每一个出版社最便宜的书 （以谁group by 就以谁为基表）
ret = Publish.objects.all().annotate(m= Min('book__price')).values('name','m')
print(ret)
```

## 综合训练

```python
# 统计书的名字是py开头的书籍的作者个数
    ret=Book.objects.filter(name__startswith='py').annotate(c=Count('authors')).values('name','c')
    print(ret)
```

## 分组规律

### values在前,表示group by  不写代表id分组          在后,表示取值

```python
# 查询各个作者出的书的总价格
ret=Author.objects.all().values('name').annotate(s=Sum('book__price')).values('name','s')
print(ret)
```

```python
# 统计大于一个作者的图书
ret = Book.objects.all().annotate(c=Count('authors')).filter(c__gt=1).values('name','c')
print(ret)
```

### filter在前,表示where条件,在后表示having

```python
# 查询所有作者写的书的总价格大于30的
    ret=Author.objects.all().filter(id__gt=2).values('id').annotate(s=Sum('book__price')).filter(s__gt=30).values('name','s')
    print(ret)
```

### 先where和先group by 无所谓先后

```python
ret = Author.objects.all().values('name').filter(id__gt=2).annotate(s=Sum('id')).values('name','s')
print(ret)
# 先where和先group by 无所谓先后
ret = Author.objects.all().filter(id__gt=2).values('id').annotate(s=Sum('id')).values('name','s')
print(ret)
ret = Author.objects.all().values('id').filter(id__gt=2).annotate(s=Sum('id')).values('name', 's')
print(ret)
```

