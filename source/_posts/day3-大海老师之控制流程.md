---
title: 3.控制流程
tags: [江洋python]
date: 2022-10-23 22:11:34
categories: python核心编程
photos:
book:
---

# 3.控制流程

{% pdf 3图灵python大海老师控制流程.pdf %}

## 1.什么是控制流程

控制流程具体指的控制程序的执行流程，而程序的执行流程分为三种结构:

顺序结构（之前我们写的代码都是顺序结构）

分支结构（用到if判断）

循环结构（用到while循环与for循环）

## 2.if判断

### 1.if判断语法1：if...

if 条件:
    代码体
    code1
    code2
    code3
    ....

#### 语法记忆方法

if+空格+条件+冒号

tab缩进代码体

tab缩进代码体

tab缩进代码体

#### 形象记忆

键盘Q 左边tab

代表电脑需要一个条件进行判断  冒号可以理解成代表计算机要说话了

那么通过tab横向换行确定要说的话

#### 实例

```python
tag = True
#
if tag:
    print('条件满足')
    print('条件满足')
    print('条件满足')
```

### 2.if判断语法2：if...else...

if 条件:
    代码体
    code1
    code2
    code3
    ....
else:
    代码体
    code1
    code2
    code3

#### 实例

```python
tag = 3==4
#
if tag:
    print('条件满足')
    print('条件满足')
    print('条件满足')
else:
    print('条件不满足')
    print('条件不满足')
    print('条件不满足')
#
print('=====和if判断没关系======')
```

### 3.逻辑运算符

#### 逻辑运算and or not

##### 1.and 与

连接左右两个条件,只有在两个条件同时成立的情况下最终结果才为True

###### 快速判断方法

全部都是and的情况下，如果判断到位假后面都是and就没必要看了，就是假

要求全部都是真才是真

```python
name = 'dahai'
num = 20
# T F
print(num>18 and 1>3 and name == 'dahai' and num < 26)
```

##### 2.or 或

连接左右两个条件,但凡有一个条件成立最终结果就为True

###### 快速判断方法

全部都是or的情况下，如果判断到位真后面都是or就没必要看了，就是真

全是假才是假

```python
print(1> 3 or  1 == 1 or 'x' == 'y' or 2 > 4)
```

##### 3.not 非

对条件进行取反

```python
print(not 4> 3)
```

##### 原理

```python
'''
(1) not的优先级最高，就是把紧跟其后的那个条件结果取反，所以not与紧跟其后的条件不可分割

(2) 如果语句中全部是用and连接，或者全部用or连接，那么按照从左到右的顺序依次计算即可

(3) 如果语句中既有and也有or，那么先用括号把and的左右两个条件给括起来，然后再进行运算
'''
```

```python
# print(not 3>1 or 3>1)
# print(3 > 1 or 3 > 1)
# 先 3>1 or 3 >1 得到是 False

# print(not 3>1)
# 先 not 3>1 得到是 True
# not 相当于小学学的乘除法  ，and和or相当于加减法
res = not  False and True           or False or False or True
print(res)
# #2、最好使用括号来区别优先级，这样别人容易读懂你的代码
res1 =  (3>4 and 4>3)or (1==3 and ('x'=='x' or 3>3))
#        F                F        没必要
print(res1)
```

### 4.if 判断条件加上逻辑运算符

```python
cls = 'human'
sex = 'female'
age = 40
if cls == 'human' and sex == 'female' and age > 16 and age < 25:
    print('开始表白....以下省略一万字')
else:
    print('姐姐好')


```

### 5.三目运算  一行代码写 if   else（只能对其有用）

```python
# 三目运算  一行代码写 if   else
#    满足条件的结果 if  条件   else  不满足条件的结果
# 只能对if ... else
a = 10
print('满足条件') if a > 18 else print('不满足条件')

```

### 6.if判断语法3：if...elif...else...：多分枝

```python
#语法3：多分枝
# 强调：if的多分枝=但凡有一个条件成立，就不会再往下判断其他条件了
# elif可以有无限个
# if 条件1:
#     code1
#     code2
#     code3
#     ....
# elif 条件2:
#     code1
#     code2
#     code3
#     ....
# elif 条件3:
#     code1
#     code2
#     code3
#     ....
# ........
# else:
#     code1
#     code2
#     code3
#     ....
# 优先级if最高  elif 依次从上往下 else
# 注意必须要有if


# 如果：成绩>=90，那么：优秀
#
# 如果成绩>=80且<90,那么：良好
#
# 如果成绩>=70且<80,那么：普通
#
# 其他情况：很差

score = int(input('>>>'))
if score >= 90:
    print('优秀')
elif score >= 80:
    print('良好')
elif score >= 70:
    print('普通')
else:
    print('很差')



```

#### 与if并列的区别

