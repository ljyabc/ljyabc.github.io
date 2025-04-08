---
title: '''django笔记2'''
tags: []
date: 2019-03-10 23:56:47
categories:
photos:
---

### day17--BBS项目：

#### 1.模型层

```python
from django.db import models

# Create your models here.

from django.contrib.auth.models import AbstractUser

"""
1.userinfo：用户信息表，
    字段：
        id
        username
        password
        phone
        avatar
        blog -- 和Blog这张表一对一关联
2.Blog：用户博客
    字段：
        id
        title
        theme
        pathname ---路径名
3.Category：文章分类
    字段：
        id
        title
        blog  ---一对多关系
4.Tag：文章关键字
    字段：
        id
        title
        blog ---一对多关系   

5.Article：文章
    字段：
        id
        title
        abstract --摘要
        content --内容
        create_time  --创建日期
        category  --- 文章和分类是一对多关系
        tag  ----文章和文章关键字是多对多关系
        blog  ---文章和用户博客是一对多的关系

6.Commit：评论
    字段：
        id
        username  ---哪个用户  评论和作者是一对多的关系：一个作者可以对应多条评论
        article   ---对什么文章  评论和文章是一对多的关系：一个文章可以对应多条评论
        content   ---评论的内容
        commit_time ---评论提交的时间
        parent_id  ----评论的父评论（有对应评论的id，没有对应null）

7.UpAndDown:点赞和点踩
    字段：
        id
        username  一对多的关系，一个作者可以点多个赞
        article   一对多关系，一篇文章可以有多个赞
        is_up  ----点赞是1，没有点赞为0

"""


class UserInfo(AbstractUser):
    id = models.AutoField(primary_key=True)
    phone = models.CharField(max_length=11, null=True)
    avatar = models.FileField(upload_to='avatar/', default='/img/default.png')
    blog = models.OneToOneField(to='Blog', to_field='id', null=True)


class Blog(models.Model):
    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=88)
    theme = models.CharField(max_length=32, null=True)
    site = models.CharField(max_length=33, null=True)


class Category(models.Model):
    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=88)
    blog = models.ForeignKey(to='Blog', to_field='id', null=True)


class Tag(models.Model):
    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=88)
    blog = models.ForeignKey(to='Blog', to_field='id', null=True)


class Article(models.Model):
    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=200)
    desc = models.CharField(max_length=255)
    content = models.TextField()
    create_time = models.DateTimeField(auto_now_add=True)
    Comment_num = models.IntegerField(null=True)
    up_num = models.IntegerField(null=True)
    down_num = models.IntegerField(null=True)
    category = models.ForeignKey(to='Category', to_field='id', null=True)
    blog = models.ForeignKey(to='Blog', to_field='id', null=True)
    tag = models.ManyToManyField(to='Tag', through='ArticleToTag', through_fields=('article', 'tag',))


class ArticleToTag(models.Model):
    id = models.AutoField(primary_key=Tag)
    article = models.ForeignKey(to='Article', to_field='id')
    tag = models.ForeignKey(to='Tag', to_field='id')

    class Meta:
        unique_together = ('article', 'tag')


class Comment(models.Model):
    id = models.AutoField(primary_key=True)
    user = models.ForeignKey(to='UserInfo', to_field='id', null=True)
    article = models.ForeignKey(to='Article', to_field='id', null=True)
    content = models.CharField(max_length=255, null=True)
    comment_time = models.DateTimeField(auto_now_add=True)
    parent = models.ForeignKey(to="Comment", to_field='id', null=True)


class UpAndDown(models.Model):
    id = models.AutoField(primary_key=True)
    username = models.ForeignKey(to='UserInfo', to_field='id', null=True)
    article = models.ForeignKey(to='Article', to_field='id', null=True)
    is_up = models.BooleanField()

```

#### 2.前端页面字符串的替换

```javascript
ss=`
<li class="list-group-item">
    <p>
        <span>${ user_name }</span>
        <span>${ time }</span>
    </p>
    <p class="well">@${parent_name }</p>
    ${content}
</li>
`

注意：
${} ----里面写需要替换的内容
```

#### 3.拿到html标签里面的值

```javascript
1.通过页面选择器获取里面的值
--获取子评论的值
var obj = $(this).children('span').text()
--获取兄弟评论的值
var obj = $(this).sibing('span').text()


2.通过给标签设置属性，属性里面放入需要获取的值
//拿到span标签中username属性对应的值
<span class="pull-right replay" username="{{ content.user.username }}"
                                  content_id="{{ content.pk }}">回复</span>
var username = $(this).attr('username') ---拿到的就是username属性的值

3.判断当前的标签是否有什么类名
//判断当前点击的div控件,有没有diggit类
var is_up = $(this).hasClass('diggit')
```

#### 4.前端字符串转成int类型的方式

```javascript
var count= $("#digg_count").text()

parseInt(count)/Number(count)
```

#### 5.前端页面聚焦光标

```javascript
//让光标聚焦到这个控件
$('#content').focus() --- focus
```

#### 6.前端输入框内容的截断

```javascript
//取到 \n 索引位置的后一位
var index = content.indexOf('\n') + 1
alert(index)

//slice传一个起始位置,一个结束位置,就可以切出来
content = content.slice(index)
```

#### 7.将时间对象转成字符串

```python
1.通过json传输的时候，json不会给我们转时间对象的，而且还会报错，这就需要我们自己来转
# 把datetime类型转成字符串,因为json是无法序列化datetime
response['time'] = ret.create_time.strftime('%Y-%m-%d %X')
```

#### 8.随机产生验证码

```python
img = Image.new('RGB', (320, 35), color=get_random_color())
# 拿到画笔,把图片传入画笔
img_draw = ImageDraw.Draw(img)
# 生成一个字体对象,第一个参数是字体文件的路径,第二个参数是字体大小
font = ImageFont.truetype('static/font/ss.TTF', size=25)

# 第一个参数,xy的坐标,第二个参数:要写的文字,第三个参数:写文字的颜色,第四个参数:字体
# 不同的字体是不同的ttf文件
random_code = ''
# 弄一个循环,循环5次,每次随机写一个(数字,大写,小写字母)
for i in range(5):
char_num = random.randint(0, 9)
# 生成一个97到122的数字,然后用chr转成字符
char_lower = chr(random.randint(97, 122))
char_upper = chr(random.randint(65, 90))
char_str = str(random.choice([char_num, char_lower, char_upper]))
img_draw.text((i * 30 + 20, 0), char_str, get_random_color(), font=font)

random_code += char_str
# 把验证码保存到session中
print(random_code)
request.session['valid_code'] = random_code
'''
1 生成一个随机字符串:ddddsfassda
2 在session表中插入一条数据
3 在cook中写入 :sessionid=ddddsfassda
'''
# width = 320
# height = 35
# for i in range(10):
#     x1 = random.randint(0, width)
#     x2 = random.randint(0, width)
#     y1 = random.randint(0, height)
#     y2 = random.randint(0, height)
#     # 在图片上画线
#     img_draw.line((x1, y1, x2, y2), fill=get_random_color())
#
# for i in range(100):
#     # 画点
#     img_draw.point([random.randint(0, width), random.randint(0, height)], fill=get_random_color())
#     x = random.randint(0, width)
#     y = random.randint(0, height)
#     # 画弧形
#     img_draw.arc((x, y, x + 4, y + 4), 0, 90, fill=get_random_color())

f = BytesIO()
# 把图片保存到f中
# 放到内存中,存取比较快,而且有自动清理
img.save(f, 'png')

data = f.getvalue()
```

```python
1.定义一个公共方法
from PIL import Image, ImageDraw, ImageFont
import random
from io import BytesIO

class ValidCode:
    # code = make_code(5)
    def __init__(self, code_num):
        self.code_num = code_num
        self.code = None

    @staticmethod
    def _get_random_color():
        return (
            random.randint(0, 255), random.randint(0, 255), random.randint(0, 255)
        )

    @staticmethod
    def _make_code(code_num):
        res = ""
        for i in range(code_num):
            s1 = chr(random.randint(65, 90))
            s2 = str(random.randint(0, 9))
            s3 = chr(random.randint(97, 122))
            res += random.choice([s1, s2, s3])
        return res

    @property
    def valid_code(self):
        img = Image.new('RGB', (200, 34), color=self._get_random_color())
        img_draw = ImageDraw.Draw(img)
        font = ImageFont.truetype('static/font/ss.TTF', size=20)
        code = self._make_code(self.code_num)
        self.code = code
        img_draw.text((0, 0), code, self._get_random_color(), font=font)

        f = BytesIO()
        img.save(f, 'png')
        data = f.getvalue()
        return data
        
2.在视图中使用这个方法
from static.common.common import  ValidCode

def get_code(request):
    if request.method == 'GET':
        v = ValidCode(code_num=5)
        data = v.valid_code
        request.session['valid_code'] = v.code
        return HttpResponse(data)
```

#### 9.多视图共用一个路由视图设计(好好理解)

```python
1.路由
 # 分组分出三个(用户名,category|tag|archive中的一个,可能是分类id,tag_id,时间)
url(r'^(?P<username>[\w]+)/(?P<condition>category|tag|archive)/(?P<param>.*)', views.user_blog),

2.视图
blog = user.blog
article_list = blog.article_set.all()
# 取出condition中的分类/标签/时间
condition = kwargs.get('condition')
# condition可能是category|tag|archive中的一个 还可能是空
# 取出param的值,可能为标签id,分类id,或者是时间
param = kwargs.get('param')
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
```

#### 10.过滤html文本及标签

```python
1.安装BeautifulSoup4

2.导入
from bs4 import BeautifulSoup

3.使用
@login_required
def add_article(request):
    if request.method == 'GET':
        return render(request, 'back_edit/add_article.html')
    if request.method == 'POST':
        url = reverse('back')
        print(request.POST)
        title = request.POST.get('title')
        # 将页面html代码以及内容全部放入content中
        content = request.POST.get('content')
        # 通过Bf类将content通过解析器解析，得到一个对象，该对象的.text是获取页面文本，.find_all是页面标签列表
        soup = BeautifulSoup(content, "html.parser")
        desc = soup.text[:150]
        print(desc)
        tags = soup.find_all()
        for tag in tags:
            # 每个页面标签对象的.name 属性可以获取标签名字，可以避免跨站脚本攻击
            if tag.name == 'script':
                # 将script标签去掉
                tag.decompose()
        ret = Article.objects.create(title=title, desc=desc, content=str(soup), blog=request.user.blog)
        return redirect(url)
```

#### 11.富文本编辑器使用(http://kindeditor.net/doc.php)

```html
1.hmtl部分
<script charset="utf-8" src="/static/kindeditor/kindeditor-all.js"></script>
    <script>
        KindEditor.ready(function (K) {
            window.editor = K.create('#editor_id', {
                width: '100%',
                height: '450px',
                uploadJson: '{% url "save_img" %}',
                extraFileUploadParams:{
                    'csrfmiddlewaretoken':'{{ csrf_token }}'
                },
                //修改默认上传文件的名字
                filePostName:'myfile'
            });
        });
    </script>
```

```python
2.视图部分
soup = BeautifulSoup(content, "html.parser")
desc = soup.text[:150]
print(desc)
tags = soup.find_all()
for tag in tags:
    # 每个页面标签对象的.name 属性可以获取标签名字，可以避免跨站脚本攻击
    if tag.name == 'script':
        # 将script标签去掉
        tag.decompose()
ret = Article.objects.create(title=title, desc=desc, content=str(soup), blog=request.user.blog)
```

```python
3.上传图片
files = request.FILES.get('myfile')
try:
    path = os.path.join(BASE_DIR, 'media', 'img')
    if not os.path.exists(path):
    	os.mkdir(path)
    file_name = files.name
    new_path = os.path.join(path, file_name)
    with open(new_path, 'wb') as f:
        for line in files:
            f.write(line)	
    res = {'error': 0, 'url': 'media/img/%s' % file_name}
except Exception as e:
	res = {'error': 1, 'url': ''}
return JsonResponse(res)
```

