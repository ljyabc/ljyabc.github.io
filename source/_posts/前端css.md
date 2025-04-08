---
title: 前端css
tags: [前端]
date: 20190328 15:40:27
categories: 理解
photos:
book: 
---

http://unclealan.cn/docs/

fonts.googleapis.com

# css

## css的三种引入方式

###  行间式：

写在标签内的style属性中

```
<p style="color:red;"</p>
```

###  内联式：

写在style标签内

```
<style>
    p {
        color:red
    }
</style>
```

###  外联式：

通过导入

```
<link rel="stylesheet" type="text/css" href="./style.css">
```

#### 优先级

 三种方式没有优先级
 三种方式协同布局
   不重复的属性一定为唯一位置的唯一值
   重复的属性采用覆盖赋值，保留最后位置的属性值
   行间式一定是逻辑上最后被解析的位置
   ！important 会影响优先级

 常用属性

### 字体

####  fontfamily

​    字体家族     fontfamily:"Arial","Helvetica","宋体",sansserif;  或者衬线字体serif

####  fontsize 

​    字体大小 10px 1.3em  都可以 

####  fontweight 

 normal/bold   字体宽度     默认 以及加粗

####  fontstyle

​     normal/italic    字体风格   默认  斜体

####  fontvariant

   normal/smallcaps   字体变形    默认   小型大写字母

####   font: 复合属性,宽风形大家,开放性大家

字体宽度. 字体风格.字体变形.字体大小.字体家族

[weight | style | variant] size family

 字体家族
    衬线字体：宋体，楷体，仿宋
   非衬线字体：微软雅黑，黑体，思源黑体

##### 举列子

```
  fontsize: 30px;
  fontweight: bold;
  fontstyle: italic;
  fontvariant: smallcaps;
```

### 颜色

####  color

 设置文字颜色

### 文本

####  letter-spacing

​    字母间隔  值为长度，可以是负值

#####    px

 像素

####  word-spacing

词的间距(通过空格识别)

#####     px

 像素

#### text-decoration 

  文字修饰

#####   underline

  下划线

#####   overline

 上划线

#####   linethrough

 删除线,主要是用来删除链接的下划线

#####   none

 (默认)=不写

 



####  text-align

​    横向排列 

##### left | right | center

左 | 右 | 中

####  verticalalign

​    垂直对其方式

##### middle： 

将支持valign特性的对象的内容与对象中部对齐 

##### 了解

```
baseline： 将支持valign特性的对象的内容与基线对齐 
sub： 垂直对齐文本的下标 
super： 垂直对齐文本的上标 
top： 将支持valign特性的对象的内容与对象顶端对齐 
text-top： 将支持valign特性的对象的文本与对象顶端对齐 

bottom： 将支持valign特性的对象的文本与对象底端对齐 
text-bottom： 将支持valign特性的对象的文本与对象顶端对齐 
<percentage>： 用百分比指定由基线算起的偏移量。可以为负值。基线对于百分数来说就是0%。 
<length>： 用长度值指定由基线算起的偏移量。可以为负值。基线对于数值来说为0。（CSS2）
```

#### text-indent   

 文本缩进 

##### em, px

单位

#### line-height

##### 

 设置行间距离 不允许使用负

##### px

单位

##### 作业垂直居中

行高等于元素的高



#### word-wrap

 允许长单词或URL地址换行到下一行

#####   normal

​     只在允许的断字点换行（浏览器保持默认处理）。

#####   break-word

​    在长单词或 URL 地址内部进行换行。

####  white-space

#####   pre：

文本

用等宽字体显示预先格式化的文本，不合并文字间的空白距离，当文字超出边界时不换行。可查阅pre对象

#####   prewrap：

强制一行

用等宽字体显示预先格式化的文本，不合并文字间的空白距离，当文字碰到边界时发生换行。

## CSS 属性/尺寸/边框/背景

### 尺寸 height  width 

 height    高度
 min-height    最小高度
 max-height    最大高度
 width        宽度

####  min-width  

  最小宽度inline-block 有用

####  max-width 

   最大宽度对块状有用

#### calc代数公式

calc(80px * 3)

### 边框 border (实体有风格颜色) 

#### border-style  

边框风格   

##### dotted

   点线

##### dashed

  虚线

##### solid

   实线

##### double

 双实线

##### groove

 槽状线

##### ridge

​     脊线

##### inset

