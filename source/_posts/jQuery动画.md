---
title: jQuery动画
tags: [前端]
date: 2019-04-01 04:10:04
categories: 理解
photos:
book:
---

# 动画效果

## 本质

jQuery 的dom的方法

## 1. 基本效果

### show([s,[e],[fn]])       

 显示隐藏的匹配元素

### hide([s,[e],[fn]])      

  隐藏显示的元素

### toggle([s],[e],[fn])  

  如果元素是可见的，切换为隐藏的；如果元素是隐藏的，切换为可见的

**参数详解**

```
speed    : 三种预定速度之一的字符串("slow","normal", or "fast")或表示动画时长的毫秒数值(如：1000)
easing    : (Optional) 用来指定切换效果，默认是"swing"，可用参数"linear"
fn        : 在动画完成时执行的函数，每个元素执行一次。
```

## 2. 滑动效果

### slideDown([s],[e],[fn])      

通过高度变化（向下增大）来动态地显示所有匹配的元素

### slideUp([s,[e],[fn]])        

通过高度变化（向上减小）来动态地隐藏所有匹配的元素

### slideToggle([s],[e],[fn])  

  通过高度变化来切换所有匹配元素的可见性

**参数详解**

```
speed    : 三种预定速度之一的字符串("slow","normal", or "fast")或表示动画时长的毫秒数值(如：1000)
easing    : (Optional) 用来指定切换效果，默认是"swing"，可用参数"linear"
fn        : 在动画完成时执行的函数，每个元素执行一次。
```

## 3 淡入淡出效果

### fadeIn([s],[e],[fn])       

 通过不透明度的变化来实现所有匹配元素的淡入效果

### fadeOut([s],[e],[fn])      

  通过不透明度的变化来实现所有匹配元素的淡出效果

### fadeToggle([s,[e],[fn]])   

 通过不透明度的变化来开关所有匹配元素的淡入和淡出效果

### fadeTo([[s],o,[e],[fn]])   

 把所有匹配元素的不透明度以渐进方式调整到指定的不透明度

**参数详解**

```
speed    : 三种预定速度之一的字符串("slow","normal", or "fast")或表示动画时长的毫秒数值(如：1000)
easing    : (Optional) 用来指定切换效果，默认是"swing"，可用参数"linear"
fn        : 在动画完成时执行的函数，每个元素执行一次。

opacity    : (用户fadeTo)一个0至1之间表示透明度的数字。
```

## 4 自定义动画

animate(p,[s],[e],[fn])

**参数详解**

```
params    : 一组包含作为动画属性和终值的样式属性和及其值的集合
speed    : 三种预定速度之一的字符串("slow","normal", or "fast")或表示动画时长的毫秒数值(如：1000)
easing    : 要使用的擦除效果的名称(需要插件支持).默认jQuery提供"linear" 和 "swing".
fn        : 在动画完成时执行的函数，每个元素执行一次。
```

```
<script>
		$(function(){
			$('#btn').click(function(){
				$('#box').animate({
					'width':'0px',
					'padding-left':'0px',
					'padding-right':'0px'	
				}, 2000, function(){
					$(this).hide();  //this是box
				})
			});


			$('#btn1').click(function(){
				$('#box').show().animate({
					'width':'400px',
					'padding-left':'20px',
					'padding-right':'20px'	
				}, 2000)
			});


			$('#btn2').click(function(){
				$('#box').animate({
					'width':'toggle',
					'padding-left':'toggle',
					'padding-right':'toggle'	
				}, 2000)
			})
		})
	</script>
```



## 5 动画控制

### stop([c],[j])        

停止所有在指定元素上正在运行的动画

### delay(d,[q])        

设置一个延时来推迟执行队列中之后的项目

### finish([queue])       

 停止当前正在运行的动画，删除所有排队的动画，并完成匹配元素所有的动画

