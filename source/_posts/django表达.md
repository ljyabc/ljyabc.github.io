---
title: django表达
tags: [django]
date: 2019-04-21 20:00:18
categories:
photos:
book:
---

## web应用

是一种可以通过web访问的应用程序，最大的好处就是用户可以很容易访问应用程序，用户只需要在浏览器中打开网页，不需要安装其他软件。

## http协议

http协议是超文本传输协议
是一个属于应用层的面向对像的协议
浏览器作为http的客户端，通过url向及web服务器发送所有请求，web服务器收到请求后，向客户端发送响应消息

## ORM

数据库中的表---->ORM----->类的对象
核心：
将表中的记录，变成一个个表类的对象，可以.属性拿到这些记录的值
将对象的属性，转成表中的一个个记录，可以插入到表中，完成对表的增删改查


字段

直接看或者注释

记录

models.类名.objects.create(name=name,password=pwd,address=addr)

django请求的生命周期

客户端发出请求 <--> web服务器（遵循wsgi协议） <--> 中间件<-->url路由层<-->视图层(views)<-->模型层<-->模板层

url到视图层到模板和数据库把数据库的数据渲染到模板上



路由层

匹配视图函数的

有名,无名

django1.0是url,2.0是path

代表视图函数的参数

反向解析

其实就是利用路由层的一个别名,然后再模板层去获得该地址,或者视图层获得该地址

路由分发

再总的路由里面配置下面的路由

视图层

传递变量

全部

  return render(request, "index.html", locals())

单独

  return render(request, "index.html", 单独)

JsonResponse

HttpResponse

CBV和FBV

类的视图还是函数的视图

上传功能

    1.模板层
    <form action="" method="post" enctype="multipart/form-data">
        <input type="file" name="my_file" value="请选择文件">
        <button type="submit">提交</button>
    </form>
    
    2.视图层
    def fileupload(request):
        if request.method=='GET':
        	return render(request,'fileupload.html')
        if request.method=='POST':
            # FILES
            print(request.FILES)
            print(type(request.FILES.get('myfile')))
            # 从字典里根据名字,把文件取出来
            myfile=request.FILES.get('myfile')
            from django.core.files.uploadedfile import InMemoryUploadedFile
            # 文件名字
            name=myfile.name
            # 打开文件,把上传过来的文件存到本地
            with open(name,'wb') as f:
                # for line in myfile.chunks():
                for line in myfile:
                    f.write(line)
            return HttpResponse('ok')

模板层

变量

视图部分传递给模板层

过滤器

竖杠后面加入条件

标签

forloop

自定义过滤器

创建文件夹,创建文件py,导入模块,对象,装饰器函数

再模板层导入py文件传入参数

```
{% load mytag %}

{{'lqz'|str_add:'nb'}}
```

自定义标签

6 在模板里:(多个参数,以空格区分)

```
{% load mytag %}

{% add_nb 'lqz'%}
```

模板的导入(重复使用)

```
{% include "模板的名字" %}
```

模板的继承



### 

光继承母版,加入新内容,母版父级也要,重写block，super重用父级的功能

### 静态文件

> 1.STATIC_URL = '/static'  一般不要改

2.创建一个static文件夹       一般不要改
3.STATICFILES_DIRS = [
    os.path.join(BASE_DIR,'static'),
]

## 数据库操作

### 数据库迁移命令

makemigrations做了一个记录

migrate建立表格

showmigrations提交到数据库

### 查询的api（接口）

#### 增加

##### 一

create创建

##### 二

先实例化产生对象，然后调用save方法

#### 修改和删除

##### 一

update(),delete()

##### 二

save

#### 查询

all()

filter() 相当于sql中的where

get() 有且只有一个结果，返回的是表中的一条记录

exclude() 查询名字不叫西游记的书，结果也是queryset的对象

order_by() 按指定字段排序，默认是asc，-号是desc

reverse() 对排序后的结果进行反向排序（一定是排序后的结果，否则报错）

count() 查询结果的个数，是int类型

last() 对queryset的对象取最后一个，得到的是book的对象

exists 判断查询的结果是否存在，返回结果是布尔类型

values(*field) 返回queryset的对象，里面套字典，字典里面拥有的字段名为values里面的字段名

value_list() 返回时queryset对象，里面是元祖，元祖里面是value_list里面的字段名

distinct() 必须完全一样,才能去重   只要带了id,去重就没有意义了

#### 模糊查询

大于,小于,包含,范围,开头,结尾,按年查询

## 创建模型

 一对一的关系:OneToOneField

一对多的关系:ForeignKey

多对多的关系:ManyToManyField

### 一对多的增删改

#### 增

from app1.models import *

##### 一

多的.objects.create(多加了一个一对多对象的id)

##### 二

少的.objects.get(pk=)

#### 删



### 多对多的增删改

一样

### 基于对象的跨表查询

#### 一对一

正向 author --关联字段在author中 --->author_detail   ----按字段
反向 author_detail --关联字段在author中 -->author    ----按表名小写

#### 一对多

正向 book --关联字段在book中 --->publish   ----按字段
反向 publish --关联字段在book中 -->book   ----按表名小写_set.all() queryset对象

#### 多对多:都得用all()

正向 book --关联字段在book中 --->author   ----按字段.all()
反向 author --关联字段在book中 -->book   ----按表名小写_set.all() queryset对象

### 基于双下划线的连表查询

正向 双 反向 单