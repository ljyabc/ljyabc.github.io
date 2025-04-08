---
title: django模板层
tags: [lnhdjango基础]
date: 2021-04-30 14:54:47
categories: 理解
photos:
book:
---

# 模板层之变量

## 1 模版语法之变量

### locals()可以接受所有的模板变量

#### views.py层 之变量

```python
def moban(request):
    name = 'shouyue'
    age = 18
    ll = [1,2,'shouyue']
    tu = (1,2,3)
    dic = {'name':'shouyue','age':18,'ll':[1,2,4]}
    # return render(request,'index.html',{'name':name})
    # locals() 会把*该*视图函数内的变量,传到模板
    return render(request,'moban.html',locals())
```

#### template层 之变量

```html
<body>
<hr>
<h1>模板语言之变量</h1>
<p>字符串{{ name }}</p>
<p>数字{{ age }}</p>
<p>列表{{ ll }}</p>
<p>字典{{ dic }}</p>
</body>
```

##### 模板层深度查询列表和字典

```html
<p>列表第0个值:{{ ll.0 }}</p>
<p>列表第2个值:{{ ll.2 }}</p>
<p>字典取值:{{ dic.name }}</p>
<p>字典取列表值:{{ dic.ll }}</p>
```

## 2 模版语法之函数

#### views.py层 之函数

```python
def moban(request):    
    def shouyue():
        print('shouyue')
        return 'shouyue传到模板层'
    return render(request,'moban.html',locals())
```

#### template层 之函数

```html
{#只写函数名:相对于函数名(),执行该函数#}
<p>函数:{{ shouyue }}</p>
```

## 3 模版语法之类和对象

### 只能渲染对象

#### views.py层 之类与对象

```python
# 类和对象
def moban(request):
    class Person():
        def __init__(self, name, age):
            self.name = name
            self.age = age

        def get_name(self):
            return self.name

        @classmethod
        def cls_test(cls):
            return 'cls'

        @staticmethod
        def static_test():
            return 'static'

        # 模板里不支持带参数
        def get_name_cs(self, ttt):
            return self.name

    shouyue = Person('shouyue', 18)
    yuan = Person('yuan', 18)
    person_list = [shouyue, yuan]
    person_dic = {'shouyue': shouyue}
    cls1=Person.cls_test()
    return render(request,'moban.html',locals())
```

#### template层 之类

```html
{# 类和类的绑定方法无法直接渲染，但是类的绑定方法需要在视图函数产生才能渲染#}
<p>类:{{ Person }}</p>
<p>类:{{ Person.cls_test }}</p>
{# 类的绑定方法 #}
<p>类:{{ cls1 }}</p>
```

#### template层 之对象



```html
{#对象#}
<p>对象:{{ shouyue1 }}</p>
<p>列表套对象:{{ person_list }}</p>
<p>字典套对象:{{ person_dic }}</p>
```

##### 模板层对象深度查询

```html
<p>对象属性:{{ shouyue1.name }}</p>
<p>对象方法:{{ shouyue1.get_name }}</p>
<p>对象调用绑定类方法:{{ shouyue1.cls_test }}</p>
<p>对象调用静态方法:{{ shouyue1.static_test }}</p>
<p>把对象列表中yuan年龄取出来:{{ person_list.1.age }}</p>
```

##### 深度查询注意不能有参数的方法

```python
{#拓展:不能调有参数的方法#}
<p>字符串的方法:{{ name.upper }}</p>
```

## 

