---
title: django用户的增删改查
tags: [lnhdjango基础]
date: 2021-04-30 14:14:29
categories: 理解
photos:
book:
---

# django用户的增删改查

## 第一步

### 在app里面写入

```python
import mysql
pymysql.install_as_MySQLdb()
```

## 第二部

### 数据库迁移

```python
python manage.py makemigrations
python manage.py migrate   
```

## 注意

模板的mysql字段的内容 渲染在视图函数 返回的时候就已经传入了模板

模板还没有到前台就完成了，是在reder里面替换的

## 增加图解

![1607675058112](django用户的增删改查\1607675058112.png)

## 删除图解

![1607681086217](django用户的增删改查/1607681086217.png)

![1607681574629](django用户的增删改查/1607681574629.png)

## 添加图解

![1607835579858](django用户的增删改查/1607835579858.png)

## 修改图解

![1607839526868](django用户的增删改查\1607839526868.png)