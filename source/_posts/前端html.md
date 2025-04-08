---
title: 前端html
tags: [前端]
date: 2019-03-28 15:20:18
categories: 记忆
photos:
book:
---

# url

URL(Uniform Resoure Locator)，统一资源定位符是对可以从互联网上得到的资源的位置和访问方法的一种简洁的表示，是互联网上标准资源的地址。互联网上的每个文件都有一个唯一的URL，它包含的信息指出文件的位置以及浏览器应该怎么处理它。 

## URL的组成

```
http://www.fuming.com/product/news/add?name=xiaolili&age=10#section1
```

### protocol 协议

，常用的协议是http

### hostname 主机地址

，可以是域名，也可以是IP地址

### port 端口

 http协议默认端口是：80端口，如果不写默认就是:80端口

### path 路径

 网络资源在服务器中的指定路径

### query

 查询字符串 如果需要从服务器那里查询内容，在这里编辑

### hash 

锚点部分，指向页面中的某个位置



# HTML常用标签

## HTML实体

### 表示一个空格

 `&nbsq;`   

### 表示特殊符号

 `&lt;` < 
 `&gt;`   <

### 版权号333333455

 `&copy;`表示版权符号    ©上海公安 版权号333333455 

### 表示人民币符号

 `&yen;`表示人民币符号   ¥1000 

### 表示实体本身`&

 `&amp;表示实体本身`&  如果是空格则就显示& 如果是符号 则&符号

### 补充特殊字符

| 描述 | 实体名称          | 实体编号     |         |
|  |  |  |  |
|      | 空格              |              | &#160;  |
| <    | 小于号            | <            | &#60;   |
| >    | 大于号            | >            | &#62;   |
| &    | 和号              | &            | &#38;   |
| "    | 引号              | "            | &#34;   |
| '    | 撇号              | ' (IE不支持) | &#39;   |
| ￠   | 分（cent）        | ¢            | &#162;  |
| £    | 镑（pound）       | £            | &#163;  |
| ¥    | 元（yen）         | ¥            | &#165;  |
| €    | 欧元（euro）      | €            | &#8364; |
| §    | 小节              | §            | &#167;  |
| ©    | 版权（copyright） | ©            | &#169;  |
| ®    | 注册商标          | ®            | &#174;  |
| ™    | 商标              | ™            | &#8482; |
| ×    | 乘号              | ×            | &#215;  |
| ÷    | 除号              | ÷            | &#247;  |

## 主体结构

### `<html></html>`

此元素可告知浏览器其自身是一个 HTML 文档。 

### `<head></head>`

用于定义文档的头部，它是所有头部元素的容器,对文件的描述。`<head>` 中的元素可以引用脚本、指示浏览器在哪里找到样式表、提供元信息等等。 

### `<body></body>`

代表文件内容,定义文档的主体

## HEAD头部标签

### `<title></title> `

  双标签内写标题，网页标题

### `<base> `

标签为页面上的所有链接规定默认地址或默认目标

### `<meta>`

写在最上面，因为下面有输入字符，指定网页的元信息可指定字符编码，关键字，描述信息属性：charset , name ,content

```
           <meta charset="utf8">     指定编码
  		<meta name="keyword" content="   指定搜索关键字
  		同志交友,同志,同志相亲"> 
  		<meta name="description" content="  指定描述信息
  		全国最大的同志交友平台">
```

### `<link>`

导入css 文档，或者指定的网页图标   属性 src   ， type   ，rel

```html
  		<link rel="stylesheet" type="text/css" href="./01.css"> 从文件导入css
  		
  		<link rel="shorcut icon" type="    导入网页标题图标 ico格式可以
  		image/xicon" href="./os.ico">
```

### `<style></style> `

```html
  <style type="text/css">  可以直接在头部运用自己定义的css来修饰
  	h1{
  		color: red;
  	}
  </style>
```

  

 `<script></script>`标签用于定义客户端脚本，比如 JavaScript。script 元素既可以包含脚本语句，也可以通过 src 属性指向外部脚本文件。 

   	

```html
  <script type="text/javascript" src="script.js"></script>
  <script>
    alert('OK')
  </script>
```

## 格式排版标签

### `<hn></hn>`

1~6  标题  

### `<p></p>`

 段落

### `<pre></pre>`

  原样输出

### `<br>`

  换行

### `<hr>`

分隔 

### `<div></div>`

  没有任何语义的标签

## 图形标签img

### src:

 要显示图片的路径.

### alt:

 图片没有加载成功时的提示.

### title:

 鼠标悬浮时的提示信息.

### width: 

图片的宽

### border 

– 代表图片边框的宽度

