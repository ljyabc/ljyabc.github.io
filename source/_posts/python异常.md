---
title: python异常
tags: [python基础]
date: 2019-03-16 23:15:48
categories: 记忆
photos:
---

#  python异常

{% pdf 异常.pdf %}

## 一般异常

```python
IndexError
l=['a','b']
l[100]

KeyError
d={'a':1}
d['b']

AttributeError:       # 属性错误
class Foo:
    pass

Foo.x
import os
os.aaa


ZeroDivisionError         # 除零错误
1 / 0


FileNotFoundError
f=open('a.txt','r',encoding='utf-8')

ValueError: I/O operation on closed file.
f=open('a.txt','r',encoding='utf-8')
f.close()
f.readline()

ValueError: invalid literal for int() with base 10: 'aaaaa'
int('aaaaa')


TypeError         # 类型错误
for i in 333:      # 333是不可迭代错误
    pass

NameError      # 定义错误
x
func()




def func():
    import os
    os.xxxx

func()
```

## 捕获处理异常

```python
语法：

单分支
try:
    print('start.....')
    x=1
    y
    l=[]
    l[3]
    d={'a':1}
    d['b']
    print('end....')
except NameError:
    print('变量名没有定义')


print('other.....')



多分支
try:
    print('start.....')
    x=1
    # y
    l=[]
    l[3]
    d={'a':1}
    d['b']
    print('end....')
except NameError:
    print('变量名没有定义')
except KeyError:
    print('字典的key不存在')
except IndexError:
    print('索引超出列表的范围')


print('other.....')




多种异常采用同一段逻辑处理
try:
    print('start.....')
    x=1
    # y
    l=[]
    # l[3]
    d={'a':1}
    d['b']
    print('end....')
except (NameError,KeyError,IndexError):
    print('变量名或者字典的key或者列表的索引有问题')


print('other.....')


万能异常
try:
    print('start.....')
    x=1
    # y
    l=[]
    # l[3]
    d={'a':1}
    # d['b']
    import os
    os.aaa
    print('end....')
except Exception:
    print('万能异常---》')


print('other.....')



获取异常的值
try:
    print('start.....')
    x=1
    y
    l=[]
    l[3]
    d={'a':1}
    d['b']
    import os
    os.aaa
    print('end....')
except Exception as e:
    print('万能异常---》',e)


print('other.....')




try:
    print('start.....')
    x=1
    # y
    l=[]
    l[3]
    d={'a':1}
    d['b']
    import os
    os.aaa
    print('end....')
except NameError as e:
    print('NameError: ',e)

except KeyError as e:
    print('KeyError: ',e)

except Exception as e:
    print('万能异常---》',e)


print('other.....')



try....else...
else: 不能单独使用，必须与except连用，意思是：else的子代码块会在被检测的代码没有出现过任何异常的情况下执行

try:
    print('start.....')
    # x=1
    # # y
    # l=[]
    # l[3]
    # d={'a':1}
    # d['b']
    # import os
    # os.aaa
    print('end....')
except NameError as e:
    print('NameError: ',e)

except KeyError as e:
    print('KeyError: ',e)

except Exception as e:
    print('万能异常---》',e)

else:
    print('在被检测的代码块没有出现任何异常的情况下执行')
print('other.....')


try...finally....
try:
    print('start.....')
    # x=1
    # # y
    # l=[]
    # l[3]
    # d={'a':1}
    # d['b']
    # import os
    # os.aaa
    print('end....')
except NameError as e:
    print('NameError: ',e)

except KeyError as e:
    print('KeyError: ',e)

except Exception as e:
    print('万能异常---》',e)

else:
    print('在被检测的代码块没有出现任何异常的情况下执行')
finally:
    print('无论有没有异常发生，都会执行')
print('other.....')




finally的子代码块中通常放回收系统资源的代码
try:
    f=open('a.txt',mode='w',encoding='utf-8')
    f.readline()

finally:
    f.close()

print('other....')
```

## 主动触发异常

```python
raise TypeError('类型错误')

class People:
    def __init__(self,name):
        if not isinstance(name,str):
            raise TypeError('%s 必须是str类型' %name)

        self.name=name

p=People(123)
```

## 断言

```python
print('part1........')
# stus=['egon','alex','wxx','lxx']
stus=[]


# if len(stus) <= 0:
#     raise TypeError
assert len(stus) > 0

print('part2.........')
print('part2.........')
print('part2.........')
print('part2.........')
print('part2.........')
print('part2.........')
```

## 自定义异常

```python
class RegisterError(BaseException):
    def __init__(self,msg,user):
        self.msg=msg
        self.user=user

    # def __str__(self):
#   在对象被打印时，自动触发，应该在该方法内采集与对象self有关的信息，然后拼成字符串返回
#         return '<%s：%s>' %(self.user,self.msg)

raise RegisterError('注册失败','teacher')
```

```python
age=input('>>: ').strip() #age='aaa'

if age.isdigit():
    age=int(age)

    if age > 10:
        print('too big')
    elif age < 10:
        print('too small')
    else:
        print('you got it')
```