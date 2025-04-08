---
title: jQueryDOM操作
tags: [前端]
date: 2019-04-01 02:08:23
categories: 理解
photos:
book:
---

# DOM操作

# jQueryDOM操作



## 可以判断参数类型

![1554056789664](E:\blog-git\ljy\source\_posts\jQueryDOM操作\1554056789664.png)

## 1 内部插入

### append(content|fn)        

向每个匹配的元素内部追加内容

### appendTo(content)        

把所有匹配的元素追加到另一个指定的元素元素集合中

![1554056260904](E:\blog-git\ljy\source\_posts\jQueryDOM操作\1554056260904.png)

### prepend(content|fn)        

向每个匹配的元素内部前置内容

### prependTo(content)        

把所有匹配的元素前置到另一个、指定的元素元素集合中

## 2 外部插入

### after(content|fn)       

 在每个匹配的元素之后插入内容

### before(content|fn)        

在每个匹配的元素之前插入内容

### insertAfter(content)    

把所有匹配的元素插入到另一个、指定的元素元素集合的后面

### insertBefore(content)    

把所有匹配的元素插入到另一个、指定的元素元素集合的前面

## 3 包裹

### wrap(html|ele|fn)        

把所有匹配的元素用其他元素的结构化标记包裹起来

```
$('#wrap_btn').on('click', function(){
				$('#box img').wrap('<li>');
			})
```

![1554056581708](E:\blog-git\ljy\source\_posts\jQueryDOM操作\1554056581708.png)

### unwrap()               

 这个方法将移出元素的父元素

### wrapAll(html|ele)       

 移出元素的父元素

```
$('#wrapAll_btn').on('click', function(){
				$('#box img').wrapAll('<li>');
```

![1554056536747](E:\blog-git\ljy\source\_posts\jQueryDOM操作\1554056536747.png)

### wrapInner(html|ele|fn)   包裹子元素

 将每一个匹配的元素的子内容(包括文本节点)用一个HTML结构包裹起来

## 4 替换

### replaceWith(content|fn)       

 将所有匹配的元素替换成指定的HTML或DOM元素

#### 替换

```
$('#box img.active').replaceWith('<img src="../../dist/images_one/meinv02.jpg">')
```

#### 移动拿到的dom

```
$('#box img.active').replaceWith($('#newImg')
```



### replaceAll(selector)      

  用匹配的元素替换掉所有 selector匹配到的元素

## 5 删除

### empty()            

删除匹配的元素集合中所有的子节点

### remove([expr])   

 从DOM中删除所有匹配的元素

### detach([expr])   

 从DOM中删除所有匹配的元素 这个方法不会把匹配的元素从jQuery对象中删除，因而可以在将来再使用这些匹配的元素。与remove()不同的是，所有绑定的事件、附加的数据等都会保留下来

## 6 复制

### clone([Even[,deepEven]])   

 克隆匹配的DOM元素并且选中这些克隆的副本

#### 副本去替换

```
$('#box img.active').replaceWith($('#newImg').clone())//
```

