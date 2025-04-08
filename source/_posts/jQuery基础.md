# jQuery基础



## 1. 了解jQuery

### 1.1 什么是jQuery

 jQuery 是一个高效、精简并且功能丰富的 JavaScript 工具库
 jQuery极大的简化了JavaScript 编程

### 1.2 什么事JS类库

 它就是一些函数的集合，就是把特定效果的代码写好，你只需要在用的时候要用很少的代码去调用。
 起主导作用的是你的代码，由你来决定何时使用类库。

### 1.3 常见JS类库

 jQuery
 ExtJS
 prototype.js
 zepto.js

### 1.4 jQuery的优势

 开源 免费
 便捷的选择器
 方便的DOM操作
 方便的动画特效
 易用的ajax操作
 丰富的插件扩展
 解决浏览器兼容性效果

### 1.5 jQuery的版本

```
1.x.x的版本是可以 支持 IE6~IE8的
2.x.x到3.x.x 的版本，不在兼容IE8以及以下浏览器
```

### 1.6 jQuery 相关网站

 官网 <https://jquery.com/>
 文档API： <http://jquery.cuishifeng.cn/index.html>

## 2 jQuery 基本使用

### 2.1 安装

**下载到本地，再引入**

下载地址：<https://jquery.com/download/>

```
<script src="jquery3.3.1.min.js"></script>
<script>
    //注意，一定在引入jQuery之后，再使用jQuery提供的各种操作
</script>
```

**或者 直接使用CDN**

```
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
<script>
    code...
</script>
```

BootCDN jQuery各个版本地址： <https://www.bootcdn.cn/jquery/>

### 2.2 jQuery对象

`$`是`jQuery`的别名

```
jQuery('.item').show()
//等同于
$('.item').show()
```

`$`对象可以用作选择器获取元素，还可以创建DOM对象

#### jquery dom对象

##### 绑定$(document)

页面文档可以触发有内容的

本质上jquery就是由 原生dom组成的类数组对象

var $box = $('#box');

#### 原生 dom对象

var box= document.querySelector('#box');

```js
<script>
        $(function () {
            var $box = $('#box'); //返回的是jquery dom对象
            var box= document.querySelector('#box');
            console.log($box,box);
        //  第一个是一个存了一堆原生dom并且封装了一堆方法的
        //    类数组对象
            //  jQuery.fn.init [div#box]0: div#boxlength: 1__proto__: Object(0) <div id=​"box">​</div>​
        //    第二个是 <div id="box"></div>    原生的
    //    原生的dom 转为jqety dom  $(原生的dom对象)
        $(box).css('height',"200px")
    //    jquery dom 对象转为 原生的dom 本质上jquery就是由 原生dom组成的类数组对象
		$box[0].style.backgroundColor='green';
        })
    </script>
```



### 2.3 文档就绪事件

```
$(document).ready(function(){

   // 开始写 jQuery 代码...

});
```

上述写法可以简写

```
$(function(){

   // 开始写 jQuery 代码...

});
```

### 2.4 连贯操作

```
//对象可以连贯调用
$(dom).find('img').css('border','1px solid #ccc').css('color', 'red').prop('src', '1.jpg').toggle()
```

### 2.5 jQueryDOM和jsDOM

 通过原生js获取的dom对象，我们称之为jsDOM或者原生DOM
 通过jQuery选择器获取的dom对象，我们称之为 jQuery DOM
 jQuery DOM本质上 是由 jsDOM组成的集合，是个类数组对象。可以通过 [索引] 获取其中的jsDOM
 `$(jsDOM)` 可以转为 jQuery DOM