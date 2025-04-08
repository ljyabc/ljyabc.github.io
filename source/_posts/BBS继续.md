---
title: BBS继续
tags: [lnhdjango基础]
date: 2021-05-05 14:38:29
categories: 理解
photos:
book:
---

# BBS

## 32StringIO个bytesio

### stringIO

```python
很多时候，数据读写不一定是文件，也可以在内存中读写。

StringIO顾名思义就是在内存中读写str。

要把str写入StringIO，我们需要先创建一个StringIO，然后，像文件一样写入即可：

## 
>>> from io import StringIO
>>> f = StringIO()
>>> f.write('hello') # 5
>>> f.write(' ') # 1
>>> f.write('world!') # 6
>>> print(f.getvalue()) # hello world!
getvalue()方法用于获得写入后的str。

要读取StringIO，可以用一个str初始化StringIO，然后，像读文件一样读取：
>>> from io import StringIO
>>> f = StringIO('Hello!\nHi!\nGoodbye!')
>>> while True:
...     s = f.readline()
...     if s == '':
...         break
...     print(s.strip())
```

### BytesIO

```python
StringIO操作的只能是str，如果要操作二进制数据，就需要使用BytesIO。

BytesIO实现了在内存中读写bytes，我们创建一个BytesIO，然后写入一些bytes：

>>> from io import BytesIO
>>> f = BytesIO()
>>> f.write('中文'.encode('utf-8')) # 6
>>> print(f.getvalue()) # b'\xe4\xb8\xad\xe6\x96\x87'
请注意，写入的不是str，而是经过UTF-8编码的bytes。

和StringIO类似，可以用一个bytes初始化BytesIO，然后，像读文件一样读取：

>>> from io import StringIO
>>> f = BytesIO(b'\xe4\xb8\xad\xe6\x96\x87')
>>> f.read() # b'\xe4\xb8\xad\xe6\x96\x87'
StringIO和BytesIO是在内存中操作str和bytes的方法，使得和读写文件具有一致的接口。
```

## PIL

```
from PIL import Image, ImageDraw, ImageFont
# Image图片， ImageDraw图片上写文字 ImageFont字体样式
```

## 手动后台控制颜色的淡与深

```
配置到settings.py里面
```

## 39验证码应该放在那里

```
放到session里面

```

## 44.登陆前台点击事件tempates

ajax发送请求局部刷新

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script src="/static/jquery-3.3.1.js"></script>
    <title>登录</title>
    <style>
        .error{
            margin-left: 20px;
            color: red;
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <h1>登录</h1>
            {#            26.{# label for="name"  如果指定某个id,这样点击这个label,焦点会到对应的控件上         #}
            <form>
                {% csrf_token %}
                {#                生成一个隐藏的input框#}
                <div class="form-group">
                    <label for="name">用户名</label>
                    <input type="text" id="name" class="form-control">
                </div>
                <div class="form-group">
                    <label for="pwd">密码</label>
                    <input type="password" id="pwd" class="form-control">
                </div>
                <div class="form-group">
                    <label for="valid_code">验证码</label>
                    {#                    27.预留出验证码一半的位置#}
                    <div class="row">
                        <div class="col-md-6">
                            <input type="text" id="valid_code" class="form-control">
                        </div>
                        {#                        28.添加一个本地的路由#}
                        <img height="35" width="320" src="/get_valid_code/" alt="" id="img_code">
                    </div>

                </div>

                <input type="button" value="登录" class="btn btn-primary " id="btn"><span class="error"></span>
            </form>
        </div>
    </div>
</div>
</body>
<script>
    $('#img_code').click(function () {
        //在路径后面加一个问号
        //
        $('#img_code')[0].src += '?'

    })
    $('#btn').click(function () {
        $.ajax({
            url: '/login/',
            type: 'post',

            data: {'name': $('#name').val(),
                'pwd': $('#pwd').val(),
                'valid_code': $('#valid_code').val(),
                'csrfmiddlewaretoken':$('[name="csrfmiddlewaretoken"]').val()
                //'csrfmiddlewaretoken':'{{ csrf_token }}'
            },
            success:function (data) {
                console.log(data)
                if(data.user){
                    location.href='/index/'
                }else {
                    $('.error').html(data.msg)
                }

            }
        })

    })
</script>
</html>
```

## 44.登陆后台台点击事件views.py

```python
def login(request):
    if request.method == 'GET':
        dic = {'name': 'lqz', 'age': 18}
        return render(request, 'login.html', locals())
    # elif request.method=='POST':
    # 44.# 判断前台发的请求是不是ajax的请求
    elif request.is_ajax():
        response = {'user': None, 'msg': None}
        name = request.POST.get('name')
        pwd = request.POST.get('pwd')
        valid_code = request.POST.get('valid_code')
        # 45.# 判断传过来的验证码是否正确
        # 从session中取出来
        if valid_code.upper() == request.session.get('valid_code').upper():
            # 46.导入auth模块
            user = auth.authenticate(request, username=name, password=pwd)
            if user:
                # ajax请求,不能再返回render页面,或者redirect,只能返回字符串
                # 校验通过,一定要登录
                auth.login(request, user)
                response['user'] = name
                response['msg'] = '登录成功'
            else:
                # 用户名密码错误
                response['msg'] = '用户名密码错误'
        else:
            response['msg'] = '验证码错误'
        print(response)
    return JsonResponse(response)
```