### usemap

 将图像定义为客户器端图像映射。

### height:

图片的高 (宽高两个属性只用一个会自动等比缩放.)

### 图片和图片映射

#### map标签

```
<map> 标签用于客户端图像映射。图像映射指带有可点击区域的一幅图像。
<img>中的 usemap 属性可引用 <map> 中的 id 或 name 属性（取决于浏览器），所以我们应同时向 <map> 添加 id 和 name 属性。
area 元素永远嵌套在 map 元素内部。area 元素可定义图像映射中的区域。
```

#### area标签

##### alt 

规定区域的替代文本。如果使用 href 属性，则该属性是必需的。

##### href URL 

规定区域的目标 URL。

##### coords 

规定区域的坐标。

##### target

 -- 用来指出哪个窗口或框架应该被此链接打开(详情看a标签的target)

##### shape 

规定区域的形状

```
rect  矩形
circle 圆形
poly  多边形
```

```html
<img src="" title="" alt="" usemap="#mymap">
```

```html
<map name="" id="">
    <area shape="" coords="" href="" target="" title="">
</map>
```

```
<img src="planets.gif" alt="Planets" usemap="#planetmap" />

<map name="planetmap">
  <area href="sun.htm" shape="rect" coords="0,0,110,260">Sun</a>
  <area href="mercur.htm" shape="circle" coords="129,161,10">Mercury</a>
  <area href="venus.htm" shape="circle" coords="180,139,14">Venus</a>
</map>
```

### 图片格式

### GIF 

-- 最多支持256色,支持透明,支持多帧动画显示效果.

### JPEG

 -- 支持多种颜色,可以有很高的压缩比,使用了有损压缩,不支持透明,不支持动画效果.

### PNG

 -- 是一种新的图片技术,可以表现品质比较高的图片,使用了无损压缩,支持透明,不支持动画.



## a标签

### href 

代表一个url链接源(就是链接到什么地方) 

```
url除了是网页外,还可以是其它的文件(如文本文件,pdf文件等)。 
url还可以是指向HTML文件中的一个位置。 
url还可以是Email地址。
```

### target  

用来指出哪个窗口或框架应该被此链接打开 

```
target=_blank： 将链接内容在新的浏览窗口中打开。 
target=_self：  将链接的内容，显示在目前的窗口中。 
target=_parent：将链接的内容，当成文件的上一个画面。 
target=_top：这个参数可以解决新内容被旧框窗包围的困扰，使用这参数，会将整个画面重新显示成链接的画面内容。
```

### title 

代表链接的附加提示信息 

### download  

HTML5新添加属性 表示下载 

#### 超链接范例

```
网站链接：     <a href="http://www.oldboy.cn">Python专家</a>
电子邮件链接： <a href="mailto:fuming@oldboy.com">写信给我</a>
电话             <a href="tel:10086">10086</a>
短信          <a href="sms:10086">发短息给我</a>
```

### 锚点

#### 

#### 点击

##### 方法一

```
div style="height:600px" id="here1"> 
		<h2>同志志向</h2>
	</div>
```

##### 方法二

```
用<a name=“”>定义，例如：<a name=“here1”>第一部分</a>，
```

##### 锚

```
使用<a href=“#here1”>跳转到第一部分</a>超链接就可以定位到网页中的“第一部分”这个位置。
```

```
锚点的跳转
使用#  <a href="#锚点名">跳转</a>
跳转到指定页面指定锚点  http://www.lampuser.com/index.html#section2
```

## 文本标签

### `<em></em>`

 强调  表现为斜体

### `<strong></strong>`

强调   表现为粗体

### `<mark></mark>`

  H5新增  表示被选择

### `<sup></sup>`

上标     如多少次方

### `<sub></sub>`

 下标     化学元素水

### `<ins></ins>`

 添加的内容   内容下面有下划线

### `<del></del>`

 删除的内容   内容中间划了一条线

### `<ruby></ruby>` / `<rt></rt>`

  加拼音  H5新增   

```
  <ruby>你好<rt>nihao</rt></ruby>     在你好上方加上nihao的显示
```

### `<mark></mark>`

**H5新增** 标签定义带有记号的文本 请在需要突出显示文本时使用,如搜索引擎搜索页面

## 布局相关的标签有语义

### `<div></div>`

 定义文档中的分区或节

### `<span></span>`

 这是一个行内元素，没有任何意义

### `<header></header>`

 **HTML5新增** 定义 section 或 page 的页眉

### `<footer></footer>`

**HTML5新增** 定义 section 或 page 的页脚

### `<main></main>`

