---
title: day6大海老师之函数高级
tags: [图灵python]
date: 2022-10-24 15:20:23
password: tulingdahai
categories: python核心编程
photos:
book:
---

![图灵logo](day6购物车与异常/图灵logo.png)

# day6大海老师之函数高级

{% pdf 5图灵python大海老师函数高级.pdf %}

## 1.有名函数

```python
# @Author : 大海
# @File : 1.有名函数.py

# print('aaa')
# print('aaa')
def run(x,y):
    # print(x)
    # x=x+1
    # print(y)
    print(x+y)
    # return x+y
# print(run)
# print(run(1, 2))
run(1,2)
# print('aaa')
```

#### 断点

```python
# 断点

# 启动断点 鼠标右键 点击debug
# ctrl + F5 重启程序
# ctrl + F2 停止
# F9 绿色的三角形是调到下一个断点
# F8 蓝色朝下的箭头是单步走
# Alt +shift+F7蓝色朝右下角的箭头是进入函数自己定义的函数,
# F7蓝色朝右下角的箭头是进入函数
# shift + F8跳出函数
# Alt+F8  搜索数据
```

## 2.匿名函数

### 2.1.匿名函数的含义

就是没有名字的函数

### 2.2.为何要用

用于仅仅临时使用一次的场景，没有重复使用的需求

### 2.3.使用

匿名函数，除了没有名字其他的都有

##### 语法

lambda空格+参数+冒号+函数体代码(表达式或者函数)

###### 一行代码图省事

##### 匿名函数的定义

lambda x,y 形参 x+y 返回值

```python
print(lambda x, y: x + y)
```

##### 匿名函数的调用

调用直接内存地址加括号（它虽然没有名字）+括号可以调用

###### 表达式

```python
print((lambda x, y: x + y)(1, 2))
```

###### 函数

```python
(lambda x, y: print(x + y))(1, 2)
```

###### 把内存地址赋值给一个变量没有意义

```python
print(lambda x, y: x + y)

# 把内存地址赋值给一个变量没有意义
# 匿名函数的精髓就是没有名字，为其绑定名字是没有意义的

f=lambda x, y: x + y
# # print(f)
print(f(1, 2))
```

### 2.4匿名函数与内置函数结合使用

```python
# max,min,sorted
salaries= {
    'xialuo':3000000,
    'xishi':30000,
    'dahai':3000
}

```

#### 1.max（可迭代对象）

```python
list1 = [1,3,5,2]
salaries= {
    'xialuo':3000000,
    'xishi':30000,
    'dahai':3000
}

# max(可迭代对象)
# 底层按照for循环遍历进行比较
print(max(list1))
print(max(salaries))
```

#### 2.max(可迭代对象,key = 函数名)

```python
# 我们要比较的是薪资 求薪资最高的那个人名：即比较的是value，但取结果是key

# 该函数的返回值作为比较规则
def run(name):
    return salaries[name]

# max(可迭代对象,key = 函数名)
# 这个key = 函数名 参数可以改变max的比较规则

# 底层
for i in salaries:
    # 改变了比较的值
    print(run(i))
    
# max的返回值性质没变，还是返回字典的key
print(max(salaries,key = run))
print(min(salaries,key = run))


```

##### 写成匿名函数

```python
# 求最大值
print(max(salaries, key=lambda name:salaries[name]))
# 求最小值
print(min(salaries, key=lambda name:salaries[name]))

# 排序
nums = [11,33,22,9,1]

res = sorted(nums,reverse=True)
print(res)


# 循环遍历薪资
for v in salaries.values():
    print(v)
# 要返回人名
print(sorted(salaries.values(),reverse=True))
print(sorted(salaries.values(),reverse=False))


# 求最大值
print(max(salaries, key=lambda name:salaries[name]))

# 但是我们是要比较薪资，返回的却是人名
# 薪资反序
print(sorted(salaries,key=lambda name:salaries[name],reverse=True))
print(sorted(salaries,key=lambda name:salaries[name],reverse=False))
```

## 3.列表生成式与字典生成式

