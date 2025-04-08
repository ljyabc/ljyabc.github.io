---
title: 常用pycharm快捷键
tags: [python进阶]
date: 2019-03-15 22:31:07
categories: 工具
photos:
---

# Pycharm常用快捷键，以及设置

## 一 常用快捷键

> 编辑类：
> Ctrl + D             复制选定的区域或行
> Ctrl + Y           删除选定的行
> Ctrl + Alt + L     代码格式化
> Ctrl + Alt + O     优化导入（去掉用不到的包导入）
> Ctrl + 鼠标        简介/进入代码定义    
> Ctrl + /           行注释 、取消注释
>
> Ctrl + 左方括号   快速跳到代码开头
> Ctrl + 右方括号   快速跳到代码末尾
> Shift + F10        运行
> Shift + F9         调试
> 查找/替换类：
> Ctrl + F          当前文件查找
> Ctrl + R          当前文件替换
> Ctrl + Shift + F  全局查找
> Ctrl + Shift + R  全局替换 
> 运行类：
> Shift + F10        运行
> Shift + F9         调试
> Alt + Shift + F10  运行模式配置
> Alt + Shift + F9   调试模式配置
> 调试类：
> F8                单步调试（一行一行走）
> F7                进入内部
> Shift + F8        退出
> Ctrl + F8         在当前行加上断点/断点开关
> Ctrl + Shift + F8 查看所有断点
> 导航类：
> Ctrl + N          快速查找类（也可查找当前工程中的文件，以文件名查找）
> Double Shift      任意位置查找

## 二 配置自己喜欢的快捷键

file——》setting——》在搜索框输入keymap，如图：

![img](https://images2018.cnblogs.com/blog/1350514/201805/1350514-20180507100828415-1252593424.png)

注意：在 上图标注1 的位置搜索要修改的功能，2的位置直接通过快捷键查找

 

 **1  修改快捷键之快速跳到本行末尾：在1 位置输入end查找到：Move Caret to Line End**

![img](https://images2018.cnblogs.com/blog/1350514/201805/1350514-20180507101117803-754153036.png)

 

 

 **2  修改快捷键之快速跳到本行开头：同上，修改为 Ctrl+引号**

![img](https://images2018.cnblogs.com/blog/1350514/201805/1350514-20180507101630695-1539432329.png)

 

 **3  修改快捷键之快速回到上一次操作的位置：**

 

![img](https://images2018.cnblogs.com/blog/1350514/201805/1350514-20180507101822016-239909397.png)

## 三 修改html的注释方式

**如果pycharm中html注释是{# #}而不是<!-- -->，这是由于指定的模版语言是Django或者是jinja2，修改一下就可以了**

**file---->settings里搜索Python Template Languages --->指定html的模版语言为None就可以了，但是这样就不能快捷使用Django或者jinja2的模版语言了**

![img](https://images2018.cnblogs.com/blog/1350514/201808/1350514-20180825193307165-1040610365.png)

## 四 按tab键代码自动补全

![img](https://images2018.cnblogs.com/blog/1350514/201808/1350514-20180825205948572-1674938901.png)

## 其它设置

> \1. Pycharm中默认是不能用Ctrl+滚轮改变字体大小的，可以在file -> Setting ->Editor-〉General -> Mouse中设置
> \2. 要设置Pycharm的字体，要先在file -> Setting ->Editor-〉Font中选择一种风格并保存，然后才可以改变
> \3. 在setting中搜索theme可以改变主题，所有配色统一改变
>
> 4 . 设置注释颜色：File-->Settings-->Editor-->Color&Fonts-->LanguageDefaults-->Linecomment-->设置颜色即可