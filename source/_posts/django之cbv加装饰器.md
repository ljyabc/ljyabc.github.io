---
title: django之cbv加装饰器
tags: [lnhdjango基础]
date: 2021-05-05 14:33:57
categories: 理解
photos:
book:
---

# cbv加装饰器

## cbv路由

```python
url(r'^login/', views.Login.as_view()),
url(r'^order/', views.Order.as_view()),
```

## 普通的添加cbv装饰器 views.py

### 第一种，原始方法

```python
def login_auth(func):
    def inner(self,request,*args,**kwargs):
        url=request.get_full_path()
        if request.session.get('id'):
            ret = func(self,request,*args,**kwargs)
        else:
            return redirect('/login/?next=%s'%url)
        return ret

    return inner

class Login(View):
    def get(self,request,*args,**kwargs):
        return render(request,'login.html')
    def post(self,request,*args,**kwargs):
        # 拿到前台的用户和密码
        name = request.POST.get('name')
        pwd = request.POST.get('pwd')
        # 和数据库对比查出该信息
        ret = models.User.objects.filter(name=name,pwd=pwd).first()
        # 是否存在
        if ret:

            url = request.GET.get('next')
            # 存在将用户的id和名字添加到服务器session表里面，sessionid添加到cookie里面
            request.session['id']=ret.pk
            request.session['name']=ret.name
            # 返回
            return redirect(url)
        else:
            return HttpResponse('用户名或密码错误')



class Order(View):
    @login_auth
    def get(self,request):
        # 取数据库查询订单，返回
        return HttpResponse('我是订单页面，我查出了好多')
```

### 第二种，@method_decorator装饰绑定对象的方法

```python
from django.utils.decorators import  method_decorator

class Order(View):
    @method_decorator(login_auth)
    def get(self,request):
        # 取数据库查询订单，返回
        return HttpResponse('我是订单页面，我查出了好多')
```

### 第三种，@method_decorator装饰类

```python
from django.utils.decorators import  method_decorator
@method_decorator(login_auth,name='get')
class Order(View):

    def get(self,request):
        # 取数据库查询订单，返回
        return HttpResponse('我是订单页面，我查出了好多')
```

### 第四种可以加在dishpatch方法上

```python
@method_decorator(login_auth)
一旦加在dishpatch,说明,所有方法都加了装饰器
```