​      内嵌效果

##### outset

   外凸效果

#### border-width

  边框宽度   

#### border-color

 边框颜色

#### border 宽 样式 颜色

   复合属性   `border: 1px solid #ccc`

#### border-left-color

边框-单独设置各边 

### 外边距(规律同内)

#### margin        

- margin-left    

- margin-right    

- margin-top    

- margin-bottom

  ##### auto

  auto:左右auto,自适应(平方)剩余可布局空间

### 内边距(非实体仅距离)

#### padding-left

内边距-单独设置各边 

 padding-top

 padding-right

 padding-bottom

####  padding

```css
  padding: 值;  上下左右
  padding: 值1 值2；   上下 左右
  padding: 值1 值2 值3;  上  左右  下
  padding: 值2 值2 值3 值4；  上  右  下  左
```



### 背景属性

#### background-color

 背景颜色  

##### `transparent ` 

 为透明

#### background-image

  背景图片 

#####  url() 

  图片地址

#### background-repeat

  背景图片平铺  

##### repeat

平铺  

##### no-repeat

不平铺 

#####  repeat-x

 水平平铺

##### repeat-y

垂直平铺

#### background-position 

 背景图片位置  

##### left top

10px 10px   左 上

##### center center

中 中

#### background-attachment

  背景图片固定 

#####  scroll / fixed  

 fixed超过固定宽度才看不到图片

#### background 复合属性  

##### background:颜色图片平铺位置固定

 color image repeat postion attachment

## CSS精灵图

### 坐标方向

![1553786517439](前端css\1553786517439.png)

![1553786595333](前端css\1553786595333.png)

利用background-position,background-image,background-repeat配合

 利用 background-position 设置背景图片的位置
 把很多小的图片 集成到一张大图上
 好处： 减少网络请求数量

## 鼠标光标设置 （CSS属性）

### cursor css属性

#### text

  文字选择器

#### crosshair 

  十字架

#### wait 

 等待

#### help 

 帮助

#### pointer 

小手

## 布局属性

### position

#### static

：静态，未定位（默认值）

#### relative

: 相对定位, 未脱离文档流

#### absolute:

 绝对定位, 完全脱离文档流	

#### fixed:

 固定定位, 完全脱离文档流

### z-index

脱离文档流的标签,具有z-index属性,可以用来控制显示层次的优先级,值为任意正整数

### display：

#### block 

此元素将显示为块级元素，此元素前后会带有换行符。

块:1.独行显示 2.支持宽高,宽默认适应父级,高默认由子级或内容撑开 3.设置宽高后,一定采用设置的宽高

#### inline

默认。此元素会被显示为内联元素，元素前后没有换行符。

 内联:1.同行显示 2.不支持宽高

#### inineblock

行内块元素。（CSS2.1 新增的值） 

内联块:1.同行显示,之间有间距 2.支持宽高,宽高由内容撑开 3.设置宽高后,一定采用设置的宽高,但只设置其中一个,另一个会根据内容等比缩放

#### none

此元素不会被显示。

### float 

| 值      | 描述                                                 |
| ------- | ---------------------------------------------------- |
| left    | 元素向左浮动。                                       |
| right   | 元素向右浮动。                                       |
| none    | 默认值。元素不浮动，并会显示在其在文本中出现的位置。 |
| inherit | 规定应该从父元素继承 float 属性的值。                |

###  clear 

| 值      | 描述                                  |
| ------- | ------------------------------------- |
| left    | 在左侧不允许浮动元素。                |
| right   | 在右侧不允许浮动元素。                |
| both    | 在左右两侧均不允许浮动元素。          |
| none    | 默认值。允许浮动元素出现在两侧。      |
| inherit | 规定应该从父元素继承 clear 属性的值。 |

### visibility 

#### visible  

默认值。元素是可见的。

#### 其他

| 值       | 描述                                                         |
| -------- | ------------------------------------------------------------ |
| hidden   | 元素是不可见的。                                             |
| collapse | 当在表格元素中使用时，此值可删除一行或一列，但是它不会影响表格的布局。被行或列占据的空间会留给其他内容使用。如果此值被用在其他的元素上，会呈现为 "hidden"。 |
| inherit  | 规定应该从父元素继承 visibility 属性的值。                   |

### overflow 

#### hidden

内容会被修剪，并且其余内容是不可见的。

