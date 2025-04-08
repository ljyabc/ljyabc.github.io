---
title: python面向对象
tags: [python进阶]
date: 2019-03-14 21:32:59
categories: 理解
photos:
---

## 面向过程编程

```
核心过程二字，过程指的是解决问题的步骤，即先干什么、再干什么、然后干什么...
基于该思想编写程序就好比在设计一条流水线，是一种机械式的思维方式
```

```
优点
    复杂的问题流程化、进而简单化
缺点
    扩展性极差
```

## 面向对象编程

{% pdf  面向对象编程.pdf %}

### 类

{% pdf  类.pdf %}

### 属性查找

```python
def __init__(self, x, y, z): #会在调用类时自动触发
```

### 绑定方法

在类内部定义的函数（没有被任何装饰器修饰的），默认就是绑定给对象用的:精髓在于会自动将对象传入,当成第一个参数 self

```python
class OldboyStudent:
    school='oldboy'

def __init__(self, x, y, z): #会在调用类时自动触发
    self.name = x #stu1.name='耗哥'
    self.age = y  #stu1.age=18
    self.sex = z #stu1.sex='male'

def choose_course(self,x):
    print('%s is choosing course' %self.name)

def func(self):
    pass
# 类名称空间中定义的数据属性和函数属性都是共享给所有对象用的
# 对象名称空间中定义的只有数据属性，而且时对象所独有的数据属性

stu1=OldboyStudent('耗哥',18,'male')
stu2=OldboyStudent('猪哥',17,'male')
stu3=OldboyStudent('帅翔',19,'female')
```

- 在类内部定义的函数如果被装饰器@classmethod装饰，
  那么则是绑定给类的，应该由类来调用，类来调用就自动将类当作第一个参数自动传入
- 非绑定:[br/>类中定义的函数如果被装饰器@staticmethod装饰，那么该函数就变成非绑定方法
  既不与类绑定，又不与对象绑定，意味着类与对象都可以来调用
  但是无论谁来调用，都没有任何自动传值的效果，就是一个普通函数]

### 类即类型

```python
#在python3中统一了类与类型的概念，类就是类型
class OldboyStudent:
    school='oldboy'

    def __init__(self, x, y, z): #会在调用类时自动触发
        self.name = x #stu1.name='耗哥'
        self.age = y  #stu1.age=18
        self.sex = z #stu1.sex='male'

    def choose_course(self,x):
        print('%s is choosing course' %self.name)

stu1=OldboyStudent('耗哥',18,'male')
# stu1.choose_course(1) #OldboyStudent.choose_course(stu1,1)
# OldboyStudent.choose_course(stu1,1)


l=[1,2,3] #l=list([1,2,3])
# print(type(l))
# l.append(4) #list.append(l,4)
list.append(l,4)
print(l)
```

### 新式类

​    但凡继承了object的类以及该类的子类，都是新式类

### 经典类

​    没有继承object的类以及该类的子类，都是经典类

```
在python3中都是新式类，只有在python2中才区别新式类与经典类
```

### 继承与派生

#### 查看继承关系

{% pdf 继承与派生.pdf %}

```python
#派生：子类中新定义的属性，子类在使用时始终以自己的为准
class OldboyPeople:
    school = 'oldboy'
    def __init__(self,name,age,sex):
        self.name = name #tea1.name='egon'
        self.age = age #tea1.age=18
        self.sex = sex #tea1.sex='male'



class OldboyStudent(OldboyPeople):
    def choose_course(self):
        print('%s is choosing course' %self.name)


class OldboyTeacher(OldboyPeople):
    #            tea1,'egon',18,'male',10
    def __init__(self,name,age,sex,level):
        # self.name=name
        # self.age=age
        # self.sex=sex
        OldboyPeople.__init__(self,name,age,sex)
        self.level=level

    def score(self,stu_obj,num):
        print('%s is scoring' %self.name)
        stu_obj.scoe=99

stu1=OldboyStudent('耗哥',18,'male')
tea1=OldboyTeacher('egon',18,'male',10)

#对象查找属性的顺序：对象自己-》对象的类-》父类-》父类。。。
# print(stu1.school)
# print(tea1.school)
# print(stu1.__dict__)
# print(tea1.__dict__)

tea1.score(stu1,99)
print(tea1.__dict__)
print(stu1.__dict__)


# 在子类派生出的新功能中重用父类功能的方式有两种：
#1、指名道姓访问某一个类的函数：该方式与继承无关
```

### 组合

比如老师需要给学生打分需要把学生对象添加到老师方法里面,该方法修改学生的分数属性

比如课程对象添加到老师对象和学生对象的属性里面,老师对象和学生对象就有了改课程对象的方法

#### 在子派生的新方法中重用父类功能的两种方式

```python
Vehicle.__init__(self,name,speed,load,power)
```

```python
#super(Subway,self) 就相当于实例本身 在python3中super()等同于super(Subway,self)
```

### 菱形继承

{% pdf 菱形继承.pdf %}

```python
print(A.mro())
```

找到A类里的继承顺序

