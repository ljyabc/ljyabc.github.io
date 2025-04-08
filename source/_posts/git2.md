---
title: git2
tags: [代码工具]
date: 2019-04-01 13:31:26
categories: 配置
photos:
book:
---

# 学习git

## 为什么要使用版本管理工具

版本管理工具的发展

安装git

- windows
  安装地址：<https://git-scm.com/download/win>
- mac
  推荐使用brew安装
- linux
  推荐使用apt-get(ubuntu)或npm(RegHat)安装

安装完了之后，要执行一下命令，告诉git 你是谁？

```
git config --global user.name "Your Name"
git config --global user.email "email@example.com"
```

------

## 版本管理

### 创建仓库(版本库)

```
git init    
```

### 添加和提交

添加文件

```
git add 文件名
```

可以同时添加多个

```
git add 文件1 文件2 文件3
```

添加所有

```
git add *
```

吧添加的文件提交上去

```
git commit -m "提交的说明"
```

添加和提交合并为一步， 该方法会把所有已经修改的文件添加并提交，但不会添加或提交新增的文件

```
git commit -am "提交说明"
```

### 版本库状态和变化

查看版本库状态

```
git status
```

查看文件的修改

```
git diff
```

### 版本回退

查看提交日志

```
git log
git log --pretty=oneline   #一行显示
```

查看历史执行操作

```
git reflog
```

执行版本回退

```
git reset --hard commitID
commitID可以写 HEAD(当前版本) 、 HEAD^(上个版本)、 HEAD^^(上上个版本) 也可以写具体 commitID
```

### 工作区和暂存区

![请输入图片描述](git2\744972259.jpeg)

### 管理修改

Git管理的是修改，不是文件

### 撤销修改

```
git checkout -- 文件名   #把文件在工作区的修改撤销掉
git reset HEAD 文件名    #可以把暂存区的修改撤销掉（unstage），重新放回工作区
```

### 删除文件

如果，直接把工作区的文件删除了，会造成工作区与版本库不统一。
可以执行 `git rm 文件名` 再执行 `git commit -m "描述"`

------

## 远程仓库

### 添加远程仓库

```
$ git remote add origin git仓库地址
git push -u origin master #加上了-u参数，Git不但会把本地的master分支内容推送的远程新的master分支，还会把本地的master分支和远程的master分支关联起来，在以后的推送或者拉取时就可以简化命令
git push origin master  
```

### 从远程仓库克隆

```
git clone 仓库地址
```

### ssh方式连接远程仓库

创建公钥和私钥

```
 ssh-keygen -t rsa -C "youremail@example.com"
```

在远程仓库上设置你的公钥

------

## 分支管理

### 创建与合并分支

创建分支

```
 git branch dev    #创建分支 dev
```

切换当前分支到

```
 git checkout dev  #切换当前分支为 dev
```

创建并切换分支

```
 git checkout -b dev 
```

查看分支

```
git branch
```

合并某分支到当前分支

```
git merge <name>
```

删除分支

```
git branch -d <name>
```

### 解决冲突

### 分支管理策略

### Bug分支

### Feature分支

### 多人协作

------

## 标签遍历

### 创建标签

### 操作标签

------

## 使用github

------

## git相关设置

### 忽略特殊文件

### 配置别名

------

## 搭建gi服务器

## git 常用命令

![e8dd7837-b39d-413e-9beb-ed51984719e0.png](git2\3758321766.png)

## 附录 git常用单词解释

repository 仓库
branch 分支
ignore 忽略
Contribution 贡献
explore 探索