| 值      | 描述                                                         |
| ------- | ------------------------------------------------------------ |
| visible | 默认值。内容不会被修剪，会呈现在元素框之外。                 |
| scroll  | 内容会被修剪，但是浏览器会显示滚动条以便查看其余的内容。     |
| auto    | 如果内容被修剪，则浏览器会显示滚动条以便查看其余的内容。消除子元素浮动对父元素的影响 |
| inherit | 规定应该从父元素继承 overflow 属性的值。                     |

### overflow-x 

水平方向

### overflow-y

垂直方向

标准文档流
 盒子和盒子位置  margin塌陷
 相关属性  display / overflow:auto/hidden/scroll  overflowx  overflowy     margin  visibility:visible/hidden

## 块级元素和内联元素

### 常见的块级元素有 

div、form、table、p、pre、h1～h5、dl、ol、ul 等。

### 常见的内联元素有

span、a、strong、em、label、input、select、textarea、img、br等

## CSS长度单位

### px 

 像素

### em 

 默认大小的倍数
百分比   默认大小参照

### cm 

厘米

### mm

毫米

### pt

point，是一个标准的长度单位，1pt＝1/72英寸，用于印刷业，非常简单易用； 

## CSS 颜色单位

border,backgroundcolor

### colorName： 

 red/green/bue/purple/orange/yellow/pink/skyblue

###  rgb数字 

 rgb(34,45,23)  rgb(20%, 57%, 100%)

### 16进制   

#abcdef   #f90   #ccc



## 基本选择器

###  HTML元素选择器

```
   div {
  
   }
```

###  CLASS选择器

```
   .className {
  
   }
```

###  ID选择器

```
  #idName {
  
   }
```

###  全局选择器

```
 * {

 }
```

###  组合: 后代元素

```
   选择器 选择器 {
  
   }
   .nav li {}
   #box div {}
   div .list {}
   .container li {}
```

###  组合：子元素

```
  选择器>选择器 {
  
   }
   .nav>li {}
   #box>div {}
   div>.list {}
   .container>li {}
```

###  组合：群组选择器

```
   选择器,选择器，选择器 {
  
   }
  
   body,ul,li,p,figure,table,.item,.listitem {
  
   }
```

###  组合：多选择器

```
   div.item {
  
   }
   .item.listitem {
  
   }
   div#container {
  
   }
```

### 

### 选择器优先级

#### !important>ID > CLASS > tagName > *

```
!important>ID > CLASS > tagName > *
计算 选择符 中ID的数量(=a)                    
计算 选择符 中 类选择器 属性选择器 伪类选择器 的数量(=b)    
计算选择符 中 标签选择器 伪对象选择器的数量 (=c)        
忽略全局选择器                            
a的权重100  b的权重10   c的权重1    相加
组合选择器 数数
```

所谓CSS优先级，即是指CSS样式在浏览器中被解析的先后顺序。

样式表中的特殊性描述了不同规则的相对权重，它的基本规则是：

1 内联样式表的权值最高               style=""－－－－－－－－－－－－1000；

2 统计选择符中的ID属性个数。       #id －－－－－－－－－－－－－－100

3 统计选择符中的CLASS属性个数。 .class －－－－－－－－－－－－－10
4 统计选择符中的HTML标签名个数。 p －－－－－－－－－－－－－－1

按这些规则将数字符串逐位相加，就得到最终的权重，然后在比较取舍时按照从左到右的顺序逐位比较。

```
1、文内的样式优先级为1,0,0,0，所以始终高于外部定义。
   
　　2、有!important声明的规则高于一切。

　　3、如果!important声明冲突，则比较优先权。

　　4、如果优先权一样，则按照在源码中出现的顺序决定，后来者居上。

　　5、由继承而得到的样式没有specificity的计算，它低于一切其它规则(比如全局选择符*定义的规则)。
```

### 总结

```
tagName
.className
#idName
*
slector,selector,selector

```

## 层级选择器

### selector1 selector2    

 后代

### selectoer1>selectoer2  

 子元素没有后代

### selector1+selector2   	

紧邻在后面的兄弟元素(一个)

### selector1~selector

后面所有兄弟元素

### 1.3 属性选择器

#### selector[attr]  	

​    包含指定的属性

#### selector[attr=value]  

​	指定属性的值

#### selector[attr^=value] 

 	属性值以value开头

#### selector[attr$=value]  

​	属性值以value结束

