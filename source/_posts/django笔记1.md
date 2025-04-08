---
title: django笔记1
tags: [python框架]
date: 2019-03-02 21:21:50
categories: python入门到放弃系列
photos:
---

## 	 django框架

[1 基于wsgiref定义自己的web框架.note](note://46CB3A338625422DB670C27B90E075C9) 

[0 基于socket手写web框架.note](note://98E45DBC41A44E419CC601DB5CF8C89C) 

### day01

#### 1.web应用

- web应用：

   ```
   web应用：是一种可以通过web访问的应用程序，最大的好处就是用户可以很容易访问应用程序，用户只需要在浏览器中打开网页，不需要安装其他软件。
   cs架构
   web应用：大部分是基于b/s架构的程序。
   ```

- web应用的优点

  ```python
  1.只需要一个浏览器即可。
  2.网络应用程序通常耗费很少的用户硬盘空间。
  3.不需要更新，所有的特性都是在服务器上执行，从而自动传达给用户端
  4.和服务器端的网络产品很容易结合，如email功能和搜索功能
  5.因为在网络浏览器窗口中运行，所以大部分情况下可以跨平台使用
  ```

- web应用的缺点

  ```
  1.特别强调浏览器的适用性
  2.如果连接出现问题，应用将不能访问
  3.不能针对用户定制化，个性化
  4.理论上可以检索任何用户的行为，这可能带来隐私安全问题
  ```

- 总结

  ```
  本质上：浏览器是一个socket客户端，服务器是一个socket服务端
  ```

#### 2.http协议

- 什么是http协议

- ```
  http协议是超文本传输协议
  是一个属于应用层的面向对像的协议
  浏览器作为http的客户端，通过url向及web服务器发送所有请求，web服务器收到请求后，向客户端发送响应消息
  ```

  http协议的特性

  ```
  1.基于tcp（传输层）/ip（网络层）协议之上的应用层协议
  2.基于请求，响应模式
  	协议规定：请求从客户端发出，最后服务器端响应请求并返回
  3.无状态保存：http协议自身不对请求和响应之间通信状态进行保存，也就是说http协议对于请求和发送不做持久化处理
  注意：
  	由于http无状态保存，所以为了持久化处理，引入了cookie技术，有了cookie再用http协议通信，就可以管理状态了。
  4.无连接：无连接的含义是限制每次连接只处理一个请求。服务器处理完客户请求，并受到客户的应答后，即断开连接。采用这种方式可以节省传输时间。
  ```

- http请求协议与响应协议

  ```
  http请求协议：
  请求首行：
  post(请求方式：POST/GET) /form/index HTTP/1.1
  请求首部字段(请求头):
  Host：127.0.0.1
  Connection:keep-alive
  Content-Type:application/x-www-form-urlencoded
  Content-Length:16
  请求体：
  name = ueno&age = 33
  ```
  ```
  请求方式：get与post请求
  1.GET提交的数据会放在url之后，以？分割url和传输数据，参数之间以&相连，如?name = test1&id = 1。
  POST方法是把提交的数据放在http包的请求体中。
  
  2.GET提交的数据大小有限制（因为浏览器的url的长度有限制），而POST方法提交的数据没有限制。
  
  3.GET与POST请求在服务端获取请求数据方式不同
  ```

- 响应协议

- ```
  状态行：协议版本 状态码 状态码描述 
  HTTP/1.1 200 OK
  
  响应头部：
  头部字段名：值 \r\n
  
  响应正文：
  ```

  响应状态码

  | 状态码 | 类别             | 原因短语                   |
  | ------ | ---------------- | -------------------------- |
  | 1xx    | 信息性状态码     | 接受的请求正在处理         |
  | 2xx    | 成功状态码       | 请求正常处理完毕           |
  | 3xx    | 重定向状态码     | 需要进行附近操作以完成请求 |
  | 4xx    | 客户端错误状态码 | 服务器无法将处理请求       |
  | 5xx    | 服务器错误状态码 | 服务器处理请求出错         |

- url简介

  ```
  统一资源定位符是对可以从互联网上得到的资源的位置和访问方法的一种简洁的表示，是互联网上标准支援你的地址。互联网上标准资源的地址，互联网上的每个文件都有一个唯一的url，它包含的信息支出文件的位置以及浏览器应该怎么处理它
  
  格式：
  协议：//ip:端口(80) /路径?name=lqz$age=age=18
  
  ?之前的是请求路径，？之后的是请求数据部分
  ```

#### 3.python中的web主流的框架(MVC)

![clipboard](django笔记1\clipboard.png)

![clipboard1](django笔记1\clipboard1.png)

![clipboard2](django笔记1\clipboard2.png)

```
a：socket b:路由和视图匹配关系 c:模板渲染

django: a：用了wsgiref b：自己 c:自己
flask: a:用了别人的 b：自己 c:jinja2
tornado：a：自己 b:自己 c:自己
```

![img](django笔记1\01.png) 

![img](django笔记1\2.png) 

![img](django笔记1\ard.png) 

![img](django笔记1\rd.png) 

![img](django笔记1\cliboard.png) 

![img](django笔记1\aclipboard.png) 

![img](django笔记1\clipbossard.png) 

### 6 内容总结 

6 内容总结

![img](django笔记1\clipb1oard.png)

![img](django笔记1\clipb2oard.png)

![img](django笔记1\clipbo4ard.png)

django安装

1.几大部分

![img](django笔记1\clipboard02.png)

![ig](django笔记1\clipboard03.png)

![img](django笔记1\clipboard04.png)

![img](django笔记1\clipboard05.png)

![img](django笔记1\clipboard06.png)

![img](django笔记1\clipboard07.png)

可以有多个APP

![img](django笔记1\clipboard08.png)

![img](django笔记1\clipboard09.png)

![ig](django笔记1\clipboard10.png)

注意事项

![ig](django笔记1\clipboard11.png)

![ig](django笔记1\clipboard12.png)

命令运行django

![mg](django笔记1\clipboard13.png)

![mg](django笔记1\clipboard14.png)

![ig](django笔记1\clipboard15.png)

- django安装

  ```
  下载django
  1.pip install django==1.11.9 
  
  创建项目
  2.django-admin startproject 项目名 
  
  创建app
  3.python manage.py startapp app01
  
  运行项目
  4.python mansge.py runserver 127.0.0.1:8001
  ```

- django文件目录

  ```
  manage.py   项目的入口，执行一些命令
  settings    全局配置信息
  urls        总路由，请求地址和视图函数的映射关系
  migrations  数据库迁移的记录
  models      数据库表模型
  views       视图函数
  ```

### day02

#### 1.django中的app的概念

```
大学：项目
信息学院：app01
物理学院：app02
注意：创建了app，要在配置文件中注册
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

#### 2.模板路径配置

```
1.templates文件夹
2.settings里注册一下
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')]
        ,
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]
```

#### 3.静态文件配置

![1552228994449](C:\Users\aaa\AppData\Local\Temp\1552228994449.png)

```
1.STATIC_URL = '/static'  一般不要改
2.创建一个static文件夹       一般不要改
3.STATICFILES_DIRS = [
    os.path.join(BASE_DIR,'static'),
]
```

#### 4.完整版登录功能

- ##### templates（模板）

  ```
  1.login.html
  	1.1 action:提交到后台的地址三种写法：
          http://127.0.0.1:8000/login
          /login/
          不写
  	1.2 method post方式
  	1.3 input type="submit" value= "提交" 或 button
  
  ```

- ###### views（视图层）

  ```python
  1.request.method  前台提交过来请求的方式POST/GET
  2.request.POST(相当于字典) post形式提交过来的数据
  3.request.POST.get('name') 通过key取值，取出列表的最后一个值
  4.request.POST.getlist('name') 通过key取出列表的所有元素
  
  注意：前台GET方式提交的数据，从request.GET字典中取值
  ```

- 连接数据库(防止sql注入，推荐以下写法)

  ```
  cur.execute('select * from user where name=%s and password=%s',[name,pwd])
  ```

#### 5.GET请求和POST请求

```
get：获取数据，页面，携带数据是不重要的数据（数据量有大小限制）

post：往后台提交数据，没有长度限制
```

#### 6.新手三件套总结

```
1.render 返回页面，默认会templates里找，注意路径
book_list = models.BookList.objects.values()
    return render(request, 'select.html', {'book_list': book_list})
    
2.redirect 重定向
return redirect('http://www.baidu.com')

3.HttpResponse 返回的是HttpResponse的对象
```

#### 7.pycharm连接数据库

![1552229746713](django笔记1\1552229746713.png)

```
参靠视频
```

#### 8.orm介绍

```
1.orm即object relational mapping ，对象关系映射
优点：
	不用写sql语句
	开发效率高
缺点：
	可能sql效率低

2.如何使用
	如果连接mysql，在setting里配置
	DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'HOST': '127.0.0.1',
        'PORT': 3306,
        'USER': 'root',
        'PASSWORD': '123',
        'NAME': 'homework',
    }
}

3.django-orm
	3.1 不能创建数据库（需要手动创建数据库）
	3.2 可以创建数据表
	3.3 可以创建字段
	
4.数据库迁移
	4.1 python manage.py makemigrations
	4.2 python manage.py migrate
```

![1552231144528](django笔记1\1552231144528.png)

9.orm创建表

```
class BookList(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=32)
    price = models.CharField(max_length=32)
    author = models.CharField(max_length=32)
    publish = models.CharField(max_length=32)
```

### day3

#### 一.orm操作表，记录

#### 1.orm增加字段(table操作)

方法一

![1552233166530](django笔记1\1552233166530.png)

二

```django
models.py里面添加一个字段，一定要给增加的字段设为初始值，为null都可以，然后重新数据库迁移
phone=models.CharField(max_length=64,default='120')
```

#### 2.orm删除字段

```
models.py里面将字段删除，然后重新数据库迁移,注释也可以
```

#### 3.orm修改字段

```
models.py里面讲修改的字段，需要修改的东西写好，然后数据库迁移
```

#### 4.orm查字段

```
models.py里面看看就可以了
```

#### 5.orm添加记录

```
user=models.User.objects.create(name=name,password=pwd,address=addr)
```

#### 6.orm删除记录

```
ret = models.User.objects.filter(id=id).delete()
```

#### 7.orm修改记录

```
models.User.objects.filter(id=id).update(name=name, password=pwd, address=addr)
```

#### 8.orm查询记录

出来的是对象可以全部,可以点字段出想要的数据

![1555849029706](django笔记1\1555849029706.png)

![1552234194253](django笔记1\1552234194253.png)

![1552234212442](django笔记1\1552234212442.png)

###### 数据在reder里面就已经替换完成

```
ret = models.User.objects.all()列表
ret = models.User.objects.filter（id=id).first()
```

#### 二.django中前端向后端发送请求后携带值得2种方式

- 方式一

  ```html
  <form action="/updateuser/?id={{ user.id }}" method="post">
      <p>用户名: <input type="text" name="name" value="{{ user.name }}"></p>
      <p>密码: <input type="text" name="password" value="{{ user.password }}"></p>
      <p>地址: <input type="text" name="addr" value="{{ user.address }}"></p>
      <input type="submit" value="提交">
  </form>
  
  注意：后端如何取值
  id = request.GET.get("id")
  ```

- 方式二

  ```html
  <p><input type="hidden" name="id" value="{{ user.id }}"></p>
  
  注意：后端如何取值
  id = request.POST.get("id")
  ```

#### 三.django请求的生命周期

```python
客户端发出请求 <--> web服务器（遵循wsgi协议） <--> 中间件<-->url路由层<-->视图层(views)<-->模型层<-->模板层
```

### day4

#### 一.	路由层

##### 简单配置

```python
1.第一个参数是正则表达式（如果要精准匹配：url(r'^admin/$', admin.site.urls)）

2.第二个参数是视图函数（不要加括号）

3.为假,路径不会加反斜杠
APPEND_SLASH=False

```
##### 无名分组

```python
按位置传参
分组过后，会把分组出来的数据，当做位置参数，传到视图函数，所以视图函数需要定义形参。

eg:
url(r'^publish/([0-9]{4})/([0-9]{2})$', views.publish),

def publish(request,*args):   视图函数可以这样接收
```
##### 有名分组

```python
按关键字传参
有名分组出来之后，会把分出出来的数据，当关键字参数，传到视图函数中，所以视图函数需要定义形参，形参的名字和分组名对应，与顺序无关。

eg:
url(r'^publish/(?P<year>[0-9]{4})/(?P<mounth>[0-9]{2})/$', views.publish),

def publish(request, mounth,year):
*****有名分组和无名分组,不要混用
```
##### 反向解析

是把一个

```python
1.先命一个名：
	1.1 无参数：
    url(r'^publishadd133/$',views.publishadd,name='ddd'),
    1.2 无名分组
    url(r'^publishadd/([0-9]{4})/([0-9]{2})/$', views.publishadd,name='ddd'),
    1.3 有名分组
    url(r'^publishadd/(?P<year>[0-9]{4})/(?P<mounth>[0-9]{2})/$', views.publishadd,name='ddd'),
```

```python
2.在模型层
	2.1 无参数
    {% url 'ddd' %}【
    2.2 无名分组
    {% url 'ddd' 2018 12 %}
    2.3 有名分组
    {% url 'ddd' 2018 12 %}  还可以 {% url 'ddd' year=2018 mounth=12 %}
```

```python
3.在视图层
from django.shortcuts import reverse
	3.1 无参数
    url=reverse('ddd')
    3.2 无名分组
    url=reverse('ddd',args=(2018,12,)) 
    3.3 有名分组
    url=reverse('ddd',args=(2018,12,)) 还可以 url=reverse('ddd',kwargs={'year':2018,'mounth':12})
```
##### 路由分发

创建APP

![1552488359923](django笔记1\1552488359923.png)

settings.py里面配置![1552488778206](django笔记1\1552488778206.png)

app的视图函数要和路由一致

![1552489301361](django笔记1\1552489301361.png)

![1552489506222](django笔记1\1552489506222.png)

```python
1. 在不同的app里创建urls.py

2. 在总路由 
导入 app01 urls
-from django.conf.urls import include 
-url(r'^blog/',include('blog.urls')),
-url(r'^app01/',include('app01.urls')),

