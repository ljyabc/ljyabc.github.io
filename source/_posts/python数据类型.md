---
title: python数据类型
tags: [python基础]
date: 2019-03-14 20:45:10
categories: 记忆
photos:
---

# 数据类型

## 引用计数

如果一个变量的引用计数为0,那么就会被python的垃圾回收机制自动回收 

## id和值

```
id相等,值一定相等: 值相等,但id不一定相等(存放值的内存空间相同则值一定相同,值相同但是存放值的内存空间不一定相同)
```

## 字符串

索引,

切片(顾头不顾尾,步长),

len,成员运算(in和not in),

循环 for ,

方法(strip split lower upper startswith endswith join index    迭代**  replace (第一个参数为指定的值,第二个参数 为自己添加的值,第三个参数是选择替换几个(默认是全部替换)) )

isdigit:判断字符串里是不是数字 

isalnum:判断是不是为字母或数字 

isalpha:判断是不是字母组成

 islower:判断是不是全小写组成

 isupper:判断是不是全大写组成

 center:输出结果时可以在左右两边添加符号,第一个参数是多宽,第二个参数是以什么符号 

### 常用操作和内置方法

​	按索引取值
	切片，顾头不顾尾，步长，切片出的字符串是一个全新的字符串，不改变原字符串
	长度len()
	成员运算in和not in
	去掉字符串左右两边的字符，strip，不管中间的
	切分split，针对按照某种分割符组织的字符串，可以切分成列表，进而进行取值
	可以for循环出每个字符
	strip,lstrip,rstrip
	lower()变成小写
	upper()全变成大写
	startswith()判断是否以什么开头
	endswith()判断是否以什么结尾
	format格式化操作
	rsplit反相切分，可以设置切分个数
	join字符串拼接
	replace替换
	isdigit判断是否纯数字
	find找到返回第一个字符的索引位置，否则返回-1
	center字符串居中
	ljust字符串左边添加符号
	rjust字符串右边添加符号
	zfill字符串居中 ，以0填充
	captalize首字母大写
	swapcase反转
	title 每个字符串开头首字母变成大写
	index（）返回索引，不存在就报错
	isalpha字符串中包含的是字母或则中文字符
	isalnum字符串中包含的是字母或中文字符或数字

### 该类型总结

​	存一个值
	有序
	不可变，可hash

格式三种方法:

###### 重点

```python
'my name is {} my age is {}'.format('egon',18)
```

## int--整型

##### **bit_lenth 使用方法:用一个int型例如int后的n  n.bit_length()**

**to_bytes 将数字转换成字节类型：6表示用多少个字节表示，little/big,用于指定生成字节的顺序  result=val.to_bytes(6,'little')**

**from_bytes,将字节转换成数字**

​        **result=b'\x02\x00\x00\x00\x00\x00'**

​        **data=int.from_bytes(result,'little')**

​        **print(data)**

## bool--布尔类型

**True/False** 

​        **False包括:0 {} [] () None**

​        **True:有值或者成功可以是True**

## list--列表

按索引存取值(正向存取+反向存取)：即可存也可以取 

切片(顾头不顾尾，步长) 

len

成员运算in和not in 

循环 for

### 常用操作和内置方法

​	按索引存取值，可存可取，只能根据已知索引去改值，索引不存在即报错
	切片，顾头不顾尾，步长
	长度len
	成员运算in 和 not in
	append追加，在列表末尾
	insert插入
	del删除
	remove指定要删除的值，返回None
	pop从列表中拿走一个值，返回那个值
	可以for循环遍历
	clear清空
	extend添加一个列表，放在列表末尾
	reverse反转列表，本身无返回值
	sort排序，默认从小往大

### copy    深浅拷贝，深拷贝拷贝所有层，浅拷贝只拷贝一层*

​            **name=[1,2,3]**

​            **name.copy()**

​            **这是浅拷贝**

​            **import copy**

​            **li=[11,22]**

​            **li2=copy.deepcopy(li)**

​            **深拷贝**

