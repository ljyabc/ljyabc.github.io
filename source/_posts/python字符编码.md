---
title: python字符编码
tags: [python基础]
date: 2019-03-14 21:36:53
categories: 理解
photos:
---

# 字符编码

```
将人类的字符编码/转换成计算机能识别的数字
这种转换必须遵循一套固定的标准，该标准无非是
人类字符与数字的对应关系，称之为字符编码表

bit：二进制位
Bytes：字节
ASCII码表：用1Bytes表示一个英文字符

1英文字符=8bit=1Bytes

GBK：用2Bytes表示一个中文字符，1Bytes去表示英文字符

unicode:内存中使用的是unicode编码，unicode把全世界的字符都建立好对应关系
        用2Bytes去表示一个字符

utf-8 用1Bytes表示英文，用3Bytes表示中文
```

# 字符编码需要记住的概念

01 内存中固定使用unicode编码，我们唯一可以改变的是存储到硬盘时使用的编码

02 要想保证存取文件不乱乱码，应该保证文档当初是以什么编码格式存的，就应该以什么编码格式去读取

## 03 python3解释器默认编码是UTF-8,python2解释器默认编码是ASCII

```
在python2中有两种字符串编码格式
                1、unicode：
                        x=u'上'
                2、unicode编码后的结果
                        x='上' #如果文件头为coding:utf-8,那么"上"被存成utf-8格式的二进制

        在python3只有一种字符串编码格式：
                1、unicode
                        x='上’
```

## 04 编码与解码

```
unicode-------编码encode-------->gbk
unicode<-------解码decode--------gbk
```

# 总结python2与python3：

```
    在python2中的字符粗类型str都是unicode按照文件头的指定的编码，编码之后的结果
    在python2中也可以制造unicode编码的字符串。需要在字符串前加u

    在python3中的字符串类型str都是unicode编码的
    所以python3中的字符串类型可以编码成其他字符编码格式，编码的结果
    是bytes类型
```