3. 在不同的app的urls里配置路由关系	
***重点***总路由,不能加结束符$
```
##### 名称空间

这样不用多此一举加入名称空间

![1552489924936](django笔记1\1552489924936.png)

```python
1.url(r'^blog/',include('blog.urls',namespace='blog')),
子路由:url(r'^publish/$', views.publish,name='test'),
    反向解析:
        视图层:url = reverse('blog:test')
        模板层:{% url 'app01:test'%}
                ***一般不要用***
                子路由:url(r'^publish/$', views.publish,name='app01_test'),
```
##### 伪静态

```python
路由:url(r'^book/(?P<id>\d+.html)',views.book),
访问:http://127.0.0.1:8000/book/4.html
```
##### 根路径响应到指定

![552490897960](django笔记1\1552490963768.png)

### day5

#### 一.虚拟环境

```
1.虚拟环境的应用场景
在同一台电脑上可以同时运行多个不同版本的软件
```

```
2.通过virtualenv软件创建
安装：
	pip install virtualenv
创建虚拟环境：
	virtualenv env_django -->创建纯净环境
	virtualenv --system-site-packages env_django 继承原安装的模块
激活该虚拟环境：
	windows进入都目录里的script文件夹输入：active
退出虚拟环境：
	deactivate
```

```
3.在pycharm中创建虚拟环境
File--->New Project--> Project Interpreter：New Virtualenv environment
```

```
4.在pycharm下创建 新建项目
files--settings--Project--Project Interpreter--add选择虚拟环境路径下的python.exe即可
```

```
5.参数说明

Name中填写新虚拟环境的名字，或者使用默认名字，方便以后安装第三方包和其他项目使用；
在Location中填写新环境的文件目录;
在Base interpreter下拉框中选择Python解释器；
勾选Inherit global site-packages可以使用base interpreter中的第三方库，不选将和外界完全隔离；
勾选Make available to all projects可将此虚拟环境提供给其他项目使用。
```



#### 二.django2和django1的路由的区别

```
1.django1和django2的路由区别
django1中使用url
django2中使用path，或re_path
```

```python
path:传的路径,是准确路径
5个转换器-->path('test/<path:year>', views.re_test),
            str,匹配除了路径分隔符（/）之外的非空字符串，这是默认的形式
            int,匹配正整数，包含0。
            slug,匹配字母、数字以及横杠、下划线组成的字符串。
            uuid,匹配格式化的uuid，如 075194d3-6885-417e-a8a8-6c931e272f00。
            path,匹配任何非空字符串，包含了路径分隔符（/）（不能用？）
-自定义转换器
    1 定义一个类:
    class MyCon:
        # 写一个正则表达式
        regex = '[0-9]{4}'
        # 匹配出來的数据,会传到这里,retrun回去的,会被视图函数接收
        def to_python(self, value):
        	return int(value)
        # 反向解析用的
        def to_url(self, value):
       	 	return '%04d' % value
        
    2 from django.urls import register_converter
        register_converter(MyCon,'yyy')
    3 path('test/<yyy:year>', views.re_test,name='test'),
```

###### 反斜杠(settings.py里面)

![1552492082082](django笔记1\1552492082082.png)

#### 3.视图层之HttpResquest对象

![1552492635768](django笔记1\1552492635768.png)

```python
# 前台Post传过来的数据,包装到POST字典中
# request.POST
# 前台浏览器窗口里携带的数据,包装到GET字典中
# request.GET
# 前台请求的方式
# request.method
# post提交的数据,body体的内容,前台会封装成:name=lqz&age=18&sex=1
# request.body
# 取出请求的路径,取不到数据部分
# print(request.path)
# 取出请求的路径,能取到数据部分
# print(request.get_full_path())
# print(request.META)
```

#### 4.视图层之三件套

```python
三件套:render,HttpResponse,redirect
render函数:
    temp=Template('<h1>{{ user }}</h1>')
    con=Context({'user':'lqz'})
    ret=temp.render(con)
    print(ret)
    # return render(request,'index.html')
    return HttpResponse(ret)
```

#### 5.视图层之JsonResponse

```python
导入：
from django.http import JsonResponse
视图函数中：
def test(request):
    import json
    # dic={'name':'lqz','age':18}
    ll = ['name', 'age']
    # 把字典转换成json格式,返回到前台
    # return HttpResponse(json.dumps(dic))
    # 把列表转换成json格式,返回到前台
    # return HttpResponse(json.dumps(ll))
    # 把字典转换成json格式,返回到前台
    # return JsonResponse(dic)
    # 报错,默认不支持列表形式
    # return JsonResponse(ll)
    # 支持列表形式
    return JsonResponse(ll,safe=False)

注意：
如果json中包含中文，可以
return JsonResponse(list_new, safe=False, json_dumps_params={"ensure_ascii": False})
```

#### 6.CBV和FBV类的视图还是函数的视图

```python
基于类的视图
1 路由层:
url(r'^test/', views.Test.as_view()),
2 视图层
导入:
from django.views import View
写一个类:
class Test(View):
    def get(self, request):#一定要传request对象
    	return HttpResponse('get-test')

    def post(self, request):
    	return HttpResponse('post-test')
使用
url(r'^test/', views.Test.as_view()),

基于函数的视图	

```

#### 7.简单的文件上传功能

```html
1.模板层
<form action="" method="post" enctype="multipart/form-data">
    <input type="file" name="my_file" value="请选择文件">
    <button type="submit">提交</button>
</form>
```

```python
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
```

### day6

#### 1.模板层

```python
1.解释视图如何工作的
def current_datetime(request):
    now = datetime.datetime.now()
    html = "<html><body>It is now %s.</body></html>" % now
    return HttpResponse(html)
```

```python
2.为什么使用模板
对页面设计进行的任何改变都必须对 Python 代码进行相应的修改。 站点设计的修改往往比底层 Python 代码的修改要频繁得多，因此如果可以在不进行 Python 代码修改的情况下变更设计，那将会方便得多。

Python 代码编写和 HTML 设计是两项不同的工作，大多数专业的网站开发环境都将他们分配给不同的人员（甚至不同部门）来完成。 设计者和HTML/CSS的编码人员不应该被要求去编辑Python的代码来完成他们的工作。

程序员编写 Python代码和设计人员制作模板两项工作同时进行的效率是最高的，远胜于让一个人等待另一个人完成对某个既包含 Python又包含 HTML 的文件的编辑工作。
```

```python
3.原始视图函数和django模板修改的视图函数
def current_time(req):
    # ================================原始的视图函数
    # import datetime
    # now=datetime.datetime.now()
    # html="<html><body>现在时刻：<h1>%s.</h1></body></html>" %now


    # ================================django模板修改的视图函数
    # from django.template import Template,Context
    # now=datetime.datetime.now()
    # t=Template('<html><body>现在时刻是:<h1>{{current_date}}</h1></body></html>')
    # #t=get_template('current_datetime.html')
    # c=Context({'current_date':str(now)})
    # html=t.render(c)
    #
    # return HttpResponse(html)


    #另一种写法(推荐)
    import datetime
    now=datetime.datetime.now()
    return render(req, 'current_datetime.html', {'current_date':str(now)[:19]})

```

#### 2.模板语法之变量

```
模版语法重点：

　　变量：{{ 变量名 }}

　　　　1 深度查询 用句点符

　　　　2 过滤器