```python
# 如果：成绩>=90，那么：优秀
#
# 如果成绩>=80且<90,那么：良好
#
# 如果成绩>=70且<80,那么：普通
#
# 其他情况：很差

score = int(input('>>>'))
if score >= 90:
    print('优秀')
if  90>score >= 80:
    print('良好')
if 80>score >= 70:
    print('普通')
if score < 70:
    print('很差')
# #4个独立的语法1：
# elif 与if并列的区别
# if并列是每个if都是独立的  也就是说每一个if条件 是独立的
# 而elif的条件  是在上个if 或者 上一个elif 不满足的条件下执行的条件

# not in
# 人生的选择
A_parent = ['工程师','医生','警察','歌手']
B_parent = ['工程师']
# 随便选什么职业
C_parent = []

chose = input('招聘>>>')
if chose in A_parent:
    print('小孩A成为了%s' % chose)
if chose in B_parent:
    print('小孩B成为了%s' % chose)
if chose not in C_parent:
    print('小孩C成为了%s' % chose)
```

### 7.if 嵌套

```python
# if 嵌套
# 语法
# if 条件:
#     code1
#     code2
#     code3
#     if 条件:
#           code1
#           code2
#           code3
#     else:
#           code1
#           code2
#           code3
# else:
#     code1
#     code2
#     code3



# if 判断条件加上逻辑运算符
cls = 'human'
sex = 'female'
age = 23
if cls == 'human' and sex == 'female' and age > 16 and age < 25:
    print('开始表白....以下省略一万字')
    is_success = input('女孩输入我愿意').strip()
    if is_success =='我愿意':
        print('在一起')
    else:
        print('我逗你玩呢')
else:
    print('姐姐好')
```

## 3.while循环

```python
'''
1 什么是循环
    循环就是一个重复的过程

2 为何要有循环
    人可以重复的去做某一件事
    程序中必须有一种机制能够控制计算机像人一样重复地去做某一件事

3 如何用循环
'''
```

### 语法

```python
# 语法
# while 条件:
#     code1
#     code2
#     code3
```

#### 1.while + True的情况

条件为满足  一直循环

```python
while True:
    print('111')
    print('222')
```

##### 在登录的情况需要循环 还有判断

```python
# 在登录的情况需要循环 还有判断
db_user = 'dahai'
db_pwd = '123'
while True:
    input_user = input('请输入用户名')
    input_pwd = input('请输入密码')
    if input_user == db_user and input_pwd == db_pwd:
        print('登录成功')
    else:
        print('登录失败')
```

#### 2.while + break: break代表结束本层循环

```python
# while + break: break代表结束本层循环
db_user = 'dahai'
db_pwd = '123'
while True:
    input_user = input('请输入用户名')
    input_pwd = input('请输入密码')
    if input_user == db_user and input_pwd == db_pwd:
        print('登录成功')
        break
    else:
        print('登录失败')
```

#### 3.while + 一个条件范围 不满足这个条件范围就会跳出循环

```python
# while + 一个条件范围 不满足这个条件范围就会跳出循环
# 通过代码体可以结束循环
start = 0
while start < 8:
    start += 1
    print(start)
    print(start)
    print(start)
```

#### 4.while+continue:continue代表结束本次循环

```python
# while+continue:continue代表结束本次循环
# （本次循环continue之后的代码不在运行），直接进入下一次循环
start = 0
while start < 8:
    start += 1
    if start == 4:
        continue
# 跳过了本次循环，
# 后面的代码不走了，直接走下一次循环
# 没有打印4
    print(start)
    # continue
    # 没代码了
# 强调：continue一定不要作为循环体的最后一步代码
```

#### 5.while + else # break # 了解

```python
while + else # break # 了解
n = 0
while n < 6:
    n += 1
    if n == 6:
        break
    print(n)
else:
#     # else的代码会在while循环没有break打断的情况下最后运行
    print('==============')
# # 和循环没任何关系
print('---------------')
```

## 4.if和while结合

```python
# @Author : 大海
# @File : 5.if和while结合.py
# 登录取款程序
# 理解while嵌套
user = '大海'
pwd = '123'
balance = 5000
tag = True
while True:
    # 登录程序
    while tag:
        user1 = input('输入用户名')
        if user != user1:
            print('你输入的用户名错误,请重新输入')
            continue
        pwd1 = input('输入密码')
        if pwd == pwd1:
            print('登录成功')
            break

        else:
            print('密码错误')
    tag = False
    # print('测试')
    # 取款代码
    money  = int(input('输入你的取款金额'))
    if balance >money:
        balance = balance -money
        print('恭喜取走了%s' % money)
        print('还剩%s' % balance)
        break
    else:
        print('余额不足')

```

## 5.for循环

### 1.whlie遍历列表

```python
names = ['dahai','xialuo','guan','xishi']
i = 0
while i < len(names):
    print(names[i])
    # print(i)
    i+=1
```

### 2.for循环遍历列表