```
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
	<style>
		#box {
			overflow: hidden;
			width: 400px;
			height: 200px;
			border: 2px solid #ccc;
			padding: 20px;
		}
	</style>
</head>
<body>
	<h1>动画控制</h1>
	<hr>
	<button id="btn">隐藏</button>
	<button id="btn1">显示</button>
	<button id="btn2">切换</button>

	<br>
	<button id="btn3">动画</button>
	<button id="btn4">finish</button>
	<button id="btn5">stop</button>

	<hr>
	<div id="box">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quas et necessitatibus cumque accusamus iure eius expedita, dolore, nobis ut maiores dignissimos consectetur saepe repudiandae, libero molestias deserunt veritatis facere vitae.</div>

	<script src="../jquery-3.3.1.js"></script>
	<script>


		$(function(){

			$('#btn4').on('click', function() {
				$('#box').finish();
			});

			$('#btn5').on('click', function() {
				$('#box').stop();
			});

			$('#btn3').on('click', function(){
				//如果 box元素 正在执行  return false?/true 结束这个按钮函数的功能
				if ($('#box').is(':animated')) {
					return false;
				}

				//动画队列 delay
				$('#box').slideUp(3000).delay(2000).show(2000).fadeOut(2000).slideDown(3000)
			});

			$('#btn').click(function(){
				$('#box').animate({
					'width':'0px',
					'padding-left':'0px',
					'padding-right':'0px'	
				}, 2000, function(){
					$(this).hide();
				})
			});


			$('#btn1').click(function(){
				$('#box').show().animate({
					'width':'400px',
					'padding-left':'20px',
					'padding-right':'20px'	
				}, 2000)
			});


			$('#btn2').click(function(){
				$('#box').animate({
					'width':'toggle',
					'padding-left':'toggle',
					'padding-right':'toggle'	
				}, 5000)
			})
		})
	</script>
</body>
</html>
```



## 6 设置

```
//关闭页面上所有的动画
jQuery.fx.off = true;
```

## 新闻滚动

```js
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>滚动播放</title>
	<style>
		body {
			background:#ccc;
		}
		#box {
			margin:100px auto;
			width: 1000px;
			height: 460px;
			background:#ccc;
			overflow: hidden;
		}

		ul {
			list-style:none;
			padding:0;
			margin:0;
		}
        /*将p标签自带的margin设为0*/
		p {
			margin:0;
		}
		#box li {
			height:100px;
			margin-bottom:20px;
			background: #fff
		}
		#box li img{
			float:left;
			width:100px;
			height: 100px;
		}
		#box li p {
			float:right;
			width:850px;
			line-height: 100px;
			height:100px;
		}
	</style>
</head>
<body>
	<div id="box">
		<ul id="newsList">
			<li>
				<img src="../../dist/images_one/14.jpg" alt="">
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsum, ea.</p>
			</li>

			<li>
				<img src="../../dist/images_one/1.jpg" alt="">
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsum, ea.</p>
			</li>

			<li>
				<img src="../../dist/images_one/2.jpg" alt="">
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsum, ea.</p>
			</li>

			<li>
				<img src="../../dist/images_one/3.jpg" alt="">
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsum, ea.</p>
			</li>

			<li>
				<img src="../../dist/images_one/4.jpg" alt="">
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsum, ea.</p>
			</li>

			<li>
				<img src="../../dist/images_one/11.jpg" alt="">
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsum, ea.</p>
			</li>

			<li>
				<img src="../../dist/images_one/10.jpg" alt="">
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsum, ea.</p>
			</li>

			<li>
				<img src="../../dist/images_one/9.jpg" alt="">
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsum, ea.</p>
			</li>

			<li>
				<img src="../../dist/images_one/8.jpg" alt="">
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsum, ea.</p>
			</li>
		</ul>
	</div>


	<script src="../jquery-3.3.1.js"></script>
	<script>
		$(function(){
			setInterval(function(){
				$('#box li').eq(3).fadeTo(500, 0, function(){
                    //第四个(即last())隐藏完成后触发新功能  最后一个瞬间透明度变为1 ，隐藏，前置，展开
					$('#box li').last().fadeTo(0,1).hide().prependTo('#newsList').slideDown();
				//	一定要有fadeTo把透明度变为1，不然前置透明度仍然是0
				})
			}, 2000)
		})
	</script>
</body>
</html>
```

