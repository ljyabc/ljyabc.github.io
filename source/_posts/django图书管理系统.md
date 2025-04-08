---
title: django图书管理系统
tags: [lnhdjango基础]
date: 2021-04-30 14:09:36
categories: 理解
photos:
book:
---



# django图书管理系统

## django的生命周期

![1608019817174](django图书管理系统\1608019817174.png)

## 1.static配置    setting.py

```python
STATICFILES_DIRS = [
    os.path.join(BASE_DIR,'static')
]
```

## 2.app里面  init.py

```python
import pymysql
pymysql.install_as_MySQLdb()
```

## 3.models.py    orm对象关系映射

### Publish表   出版社

```python
class Publish(models.Model):
    # 可以不写，默认棒你创建

    # nid =models.AutoField(primary_key=True)

    name = models.CharField(max_length=32)
    addr = models.CharField(max_length=64)
    # 也是一个varchar类型，只不过会判断一下是否是邮箱
    email = models.EmailField()
```

### Author表  作者表

```python
class Author(models.Model):
    nid = models.AutoField(primary_key=True)
    name = models.CharField(max_length=32)
    age = models.IntegerField()
```

### book表 图书表    与Publish表 是多对一的关系    与Author表示多对多的关系

```python
class Book(models.Model):
    name = models.CharField(max_length=32)
    # 浮点型
    price = models.DecimalField(max_digits=5,decimal_places=2)
    pub_date = models.DateField()
    # to 可以不加引号 ，但是，要在前面定义
    # 自动在publist后面加了一个_id
    publist =models.ForeignKey(to=Publish,to_field='nid')
    # 自动创建了第三张表
    authors = models.ManyToManyField(to='Author')
```

## 4.执行数据库迁移

```mysql
1 python3 manage.py makemigrations   ----记录一下数据库的变化
2 python3 manage.py migrate          ----将变化同步到数据库中
```

## 5.出版社视图函数，模板层，路由

### 1.add_publish添加部分

#### 1.1.注意些urls.py路由

```python
# 记得导入app里面的视图函数文件
from app01 import views
urlpatterns = [
    url(r'^admin/', admin.site.urls),
    # 每一个视图函数的路由记得写
    url(r'^add_publish/', views.add_publish),
    url(r'^publish_list/', views.publish_list),
	
]
```

#### 1.2.views.py  写视图函数

```python
def add_publish(request):
    if request.method == 'POST':

        name = request.POST.get('name')
        addr = request.POST.get('addr')
        email = request.POST.get('email')
        print(name,addr,email)
        publish=models.Publish.objects.create(name = name,addr = addr ,email=email)
        if publish:
            return redirect('/publish_list/')
    return render(request,'add_publish.html')

def publish_list(request):

    return HttpResponse('ok')

```

#### 1.3.模板层template

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>新增出版社</title>
    <link rel="stylesheet" href='/static/bootstrap-3.3.7-dist/css/bootstrap.min.css'>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <h2>添加出版社</h2>
            <form action="/add_publish/" method="post">

                <p>出版社名称: <input type="text" name="name" class="form-control"></p>
                <p>出版社地址: <input type="text" name="addr" class="form-control"></p>
                <p>出版社邮箱: <input type="text" name="email" class="form-control"></p>
                <p><input type="submit" value="添加" class="form-control btn btn-success"></p>
            </form>

        </div>
    </div>
</div>
</body>
</html>
```

### 2.publish_list展示部分

#### 2.1.views.py  写视图函数

```python
def publish_list(request):
    publish_list=models.Publish.objects.all()
    return render(request,'publist_list.html',{'publish_list':publish_list})
```

#### 2.2.模板层template

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>出版社列表</title>
    <link rel="stylesheet" href='/static/bootstrap-3.3.7-dist/css/bootstrap.min.css'>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <h2>出版社列表</h2>
        {#      紧缩表格      #}
            <table class="table table-condensed">
                
                <thead>
                <tr>
                    <th>ID</th>
                    <th>出版社名称</th>
                    <th>出版社地址</th>
                    <th>邮箱</th>
                </tr>
                </thead>
                <tbody>
                    {% for publish in publish_list %}
                        <tr>
                            <td>{{ publish.nid }}</td>
                            <td>{{ publish.name }}</td>
                            <td>{{ publish.addr }}</td>
                            <td>{{ publish.email }}</td>
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

### 3.publish_list删除部分

#### 3.1.注意些urls.py路由

```python
from app01 import views
urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^add_publish/', views.add_publish),
    url(r'^publish_list/', views.publish_list),
    url(r'^delete_publish/', views.delete_publish),

]
```

#### 3.2.views.py  写视图函数

```python
def delete_publish(request):
    nid = request.GET.get('nid')
    print(nid)
    # 相当于mysql里面的where条件
    models.Publish.objects.filter(nid=nid).delete()
    # 删除完以后从定向到publish_list这个页面
    return redirect('/publish_list/')