[<class '__main__.A'>, <class '__main__.B'>, <class '__main__.E'>, <class '__main__.C'>, <class '__main__.F'>, <class '__main__.D'>, <class '__main__.G'>, <class 'object'>]

##### 保留最后的G最后一次继承

```python
class G(object):
    # def test(self):
    #     print('from G')
    pass

class E(G):
    # def test(self):
    #     print('from E')
    pass

class B(E):
    # def test(self):
    #     print('from B')
    pass

class F(G):
    # def test(self):
    #     print('from F')
    pass

class C(F):
    # def test(self):
    #     print('from C')
    pass

class D(G):
    # def test(self):
    #     print('from D')
    pass

class A(B,C,D):
    def test(self):
        print('from A')
    # pass

obj=A()
print(A.mro())
# obj.test() #A->B->E-C-F-D->G-object
```

```python
# 在子派生的新方法中重用父类功能的两种方式
# 方式一：与继承无关
# 指名道姓法，直接用：类名.函数名
class OldboyPeople:
    school = 'oldboy'

    def __init__(self, name, age, sex):
        self.name = name
        self.age = age
        self.sex = sex

class OldboyStudent(OldboyPeople):
    def __init__(self,name,age,sex,stu_id):
        OldboyPeople.__init__(self,name,age,sex)
        self.stu_id=stu_id

    def choose_course(self):
        print('%s is choosing course' %self.name)


# 方式二：严格以来继承属性查找关系
# super()会得到一个特殊的对象，该对象就是专门用来访问父类中的属性的（按照继承的关系）
# super().__init__(不用为self传值)
# 注意：
# super的完整用法是super(自己的类名,self),在python2中需要写完整，而python3中可以简写为super()
class OldboyPeople:
    school = 'oldboy'

    def __init__(self, name, age, sex):
        self.name = name
        self.age = age
        self.sex = sex

class OldboyStudent(OldboyPeople):
    def __init__(self,name,age,sex,stu_id):
        # OldboyPeople.__init__(self,name,age,sex)
        super(OldboyStudent,self).__init__(name,age,sex)
        self.stu_id=stu_id

    def choose_course(self):
        print('%s is choosing course' %self.name)


stu1=OldboyStudent('猪哥',19,'male',1)
print(stu1.__dict__)

print(OldboyStudent.mro())


# class A:
#     def f1(self):
#         print('A.f1')
#
# class B:
#     def f2(self):
#         super().f1()
#         print('B.f2')
#
# class C(B,A):
#     pass
#
# obj=C()
# print(C.mro()) #C-》B->A->object
# obj.f2()
```

{% pdf  重用父类功能.pdf %}

### 多态

{% pdf 多态.pdf %}

```
1、类的属性和对象的属性有什么区别?'''
#类属性是共有的，任何实例化的对象都能够拿到类属性，而对象属性是对象自己本身的特性。

'''2、面向过程编程与面向对象编程的区别与应用场景?'''
#面向过程是机械化的思维方式，解决问题的步骤是先干什么，后干什么， 把简单的问题流程化进而简单化。代码的扩展性不好
#一般运用在程序不需要经常改变的地方
#面向过程是一种上帝式的思维，解决问题是找一个个的对象，由对象之间相互交互，代码的扩展性好。经常用在需要改动的地方

'''3、类和对象在内存中是如何保存的。'''
#类在定义阶段就会产生一个名称空间，然后将产生的名字放到内存空间中，对象是在实例化过程中产生的名称空间，该名称空间存放对象私有的属性，以及绑定方法。

'''    4、什么是绑定到对象的方法，、如何定义，如何调用，给谁用？有什么特性'''
#类中定义的方法就是给实例化的对象绑定的方法，在类的定义阶段就定义一个函数，函数必须要加上一个参数，用来接收对象本身
#实例化的对象可以直接调用绑定方法，谁来调用就给谁绑定一个方法。
```

### 封装

{% pdf 封装.pdf %}

#### 强制调用

```python
print(People._People__country)
```

### 特性property

{% pdf 特性property.pdf %}

```python
#property装饰器用于将被装饰的方法伪装成一个数据属性，在使用时可以不用加括号而直接引用
class People:
    def __init__(self,name,weight,height):
        self.name=name
        self.weight=weight
        self.height=height

    @property
    def bmi(self):
        return self.weight / (self.height ** 2)
#
peo1=People('egon',75,1.8)

peo1.height=1.85
print(peo1.bmi)
```

#### 查看隐藏封装属性

