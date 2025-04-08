---
title: python函数递归
tags: [python基础]
date: 2019-03-15 16:20:34
categories: 理解
photos:
---

#  python函数递归

## python函数递归思维导图

{% pdf  python函数递归.pdf %}

## 二分法

```python
l=[1,2,10,30,33,99,101,200,301,311,402,403,500,900,1000] #从小到大排列的数字列表

def search(n,l):
    print(l)
    if len(l) == 0:
        print('not exists')
        return
    mid_index=len(l) // 2
    if n > l[mid_index]:
        #in the right
        l=l[mid_index+1:]
        search(n,l)
    elif n < l[mid_index]:
        #in the left
        l=l[:mid_index]
        search(n,l)
    else:
        print('find it')


search(3,l)

实现类似于in的效果
```

## 阶段性练习

> 1、文件内容如下,标题为:姓名,性别,年纪,薪资
>
> egon male 18 3000
> alex male 38 30000
> wupeiqi female 28 20000
> yuanhao female 28 10000
>
> 要求:
> 从文件中取出每一条记录放入列表中,
> 列表的每个元素都是{'name':'egon','sex':'male','age':18,'salary':3000}的形式
>
> 2 根据1得到的列表,取出薪资最高的人的信息
> 3 根据1得到的列表,取出最年轻的人的信息
> 4 根据1得到的列表,将每个人的信息中的名字映射成首字母大写的形式
> 5 根据1得到的列表,过滤掉名字以a开头的人的信息
> 6 使用递归打印斐波那契数列(前两个数的和得到第三个数，如：0 1 1 2 3 4 7...)
>
> 7 一个嵌套很多层的列表，如l=［1,2,[3,[4,5,6,[7,8,[9,10,[11,12,13,[14,15]]]]]]］，用递归取出所有的值

```python
#1
with open('db.txt') as f:
    items=(line.split() for line in f)
    info=[{'name':name,'sex':sex,'age':age,'salary':salary} \
          for name,sex,age,salary in items]

print(info)
#2
print(max(info,key=lambda dic:dic['salary']))

#3
print(min(info,key=lambda dic:dic['age']))

# 4
info_new=map(lambda item:{'name':item['name'].capitalize(),
                          'sex':item['sex'],
                          'age':item['age'],
                          'salary':item['salary']},info)

print(list(info_new))

#5
g=filter(lambda item:item['name'].startswith('a'),info)
print(list(g))

#6
#非递归
def fib(n):
    a,b=0,1
    while a < n:
        print(a,end=' ')
        a,b=b,a+b
    print()

fib(10)
#递归
def fib(a,b,stop):
    if  a > stop:
        return
    print(a,end=' ')
    fib(b,a+b,stop)

fib(0,1,10)


#7
l=[1,2,[3,[4,5,6,[7,8,[9,10,[11,12,13,[14,15]]]]]]]

def get(seq):
    for item in seq:
        if type(item) is list:
            get(item)
        else:
            print(item)
get(l)
```