```

#### 3.3.模板层template     publist的id会乱

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>出版社列表</title>
    <link rel="stylesheet" href='/static/bootstrap-3.3.7-dist/css/bootstrap.min.css'>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <h2>出版社列表</h2>
{#      紧缩表格      #}
            <table class="table table-condensed">

                <thead>
                <tr>
                    <th>ID</th>
                    <th>出版社名称</th>
                    <th>出版社地址</th>
                    <th>邮箱</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                    {% for publish in publish_list %}
                        <tr>
{#                            <td>{{ publish.nid }}</td>#}
                            {#       forloop.counte                    for循环的个数#}
                            <td>{{ forloop.counter }}</td>
                            <td>{{ publish.name }}</td>
                            <td>{{ publish.addr }}</td>
                            <td>{{ publish.email }}</td>
                            <td>
                                <a href="/delete_publish/?nid={{ publish.nid }}" class="btn bg-danger">删除</a>
                                <a href="" class="btn bg-success">编辑</a>
                                <a href=""></a>
                            </td>
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

### 4.publish_list编辑部分

#### 4.1.注意些urls.py路由

```python
from app01 import views
urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^add_publish/', views.add_publish),
    url(r'^publish_list/', views.publish_list),
    url(r'^delete_publish/', views.delete_publish),
    url(r'^edit_publish/', views.edit_publish),

]
```

#### 4.2.views.py  写视图函数

```python
def edit_publish(request):
    if request.method == 'POST':
        nid = request.POST.get('nid')
        name = request.POST.get('name')
        addr = request.POST.get('addr')
        email = request.POST.get('email')
        models.Publish.objects.filter(pk = nid).update(name= name,addr=addr,email=email)
        return redirect('/publish_list/')
    nid = request.GET.get('nid')
    publish = models.Publish.objects.filter(nid=nid).first()
    # print(publish)
    return render(request,'edit_publish.html',{'publish':publish})
```

#### 4.3.模板层template

```python
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>修改出版社</title>
    <link rel="stylesheet" href='/static/bootstrap-3.3.7-dist/css/bootstrap.min.css'>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <h2>修改出版社</h2>
            <form action="/edit_publish/" method="post">
                <input type="hidden" name="nid" class="form-control" value="{{ publish.nid }}">
                <p>出版社名称: <input type="text" name="name" class="form-control" value="{{ publish.name }}"></p>
                <p>出版社地址: <input type="text" name="addr" class="form-control" value="{{ publish.addr }}"> </p>
                <p>出版社邮箱: <input type="text" name="email" class="form-control" value="{{ publish.email }}"></p>
                <p><input type="submit" value='修改' class="form-control btn btn-success"></p>
            </form>

        </div>
    </div>
</div>
</body>
</html>
```

## 6.图书视图函数，模板层，路由

### 1.add_book添加部分

#### 1.1.注意些urls.py路由

```python
from app01 import views
urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^add_publish/', views.add_publish),
    url(r'^publish_list/', views.publish_list),
    url(r'^delete_publish/', views.delete_publish),
    url(r'^edit_publish/', views.edit_publish),
    url(r'^add_author/', views.add_author),
    url(r'^author_list/', views.author_list),
    url(r'^delete_author/', views.delete_author),
    url(r'^edit_author/', views.edit_author),
    url(r'^add_book/', views.add_book),
    url(r'^book_list/', views.book_list),

]
```

#### 1.2.views.py  写视图函数

```python
def add_book(request):
    if request.method == 'POST':
        name = request.POST.get('name')
        price = request.POST.get('price')
        pub_date = request.POST.get('pub_date')
        publish_id = request.POST.get('publish')
        # 这里提交的是多个值
        authors = request.POST.getlist('authors')
        book=models.Book.objects.create(name= name ,price = price,pub_date = pub_date,publish_id=publish_id)

        # 关键点 book对象添加属性 book 对应一个id  authors把这个列表打散
        book.authors.add(*authors)
        return HttpResponse('ok')
    publish_list=models.Publish.objects.all()
    author_list=models.Author.objects.all()
    return render(request,'add_book.html',{'publish_list':publish_list,'author_list':author_list})
```

#### 1.3.模板层template

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>新增图书</title>
    <link rel="stylesheet" href='/static/bootstrap-3.3.7-dist/css/bootstrap.min.css'>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <h2>添加图书</h2>
            <form action="/add_book/" method="post">
                <input type="hidden" name="id" class="form-control" value="{{ publish.id }}">
                <p>图书名称: <input type="text" name="name" class="form-control"></p>
                <p>图书价格: <input type="text" name="price" class="form-control"></p>
                <p>出版日期: <input type="date" name="pub_date" class="form-control"></p>
                <p>出版社:
                    <select name="publish" id="" class="form-control">
                        {% for publish in publish_list %}
                        <option value="{{ publish.nid }}">{{ publish.name }}</option>
                        {% endfor %}


                    </select>
                </p>
                <p>作者:
                    <select name="authors" id="" multiple class="form-control">
                        {% for author in author_list %}
                            <option value="{{ author.nid }}">{{ author.name }}</option>
                        {% endfor %}

                    </select>

                </p>
                <p><input type="submit" value="提交" class="form-control btn btn-success"></p>
            </form>

        </div>
    </div>
</div>
</body>
</html>
```

### 2.book_list图书列表展示