　　标签：｛｛%  % ｝｝
```

```django
1.html部分
<h1>模板语言之变量</h1>
{# 模板语言注释 #}
<p>字符串：{{ name }}</p>
<p>数字：{{ age }}</p>
<p>列表：{{ lis }}</p>
<p>字典：{{ dic }}</p>
<p>元祖：{{ tu }}</p>
{#只写函数名默认加括号运行#}
<p>函数：{{ test }}</p>
<p>类：{{ People }}</p>
<p>对象：{{ zhang }}</p>
<p>类对象列表：{{ lis2 }}</p>

<hr>
<h1>变量的深度查询</h1>
<p>列表的第一个值：{{ lis.0 }}</p>
<p>字典取值：{{ dic.name }}</p>
{#再继续取值继续点#}
<p>字典取列表值：{{ dic.hobbies }}</p>
<p>列表的第一个值：{{ lis.0 }}</p>

<p>对象取数据属性：{{ zhang.name }}</p>
<p>对象取函数属性：{{ zhang.get_name }}</p>
<p>对象取绑定给类函数属性：{{ zhang.cls_test }}</p>
<p>对象取静态函数属性：{{ zhang.foo }}</p>
<p>在列表对象中取出对象的属性：{{ lis2.0.age }}</p>
{#注意：不能调有参数的方法#}
<p>字符串的内置方法：{{ name.isdigit }}</p>
```

```python
2.视图部分
def index(request):
    name = "zcg"
    age = 18
    lis = ["hello", 33, [1, 2, 3], {"name": "zcg"}]
    dic = {"name": "zhang", "age": 11, "hobbies": ["chi", "he"]}
    tu = ("si", 1, lis, type(lis))
    lis4 = []
    lis5 = [1, 2]
    file_size = 1024
    c_time = datetime.datetime.now()
    h1 = "<h1>你好啊</h1>"
    # 这里的alert里面的东西如果是汉子必须加引号
    script = "<script>alert('傻逼')</script>"

    # locals()会将该视图函数内的属性返回给模板
    def test():
        print("zhang")
        return "hello test"

    class People(object):
        def __init__(self, name, age):
            self.name = name
            self.age = age

        def get_name(self):
            return self.name

        @classmethod
        def cls_test(cls):
            return "class use"

        @staticmethod
        def foo():
            return "foo use"

    zhang = People("zhang", 22)
    zcg = People("zcg", 44)
    lis2 = [zhang, zcg]
    # 相当于执行该函数，并打印
    # print(test())
    return render(request, "index.html", locals())
```

#### 3.模板语法之过滤器

```django
1.html部分
h1>模板语言之过滤器</h1>
{#后面就是个python中的函数,|前面的,是函数的第一个参数,冒号后面的是第二个参数#}
<p>统计字符串的长度：{{ name|length }}</p>
<p>统计列表的长度：{{ lis|length }}</p>
<p>过滤器之默认值：{{ lis4|default:"[hello]" }}</p>
<p>过滤器之filesizeformat：{{ file_size|filesizeformat }}</p>
<p>过滤器之无date：{{ c_time }}</p>
<p>过滤器之date:{{ c_time|date:'Y-m-d' }}</p>
<p>过滤器之slice:{{ name|slice:'0:5:4' }}</p>
{#truncatechars 至少三个起步#}
<p>过滤器之truncatechars:{{ 'dafddfafgadfgaasdgadgfadaf'|truncatechars:5 }}</p>
<p>过滤器之truncatewords:{{ '我 dfaf ga dfgaas 你 dgf adaf'|truncatewords:5 }}</p>

<p>过滤器之不用safe：{{ h1 }}</p>
<p>过滤器之用safe：{{ h1|safe }}</p>
<p>过滤器之不用safe：{{ script }}</p>
{#<p>过滤器之用safe：{{ script|safe }}</p>#}

<p>过滤器之用add:{{ 12|add:'1' }}</p>
<p>过滤器之用add:{{ 'egon'|add:'dsb' }}</p>
```

#### 4.模板语法之标签

```django
1.html部分
<h1>模板语言之标签</h1>
{% for li in lis %}
    {{ forloop }}
    {% if forloop.revcounter %}
        <p>{{ forloop.first }}--->{{ forloop.counter0 }}--->{{ forloop.revcounter }}----->{{ li }}</p>
    {% endif %}
{% endfor %}
<hr>
{% for foo in lis5 %}
    {% for li in lis %}
        {{ forloop.parentloop.counter }}
        <p>{{ forloop.first }}--->{{ forloop.counter0 }}--->{{ forloop.revcounter }}----->{{ li }}</p>
    {% endfor %}
{% endfor %}
<hr>
{% for foo in lis5 %}
    {% for foo in lis %}
        {#        标签之if#}
        {% if forloop.counter < 3 and forloop.parentloop.counter == 1 %}
            {{ forloop.parentloop.counter }}
            <p>{{ foo }}</p>
        {% endif %}
    {% endfor %}
{% endfor %}
{#标签之with,取别名，对于名字过长的变量起到简化作用#}
<hr>
{% with lis5 as mm %}
    <p>{{ mm.0 }}</p>
    <p>{{ lis5.0 }}</p>
{% endwith %}
************************for ,if,with 都要有结束******************
```

#### 5.模板语法之自定义过滤器

```django
***标签不能用在if判断中,过滤器,可以用在if判断中
自定义过滤器
1 先app是不是已经在setting中注册
2 在app下创建一个templatetags(****名字不能变***)的文件夹(模块)
3 在模块下创建一个py文件,名字随意:mytag.py
4 # 第一步,导入template
from django.template import Library
# 第二步,定义一个叫register的变量=template.Library()
			   register = Library()
5 写一个函数,用@register.filter(name='yyy')装饰一下(可以指定别名)
def str_add(str1, str2): #一定要有返回值
    # 业务逻辑很复杂
    return str1 + str2
6 在模板里:(新定定义的标签,过滤器,都要重启程序)
{% load mytag %}
{{'lqz'|str_add:'nb'}}

```

```python
2.实例html部分
{% load my_tags %}
<p>{{ 'lqz'|yyy:'nb' }}</p>

3.实例templatetags下的mytag
from django.template import Library
register = Library()
@register.filter(name='yyy')
def str_add(str1, str2):
    # 业务逻辑很复杂
    return str1 + str2
```

#### 6.模板语法之自定义标签

```
自定义标签:
1-4:前4步,根过滤器的定义完全一样
5 只是装饰器不一样
@register.simple_tag()
def add_nb(value):
	return value+'nb'
6 在模板里:(多个参数,以空格区分)
{% load mytag %}
{% add_nb 'lqz'%}
```

```python
2.实例之html部分
<h4>使用自定义的标签</h4>
<p>{% add_nb 'egon' %}</p>
<p>{% add_3 'egon' 'is' 'dsb' %}</p>

3.实例之templatetags的mytag部分
@register.simple_tag()
def check(value):
    word = Thread_word.objects.all().values()
    map_word = {dic.get("old_word"): dic.get("new_word") for dic in word}
    for k, v in map_word.items():
        if k in value:
            value = value.replace(k, v)
    return value
```

#### 7.模板的导入(重复使用)

```django
1.什么是模板的导入
就是写了一个好看的组件，可以复用

2.如何导入
2.1 先写一个模板
2.2 在需要导入的模板中：{% include "模板的名字" %}

3.实例
3.1 需要导入模板中的代码
<body>
{% include "love.html" %}
</body>

3.2 模板中的代码：注意不要html标签，只写一个组件即可
<div>
    <p>床前明月光</p>
    <p>疑是地上霜</p>
    <p>举头望明月</p>
    <p>低头思故乡</p>
</div>

3.3 视图中的代码
def input_test(request):
    return render(request, "input_html.html")

```

#### 8.模板的继承

```
注意：模板继承的时候，可以先将需要的数据，查询出来，然后通过local（），将数据拿到前端页面渲染，在后台渲染完毕后，返回到前台，

非常重要的：
当后台共用一个视图函数时，视图函数中可以通过args/kwargs等来接受，如论是否传值，均可以相应到对应的视图
```

```python
eg：
url(r'^(?P<username>[\w]+)/(?P<condition>category|tag|archive)/(?P<param>.*)', views.user_blog),
url(r'^(?P<username>[\w]+)$', views.user_blog),

视图：
def user_blog(request, username, *args, **kwargs):
    print(username)
    # username=username
    user = models.UserInfo.objects.filter(username=username).first()
    if not user:
        return render(request, 'error.html')

    blog = user.blog
    article_list = blog.article_set.all()
    # 取出condition中的分类/标签/时间
    condition = kwargs.get('condition')
    # condition可能是category|tag|archive中的一个 还可能是空
    # 取出param的值,可能为标签id,分类id,或者是时间
    param = kwargs.get('param')
    print(condition)
    print(param)
    if 'tag' == condition:
        article_list = article_list.filter(tag__pk=param)
    elif 'category' == condition:
        article_list = article_list.filter(category__pk=param)
    elif 'archive' == condition:
        #     2018-11   -->切分--->查询
        # [2018,11]
        archive_list = param.split('-')
        # 过滤:发布年为2018年,月为11月的所有文章
        article_list = article_list.filter(create_time__year=archive_list[0], create_time__month=archive_list[1])

    return render(request, 'user_blog.html', locals())
```



```django
1.什么是模板的继承
写一个母版，留一个可拓展区域的盒子，可以留多个盒子，盒子内的东西可以变化，盒子外的其他部分，都继承之母版，不可改变

2.使用方式
2.1 先写一个母版，留合适的可拓展区域的盒子
语法：
{% block content %}
....可以写内容
{% endblock content %}

2.2 在子模板中使用
语法：
{% extends "母版的名字" %}  ---明确继承的母版
{% block content %}
....可以写页面内容
{% endblock content%}

3.实例：
3.1母版
<body>
<div class="main">
    <div class="left"></div>
    <div class="right">
        {% block content %}

        {% endblock content %}
    </div>
</div>

3.2 使用母版
方式一：直接继承过来使用，不重写block，默认显示父级的内容
{% extends "muban.html" %}
    
方式二：继承过来，重写block，block部分使用自己的其他部分使用母版的
{% extends "muban.html" %}

{% block content %}
<p>我是可以使用区域，我厉害吧</p>
<p>我是可以使用区域，我厉害吧</p>
<p>我是可以使用区域，我厉害吧</p>
<p>我是可以使用区域，我厉害吧</p>
<p>我是可以使用区域，我厉害吧</p>
<p>我是可以使用区域，我厉害吧</p>
{% endblock %}
    
方式三：继承过来，重写block，super重用父级的功能
{% extends "muban.html" %}

{% block content %}
<p>我是可以使用区域，我厉害吧</p>
    {{ block.super }}
<p>我是可以使用区域，我厉害吧</p>
<p>我是可以使用区域，我厉害吧</p>
<p>我是可以使用区域，我厉害吧</p>
<p>我是可以使用区域，我厉害吧</p>
<p>我是可以使用区域，我厉害吧</p>
{% endblock %}
```

#### 9.静态文件相关

```django
方式一：写死静态文件的路径
<link rel="stylesheet" href="/static/css/new.css">
```

```django 
方式二：通过反向查找拼接路径
{% load static %}
<link rel="stylesheet" href="{% static 'css/new.css' %}">
```

```django
方式三：通过反向查找
{% load static %}
<link rel="stylesheet" href="{% get_static_prefix %}css/new.css">

注意：
get_static_prefix返回值是:静态文件的地址,相当于/static/
```

### day7

#### 1.单表操作

```python
    1.数据库迁移命令
python manage.py makemigrations 只是在migrations里面做了一个记录
python manage.py migrate  真正在数据库中建立表格
python manage.py showmigrations 查看有没有提交到数据库
```

```python
2.查询的api（接口）**********

增加：
方式一：create创建
book = models.Book.objects.create(name="红楼梦", price=23.8, publish="人民出版社", author="曹大姐", create_date="2011-9-12")
print(book.create_date)

方式二：先实例化产生对象，然后调用save方法
book = models.Book(name="水浒传", price=19, publish="北京出版社", author="施耐阉")
book.save()
print(book.name)
```

```python
删除：
方式一：删除名字叫水浒传的这本书，通过queryset删除
ret = models.Book.objects.filter(name="水浒传").first().delete()
print(ret)

方式二：删除全部，通过queryset删除
ret = models.Book.objects.filter(name="水浒传").all().delete()
print(ret)

方式三：通过对象删除
ret = models.Book.objects.filter(name="水浒传").first()
print(ret)
msg = ret.delete()
print(msg)
```

```python
修改：
方式一：通过queryset来修改，,返回值是int类型的影响的行数
ret = models.Book.objects.filter(name="水浒传").update(price=99)
print(ret)

方式二：通过book对象的方式来修改
book = models.Book.objects.filter(name="水浒传").last()
book.price = 88
book.save()
```

```python
查询：********非常重要**********
1.all()取到表中所有记录放入queryset对象中
ret = models.Book.objects.all()
print(ret)
eg:
<QuerySet [<Book: name:红楼梦  price:23.80>, <Book: name:水浒传  price:88.00>, <Book: name:水浒传  price:88.00>, <Book: name:小李飞刀  price:44.00>, <Book: name:书剑恩仇录  price:50.00>]>

2.filter() 相当于sql中的where，后面跟过滤条件，返回的结果是queryset的对象
ret = models.Book.objects.filter(name="小李飞刀")
print(ret) -- 拿到的是queryset对象

ret = models.Book.objects.filter(name="水浒传").first()
print(ret) --book的对象

ret = models.Book.objects.filter(name="水浒传", id=11)
print(ret) --取到名字是水浒传且id是1的queryset对象

3.get() 有且只有一个结果，返回的是表中的一条记录，不是queryset对象
ret = models.Book.objects.get(id=1) --返回唯一的对象  
print(ret)
ret = models.Book.objects.get(name="水浒传") --多个就报错

4.exclude() 查询名字不叫西游记的书，结果也是queryset的对象
ret = models.Book.objects.exclude(name="小李飞刀")

5.order_by() 按指定字段排序，默认是asc，-号是desc
ret = models.Book.objects.all().order_by("price")
print(ret) --asc
ret = models.Book.objects.all().order_by("-price")
print(ret) -- desc
ret=models.Book.objects.all().order_by('-price','create_data') --可以传多个值

6.reverse() 对排序后的结果进行反向排序（一定是排序后的结果，否则报错）
ret = models.Book.objects.all().order_by("-price").reverse()
print(ret)

7.count() 查询结果的个数，是int类型
ret = models.Book.objects.filter(name="水浒传").count()
print(ret) --结果为：2

8.last() 对queryset的对象取最后一个，得到的是book的对象
ret = models.Book.objects.all().last()
print(ret) --Bookobj

9. exists 判断查询的结果是否存在，返回结果是布尔类型
ret = models.Book.objects.filter(name="cc").exists()
print(ret) --False

10.values(*field) 返回queryset的对象，里面套字典，字典里面拥有的字段名为values里面的字段名

ret = models.Book.objects.all().values('name', 'price')<QuerySet [{'name': '红楼梦', 'price': Decimal('23.80')}] >

11.value_list() 返回时queryset对象，里面是元祖，元祖里面是value_list里面的字段名

 ret = models.Book.objects.all().values_list('name', 'price')
 <QuerySet [('红楼梦', Decimal('23.80'))] >

12.distinct() 必须完全一样,才能去重   只要带了id,去重就没有意义了

ret = models.Book.objects.all().values('name').distinct()
print(ret) ---去除名字重复的记录
```

```python
查询：基于双下划线的模糊查询
1.大于gt >
ret = models.Book.objects.filter(price__gt=50)
print(ret)

2.小于lt <
ret = models.Book.objects.filter(price__lt=50)
print(ret)

3.大于等于gte >=
ret = models.Book.objects.filter(price__gte='50')
print(ret)

4.小于等于lte <=
ret = models.Book.objects.filter(price__lte='50')
print(ret)

5.在什么之中 in
ret = models.Book.objects.filter(price__in=['88', '44', '50'])
print(ret)

6.在什么范围中 range = between and
ret = models.Book.objects.filter(price__range=[50, 100])
print(ret)

7.查询在字段中是否包含某个字contains 首尾中全符合
ret = models.Book.objects.filter(name__contains='李')
print(ret)

8.icontains 查询名字带p的书,忽略大小写
ret=models.Book.objects.filter(name__icontains='P')
print(ret)

9.以什么开头startswith 
ret = models.Book.objects.filter(name__startswith="水")
print(ret)

10.以什么结尾endswith 不能查询价格之类的字段
ret = models.Book.objects.filter(name__endswith="传")
print(ret)

11.按年查询：year | month | day
ret = models.Book.objects.filter(create_date__year="2017")
print(ret)
```

### day8

```python
1.django终端打印sql语句

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

```python
2.创建模型
from django.db import models


# Create your models here.
# 名字使用大驼峰
# 用OneToOneField/ForeignKey 默认会在字段后面添加_id
# 一对一的关系:OneToOneField
# 一对多的关系:ForeignKey
# 多对多的关系:ManyToManyField

class Publish(models.Model):
    # id如果不写，会自动生成,nid,自动递增
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=32)
    address = models.CharField(max_length=55)
    email = models.EmailField()


class Author(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=32)
    # 数字类型
    sex = models.IntegerField()
    # 这样也不会出错，但是不建议这样来做
    # author_detail = models.ForeignKey(unique=True)
    author_detail = models.OneToOneField(to="AuthorDetail", to_field="id")


class AuthorDetail(models.Model):
    id = models.AutoField(primary_key=True)
    phone = models.CharField(max_length=32)
    address = models.CharField(max_length=55)


class Book(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=32)
    price = models.DecimalField(max_digits=5, decimal_places=2)
    publish = models.ForeignKey(to="Publish", to_field="id")
    authors = models.ManyToManyField(to="Author")
```



#### 1.一对多的增删改

```python
1.一对多的新增数据
    #one 直接传id
    ret = Book.objects.create(name="红楼梦", price=33.5, publish_id=2)
    print(ret.name)

    #two 传对象,传到数据库中还是id
    pk是主键自动去表中寻找对应的主键
    publish = Publish.objects.get(pk=1)
    ret = Book.objects.create(name='西游记', price=99, publish=publish)
    print(ret)

2.一对多的删除数据 delete方法，模型对象或者queryset对象
    #one
    ret = Book.objects.filter(name='西游记').first().delete()
    print(ret) 

    #two
    ret = Book.objects.filter(name="西游记").delete()
    print(ret)

3.一对多更新数据 update方法，或者模型对象修改属性，然后save
    #one
    ret = Book.objects.filter(name="西游记").update(publish_id= 3)

    #two
    book = Book.objects.filter(name="红楼梦").first()
    book.publish_id = 1
    book.save()
```

#### 2.多对多的增删改

```python
1.多对多的增删改

# 1.增 add（）里面可以是对象，或者是pk
    # one 对象
    aaa = Author.objects.filter(name='aaa').first()
    bbb = Author.objects.filter(name='bbb').first()
    book = Book.objects.filter(name='红楼梦').first()
    ret = book.authors.add(aaa, bbb)
    print(ret)

    # two 添加pk
    book = Book.objects.filter(name="金瓶梅").first().authors.add(2,3)

# 2.删 remove() 里面可以是对象，或者id
    # one 对象	
    aaa = Author.objects.filter(name='aaa').first()
    book = Book.objects.filter(name='红楼梦').first()
    ret = book.authors.remove(aaa)
    print(ret)

    # two id
    book = Book.objects.filter(name='金瓶梅').first().authors.remove(2)

#  clear() 清空所有
	book = Book.objects.filter(name="金瓶梅").first().authors.clear()

# 3.改 set([iter]) 里面是一个可迭代的对象，对象里面可以放模型对象，或者id，先清空再添加
	book = Book.objects.filter(name='金瓶梅').first().authors.set([3, 4])
```

#### 3.一对一的增删改

```python

```

#### 4.基于对象的跨表查询

```python
1.一对一

'''
一对一
正向 author --关联字段在author中 --->author_detail   ----按字段
反向 author_detail --关联字段在author中 -->author    ----按表名小写
'''
# 1.正向查询
author = Author.objects.filter(name="aaa").first().author_detail.phone
# AuthorDetail object /Author.objects.filter(name="aaa").first().author_detail
print(author)

# 2.反向查询
author_detail = AuthorDetail.objects.filter(address="北京").first().author.name
# Author object /AuthorDetail.objects.filter(address="北京").first().author
print(author_detail)
```

```python
2.一对多 

'''
一对多
正向 book --关联字段在book中 --->publish   ----按字段
反向 publish --关联字段在book中 -->book   ----按表名小写_set.all() queryset对象
'''

# 正向查询
book = Book.objects.filter(name='金瓶梅').first().publish.name
# Publish object/Book.objects.filter(name='金瓶梅').first().publish
print(book)

# 反向查询
publish = Publish.objects.filter(address="北京").first().book_set.all().values("name")
# <QuerySet [<Book: Book object>, <Book: Book object>]>/Publish.objects.filter(address="北京").first().book_set.all()
print(publish)
```

```python
3.多对多

'''
多对多:都得用all()
正向 book --关联字段在book中 --->author   ----按字段.all()
反向 author --关联字段在book中 -->book   ----按表名小写_set.all() queryset对象
'''

# 正向查询
book = Book.objects.filter(name="红楼梦").first().authors.all().values("name")
# <QuerySet [{'name': 'bbb'}, {'name': 'ddd'}]>/Book.objects.filter(name="红楼梦").first().authors.all()
print(book)

# 反向查询
author = Author.objects.filter(name="ddd").first().book_set.all().values("name")
# <QuerySet [{'name': '红楼梦'}, {'name': '金瓶梅'}]>/Author.objects.filter(name="ddd").first().book_set.all()
print(author)

# 连续跨表
# 查询地址是北京的作者写过的的书的出版社的名字 杭州出版社
author_detail = AuthorDetail.objects.filter(address="北京").all()
list_item = []
for author_d in author_detail:
    books = author_d.author.book_set.all()
    print(books)
    list_name = [book.publish.name for book in books]
    list_item.append(list_name)
print(list_item)
```



#### 5.基于双下划线的连表查询

```python
1.一对一：基于双下划线的查询（连接查询inner left right union）

# 以Author表作为基表
ret = Author.objects.filter(name="aaa").values("author_detail__phone")
print(ret)

# 以AuthorDetail表作为基表
ret = AuthorDetail.objects.filter(author__name='aaa').values("phone")
print(ret)

# 正向
ret = Author.objects.filter(name="bbb").values('sex', 'author_detail__phone')
print(ret)

# 反向
ret = AuthorDetail.objects.filter(phone='9999999').values('author__sex')
print(ret)

ret = Author.objects.filter(author_detail__phone='9999999').values('sex')
print(ret)

```

```python
2.基于双下划线的一对多的连表查询（出版社 -- book）

# 查询出版社为北京出版社出版的所有图书的名字,价格--(反向查 按表名小写)
ret = Publish.objects.filter(name="北京出版社").values('book__name', 'book__price')
print(ret)
# 正向查 按字段
ret = Book.objects.filter(publish__name='北京出版社').values('name', 'price')
print(ret)

# 查询北京出版社出版的价格大于19的书--(反向查 按表名小写)
ret = Publish.objects.filter(name='北京出版社', book__price__gt=19).values('book__name', "book__price")
print(ret)
# 正向查 按字段
ret = Book.objects.filter(publish__name='北京出版社', price__gt=19).values('name', 'price')
print(ret)
```

```python
3.基于双下划线的多对多的连表查询(book -- author)

eg:查询红楼梦的所有作者
# 正向 按字段
ret = Book.objects.all().filter(name='红楼梦').values('authors__name')
print(ret)
# 反向 按表名小写
ret = Author.objects.all().filter(book__name='红楼梦').values('name')
print(ret)

eg:	查询图书价格大于30的所有作者名字
# 正向 按字段
ret = Book.objects.all().filter(price__gt=30).values('authors__name')
print(ret)
# 反向 按表名
ret = Author.objects.all().filter(book__price__gt=30).values('name')
print(ret)
```

```python
4.连续跨表（进阶版）
注意：连续跨表的本质是将所有需要关联的表连接在一起，没有效率之分

# 查询北京出版社出版过的所有书籍的名字以及作者的姓名和电话（五表联查）
ret = Publish.objects.all().filter(name="北京出版社").values('book__name', 'book__authors__name','book__authors__author_detail__phone')
print(ret)

ret = Book.objects.all().filter(publish__name="北京出版社").values('name', 'authors__name','authors__author_detail__phone')
print(ret)

# 手机号以138开头的作者出版过的所有书籍名称以及出版社名称
ret = AuthorDetail.objects.all().filter(phone__startswith='138').values('author__name', 'author__book__name','author__book__publish__name')
print(ret)

ret = Book.objects.all().filter(authors__author_detail__phone__startswith="138").values('authors__name', 'name','publish__name')
print(ret)

```

#### 6.聚合查询aggregate --(Avg, Count, Max, Min, Sum)

```python
# 聚合查询aggregate 是queryset终止子句
from django.db.models import Avg, Count, Max, Min, Sum

# 计算所有图书的平均价格
ret = Book.objects.all().aggregate(Avg('price'))
print(ret)

# 计算图书中最高的价格
ret = Book.objects.all().aggregate(Max("price"))
print(ret)

# 计算图书的最高价格,最低价格,平均价格,总价
ret = Book.objects.all().aggregate(Max('price'), Min("price"), Sum("price"), Count("pk"))
print(ret)
```

#### 7.分组查询annotate ()

```python
总结终极版本
    values在前,表示group by 在后,表示取值
    filter在前,表示where条件,在后表示having
```

```python
# 分组查询annotate
# 统计每一本书的作者的个数
ret = Book.objects.all().annotate(c=Count("authors")).values('name', 'c')
print(ret)

# 统计每一个出版社的最便宜的书(以谁group by 就以谁为基表)
ret = Publish.objects.all().annotate(m=Min('book__price')).values('name', 'm')
print(ret)

# 统计每一本以王结尾的书籍的作者个数
ret = Book.objects.all().filter(name__endswith="王").annotate(c=Count('authors')).values("name", 'c')
print(ret)

# 查询各个作者出的书的总价格
ret = Author.objects.all().annotate(s=Sum('book__price')).values('name', 's')
print(ret)

# 查询名字叫lqz作者书的总价格
ret = Author.objects.all().filter(name="lqz").annotate(s=Sum('book__price')).values('name', 's')
print(ret)

# 查询所有作者写的书的总价格大于30
ret = Author.objects.all().annotate(s=Sum("book__price")).filter(s__gt=30).values('name','s')
print(ret)

# 统计不止一个作者的图书
ret = Book.objects.all().values('pk').annotate(c=Count('authors')).filter(c__gt=1).values('name','c')
print(ret)
```

#### 8.F函数:同一张表中的2个字段作比较

```python
1.导入此模块
from django.db.models import F
```

```python
# F函数 
from django.db.models import F

# 查询评论数大于阅读数的书
ret = Book.objects.all().filter(commit_num__gt=F('read_num')).values('name')
print(ret)

# 把所有书的评论数加1
ret = Book.objects.all().update(commit_num=F('commit_num') + 1)
print(ret)

# 把红楼梦这本书的阅读数减5
ret = Book.objects.all().filter(name='红楼梦').update(commit_num=F('commit_num')-5)
print(ret)
```

#### 9.Q函数：与或非（&|~）

```python
1.导入此模块
from django.db.models import Q
```

```python

# 查询作者名字是lqz或者名字是zcg的书
ret = Book.objects.all().filter(Q(authors__name='lqz') | Q(authors__name='zcg')).values('name', 'authors__name')
print(ret)

# 查询作者不是lqz的书
ret = Book.objects.all().filter(~Q(authors__name='lqz')).values('name', 'authors__name')
print(ret)

# 构建很复杂的逻辑，需要用括号来区分
ret = Book.objects.all().filter((Q(name='红楼梦') & Q(price__gt='100')) | Q(pk__gt=2)).values()
print(ret)
```

### day9

#### 1.ORM常用字段

```python

```

#### 2.ORM不常用的字段

```python
AutoField(Field)
        - int自增列，必须填入参数 primary_key=True

    BigAutoField(AutoField)
        - bigint自增列，必须填入参数 primary_key=True

        注：当model中如果没有自增列，则自动会创建一个列名为id的列
        from django.db import models

        class UserInfo(models.Model):
            # 自动创建一个列名为id的且为自增的整数列
            username = models.CharField(max_length=32)

        class Group(models.Model):
            # 自定义自增列
            nid = models.AutoField(primary_key=True)
            name = models.CharField(max_length=32)

    SmallIntegerField(IntegerField):
        - 小整数 -32768 ～ 32767

    PositiveSmallIntegerField(PositiveIntegerRelDbTypeMixin, IntegerField)
        - 正小整数 0 ～ 32767
    IntegerField(Field)
        - 整数列(有符号的) -2147483648 ～ 2147483647

    PositiveIntegerField(PositiveIntegerRelDbTypeMixin, IntegerField)
        - 正整数 0 ～ 2147483647

    BigIntegerField(IntegerField):
        - 长整型(有符号的) -9223372036854775808 ～ 9223372036854775807

    BooleanField(Field)
        - 布尔值类型

    NullBooleanField(Field):
        - 可以为空的布尔值

    CharField(Field)
        - 字符类型
        - 必须提供max_length参数， max_length表示字符长度

    TextField(Field)
        - 文本类型

    EmailField(CharField)：
        - 字符串类型，Django Admin以及ModelForm中提供验证机制

    IPAddressField(Field)
        - 字符串类型，Django Admin以及ModelForm中提供验证 IPV4 机制

    GenericIPAddressField(Field)
        - 字符串类型，Django Admin以及ModelForm中提供验证 Ipv4和Ipv6
        - 参数：
            protocol，用于指定Ipv4或Ipv6， 'both',"ipv4","ipv6"
            unpack_ipv4， 如果指定为True，则输入::ffff:192.0.2.1时候，可解析为192.0.2.1，开启此功能，需要protocol="both"

    URLField(CharField)
        - 字符串类型，Django Admin以及ModelForm中提供验证 URL

    SlugField(CharField)
        - 字符串类型，Django Admin以及ModelForm中提供验证支持 字母、数字、下划线、连接符（减号）

    CommaSeparatedIntegerField(CharField)
        - 字符串类型，格式必须为逗号分割的数字

    UUIDField(Field)
        - 字符串类型，Django Admin以及ModelForm中提供对UUID格式的验证

    FilePathField(Field)
        - 字符串，Django Admin以及ModelForm中提供读取文件夹下文件的功能
        - 参数：
                path,                      文件夹路径
                match=None,                正则匹配
                recursive=False,           递归下面的文件夹
                allow_files=True,          允许文件
                allow_folders=False,       允许文件夹

    FileField(Field)
        - 字符串，路径保存在数据库，文件上传到指定目录
        - 参数：
            upload_to = ""      上传文件的保存路径
            storage = None      存储组件，默认django.core.files.storage.FileSystemStorage

    ImageField(FileField)
        - 字符串，路径保存在数据库，文件上传到指定目录
        - 参数：
            upload_to = ""      上传文件的保存路径
            storage = None      存储组件，默认django.core.files.storage.FileSystemStorage
            width_field=None,   上传图片的高度保存的数据库字段名（字符串）
            height_field=None   上传图片的宽度保存的数据库字段名（字符串）

    DateTimeField(DateField)
        - 日期+时间格式 YYYY-MM-DD HH:MM[:ss[.uuuuuu]][TZ]

    DateField(DateTimeCheckMixin, Field)
        - 日期格式      YYYY-MM-DD

    TimeField(DateTimeCheckMixin, Field)
        - 时间格式      HH:MM[:ss[.uuuuuu]]

    DurationField(Field)
        - 长整数，时间间隔，数据库中按照bigint存储，ORM中获取的值为datetime.timedelta类型

    FloatField(Field)
        - 浮点型

    DecimalField(Field)
        - 10进制小数
        - 参数：
            max_digits，小数总长度
            decimal_places，小数位长度

    BinaryField(Field)
        - 二进制类型

常用和非常用字段合集
```

#### 3.ORM和mysql中对应的字段关系

```python
对应关系：
    'AutoField': 'integer AUTO_INCREMENT',
    'BigAutoField': 'bigint AUTO_INCREMENT',
    'BinaryField': 'longblob',
    'BooleanField': 'bool',
    'CharField': 'varchar(%(max_length)s)',
    'CommaSeparatedIntegerField': 'varchar(%(max_length)s)',
    'DateField': 'date',
    'DateTimeField': 'datetime',
    'DecimalField': 'numeric(%(max_digits)s, %(decimal_places)s)',
    'DurationField': 'bigint',
    'FileField': 'varchar(%(max_length)s)',
    'FilePathField': 'varchar(%(max_length)s)',
    'FloatField': 'double precision',
    'IntegerField': 'integer',
    'BigIntegerField': 'bigint',
    'IPAddressField': 'char(15)',
    'GenericIPAddressField': 'char(39)',
    'NullBooleanField': 'bool',
    'OneToOneField': 'integer',
    'PositiveIntegerField': 'integer UNSIGNED',
    'PositiveSmallIntegerField': 'smallint UNSIGNED',
    'SlugField': 'varchar(%(max_length)s)',
    'SmallIntegerField': 'smallint',
    'TextField': 'longtext',
    'TimeField': 'time',
    'UUIDField': 'char(32)',

```

#### 4.ORM字段参数

```python
null
用于表示某个字段可以为空。

unique
如果设置为unique=True 则该字段在此表中必须是唯一的 。

db_index
如果db_index=True 则代表着为此字段设置索引。

default
为该字段设置默认值。

DateField和DateTimeField
auto_now_add
配置auto_now_add=True，创建数据记录的时候会把当前时间添加到数据库。

auto_now
配置上auto_now=True，每次更新数据记录的时候会更新该字段。
```

#### 5.关系字段

```python
1.ForeignKey
外键类型在ORM中用来表示外键关联关系，一般把ForeignKey字段设置在 '一对多'中'多'的一方。

ForeignKey可以和其他表做关联关系同时也可以和自身做关联关系。

to
设置要关联的表

to_field
设置要关联的表的字段

related_name
反向操作时，使用的字段名，用于代替原反向查询时的'表名_set'。

on_delete
　　当删除关联表中的数据时，当前表与其关联的行的行为。

　　models.CASCADE
　　删除关联数据，与之关联也删除


　　models.DO_NOTHING
　　删除关联数据，引发错误IntegrityError


　　models.PROTECT
　　删除关联数据，引发错误ProtectedError


　　models.SET_NULL
　　删除关联数据，与之关联的值设置为null（前提FK字段需要设置为可空）


　　models.SET_DEFAULT
　　删除关联数据，与之关联的值设置为默认值（前提FK字段需要设置默认值）


　　models.SET

　　删除关联数据，
　　a. 与之关联的值设置为指定值，设置：models.SET(值)
　　b. 与之关联的值设置为可执行对象的返回值，设置：models.SET(可执行对象)
    
db_constraint
是否在数据库中创建外键约束，默认为True。
```

```python
2.OneToOneField
一对一字段。

通常一对一字段用来扩展已有字段。

一对一的关联关系多用在当一张表的不同字段查询频次差距过大的情况下，将本可以存储在一张表的字段拆开放置在两张表中，然后将两张表建立一对一的关联关系。

to
设置要关联的表。

to_field
设置要关联的字段。

on_delete
同ForeignKey字段。
```

```python
3.ManyToManyField
用于表示多对多的关联关系。在数据库中通过第三张表来建立关联关系


through
在使用ManyToManyField字段时，Django将自动生成一张表来管理多对多的关联关系。

但我们也可以手动创建第三张表来管理多对多关系，此时就需要通过through来指定第三张表的表名。

through_fields
设置关联的字段。


db_table
默认创建第三张表时，数据库中表的名称。
```

#### 6.元信息

```
ORM对应的类里面包含另一个Meta类，而Meta类封装了一些数据库的信息。主要字段如下:

db_table
ORM在数据库中的表名默认是 app_类名，可以通过db_table可以重写表名。

index_together
联合索引。

unique_together
联合唯一索引。

ordering
指定默认按什么字段排序。

只有设置了该属性，我们查询到的结果才可以被reverse()。
```

```python
实例：
class UserInfo(models.Model):
        nid = models.AutoField(primary_key=True)
        username = models.CharField(max_length=32)

        class Meta:
            # 数据库中生成的表名称 默认 app名称 + 下划线 + 类名
            db_table = "table_name"

            # 联合索引
            index_together = [
                ("pub_date", "deadline"),
            ]

            # 联合唯一索引
            unique_together = (("driver", "restaurant"),)
            
            ordering = ('name',)
            
            # admin中显示的表名称
            verbose_name='哈哈'

            # verbose_name加s
            verbose_name_plural=verbose_name

```

#### 7.自定义字段(了解)

```python
自定义char类型字段：
class FixedCharField(models.Field):
    """
    自定义的char类型的字段类
    """
    def __init__(self, max_length, *args, **kwargs):
        self.max_length = max_length
        super(FixedCharField, self).__init__(max_length=max_length, *args, **kwargs)

    def db_type(self, connection):
        """
        限定生成数据库表的字段类型为char，长度为max_length指定的值
        """
        return 'char(%s)' % self.max_length


class Class(models.Model):
    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=25)
    # 使用自定义的char类型的字段
    cname = FixedCharField(max_length=25)
```

#### 8.多对多关联关系三种创建方式

```python
方式一：自行创建第三张表
class Book(models.Model):
    title = models.CharField(max_length=32, verbose_name="书名")


class Author(models.Model):
    name = models.CharField(max_length=32, verbose_name="作者姓名")


# 自己创建第三张表，分别通过外键关联书和作者
class Author2Book(models.Model):
    author = models.ForeignKey(to="Author")
    book = models.ForeignKey(to="Book")

    class Meta:
        unique_together = ("author", "book")
```

```python
方式二：通过ManyToManyField自动创建
class Book(models.Model):
    title = models.CharField(max_length=32, verbose_name="书名")


# 通过ORM自带的ManyToManyField自动创建第三张表
class Author(models.Model):
    name = models.CharField(max_length=32, verbose_name="作者姓名")
    books = models.ManyToManyField(to="Book", related_name="authors")
```

```python
方式三：设置ManyToManyField并指定自己创建的第三张表
class Book(models.Model):
    title = models.CharField(max_length=32, verbose_name="书名")


# 自己创建第三张表，并通过ManyToManyField指定关联
class Author(models.Model):
    name = models.CharField(max_length=32, verbose_name="作者姓名")
    books = models.ManyToManyField(to="Book", through="Author2Book", through_fields=("author", "book"))
    # through_fields接受一个2元组（'field1'，'field2'）：
    # 其中field1是定义ManyToManyField的模型外键的名（author），field2是关联目标模型（book）的外键名。


class Author2Book(models.Model):
    author = models.ForeignKey(to="Author")
    book = models.ForeignKey(to="Book")

    class Meta:
        unique_together = ("author", "book")
```

```
注意：

当我们需要在第三张关系表中存储额外的字段时，就要使用第三种方式。

但是当我们使用第三种方式创建多对多关联关系时，就无法使用set、add、remove、clear方法来管理多对多的关系了，需要通过第三张表的model来管理多对多关系。
```

### day10

#### 1.inclusion_tag

```python
1.作用
	生成html的片段（动态，传参数，传数据）
2.使用
	2.1 mytag中
		@inclusion_tag('模板路径',name='重命名')
		def my_in():  不写,写多个,不写不传,写多个,按空格来传参
			一堆逻辑处理,查数据库
			ret=Book.objects.all()
			return {'books':ret}
        
    2.2 模板中
    	可以用books这个变量,渲染页面
        
    2.3 在需要展示的模板中
    	{%load mytag %}
		{% my_in 参数 %}
```

#### 2.defer/only（数据库优化）

```
defer---->除了指定字段之外
only---->只查询几个字段
比如:ret=Book.object.all().only('name')  id始终会查
结果是queryset对象,套book对象

问:如果取price,发生了什么?
	它会再次查询数据库,对数据库造成压力
```

#### 3.事务(原子性操作)

```python
from django.db import transition
with transition.atomic():
    sql1
    sql2
```

#### 4.choice

```python
模型表中某个字段,可以指定choice,用在选择不经常变的情况,经常变,尽量用数据库

mychoice=((1,'男'),(2,'女'),(3,'其他')) 
dd = models.ForeignKey(choices=mychoice)

get_dd_display()  视图中
get_dd_dispaly 模板中
```

### day11

#### 1.ajax组件

```python
1.什么是ajax
	异步的JavaScript和xml,跟后台交互,都用json

2.有什么用
	前后端做数据交互
3.特点
	异步(异步和同步的区别:同步是请求发过去,要等着回应;异步:不需要等回应,可以进行其他操作)
	
	局部刷新：不影响其他页面内容
	
```

```javascript
2.如何用：基本使用

$.ajax({
    url:'/index/',
    type:'post',
    //data:往后台提交的数据
    data:{'name':'lqz','age':18},
    //成功的时候回调这个函数
    success:function (data) {
    	alert(data)
    }
})
```

#### 2.通过ajax上传文件

```javascript
1.模板层

$("#btn").click(function () {
    //上传文件,必须用FormData,生产一个formdata对象
    var formdata=new FormData();
    formdata.append('name',$("#name").val());
    //取出文件$("#myfile")[0].files拿到的是文件列表,取第0个把具体的文件取出来
    formdata.append('myfile',$("#myfile")[0].files[0]);

    $.ajax({
        url:'/files_ajax/',
        type:'post',
        //不预处理数据,(name=lqz&age=18)
        processData:false,
        //指定往后台传数据的编码格式(urlencoded,formdata,json)
        //现在用formdata对象处理了,就不需要指定编码格式了,不要给我编码了
        contentType:false,
        data:formdata,
        success:function (data) {
        	alert(data)

    }
})
    
视图层:(跟form表单上传文件完全一样)
```

#### 3.基于ajax提交json格式的数据

```javascript
1.模板层

$('#btn').click(function () {
    var post_data={'name':$("#name").val(),'pwd':$("#pwd").val()};
    console.log(typeof post_data);
    // 如何把post_data这个字典,转成json格式字符串
    //JSON.stringify相当于python中json.dumpus(post_data)
    //pos是个字符串,json格式字符串
    var pos=JSON.stringify(post_data);
    console.log(typeof pos); 
    $.ajax({
        url:'/json/',
        type:'post',
        data:pos,
        contentType:'application/json',
        success:function (data) {
            //如果data是json格式字符串,如何转成对象(字典)?
            //data=JSON.parse(data)
            console.log(typeof data)
            console.log(data)
            var ret=JSON.parse(data)
            console.log(typeof ret)
            console.log(ret.status)
            //alert(data)

        }
    })
})

2.视图层

def add_json(request):
    if request.method=='GET':
    	return render(request,'json.html')
    print(request.POST)
    print(request.GET)
    print(request.body) # json数据在body里面 b'...'
    import json
    # res是个字典
    res=json.loads(request.body.decode('utf-8'))
    print(res)
    print(type(res))
    dic={'status':'100','msg':'登录成功'}
    # return HttpResponse('ok')
    # 返回给前台json格式
    return HttpResponse(json.dumps(dic))
    # return JsonResponse(dic)

```

```javascript
重点：
请求的编码方式:
	contentType:'application/json',
响应回来解析的方式：
	dataType:'json',
```

#### 4.基于ajax如何实现用户认证通过后的页面转跳

```html
1.模板层
login:
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>登录</title>
    {% load static %}
    <script src="{% static '/utils/jquery-3.3.1.js' %}"></script>
    <link rel="stylesheet" href="{% static '/utils/bootstrap-3.3.7-dist/css/bootstrap.css' %}">
</head>
<body>
<form>
    用户名：<input type="text" name="name" class="name">
    密码：<input type="text" name="password" class="password">
    <button type="button" id="btn">提交</button>
    <span class="ss"></span>
</form>
</body>
<script>
    $('#btn').click(function () {
        let msg = {
            'name': $('.name').val(),
            'password': $('.password').val()
        };
        $.ajax({
            // 不写默然超当前路径发请求
            url: '',
            type: 'post',
            data: msg,
            dataType: 'json',
            success: function (data) {
                console.log(data);
				// 错误信息，直接login页面渲染
                if (data.status === '100') {
                    $('.ss').text(data.data);
                }
                // 登录成功，直接跳转指定页面
                if (data.status === '101') {
                    location.href = 'http://127.0.0.1:8234/order/';
                }
            }
        })
    })
</script>
</html>
```

```html
2.模板order
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>order</title>
    {% load static %}
    <script src="{% static '/utils/jquery-3.3.1.js' %}"></script>
    <link rel="stylesheet" href="{% static '/utils/bootstrap-3.3.7-dist/css/bootstrap.css' %}">
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-6 col-lg-offset-3">
            <table class="table table-bordered">
                <thead>
                <tr id="head">
                    <th>id</th>
                    <th>商品</th>
                    <th>价格</th>
                </tr>
                </thead>
                <tbody id="body">
                {% for foo in msg %}
                    <tr>
                    <td>{{ forloop.counter }}</td>
                    <td>{{ foo.name }}</td>
                    <td>{{ foo.price }}</td>
                    </tr>
                {% endfor %}


                </tbody>
            </table>
        </div>
    </div>

</div>

</body>
</html>
```

```python
3.视图
from django.shortcuts import render, HttpResponse, redirect
from django.views import View
from django.utils.decorators import method_decorator

from app01.models import User, OrderMsg
from django.http import JsonResponse


# Create your views here.

def auth(func):
    from functools import wraps
    @wraps(func)
    def inner(request, *args, **kwargs):
        url = request.get_full_path()
        if request.session.get('id'):
            ret = func(request, *args, **kwargs)
        else:
            return redirect('/login/?next=%s' % url)
        return ret

    return inner


class Login(View):
    def get(self, request):
        return render(request, 'login.html')

    def post(self, request):
        name = request.POST.get('name')
        password = request.POST.get('password')
        res = User.objects.filter(name=name, password=password).first()
        if res:
            url = request.GET.get('next')
            print(request.GET)
            print(request.get_full_path())
            request.session['name'] = res.name
            request.session['id'] = res.pk
            if url:
                obj = JsonResponse({'status': '101', 'url': url})
                print(url)
            else:
                obj = JsonResponse({'status': '101', 'url': '/order/'})
        else:
            obj = JsonResponse({'data': '用户名或密码错误', 'status': '100'})
        return obj


@method_decorator(auth, name='get')
@method_decorator(auth, name='post')
class Order(View):
    def get(self, request):
        print(request.GET)
        id = request.session.get('id')
        msg = OrderMsg.objects.filter(user_id=id).all().values('name', 'price')
        print(msg)
        return render(request, 'order.html', locals())

    def post(self, request):
        return HttpResponse('ok')

```



#### 4.视图函数通过装饰器将json数据格式自动转成python中的数据类型

```python
import json


def wrapper(func):
    from functools import wraps
    @wraps(func)
    def inner(request, *args, **kwargs):
        request.data = request.POST
        try:
            request.data = json.loads(request.body.decode('utf-8'))
        except Exception as e:
            print(e)
        res = func(request, *args, **kwargs)
        return res

    return inner
```

```
注意：
json格式的数据放在body体中，django不会帮我们转，我们将转过后的数据赋给变量，
request.data = json.loads(request.body.decode('utf-8'))
data的属性会被我们覆盖，如果单纯通过判断GET,POST,body里面有没有值是有逻辑漏洞的，因为可以一个post请求过来，可以通过GET取到路径?name=ll&sex = 1的值！！
```

#### 5.ajax路径相关问题（****）

```javascript
js得到当前页面的url信息方法

1，设置或获取对象指定的文件名或路径。

alert(window.location.pathname)  ----/login/
2，设置或获取整个 URL 为字符串。

alert(window.location.href);  ---- http://127.0.0.1:8234/login/?next=/order/

3，设置或获取与 URL 关联的端口号码。

alert(window.location.port)   ---- 8234

4，设置或获取 URL 的协议部分。

alert(window.location.protocol)  ---- http:

5，设置或获取 href 属性中在井号“#”后面的分段。

alert(window.location.hash)

6，设置或获取 location 或 URL 的 hostname 和 port 号码。

alert(window.location.host)  ---- 127.0.0.1:8234

7，设置或获取 href 属性中跟在问号后面的部分。

alert(window.location.search) --- ?next=/order/

8，获取变量的值(截取等号后面的部分)

var url = window.location.search;

// alert(url.length);

// alert(url.lastIndexOf(‘=’));

var loc = url.substring(url.lastIndexOf(‘=’)+1, url.length);

9，用来得到当前网页的域名

var domain = document.domain; ----127.0.0.1

10.
document.domain + window.location.pathname + window.location.search
相当于：
window.location.href
```

```python
ajax注意提交数据和form表单的冲突
1.form表单不要写method = 'post'
2.form表单内input和button提交框，一律不能type='submit' 可以写button可以写type = 'button'
3.可以将提交按钮写在表单外面
```

#### 6.ajax获取响应头以及自定义请求头

```python
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>登录</title>
    <link rel="stylesheet" href="/static/utils/bootstrap-3.3.7-dist/css/bootstrap.css">
    <script src="/static/utils/jquery-3.3.1.js"></script>
    <style>
        .code {
            border-radius: 5px;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <form class="form-horizontal col-lg-6 col-lg-offset-3">
            <div class="form-group">
                <label for="username" class="col-sm-2 control-label">用户名</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="username" placeholder="User" name="username">
                </div>
            </div>
            <div class="form-group">
                <label for="password" class="col-sm-2 control-label">密码</label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" id="password" placeholder="Password" name="password">
                </div>
            </div>
            <div class="form-group">
                <label for="code" class="col-sm-2 control-label">验证码</label>
                <div class="row">
                    <div class="col-lg-6">
                        <input type="text" class="form-control " id="code" placeholder="code" name="code">
                    </div>

                    <img src="/get_code/" alt="" class="my_code">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="button" class="btn btn-default" id="btn">登录</button>
                    <span id="msg"></span>
                </div>
            </div>
        </form>
    </div>
</div>
<script>
	// 定义一个变量
    let header;
    
    // 获取头部信息，生成一个对象给header
    $.ajax({
        type: 'HEAD', // 获取头信息，type=HEAD即可
        url: window.location.href,
        complete: function (xhr, data) {
            // 获取相关Http Response header
            header = {
                // 服务器端时间
                "date": xhr.getResponseHeader('Date'),
                // 如果开启了gzip，会返回这个东西
                "contentEncoding": xhr.getResponseHeader('Content-Encoding'),
                // keep-alive ？ close？
                "connection": xhr.getResponseHeader('Connection'),
                // 响应长度
                "contentLength": xhr.getResponseHeader('Content-Length'),
                // 服务器类型，apache？lighttpd？
                "server": xhr.getResponseHeader('Server'),
                "vary": xhr.getResponseHeader('Vary'),
                "transferEncoding": xhr.getResponseHeader('Transfer-Encoding'),
                // text/html ? text/xml?
                "contentType": xhr.getResponseHeader('Content-Type'),
                "cacheControl": xhr.getResponseHeader('Cache-Control'),
                // 生命周期？
                "exprires": xhr.getResponseHeader('Exprires'),
                "lastModified": xhr.getResponseHeader('Last-Modified'),
                "valid_code": xhr.getResponseHeader('Valid_code')
            };
            // 在这里，做想做的事。。。
        }
    });
    $('#btn').click(function () {
        let dic = {
            'username': $('#username').val(),
            'password': $('#password').val(),
            'code': $('#code').val(),
        };
        {#let valid_code = xhr().getResponseHeader('valid_code');#}
        let json_dic = JSON.stringify(dic);
        console.log(header.valid_code);
        $.ajax({
            url: '',
            type: 'post',
            data: json_dic,
            contentType: 'application/json',
            dataType: 'json',
            // 在这里使用
            headers:{
                'Valid-Code':header.valid_code  //一定要这样写
            },
            success: function (data) {
                console.log(data);

                if (data.status === '404') {
                    $('#msg').text(data.data)
                }
                if (data.status === '405') {
                    $('#msg').text(data.data)
                }
                if (data.status === '101') {
                    window.location.href = 'http://127.0.0.1:8789/index/'
                }
            }

        })
    })
</script>
</body>
</html>
```

#### 7.ajax传json格式字典，如何通过验证(***)

```javascript
let dic = {
    'username': $('#username').val(),
    'password': $('#password').val(),
    'new_password': $('#new_password').val(),
    };
	let json_dic = JSON.stringify(dic);
	console.log(json_dic);
    $.ajax({
        url: '/ModifyPassword/',
        type: 'post',
        contentType: 'application/json',
        data: json_dic,
        dataType: 'json',
        headers: {
        	'X-CSRFToken':  "{{ csrf_token }}"
        },
    success: function (data) {
        console.log(data);
        if (data.status === '100') {
        	location.href = 'http://127.0.0.1:8789/login/'
        }
}
```

#### 8.ajax静态刷新

```html
1.html
{% for article in article_list %}
<h4>{{ article.title }}</h4>
<div class="media">
<div class="media-left">
    <a href="#">
    <img class="media-object" src="{{ article.blog.userinfo.avatar }}"
style="width: 40px; height: 40px;">
</a>	
</div>
    <div class="media-body">
    <h5 class="media-heading">{{ article.abstract }}</h5>
</div>
</div>
<div class="li">
    <span>作者:({{ article.blog.userinfo.username }})</span>
    <span>时间（{{ article.create_time|date:'Y:m:d H:i:s' }}）</span>
    <span><a href="">评论（{{ article.comment_num }}）</a></span>
    <span class="up">赞（<i>{{ article.up_num }}</i>）</span>
    <span class="mm" style="display: none"><i>{{ article.id }}</i></span>
    <span class="down">踩（<i>{{ article.down_num }}</i>）</span>
</div>
{% endfor %}
```

```javascript
2.jquery

 $('.up').click(function () {
        console.log($(this).children().text());
        console.log($(this).next().children().text());
        let dic = {
            'id':$(this).next().children().text(),
            'num': $(this).children().text(),
            'up_num': '1',
        };
        let my = $(this);
        console.log(dic);
        $.ajax({
            url: '{% url "upanddown" %}',
            type: 'post',
            data: dic,
            headers: {
                'X-CSRFToken': "{{ csrf_token }}"
            },
            success: function (data) {
                console.log(data);
                my.children().text(data)
            }

        })
    });
```

#### 9.简单的控制上传文件的方法

```
accept='image/*'
```



### day12

#### 1.分页器组件（*****）

```python
1.批量插入
lis = [models.Book.objects.create(name="图书%s" % i, price=i + 10) for i in range(1, 101)]
models.Book.objects.bulk_create(lis)
```

```python

2.分页器的属性和方法：
# 导入
from django.core.paginator import Paginator 
# 实例化产生一个paginator的分页对象,传一个iter和每页的条数
paginator = Paginator(book_list,10)

# 对象内的属性和方法
	数据总条数：paginator.count
    总页数：paginator.num_pages
    页码数的列表：paginator.page_range
    取到指定的页，返回一个page对象：paginator.page(2)
    
    current_page = paginator.page(2)
    当前页码内所有的数据：current_page.object_list
    是否有下一页：current_page.has_next()
    是否有上一页：current_page.has_previous()
    下一页的页码数：current_page.next_page_number()
    上一页的页码数：current_page.previous_page_number()
    
```

```python
3.前五后五进行分页：(视图层)

def index(request):
    # 先查出数据
    lis = models.Book.objects.all()
    # 按照指定的数目进行分页，得到一个分页后的对象
    paginator = Paginator(lis, 3)
    # 为防止溢出，产生错误，放到异常处理中执行代码
    try:
        # 从页面获取当前页的页码
        current_page_num = int(request.GET.get('page'))
        # 从分页对象中产生一个当前页的对象current_page
        current_page = paginator.page(current_page_num)
        # 总页码数大于11
        if paginator.num_pages > 11:
            if current_page_num < 6:
                page_range = range(1, 12)
            elif paginator.num_pages - current_page_num < 5:
                page_range = range(paginator.num_pages - 10, paginator.num_pages + 1)
            else:
                page_range = range(current_page_num - 5, current_page_num + 6)
        else:
            page_range = paginator.page_range

    except Exception as e:
        current_page_num = 1
        current_page = paginator.page(current_page_num)
        page_range = range(1, 12)
    return render(request, 'index.html', locals())
```

```html
1.模板层：
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>分页器</title>
    {% load static %}
    <link rel="stylesheet" href="{% static '/utils/bootstrap-3.3.7-dist/css/bootstrap.css' %}">
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-6 col-lg-offset-3">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>id</th>
                    <th>书名</th>
                    <th>价格</th>
                </tr>
                </thead>
                <tbody>
                {% for book in current_page %}
                    <tr>
                        <td>{{ forloop.counter }}</td>
                        <td>{{ book.name }}</td>
                        <td>{{ book.price }}</td>
                    </tr>
                {% endfor %}

                </tbody>
            </table>
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    {% if current_page.has_previous %}
                        <li>
                            <a href="/index/?page={{ current_page.previous_page_number }}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    {% else %}
                        <li>
                            <a href="" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    {% endif %}
                    {% for foo in page_range %}
                        {% if foo == current_page_num %}
                            <li class="active"><a href="/index/?page={{ foo }}">{{ foo }}</a></li>
                        {% else %}
                            <li><a href="/index/?page={{ foo }}">{{ foo }}</a></li>
                        {% endif %}
                    {% endfor %}
                    {% if current_page.has_next %}
                        <li>
                            <a href="/index/?page={{ current_page.next_page_number }}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                        {% else %}
                        <li>
                            <a href="" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    {% endif %}

                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
```

### day13

#### 1.Forms校验功能组件

- 1.校验字段的功能

  ```python
  1.前端传过来的数据，通过post或者get，或者body里面取出来，生成字典类型
  2.将自定义的UserForms类实例化，同时将字典传入该类中，生成一个form的对象
  3.执行form.is_valid()进行字段的校验
  4.详情见实例
  ```

  ```html
  1.模板层
  <form action="" method="post" novalidate="false">
      {% csrf_token %}
      <div>
          <label for="user">用户名</label>
          <p><input type="text" name="name" id="name"></p>
      </div>
      <div>
          <label for="pwd">密码</label>
          <p><input type="password" name="pwd" id="pwd"></p>
      </div>
      <div>
          <label for="r_pwd">确认密码</label>
          <p><input type="password" name="r_pwd" id="r_pwd"></p>
      </div>
       <div>
          <label for="email">邮箱</label>
          <p><input type="text" name="email" id="email"></p>
      </div>
      <input type="submit">
  </form>
  ```

  ```python
  2.视图层
  # forms组件
  from django import forms
  from django.forms import widgets
  from django.core.exceptions import ValidationError
  
  wid_01=widgets.TextInput(attrs={"class":"form-control"})
  wid_02=widgets.PasswordInput(attrs={"class":"form-control"})
  
  class UserForm(forms.Form):
      name=forms.CharField(max_length=32,
                           widget=wid_01
                           )
      pwd=forms.CharField(max_length=32,widget=wid_02)
      r_pwd=forms.CharField(max_length=32,widget=wid_02)
      email=forms.EmailField(widget=wid_01)
      tel=forms.CharField(max_length=32,widget=wid_01)
  
  
  
  def register(request):
  
      if request.method=="POST":
          form=UserForm(request.POST)
          if form.is_valid():
              print(form.cleaned_data)       # 所有干净的字段以及对应的值
          else:
              print(form.cleaned_data)       #
              print(form.errors)             # ErrorDict : {"校验错误的字段":["错误信息",]}
              print(form.errors.get("name")) # ErrorList ["错误信息",]
          return HttpResponse("OK")
      form=UserForm()
      return render(request,"register.html",locals())
  ```

  ```python
  4.form对象常用的方法和属性
  form.cleaned_data --所有校验通过的字段，以及对应的值
  
  form.errors -- 如果有校验不通过的字段，则会返回一个ErrorDict：{"校验错误的字段":["错误信息",]}
  
  form.errors.get("name") --ErrorList ['错误信息'] --一般我们取第一个错误信息
  ```

  ```python
  5.for循环form对象，得到字段对象f,form里面的类中一定重写了__iter__方法
  f.lable 获取字段的标签
  f.name  获取字段的名字
  f.errors 获取字段的错误列表,一般我们取第一个字段作为错误信息渲染到页面
  ```

- 2.渲染标签的功能

  ```html
  1.方式一:直接用form对象进行渲染，有较强的灵活性，但是代码量多
  
  <h3>注册页面</h3>
  <div class="container">
      <div class="row">
          <div class="col-md-6 col-lg-offset-3">
  
                  <form action="" method="post" novalidate="false">
                      {% csrf_token %}
                      <div>
                          <label for="">用户名</label>
                          {{ form.name }} --最终会被解析成input标签
                      </div>
                      <div>
                          <label for="">密码</label>
                          {{ form.pwd }}
                      </div>
                      <div>
                          <label for="">确认密码</label>
                          {{ form.r_pwd }}
                      </div>
                      <div>
                          <label for=""> 邮箱</label>
                          {{ form.email }}
                      </div>
  
                      <input type="submit" class="btn btn-default pull-right">
                  </form>
          </div>
      </div>
  </div>
  ```

  ```html
  2.方式二：推荐使用
  <form action="" method="post">
      {% csrf_token %}
  
      {% for field in form %}
          <div>
              <label for="">{{ field.label }}</label>
              {{ field }}	
          </div>
      {% endfor %}
      <input type="submit" class="btn btn-default pull-right">
                  
  </form>
  ```

  ```html
  3.方式三：代码量少但是可拓展性变弱
  <form action="" method="post">
      {% csrf_token %}
      
      {{ form.as_p }}
  
      <input type="submit" class="btn btn-default pull-right">
  
  </form>
  ```

- 3.渲染错误信息的功能

  ```python
  1.视图
  
  def register(request):
      if request.method=="POST":
          form=UserForm(request.POST)
          if form.is_valid():
              print(form.cleaned_data)       # 所有干净的字段以及对应的值
          else:
              print(form.cleaned_data)       #
              print(form.errors)             # ErrorDict : {"校验错误的字段":["错误信息",]}
              print(form.errors.get("name")) # ErrorList ["错误信息",]
          return render(request,"register.html",locals())
      form=UserForm()
      return render(request,"register.html",locals())
  ```

  ```html
  2.模板:field.errors.0就是错误信息的第一个
  <form action="" method="post" novalidate>
      {% csrf_token %}
      
      {% for field in form %}
          <div>
              <label for="">{{ field.label }}</label>
              {{ field }} <span class="pull-right" style="color: red">{{ field.errors.0 }}</span>
          </div>
      {% endfor %}
      <input type="submit" class="btn btn-default">
  
  </form>
  ```

- 4.组件的参数配置

  ```python
  class Ret(Form):
      name = forms.CharField(max_length=10, min_length=2, label='用户名',
                             error_messages={'required': '该字段不能为空', 'invalid': '格式错误', 'max_length': '太长',
                                             'min_length': '太短'},
                             widget=widgets.TextInput(attrs={'class':'form-control'}))
      pwd = forms.CharField(max_length=10, min_length=2, widget=widgets.PasswordInput(attrs={'class':'form-control'}))
      email = forms.EmailField(label='邮箱', error_messages={'required': '该字段不能为空', 'invalid': '格式错误'})
  ```

- 5.局部钩子

  ```python
  from django.core.exceptions import NON_FIELD_ERRORS, ValidationError
  def clean_name(self):
  
          val=self.cleaned_data.get("name")
  
          ret=UserInfo.objects.filter(name=val)
  
          if not ret:
              return val
          else:
              raise ValidationError("该用户已注册!")
  
  def clean_tel(self):
  
      val=self.cleaned_data.get("tel")
  
      if len(val)==11:
  
          return val
      else:
          raise  ValidationError("手机号格式错误")
  ```

- 6.全局钩子

  ```python
      def clean(self):
          pwd=self.cleaned_data.get('pwd')
          r_pwd=self.cleaned_data.get('r_pwd')
  
          if pwd and r_pwd:
              if pwd==r_pwd:
                  return self.cleaned_data
              else:
                  raise ValidationError('两次密码不一致')
          else:
  
              return self.cleaned_data
  ```

- 7.注意事项(***)

  ```python
  1.form表单的name属性值应该与forms组件字段名称一致
  
  2.form除了可以校验前端传过来的数据，也可以校验数据库的数据
  比如数据库为空的字段，可以过滤掉
  
  3.如果前台是ajax传过来的json格式对象，那么我们返回时一定要返回json格式Httpresponse,自然对应模板中通过dom操作，渲染到模板中。
  ```

- 8.实例

  ```python
  视图层
  
  from django import forms
  from django.forms import widgets
  from django.core.exceptions import ValidationError
  
  
  class MyForm(forms.Form):
      name = forms.CharField(max_length=10, min_length=3, label='用户名',
                             error_messages={'max_length': '最长是10', 'min_length': '最短是3', 'required': '这个必须填'},
                             widget=widgets.TextInput(attrs={'class': 'form-control name'}))
      password = forms.CharField(max_length=20, min_length=3, label='密码',
                                 error_messages={'max_length': '最长是20', 'min_length': '最短是3', 'required': '这个必须填'},
                                 widget=widgets.PasswordInput(attrs={'class': 'form-control password'}))
      re_password = forms.CharField(max_length=20, min_length=3, label='请确认密码',
                                    error_messages={'max_length': '最长是20', 'min_length': '最短是3', 'required': '这个必须填'},
                                    widget=widgets.PasswordInput(attrs={'class': 'form-control re_password'}))
      sex = forms.IntegerField(max_value=3, min_value=1, label='性别',
                               error_messages={'max_length': '最长是3', 'min_length': '最短是1', 'required': '这个必须填'},
                               widget=widgets.NumberInput(attrs={'class': 'form-control sex'}))
      email = forms.EmailField(label='邮箱', widget=widgets.EmailInput(attrs={'class': 'form-control email'}),
                               error_messages={'required': '这个必须填', 'invalid': '不符合邮箱格式'})
  
      def clean_name(self):
          name = self.cleaned_data.get('name')
          print(name)
          from app01.models import User
          name_list = User.objects.all().values('name')
          lis = [v['name'] for v in name_list]
          if name in lis:
              raise ValidationError('用户名重复')
          return name
  
      def clean(self):
          password = self.cleaned_data.get("password")
          re_password = self.cleaned_data.get("re_password")
          if password == re_password:
              return self.cleaned_data
          else:
              raise ValidationError('两次输入的密码不一致')
  
  
  def register(request):
      if request.method == 'GET':
          my_form = MyForm()
          print(type(my_form))
          for i in my_form:
              print(i)
              print(i.label)
              print(i.name)
              print(i.errors)
      elif request.method == 'POST':
          import json
          print(request.GET)
          print(request.POST)
          print(request.body)
          print(request.META)
          print(json.loads(request.body))
  
          my_form = MyForm(json.loads(request.body))
          if my_form.is_valid():
              my_form.cleaned_data.pop("re_password")
              User.objects.create(**my_form.cleaned_data)
              dic = {'status': True}
              return JsonResponse(dic)
          else:
              global_error = my_form.errors.get('__all__')
              if global_error:
                  my_form.errors['all'] = [global_error[0]]
                  my_form.errors.pop("__all__")
              return JsonResponse(my_form.errors)
      return render(request, 'register.html', locals())
  
  ```

  ```html
  模板层
  <!DOCTYPE html>
  <html lang="zh">
  <head>
      <meta charset="UTF-8">
      <title>注册</title>
      <link rel="stylesheet" href="/static/utils/bootstrap-3.3.7-dist/css/bootstrap.css">
      <script src="/static/utils/jquery-3.3.1.js"></script>
  </head>
  <body>
  <div class="container-fluid">
      <div class="row">
          <div class="col-lg-6 col-lg-offset-3">
              <div>
                  <form class="form-horizontal">
                      {% for foo in my_form %}
                          <div class="form-group ">
                              <label for="inputEmail3" class="col-sm-2 control-label">{{ foo.label }}</label>
                              <div class="col-sm-10 mm" id="{{ foo.auto_id }}">
                                  {{ foo }}
                              </div>
                          </div>
                      {% endfor %}
                      <div class="form-group">
                          <div class="col-sm-offset-2 col-sm-10">
                              <button type="button" class="btn btn-default" id="btn">注册</button>
                              <span id="id_all"></span>
                          </div>
                      </div>
                  </form>
              </div>
          </div>
      </div>
  </div>
  </body>
  <script>
      $('#btn').click(function () {
          let dic = {
              "name": $('.name').val(),
              "password": $('.password').val(),
              "re_password": $('.re_password').val(),
              "sex": $('.sex').val(),
              "email": $('.email').val()
          };
          let json_dic = JSON.stringify(dic);
          console.log(dic);
          $.ajax({
              url: '/register/',
              type: 'post',
              contentType: 'application/json',
              data: json_dic,
              dataType: 'json',
              success: function (data) {
                  console.log(data);
                  $.each(data, function (i, obj) {
                      if (i === 'status') {
                          location.href='http://www.baidu.com'
                      }
                      console.log(i);
                      console.log(i, obj);
                      let $span = $('<span></span>');
                      $span.text(obj[0]);
                      res = '#id_aa'.replace('aa', i);
                      console.log(res);
                      $span.appendTo(res)
                  })
  
              }
          })
      });
  
      $('#id_name .name').mouseout(function () {
          if ($(this).val()) {
              let name_dic = {'name': $(this).val()};
              let json_dic = JSON.stringify(name_dic);
  
              $.ajax({
                  url: '/register/',
                  type: 'post',
                  contentType: 'application/json',
                  data: json_dic,
                  dataType: 'json',
                  success: function (data) {
                      if ($('.myname').length > 0) {
                          console.log('jjj')
                      } else {
                          let $span = $('<span></span>');
                          console.log(data, 'mmmmmmmm');
                          $span.text(data.name[0]);
                          $span.addClass('myname');
                          $span.appendTo($('#id_name'));
                          setTimeout(function () {
                              $span.remove();
                          }, 3000)
                      }
  
                  }
              })
          } else {
              console.log($(this).val())
          }
  
      })
  </script>
  </html>
  
  
  ```

### day14

#### 1.cookie组件

- 1.会话跟踪技术

  ```
  1.因为http协议是无状态协议，也就是说每个请求都是相互独立的！
  这样会导致每次请求过来都是一个全新的会话，无法知道上一次会话的是谁，但是在
  同一个会话中，应该是数据共享的，所以就有了cookie和session来完成
  
  2.seesion底层依赖的是cookie技术
  ```

- 2.cookie简介

  ```
  1.什么是cookie
  cookie的本质就是key-value结构，类似于python中的字典
  
  客户端浏览器第一次发送请求（没有cookie）-->服务端判断是否有cookie---没有---就生成一个cookie--返回给客户端浏览器--客户端浏览器保存这个cookie
  
  客户端浏览器第二次发送请求（有之前存的cookie）-->服务器判断是否有cookie-->有cookie，服务器会识别数据，最终返回给客户端数据
  ```

- 3.cookie规范

  ```python
  1.cookie大小上限4kb
  2.一个服务器最多在客户端保存20个cookie
  3.一个浏览器最多保存300个cookie
  ```

- 4.cookie的覆盖

  ```
  如果服务端发送重复cookie那么就会覆盖原有的cookie
  
  例如客户端的第一个请求服务器端发送的Cookie是：Set-Cookie: a=A；第二请求服务器端发送的是：Set-Cookie: a=AA，那么客户端只留下一个Cookie，即：a=AA。
  ```

- 5.在浏览器中查看cookie

  ```
  浏览器中按F12，点network---cookie就能看到
  ```

#### 2.django中如何使用cookie

- 1.获取cookie

  ```python
  request.COOKIES['key']
  request.get_signed_cookie(key, default=RAISE_ERROR, salt='', max_age=None)
  name=request.COOKIES.get('name')
  参数：
      default: 默认值
      salt: 加密盐
      max_age: 后台控制过期时间
  ```

- 2.设置cookie

  ```python
  rep = HttpResponse(...)
  rep ＝ render(request, ...)
  
  rep.set_cookie(key,value)
  格式：Set-Cookie: name：zhang
      
  rep.set_signed_cookie(key,value,salt='加密盐')
  格式：Set-Cookie: name=zhang:1gPsDw:kPYWmlBNjZ7YXCSKT50nb1ldLjk;
  参数：
  
  #key---- 键
  
  #value='', 值
  
  #max_age=None, 超时时间 cookie需要延续的时间（以秒为单位）如果参数是\ None`` ，这个cookie会延续到浏览器关闭为止
  
  #expires=None, 超时时间(IE requires expires, so set it if hasn't been already.)
  
  #path='/', Cookie生效的路径，/ 表示根路径，特殊的：根路径的cookie可以被任何url的页面访问，浏览器只会把cookie回传给带有该路径的页面，这样可以避免将cookie传给站点中的其他的应用。
  
  #domain=None, Cookie生效的域名 你可用这个参数来构造一个跨站cookie。如， domain=".example.com"所构造的cookie对下面这些站点都是可读的：www.example.com 、 www2.example.com 和an.other.sub.domain.example.com 。如果该参数设置为 None ，cookie只能由设置它的站点读取
  
  #secure=False, 浏览器将通过HTTPS来回传cookie
  
  #httponly=False 只能http协议传输，无法被JavaScript获取（不是绝对，底层抓包可以获取到也可以被覆盖）
  
  ```

- 3.删除cookie

  ```python
  
  def delete_cookie(request):
      obj = HttpResponse('ok')
      # 指定删除名字是name的cookie
      obj.delete_cookie('name')
      return obj
  ```

- 4.登录认证装饰器

  ```python
  # 登录认证装饰器
  def login_auth(func):
      def inner(request, *args, **kwargs):
          # 拿到之前访问的路径
          # 这个不行,因为取不到数据部分
          # url=request.path
          url = request.get_full_path()
  
          is_login = request.COOKIES.get('is_login')
          if is_login:
              res = func(request, *args, **kwargs)
              return res
          else:
              return redirect('/login/?next=%s' % url)
  
      return inner
  
  
  # 新的login
  def login(request):
      if request.method == 'GET':
          return render(request, 'login.html')
      else:
          next = request.GET.get('next')
          name = request.POST.get('name')
          pwd = request.POST.get('pwd')
          if name == 'lqz' and pwd == '123':
  
              if next:  #判断是否存在next，存在则返回之前的页面，反之返回shop页面，并生成一个新的cookie
                  obj = redirect(next)
              else:
                  obj = redirect('/shopping/')
  
              obj.set_cookie('is_login', True)
              return obj
          else:
              return HttpResponse('用户名或密码错误')
  ```

#### 3.session组件（一定要做数据库迁移）

- 1.session的由来

  ```
  1.Cookie弥补了HTTP无状态的不足，让服务器知道来的人是“谁”；但是Cookie以文本的形式保存在本地，自身安全性较差；所以我们就通过Cookie识别不同的用户，对应的在Session里保存私密的信息以及超过4096字节的文本。
  
  另外，上述所说的Cookie和Session其实是共通性的东西，不限于语言和框架。
  
  2.session必须和cookie连用 
  ```

- 2.django中session相关方法

  ```python
  # 获取、设置、删除Session中数据
  request.session['k1']
  request.session.get('k1',None)
  request.session['k1'] = 123
  request.session.setdefault('k1',123) # 存在则不设置
  del request.session['k1']
  
  
  # 所有 键、值、键值对
  request.session.keys()
  request.session.values()
  request.session.items()
  request.session.iterkeys()
  request.session.itervalues()
  request.session.iteritems()
  
  # 会话session的key
  request.session.session_key
  
  # 将所有Session失效日期小于当前日期的数据删除
  request.session.clear_expired()
  
  # 检查会话session的key在数据库中是否存在
  request.session.exists("session_key")
  
  # 删除当前会话的所有Session数据(只删数据库)
  request.session.delete()
  　　
  # 删除当前的会话数据并删除会话的Cookie（数据库和cookie都删）。
  request.session.flush() 
      这用于确保前面的会话数据不可以再次被用户的浏览器访问
      例如，django.contrib.auth.logout() 函数中就会调用它。
  
  # 设置会话Session和Cookie的超时时间
  request.session.set_expiry(value)
      * 如果value是个整数，session会在些秒数后失效。
      * 如果value是个datatime或timedelta，session就会在这个时间后失效。
      * 如果value是0,用户关闭浏览器session就会失效。
      * 如果value是None,session会依赖全局session失效策略。
  ```

  ```
  思考，如果第二个人再次再同一个浏览器上登录，django-session表会怎样？
  
  会覆盖之前session，之前用户的登录信息失效
  ```

  ```
  **************session的配置
  不但能放到数据库,还能放到文件中,redis(内存数据库)
  ```

- 3.基于session的登录验证装饰器（FBV）

  ```python
  # 基于session写一个登陆认证装饰器,登陆之后才能查看订单页面,购物页面
  def auth_login(func):
      def inner(request, *args, **kwargs):
          url = request.get_full_path()
          if request.session.get('is_login'):
              res = func(request, *args, **kwargs)
              return res
          else:
              return redirect('/login/?next=%s' % url)
  
      return inner
  ```

  ```python
  def login(request):
      if request.method == 'GET':
          return render(request, 'login.html')
      else:
          name = request.POST.get("name")
          password = request.POST.get("password")
          next = request.GET.get('next')
          if name == 'zhang' and password == '123':
              if next:
                  obj = redirect(next)
              else:
                  obj = redirect('/shopping/')
              request.session['is_login'] = True
              return obj
          else:
              return HttpResponse('账号或密码错误')
  
  
  @auth_login
  def shopping(request):
      return HttpResponse('我是购物页面')
  
  
  @auth_login
  def order(request):
      return HttpResponse('我是订单页面')
  ```

- 4.登录认证装饰器（CBV）

  ```python
  from django.shortcuts import render, HttpResponse, redirect
  from django.views import View
  from django.utils.decorators import method_decorator
  
  from app01.models import User, OrderMsg
  from django.http import JsonResponse
  
  
  # Create your views here.
  
  def auth(func):
      from functools import wraps
      @wraps(func)
      def inner(request, *args, **kwargs):
          url = request.get_full_path()
          if request.session.get('id'):
              res = func(request, *args, **kwargs)
              return res
          else:
              return redirect('/login/?next=%s' % url)
  
      return inner
  
  
  class Login(View):
      def get(self, request):
          return render(request, 'login.html')
  
      def post(self, request):
          name = request.POST.get('name')
          password = request.POST.get('password')
          res = User.objects.filter(name=name, password=password).first()
          if res:
              url = request.GET.get('next')
              print(request.GET)
              request.session['name'] = res.name
              request.session['id'] = res.pk
              if url:
                  return redirect(url)  ---#这地方有问题
              else:
                  return redirect('/order/')
          else:
              return JsonResponse({'data': '用户名或密码错误', 'status': '100'})
  
  
  @method_decorator(auth, name='get')
  @method_decorator(auth, name='post')
  class Order(View):
      def get(self, request):
          id = request.session.get('id')
          msg = OrderMsg.objects.filter(user_id=id).all().values('name', 'price')
          lis = {'status': '101', 'data': [{i.get('name'): i.get('price')} for i in msg]}
          return JsonResponse(lis, safe=True, json_dumps_params={'ensure_ascii': False})
  
      def post(self, request):
          return HttpResponse('ok')
  
  ```

  ```html
  <!DOCTYPE html>
  <html lang="zh">
  <head>
      <meta charset="UTF-8">
      <title>登录</title>
      {% load static %}
      <script src="{% static '/utils/jquery-3.3.1.js' %}"></script>
  </head>
  <body>
  <form>
      用户名：<input type="text" name="name" class="name">
      密码：<input type="text" name="password" class="password">
      <button type="button" id="btn">提交</button>
      <span class="ss"></span>
  </form>
  </body>
  <script>
      $('#btn').click(function () {
          let msg = {
              'name': $('.name').val(),
              'password': $('.password').val()
          };
          $.ajax({
              url: '/login/',
              type: 'post',
              data: msg,
              dataType: 'json',
              success: function (data) {
                  console.log(data);
  
                  if (data.status === '100'){
                      $('.ss').text(data.data);
                  }
                  if (data.status === '101') {
                      location.href ='http://127.0.0.1:8234/order/';
                  }
              }
          })
      })
  </script>
  </html>
  ```

### day15

#### 1.中间件

```
1.什么是中间件
请求和响应之间的一道屏障
2.中间件的作用
控制请求和响应
```

#### 2.自定义中间件

```python
1.导入
先创建一个py文件,再导入
from django.utils.deprecation import MiddlewareMixin

2.定义一个类：名字可以随意，继承MiddlewareMixin
class MyMiddleware1(MiddlewareMixin):
    def process_request(self, request):
        print('MyMiddleware---->1---->process_request')
        # 返回HttpRspons对象,直接返回,走自己的process_response
        # 返回None的时候,继续往下走
        # return HttpResponse('i am middle--1')
        return None

    def process_response(self, request, response):

        print('MyMiddleware--->1---->process_response')
        return response
 
3.使用：在settings中注册
MIDDLEWARE = [
    'app01.mymiddelware.MyMiddleware1',
]
```

```
注意：
中间件的执行循序（正常情况）
request：从上往下执行，每个中间件都会执行
response：从下往上执行，每个中间件都会执行
-process_request,从上往下执行
    -如果retrun HttpResponse的对象,直接返回了
    -如果retrun None ,继续往下走
-process_response,从下往上执行
	-必须要retrun Httpresponse的对象
```

#### 3.中间件的方法（最重要前2个）

```
-process_request
-请求来的时候,会响应它

-process_response
-响应回去的时候,会走它

-process_view(了解)
    - request, callback(视图函数), callback_args(无名分组的参数), 	callback_kwargs(有名分组的参数)
-执行顺序,详见图

-def process_exception(self, request, exception)(了解)
-def process_template_response(self, request, response):(了解)
```

#### 4.csrf：跨站请求伪造

```
比如:转账请求:transfer?to=lqz&count=1000
是什么?
攻击者盗用了你的身份，以你的名义发送恶意请求，对服务器来说这个请求是完全合法的
```

```
如何防范：
1.通过refer：判断发送请求的上次域名和端口是不是在转账请求域名和端口内
2.加一个随机字符串校验（加在请求的路径里，或者加在请求体中）
3.在请求头中加字符串校验
```

```python
验证原理：
def _compare_salted_tokens(request_csrf_token, csrf_token):
    # Assume both arguments are sanitized -- that is, strings of
    # length CSRF_TOKEN_LENGTH, all CSRF_ALLOWED_CHARS.
    return constant_time_compare(
        _unsalt_cipher_token(request_csrf_token),
        _unsalt_cipher_token(csrf_token),
    )

def _unsalt_cipher_token(token):
    """
    Given a token (assumed to be a string of CSRF_ALLOWED_CHARS, of length
    CSRF_TOKEN_LENGTH, and that its first half is a salt), use it to decrypt
    the second half to produce the original secret.
    """
    salt = token[:CSRF_SECRET_LENGTH]
    token = token[CSRF_SECRET_LENGTH:]
    chars = CSRF_ALLOWED_CHARS
    pairs = zip((chars.index(x) for x in token), (chars.index(x) for x in salt))
    secret = ''.join(chars[x - y] for x, y in pairs)  # Note negative values are ok
    return secret

token字符串的前32位是salt， 后面是加密后的token， 通过salt能解密出唯一的secret。
django会验证表单中的token和cookie中token是否能解出同样的secret，secret一样则本次请求合法。
同样也不难解释，为什么ajax请求时，需要从cookie中拿取token添加到请求头中。

```

```python
如何使用：
1.中间件不在注释掉
2.以后再发post请求时，携带那个随机字符串

form表单形式:
<form action="" method="post">
    {% csrf_token %}
    <input type="text" name="name">	
    <input type="text" name="pwd">
    <input type="submit" value="提交">
</form>

ajax提交：
data: {
    'name': $('[name="name"]').val(),
    'pwd': $('[name="pwd"]').val(),
    //'csrfmiddlewaretoken': $('[name="csrfmiddlewaretoken"]').val()
    'csrfmiddlewaretoken': '{{ csrf_token }}'
},
```

#### 5.csrf：局部禁用，局部使用(CBV)

```python
1.局部禁用：全局就得使用
2.局部使用：全局就得禁用
from django.views import View
from django.utils.decorators import method_decorator
@method_decorator(csrf_protect,name='dispatch')
class Csrf_disable(View):
    # @method_decorator(csrf_protect)
    def dispatch(self, request, *args, **kwargs):
        ret=super().dispatch(request, *args, **kwargs)
        return ret
    def get(self,request):
        return HttpResponse('ok')

    def post(self,request):
        return HttpResponse('post---ok')
```

```
注意：****
只能加在dispatch方法或者类上面，如上
```

#### 6.csrf：局部禁用，局部使用(FBV)

```python
用装饰器:from django.views.decorators.csrf import csrf_exempt,csrf_protect
    fbv--->直接加载fbv上就行了
    局部禁用,全局得使用
    @csrf_exempt
    def csrf_disable(request):
        print(request.POST)
        return HttpResponse('ok')
    局部使用,全局得禁用
    @csrf_protect
    def csrf_disable(request):
        print(request.POST)
        return HttpResponse('ok')
```
### day16
#### 1.auth组件

```python
1.什么是auth组件
是django内置的用户认证的组件

2.作用
可以快速的实现用户的登录，注册，修改，注销等操作
```

![1552153143351](django笔记1\1552153143351.png)

##### is_superuser是0普通用户,1超级用户

![1552153361848](django笔记1\1552153361848.png)

##### 干了3件事生成一个随机字符串,把随机字符串写到cookie里,再写道session的字典里

![1552153728832](django笔记1\1552153728832.png)

##### 以后在任意视图可以调用user的方法

![1552153847052](django笔记1\1552153847052.png)

![1552154157269](django笔记1\1552154157269.png)

###### auth中间件

![1552154010685](django笔记1\1552154010685.png)

#### 2.auth组件常用的功能

```python
1.auth验证功能  --authenticate

from django.contrib import auth
user = auth.authenticate(request, username = name, password = password)
**通过返回一个user对象
相当于：
user = User.objects.filter(name = name, password = password).first()
```

```python
2.auth登录功能   --login

auth.login(request, user)
目的：就是将用户信息存到session里面，并返回给客户端一个cookie里面包含一个随机字符串
相当于：
request.session['name'] = name

注意：
一旦登录成功，以后无论在哪个视图函数中，会多一个request.user的属性
无论在哪个视图函数中都可以通过request.user取出当前登录的用户对象
如果没有登录：request.user = AnonymousUser匿名用户
```

```
3.auth注销功能  --logout

auth.logout(request)
相当于：
request.session.flush(),删除用户的状态
```

![1552154293200](django笔记1\1552154293200.png)

![1552154436732](django笔记1\1552154436732.png)

```python
4.auth的登录认证装饰器

from django.contrib.auth.decorators import login_required
@login_required(redirect_field_name = 'mmm',login_url='/login/')
相当于：
?next=/.../ ...代表上次访问的路径，登录成功后返回到上次访问的路径
redirect_field_name --相当于？后面的key值
login_url = '/login/'

注意:可以全局配置(setting配置)
# 全局的配置,如果没有登录,跳到这个路由
LOGIN_URL='/login/'
```

```python
5.auth创建用户   --create_user/create_superuser

from django.contrib.auth.models import User
-创建普通用户
user = User.objects.create_user(username = name, password = password)
-创建超级用户
user = User.objects.create_superuser(username = name, password = password)

注意：
不能使用create直接创建用户，因为密码是密文的，而create的密码是明文的，所以反解时会出错
user=User.objects.create(username=name,password=pwd)

```

```python
6.auth校验密码  ---check_password
res = request.user.check_password(password)
返回时boolean类型
```

```python
7.auth修改密码   ---set_password
res = request.user.set_password(newpassword).save()
```

```注销python
8.auth判断当前用户是否通过认证   ---is_authenticated(调用了login方法)
res = request.user.is_authenticated()
返回boolean类型
应用场景登陆了显示requset.user.username,没有登陆显示注册
```

```python
9.
auth判断用户是否拥有网站的管理权限（is_staff）
10.
is_active ： 是否允许用户登录, 设置为 False，可以在不删除用户的前提下禁止用户登录。
```

orm删除

#### 3.扩展默认的auth_user表(增加一个字段)

![1552156641791](django笔记1\1552156641791.png)

```python
方式一：使用一对一关联
from django.contrib.auth.models import User

# 第一种方式
class UserDetail(models.Model):
    phone=models.CharField(max_length=32)
    # 一对一跟auth_user表做关联
    # 如果是从外部引入的表模型,是不能加引号的
    # 如果加引号,只是在当前model找
    user=models.OneToOneField(to=User)
```

```python
方式二：使用类继承AbstractUser,因为user模块也是继承了AbstractUser
from django.contrib.auth.models import AbstractUser
class UserInfo(AbstractUser):
    # username,password...都有
    phone = models.CharField(max_length=32)
    sex = models.BooleanField()
    
注意：一定要在setting里面做配置
# 引用Django自带的User表，继承使用时需要设置
AUTH_USER_MODEL = "app名.UserInfo"
# 一旦我们指定了新的认证系统所使用的表，我们就需要重新在数据库中创建该表，而不能继续使用原来默认的auth_user表了。
```

![1552156970809](django笔记1\1552156970809.png)

###### 重构后导入自己的

![1552157199316](django笔记1\1552157199316.png)

#### 4.auth使用login_required如何重定向回去

```python
# 需要登录的视图函数
@login_required(redirect_field_name='next')
def back(request):
    if request.method == 'GET':
        blog = request.user.blog
        article_list = Article.objects.filter(blog=blog)
        return render(request, 'back_edit/detail.html', locals())
        
# login视图函数
def login(request):
    if request.method == 'GET':
        return render(request, 'login.html', locals())
    if request.method == 'POST':
        print(request.body)
        dic = json.loads(request.body)
        url = request.GET.get('next') # 获得next后面值
        if dic['code'] == request.session.get('valid_code'):
            dic.pop('code')
            user = auth.authenticate(request, **dic)
            if user:
                auth.login(request, user)
                if url: # 有就重定向指定url
                    res = {'status': '101', 'url': url}
                else: # 没有就返回到主页
                    res = {'status': '101', 'url': '/index/'}
            else:
                res = {'status': '404', 'data': '用户名或密码错误'}
        else:
            res = {'status': '404', 'data': '验证码输入错误'}
        return JsonResponse(res)
```

```
1.ajax按照上面的方式重定向

2.form表单，直接视图函数中重定向
```
