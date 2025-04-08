---
title: django自定义转换器
tags: [lnhdjango基础]
date: 2021-04-30 18:55:18
categories: 理解
photos:
book:
---

# 自定义转换器

## 2 django 2.0和django 1.0 路由层区别

1.(*****url,re_path分组分出来的数据,是字符串)

2.-re_path:跟1.0的url用法相同

3.但是django2.0加了一个

-path:传的路径,是准确路径
			5个转换器-->path('test/<path:year>', views.re_test),
			str,匹配除了路径分隔符（/）之外的非空字符串，这是默认的形式
			int,匹配正整数，包含0。
			slug,匹配字母、数字以及横杠、下划线组成的字符串。
			uuid,匹配格式化的uuid，如 075194d3-6885-417e-a8a8-6c931e272f00。
			path,匹配任何非空字符串，包含了路径分隔符（/）（不能用？）

## 1 定义一个类:

在django2.0里面使用

```python
class MyCon:
    # 写一个正则表达式
    regex = '[0-9]{4}'
    # 匹配出來的数据,会传到这里,retrun回去的,会被视图函数接收
    def to_python(self, value):
    	return int(value)
    # 反向解析用的
    def to_url(self, value):
    	return '%04d' % value
```

## 2 导入模块和类和路由名字

```python
from django.urls import register_converter
# 传入类名MyCon和路由名字yyy
register_converter(MyCon,'yyy')
```

## 3.写路由

```python
path('test/<yyy:year>', views.re_test,name='test'),
```