```python
names = ['dahai','xialuo','guan','xishi']
for a in names:
    print(a)
```

### 3.for循环遍历字典

```python
namess = {'name1':'dahai','name2':'xialuo','name3':'xishi'}
# # 默认遍历key值
# for i in namess:
#     print(i)
# # 第二种遍历key值
# for i in namess.keys():
#     print(i)
# # # 遍历value值
# for i in namess:
#     # i就是namess的key
#     #     #     # 每次可以取
#     # 通过key取出value
#     print(namess[i])
# 直接取遍历value值
# for i in namess.values():
#     print(i)
# # # 遍历键值对

# for i in namess.items():
#     # 元组
#     print(i)
#     # 取key
#     print(i[0])
#     # 取value
#     print(i[1])
```

### 4.while循环和for循环的区别

for可以不依赖于索引取指，是一种通用的循环取值方式

for的循环次数是由被循环对象包含值的个数决定的，而while的循环次数是由条件决定的

### 5.range的使用

range(起始索引,结束索引,步长)

range(结束索引) # 相当于起始索引是0

```python
# a = range(5)
# print(a)
# print(type(a))
#
# # 它是一个迭代器
# # # 顾头不顾尾
# print(list(a))
# # 为什么不直接变成列表，因为会浪费内存
# print(range(0,10000000000000000000000000000000000000))
# 一般和for循环连用, 循环一次取一次
#  range相当于母鸡下蛋 一次下一个  下了0 1 2 3 4 这5个鸡蛋

# for i in range(0,5):
#     print(i)
#
# # for i in range(0,5,2):
# #     print(i)
# # # 虽然结果一样但是列表浪费内存
# #  列表相当于一筐鸡蛋 一次性就是 0 1 2 3 4 这5个鸡蛋
# for i in [0,1,2,3,4]:
#     print(i)

# 倒叙
for i in range(5,0,-1):
    print(i)
```

### 6.for + break  或者 加continue

```python
# for + break  或者 加continue
namesss = ['dahai','xialuo','xishi','顾安','欢喜']
for n in namesss:
    if n == '顾安':
        # break
        continue
    print(n)
```

### 7.for+else 了解

```python
# for+else 了解
#  else的代码会在for循环没有break打断的情况下最后运行
for i in range(0,10):
    # print(i)
    if i == 4:
        # break
        continue
    print(i)
else:
    print('================')
```

### 8.打印9*9乘法口诀表

```python
# for循环的嵌套
# 打印9*9乘法口诀表
# i是乘数，j是被乘数
# print有一个参数end  默认是\n
# print(1,end=' ')
# print(1,end=' ')
# print(1,end=' ')
# 1 1 1  print(1,end=' ') end空格
# 1  print(1,end='\n')  end\n
# 1
# 1

# 自己控制换行 或者 空格
# i是乘数，j是被乘数
for i in range(1,10):
#     # print('这个是%s是i' % i)
#     # 通过i 的值来决定 j 的个数
    for j in  range(1,i+1):# 每一行打印多少个
        # print('这个是%s是j' % j)
#         # 控制每一行出现的公式的个数
#         # 第1次范围是range(1,2)    i  1      (1,2)    j  1  只循环了一次
#         # 第2次范围是range(1,3)    i  2      (1,3)    j  1  j  2  只循环了二次
#         # 第3次范围是range(1,4)    i  3      (1,4)    j  1  j  2   j  3 只循环了三次
#         # 格式化输出
        print('%s*%s=%s'%(i,j,i*j),end=' ')
#     # 乘法口诀表是在小循环结束的时候换行
    print(end='\n')
```

### 9.for循环去重

```python
# 集合去重
# 局限性
#1、无法保证原数据类型的顺序
#2、当某一个数据中包含的多个值全部为不可变的类型时才能用集合去重
# names = ['dahai','xialuo','xishi','dahai','dahai','dahai']
# s=set(names)
# print(s)
# l = list(s)
# print(l)
# 2、当某一个数据中包含的多个值全部为不可变的类型时才能用集合去重 错误示范
# names = ['dahai','xialuo','xishi','dahai','dahai',{'name':'dahai'},{'name':'dahai'}]
#
# set(names)
# 要用for循环和if判断去重就可以保证顺序和对可变类型去重
# 总结
# 字符串，数字，布尔，复数 都是一个值，改变需要重新赋值，都是不可变类型
# 容器元组是不可变类型，字典，列表，集合都是可变类型

info =[
    {'name':'dahai','age':18},
    {'name':'xialuo','age':78},
    {'name':'xishi','age':8},
    {'name':'dahai','age':18},
    {'name':'dahai','age':18}
]
# 不行
# set(info)


L = []
for i in info:
    # print(i)
    if i not in L:
        L.append(i)
# print(L)

info = L
print(info)

# 恭喜 同学们完成了第二关 控制流程

```