**HTML5新增** 标签规定文档的主要内容。`<main>` 元素中的内容对于文档来说应当是唯一的。它不应包含在 文档中重复出现的内容，比如侧栏、导航栏、版权信息、站点标志或搜索表单。IE都不识别

### `<nav></nav>`

 **HTML5新增** 表示链接导航部分 如果文档中有“前后”按钮，则应该把它放到元素中

### `<section></section>`

**HTML5新增** 定义文档中的节 通常不推荐那些没有标题的内容使用section

### `<article></article>`

**HTML5新增** 定义文章 论坛帖子 报纸文章 博客条目 用户评论

### `<aside></aside>`

 **HTML5新增** 相关内容，相关辅助信息，如侧边栏



# 列表

### `<ul></ul>`

 代表HTML无序列表 ，里面每一列表项使用`<li>`标签定义

### `<ol></ol>`

 代表HTML有序列表 ，里面每一列表项使用`<li>`标签定义

```
  属性
  start 规定有序列表的起始值。
  type   规定在列表中使用的标记类型。(1 a A  i  I)
  reversed  H5新添加 降序
```

### `<li></li>`

 代表HTML列表项目，每个列表项使用一对`<li></li>`标记

### `<dl></dl>`

 定义了定义列表（definition list）

### `<dt></dt>`

 标签定义了定义列表中的项目（即术语部分）

### `<dd></dd>`

 在定义列表中定义条目的定义部分。

# 表格

## 标签

 `<table></table>`  

###  `<caption></caption>`   

定义表格标题
 `<thead></thead>`

 `<tfoot></tfoot>`

 `<tbody></tbody>`

###  `<tr></tr>`

 行

###  `<th></th>`

 表头单元格

###  `<td></td>`

 单元格

### border: 

表格边框.

### cellpadding: 

内边距

### cellspacing: 

外边距.

###  width: 

像素 百分比.（最好通过css来设置长宽）

###  rowspan: 

 单元格竖跨多少行

###  colspan: 

 单元格横跨多少列（即合并单元格）

```
<table>
         <tr>
                <td>标题</td>
                <td>标题</td>
         </tr>
         
         <tr>
                <td>内容</td>
                <td>内容</td>
         </tr>
</table>
```

## 合并单元格

### 给`<td>` 或者 `<th>` 设置属性 

### rowspan

  合并行

### colspan

  合并列

# 表单

## 标签

### `<form></from>`  

定义一个 HTML 表单，用于用户输入。

#### from属性

属性

### action

 表单提交到哪.一般指向服务器端一个程序,程序接收到表单提交过来的数据（即表单元素值）作相应处理，比如https://www.sogou.com/web 

### method  

​    表单的提交方式 post/get默认取值就是get 

### enctype

​    multipart/formdata(有文件表单时候，必须使用这个)
    application/xwwwformurlencoded

### target

#### `<input>` 

定义一个输入控件

```
属性
name  必须有，否则数据无法传递
type  text、password、radio、hidden、checkbox、submit、image、file、reset、button、submit、email、num
```

####  `<button></button>` 定义按钮

```
  属性
  type  submit、reset、submit
  name
```

####  `<select></select>` 属性

定义选择列表（下拉列表）

#####   disabled 

 禁用

  name      必须有

#####   multiple 

 多选,默认会显示所有,名字要使用数组like[]
  size      显示几个下拉

####  `<option></option>`   

定义选择列表中的选项。

```
  属性
  value   提交的值，若没有，则提交内容
  selected  定义选中项
  disabled  选项禁用
```

####  `<optgroup></optgroup>`   

把相关的选项组合在一起

```
  属性
  disabled  规定禁用该选项组。
  label    为选项组规定描述。
```

####  `<textarea></textarea>`

```
  属性
  cols  可见宽度
  rows  可见行数
  readonly  文本区只读
  name  必须有
  disabled  禁用
```

####  `<label>`  

定义 fieldset 元素的标题。  

####  `<fieldset></fidldset>`  

定义围绕表单中元素的边框

![1553759514332](前端html\1553759514332.png)

![1553759546494](前端html\1553759546494.png)

####  `<legend></legend>` 

 定义 fieldset 元素的标题。

## 表单组成控件

### 其实本质就是type的属性不一样

```
属性
name  必须有，否则数据无法传递
type  text、password、radio、hidden、checkbox、submit、image、file、reset、button、submit、email、num
```

### 文本输入框

#### placeholder

提示表单的输入信息

#### maxlength  

规定最大字符数

#### value  

 传给后台值

#### size

 表单长度

```
<input type="text" name="username">
<input type="text" name="username" placeholder="请输入用户名">
<input type="text" name="username" value="李大钊">
<input type="text" name="username" placeholder="请输入用户名" size="10" maxlength="15">
```