#### 12.head

```python
headers: {
                'X-CSRFToken': "{{ csrf_token }}"
            },
url(r'^media/(?P<path>.*)', serve, {'document_root': settings.MEDIA_ROOT}),
from django.conf.urls import url
from django.contrib import admin
from blog.views import *
from django.conf.urls.static import static
from django.conf.urls.static import settings
from django.views.static import serve
```

### day18---Rest Framework

#### 一.RESTful规范（共十条）

##### 1.什么是restful规范

```
1.rest与技术无关，代表的是一种软件架构风格，rest是representational state transfer,中文翻译为‘表征状态转移’

2.rest从资源的角度审视整个网络，它将分布在网络中某个节点的资源通过url进行标识，客户端应用通过url来获取资源的表征，获得这些表征致使这些应用转变状态。

3.rest与技术无关，代表的是一种软件架构风格。

4.所有的数据，不过是通过网络获取的还是操作（增删改查）的数据，都是资源，将一切数据视为资源的是rest区别与其他架构风格的最本质的属性。

5.对于rest这种面向资源的架构风格，有人提出一种全新的结构理念，即：面向资源架构
```

```
总结：
1.rest是一种规范
2.面向资源编程：把网络上所有的东西，想象成资源。
```

##### 2.restful api设计（规范）

```markdown
1.api与用户的通信协议，总是使用HTTPs协议。
https比http安全，会SSL加密,但是得购买SSL证书。
```

***

```markdown
2.域名
尽量将自己的api部署在专用域名
方式一：https://api.example.com
方式二：https://example.org/api

eg：
例如写一个查询所有图书的api接口，即是api后面接口相关的url
方式一：https://api.example.com/books
方式二：https://127.0.0.1/api/books
```

***

```
3.版本
url：https://api.example.com/v1/
url:https://127.0.0.1/api/v1/books --推荐使用
```

***

```
4.路径：视网络上的任何东西为资源，均使用名词表示（可复数）
https://api.example.com/v1/books
https://api.example.com/v1/animals
https://api.example.com/v1/employees
不能这么写:
    -获取所有图书:https://127.0.0.1/api/get_all_books
    -新增一本书:https://127.0.0.1/api/add_book
统一都用这个:
	https://api.example.com/v1/books
```

***

```
5.method
GET      ：从服务器取出资源（一项或多项）
POST    ：在服务器新建一个资源
PUT      ：在服务器更新资源（客户端提供改变后的完整资源）
PATCH  ：在服务器更新资源（客户端提供改变的属性）
DELETE ：从服务器删除资源

注意：
put，patch，delete这些请求方式，django内部不会给我们做处理，数据只会存放在body体中，需要手动处理

幂等性：
多次请求的结果，返回的都是相同的结果。put请求第幂等的。
```

***

```
6.过滤：通国url传参的方式，传递搜索条件
https://api.example.com/v1/zoos?limit=10：指定返回记录的数量
https://api.example.com/v1/zoos?offset=10：指定返回记录的开始位置
https://api.example.com/v1/zoos?page=2&per_page=100：指定第几页，以及每页的记录数
https://api.example.com/v1/zoos?sortby=name&order=asc：指定返回结果按照哪个属性排序，以及排序顺序
https://api.example.com/v1/zoos?animal_type_id=1：指定筛选条件
```

***

```
7.状态码
200 OK - [GET]：服务器成功返回用户请求的数据，该操作是幂等的（Idempotent）。
201 CREATED - [POST/PUT/PATCH]：用户新建或修改数据成功。
202 Accepted - [*]：表示一个请求已经进入后台排队（异步任务）
204 NO CONTENT - [DELETE]：用户删除数据成功。
400 INVALID REQUEST - [POST/PUT/PATCH]：用户发出的请求有错误，服务器没有进行新建或修改数据的操作，该操作是幂等的。
401 Unauthorized - [*]：表示用户没有权限（令牌、用户名、密码错误）。
403 Forbidden - [*] 表示用户得到授权（与401错误相对），但是访问是被禁止的。
404 NOT FOUND - [*]：用户发出的请求针对的是不存在的记录，服务器没有进行操作，该操作是幂等的。
406 Not Acceptable - [GET]：用户请求的格式不可得（比如用户请求JSON格式，但是只有XML格式）。
410 Gone -[GET]：用户请求的资源被永久删除，且不会再得到的。
422 Unprocesable entity - [POST/PUT/PATCH] 当创建一个对象时，发生一个验证错误。
500 INTERNAL SERVER ERROR - [*]：服务器发生错误，用户将无法判断发出的请求是否成功。

自定义状态码：
status: 100表示成功
    101表示用户名密码错误
    102我也不知道什么错误
```

***

```
8.错误处理
错误处理，应返回错误信息，error当做key。
{status:101,error:'错误信息写上'}
```

***

```
9.返回结果，针对不同操作，服务器向用户返回的结果应该符合以下规范。
GET /books：返回资源对象的列表（数组）
GET /books/1：返回单个资源对象
POST /books：返回新生成的资源对象    -新增,传数据,一旦新增完成,把新的资源对象返回
PUT /books/1：返回完整的资源对象
PATCH /books/1：返回完整的资源对象
DELETE /books/1：返回一个空文档
```

***

```
10.Hypermedia API，RESTful API最好做到Hypermedia，即返回结果中提供链接，连向其他API方法，使得用户不查文档，也知道下一步应该做什么。
{
    status:100
    msg:成功
    url:127.0.0.1/books/1
}

核心:返回结果中提供链接
```

***

```python
实例：
复制代码

import json

def  user2(request):
    if request.method=='GET':
        dic = {'status':200,'name': 'lqz2', 'age': 18}
        return HttpResponse(json.dumps(dic))
    elif request.method=='POST':
        dic = {'status': 200, 'msg': '修改成功'}
        return JsonResponse(dic)

class Users(View):
    def get(self, request):
        dic = {'status':200,'name': 'lqz', 'age': 18}
        return HttpResponse(json.dumps(dic))

    def post(self, request):
        dic = {'status': 200, 'msg': '修改成功'}
        return JsonResponse(dic)
```

***

> ***	针对book这张表的符合resf规范的视图和路由
>
> ```python
> 视图：
> from app01.models import Book
> from rest_framework.views import APIView
> from rest_framework.request import Request
> from django.http import JsonResponse
> from app01.MySer import BookSerializer
> from rest_framework.utils.serializer_helpers import ReturnDict
> 
> class BookView(APIView):
>     """
>     GET /Book：返回资源对象的列表（数组）
>     GET /Book/1：返回单个资源对象
>     POST /Book：返回新生成的资源对象    -新增,传数据,一旦新增完成,把新的资源对象返回
>     PUT /Book/1：返回完整的资源对象
>     PATCH /Book/1：返回完整的资源对象
>     DELETE /Book/1：返回一个空文档
> 
>     """
> 
>     def get(self, request, **kwargs):
>         response = {'status': 100, 'msg': None}
>         if kwargs:
>             '''有值查一条'''
>             book = Book.objects.filter(pk=kwargs['id']).first()
>             ser = BookSerializer(book, many=False)
>             data = ser.data
>             print(data, type(data))
>             # <class 'rest_framework.utils.serializer_helpers.ReturnDict'>-----data类型
>             # response['msg'] = {'name': book.name, 'price': book.price}
>             response['msg'] = data
>             return JsonResponse(response, safe=False)
>         else:
>             '''无值查全部'''
>             books = Book.objects.all()
>             lis = [{'name': book.name, 'price': book.price} for book in books]
>             response['msg'] = lis
>         return JsonResponse(response, safe=False)
> 
>     def post(self, request, **kwargs):
>         response = {'status': 100, 'msg': None}
>         print(request.method)
>         print(request.POST)
>         print(request.GET)
>         print(request.FILES)
>         print(request.META)
>         print(request.data)
>         nn = request.data
>         """
>         POST
>         <QueryDict: {'name': ['小李飞刀'], 'price': ['88']}>
>         <QueryDict: {}>
>         <MultiValueDict: {}>
>         <QueryDict: {'name': ['小李飞刀'], 'price': ['88']}>
>         """
>         name = request.data.get('name')
>         price = request.data.get('price')
>         book = Book.objects.create(name=name, price=price)
>         response['msg'] = {'name': book.name, 'price': book.price}
>         return JsonResponse(response, safe=False)
> 
>     def put(self, request, **kwargs):
>         response = {'status': 100, 'msg': None}
>         name = request.data.get('name')
>         price = request.data.get('price')
>         book = Book.objects.filter(pk=kwargs['id']).update(name=name, price=price)
>         print(book)
>         response['msg'] = '更新成功'
>         response['url'] = '127.0.0.1/Book/%s' % kwargs['id']
>         return JsonResponse(response, safe=False)
> 
>     def patch(self, request, **kwargs):
>         response = {'status': 100, 'msg': None}
>         name = request.data.get('name')
>         price = request.data.get('price')
>         book = Book.objects.filter(pk=kwargs['id']).update(name=name, price=price)
>         print(book)
>         response['msg'] = '更新成功'
>         response['url'] = '127.0.0.1/Book/%s' % kwargs['id']
>         return JsonResponse(response, safe=False)
> 
>     def delete(self, request, **kwargs):
>         response = {'status': 100, 'msg': None}
>         ret = Book.objects.filter(pk=kwargs['id']).delete()
>         print(ret)  # (1, {'app01.Book': 1})
>         response['msg'] = '删除成功'
>         return JsonResponse(response)
> 
> ```
>
> 

#### 二.restframework之APIView

##### 1.安装djangorestframework

```markdown
方式一：pip3 install djangorestframework

方式二：pycharm图形化界面安装

方式三：pycharm命令行下安装（装在当前工程所用的解释器下）

**注意：
djangorestframework是一个app,所以需要注册
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'app01.apps.App01Config',
    'rest_framework', ----注册
]
```

##### 2.djangorestframework的APIView分析

```
1.djangorestframework只是快速的构建resful规范的接口。
```

***

```python
使用：
1.先导入
from rest_framework.views import APIView
from app01.models import Books
from django.http import JsonResponse

2.写一个类继承APIView
class BookView(APIView):
    """
    GET /books：返回资源对象的列表（数组）
    GET /books/1：返回单个资源对象
    POST /books：返回新生成的资源对象    -新增,传数据,一旦新增完成,把新的资源对象返回
    PUT /books/1：返回完整的资源对象
    PATCH /books/1：返回完整的资源对象
    DELETE /books/1：返回一个空文档

    """

    def get(self, request, **kwargs):
        response = {'status': 100, 'msg': None}
        if kwargs:
            '''有值查一条'''
            book = Books.objects.filter(pk=kwargs['id']).first()
            response['msg'] = {'name': book.name, 'price': book.price}
        else:
            '''无值查全部'''
            books = Books.objects.all()
            lis = [{'name': book.name, 'price': book.price} for book in books]
            response['msg'] = lis
        return JsonResponse(response, safe=False)

    def post(self, request, **kwargs):
        response = {'status': 100, 'msg': None}
        print(request.method)
        print(request.POST)
        print(request.GET)
        print(request.FILES)
        print(request.META)
        print(request.data)
        """
        POST
        <QueryDict: {'name': ['小李飞刀'], 'price': ['88']}>
        <QueryDict: {}>
        <MultiValueDict: {}>
        <QueryDict: {'name': ['小李飞刀'], 'price': ['88']}>
        """
        name = request.data.get('name')
        price = request.data.get('price')
        book = Books.objects.create(name=name, price=price)
        response['msg'] = {'name': book.name, 'price': book.price}
        return JsonResponse(response, safe=False)

    def put(self, request, **kwargs):
        response = {'status': 100, 'msg': None}
        name = request.data.get('name')
        price = request.data.get('price')
        book = Books.objects.filter(pk=kwargs['id']).update(name=name, price=price)
        print(book)
        response['msg'] = '更新成功'
        response['url'] = '127.0.0.1/books/%s' % kwargs['id']
        return JsonResponse(response, safe=False)

    def patch(self, request, **kwargs):
        response = {'status': 100, 'msg': None}
        name = request.data.get('name')
        price = request.data.get('price')
        book = Books.objects.filter(pk=kwargs['id']).update(name=name, price=price)
        print(book)
        response['msg'] = '更新成功'
        response['url'] = '127.0.0.1/books/%s' % kwargs['id']
        return JsonResponse(response, safe=False)

    def delete(self, request, **kwargs):
        response = {'status': 100, 'msg': None}
        ret = Books.objects.filter(pk=kwargs['id']).delete()
        print(ret)  # (1, {'app01.Books': 1})
        response['msg'] = '删除成功'
        return JsonResponse(response)


```