#### selector[attr*=value]  

​	属性值包含value

#### selector[][][]      

#####     多个属性选择器

 属性选择器优先级 同 class



## 伪类选择器

```css
/*语法*/
selector:伪类 {
   
}
```

### 常用

#### :link	

  未访问的超链接

#### :visited

  访问过的超链接

#### :hover 

   鼠标悬停 任意元素

#### :actived 

 激活状态的超链接

#### :focus  

  获得焦点时和input连用

#### 可以设置后代

```
/*鼠标悬停*/
		.list li:hover {
			background: pink;
			color: #fff;
			border:1px dashed #999;
		}
```

## 子元素选择器死脑子

### E:first-child

```
  匹配父元素的第一个子元素E。 
```

### E:last-child

```
  匹配父元素的最后一个子元素E。 死脑子最后一个不是E元素无效
```

### E:only-child

```
  匹配父元素仅有的一个子元素E。
```

### E:nth-child(数字n,奇数odd,偶数even)

```
  匹配父元素的第n个子元素E，假设该子元素不是E，则选择符无效。
```

### E:nth-last-child(n)

```
  匹配父元素的倒数第n个子元素E，假设该子元素不是E，则选择符无效。
```

### E:nth-last-child(n)

```
  匹配父元素的倒数第n个子元素E，假设该子元素不是E，则选择符无效。
```

## 子元素选择器活脑子

### E:first-of-type

```
  匹配同类型中的第一个同级兄弟元素E
```

### E:last-of-type

```
  匹配同类型中的最后一个同级兄弟元素E
```

### E:only-of-type

```
  匹配同类型中的唯一的一个同级兄弟元素E
```

### E:nth-of-type(n)

```
  匹配同类型中的第n个同级兄弟元素E
```

### E:nth-last-of-type(n)

```
  匹配同类型中的倒数第n个同级兄弟元素E
```

### E:empty

```
  匹配没有任何子元素（包括text节点）的元素E
```

## 否定伪类选择器

### E:not(s)

```
  匹配不含有s选择符的元素E
```

## 伪元素选择器

### E:first-letter/E::first-letter

```
设置对象内的第一个字符的样式。 
```

### E:first-line/E::first-line

```
设置对象内的第一行的样式。
```

### E:before/E::before

```
设置在对象前（依据对象树的逻辑结构）发生的内容。用来和content属性一起使用
```

```
.message::before {
			content:'你好';
		}
		
```

### E:after/E::after

```
设置在对象后（依据对象树的逻辑结构）发生的内容。用来和content属性一起使用
```

```
.message::after {
			content:'大家好';
			display: block;
			width: 200px;
			height: 100px;
			border: 1px solid red;
			margin: 10px;
		}
```

#### 集体去浮动

```
.clearfix::after {
			content:'';
			display: block;
			clear:both;
		}
再将需要去浮动的加入改类名
```

### E::placeholder

```
设置对象文字占位符的样式。 
```

### E::selection

```
设置对象被选择时的样式。 
```



# CSS3

## CSS3基础

### 浏览器私有前缀

```
weibkit*    chrome/safari
moz*		 firefox
ms*		  ie
o*		 opera

```



###  CSS3 新增的颜色

#### background:rgba(r,g,b,不透明度)  

不透明度：0~1 小数， 数越大，越不透明

#### background-image:

#####  linear-gradient渐变色

不加to上下

 linear-gradient(right, red, yellow,green);

加左右

 linear-gradient(to right, red, yellow,green);

###  CSS3新增长度单位

px

### em	

​	默认字体大小的倍数

### rem	

​	根元素字体大小的倍数,比如手机就需要

### vw 

​     窗口宽度分成100份  50vw

### vh 

​     窗口高度分成100份

## CSS3新增属性

重新设置 盒子模型的规则

### boxsizing:

####  contentbox(默认) /

width/height内容的宽高

####  borderbox

 （width/height盒子的宽高,压缩内容）

### outline:

外轮廓  在border的外面 不算盒子

- outline 给元素周围绘制一条轮廓线

  ```
  <' outline-width '> || <' outline-style '> || <' outline-color '>
  
  ```

- outline-width 外廓线宽度

  > ： 用长度值来定义轮廓的厚度。不允许负值 medium： 定义默认宽度的轮廓。 thin： 定义比默认宽度细的轮廓。 thick： 定义比默认宽度粗的轮廓。

