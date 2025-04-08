---
title: django之cookie
tags: [lnhdjango基础]
date: 2021-05-05 14:33:02
categories: 理解
photos:
book:
---



# cookie

## 是什么?

```
存储在客户端浏览器上的键值对
```

## 原理

```
是服务器产生,发给客户端浏览器,浏览器保存起来,下次发请求,会携带这个键值对到服务器
```

## Cookie的覆盖

```
先写了一个键值对,后来再写,会把原来的值覆盖掉
```

## cookie使用

### 添加cookie

```python
写cookie:在Httpresponse这个对象上写
				obj.set_cookie(key,value)
```

#### 添加cookie的路由

```python
url(r'^set_cookie/', views.set_cookie),
```

#### 添加cookie的视图函数

```python
def set_cookie(request):
    obj = HttpResponse('ok')
    # 设置cookie
    obj.set_cookie('name','shouyue')
    return obj
```

### 提取cookie

```python
从request对象中取,取出来是个字典request.COOKIES
```

#### 提取cookie的路由

```python
url(r'^get_cookie/', views.get_cookie),
```

#### 提取cookie的视图函数

```python
def get_cookie(request):
    print(type(request.COOKIES))
    # 取cookie的值
    print(request.COOKIES)
    name = request.COOKIES.get('name')
    print(name)
    obj = HttpResponse('get_cookie')
```

### 删除cookie

```python
obj.delete_cookie('name')
```

## 简单的cookie登录认证的装饰器

### cookie登录认证的装饰器视图层

```python
def login_auth(func):
    def inner(request,*args,**kwargs):
        is_login = request.COOKIES.get('is_login')
        if is_login:
            res = func(request,*args,**kwargs)
            return res
        else:
            return redirect('/login/')
    return inner

def login(request):
    if request.method == 'GET':
        return render(request,'login.html')
    else:

        name=request.POST.get('name')
        pwd = request.POST.get('pwd')
        if name == 'shouyue' and pwd == '123':
            #登录成功，写到客户端浏览器cookie
            obj =HttpResponse('登录成功')
            # 新手三件套，都能写cookie
            obj.set_cookie('is_login',True)
            return obj
        else:
            return HttpResponse('用户名或密码错误')

@login_auth
def order(request):

    return HttpResponse('我是订单页面,我得登录才能看')

@login_auth
def shopping(request):

    return HttpResponse('我是购物,我得登录才能看')
```

### cookie登录认证的装饰器路由层

```python
    url(r'^login/', views.login),
    url(r'^order/', views.order),
    url(r'^shopping/', views.shopping),
```

## 加强版的cookie登录认证的装饰器

### 加强版的cookie登录认证的装饰器视图层

```python
def login_auth(func):
    def inner(request,*args,**kwargs):
        #这个不行，因为取不到数据部分
        # url = request.path
        url = request.get_full_path()
        is_login = request.COOKIES.get('is_login')
        if is_login:
            res = func(request,*args,**kwargs)
            return res
        else:
            return redirect('/login/?next=%s'%url)
    return inner

def login(request):
    if request.method == 'GET':
        return render(request, 'login.html')
    else:
        next = request.GET.get('next')
        name = request.POST.get('name')
        pwd = request.POST.get('pwd')
        if name == 'shouyue' and pwd == '123':
            # 登录成功，写到客户端浏览器cookie
            if next:
                obj = redirect(next)
            else:
                obj = redirect('/shopping/')
                # 新手三件套，都能写cookie
            obj.set_cookie('is_login', True)
            return obj
        else:
            return HttpResponse('用户名或密码错误')
        
@login_auth
def order(request):

    return HttpResponse('我是订单页面,我得登录才能看')

@login_auth
def shopping(request):

    return HttpResponse('我是购物,我得登录才能看')
```

## cookie其他参数

### 加盐cookie，salt参数

#### 加盐cookie路由

```python
url(r'^salt_cookie/', views.salt_cookie),
```

#### 加盐cookie视图函数

```python
def salt_cookie(request):
    object = HttpResponse('ok')
    # 加盐,123是个密码，解cookie的时候需要它
    object.set_signed_cookie('name','shouyue',salt='123')
    # 结果
    # name=shouyue:1kyYeb:kZdqdfPCeKHpItoGQgA4o-5C9_Q
    return object
```

### cookie过期时间

#### cookie路由

```python
url(r'^set_cookie_time/', views.set_cookie_time),
url(r'^get_cookie_time/', views.get_cookie_time),
```

#### cookie视图函数 max_age 传入一个秒的时间

```python
def set_cookie_time(request):
    object = HttpResponse('添加cookie5秒')
    # 5秒后失效
    object.set_cookie('name','shouyue1',max_age=15)
    return object

def get_cookie_time(request):
    name= request.COOKIES.get('name')
    print(name)
    return HttpResponse('测试cookie时间')
```

#### cookie视图函数 expires 传入一个datatime对象

```python
from datetime import datetime
def set_cookie_time(request):
    object = HttpResponse('添加cookie5秒')
    # 5秒后失效
    object.set_cookie('name','shouyue1',expires=datetime)
    return object

def get_cookie_time(request):
    name= request.COOKIES.get('name')
    print(name)
    return HttpResponse('测试cookie时间')
```

### cookie的生效路径 path

#### cookie的生效路径路由

```python
url(r'^shopping/', views.shopping),
url(r'^set_shopping_cookie/', views.set_shopping_cookie),
url(r'^get_shopping_cookie/', views.get_shopping_cookie),
```

#### cookie的生效路径视图函数

```python
def set_shopping_cookie(request):
    object = HttpResponse('设置shopping的cookie')

    object.set_cookie('name','shouyue1',path='/shopping/')
    return object
# 其他的不生效shopping的cookie
def get_shopping_cookie(request):
    name= request.COOKIES.get('name')
    print(name)
    return HttpResponse('测试设置shopping的cookie没有哦')

# 只要shopping的cookie才生效
def shopping(request):

    return HttpResponse('设置shopping的cookie我才有')
```

### domain 设置域名

```
下有效domain='map.baidu.com'
```

### secure = False,

```
默认是false,设置成True浏览器将通过HTTPS来回传cookie
```

### httponly=True

```
只能https协议传输，无法被JavaScript获取（不是绝对，底层抓包可以获取到也可以被覆盖)
```

