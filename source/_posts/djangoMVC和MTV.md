---
title: djangoMVC和MTV
tags: [lnhdjango基础]
date: 2021-04-30 16:52:59
categories: 理解
photos:
book:
---

# MVC和MTV

## django 是mtv模式:

```python
-M:model   ---->模型
-T:Template  --->模板
-V:view    ---->视图
```

## -mvc模式:

```
-M:model---->模型,数据库相关
-v:view----->模板---->页面相关
-C:controller--->控制器:url+view
```

本质上:MTV就是MVC