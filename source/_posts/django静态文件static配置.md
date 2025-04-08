---
title: django静态文件static配置
tags: [lnhdjango基础]
date: 2021-04-30 15:04:15
categories: 理解
photos:
book:
---

# 静态文件static配置

## 1 写死静态文件

```html
<link rel="stylesheet" href="/static/css/mycss.css">
```

## 2 使用 static标签函数:

```html
-{%load static%}
#static返回值,会拼上传参的路径
-{% static "传参"%}
```

## 3 使用get_static_prefix 标签

```html
-{%load static%}
#get_static_prefix返回值是:静态文件的地址,相当于/static/
-{% get_static_prefix %}css/mycss.css
```