****

```python
1.执行流程分析
路由：
url(r'^books/(?P<id>\d+)', BookView.as_view()), ---调用from rest_framework.views import APIView里的as_view方法：

@classmethod
def as_view(cls, **initkwargs):
    """
    Store the original class on the view function.

    This allows us to discover information about the view when we do URL
    reverse lookups.  Used for breadcrumb generation.
    """
    if isinstance(getattr(cls, 'queryset', None), models.query.QuerySet):
        def force_evaluation():
            raise RuntimeError(
                'Do not evaluate the `.queryset` attribute directly, '
                'as the result will be cached and reused between requests. '
                'Use `.all()` or call `.get_queryset()` instead.'
            )
            cls.queryset._fetch_all = force_evaluation
	# 执行父类的as_view方法
    view = super(APIView, cls).as_view(**initkwargs) ----执行View里面as_view
    
    view.cls = cls
    view.initkwargs = initkwargs

    # Note: session based authentication is explicitly CSRF validated,
    # all other authentication is CSRF exempt.
    return csrf_exempt(view)
```

```python

# from rest_framework.views import APIView执行的是这个类中的as_view

1.先执行APIView下的as_view，将产生的view函数传入到局部禁用方法中

@classmethod
def as_view(cls, **initkwargs):
    """
    Store the original class on the view function.

    This allows us to discover information about the view when we do URL
    reverse lookups.  Used for breadcrumb generation.
    """
    if isinstance(getattr(cls, 'queryset', None), models.query.QuerySet):
        def force_evaluation():
            raise RuntimeError(
                'Do not evaluate the `.queryset` attribute directly, '
                'as the result will be cached and reused between requests. '
                'Use `.all()` or call `.get_queryset()` instead.'
            )

        cls.queryset._fetch_all = force_evaluation
        
2.执行View类中的as_view方法---返回值是view函数的内存地址

    # 重用了父类（View）里面的as_view方法
    view = super(APIView, cls).as_view(**initkwargs)
    # <as_view>-----------------------------------------------------------------------------------1
    # View里面的as_view方法：
    @classonlymethod
    def as_view(cls, **initkwargs):
        """
        Main entry point for a request-response process.
        """
        for key in initkwargs:
            if key in cls.http_method_names:
                raise TypeError("You tried to pass in the %s method name as a "
                                "keyword argument to %s(). Don't do that."
                                % (key, cls.__name__))
            if not hasattr(cls, key):
                raise TypeError("%s() received an invalid keyword %r. as_view "
                                "only accepts arguments that are already "
                                "attributes of the class." % (cls.__name__, key))

        def view(request, *args, **kwargs):
            # request这个request还是之前的request
            self = cls(**initkwargs)
            # self是BookView这个CBV的对象
            if hasattr(self, 'get') and not hasattr(self, 'head'):
                self.head = self.get
            self.request = request
            self.args = args
            self.kwargs = kwargs
            
3.调用APIView类中dispatch方法返回的结果是加工后的self.response

            # 是self这个对象调用dispatch方法，自己类中没有，去父类中去找，所以此时的dispatch方法是APIView的。
            return self.dispatch(request, *args, **kwargs)

            # <dispatch>-----------------------------------------------------------------------------------2
            def dispatch(self, request, *args, **kwargs):
                """
                `.dispatch()` is pretty much the same as Django's regular dispatch,
                but with extra hooks for startup, finalize, and exception handling.
                """
                self.args = args
                self.kwargs = kwargs
                
4.调用Request类中__init__方法初始化对象---放回一个Request的对象（此时的是新的request）

                # 此时将request（最初的）传到APIView里面的initialize_request（初始化request）--返回一个Request的对象
                request = self.initialize_request(request, *args, **kwargs)
                # <initialize_request>-----------------------------------------------------------------------------------3
                def initialize_request(self, request, *args, **kwargs):
                    """
                    Returns the initial request object.
                    """
                    parser_context = self.get_parser_context(request)
                    # 将参数以及request传入到from rest_framework.request import Request类中初始化，实例产生对象
                    return Request(
                        request,
                        parsers=self.get_parsers(),
                        authenticators=self.get_authenticators(),
                        negotiator=self.get_content_negotiator(),
                        parser_context=parser_context
                    )
                    # <Request>-----------------------------------------------------------------------------------4
                    def __init__(self, request, parsers=None, authenticators=None,
                                 negotiator=None, parser_context=None):
                        assert isinstance(request, HttpRequest), (
                            'The `request` argument must be an instance of '
                            '`django.http.HttpRequest`, not `{}.{}`.'
                                .format(request.__class__.__module__, request.__class__.__name__)
                        )
                        # ---此时将最初的request设置成Request对象的一个属性
                        self._request = request
                        self.parsers = parsers or ()
                        self.authenticators = authenticators or ()
                        self.negotiator = negotiator or self._default_negotiator()
                        self.parser_context = parser_context
                        self._data = Empty
                        self._files = Empty
                        self._full_data = Empty
                        self._content_type = Empty
                        self._stream = Empty

                        if self.parser_context is None:
                            self.parser_context = {}
                        self.parser_context['request'] = self
                        self.parser_context['encoding'] = request.encoding or settings.DEFAULT_CHARSET

                        force_user = getattr(request, '_force_auth_user', None)
                        force_token = getattr(request, '_force_auth_token', None)
                        if force_user is not None or force_token is not None:
                            forced_auth = ForcedAuthentication(force_user, force_token)
                            self.authenticators = (forced_auth,)

                    @property
                    # 将request.data伪装成对象的属性，其实是对象的方法。data里面可以取body体内的数据
                    def data(self):
                        if not _hasattr(self, '_full_data'):
                            self._load_data_and_files()
                        return self._full_data
                    # 此方法当request.POST等原先的一些属性访问时，找不到时会触发，然后再去原先的request对象的属性中查找并返回
                    def __getattr__(self, attr):
                        """
                        If an attribute does not exist on this instance, then we also attempt
                        to proxy it to the underlying HttpRequest object.
                        """
                        try:
                            return getattr(self._request, attr)
                        except AttributeError:
                            return self.__getattribute__(attr)
                    # </Request>-----------------------------------------------------------------------------------4
                # <initialize_request>-----------------------------------------------------------------------------------3
                
5.Request的对象（此时的是新的request）赋给对象，作为其属性

                # 将新的request赋给CBV的对象。作为其属性
                self.request = request
                self.headers = self.default_response_headers  # deprecate?

                try:
                    self.initial(request, *args, **kwargs)

                    # Get the appropriate handler method
                    if request.method.lower() in self.http_method_names:
                        handler = getattr(self, request.method.lower(),
                                          self.http_method_not_allowed)
                    else:
                        handler = self.http_method_not_allowed
                        
6.执行CBV里面的视图函数，将最新的request传到视图中执行，将返回的结果赋给response

                    # 执行CBV里面的视图函数，将返回的结果给response接受
                    response = handler(request, *args, **kwargs)

                except Exception as exc:
                    response = self.handle_exception(exc)
                    
7.将返回值response设置成self对象的response属性，对其添加的一些属性

                # 将改变后的request和视图函数的执行的结果一并传入到finalize_response方法中（APIView）---执行的结果返回response对象，对其添加的一些属性
                # self.response = response --->此时的response多了一些属性了
                self.response = self.finalize_response(request, response, *args, **kwargs)
                # <finalize_response>-----------------------------------------------------------------------------------5
                def finalize_response(self, request, response, *args, **kwargs):
                    """
                    Returns the final response object.
                    """
                    # Make the error obvious if a proper response is not returned
                    assert isinstance(response, HttpResponseBase), (
                            'Expected a `Response`, `HttpResponse` or `HttpStreamingResponse` '
                            'to be returned from the view, but received a `%s`'
                            % type(response)
                    )

                    if isinstance(response, Response):
                        if not getattr(request, 'accepted_renderer', None):
                            neg = self.perform_content_negotiation(request, force=True)
                            request.accepted_renderer, request.accepted_media_type = neg

                        response.accepted_renderer = request.accepted_renderer
                        response.accepted_media_type = request.accepted_media_type
                        response.renderer_context = self.get_renderer_context()

                    # Add new vary headers to the response instead of overwriting.
                    vary_headers = self.headers.pop('Vary', None)
                    if vary_headers is not None:
                        patch_vary_headers(response, cc_delim_re.split(vary_headers))

                    for key, value in self.headers.items():
                        response[key] = value

                    return response
                # </finalize_response>-----------------------------------------------------------------------------------5
                
8.最后返回对象的response属性，def view 的返回值就是视图函数的执行结果，以及添加的一些属性，

                # 最后返回self.response
                return self.response

                # </dispatch>-----------------------------------------------------------------------------------2

        view.view_class = cls
        view.view_initkwargs = initkwargs

        # take name and docstring from class
        update_wrapper(view, cls, updated=())

        # and possible attributes set by decorators
        # like csrf_exempt from dispatch
        update_wrapper(view, cls.dispatch, assigned=())
        
9.最后将加工好的view函数的内存地址返回出去给view这个变量接受。
        # 在View中的as_view中执行后返回view这个函数的内存地址
        return view


# </as_view>-----------------------------------------------------------------------------------1
view.cls = cls
view.initkwargs = initkwargs

# Note: session based authentication is explicitly CSRF validated,
# all other authentication is CSRF exempt.

10.将加工好的view传入局部禁用csrf方法中，采用其他的验证方式，保证其安全
# 局部禁用csrf组件，采用其他的验证方式
return csrf_exempt(view)

```

```python
注意：
1.所有视图里面没有定义在函数体内的代码，在django程序启动过后，就开始执行
2.所有路由里面的视图函数，在django项目启动后都会将函数的内存地址放在路由后面
3.as_view是将其中的定义的view的视图函数（里面有dispatch方法）放在路由后面
4.当有请求过来后，执行view的方法，以及将参数传入。

```

***

```python
1.APIView中dispatch方法
request = self.initialize_request(request, *args, **kwargs) --改变原有的request
```

#### 三.django及DRF序列化工具

```python
from django.core import serializers
def get(self,request):

    response = {'status': 100, 'data': None}
    books = models.Book.objects.all()
    # 先构造出所有书籍的字典的列表
    # 用django提供的序列化组件
    ret=serializers.serialize('json',books)
    print(ret)

    # 返回数据是json格式数据
    response['data'] = ret

    return HttpResponse(ret)
```

***

```json
结果：
[
    {
        "model": "app01.book",
        "pk": 1,
        "fields": {
            "name": "红楼梦",
            "price": "15"
        }
    },
    {
        "model": "app01.book",
        "pk": 2,
        "fields": {
            "name": "水",
            "price": "15"
        }
    },
    {
        "model": "app01.book",
        "pk": 3,
        "fields": {
            "name": "水都是",
            "price": "15"
        }
    }
]
```

***

```
注意：
自带的序列化工具，不可控，不能指定需要的数据。
```

##### 1.restframework序列化工具---之序列化

```python
1.导入序列化工具
from rest_framework.serializers import Serializer,ModelSerializer

注意：
1.The field 'authors_name' was declared on serializer BookSerializer, but has not been included in the 'fields' option.
当抛出这个异常时，需要在fields = ['name', 'price', ]里面注册
```

> 1.推荐写法

