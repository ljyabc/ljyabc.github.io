---
title: django导入
tags: [lnhdjango基础]
date: 2021-04-30 15:02:52
categories: 理解
photos:
book:
---

# 模板的导入和继承

## 了解

```
浏览器    》》》》》 CDN服务加载静态数据

浏览器 》》》》》》 django服务器加载其他数据
```



## 模版导入

### 模板导入的作用：

```
 写了一个好看的组件,可以复用
```



### 第一步

#### 1写一个模板template_test.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <title>Title</title>
    <style>
        .head {
            height: 60px;
            background: #3c763d;
        }
    </style>
</head>
<body>
<div class="head"></div>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-3">
            <div>
                <div class="panel">
                    <div class="panel-body">
                        守约一号
                    </div>
                    <div class="panel-footer">啊啊啊啊</div>
                    <div class="panel panel-success">
                        <div class="panel-body">
                            守约二号
                        </div>
                        <div class="panel-footer">Panel footer</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">

        </div>
    </div>
</div>

</body>
</html>
```

### 第二步

#### 2.把需要导入的部分放到一个新的文件left.html里面

```html
<div>
                <div class="panel">
                    <div class="panel-body">
                        守约一号
                    </div>
                    <div class="panel-footer">啊啊啊啊</div>
                    <div class="panel panel-success">
                        <div class="panel-body">
                            守约二号
                        </div>
                        <div class="panel-footer">Panel footer</div>
                    </div>
                </div>
            </div>
```

### 第三步

#### 3 在模板中:

```
{%include'模板的名字'%},例子left.html
```

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <title>Title</title>
    <style>
        .head {
            height: 60px;
            background: #3c763d;
        }
    </style>
</head>
<body>
<div class="head"></div>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-3">
            {% include 'left.html' %}
        </div>
        <div class="col-md-6">

        </div>
    </div>
</div>

</body>
</html>
```

## 模板的继承

### 模板继承的作用

一个页面需要之前的效果，只需要改其中的一部分，这就用到了继承

1 写一个母版,留一个可扩展的区域(盒子),可以留多个盒子(留的越多,可扩展性越高)

### 模板的继承使用方法

写一个母版留一个可扩展的区域(盒子),可以留多个盒子(留的越多,可扩展性越高)

#### 1.被继承的base.html

```html
{%block 名字%}
	可以写内容，
{%endblock%}
```

###### 注意

```
这个内容，如果什么都不写只写 了一个{%  extends 'base.html' %}就会显示
```

#### 2.需继承的template2

```
extends记得写{%extends 'base.html'%}
```



```html
{%  extends 'base.html' %}
{%block 名字%}
	如果需要自己的内容也想要base.html内容就写
	{{ block.super }}
{%endblock%}
```

###### 注意

```
盒子和顺序没关系，只要名字对应就可以
```

