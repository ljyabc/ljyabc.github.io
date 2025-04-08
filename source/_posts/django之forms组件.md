---
title: django之forms组件
tags: [lnhdjango基础]
date: 2021-05-05 14:39:52
categories: 理解
photos:
book:
---

# forms组件

## 作用

```python
前台会传过来不同种类的数据，对前台传过来的数据进行校验
```

## 在views.py导入 django 的form模块

```python
from django import form
```

## 写一个类

```python
class MyForm(forms.Form):
    # 要校验那些字典，就是类的属性
    # 定义一个属性可以用来校验字符串类型
    name = forms.CharField(max_length=8,min_length=3)
    # required=True默认必填
    pwd = forms.CharField(max_length=8,min_length=3,required=True)
    # 校验是否是邮箱格式
    email = forms.EmailField()
```

## 定义视图函数1

```python
# 要校验的字典，可以多参数，少呢？ 但是不能少
def index_form1(request):
    # 生成对象的时候，需要传入要校验的数据（字典）
    if request.method == 'GET':
        return render(request,'index.html')
    elif request.method == 'POST':
        print(request.POST)
        myform  = MyForm(request.POST)
        # is_valid是true校验成功，反之，校验失败
        myform.is_valid()
        if myform.is_valid():
            print(myform.cleaned_data)
            return HttpResponse('校验成功')
        else:
            # 校验成功的数据，也是一个字典
            print(myform.cleaned_data)
            #错误信息 它是一个字典
            print(myform.errors)
            # 错误信息列表，因为会有多个
            print(myform.errors.as_data())
            #
            print(type(myform.errors))
            # 是一个字典类型
            from django.forms.utils import ErrorDict

            return HttpResponse('校验失败')
```

### index.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<form action="" method="post">
    <p>用户名: <input type="text" name="name"></p>
    <p>密码: <input type="text" name="pwd"></p>
    <p>邮箱: <input type="text" name="email"></p>
    <input type="submit" value="提交">
</form>
</body>
</html>
```

## forms组件校验渲染

### 定义视图函数2

```python
def index_form2(request):
    # 生成对象的时候，需要传入要校验的数据（字典）
    myform = MyForm()
    if request.method == 'GET':
        return render(request,'index2.html',locals())
```

### 第一种渲染方式

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<hr>
<h1>第一种方式</h1>
<form action="" method="post">
    <p>用户名: {{ myform.name }}</p>
    <p>密码: {{ myform.pwd }}</p>
    <p>邮箱: {{ myform.email }}</p>
    <input type="submit" value="提交">
</form>
</body>
</html>
```

### 第二种渲染方式 注意label

```html
<hr>
<h1>第二种方式</h1>
<form action="" method="post">
    {% for foo in myform %}
    <p>{{ foo.label }}:{{ foo }}</p>
    {% endfor %}

    <input type="submit" value="提交">
</form>
```

#### 在form类定义里面属性加入lacel参数

```python
# 前台传过来不同种类的数据
from django import forms
# 写一个类 ，继承Form
class MyForm(forms.Form):
    # 要校验那些字典，就是类的属性
    # 定义一个属性可以用来校验字符串类型
    name = forms.CharField(max_length=8,min_length=3,label='用户名')
    # required=True默认必填
    pwd = forms.CharField(max_length=8,min_length=3,required=True,label='密码')
    # 校验是否是邮箱格式
    email = forms.EmailField(label='邮箱')
```

### 第三种渲染方式 不建议使用

```html
<h1>第三种方式</h1>
<form action="" method="post">
{#    {{ myform.as_p }}#}
    {{ myform.as_ul }}
    <input type="submit" value="提交">
</form>
```

## forms组件渲染错误信息

```python
- myforms有errors
			-属性(name)也有errors
			-错误信息,变成中文:
				- error_messages={'max_length': '最长是8', 'min_length': '最短是3', 'required': '这个必须填','invalid': '不符合邮箱格式'}
			-给input标签指定样式,指定格式:
				 -widget=widgets.TextInput(attrs={'class':'form-control'})
			-模板,渲染错误信息:<span>{{ myform.name.errors.0 }}</span>
```

### views.py代码

```python
def index_form3(request):
    # 生成对象的时候，需要传入要校验的数据（字典）

    if request.method == 'GET':
        myform = MyForm()
    elif request.method == 'POST':
        myform = MyForm(request.POST)

    return render(request, 'index3.html', locals())

```

### index3.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
</head>
<body>

<h1>第二种方式</h1>
<form action="" method="post" novalidate>
    {% for foo in myform %}
    <p>{{ foo.label }}:{{ foo }} <span>{{ foo.errors.0 }}</span></p>
    {% endfor %}

    <input type="submit" value="提交">
</form>

</body>
</html>
```

### 错误信息变中文和指定样式

```python
# 前台传过来不同种类的数据
from django import forms

from django.forms import widgets


# 写一个类 ，继承Form
class MyForm(forms.Form):
    # 要校验那些字典，就是类的属性
    # 定义一个属性可以用来校验字符串类型
    name = forms.CharField(max_length=8, min_length=3, label='用户名',
                           error_messages={'max_length': '最长是8', 'min_length': '最短是3', 'required': '这个必须填'}
                           ,widget=widgets.TextInput(attrs={'class':'form-control'}))
    # required=True默认必填
    pwd = forms.CharField(max_length=8, min_length=3, required=True, label='密码',
                          error_messages={'max_length': '最长是8', 'min_length': '最短是3', 'required': '这个必须填'}
                          , widget=widgets.PasswordInput()
                          )
    # 校验是否是邮箱格式
    email = forms.EmailField(label='邮箱', error_messages={'required': '这个必须填', 'invalid': '不符合邮箱格式'})
```

## 钩子函数

### 局部钩子

#### 作用

```
比如用户名已经被注册 ，需要校验渲染到页面上
```

#### 使用在其他校验完成后做钩子函数的校验

```python
-定义一个函数,名字叫:clean_字段名字,内部,取出该字段,进行校验,如果通过,将该字段返回,如果失败,抛异常(ValidationError)
			-   def clean_name(self):
					# self:当前form对象
					name = self.cleaned_data.get('name')
					if name.startswith('sb'):
						# 失败,抛异常
						raise ValidationError('不能以傻逼开头')
					# 正常,把name返回
					return name
```

### 全局钩子

```python
#重写clean方法
			def clean(self):
				#程序能走到该函数,前面校验已经通过了,所以可以从cleaned_data中取出密码和确认密码		
				pwd=self.cleaned_data.get('pwd')
				re_pwd=self.cleaned_data.get('re_pwd')
				#进行自己的校验
				if pwd==re_pwd:
					#通过,直接返回cleaned_data
					return self.cleaned_data
				else:
					#失败,抛异常(ValidationError)
					raise ValidationError('两次密码不一致')
```

