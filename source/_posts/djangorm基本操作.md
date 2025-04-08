---
title: djangorm基本操作
tags: [lnhdjango基础]
date: 2021-05-05 14:29:49
categories: 理解
photos:
book:
---

# orm的基本操作

## orm的models.py

### 语法格式

```python
class + 类名对应数据库名字(继承models.Model):
	nid属性名对应字段 = models.AutoField一种数据类型(约束和字段长度约束)
```

### 常用字段类型

#### AutoField

```python
一个自动增加的整数类型字段。通常你不需要自己编写它，Django会自动帮你添加字段：id = models.AutoField(primary_key=True)，这是一个自增字段，从1开始计数。如果你非要自己设置主键，那么请务必将字段设置为primary_key=True。Django在一个模型中只允许有一个自增字段，并且该字段必须为主键！
```

#### BooleanField

```python
布尔值类型。默认值是None。在HTML表单中体现为CheckboxInput标签。如果设置了参数null=True，则表现为NullBooleanSelect选择框。可以提供default参数值，设置默认值。
```

#### CharField

```python
最常用的类型，字符串类型。必须接收一个max_length参数，表示字符串长度不能超过该值。默认的表单标签是text input。
```

#### DateField

```python
class DateField(auto_now=False, auto_now_add=False, **options) , 日期类型。一个Python中的datetime.date的实例。在HTML中表现为DateInput标签。在admin后台中，Django会帮你自动添加一个JS日历表和一个“Today”快捷方式，以及附加的日期合法性验证。两个重要参数：（参数互斥，不能共存） auto_now:每当对象被保存时将字段设为当前日期，常用于保存最后修改时间。auto_now_add：每当对象被创建时，设为当前日期，常用于保存创建日期(注意，它是不可修改的)。设置上面两个参数就相当于给field添加了editable=False和blank=True属性。如果想具有修改属性，请用default参数。例子：pub_time = models.DateField(auto_now_add=True)，自动添加发布时间。
```

#### IntegerField

```
一个整数类型,范围在 -2147483648 to 2147483647。
整数类型，最常用的字段之一。取值范围-2147483648到2147483647。在HTML中表现为NumberInput或者TextInput标签。
```

#### TextField

 https://www.liujiangblog.com/course/django/95 

## 补充choice不变的数据

```python
-在模型表中定义mychoice=((1,'男'),(2,'女'),(3,'其他'))
	-在字段上用:dd = models.IntegerField(choices=mychoice)
	-取对应的文字:
		-在视图层:(get_字段名_display())
			sex=author.get_dd_display()
            
            
-模型表中某个字段,可以指定choice,用在选择不经常变的情况,经常变,尽量用数据库
		    user_type=models.ForeignKey(to='Info', to_field='id',db_constraint=False)
			#取出对应的汉字
			# author对象.user_type.name
			mychoice=((1,'男'),(2,'女'),(3,'其他'))
			# dd = models.ForeignKey(to='Info', to_field='id')
			#取出对应的汉字
			dd = models.ForeignKey(choices=mychoice)
```

