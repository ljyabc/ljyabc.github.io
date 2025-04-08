---
title: djangoF函数和Q函数
tags: [lnhdjango基础]
date: 2021-04-30 15:05:13
categories: 理解
photos:
book:
---

# djangoF和Q查询

## F函数

```python
from django.db.models import F

# 查询评论数大于阅读数的书
# 这样不行,进行不下去了
# ret=Book.objects.all().filter(commit_num__gt=reat_num)
# 这么来做
ret=Book.objects.all().filter(commit_num__gt=F('reat_num'))
print(ret)
# 把所有书的评论数加1
# 不行,进行不下去
# ret=Book.objects.all().update(commit_num+=1)
# 不行,进行不下去
# ret=Book.objects.all().update(commit_num=commit_num+1)
# 这样来做
# ret=Book.objects.all().update(commit_num=F('commit_num')+1)
# print(ret)
# 把python这本书的阅读数减5
ret = Book.objects.all().filter(name='python').update(reat_num=F('reat_num') - 5)
print(ret)
```

## Q函数

```
为了表示与& ,或 | ,非 ~,
```

```python
from django.db.models import Q
# 查询作者名字是shouyue或者名字是douli的书
# 这样行不通
# ret=Book.objects.all().filter(authors__name='shouyue',authors__name='douli')
# 这样出来
ret=Book.objects.all().filter(Q(authors__name='shouyue')|Q(authors__name='douli'))
print(ret)
# 没有意义
# ret = Book.objects.all().filter(Q(authors__name='shouyue') & Q(authors__name='douli'))
# print(ret)
# 查询作者不是shouyue的书
ret=Book.objects.filter(~Q(authors__name='shouyue'))
print(ret)
#     构建很复杂的逻辑,需要用括号来区分
ret = Book.objects.filter((Q(name='红楼梦') & Q(price__gt=100)) | Q(pk__gt=2))
print(ret)
```

