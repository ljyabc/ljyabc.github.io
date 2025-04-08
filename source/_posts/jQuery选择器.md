---
title: jQuery选择器
tags: [前端]
date: 2019-03-31 17:20:17
categories: 理解
photos:
book:
---

# 选择器

通过选择器，可以获取到页面元素。jQuery具有强大的选择器，跟CSS3选择器类似

## 本质

jquery dom对象

## 1 基本选择器

同JS

```
#id            根据给定的ID匹配一个元素
element        根据给定的元素标签名匹配所有元素
.class        根据给定的css类名匹配元素。
*            匹配所有元素
selector1,selector2,selectorN    将每一个选择器匹配到的元素合并后一起返回
```

## 2 层级选择器

同JS

```
ancestor descendant    在给定的祖先元素下匹配所有的后代元素
parent>child        在给定的父元素下匹配所有的子元素
prev+next            匹配所有紧接在 prev 元素后的 next 元素
prev~siblings        匹配 prev 元素之后的所有 siblings 元素
```

## 3 过滤选择器

### :first           

 获取第一个元素

### :not(selector)   

 去除所有与给定选择器匹配的元素

### :even         

   匹配所有索引值为偶数的元素，从 0 开始计数

### :odd           

 匹配所有索引值为奇数的元素，从 0 开始计数

### :eq(index)        

匹配一个给定索引值的元素

### :gt(index)        

匹配所有大于给定索引值的元素

### :lang          

 选择指定语言的所有元素。1.9+

### :last           

 获取最后个元素

### :lt(index)       

 匹配所有小于给定索引值的元素

### :header           

 匹配如 h1, h2, h3之类的标题元素

### :animated       

 匹配所有正在执行动画效果的元素

### :focus           

 匹配当前获取焦点的元素

### :root           

选择该文档的根元素   1.9+

### :target         

选择由文档URI的格式化识别码表示的目标元素    1.9

## 4 内容选择器

### :contains(text)   

 匹配包含给定文本的元素

```
li:contains('')  不光选中内筒有xx的元素  还选中这个元素的父元素
            $("li:contains('小丽丽')").css('border', '2px solid red');
```

![1554025095250](E:\blog-git\ljy\source\_posts\jQuery选择器\1554025095250.png)

### :empty          

  匹配所有不包含子元素或者文本的空元素

没有子元素，也不能有内容

### :has(selector)    

匹配含有选择器所匹配的元素的元素

```
//有这个子元素的元素
			$("li:has('.item')").css('border', '2px solid red');
```

![1554025184086](E:\blog-git\ljy\source\_posts\jQuery选择器\1554025184086.png)

### :parent           

 匹配含有子元素或者文本的元素

```
是有子元素 或者 内容  满足一个就够
```



## 5 可见性选择器

### :hidden        

匹配所有不可见元素，或者type为hidden的元素

### :visible   

 匹配所有的可见元素

## 6 属性选择器

与js一样

### [attribute]            

匹配包含给定属性的元素

### [attribute=value]   

 匹配给定的属性是某个特定值的元素

### [attribute!=value]   

 匹配所有不含有指定的属性，或者属性不等于特定值的元素

### [attribute^=value]    

匹配给定的属性是以某些值开始的元素

### [attribute$=value]   

 匹配给定的属性是以某些值结尾的元素

### [attribute*=value]   

 匹配给定的属性是以包含某些值的元素

### [attrSel1][attrSel2][attrSelN]   

 复合属性选择器，需要同时满足多个条件时使用

## 7 子元素选择器

### :first-child      

  匹配所给选择器( :之前的选择器)的第一个子元素

### :first-of-type    

  结构化伪类，匹配E的父元素的第一个E类型的孩子        1.9+

### :last-child          

  匹配最后一个子元素

### :last-of-type     

  结构化伪类，匹配E的父元素的最后一个E类型的孩子    1.9+

### :nth-child()      

  匹配其父元素下的第N个子或奇偶元素        

### :nth-last-child()    

选择所有他们父元素的第n个子元素。计数从最后一个元素开始到第一个    1.9+

### :nth-last-of-type()   

 选择的所有他们的父级元素的第n个子元素，计数从最后一个元素到第一个    1.9+

### :nth-of-type()    

  选择同属于一个父元素之下，并且标签名相同的子元素中的第n个    1.9+

### :only-child           

 如果某个元素是父元素中唯一的子元素，那将会被匹配

### :only-of-type         

 选择所有没有兄弟元素，且具有相同的元素名称的元素    1.9+

## 8 表单选择器

### 语法

```
$(':text').css('border', '1px solid red');
```

### :input         

   匹配所有 input, textarea, select 和 button 元素

### :text           

 匹配所有的单行文本框

### :password      

  匹配所有密码框

### :radio          

  匹配所有单选按钮

### :checkbox      

  匹配所有复选框

### :submit          

  匹配所有提交按钮，匹配 type="submit" 的input或者button

### :image           

 匹配所有图像域

### :reset          

  匹配所有重置按钮

### :button        

​    匹配所有按钮

### :file           

 匹配所有文件域

```js
<input type="text" name="" id=""> <br>
	<input type="password" name="" id=""> <br>
	<div></div>
	<select name="" id="">
		<option value="1">1</option>
		<option value="1" selected>2</option>
		<option value="1">3</option>
		<option value="1">4</option>
	</select>
	<button></button>
	
	
	<script src="../jquery-3.3.1.js"></script>
	<script>
		$(function(){
            //1
			//针对表单元素后面  :写type的名字 写
			//$(':text').css('border', '1px solid red');

			//2
			//所有的表单控件(****)
			//$(':input').css('border', '1px solid red');

			//3
			//只有表单有这个控制键
			$(':enabled').css('border', '2px solid green')//(***)

			//4
			//选择默认的表单
			// $(':selected').css('color', 'red'); //设置的是option(***)
		})
	</script>
```

## 9 表单对象选择器

### :enabled        

匹配所有可用元素

```
//只有表单有这个控制键
			$(':enabled').css('border', '2px solid green')//(***)
```

![1554025913007](E:\blog-git\ljy\source\_posts\jQuery选择器\1554025913007.png)

### :disabled       

 匹配所有不可用元素

### :checked       

 匹配所有选中的被选中元素(复选框、单选框等，select中的option)

### :selected       

 匹配所有选中的option元素

![1554026026546](E:\blog-git\ljy\source\_posts\jQuery选择器\1554026026546.png)

![1554026060290](E:\blog-git\ljy\source\_posts\jQuery选择器\1554026060290.png)