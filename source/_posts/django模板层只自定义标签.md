---
title: django模板层只自定义标签
tags: [django模板自定义标签]
date: 2021-05-05 14:32:00
categories: 理解
photos:
book:
---



# 模板层之自定义标签

## 作用

```python
-干什么用的?生成html的片段(动态,传参数,传数据)

-app下新建一个模块,templatetags
		-创建一个py文件(mytag.py)
		-from django.template import Library
		-register=Library()   ----->register名字一定不能变
		-写装饰器(标签,过滤器,inclusion_tag)
		-@inclusion_tag('模板路径',name='重命名')
		-def my_in():  不写,写多个,不写不传,写多个,按空格来传参
		-	一堆逻辑处理,查数据库
		-	ret=Book.object.all()
			return {''books':ret}
		-在模板中:
			可以用books这个变量,渲染页面
		-应用:
			-在另一个模板中:
			-{%load mytag.py%}
			-{% my_in %}
```

## 第一步

 先app01是不是已经在setting中注册 

```python
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'app01.apps.App01Config',
]
```

## 第二步

 在app01下创建一个templatetags(名字不能变)的文件夹(模块) 

## 第三步

 在模块下创建一个py文件,名字随意:mytag.py 

## 第四步

### mytag.py中的内容：

```python
# 第一种导入方式
# 第一步,导入template
# from django import template
# 第二步,定义一个叫register的变量=template.Library()
# register = template.Library()

# 或者
from django.template import Library

register = Library()

# 第三步的第一种
@register.filter()
def sadd(str1):
    # 业务逻辑很复杂哦
    return str1 + 1

# 第三步的第一种
@register.filter(name = 'myadd')
def sadd(str1):
    # 业务逻辑很复杂哦
    return str1 + 1
```

### 对应模板层

第四步第一种模板直接调用函数sadd函数

```
{% load mytag %}
{{ 3|sadd }}
```

第四步第二种在模板中使用 myadd 是解析 ， 

```
{% load mytag %}
{{ 4|myadd }}
```

## 自定义过滤器

```python
-1-4:前4步,根过滤器的定义完全一样
			-5 只是装饰器不一样
			@register.simple_tag()
				def add_nb(value):
					return value+'nb'
			-6 在模板里:(多个参数,以空格区分)
				-{% load mytag %}
				-{% add_nb 'lqz'%}
```

但是不能用if判断