### 密码框password

```
<input type="password" name="pwd">
<input type="password" name="pwd" placeholder="请输入密码">
<input type="password" name="pwd" placeholder="请输入密码" maxlength="12">
```

### 单选按钮radio

```
<input type="radio" name="sex" value="male" checked>男
<input type="radio" name="sex" value="female">男
```

### 复选框checkbox

```
<input type="checkbox" name="hobby" value="basketball"> 篮球
<input type="checkbox" name="hobby" value="football"> 足球
<input type="checkbox" name="hobby" value="pingpong" checked> 乒乓球 
<input type="checkbox" name="hobby" value="baseball"> 棒球
```

### 文件选择框file

```
<input type="file" name="pic">
<input type="file" name="pics" multiple>  <!选择多个文件>
```

### 规定类型的文本输入框（HTML5新增）

#### 邮箱email

```
<input type="email" name="email" placeholder="请输入邮箱">
```

#### 网址url

```
<input type="url" name="url" placeholder="请输入网址">
```

#### 数字number

```
<input type="number" name="num">
<input type="number" name="num" min='10' max='100' step='10'>
```

#### 搜索框search

```
<input type="search" name="kw" placeholder="搜索">
```

#### 电话号码tel

 同于text  但是用移动设备，会直接弹出数字键盘>

```
<input type="tel" name="tel_num" placeholder="请输入电话号码">
```

### 范围选择框(HTML5新增)range

```
<input type="range" name="range">
<input type="range" name="range" value="80">
<input type="range" name="range" value="80" max="100" min="0">
```

### 颜色选择框(HTML5新增)color

```
<input type="color" name="color">
```

### 时间日期选择框(HTML5新增)

#### 天date

```
<input type="date" name="date">
```

#### 月month

```
<input type="month" name="month">
```

#### 周week

```
<input type="week" name="week">
```

#### 时间time

```
<input type="time" name="time">
```

#### 日期datetime

```
<input type="datetime" name="datetime">
```

#### 总时间datetimelocal

```
<input type="datetimelocal" name="datetime">
```

### 下拉选项

#### select里面框了option选项

```
<select name="major">
    <option value="computer">计算机</option>
    <option value="archaeology">考古学</option>
    <option value="medicine" selected>医学</option>
    <option value="Architecture">建筑学</option>
    <option value="Biology">生物学</option>
</select>
```

#### 可多选multiple

```
<select name="major" multiple>
    <option value="computer">计算机</option>
    <option value="archaeology">考古学</option>
    <option value="medicine">医学</option>
    <option value="Architecture">建筑学</option>
    <option value="Biology">生物学</option>
</select>
```

### 多行文本输入textarea

```
<textarea name="content"></textarea>
```

#### 可以设置长宽cols,rows

```
<textarea name="content" cols="30" rows="10"></textarea>
```

### 按钮

#### 提交按钮submit

```
<input type="submit" value="提交">
<button>提交</button>
<button type="submit">提交</button>
```

#### 重置按钮reset

```
<input type="reset" value="重置">
<button type="reset">重置</button>
```

#### 普通按钮button

```
<input type="button" value="按钮">
<button type="button">按钮</button>
```

## 表单验证 

### 必须填required

```
required 属性   给所有可以输入的表单控件  表示必填

```

### 指定类型email/url/number

```
email/url/number   会自动验证类型
```

### 正则属性pattern

```
pattern 属性 所有可输入 
<input type="text" pattern="\d{4,6}" title="必须是4~6位数字">

```



## 表单控件的通用属性

### disabled 

 所有的表单控件元素 禁用

### enabled   

可用 用于所有的表单控件

### readonly  

只读  用于可以输入的表单控件(input/textarea)

### autofocus 

 自动获取焦点  所有的表单元素  H5

### autocomplete  on/off 

  没写是on用于可输入的控件 是否自动填充内容 H5

### pattern 

 正则验证

### title 

  提示信息

### required

  必填的表单

## 视频/音频(H5)

### 标签

### `<video></video>` 定义视频

#### autoplay

如果出现该属性，则视频在就绪后马上播放

#### controls

如果出现该属性，则向用户显示控件，比如播放按钮

#### height

设置视频播放器的高度

#### loop

如果出现该属性，则当媒介文件完成播放后再次开始播放

#### muted

如果出现该属性，视频的音频输出为静音

#### poster

规定视频正在下载时显示的图像，直到用户点击播放按钮

#### preload

如果出现该属性，则视频在页面加载时进行加载，并预备播放。如果使用

#### 视频