```python
1.在app下写一个py文件，如myser
2.在py文件中，导入restframework里面的序列化工具，如上
3.定义一个类，继承Serializer/ModelSerializer
4.在视图中导入py文件中的类
5.实例化产生对象
	# 单个对象
	ser = BookSerializer(book, many=False)
    data = ser.data
    # 多个对象
    ser = BookSerializer(books, many=True)
    data = ser.data
    # 注意：
    ser.data是<class 'rest_framework.utils.serializer_helpers.ReturnDict'>
6.将字典通过JsonResponse返回，并指定safe=Fasle
```

> 2.实例-继承Serializer

```python
1.myser文件中
from rest_framework import serializers
from app01.models import Book


class AuthorSerializer(serializers.Serializer):
    author_name = serializers.CharField(source='name')
    phone = serializers.CharField(source='author_detail.telephone')
    
class BookSerializer(serializers.Serializer):
    # 用source可以为字段取别名，防止有人通过数据库的字段名和表名，做一些黑客行为
    # 一旦用了source属性名一定不能和字段名重复，不然会抛出断言错误AssertionError
    aaa = serializers.CharField(source='name')
    # 如果不用source指定字段名，属性必须和model里面的字段对应，不能乱写
    price = serializers.CharField()
    # 直接拿是"Publish object"，相当于print了这个对象,可以在模型中重写__str__
    # publish = serializers.CharField()
    # 查询出版社相关的信息，一对多关系
    publish_name = serializers.CharField(source='publish.name')  # "北京出版社",拿到的是出版社的名字
    publish_city = serializers.CharField(source='publish.city')  # "publish_city": "北京"
    publish_email = serializers.CharField(source='publish.email')  # "publish_email": "888@qq.com"

    # 查询作者相关的信息
    # 直接这样写会报错或者是none
    # authors = serializers.CharField(source='authors.name')
    # SerializerMethodField()可以指定一个方法名，方法就是钩子函数
    authors = serializers.SerializerMethodField()

    def get_authors(self, obj):
        # 方式一
        # obj就是book这个对象
        authors = obj.authors.all()
        '''
        
        lis = [{'name': author.name, 'phone': author.author_detail.telephone} for author in authors]
        '''
        # 方式二
        # 再写一个序列化的类，将查询出的对象传入序列化
        ret = AuthorSerializer(instance=authors, many=True)
        return ret.data
    
    
2.视图函数中
def get(self, request, **kwargs):
    response = {'status': 100, 'msg': None}
    if kwargs:
        '''有值查一条'''
        book = Book.objects.filter(pk=kwargs['id']).first()
        ser = BookSerializer(book, many=False)
        data = ser.data
        print(data, type(data))
        # <class 'rest_framework.utils.serializer_helpers.ReturnDict'>-----data类型
        # response['msg'] = {'name': book.name, 'price': book.price}
        response['msg'] = data
        return JsonResponse(response, safe=False)
    else:
        '''无值查全部'''
        books = Book.objects.all()
        ret = BookSerializer(instance=books, many=True)
        data = ret.data
        # lis = [{'name': book.name, 'price': book.price} for book in books]
        response['msg'] = data
        return JsonResponse(response, safe=False)
```

> 实例-继承ModelSerializer

```python
1..myser文件中

from rest_framework import serializers
from app01.models import Book


class AuthorSerializer(serializers.Serializer):
    author_name = serializers.CharField(source='name')
    phone = serializers.CharField(source='author_detail.telephone')
    
class BookSerializer(serializers.ModelSerializer):
    class Meta:
        # 指定模型
        model = Book
        # 指定获取的全部字段
        fields = '__all__'
        # 指定获取局部字段
        # fields = ['name', 'price']
        # 指定排除哪些字段
        # exclude = ['name', 'price']
        # 指定查询深度(即跨表的次数)
        depth = 1

    # 可以重写属性
    publish = serializers.SerializerMethodField()

    def get_publish(self, obj):
        return obj.publish.name

    authors = serializers.SerializerMethodField()

    def get_authors(self, obj):
        authors = obj.authors.all()
        ret = AuthorSerializer(instance=authors, many=True)
        return ret.data
    
    
2.在视图函数中
2.视图函数中
def get(self, request, **kwargs):
    response = {'status': 100, 'msg': None}
    if kwargs:
        '''有值查一条'''
        book = Book.objects.filter(pk=kwargs['id']).first()
        ser = BookSerializer(book, many=False)
        data = ser.data
        print(data, type(data))
        # <class 'rest_framework.utils.serializer_helpers.ReturnDict'>-----data类型
        # response['msg'] = {'name': book.name, 'price': book.price}
        response['msg'] = data
        return JsonResponse(response, safe=False)
    else:
        '''无值查全部'''
        books = Book.objects.all()
        ret = BookSerializer(instance=books, many=True)
        data = ret.data
        # lis = [{'name': book.name, 'price': book.price} for book in books]
        response['msg'] = data
        return JsonResponse(response, safe=False)
```

##### 2.restframework序列化工具---之反序列化

> 实例-继承ModelSerializer

```python
1.myser文件中

class BookSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Book
        fields = '__all__'

    name = serializers.CharField(min_length=2, error_messages={'required': '该字段必填'})
    authors = serializers.CharField(required=False, )

    # 局部钩子:
    def validate_name(self, value):
        # print(value)
        if value.startswith('sb'):
            # 不能以sb开头
            raise ValidationError('不能以sb开头')
        else:
            return value

    # 全局钩子找到了
    def validate(self, value):
        # value是所有校验通过数据的字典
        print(value)
        name = value.get('name')
        price = value.get('price')
        if name and price:
            if str(name) == str(price):
                return value
            else:
                raise ValidationError('名字跟价格不相等')
        return value
    
    
2.视图中

class BookView(APIView):
    """
    GET /Book：返回资源对象的列表（数组）
    GET /Book/1：返回单个资源对象
    POST /Book：返回新生成的资源对象    -新增,传数据,一旦新增完成,把新的资源对象返回
    PUT /Book/1：返回完整的资源对象
    PATCH /Book/1：返回完整的资源对象
    DELETE /Book/1：返回一个空文档

    """

    def get(self, request, **kwargs):
        response = {'status': 100, 'msg': None}
        if kwargs:
            '''有值查一条'''
            book = Book.objects.filter(pk=kwargs['id']).first()
            ser = BookSerializer(book, many=False)
            data = ser.data
            print(data, type(data))
            # <class 'rest_framework.utils.serializer_helpers.ReturnDict'>-----data类型
            # response['msg'] = {'name': book.name, 'price': book.price}
            response['msg'] = data
            return JsonResponse(response, safe=False)
        else:
            '''无值查全部'''
            books = Book.objects.all()
            ret = BookSerializer(instance=books, many=True)
            data = ret.data
            # lis = [{'name': book.name, 'price': book.price} for book in books]
            response['msg'] = data
        return JsonResponse(response, safe=False)

    def post(self, request, **kwargs):
        # publish = Publish.objects.filter(pk=request.data.get('publish')).first()
        # ret = BookSerializer(data=request.data, context={'publish': publish})
        # 新增一条记录通过序列化的类，传入需要新增的内容，给data接受
        ret = BookSerializer(data=request.data)
        if ret.is_valid():
            ret.save()
            return Response(ret.data)
        else:
            return Response(ret.errors)

    def put(self, request, **kwargs):
        response = {'status': 100, 'msg': None}
        book = Book.objects.filter(pk=kwargs['id']).first()
        # 必须将需要修改的book对象放在里面
        # 更新一条记录时，一定要指定instance的对象
        ret = BookSerializer(data=request.data, instance=book)
        if ret.is_valid():
            ret.save()
            response['msg'] = ret.data
        else:
            response['msg'] = ret.errors
        return JsonResponse(response, safe=False)

    def patch(self, request, **kwargs):
        response = {'status': 100, 'msg': None}
        book = Book.objects.filter(pk=kwargs['id']).first()
        # 必须将需要修改的book对象放在里面
        ret = BookSerializer(data=request.data, instance=book)
        if ret.is_valid():
            ret.save()
            response['msg'] = ret.data
        else:
            response['msg'] = ret.errors
        return JsonResponse(response, safe=False)

    def delete(self, request, **kwargs):
        response = {'status': 100, 'msg': None}
        # 删除就不要用序列化组件了
        ret = Book.objects.filter(pk=kwargs['id']).delete()
        print(ret)  # (1, {'app01.Book': 1})
        response['msg'] = '删除成功'
        return JsonResponse(response)
```

***

```python
注意：
1.对一张表的增删改查应该对应一个视图类
2.针对get请求方式，查全部或者查单条
3.如何想过滤，需要在视图里面查询的时候进行过滤
4.反序列化时一定不能写depth，否则会报错。

```

***

```python
1.有时候需要重写create和update方法，需要手动pop掉多余的字段。
def create(self, validated_data):
    print(validated_data, 'mmmmmmmmm')
    # {'name': '金瓶梅', 'price': Decimal('45.00'), 'publish_date': datetime.date(2014, 11, 22)}
    return Book.objects.create(publish=self.context["publish"], **validated_data)

 def update(self, instance, validated_data):
        # instance 是需要更新的对象，validated_data是验证通过的数据，基于对象的更新
        instance.name = validated_data.get('name')
        instance.save()
        return instance

```

```python
1.*****手动创建对象，并传入第三张表中（在ModelSerializer）
 def create(self, validated_data):
        print(validated_data, 'mmmmmmmmm')
        # 如何才能不用传nid
        mm = self.fields
        print(mm)
        author_list = validated_data['authors']
        print(validated_data['authors'])  # [<Author: Author object>, <Author: Author object>]
        # {'name': '金瓶梅', 'price': Decimal('45.00'), 'publish_date': datetime.date(2014, 11, 22)}
        author_list = validated_data.pop('authors')
        book = Book.objects.create(**validated_data)
        # 第三张表中添加字段。最好加在事务里面，出错回滚
        book.authors.add(*author_list)
        return book
    
    
2.*****手动创建对象，并传入第三张表中（在Serializer）
# 假设现在是个博客，有一个创建文章，与修改文章的功能, model为Article。
class ArticleSerializer(serializers.Serializer):
    # 将user这个用户保存起来，需要的时候调用
    user = serializers.HiddenField(
        default=serializers.CurrentUserDefault())
    name = serializers.CharField(max_length=20)
    content = serializers.CharField()

    def create(self, validated_data):
        # 除了用户，其他数据可以从validated_data这个字典中获取
        # 注意，users在这里是放在上下文中的request，而不是直接的request
        user = self.context['request'].user
        name = validated_data['name ']
        content = validated_data['content ']
        return Article.objects.create(**validated_data)

    def update(self, instance, validated_data):
        # 更新的特别之处在于你已经获取到了这个对象instance
        instance.name = validated_data.get('name')
        instance.content = validated_data.get('content')
        instance.save()
        return instance
```

![](C:\Users\zhangchenggang\Desktop\序列化组件图.png)

##### 3.序列化组件中可传参数

```python
1.read_only
read_only：True表示不允许用户自己上传，只能用于api的输出。如果某个字段设置了read_only=True，那么就不需要进行数据验证，只会在返回时，将这个字段序列化后返回.

2.write_only
write_only:与read_only对应;就是用户post过来的数据，后台服务器处理后不会再经过序列化后返回给客户端；最常见的就是我们在使用手机注册的验证码和填写的密码。

3.required
就是这个字段是否必填，例如要求：用户名，密码等是必须填写的；不填写就直接报错.

4.allow_null/allow_blank
是否允许为NULL/空 。 

5.error_messages
出错时，信息提示。

6.lable
页面字段显示的标签

7.max_length/min_length
最大/最小长度

8.help_text
在指定字段增加一些提示文字，这两个字段作用于api页面比较有用 

9.style
说明字段的类型
eg:
    # 在api页面，输入密码就会以*显示
    password = serializers.CharField( style={'input_type': 'password'})
       
    # 会显示选项框
    color_channel = serializers.ChoiceField(
        choices=['red', 'green', 'blue'],
        style={'base_template': 'radio.html'})
```