```python
#
class People:
    def __init__(self,name):
        self.__name=name

    @property # 查看obj.name
    def na(self):
        return '<名字是：%s>' %self.__name

    @na.setter #修改obj.name=值
    def na(self,name):
        if type(name) is not str:
            raise TypeError('名字必须是str类型傻叉')
        self.__name=name

    @na.deleter #删除del obj.name
    def na(self):
        # raise PermissionError('不让删')
        print('不让删除傻叉')
        # del self.__name

peo1=People('egon')
# print(peo1.name)
#
# print(peo1.name)

# peo1.name='EGON'
# print(peo1.name)

# del peo1.na


print(peo1.na)

#
#
#
# class People:
#     def __init__(self,name):
#         self.__name=name
#
#
#     def tell_name(self):
#         return '<名字是：%s>' %self.__name
#
#     def set_name(self,name):
#         if type(name) is not str:
#             raise TypeError('名字必须是str类型傻叉')
#         self.__name=name
#
#     def del_name(self):
#         print('不让删除傻叉')
#
#     name=property(tell_name,set_name,del_name)
#
#
# peo1=People('egon')
#
# print(peo1.name)
# peo1.name='EGON'
# print(peo1.name)
# del peo1.name
class People:
    def __init__(self,name):
        self.__name=name

    @property # 查看obj.name
    def na(self):
        return '<名字是：%s>' %self.__name

    @na.setter #修改obj.name=值
    def na(self,name):
        if type(name) is not str:
            raise TypeError('名字必须是str类型傻叉')
        self.__name=name

    @na.deleter #删除del obj.name
    def na(self):
        # raise PermissionError('不让删')
        print('不让删除傻叉')
        # del self.__name

peo1=People('egon')
# print(peo1.name)
#
# print(peo1.name)

# peo1.name='EGON'
# print(peo1.name)

# del peo1.na
```

### 绑定方法和非绑定方法

{% pdf 绑定方法和非绑定方法.pdf %}

```python
import settings
import uuid

class Mysql:
    def __init__(self,ip,port):
        self.uid=self.create_uid()
        self.ip=ip
        self.port=port

    def tell_info(self):
        print('%s:%s' %(self.ip,self.port))

    @classmethod
    def from_conf(cls):
        return cls(settings.IP, settings.PORT)

    @staticmethod
    def func(x,y):
        print('不与任何人绑定')

    @staticmethod
    def create_uid():
        return uuid.uuid1()

# 默认的实例化方式：类名(..)
obj=Mysql('10.10.0.9',3307)

# 一种新的实例化方式：从配置文件中读取配置完成实例化
# obj1=Mysql.from_conf()
# obj1.tell_info()

# obj.func(1,2)
# Mysql.func(3,4)
# print(obj.func)
# print(Mysql.func)

print(obj.uid)
```

### 判断类

{% pdf 判断类.pdf %}

```python
class Foo:
    pass

obj=Foo()

print(isinstance(obj,Foo))

# 在python3中统一类与类型的概念
# d={'x':1} #d=dict({'x':1} #)

# print(type(d) is dict)
# print(isinstance(d,dict))

# issubclass()


class Parent:
    pass

class Sub(Parent):
    pass

print(issubclass(Sub,Parent))
print(issubclass(Parent,object))
```

### 反射

#### 1、什么是反射

​    通过字符串来操作类或者对象的属性

#### 2、如何用

​    hasattr 有
    getattr 拿
    setattr 改
    delattr 删

```python
class People:
    country='China'
    def __init__(self,name):
        self.name=name

    def eat(self):
        print('%s is eating' %self.name)

peo1=People('egon')


print(hasattr(peo1,'eat')) #peo1.eat

print(getattr(peo1,'eat')) #peo1.eat
print(getattr(peo1,'xxxxx',None))

# setattr(peo1,'age',18) #peo1.age=18
# print(peo1.age)

# print(peo1.__dict__)
# delattr(peo1,'name') #del peo1.name
# print(peo1.__dict__)
# 还行


class Ftp:
    def __init__(self,ip,port):
        self.ip=ip
        self.port=port

    def get(self):
        print('GET function')

    def put(self):
        print('PUT function')

    def run(self):
        while True:
            choice=input('>>>: ').strip()
            print(choice,type(choice))
            if hasattr(self,choice):
                method=getattr(self,choice)
                method()
            else:
                print('输入的命令不存在')

            # method=getattr(self,choice,None)
            # if method is None:
            #     print('输入的命令不存在')
            # else:
            #     method()

conn=Ftp('1.1.1.1',23)
conn.run()
```

## 类中的魔法方法

### 1、str方法

{% pdf str.pdf %}

```python
class People:
    def __init__(self,name,age):
        self.name=name
        self.age=age

    #在对象被打印时，自动触发，应该在该方法内采集与对象self有关的信息，然后拼成字符串返回
    def __str__(self):

# print('======>')

        return '<name:%s age:%s>' %(self.name,self.age)
obj=People('egon',18)
obj1=People('alex',18)
print(obj)  #obj.__str__()
print(obj)  #obj.__str__()
print(obj)  #obj.__str__()
print(obj1)  #obj1.__str__()

d={'x':1} #d=dict({'x':1})
print(d)
```



### 1、del析构方法

{% pdf del.pdf %}

```python
__del__会在对象被删除之前自动触发
class People:
    def __init__(self,name,age):
        self.name=name
        self.age=age
        self.f=open('a.txt','rt',encoding='utf-8')

    def __del__(self):

# print('run=-====>')

# 做回收系统资源相关的事情

        self.f.close()

obj=People('egon',18)

print('主')
```

