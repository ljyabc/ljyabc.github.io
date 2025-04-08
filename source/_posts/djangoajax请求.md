---
title: djangoajax请求
tags: [lnhdjango基础]
date: 2021-05-05 14:30:43
categories: 理解
photos:
book:
---

# ajax请求

## 1注释掉提交安全

### settings.py

```python
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    # 'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]
```

## 2路由

```python
from app01 import views
urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^index/', views.index),
]
```

## 3.视图函数

```python
from django.shortcuts import render,HttpResponse

# Create your views here.

def index(request):
    if request.method == 'GET':
        print(request.body)
        print(request.POST)
        print(request.GET)
        return render(request,'index.html')
    else:
        print(request.body)
        print(request.POST)
        print(request.GET)
        return HttpResponse('ok')
```

## 4模板层

### ajaxget

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="/static/jquery-3.3.1.js"> </script>
</head>
<body>
<button class="btn">点我后台发数据</button>
</body>
<script>
{#   取btn这个按钮 #}
    $('.btn').click(function () {
        {#alert(1)#}
        $.ajax({
            // url ：向后台发送请求的地址
            url:'/index/?name=lqz',
            type:'get'
        })
    })
</script>
</html>
```

### ajaxpost请求

```html
<script>
{#   取btn这个按钮 #}
    $('.btn').click(function () {
        {#alert(1)#}
        /*$.ajax({
            // url ：向后台发送请求的地址
            url:'/index/?name=lqz',
            type:'get'
        })*/
        $.ajax({
            url:'index',
            type:'post',
            //data 往后台提交数据
            data:{'name':'shouyue','age':18},
            //成功的时候回调
            success:function (data) {
                alert(data)
            }
        })
        alert('123')
    })
</script>
```

## 练习

### 路由

```python
from app01 import views
urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^index/', views.index),
    url(r'^add/', views.add),
]
```

### 视图层

```python
def add(request):
    if request.method == 'GET':
        return render(request,'add.html')
    print(1111)
    add1= request.POST.get('add1')
    add2= request.POST.get('add2')
    sum =int(add1)+int(add2)
    print(sum)
    return HttpResponse(str(sum))
```

### 模板层

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="/static/jquery-3.3.1.js"> </script>
</head>
<body>
<p><input type="text" name="add1" id="add1">+<input type="text" name="add2" id="add2">=<input type="text" name="sum" id="sum"></p>
<button class="btn">点我</button>

</body>
<script>
    $('.btn').click(function () {
        $.ajax({
            url:'add',
            type:'post',
            data:{'add1':$('#add1').val(),'add2':$('#add2').val()},
            success:function (data) {
                {#alert(data)#}
                $("#sum").val(data)


            }
        })
    })
</script>
</html>
```

# ajax的理解

## 1 什么是ajax

异步的JavaScript和xml,跟后台交互,都用json

## 2 ajax干啥用的?

前后端做数据交互:

## 3 之前学的跟后台做交互的方式:

-第一种:在浏览器窗口输入地址(get)
-第二种:用form表单提交数据

## 4 特点:

-异步(异步和同步的区别:同步是请求发过去,要等着回应;异步:不需要等回应,可以进行其他操作)
-局部刷新:

## 5操作

```htm
$.ajax({
            url:'/index/',
            type:'post',
            //data:往后台提交的数据
            data:{'name':'shouyue','age':18},
            //成功的时候回调这个函数
            success:function (data) {
                alert(data)
            }
})
```