##### 4.常用字段

```python
1.普通字段
CharField、BooleanField、IntegerField、DateTimeField

2.隐藏字段
HiddenField
HiddenField的值不依靠输入，而需要设置默认的值，不需要用户自己post数据过来，也不会显式返回给用户，最常用的就是user!! 
例如：
在登录情况下，进行一些操作，假设一个用户去收藏了某一门课，那么后台应该自动识别这个用户，然后用户只需要将课程的id post过来，那么这样的功能，我们配合CurrentUserDefault()实现。
eg:
# 这样就可以直接获取到当前用户
user = serializers.HiddenField(default=serializers.CurrentUserDefault())
    
```

##### 5.钩子函数

```python
1.局部钩子，validata_字段名
class SmsSerializer(serializers.Serializer):
    """
    为什不用ModelSerializer来完成手机号码的验证呢？
    因为VerifyCode中还有一个字段是手机验证码字段，直接使用ModelSerializer来验证会报错
    因为ModelSerializer会自动生成VerifyCode模型中的所有字段；但是
    我们传递过来的就是一个手机号，判断它是否是合法的
    因此使用Serializer来自定义合法性校验规则，相当于就是钩子函数
    单独对手机号码进行验证
    """
    mobile = serializers.CharField(max_length=11)
　　# 使用validate_字段名(self, 字段名)：要么返回字段，要么抛出异常
    def validate_mobile(self, mobile):
        """
        验证手机号码，记住这里的validate_字段名一定要是数据模型中的字段
        :param attrs:
        :return:
        """
        # 手机号码是否注册，查询UserProfile表即可
        if User.objects.filter(mobile=mobile).exists():
            raise serializers.ValidationError("用户已经存在")

        # 验证手机号码是否合法，这部分应该是在前端做的，当然后台也需要进行验证
        if not re.match(REGEX_MOBILE, mobile):
            raise serializers.ValidationError("手机号码格式不正确")

        # 验证发送频率，如果不做，用户可以一直向后台发送，请求验证码；
        # 会造成很大的压力，限制一分钟只能发送一次 7-8 09:00
        one_minute_ago = datetime.now() - timedelta(hours=0, minutes=1, seconds=0)
        """
        如果添加时间在一分钟以内，它肯定是大于你一分钟之前的时间的
        如果这条记录存在
        """
        if VerifyCode.objects.filter(add_time__gt=one_minute_ago, mobile=mobile):
            raise serializers.ValidationError("抱歉，一分钟只能发送一次")
        # 如果验证通过，我就将这个mobile返回去，这里一定要有一个返回
        return mobile
```

```python
2.全局钩子validate
 def validate(self, value):
        # value是所有校验通过数据的字典
        print(value)
        name = value.get('name')
        price = value.get('price')
        if name and price:
            if str(name) == str(price):
                return value
            else:
                raise ValidationError('名字跟价格不相等')
        return value
```

***

> 全局钩子除了验证功能以外，还可以对read_only字段进行赋值操作

```python
eg：订单号的生成，我们可以在这步生成一个订单号，然后添加到attrs这个字典中

class OrderSerializer(serializers.ModelSerializer):
    user = serializers.HiddenField(
        default=serializers.CurrentUserDefault()
    )

    pay_status = serializers.CharField(read_only=True)
    trade_no = serializers.CharField(read_only=True)
    order_sn = serializers.CharField(read_only=True)
    pay_time = serializers.DateTimeField(read_only=True)
    """
    在用户提交订单的时候，我们在这里给用户新增一个字段，就是支付宝支付的URL
    要设置为read_only=True，这样的话，就不能让用户端提交了，而是服务器端生成
    返回给用户的
    """
    alipay_url = serializers.SerializerMethodField(read_only=True)

    def get_alipay_url(self, obj):  # obj就是OrderSerializer对象
        alipay = AliPay(
            appid="2016091200490227",  # 沙箱环境中可以找到
            app_notify_url="http://47.92.87.172:8000/alipay/return/",
            app_private_key_path=private_key_path,  # 个人私钥
            alipay_public_key_path=ali_pub_key_path,  # 支付宝的公钥，验证支付宝回传消息使用，不是你自己的公钥,
            debug=True,  # 默认False,上线的时候修改为False即可
            return_url="http://47.92.87.172:8000/alipay/return/"
        )

        url = alipay.direct_pay(
            # 一个订单里面可能有多个商品，因此subject
            # 不适合使用商品名称
            subject=obj.order_sn,
            out_trade_no=obj.order_sn,
            total_amount=obj.order_mount,
        )
        re_url = "https://openapi.alipaydev.com/gateway.do?{data}".format(data=url)

        return re_url

    def generate_order_sn(self):
        """
        后台系统生成订单号
        这个是系统后台生成的：
        当前时间+userId+随机数
        """
        random_ins = Random()
        order_sn = "{time_str}{user_id}   	{random_num}".format(time_str=time.strftime("%Y%m%d%H%M%S"),                                                          user_id=self.context["request"].user.id,                                                    random_num=random_ins.randint(1000, 9999))
        return order_sn

    def validate(self, attrs):  # 全局钩子函数
        attrs["order_sn"] = self.generate_order_sn()
        return attrs

    class Meta:
        model = OrderInfo
        fields = "__all__"
```

##### 6.联合唯一

```python
1.UniqueTogetherValidator
联合唯一，例如我们需要判断用户是否收藏了某个商品，前端只需要传递过来一个商品ID即可。这个时候就不是像上面那样单独作用于某个字段，而是需要进行联合唯一的判断，即用户ID和商品ID；此时我们需要在Meta中设置。

class UserFavSerializer(serializers.ModelSerializer):
    # 获取到当前用户
    user = serializers.HiddenField(
        default=serializers.CurrentUserDefault()
    )

    class Meta:
        model = UserFav
        """
        我们需要获取的是当前登入的user
        以后要取消收藏，只需要获取这里的id即可
        UniqueTogetherValidator作用在多个字段之上
        因为是联合唯一主键
        """
        validators = [
            UniqueTogetherValidator(
                queryset=UserFav.objects.all(),
                fields=('user', 'goods'),
                message="已经收藏"
            )
        ]
        fields = ("user", "goods", "id")
```

##### 7.ModelSerializer需要解决的2个问题

> 问题一：某个字段不属于指定model，它是write_only，需要用户传进来，但我们不能对它进行save( )，因为ModelSerializer是基于Model，这个字段在Model中没有对应，这个时候，我们需要重载validate！ 

```python
实例：
在用户注册时，我们需要填写验证码，这个验证码只需要验证，不需要保存到用户这个Model中：

def validate(self, attrs):
    del attrs["code"]
    return attrs
```

> 问题二：某个字段不属于指定model，它是read_only，只需要将它序列化传递给用户，但是在这个model中，没有这个字段！我们需要用到SerializerMethodField。

```python
实例：
假设需要返回用户加入这个网站多久了，不可能维持这样加入的天数这样一个数据，一般会记录用户加入的时间点，然后当用户获取这个数据，我们再计算返回给它。

class UserSerializer(serializers.ModelSerializer):  
    days_since_joined = serializers.SerializerMethodField()
    # 方法写法：get_ + 字段
    def get_days_since_joined(self, obj):
    # obj指这个model的对象
        return (now() - obj.date_joined).days

    class Meta:
        model = User

```

#### 四.DRF认证组件

##### 1.源码分析

```
APIView---dispatch---initialize_request（包装request）---apiview的get_authenticators---将对象列表返回给authenticators----执行apiview的initial方法---执行apiview的perform_authentication方法-----（request.user）---Request.user方法----执行request对象的_authenticate方法------循环request对象的authenticators----执行循环出的每个对象的authenticate方法，将自己和request这个对象传入----最后返回一个元组（认证通过）或者抛出异常（认证失败）exceptions.APIException----如果认证通过self.user, self.auth = user_auth_tuple执行的结果解压赋 值，给request对象添加二个属性。
```

##### 2.认证组件如何使用

```python
1.新建一个认证组件的py文件
2.创建一个认证类
3.在类中定义一个authenticate对象的绑定方法，并接受request这个参数
4.成功返回一个元组，当前认证通过的用户，以及auth
5.失败抛出APIException('用户不合法')
6.可以继承

eg:
from rest_framework import exceptions
from app01.models import *

# 存到数据库的版本

class LoginAuth:
    def authenticate(self, request):
        token = request.query_params.get('token')
        ret = UserToken.objects.filter(token=token).first()
        if ret:
            return ret.user, ret
        raise exceptions.APIException('用户不合法')
```

***

> 1.局部使用

```python
1.在视图中导入认证组件
from app01.Myauth import LoginAuth

2.在视图类中定义一个变量（名字不能变）
authentication_classes = [LoginAuth, ]

3.这样改视图类就具备了验证功能
```

> ​	

> 2.全局使用

```python
1.在settings里面配置
REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'app01.Myauth.LoginAuth',
    ),
}


2.局部禁用
authentication_classes = []
```

> 3.认证组件执行顺序

```
认证类使用顺序：先用视图类中的验证类，再用settings里配置的验证类，最后用默认的验证类
```

#### 五.DRF权限组件

```
只用超级用户才能访问指定的数据，普通用户不能访问，所以就要有权限组件对其限制
```

##### 1.源码分析

```
APIView---dispatch----执行initial方法----执行apiview对象的check_permissions方法（循环对象列表）----执行apiview的get_permissions方法（对象列表）---执行对象列表里面的has_permission方法，返回结果为True/False,传入三个参数，第一个参数是对象本身，第二个参数request，第三个参数是view对象。
```

##### 2.权限组件如何使用

> 1.局部使用

```python
1.创建一个py文件
from rest_framework.permissions import BasePermission


class UserPermission(BasePermission):
    message = '您没有相关权限'

    def has_permission(self, request, view):
        if request.user.user_type == 2:
            return True
        else:
            return False
        
1.在视图中导入认证组件
from app01.Mypremisssion import UserPermission

2.在视图类中定义一个变量（名字不能变）
 permission_classes = [UserPermission,]

3.这样改视图类就具备了权限功能
```

> 2.全局使用

```python
1.在settings里面配置
REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'app01.Myauth.LoginAuth',
    ),
    'DEFAULT_PERMISSION_CLASSES': (
        'app01.Mypremisssion.UserPermission',
    ),
}

2.局部禁用
permission_classes = []
```

> 3.权限组件执行顺序

```
权限类使用顺序：先用视图类中的权限类，再用settings里配置的权限类，最后用默认的权限类
```

#### 六.importlib使用分析

##### 1.动态导入

```python
import importlib

# 当前实在执行文件下
# 相对导入模块
# name = ".name" ---模块名，即py文件
# package= "day01.bb" ---包的路径
# 最后返回一个模块对象
func = importlib.import_module(name='.kk', package='day01.bb')

if __name__ == '__main__':
    print(func)
    # 模块对象可以通过.属性访问里面的方法和属性
    func.foo3()
    func.run()
```

#### 七.UUID模块

##### 1.什么是uuid

```python
uuid是128位的全局唯一标识符（univeral unique identifier），通常用32位的一个字符串的形式来表现。有时也称guid(global unique identifier)，C#语言中使用。python中自带了uuid模块来进行uuid的生成和管理工作

UUID —— Universally Unique IDentifier  Python中称为 UUID
GUID —— Globally Unique IDentifier     C#中称为 GUID
它是通过MAC地址、 时间戳、 命名空间、 随机数、 伪随机数来保证生成ID的唯一性,，有着固定的大小( 128 bit位 )，通常由 32 字节的字符串（十六进制）表示

它的唯一性和一致性特点，使得可以无需注册过程就能够产生一个新的UUID；UUID可以被用作多种用途, 既可以用来短时间内标记一个对象，也可以可靠的辨别网络中的持久性对象
```

##### 2.uuid有什么用