```
<video src=""></video>  要播放的视频的 URL。 
controls  如果出现该属性，则向用户显示控件，比如播放按钮。
autoplay   如果出现该属性，则视频在就绪后马上播放。 
poster= ""   规定视频正在下载时显示的图像，直到用户点击播放按钮。 
preload 预加载
loop  如果出现该属性，则当媒介文件完成播放后再次开始播放。




```

mp4 / ogg / webm  视频支持的格式

#### 音频

```
<audio src=""></audio>
controls
autoplay
preload
loop




```

mp3 / wav / ogg   音频的格式

#### source

```
<video>
	<source src="" type="">
	<source src="" type="">
	<source src="" type="">
</video>

<audio>
	<source src="" type="">
	<source src="" type="">
	<source src="" type="">
</audio>

可以指定多个格式的文件 用来适配浏览器


```

### 其他

```
| 属性     | 值                  | 描述                                                   
|  |  | 
| autoplay | autoplay           | 如果出现该属性，则视频在就绪后马上播放。                     
| controls | controls           | 如果出现该属性，则向用户显示控件，比如播放按钮。              
| height   | pixels             | 设置视频播放器的高度。                                   
| loop     | loop               | 如果出现该属性，则当媒介文件完成播放后再次开始播放。           
| muted    | muted              | 如果出现该属性，视频的音频输出为静音。                     
| poster   | URL                | 规定视频正在下载时显示的图像，直到用户点击播放按钮。         
| preload  | auto metadata none | 如果出现该属性，则视频在页面加载时进行加载，并预备播放。如果使用 "autoplay"，则忽略该属性。 
| src      | URL                | 要播放的视频的 URL。                                    
| width    | pixels             | 设置视频播放器的宽度。
```

`<audio></audio>` 定义音频

```
| 属性      | 值                 | 描述                                                       
|  |  | 
| autoplay | autoplay           | 如果出现该属性，则音频在就绪后马上播放。                    
| controls | controls           | 如果出现该属性，则向用户显示音频控件（比如播放/暂停按钮）。 
| loop     | loop               | 如果出现该属性，则每当音频结束时重新开始播放。              
| muted    | muted              | 如果出现该属性，则音频输出为静音。                          
| preload  | auto metadata none | 规定当网页加载时，音频是否默认被加载以及如何被加载。        
| src      | URL*               | 规定音频文件的 URL。
```

`<source></source>`为媒体元素（比如 `<video>` 和 `<audio>`）定义媒体资源

| 属性   | 值            | 描述                                       
|  |  |  
| media | media_query   | 规定媒体资源的类型，供浏览器决定是否下载。 
| src   | URL           | 规定媒体文件的 URL。                       
| type  | MIME_type     | 规定媒体资源的 MIME 类型。

#### 视频

 支持的视频类型

| 浏览器            | MP4                                                     | WebM | Ogg  |
|  |  |  |  |
| Internet Explorer | YES                                                     | NO   | NO   |
| Chrome            | YES                                                     | YES  | YES  |
| Firefox           | YES 从 Firefox 21 版本开始 Linux 系统从 Firefox 30 开始 | YES  | YES  |
| Safari            | YES                                                     | NO   | NO   |
| Opera             | YES 从 Opera 25 版本开始                                | YES  | YES  |

 MP4 = MPEG 4文件使用 H264 视频编解码器和AAC音频编解码器
 WebM = WebM 文件使用 VP8 视频编解码器和 Vorbis 音频编解码器
 Ogg = Ogg 文件使用 Theora 视频编解码器和 Vorbis音频编解码器

#### 视频格式的MIME类型

| 格式 | MIMEtype  |
|  |  |
| MP4  | video/mp4  |
| WebM | video/webm |
| Ogg  | video/ogg  |

MIME(Multipurpose Internet Mail Extensions)多用途互联网邮件扩展类型。是设定某种扩展名的文件用一种应用程序来打开的方式类型，当该扩展名文件被访问的时候，浏览器会自动使用指定应用程序来打开

### 音频

#### 支持的音频格式

| 浏览器            | MP3  | Wav  | Ogg  |
|  |  |  |  |
| Internet Explorer | YES  | NO   | NO   |
| Chrome            | YES  | YES  | YES  |
| Firefox           | YES  | YES  | YES  |
| Safari            | YES  | YES  | NO   |
| Opera             | YES  | YES  | YES  |

#### 音频格式MIME类型

| 格式 | MIMEtype |
|  |  |
| MP3  | audio/mp3 |
| Wav  | audio/wav |
| Ogg  | audio/og  |



# 字体图标

http://fontawesome.dashgame.com/



<a href="#">返回顶部</a>