- outline-style 外廓线风格

  > none： 无轮廓。与任何指定的 <' outline-width '> 值无关 dotted： 点状轮廓。 dashed： 虚线轮廓。 solid： 实线轮廓 double： 双线轮廓。两条单线与其间隔的和等于指定的 <' outline-width '> 值 groove： 3D凹槽轮廓。 ridge： 3D凸槽轮廓。 inset： 3D凹边轮廓。 outset： 3D凸边轮廓。

- outline-color 外廓线颜色

- outline-offset 外廓线的偏移量

不透明度

### opacity元素整体

 0~1 小数

### 边框圆角

#### border-radius

> 设置或检索对象使用圆角边框。提供2个参数，2个参数以“/”分隔，每个参数允许设置1~4个参数值，第1个参数表示水平半径，第2个参数表示垂直半径，如第2个参数省略，则默认等于第1个参数 水平半径：如果提供全部四个参数值，将按上左(top-left)、上右(top-right)、下右(bottom-right)、下左(bottom-left)的顺序作用于四个角。 如果只提供一个，将用于全部的于四个角。 如果提供两个，第一个用于上左(top-left)、下右(bottom-right)，第二个用于上右(top-right)、下左(bottom-left)。 如果提供三个，第一个用于上左(top-left)，第二个用于上右(top-right)、下左(bottom-left)，第三个用于下右(bottom-right)。
>
> 垂直半径也遵循以上4点。

- border-top-left-radius 设置或检索对象的左上角圆角边框
- border-top-right-radius 设置或检索对象的右上角圆角边框
- border-bottom-right-radius 设置或检索对象的右下角圆角边框
- border-bottom-left-radius 设置或检索对象的左下角圆角边框

### boxshadow阴影

```
boxshadow:水平偏移 垂直偏移;   偏移可以负值
boxshadow:水平偏移 垂直偏移 颜色;
boxshadow:水平偏移 垂直偏移 模糊值 颜色; /*最常见的*/
boxshadow:水平偏移 垂直偏移 模糊值 外延值 颜色;
```

### 背景

#### backgroundsize

##### cover

优先 铺满元素。 多余的图片裁掉 保证原图比例

##### contain

优先 保证图片显示完整，可能元素不能铺满。 保证原图比例

##### 400px 300px

指定背景大小

##### 100% 100%

自定义

```
backgroundsize: cover / contain / 400px 300px / 100% 100%
background: color image postion/size repeat attachment

```



### 变换

####  transform

##### 位移

  translatex() 
  translatey()
  translate(x, y)

##### 旋转

  rotate()  角度 deg

##### 扭曲

  skewx()   角度deg
  skewy()   
  skew(x, y)

#### transform-origin 

 变换的原点。  对translate没有意义。  对rotate影响大



### 过渡效果

一般和:hover连用

#### 哪些CSS属性可以过渡

```
长度 (padding margin width height  left/top/right/bottom borderwidth  backgroundposition ...)
颜色
变换
纯数字 (opacity、zindex)

```

#### 触发过渡

```
伪类触发  :hover  :focus  ....
媒体查询   @media
JS

```

#### 相关属性

##### transition-property 

 指定要过渡的属性 用,隔开。默认是 all 可以是with

##### transition-duration 

 过渡持续时间

##### transition-timingfunction 

 过渡线性效果 

######  默认 ease

先加速后减速

###### 匀速 linear

匀速

##### transition-delay 

  过渡延迟

##### transition：复合

property timingfunction duration delay



### 3.8 CSS3动画

#### 关键帧

```css
@keyframes 动画名字 {
    0% {
        
    }
    20% {
        
    }
    40% {
        
    }
    100% {
        
    }
}
```

#### 相关CSS动画属性

```
animation-name  指定动画的名字
animation-duration  动画的执行时间
animation-timing-function  执行效果速度  
animation-delay   延迟
animation-iteration-count   循环 次数  infinite(无限)
animation-direction:  alternate （正向 反向 交替）\ reverse（反向）和hover连用
animation-play-state: running / paused
animation 复合属性
```



## 布局

### 1. CSS重置

 reset.css

```
  去掉所有元素的默认样式
  也可以保证浏览器效果相同
```

 normalize.css

```
  重新设计了所有元素的默认样式
  保证所有浏览器效果相同
  
  优点：
  添加了H5新元素的样式重置
  没有简单粗暴
```
