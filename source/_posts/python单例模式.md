---
title: python单例模式
tags: [python进阶]
date: 2019-03-16 13:55:16
categories: 理解
photos:
---

# 单例模式

多次实例化的结果指向同一个实例 

## 单例模式的实现方式一：(绑定类的方法) 

```python
import settings
 
class Mysql:
    __instance = None
 
    def __init__(self, IP, PORT):
        self.IP = IP
        self.PORT = PORT
 
 
    @classmethod
    def from_conf(cls):
        if cls.__instance is None:
            cls.__instance=cls(settings.IP,settings.PORT)
 
        return cls.__instance
 
obj1 = Mysql.from_conf()
obj2 = Mysql.from_conf()
obj3 = Mysql("1.1.1.3","2206")
 
print(obj1)  #<__main__.Mysql object at 0x0000000002708278>
print(obj2)  #<__main__.Mysql object at 0x0000000002708278>
print(obj3)  #<__main__.Mysql object at 0x0000000002708550>
 
 
 
 
 
#settings.py
 
IP="1.1.1.2"
PORT= "3306"

```



## 单例模式的实现方式二：（@singleton装饰器） 

```python
def singleton(cls):
    _instance=cls(settings.IP,settings.PORT)
    def wrapper(*args,**kwargs):
        if len(args)!=0 or len(kwargs)!=0:
            obj=cls(*args,**kwargs)
            return obj
        return _instance
    return wrapper
 
 
@singleton  #Mysql=singleton(Mysql) Mysql=wrapper
class Mysql:
    def __init__(self,IP,PORT):
        self.IP=IP
        self.PORT=PORT
 
obj1=Mysql()
obj2=Mysql()
obj3=Mysql()
obj4=Mysql("1.1.1.2",2206)
 
print(obj1) #<__main__.Mysql object at 0x0000000002578278>
print(obj2) #<__main__.Mysql object at 0x0000000002578278>
print(obj3) #<__main__.Mysql object at 0x0000000002578278>
print(obj4) #<__main__.Mysql object at 0x0000000002578588>

```

## 单例模式的实现方式三：(元类) 

```python
import settings
class Mymeta(type):
    def __init__(self,class_name,class_bases,class_dic):
        #self 是Mysql这个类
        self._instance=self(settings.IP,settings.PORT)
 
 
    def __call__(self, *args, **kwargs):
        if len(args)!=0 or len(kwargs)!=0:
            # self 是Mysql这个类
            obj=self.__new__(self)
            self.__init__(obj,*args,**kwargs)
            return obj
        else:
            return self._instance
 
 
 
 
 
class Mysql(object,metaclass=Mymeta):  #Mysql=Mymeta(....)
    def __init__(self,IP,PORT):
        self.IP=IP
        self.PORT=PORT
 
 
obj1=Mysql()
obj2=Mysql()
obj3=Mysql("1.1.1.3",6609)
 
 
print(obj1) #<__main__.Mysql object at 0x00000000021D8550>
print(obj2) #<__main__.Mysql object at 0x00000000021D8550>
print(obj3) #<__main__.Mysql object at 0x00000000021D8550>

```

## 单例模式的实现方式四：(导模块 --第一次导模块会创造名称空间，第二次导直接用第一次造好的名称空间) 

```python
#singleton.py
import settings
 
 
class Mysql:
    def __init__(self, IP, PORT):
         self.IP = IP
         self.PORT = PORT
 
instance=Mysql(settings.IP,settings.PORT)
 
#settings.py
IP="1.1.1.2"
PORT= "3306"
 
def f1():
   from singleton import  instance
   print(instance)  #<singleton.Mysql object at 0x00000000021B8630>
 
def f2():
   from singleton import  instance,Mysql
   print(instance)   #<singleton.Mysql object at 0x00000000021B8630>
   obj=Mysql("1.1.1.6",3306)
   print(obj)  #<singleton.Mysql object at 0x0000000002104978>
 
f1()
f2()

```