```
1.需要id要唯一，但不需要具体的意义
2.仅仅用来标识一个对象。常见的用处有数据库表的id字段；用户session的key值；前端的各种UI库，因为它们通常需要动态创建各种UI元素，这些元素需要唯一的id， 这时候就需要使用UUID了。例如：一个网站在存储视频、图片等格式的文件时，这些文件的命名方式就可以采用 UUID生成的随机标识符，避免重名的出现
```

##### 3.python中uuid模块

```python
import uuid

#   基于时间戳
#   使用主机ID, 序列号, 和当前时间来生成UUID, 可保证全球范围的唯一性.
#   但由于使用该方法生成的UUID中包含有主机的网络地址, 因此可能危及隐私.
#   该函数有两个参数, 如果 node 参数未指定, 系统将会自动调用 getnode() 函数来获取主机的硬件(mac)地址.
#   如果 clock_seq  参数未指定系统会使用一个随机产生的14位序列号来代替.
print(uuid.uuid1())

#   通过计算名字和命名空间的MD5散列值得到，保证了同一命名空间中不同名字的唯一性，
#   和不同命名空间的唯一性，***但同一命名空间的同一名字生成相同的uuid****。
print(uuid.uuid3(uuid.NAMESPACE_URL, 'zhang'))
print(uuid.uuid3(uuid.NAMESPACE_URL, 'zhang'))
# 70670fc3-1147-3c67-b9ae-20bbf7ec0b96
# 70670fc3-1147-3c67-b9ae-20bbf7ec0b96

# 通过随机数来生成UUID. 使用的是伪随机数有一定的重复概率.
print(uuid.uuid4())
# 3a597f00-9d3e-492f-a73b-c5cb9b6ad808

print(uuid.uuid5(uuid.NAMESPACE_URL, 'zhang'))
print(uuid.uuid5(uuid.NAMESPACE_URL, 'zhang'))
# f54fe653-75f9-5cae-ad85-73f4c2765aa4
# f54fe653-75f9-5cae-ad85-73f4c2765aa4
```

##### 4.总结

```python
1 Python中没有基于 DCE 的，所以uuid2可以忽略
2 uuid4存在概率性重复，由无映射性
3 若在Global的分布式计算环境下，最好用uuid1
4 若有名字的唯一性要求，最好用uuid3或uuid5
```

#### 八.DRF频率控制组件

##### 1.什么是频控组件

```
1.为了控制用户对某个url请求的频率，比如，一分钟以内，只能访问三次
2.节流访问控制
```

##### 2.怎么使用组件

```python 
1.自定义频控
import time

class MyThrottle:
    dic = {}

    def __init__(self):
        self.history = None
        self.ctime = None

    def allow_request(self, request, view):
        ip = request.META.get('REMOTE_ADDR')
        ctime = time.time()
        self.ctime = ctime
        if ip not in self.dic:
            self.dic[ip] = [ctime, ]
            return True
        # 这里是dic里面有该ip了
        history = self.dic.get(ip)
        self.history = history
        while history and ctime - history[-1] > 60:
            # 默认从尾删
            history.pop()
        if len(history) < 3:
            # 如果小于3，列表中插入一个时间
            history.insert(0, ctime)
            return True
        return False

    def wait(self):
        # (self.ctime - self.history[-1])最新的时间减去最后的时间，最大时间差
        # 60减去最大时间差，就是还剩下多少秒过后ctime-history[-1]可以pop掉
        return 60 - (self.ctime - self.history[-1])
    
    
 
```

```python
2.用rest频控组件
from app01.myThrottle import MyThrottle
class BookView(MyAPIView):
    throttle_classes = [MyThrottle, ]
```

```python
3.输出错误信息中文方式一：修改源码
from rest_framework.exceptions import Throttled, APIException
class Throttled(Throttled, APIException):
    default_detail = '傻逼'
    extra_detail_singular = '还剩 {wait} 秒.'
    extra_detail_plural = '还剩 {wait} 秒'
    
   
def throttled(self, request, wait):
    """
    If request is throttled, determine what kind of exception to raise.
    """
    # 已经修改了源码
    raise self.Throttled(wait)
    
    
4.输出错误信息中文方式二
def throttled(self, request, wait):
    class MyThrottled(exceptions.Throttled):
        default_detail = '傻逼'
        extra_detail_singular = '还剩 {wait} 秒.'
        extra_detail_plural = '还剩 {wait} 秒'

   	raise MyThrottled(wait)
```

> 3.全局使用

```python
1.在Mythro模块中定义这个类，继承SimpleRateThrottle
from rest_framework.throttling import BaseThrottle, SimpleRateThrottle
class MyThrottle(SimpleRateThrottle):
    scope = 'aaa'

    def get_cache_key(self, request, view):
        # 返回ip地址
        # ip=request.META.get('REMOTE_ADDR')
        # return ip
        return self.get_ident(request)
```

```python
2.在settings里面做配置
REST_FRAMEWORK = {
    'DEFAULT_THROTTLE_CLASSES': ['app01.MyAuth.MyThrottle', ],
    'DEFAULT_THROTTLE_RATES': {
        'aaa': '10/m'
    }
}
```

> 4.局部使用少用几个

```
throttle_classes = [MyThrottle,]
写几个就用几个
```

> 5.局部使用，全局不使用

```python
throttle_classes = [MyThrottle,]
写几个就用几个
```

#### 九.DRF解析器

##### 1.什么是解析器

```
根据请求头 content-type 选择对应的解析器对请求体内容进行处理。

有application/json，x-www-form-urlencoded，form-data等格式
```

##### 2.drf内置的解析器

```python
'DEFAULT_PARSER_CLASSES': (
        'rest_framework.parsers.JSONParser',
        'rest_framework.parsers.FormParser',
        'rest_framework.parsers.MultiPartParser'
    ),
```

> 3.全局使用解析器

```python
在settings里面配置
REST_FRAMEWORK = {
    'DEFAULT_PARSER_CLASSES':[
        'rest_framework.parsers.JSONParser'
        'rest_framework.parsers.FormParser'  
        'rest_framework.parsers.MultiPartParser'
    ]

}
```

> 4.局部使用解析器

```python
在视图函数中,或者视图函数所继承的父类中
from rest_framework.parsers import JSONParser  # 解析json格式
from rest_framework.parsers import FileUploadParser #解析上传文件
from rest_framework.parsers import FormParser #application/x-www-form-urlencoded 的请求体
from rest_framework.parsers import MultiPartParser #multipart/form-data的请求体

class TestView(APIView):
    parser_classes = [JSONParser, ]
```

#### 十.DRF视图组件

##### 1.什么是视图组件

```python
可以控制多个路由响应的视图
```

##### 2.视图组件的用法一

> 路由

```python
url(r'^publish/$', views.PublishView.as_view()),
url(r'^publish/(?P<pk>\d+)/$', views.PublishDetailView.as_view()),
```

> 视图

```python
from rest_framework.mixins import ListModelMixin, \ # 可以返回get多个对象
                                  CreateModelMixin, \# 添加一条记录
                                  RetrieveModelMixin, \# 可以返回get单个对象
                                  UpdateModelMixin,\ # 更新一个记录
                                  DestroyModelMixin #删除一条记录
from rest_framework.generics import GenericAPIView

class PublishView(GenericAPIView, ListModelMixin, CreateModelMixin):
    queryset = Publish.objects.all()
    serializer_class = PublishSerializers

    def get(self, request):
        return self.list(request)

    def post(self, request):
        # 添加一条数据
        return self.create(request)


class PublishDetailView(GenericAPIView, RetrieveModelMixin, UpdateModelMixin, DestroyModelMixin):
    queryset = Publish.objects.all()
    serializer_class = PublishSerializers

    def get(self, request, pk):
        return self.retrieve(request, pk)

    def put(self, request, pk):
        return self.update(request, pk)

    def delete(self, request, pk):
        return self.destroy(request, pk)
```

##### 3.视图组件的用法二

> 路由

```python
url(r'^publish/$', views.PublishView.as_view()),
url(r'^publish/(?P<pk>\d+)/$', views.PublishDetailView.as_view()),
```

> 视图

```python
from rest_framework.generics import ListCreateAPIView, ListAPIView, RetrieveUpdateDestroyAPIView

class PublishView(ListCreateAPIView):
    queryset = Publish.objects.all()
    serializer_class = PublishSerializers


class PublishDetailView(RetrieveUpdateDestroyAPIView):
    queryset = Publish.objects.all()
    serializer_class = PublishSerializers
```

##### 3.视图组件的用法三

> 路由

```python
url(r'^publish', views.PublishView.as_view({'get': 'list', 'post': 'create'})),
url(r'^publish/(?P<pk>\d+)', views.PublishView.as_view({'get': 'retrieve', 'put': 'update','delete':'destroy'})),
```

> 视图

```python
from rest_framework.viewsets import ModelViewSet

class PublishView(ModelViewSet):
    queryset = Publish.objects.all()
    serializer_class = PublishSerializers
```

##### 4.注意：以上三种用法都不建议使用

##### 5.魔法类ViewSetMixin

> 导入

```python
from rest_framework.viewsets import ViewSetMixin
```

> 使用

```python
1.路由
url(r'^test1/$', views.TestAll.as_view({'get': 'test'})),
url(r'^test2/$', views.TestAll.as_view({'get': 'test2'})),
url(r'^test3/$', views.TestAll.as_view({'get': 'test3'})),

2.视图
# 注意先后顺序,ViewSetMixin写在前面
class TestAll(ViewSetMixin, APIView):
    def test(self, request):
        print(settings.DEBUG)

        return HttpResponse('test')

    def test2(self, request):
        return HttpResponse('test2')

    def test3(self, request):
        return HttpResponse('test3')
```

> 作用

```
可以让不同的路由，响应到同一个视图类中的不同的视图方法。
比如：和book相关的路由，用一个视图类，和publish相关的，用一个视图类
```

> 源码分析

```python
class ViewSetMixin(object):
    """
    This is the magic.

    Overrides `.as_view()` so that it takes an `actions` keyword that performs
    the binding of HTTP methods to actions on the Resource.

    For example, to create a concrete view binding the 'GET' and 'POST' methods
    to the 'list' and 'create' actions...

    view = MyViewSet.as_view({'get': 'list', 'post': 'create'})
    """

    @classonlymethod
    def as_view(cls, actions=None, **initkwargs):
        # 重写了as_view，将传入的字典给actions参数接收
        def view(request, *args, **kwargs):
            # 实例化产生一个视图类的对象
            self = cls(**initkwargs)
            self.action_map = actions
            for method, action in actions.items():
                # {"get":"list"}
                # handler拿到是视图类中的方法的内存地址
                handler = getattr(self, action)
                # 将视图类中的内存地址设置成视图对象self的属性
                setattr(self, method, handler)

            if hasattr(self, 'get') and not hasattr(self, 'head'):
                self.head = self.get

            self.request = request
            self.args = args
            self.kwargs = kwargs

            # And continue as usual
            return self.dispatch(request, *args, **kwargs)
        update_wrapper(view, cls, updated=())
        update_wrapper(view, cls.dispatch, assigned=())
        view.cls = cls
        view.initkwargs = initkwargs
```

```python
1.无论以后执行的是什么路由，全部响应到这个ViewSetMixin这个里面的as_view的魔法方法中
```

#### 十一.DRF之响应器

##### 1.什么是响应器

```
根据用户请求的url或用户可接受的类型，筛选出合适渲染组建
```

##### 2.内置渲染器

```python
1.显示json格式：JSONRenderer

访问URL：

http://127.0.0.1:8000/test/?format=json
http://127.0.0.1:8000/test.json
http://127.0.0.1:8000/test/
 
2.默认显示格式：BrowsableAPIRenderer（可以修改它的html文件）

访问URL：

http://127.0.0.1:8000/test/?format=api
http://127.0.0.1:8000/test.api
http://127.0.0.1:8000/test/
 

3.表格方式：AdminRenderer

访问URL：

http://127.0.0.1:8000/test/?format=admin
http://127.0.0.1:8000/test.admin
http://127.0.0.1:8000/test/
 

4.form表单方式：HTMLFormRenderer

访问URL：

http://127.0.0.1:8000/test/?format=form
http://127.0.0.1:8000/test.form
http://127.0.0.1:8000/test/

```