#### 2.1.注意些urls.py路由

```python
from app01 import views
urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^add_publish/', views.add_publish),
    url(r'^publish_list/', views.publish_list),
    url(r'^delete_publish/', views.delete_publish),
    url(r'^edit_publish/', views.edit_publish),
    url(r'^add_author/', views.add_author),
    url(r'^author_list/', views.author_list),
    url(r'^delete_author/', views.delete_author),
    url(r'^edit_author/', views.edit_author),
    url(r'^add_book/', views.add_book),
    url(r'^book_list/', views.book_list),

]
```

#### 2.2.views.py  写视图函数

```python
def book_list(request):
    book_list=models.Book.objects.all()
    return render(request,'book_list.html',{'book_list':book_list})
```

#### 2.3.模板层template

```python
def book_list(request):
    book_list=models.Book.objects.all()
    return render(request,'book_list.html',{'book_list':book_list})
```

### 3.delete_book删除部分

#### 3.1.注意些urls.py路由

```python
from app01 import views
urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^add_publish/', views.add_publish),
    url(r'^publish_list/', views.publish_list),
    url(r'^delete_publish/', views.delete_publish),
    url(r'^edit_publish/', views.edit_publish),
    url(r'^add_author/', views.add_author),
    url(r'^author_list/', views.author_list),
    url(r'^delete_author/', views.delete_author),
    url(r'^edit_author/', views.edit_author),
    url(r'^add_book/', views.add_book),
    url(r'^book_list/', views.book_list),
    url(r'^delete_book/', views.delete_book),

]
```

#### 3.2.views.py  写视图函数

```python
def delete_book(request):
    nid = request.GET.get('id')
    print(nid)
    models.Book.objects.filter(pk=nid).delete()
    return redirect('/book_list/')
```

### 4.edit_book编辑部分

#### 4.1.注意些urls.py路由

```python
from app01 import views
urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^add_publish/', views.add_publish),
    url(r'^publish_list/', views.publish_list),
    url(r'^delete_publish/', views.delete_publish),
    url(r'^edit_publish/', views.edit_publish),
    url(r'^add_author/', views.add_author),
    url(r'^author_list/', views.author_list),
    url(r'^delete_author/', views.delete_author),
    url(r'^edit_author/', views.edit_author),
    url(r'^add_book/', views.add_book),
    url(r'^book_list/', views.book_list),
    url(r'^delete_book/', views.delete_book),
    url(r'^edit_book/', views.edit_book),
]
```

#### 4.2.views.py  写视图函数

```python
def edit_book(request):
    if request.method == 'POST':
        nid = request.POST.get('nid')
        name = request.POST.get('name')
        price = request.POST.get('price')
        pub_date = request.POST.get('pub_date')
        publish_id = request.POST.get('publish')
        authors = request.POST.getlist('authors')
        # 这里提交的是多个值
        print(nid)
        print(authors)
        models.Book.objects.filter(pk=nid).update(name=name,price=price,pub_date=pub_date,publish_id=publish_id)
        book=models.Book.objects.filter(pk=nid).first()
        # 先把原来的删除,再往里面add
        book.authors.set(authors)
        # 相当于
        # book.authors.clear()
        # book.authors.add(*authors)
        return redirect('/book_list/')
    nid = request.GET.get('id')
    book=models.Book.objects.filter(pk=nid).first()
    publish_list=models.Publish.objects.all()
    author_list=models.Author.objects.all()
    return render(request,'edit_book.html',{'book':book,'publish_list':publish_list,'author_list':author_list})
```

#### 4.3.模板层template

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>新增图书</title>
    <link rel="stylesheet" href='/static/bootstrap-3.3.7-dist/css/bootstrap.min.css'>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <h2>添加图书</h2>
            <form action="/edit_book/" method="post">
                <input type="hidden" name="nid" class="form-control" value="{{ book.id }}">
                <p>图书名称: <input type="text" name="name" class="form-control" value="{{ book.name }}"></p>
                <p>图书价格: <input type="text" name="price" class="form-control" value="{{ book.price }}"></p>
                <p>出版日期: <input type="date" name="pub_date" class="form-control" value="{{ book.pub_date|date:"Y-m-d" }}"></p>
                <p>出版社:
                    <select name="publish" id="" class="form-control">
                        {% for publish in publish_list %}
                            {% if book.publish == publish %}
                                <option selected value="{{ publish.nid }}">{{ publish.name }}</option>
                            {% else %}
                                <option value="{{ publish.nid }}">{{ publish.name }}</option>
                            {% endif %}

                        {% endfor %}


                    </select>
                </p>
                <p>作者:
                    <select name="authors" id="" multiple class="form-control">
                        {% for author in author_list %}
                            {% if author in book.author.all %}
                                <option selected value="{{ author.nid }}">{{ author.name }}</option>
                            {% else %}
                                <option value="{{ author.nid }}">{{ author.name }}</option>
                            {% endif %}

                        {% endfor %}

                    </select>

                </p>
                <p><input type="submit" value="提交" class="form-control btn btn-success"></p>
            </form>

        </div>
    </div>
</div>
</body>
</html>
```

