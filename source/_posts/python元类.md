---
title: python元类
tags: [python进阶]
date: 2019-03-16 14:46:47
categories: 理解
photos:
---

# python元类

{% pdf 元类.pdf %}

## 一.什么是元类

一切源自于一句话：python中一切皆为对象，让我们先定义一个类，然后逐步分析 

```python
class Oldboystudent:
     def __init__(self,name,age,sex):
        self.name=name
        self.age=age
        self.sex=sex
 
     def score(self):
        print("%s hahahha" %self.name)
 
 
 
 stu1=Oldboystudent("egon",18,"male")
 stu1.score()

```

所有的对象都是实例化或者说调用类而得到的（调用类的过程称为累的实例化），比如对象stu1是用类Oldboystudent得到的 

如果一切皆为对象，那么类Oldboystudent本质也是一个对象，既然所有的对象都是调用类得到的，那么Oldboystudent必然也是调用了一个类得到的，这个类称为元类 

于是我们可以推导出=======>产生Oldboystudent的过程一定发生了：Oldboystudent=元类(...) 

```python
print(type(Oldboystudent))   #<class 'type'>  结果为<class 'type'>，证明是调用了type这个元类而产生的Oldboystudent，即默认的元类为type

```

## 二.class关键字创建类的流程分析

上文我们基于python中一切皆为对象的概念分析出：我们用class关键字定义的类本身也是一个对象，负责产生该对象的类称之为元类(元类可以简称为类的类),内置的元类为type

class关键字在帮我们创建类时，必然帮我们调用了元类Oldboystudent=type(...).,那调用type时传入的参数是什么呢？必然是类的关键组成部分，一个类有三大组成部分，分别是

1.类名class_name="Oldboystudent"

2.基类们class_bases=(object,)

3.类的名称空间class_dic,类的名称空间是执行类体代码而得到的

调用type时会依次传入以上三个参数

综上，class关键字帮我们创建一个类应该细分为以下四个过程