##### 3.局部使用

```python
from rest_framework.renderers import  HTMLFormRenderer,BrowsableAPIRenderer
class BookDetailView(APIView):
    renderer_classes = [HTMLFormRenderer,BrowsableAPIRenderer ]
    def get(self,request,pk):
        book_obj=models.Book.objects.filter(pk=pk).first()
        bs=BookSerializers(book_obj,many=False)
        return Response(bs.data)
    def put(self,request,pk):
        book_obj = models.Book.objects.filter(pk=pk).first()

        bs=BookSerializers(data=request.data,instance=book_obj)
        if bs.is_valid():
            bs.save() # update
            return Response(bs.data)
        else:
            return Response(bs.errors)
    def delete(self,request,pk):
        models.Book.objects.filter(pk=pk).delete()

        return Response("")
```

##### 4.全局使用

```python
在settings里面配置
REST_FRAMEWORK = {
    'DEFAULT_RENDERER_CLASSES':['rest_framework.renderers.JSONRenderer']
}
```

##### 5.自定义显示模板

```python
from rest_framework.renderers import TemplateHTMLRenderer

class BookDetailView(APIView):
    renderer_classes = [TemplateHTMLRenderer]
    def get(self,request,pk):
        book_obj=models.Book.objects.filter(pk=pk).first()
        bs=BookSerializers(book_obj,many=False)
        return Response(bs.data,template_name='aa.html')
```

##### 6.注意

```
注意：如果同时多个存在时，自动根据URL后缀来选择渲染器。
```

#### 十二.DRF之url控制

##### 1.原始的路由

```python
from django.conf.urls import url
from app01 import views
urlpatterns = [
    url(r'^books/$', views.BookView.as_view()),
    url(r'^books/(?P<pk>\d+)$', views.BookDetailView.as_view()),
]
```

##### 2.半自动路由（视图类继承ModelViewSet）

```python
from django.conf.urls import url
from app01 import views
urlpatterns = [
    url(r'^publish/$', views.PublishView.as_view({'get':'list','post':'create'})),
    url(r'^publish/(?P<pk>\d+)/$', views.PublishView.as_view({'get':'retrieve','put':'update','delete':'destroy'})),

]
```

##### 3.全自动路由(不推荐使用)

```python
1.路由
from django.conf.urls import url,include
from app01 import views
from rest_framework import routers
router=routers.DefaultRouter()
# 两个参数，一个是匹配的路由，一个是视图中写的CBV的类
router.register('publish',views.PublishView)
urlpatterns = [
    # http://127.0.0.1:8000/publish/format=json(渲染器通过这个判断，返回渲染的页面)
    # url(r'^publish/', views.PublishView.as_view({'get':'list','post':'create'})),
    # http://127.0.0.1:8000/publish.json(渲染器通过这个判断，返回渲染的页面)
    # url(r'^publish\.(?P<format>\w+)$', views.PublishView.as_view({'get':'list','post':'create'})),
    
    # 可以用 以下方式访问
    # 1 http://127.0.0.1:8000/publish/
    # 2 http://127.0.0.1:8000/publish.json
    # 3 http://127.0.0.1:8000/publish/3
    # 4 http://127.0.0.1:8000/publish/3.json   
    url(r'',include(router.urls))
```

```python
2.视图
from rest_framework.viewsets import ModelViewSet
class PublishView(ModelViewSet):
    queryset=models.Publish.objects.all()
    serializer_class=PublishSerializers
```

#### 十三.DRF之分页器

##### 1.简单分页

```python
1.四个核心参数
# 每页显示多少条
page_size = 3
# 查询的key,问号后面的key
page_query_param = 'aa'
# 指定当前页显示多少条
page_size_query_param = 'size'
# 每页最多显示多少条
max_page_size = 4
```

> 如何使用

```python
# 普通分页
from rest_framework.pagination import PageNumberPagination
def get_all(self, request):
    response = {'status': 100, 'msg': '查询成功'}
    book_list = models.Book.objects.all()
    # 实例化产生一个分页对象
    # 不继承来修改对象的值
    page = PageNumberPagination()
    page.page_size = 2
    # 页面访问参数
    page.page_query_param = 'bb'
    # page = MyPageNumberPagination()
    # 第一个参数:要分页的数据,第二个参数request对象,第三个参数,当前视图对象
    page_list = page.paginate_queryset(book_list, request, self)
    # 再序列化的时候,用分页之后的数据
    ser = mySer.BookSerializer(instance=page_list, many=True)
    response['data'] = ser.data
    # return Response(response)
    # 会带着链接,和总共的条数(不建议用)
    return page.get_paginated_response(response)
```

```python
2.可以在setting里面配置全局的page_size
REST_FRAMEWORK = {
    # 每页显示两条
    'PAGE_SIZE':2
}
```

##### 2.偏移分页

```python
#默认每页显示几条
default_limit = 2
#自定义偏移后取几条的参数
limit_query_param = 'limit'
#自定义偏移位置的参数
offset_query_param = 'offset'
#最多每页显示的条数
max_limit = None
```

> 使用

```python
# 偏移分页
from rest_framework.pagination import LimitOffsetPagination


class Book(ViewSetMixin, APIView):
    def get_all(self, request):
        response = {'status': 100, 'msg': '查询成功'}
        book_list = models.Book.objects.all()
        # 实例化产生一个偏移分页对象
        page = LimitOffsetPagination()
        page.default_limit = 3
        page.max_limit = 5

        page_list = page.paginate_queryset(book_list, request, self)
        ser = mySer.BookSerializer(instance=page_list, many=True)
        return Response(ser.data)
```

##### 3.加密分页（查询速度快，但是只能查上一页和下一页，cursor加密）

```python
#查询的关键字，后谜案是随机生成的字符串
cursor_query_param = 'cursor'
#指定每页显示的多少条
page_size = 2
#指定的排序方式
ordering = '-created'
```

#### 十四.反向解析

##### 1.get_all

```python
url(r'^(?P<version>[v1|v2|v3]+)/books/$', views.Book.as_view({'get': 'get_all'}), name='ttt'),
url2 = request.versioning_scheme.reverse('ttt', request=request)
```

##### 2.get_one

```python
url(r'^(?P<version>[v1|v2|v3]+)/books/(?P<pk>\d+)', views.Book.as_view({'get': 'get_one'}), name='mmm'),

url = reverse('mmm', kwargs=kwargs)
```

#### 十五.DRF之版本控制

##### 1.如何使用

```python
1.setting里面配置
REST_FRAMEWORK = {
    # 'DEFAULT_VERSIONING_CLASS':'rest_framework.versioning.QueryParameterVersioning', #全局配置
    'VERSION_PARAM':'version', #版本的key值，也就是路由的有名分组的名字
    'DEFAULT_VERSION':'v1', # 默认的版本
    'ALLOWED_VERSIONS': ['v1', 'v2'], # 允许的版本
}

```

```python
2.视图
from rest_framework.versioning import URLPathVersioning, QueryParameterVersioning, AcceptHeaderVersioning
class Book(ViewSetMixin, APIView):
    # 局部使用
    versioning_class = URLPathVersioning
```

```python
3.url
url(r'^(?P<version>[v1|v2|v3]+)/books/(?P<pk>\d+)', views.Book.as_view({'get': 'get_one'}), name='mmm'),
url(r'^(?P<version>[v1|v2|v3]+)/books/$', views.Book.as_view({'get': 'get_all'}), name='ttt'),
```

```
如何访问
http://127.0.0.1/v1/books/1
```

#### 十六.ContentType组件

##### 1.model层

```python
from django.db import models

# Create your models here.
from django.contrib.contenttypes.fields import GenericForeignKey, GenericRelation


class Course(models.Model):
    title = models.CharField(max_length=32)
    # 主要是为了方便根据课程查询价格策略
    policy = GenericRelation(to='PricePolicy', object_id_field='course_id', content_type_field='table')

    def __str__(self):
        return self.title


class DegreeCourse(models.Model):
    title = models.CharField(max_length=32)
    policy = GenericRelation(to='PricePolicy', object_id_field='course_id', content_type_field='table')

    def __str__(self):
        return self.title


class PricePolicy(models.Model):
    price = models.DecimalField(max_digits=8, decimal_places=2)
    period = models.CharField(max_length=32)
    course_id = models.IntegerField()
    # 外键关联contentType，一对多的关系，contenttypes是app名字，后面是表名
    table = models.ForeignKey(to='contenttypes.ContentType')
    # 不会在数据库中字段，为了方便查询和更新
    union = GenericForeignKey('table', 'course_id')

```

##### 2.视图层

```python
from django.shortcuts import render, HttpResponse
from app01.models import *
from django.contrib.contenttypes.models import ContentType


# Create your views here.


def test(request):
    # 为Django专题课，添加三个价格策略
    # 原始方式
    """
    course = Course.objects.filter(pk=1).first()
    table = ContentType.objects.filter(model='course').first()
    ret = PricePolicy.objects.create(price=10000, period=1, table=table, course_id=course.pk)
    ret = PricePolicy.objects.create(price=20000, period=2, table=table, course_id=course.pk)
    ret = PricePolicy.objects.create(price=30000, period=3, table=table, course_id=course.pk)
    """
    # contenttype方式,添加三个价格策略
    """
    course = Course.objects.filter(pk=2).first()
    ret = PricePolicy.objects.create(price=10000, period=1, union=course)
    ret = PricePolicy.objects.create(price=20000, period=2, union=course)
    ret = PricePolicy.objects.create(price=30000, period=3, union=course)
    """
    # 给学位课加一个价格策略
    """
    degree = DegreeCourse.objects.filter(pk=1).first()
    ret = PricePolicy.objects.create(price=50000, period=5.5, union=degree)
    """
    # 查询所有价格策略，并且显示对应的课程名称
    """
    # 查出所有的价格策略
    price_policy = PricePolicy.objects.all()
    # 循环所有的价格策略，拿到单个策略对象
    for i in price_policy:
        print(type(i))  # <class 'app01.models.PricePolicy'>
        print(i.union)  # python21天基础,拿到的是课程的对象，通过i.union拿到课程对象
    """
    # 查询Django所有的价格策略
    course = Course.objects.filter(pk=1).first()
    price_policy = course.policy.all()
    for i in price_policy:
        print(type(i))  # PricePolicy object
        print(i.period)  # 1
    return HttpResponse('ok')

```

#### 十七.Django的缓存机制

##### 1.缓存介绍

```python
1.在动态网站中，用户所有的请求，服务器都会取数据库中进行相应的增，删，改，查，渲染模板，执行业务逻辑，最后生成用户能看到的页面。

2.当一个网站的用户访问量很大的时候，每一次的后台操作，都会消耗很多的服务端的资源，所以必须使用缓存来减轻后端服务器的压力。

3.缓存是将一些常用的数据保存内存或者memcache中，在一定时间内有人来访问这些数据时，则不再去执行数据库及渲染等操作，而是直接从内存或memcache的缓存中去取得数据，然后返回给用户。
```

##### 2.django中的6种缓存的配置

> 方式一：开发调试（此模式为开发调试使用，实际上不执行任何操作）

```python
CACHES = {
 'default': {
  'BACKEND': 'django.core.cache.backends.db.DatabaseCache',  # 指定缓存使用的引擎
  'LOCATION': 'cache_table',          # 数据库表    
  'OPTIONS':{
   'MAX_ENTRIES': 300,           # 最大缓存记录的数量（默认300）
   'CULL_FREQUENCY': 3,          # 缓存到达最大个数之后，剔除缓存个数的比例，即：1/CULL_FREQUENCY（默认3）
  }  
 }   
}
```

> 方式二：内存缓存(将缓存内容保存至内存区域中)

