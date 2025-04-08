---
title: git
tags: [代码工具]
date: 2019-03-03 00:12:35
categories: 其他
photos:
---

# Git

https://lupython.gitee.io/categories/

## 下载

https://git-scm.com/download/win



![1551230719006](git\1551230719006.png)

## 配置

![1551230944677](git\1551230944677.png)

## 创建项目

![1551231155237](git\1551231155237.png)

### 初始化一下

git init

### 什么是主分支

![1551231336348](git\1551231336348.png)

### 列出隐藏文件

> ###### ls -al
>
> ###### ls -a

### 进入git的目录

![1551231690059](git\1551231690059.png)

### 创建一个git

![1551232282685](git\1551232282685.png)

### 提交到暂存区

![155123243359](git\1551232413359.png)

![1551232455701](git\1551232455701.png)

![1551232633762](git\1551232633762.png)

![1551232689248](git\1551232689248.png)

### 修改

![1551232916848](git\1551232916848.png)![1551233431173](git\1551233431173.png)

### touch(添加一个文件)

## 远程

> git add .全部提交
>
> get commint
>
> ![1551238501228](git\1551238501228.png)

> ```
> git remote add origin https://gitee.com/ljy_-123/oldboygit.git
> ```
>
> 同步创库
>
> git pull --rebase origin master 
>
> git push origin master

## 刷新完成提交

![1551236561607](git\1551236561607.png)

## 一般不会在网页上编辑

![1551236728125](git\1551236728125.png)

## master分支

![1551236895388](git\1551236895388.png)

## 删除

git rm c.py

![1551238774283](git\1551238774283.png)

![1551238800100](git\1551238800100.png)



# 何为分布式，与集中式有何区别？ 

## svn服务器

### 东西丢了就丢了

![1551240655893](git\1551240655893.png)

## git服务器

git服务器是提供开发者“交换”代码用的，服务器的数据丢了没有关系，换一台就好了，因为本地已经保存了一份 

![1551240941880](git\1551240941880.png)

## 历史无所谓

## 工作区和版本库

![image](git\1551241296122.png)

## 查看项目日志

### git log

```
git log : 查看项目日志
git log file : 查看某个文件日志
git log . :查看本目录日志
git reflog: 查看详细做了啥
```

![1551243248059](git\1551243248059.png)

## 版本的切换

### git reflog



![1551245702582](git\1551245702582.png)

### git reset --hard "head^"

###### 不灵活

### git log --pretty=oneline

![1551246952293](git\1551246952293.png)

###### git reset --hard 文件前面的数字字母



![1551247571949](git\1551247571949.png)

# 四.远程配置

###### 注意master分支是最干净的

## 查看分支

> ### git branch
>
> git branch -a

![1551248044086](git\1551248044086.png)

## 创建分支

> ### git branch dev



## 切换分支

> ### git checkout dev

## 合并分支

> ### git mergo dev

## 远程服务器配置 

#### 查看远程仓库

```
git remote 
git remote -v
```

#### 删除远程仓库

```
命令：git remote remove <远程地址>

例子：git remote remove origin
```

#### 添加远程仓库

```
	git remote add <远程仓库别名> <远程仓库地址>
```

#### 修改远程仓库

>  git remote rename <旧名称> <新名称> 

#### 链接多个用户

![1551588064](git\1551258428064.png)

# 五.git冲突

###### git clone 代码地址

###### 需要空目录代码

###### 不用触发,不是管理者

## 一套完整上传的流程

###### 新建一个控文件夹项目



![1551259222733](git\1551259222733.png)

cd到项目

![1551263898996](git\1551263898996.png)

### 所有先要pull一下

> `git pull origin dev` 



### 解决冲突和修改

![1551266580112](git\1551266580112.png)

### 检查是否最新

![1551266708904](git\1551266708904.png)

### 公钥

#### ssh

一路回车

![1551267054321](git\1551267054321.png)

![1551267157082](git\1551267157082.png)

### 把id_rsa.pub里面的复制下来

```
 `ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCnJlTPHh0CyjLc4xvW3C6FiDswuT6gycqsWxY0rGT/lcEUa/68TvmKXqaE3IC5N45sFTczhBigdEL7wC0fq UJFD+feNogrF+2HQsfxFTD9yfXXm9Esm7FkJ5Fj4wjtBGHV+N8vajab4ODONe6y7LCW1uctG4rLLwLJ8Ontz7GQP/SzyMXo5ensDWFPP7PhxojpY/YVXVMPMX i0EZ1/L3G1/67ErDAoAzDS7mcEMMFu4KRG3lOfuQcIHysBfFiGZjVxXEbIWOzSS5LF9JNIpPs65+VTBPPrA6X22mG8Jg7Qb6YKoUR6BJbK2SouAS3uBYdri41 e0iyiksHRUe+44kln 1634306788@qq.com                                                                                       ` 22733.


```

![1551267647076](git\1551267647076.png)

![1551285049537](git\1551285049537.png)

![1551420834710](git\1551420834710.png)

![1551420902610](git\1551420902610.png)

![1551421713547](git\1551421713547.png)

# git代码冲突常见的解决方法

------

如果系统中有一些配置文件在服务器上做了配置修改,然后后续开发又新添加一些配置项的时候,
在发布这个配置文件的时候,会发生代码冲突:
error: Your local changes to the following files would be overwritten by merge:
protected/config/main.php
Please, commit your changes or stash them before you can merge.
如果希望保留生产服务器上所做的改动,仅仅并入新配置项, 处理方法如下:

```
git stash
git pull
git stash pop
```

然后可以使用git diff -w +文件名 来确认代码自动合并的情况.

反过来,如果希望用代码库中的文件完全覆盖本地工作版本. 方法如下:

```
git reset --hard
git pull
```

其中git reset是针对版本,如果想针对文件回退本地修改,使用

```
git checkout HEAD file/to/restore
```