```python
    ['alex', 'SB', 'wxx', 'lxx', 'egon', 4, 3.1]

    names=['alex','wxx','lxx','egon',4,3.1]
    res=names.remove('wxx')  # 单纯的删掉,是按照元素的值去删除，没有返回值
    print(res)
    print(names)

    None
    ['alex', 'lxx', 'egon', 4, 3.1]

    names=['alex','wxx','lxx','egon',4,3.1]
    res=names.pop(1) #拿走一个值,是按照索引去删除,有返回值
    print(names)
    print(res)

    ['alex', 'lxx', 'egon', 4, 3.1]
    wxx

    names=['alex','wxx','lxx','egon',4,3.1]
    print(names.pop())
    print(names.pop())
    pop: 默认从最后一个开始删除
    3.1
    4

    names=['alex','wxx','lxx','lxx','egon',4,3.1]
    print(names.count('lxx')) #统计个数

    print(names.index('lxx'))

    2
    2

    names.clear() #全部清空
    print(names)

    []

    x=names.copy() #拷贝,把names复制给x
    print(x)

    ['alex', 'wxx', 'lxx', 'lxx', 'egon', 4, 3.1]

    names.extend([1,2,3]) # 加值
    print(names)

    ['alex', 'wxx', 'lxx', 'lxx', 'egon', 4, 3.1, 1, 2, 3]

    names.reverse() # 将结果倒过来输出
    print(names)

    [3.1, 4, 'egon', 'lxx', 'lxx', 'wxx', 'alex']

    names=[1,10,-3,11]
    names.sort(reverse=True) #默认从大到小排列,把reverse改为True就变成从小到大排列
    print(names)

    [-3, 1, 10, 11]
```

## dict--字典

**clear    同列表，字典内容全部清除**

**copy    同列表，深浅拷贝**

**fromkeys    可以生成字典**

​            **val=dict.fromkeys(['k1','k2','k3'],666)**

​            **val['k1']=999**

​            **print(val)**

​            **结果：{'k1':999,'k2':666,'k3':666}**

​            **val=dict.fromkeys(['k1','k2','k3'],[])**

​            **val['k1'].append(666)**

​            **val['k1']=[1,2,3]**

​            **print(val)**

​            **结果：{'k1':[1,2,3],'k2':[666],'k3':[666]}    因为创建这个字典时候用的空列表是同一个内存地址的，而赋值后用了新的地址**

**get    获取值，按照key，如果没获取到还可以有默认值**

**pop    同列表，删除并获取删除的值**

 **item    输出字典所有的键值对**

**keys    输出字典所有的key**

**popitem    pop中制定了key，popitem出来的是元素类型**

**setdefault    添加    列表中有的就不错修改，没有的就添加**

**update    更新**

​            **dic={'k1':'v1','k2':'v2'}**

​            **dic.update({'k4':'v4','k2':'v5'})**

​            **print(dic)**

​            **结果：{'k1': 'v1', 'k2': 'v5', 'k4': 'v4'}**

## set--集合

用途：关系运算，去重，集合的三大特性：
每一个值都必须是不可变的类型
，元素不能重复，
集合类元素无序

### 常用操作和内置方法

​	交集：&
	并集：|
	差集：-
	对称差集：^
	是否相等：==
	父集：一个集合是包含另外一个集合，>=
	子集：一个集合是否在另一个集合中，<=
	update
	pop随机删除
	remove单纯的删除，返回值为None，当删除元素不存在就则报错
	discard，单纯的删除，返回值为None，当删除元素不存在不会报错
	isdisjoint当两个集合没有交集时返回True

### 该类型总结

​	可以存多个值
	无序
	可变
	集合去重的局限性
		无法原数据类型的顺序
		只有集合中的元素全为不可变类型时，才可以用集合去重

### 其他

**集合是有序的并且不可以重复的**

**names={'鸣人','佐助','小樱'}**

**names.add('鸣人')**

**即使现在又添加了一次鸣人，在集合中也不会出现**

#### 差集

> **names={'鸣人','佐助','小樱'}**
>
> **boys={'鸣人','佐助','卡卡西'}**
>
> **val=names.difference(boys)**
>
> **names中存在，boys中不存在的数据,结果为'小樱'**
>
> **val=boys.difference(names)**
>
> **boys中存在，names中不存在数据，结果为'卡卡西'**
>
> **difference_update****同differenc一样用法**

#### 对称差集