```python
CACHES = {
 'default': {
  'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',  # 指定缓存使用的引擎
  'LOCATION': 'unique-snowflake',         # 写在内存中的变量的唯一值 
  'TIMEOUT':300,             # 缓存超时时间(默认为300秒,None表示永不过期)
  'OPTIONS':{
   'MAX_ENTRIES': 300,           # 最大缓存记录的数量（默认300）
   'CULL_FREQUENCY': 3,          # 缓存到达最大个数之后，剔除缓存个数的比例，即：1/CULL_FREQUENCY（默认3）
  }  
 }
}
```

> 方式三：**文件缓存(把缓存数据存储在文件中)**

```python
CACHES = {
 'default': {
  'BACKEND': 'django.core.cache.backends.filebased.FileBasedCache', #指定缓存使用的引擎
  'LOCATION': '/var/tmp/django_cache',        #指定缓存的路径
  'TIMEOUT':300,              #缓存超时时间(默认为300秒,None表示永不过期)
  'OPTIONS':{
   'MAX_ENTRIES': 300,            # 最大缓存记录的数量（默认300）
   'CULL_FREQUENCY': 3,           # 缓存到达最大个数之后，剔除缓存个数的比例，即：1/CULL_FREQUENCY（默认3）
  }
 }   
}
```

> 方式四：**数据库缓存（把缓存数据存在数据库中）**

```python
CACHES = {
 'default': {
  'BACKEND': 'django.core.cache.backends.db.DatabaseCache',  # 指定缓存使用的引擎
  'LOCATION': 'cache_table',          # 数据库表    
  'OPTIONS':{
   'MAX_ENTRIES': 300,           # 最大缓存记录的数量（默认300）
   'CULL_FREQUENCY': 3,          # 缓存到达最大个数之后，剔除缓存个数的比例，即：1/CULL_FREQUENCY（默认3）
  }  
 }   
}
```

```
1.注意,创建缓存的数据库表使用的语句
python manage.py createcachetable
```

> 方式五

```

```

> 方式六

```

```

##### 3.django中缓存的应用

> 1.全站使用缓存

```python
1.settings里面中间键配置
MIDDLEWARE = [
    # 重写了中间件的response_process方法
    'django.middleware.cache.UpdateCacheMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    # 重写了中间件的process_request方法
    'django.middleware.cache.FetchFromCacheMiddleware',
]
# 以秒为单位，设置缓存时间
CACHE_MIDDLEWARE_SECONDS = 10
```

> 2.单个页面使用缓存

```python
1.视图中
from django.views.decorators.cache import cache_page
import time
from .models import *

@cache_page(15)          #超时时间为15秒
def index(request):
　　t=time.time()      #获取当前时间
　　bookList=Book.objects.all()
　　return render(request,"index.html",locals())
```

> 3.页面中局部标签使用缓存

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
    {% load cache %}
    {% cache 5 'test' %}
    缓存的时间:
    {{ ctime }}
    {% endcache %}
    <hr>
    实际时间:
    {{ ctime }}
</body>
</html>
```

> 4.如果需要把缓存的数据放到文件中，怎么做

```python
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.filebased.FileBasedCache',  # 指定缓存使用的引擎
        'LOCATION': 'D:\lqz\catch',  # 指定缓存的路径
        'TIMEOUT': 300,  # 缓存超时时间(默认为300秒,None表示永不过期)
        'OPTIONS': {
            'MAX_ENTRIES': 300,  # 最大缓存记录的数量（默认300）
            'CULL_FREQUENCY': 3,  # 缓存到达最大个数之后，剔除缓存个数的比例，即：1/CULL_FREQUENCY（默认3）
        }
    }
}
```

#### 十八.django解决跨域问题

##### 1.跨域产生的原因

```
浏览器同源策略
```

##### 2.简单请求

```python
发一次请求：
请求方式：GET/HEAD/POST
头部信息不超过以下几种字段：
Accept
Accept-Language
Content-Language
Last-Event-ID
Content-Type：只限于三个值application/x-www-form-urlencoded、multipart/form-data、text/plain
```

##### 3.复杂请求

```python
1.非同源
2.请求方式：非get/head/post
3.或者请求方式：GET/HEAD/POST
但是Content-Type为json格式
4.非同源，头部信息超过以上5中字段的
```

##### 4.解决跨域

```python
from django.utils.deprecation import MiddlewareMixin
class CorsMiddleWare(MiddlewareMixin):
    def process_response(self,request,response):
    if request.method=="OPTIONS":
    #可以加*
    	response["Access-Control-Allow-Headers"]="Content-Type,token"
    response["Access-Control-Allow-Origin"] = "http://localhost:8080"
    return response
```

#### 十九.通过命令导出python项目依赖

```python
pip3 freeze > requirement.txt
显示效果如下
requirement.txt
pip3 install -r requirement.txt
```

```
asn1crypto==0.24.0
beautifulsoup4==4.6.3
certifi==2018.10.15
cffi==1.11.5
chardet==3.0.4
Click==7.0
cryptography==2.3.1
Django==1.11.9
djangorestframework==3.9.0
Flask==1.0.2
Flask-Cors==3.0.6
gevent==1.3.7
greenlet==0.4.15
idna==2.7
itsdangerous==1.1.0
Jinja2==2.10
MarkupSafe==1.0
numpy==1.15.4
pandas==0.23.4
Pillow==5.3.0
Pillow-PIL==0.1.dev0
pycparser==2.19
PyMySQL==0.9.2
python-dateutil==2.7.5
pytz==2018.7
requests==2.20.0
six==1.11.0
urllib3==1.24
Werkzeug==0.14.1

```



#### day19--路飞项目

#### 一.设置token超时时间

> 1.如何将datatime类型转换层时间戳

```python
import time

ctime = time.time()
usertoken = UserToken.objects.filter(token='19e40213-c879-4318-81fb-e567fd902cf6').first()
old_time = usertoken.time
# 将datatime类型转换成时间戳
online_seconds = int(time.mktime(old_time.timetuple()))
print(ctime-online_seconds)
```

> 2.时间戳和datatime相互转换

```python
python datetime 与时间戳相互转换


首先需要引入的时间相关模块：

import time, datetime
from datetime import date, datetime, timedelta

字符串时间online_time变为datetime类型online_dt：
DT_FORMAT='%Y%m%d %H:%M:%S'

online_time = '20170219 00:02:07'

online_dt = datetime.strptime(online_time, DT_FORMAT)


datetime类型online_dt变为时间戳秒online_seconds：

online_seconds = int(time.mktime(online_dt.timetuple()))

时间戳秒online_seconds变为datetime类型online_dt2(忽略时区):
online_dt2 = datetime.fromtimestamp(online_seconds)
datetime类型online_dt2变为字符串时间online_time2:

online_time2=online_dt2.strftime(DT_FORMAT)
显然online_time==online_time2。形成完成变换链

```

> 3.实例---实例之数据库版本

```python
1.settings
# 自定义token超时时间，后面会根据这个变量值，做切分，s代表秒，m代表分钟，h代表小时，d代表日，w代表一周
TOKEN_TIMEOUT = "18/H"
```

```python
2.myauth:登录验证

from rest_framework import exceptions
from user.models import *
from static.utils.Mycommon import ValidTokenTime

# 存到数据库的版本
class LoginAuth:
    def authenticate(self, request):

        token = request.query_params.get('token')
        # 查出token对象
        usertoken = UserToken.objects.filter(token=token).first()
        if usertoken:
            # 将对象传入超时验证组件
            res = ValidTokenTime(usertoken)
            # 判断是否验证通过
            if res.id_valid():
                return usertoken.user, usertoken
            else:
                raise exceptions.APIException('请重新登录，您的登录已超时')
        raise exceptions.APIException('用户不合法')
```

```python
3.mycommon
import time
from django.conf import settings
from rest_framework import exceptions


class ValidTokenTime:
    """将token的超时时间放在这里面验证"""

    def __init__(self, usertoken_obj):
        self.usertoken_obj = usertoken_obj

    def id_valid(self):
        # 获取当前时间
        ctime = time.time()
        # 获取数据库最后存取token的时间
        old_time = self.usertoken_obj.time
        # 当前时间和数据库的时间差
        time_difference = ctime - int(time.mktime(old_time.timetuple()))
        is_allow = self._allow(time_difference)
        return is_allow

    def _allow(self, time_difference):
        time_out = None
        try:
            # 将所有时间，转成时间戳的形式，统一进行计算
            num, unit = settings.TOKEN_TIMEOUT.strip(' ').split('/')
            if unit[0] not in ['s', 'S', 'm', 'M', 'h', 'H']:
                raise TypeError('配置文件错误')
            else:
                if unit[0] in ['s', 'S']:
                    time_out = int(num)
                elif unit[0] in ['m', 'M']:
                    time_out = int(num) * 60
                elif unit[0] in ['h', 'H']:
                    time_out = int(num) * 60 * 60

        except Exception as e:
            raise exceptions.APIException('配置文件格式不正确')
        if int(time_difference) > time_out:
            return False
        return True

```

> 4.实例---redis数据库版本

```python
1.myredis
import redis

POOL = redis.ConnectionPool(host='127.0.0.1', port=6379, max_connections=1000)
```

```python
2.myauth
from static.utils.MYredis import POOL
import redis


class LoginAuth:
    def authenticate(self, request):
        token = request.query_params.get('token')
        # 判断是否前端传来token
        if not token:
            raise exceptions.APIException('用户不合法')
        # 查出token对象
        conn = redis.Redis(connection_pool=POOL)
        b_username = conn.get(token)
        # 判断redis中是否存在这个token
        if not b_username:
            raise exceptions.APIException('用户不合法')
        username = b_username.decode('utf-8')
        user = User.objects.filter(name=username).first()
        # 判断数据库中是否有这个用户
        if user:
            return user, username
        raise exceptions.APIException('用户不存在')
```

```python
3.视图中
class Login(ViewSetMixin, APIView):

    def login(self, request, *args, **kwargs):
        name = request.data.get('username')
        password = request.data.get('password')
        user = User.objects.filter(name=name, password=password).first()
        if user:
            token = uuid.uuid4()
            # UserToken.objects.update_or_create(user=user, defaults={'token': token})
            conn = redis.Redis(connection_pool=POOL)
            # uuid需要转成字符串格式，才能存入到redis中,超时时间为60s，存在则不更新
            conn.set(str(token), name, ex=60, nx=True)
            response.msg = '登录成功'
            response.token = token
            response.name = name
        else:

            response.status = 101
            response.msg = '用户名或密码错误'
        return response.magic_response
```



##### 二.封装response

```python
from rest_framework.response import Response


class Myresponse:
    def __init__(self):
        self.status = 100
        self.msg = None
        # self.dict = None

    @property
    def magic_response(self):
        return Response(self.__dict__)

# 任何位置导入，只执行一次模块代码，实现单例
response = Myresponse()

```

##### 三.购物车存redis，redis中数据结构设计

```json
# shopping_1用户的id
shopping_1:{
    "status": 103,
    "msg": "查询成功",
    "data": {
        # 课程的id
        "1": {
            "title": "python从入门到放弃",
            "img": "/media/img/lhf.jpeg",
            "default_policy": "2", # 默认价格策略的id
            "policy": {
        		# 价格策略id
                "1": {
                    "policy": 1,
                    "period_display": "1周",
                    "price": 9.9
                },
                "2": {
                    "policy": 2,
                    "period_display": "1个月",
                    "price": 19.9
                },
                "3": {
                    "policy": 3,
                    "period_display": "3个月",
                    "price": 29.9
                }
            }
        },
        "2": {
            "title": "linuc架构",
            "img": "/media/img/alax.jpeg",
            "default_policy": "4",
            "policy": {
                "4": {
                    "policy": 4,
                    "period_display": "1周",
                    "price": 8.8
                },
                "5": {
                    "policy": 5,
                    "period_display": "1个月",
                    "price": 18.8
                }
            }
        }
    }
}
```

#### 四.秒杀系统：一定要加锁