### 列表生成式

```python
# 列表生成式
# L = []
# for i in range(1,10):
#     L.append(i)
# print(L)

# L1 = [i for i in range(1,10)]
# print(L1)

# L1 = [i * 3 for i in range(1,10)]
# print(L1)
# L1 = [i * 3 for i in range(1,10)if i % 2 == 0]
# print(L1)
```

### 列表生成式排序

```python
# 列表生成式排序
ts_file = ['2.ts','3.ts','1.ts','4.ts','5.ts','6.ts','8.ts','10.ts','11.ts']
# print(sorted(ts_file))
# 把后缀 .ts 去掉  变成int类型
int_test=[int(i.replace('.ts','')) for i in ts_file]
print(int_test)
# 排序
s1=sorted(int_test)
print(s1)
# 变成str类型   把后缀 .ts 加上
s2=[str(i)+'.ts' for i in s1]
print(s2)

print([str(i) + '.ts' for i in sorted([int(i.replace('.ts', '')) for i in ts_file])])
```

### 字典生成式

```python
# 字典生成式

dict1={k+'aaa':v for k,v in {'name':'大海','age':18}.items() if k == 'age'}
print(dict1)
```









## 3.递归函数

### 3.1.什么是递归函数

函数的递归调用是函数嵌套调用的一种特殊形式,
    在调用一个函数的过程中又直接或者间接地调用该函数
本身,称之为函数的递归调用
递归死循环是没有意义的

#### 递归调用必须有两个明确的阶段:

1. 回溯: 一次次递归调用下去,说白了就一个重复的过程,
       但需要注意的是每一次重复问题的规模都应该有所减少,
       直到逼近一个最终的结果,即回溯阶段一定要有一个明确的结束条件
2. 递推: 往回一层一层推算出结果

```python
def foo(n):
    print('from foo',n)
    foo(n+1)
foo(0)

# A同学  B同学 C同学 D同学 E同学
# 第五个人年龄为第4个人加2岁
'''
age(5) = age(4) + 2
age(4) = age(3) + 2
age(3) = age(2) + 2
age(2) = age(1) + 2
age(1) = 18
'''
# 第几个人定义成n
'''
age(n) = age(n-1) + 2     # n>1
age(n) = 18               # n=1
'''
# # 递归调用就是一个重复的过程,但是每一次重复问题的规模都应该有所减少,
# # # 并且应该在满足某种条件的情况下结束重复,开始进入递推阶段
def age(n):
#
    if n == 1:
#         #               所以要在这里写递归结束条件
#         #         # #     #     # 在这个找到条件并且导致函数不再自己调用自己的时候
#         #         # #     #     # 叫做回溯   左边
#         #         # 从结束条件一步步进行返回的结果
#         #         # #     #     # 叫做递推   右边
#         #         #              第一次  # age(5)=age(4)+2                  26
#         #         # #     #     # 第二次   age(4)=age(3)+2                 24
#         #         # #     #     # 第三次 # age(3)=age(2)+2                 22
#         #         # #     #     # 第四次 # age(2)=age(1)+2                 20
#         #         # #     #     # 但是我们不知道age(1)是多少
#         #         # #     #     # 第五次 age(1)=18                    递推  18
        return 18
    if n>1:
        return age(n-1) + 2
#
print(age(5))


# 把里面的数字取出来
L = [1,[2,[3,[4,[5,[6,[7,[8,[9,]]]]]]]]]
# 循环需要考虑次数
for n in L:
    # print(n)
    if type(n) is not  list:
        print(n,'第一层')
    else:
        # print(n)
        # [2, [3, [4, [5, [6, [7, [8, [9]]]]]]]]
        for n in n:
            if type(n) is not list:
                print(n,'第二层')
            else:
#
                # [3, [4, [5, [6, [7, [8, [9]]]]]]]
                for n in n:
                    if type(n) is not list:
                        print(n, '第三层')
                    else:
                        print(n, '第三层')


def search(L):
    for n in L:
        # print(n)
        # 当n 有9
        if type(n) is not list:
            print(n)
        else:
            # print(n)
            # [2, [3, [4, [5, [6, [7, [8, [9]]]]]]]]

            search(n)

search(L)

# 递归是函数的定义里面嵌套函数的调用
# 递归与循环的区别，循环每一次都要判断，需要考虑多少次  *****
# 而递归只需要确定结束条件就行，按照规律进行重复调用，不需要考虑次数
```