> **names={'鸣人','佐助','小樱'}**
>
> **boys={'鸣人','佐助','卡卡西'}**
>
> **val=names.symmetric_difference(boys)**
>
> **输出的是两个集合互不相同的，结果为{'小樱','卡卡西'}**
>
> **symmetric_difference_update方法使用方法同上**

#### 删除指定值

> **names={'鸣人','佐助','小樱'}**
>
> **names.discard('鸣人')**
>
> **结果:names={'佐助','小樱'}**

#### 求交集*

> **names={'鸣人','佐助','小樱'}**
>
> **boys={'鸣人','佐助','卡卡西'}**
>
> **val=names.intersection(boys)**
>
> **输出的是两个集合的交集，也就是两个集合都有的值。结果：{'鸣人','佐助'}**
>
> **intersection_update使用方法同上**

#### 并集*

> **names={'鸣人','佐助','小樱'}**
>
> **boys={'鸣人','佐助','卡卡西'}**
>
> val=names.union(boys)
>
> 输出的是两个集合拥有的所有值，重复的值只输出一个。结果：{'鸣人','佐助','小樱','卡卡西'}

#### 判断是否无交集

> **names={'鸣人','佐助','小樱'}****boys={'鸣人','佐助','卡卡西'}****val=names.isdisjoint(boys)****有交集为False，无交集为True**

#### **子集父集*

> **names={'鸣人','佐助','小樱'}****boys={'鸣人','佐助','卡卡西'}****val=boys.issubset(names)****判断是否是子集****val=names.issuperset(boys)****判断是否是父集**

#### **删除集合元素*

> **names={'鸣人','佐助','小樱'}****v=names.pop()****同列表，取删除值****names.remove('鸣人')****names.discard('佐助')**

#### **更新*


> **names={'鸣人','佐助','小樱'}**
>
> **boys={'鸣人1','佐助1','卡卡西1'}**
>
> **names.update(boys)**
>
> **更新值，结果：{'鸣人','佐助','小樱','鸣人1','佐助1','卡卡西1'}**

## 元祖

用途：记录多个值，当多个值没有改的需求，此时元组更加适合

### 常用操作和内置方法

​	按索引取值，只能取
	切片顾头不顾尾
	长度len
	成员运算in 和 not in
	可以for循环遍历
	count统计元素出现的次数
	index查看元素所在的索引位置，不存在就报错

### 类型总结

​	可以存放多个值
	不可变
	有序

## 字典

用途：记录多个值，每一个值都有对应的key用来描述value

### 常用操作和内置方法

​	按key取值可存可取
	长度len
	成员运算in 和 not in  判断的是key
	del 删除，不存在就报错
	pop删除，不存在就报错
	popitem删除字典第一个键值对
	keys
	values
	items
	可以for 循环遍历
	get存在返回value，不存在返回None
	update有则替换，无则添加
	setdefault有则不变，无则添加

### 该类型总结

​	存多个值
	无序
	可变

```
1、数据类型
    int
    float
    str
    list
        列表内的元素可以是任意类型
    tuple
        元组内的元素可以是任意类型
    dict
        字典的key必须是不可变类型
        字典的value可以是任意类型

    set
        集合内元素必须为不可变类型
        集合内元素无序
        集合内元素不能重复

```

    可变类型：值变，id不变
        列表，字典，集合
    不可变类型：值变，id也跟着变
        int，float，str，tuple


    可以按照索引取值都是有序
        str，list，tuple
    否则都是无序
        dict，set


    只能存一个值的：
        int，float，str
    
    可以存多个值的，（比喻为容器类型）
        list，tuple，dict，set

2、字符编码
    unicode：内存（不能改变）
        2bytes存一个字符

        上-------unicode--------》4e0a
        上<-------unicode--------4e0a
    
    gbk:
        2bytes代表一个中文字符，1bytes代表一个英文字符
    utf-8
        3bytes代表一个中文字符，1bytes代表一个英文字符


    unicode-------编码encode---------》utf-8
    unicode《-------解码decode---------utf-8


    处理乱码问题，一个核心的思想：
        字符当初是以什么编码格式存的/编码就应该以什么编码方式解码
    
    python3中
        str类型的值默认就是unicode编码的结果
        name='何'
        print(name)
    
        bytes:可以当成二进制去看
            name_bytes=name.encode('utf-8')
            name_bytes.decode(''utf-8')