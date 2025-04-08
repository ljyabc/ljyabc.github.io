---
title: python表达式
tags: [python基础]
date: 2019-03-14 23:08:37
categories: 记忆
photos:
---

## 各种表达式



### 三元表达式

三元表达式实现的效果就是:条件成立的情况下返回一个值,不成立的情况下返回另外一种值

​	三元表达式实现的效果就是:条件成立的情况下返回一个值,不成立的情况下返回另外一种值
	res="SB" if name == 'lqz' else "NB"

### 列表生成式

​	l=[name for name in names if name.endswith('sb')]

### 字典生成式

​	dic={k:vals[i] for i,k in enumerate(keys) if i > 0}

{% pdf 各种表达式.pdf %}

## 内置函数

{% pdf 内置函数.pdf %}

## 匿名函数(lambda)

没有名字的函数，仅仅临时使用一次的场景，没有重复使用的需求

### 匿名函数与内置函数结合使用

```python
res=max(salaries,key=lambda name:salaries[name])
res=min(salaries,key=lambda name:salaries[name])
res=sorted(salaries,key=lambda name:salaries[name],reverse=True)
res = map(lambda name: name + "dSB", names)
res=filter(lambda name:name.endswith('sb'),names)
from functools import reduce
res=reduce(lambda x,y:x+y,l,'A')
```

{% pdf 匿名函数.pdf %}  