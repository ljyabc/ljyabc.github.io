---
title: djang元信息
tags: [lnhdjango基础]
date: 2021-05-05 14:27:46
categories: 理解
photos:
book:
---

# 元信息

## 概念

```python
ORM对应的类里面包含另一个Meta类，而Meta类封装了一些数据库的信息。主要字段如下:
```

## db_table

```python
ORM在数据库中的表名默认是 app_类名，可以通过db_table可以重写表名。
```

## index_together

```python
联合索引。
```

## unique_together

```
联合唯一索引。
```

## ordering

```python
指定默认按什么字段排序。

只有设置了该属性，我们查询到的结果才可以被reverse()。
```

## 实例

```python
实例：
class UserInfo(models.Model):
        nid = models.AutoField(primary_key=True)
        username = models.CharField(max_length=32)

        class Meta:
            # 数据库中生成的表名称 默认 app名称 + 下划线 + 类名
            db_table = "table_name"

            # 联合索引
            index_together = [
                ("pub_date", "deadline"),
            ]

            # 联合唯一索引
            unique_together = (("driver", "restaurant"),)
            
            ordering = ('name',)
            
            # admin中显示的表名称
            verbose_name='哈哈'

            # verbose_name加s
            verbose_name_plural=verbose_name
```