![img](https://img-blog.csdn.net/20180829210755503?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2x1YW43bGllbQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70) 

补充：exec的用法

exec：三个参数

参数一：包含一系列python代码的字符串

参数二：全局作用域（字典形式），如果不指定，默认为globals()

参数三：局部作用域（字典形式），如果不指定，默认为locals()

可以把exec命令的执行当成是一个函数的执行，会将执行期间产生的名字存放于局部名称空间中

## 三.自定义元类控制类Oldboystudent的创建

一个类没有声明自己的元类，默认它的元类就是type，除了使用内置的元类type，我们也可以通过继承type来自定义元类，然后使用metaclass关键字参数为一个类指定元类 

```python
class Mymeta(type): #只有继承了type类才能称之为一个元类，否则就是一个普通的自定义类
    pass
 
class Oldboystudent(object,metaclass=Mymeta):#Oldboystudent=Mymeta('Oldboystudent',(object),{...})
    school='oldboy'
 
    def __init__(self,name,age):
        self.name=name
        self.age=age
 
    def say(self):
        print('%s says welcome to the oldboy to learn Python' %self.name)

```

```
自定义元类可以控制类的生产过程，类的产生过程其实就是元类的调用过程，即Oldboystudent=Mymeta('Oldboystudent',(object),{...})

调用Mymeta会先产生一个空对象Oldboystudent，然后连同调用Mymeta括号内的参数一同传给Mymeta下的__init__方法，完成初始化，于是我们可以
```

```python
class Mymeta(type): #只有继承了type类才能称之为一个元类，否则就是一个普通的自定义类
    def __init__(self,class_name,class_bases,class_dic):
        # print(self)   #self=Oldboystudent
        # print(class_name)  #Oldboystudent
        # print(class_bases)  #object
        # print(class_dic)    #{..}
        #控制类名必须用驼峰体
        if class_name.islower():
            raise TypeError("类名必须为驼峰体")
        #控制类体里面必须有解释
        doc = class_dic.get('__doc__')
        if doc is None or len(doc) == 0 or len(doc.strip('\n ')) == 0:
            raise TypeError("类体必须有注释")
 
 
class Oldboystudent(object,metaclass=Mymeta):
    school="Oldboy"
 
    def __init__(self,name,age,sex):
        self.name=name
        self.age=age
        self.sex=sex
 
Oldboystudent=Mymeta("Oldboystudent",(object,),{})
 
print(Oldboystudent.__dict__)

```

## 四.自定义元类控制类Oldboystudent的调用

储备知识：

```python
__call__
```

```python
class Foo:
    def __call__(self, *args, **kwargs):
        print(self)
        print(args)
        print(kwargs)
 
obj=Foo()
#1、要想让obj这个对象变成一个可调用的对象，需要在该对象的类中定义一个方法__call__方法，该方法会在调用对象时自动触发
#2、调用obj的返回值就是__call__方法的返回值
res=obj(1,2,3,x=1,y=2) 

```

```python
由上例可知，调用一个对象，就是触发对象所在的类中的__call__方法的执行，如果把Oldboystudent也当做一个对象，那么在Oldboystudent这个对象的类中也必然存在一个__call__方法
```

```python
class Mymeta(type): #只有继承了type类才能称之为一个元类，否则就是一个普通的自定义类
    def __call__(self, *args, **kwargs):   #self=OldboyStudent这个类 args=("ZS,18,"male) kwargs={}
        #先产生一个空对象
        stu_obj=self.__new__(self)  #stu_obj是OldboyStudent这个类的对象
        #执行__init__方法，完成对象的初始化属性操作
        self.__init__(stu_obj,*args,**kwargs)
        #返回初始化好的那个对象
        return stu_obj
 
class OldboyStudent(object,metaclass=Mymeta):
    school = "Oldboy"
    def __init__(self,name,age,sex):
        self.name=name
        self.age=age
        self.sex=sex
 
 
 
stu1=OldboyStudent("ZS",18,"male")
print(stu1.__dict__)

```

```python
默认地，调用stu1=OldboyStudent("ZS",18,"male")会做三件事

1.产生一个空对象stu_obj

2.调用__init__方法初始化对象obj

3.返回初始化好的obj

对应着，OldboyStudent类中的__call__方法也因该做这三件事

上例的__call__相当于一个模板，我们可以在该基础上改写__call__的逻辑从而控制调用OldboyStudent的过程，比如将OldboyStudent的对象的所有的属性都变成私有的
```

## 五.属性查找

结合python继承的实现原理+元类重新看属性的查找应该是什么样子呢？？？

在学习完元类后，其实我们用class自定义的类也全都是对象（包括object类本身也是元类type的 一个实例，可以用type(object)查看），我们学习过继承的实现原理，如果把类当成对象去看，将下述继承应该说成是：对象OldboyStudent继承对象Foo，对象Foo继承对象Bar，对象Bar继承对象object

```python
class Mymeta(type): #只有继承了type类才能称之为一个元类，否则就是一个普通的自定义类
    n=444
 
    def __call__(self, *args, **kwargs): #self=<class '__main__.OldboyTeacher'>
        obj=self.__new__(self)
        self.__init__(obj,*args,**kwargs)
        return obj
 
class Bar(object):
    n=333
 
class Foo(Bar):
    n=222
 
class OldboyStudent(Foo,metaclass=Mymeta):
    n=111
 
    school='oldboy'
 
    def __init__(self,name,age):
        self.name=name
        self.age=age
 
    def say(self):
        print('%s says welcome to the oldboy to learn Python' %self.name)
 
 
print(OldboyStudent.n) #自下而上依次注释各个类中的n=xxx，然后重新运行程序，发现n的查找顺序为O

```

于是属性查找应该分成两层，一层是对象层（基于c3算法的MRO）的查找，另外一个层则是类层（即元类层）的查找 

![img](https://img-blog.csdn.net/20180831105416484?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2x1YW43bGllbQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70) 

```python
查找顺序：
1、先对象层：OldoyStudent->Foo->Bar->object
2、然后元类层：Mymeta->type

```

```python
依据上述总结，我们来分析下元类Mymeta中__call__里的self.__new__的查找 
```

```python
class Mymeta(type): 
    n=444
 
    def __call__(self, *args, **kwargs): #self=<class '__main__.OldboyStudent'>
        obj=self.__new__(self)
        print(self.__new__ is object.__new__) #True
 
 
class Bar(object):
    n=333
 
    # def __new__(cls, *args, **kwargs):
    #     print('Bar.__new__')
 
class Foo(Bar):
    n=222
 
    # def __new__(cls, *args, **kwargs):
    #     print('Foo.__new__')
 
class OldboyStudent(Foo,metaclass=Mymeta):
    n=111
 
    school='oldboy'
 
    def __init__(self,name,age，sex):
        self.name=name
        self.age=age
        self.sex=sex
 
    def say(self):
        print('%s says welcome to the oldboy to learn Python' %self.name)
 
 
    # def __new__(cls, *args, **kwargs):
    #     print('OldboyTeacher.__new__')
 
 
OldboyStudent(ZS',18，“male”) #触发OldboyStudent的类中的__call__方法的执行，进而执行self.__new__开始查找

```

```
总结，Mymeta下的__call__里的self.__new__在OldboyStudent、Foo、Bar里都没有找到__new__的情况下，会去找object里的__new__，而object下默认就有一个__new__，所以即便是之前的类均未实现__new__,也一定会在object中找到一个，根本不会、也根本没必要再去找元类Mymeta->type中查找__new__

我们在元类的__call__中也可以用object.__new__(self)去造对象

```

![img](https://img-blog.csdn.net/20180831110245799?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2x1YW43bGllbQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70) 

```python
**但我们还是推荐在__call__中使用self.__new__（self）去创造空对象，因为这种方式会检索三个类OldboyStudent->Foo->Bar,而object.__new__则是直接跨过了他们三个** 
```

最后说明一点 

```python
class Mymeta(type): #只有继承了type类才能称之为一个元类，否则就是一个普通的自定义类
    n=444
 
    def __new__(cls, *args, **kwargs):
        obj=type.__new__(cls,*args,**kwargs) # 必须按照这种传值方式
        print(obj.__dict__)
        # return obj # 只有在返回值是type的对象时，才会触发下面的__init__
        return 123
 
    def __init__(self,class_name,class_bases,class_dic):
        print('run。。。')
 
 
class OldboyStudent(object,metaclass=Mymeta): #OldboyStudent=Mymeta('OldboyTeacher',(object),{...})
    n=111
 
    school='oldboy'
 
    def __init__(self,name,age):
        self.name=name
        self.age=age
 
    def say(self):
        print('%s says welcome to the oldboy to learn Python' %self.name)
 
 
print(type(Mymeta)) #<class 'type'>
# 产生类OldboyStudent的过程就是在调用Mymeta，而Mymeta也是type类的一个对象，那么Mymeta之所以可以调用，一定是在元类type中有一个__call__方法
# 该方法中同样需要做至少三件事：
# class type:
#     def __call__(self, *args, **kwargs): #self=<class '__main__.Mymeta'>
#         obj=self.__new__(self,*args,**kwargs) # 产生Mymeta的一个对象
#         self.__init__(obj,*args,**kwargs) 
#         return obj

```

## 补充

```python
class Mymeta(type):
    n=444
    def __call__(self, *args, **kwargs):
        obj = self.__new__(self)  # self=Foo
        # obj = object.__new__(self)  # self=Foo
        self.__init__(obj, *args, **kwargs)
        return obj

class A(object):
    n=333
    # pass

class B(A):
    n=222
    # pass
class Foo(B,metaclass=Mymeta):  # Foo=Mymeta(...)
    n=111
    def __init__(self, x, y):
        self.x = x
        self.y = y


print(Foo.n)
#查找顺序：
#1、先对象层：Foo->B->A->object
#2、然后元类层：Mymeta->type


# print(type(object))

# obj=Foo(1,2)
# print(obj.__dict__)
```