## 4.闭包函数

#### 4.1.回顾函数基础

```python
# 编程来源于生活
# 1、什么是函数？ *****
# 在程序中,函数就具备某一功能的工具事先将工具准备好   锤子  扳手   工厂
# 即函数的定义遇到应用场景拿来就用即函数的调用所以务必记住：
# 函数的使用必须遵循先定义,后调用的原则（先制造了工具，工具才能使用）
name = 'dahai'
print(name)
# 2、为何要用函数 不用函数产生问题是：
# 1、程序冗长
#
# 2 程序的扩展性差
#
# 3 程序的可读性差

# 3.如何用函数:
# 1、函数定义阶段: *****
# 只检测函数体的语法( 工厂合不合格)，不执行函数体代码 （不使用工厂）
# def 函数名+括号+冒号
# # # 缩进+体代码
def factory(): # 制造一个工厂
#     '''
#     注释：制造手机的工厂
#     :return:
#     '''
    print('正在制造手机')  # 代码相当于员工和机器
    print('正在制造手机')  # 代码相当于员工和机器
    print('正在制造手机')  # 代码相当于员工和机器
# # # # # # 2、函数调用阶 段: *****
# # # # # # 函数的调用：函数名加括号
# # # # # # 1 先找到名字   (找到工厂的位置)
# # # # # # 2 根据名字调用代码   ( 加了括号执行工厂进行加工)
 # 1 先找到名字   (找到工厂的位置)
print(factory)
factory()
factory()
factory()
```

#### 4.2.闭包函数

##### 1.闭包的作用

保证数据安全

###### 1.全局的情况

```python
name = '大海'
print(name)
name = '小红'
print(name)
```

虽然全局可以用，但是却可以直接修改，所以数据不安全

###### 2.一个函数局部的情况

```python
def outer():
    name = '大海'
outer()
# 无法引用
print(name)
```

如果直接放到函数里面，数据是安全了，但是无法引用

所以就需要一种方法做到，既能引用函数里面的变量，又能保证这个变量不被修改

所以就想到了一种嵌套函数的办法，它就是闭包的结构，我们一起来认识一下

##### 2.闭包的结构

###### 1.闭包的概念

闭指的是:该函数是一个内部函数

包指的是:指的是该内部的函数名字在外部被引用

###### 2.构成条件:

1.函数嵌套前提

2.外部函数返回内部函数名

3.内部函数使用外部函数的变量

###### 3.闭包获得内层函数的内存地址

```python
def outer():
    print('外面的函数正在运行')
    def inner():
        print('里面的函数正在运行')
    return inner
inner=outer() 
inner()
```

###### 4.闭包获得内层返回值，该返回值是外层函数内的变量名

外层函数内的变量名被称为：非全局变量，也叫做自由变量

这个自由变量会和内层函数形成一种绑定关系

自由变量不会和全局变量产生冲突，所以保证了数据安全

```python
def outer():
    # 自由变量
    name = '大海'
    print('外面的函数正在运行')
    def inner():
        print('里面的函数正在运行')
        return name
    return inner
inner=outer() 
inner()
```

#### 计算大海多次跑步的平均路程

```python
#　计算大海多次跑步的平均路程
def outer():
    # 自由变量
    L1 = []
    def inner(s):
        L1.append(s)
        # print(L1)
        # print(sum(L1))
        total=sum(L1)
        count = len(L1)
        # print(L1)
        # print(count)
        avg_s=total/count
        print(id(L1))
        return avg_s
    return inner
inner=outer()

print(inner(1000))
print(inner(1050))
print(inner(1030))
print(inner(1070))
inner=outer()
print(inner(1000))
```

















