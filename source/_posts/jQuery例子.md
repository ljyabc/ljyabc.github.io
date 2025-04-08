---
title: jQuery例子
tags: [前端]
date: 2019-04-01 12:37:35
categories: 例子
photos:
book:
---

#  jQuery例子



## 左侧菜单　

### Tab切换

![1554094728567](jQuery例子\1554094728567.png)

```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>tab</title>

    <style>
        *{
            margin: 0;
            padding: 0;
        }
        .tab_outer{
            margin: 20px auto;
            width: 60%;
        }
        .menu{
            background-color: #cccccc;
            /*border: 1px solid red;*/
            line-height: 40px;
            text-align: center;
        }
        .menu li{
            display: inline-block;
            margin-left: 14px;
            padding:5px 20px;

        }
        .menu a{
            border-right: 1px solid red;
            padding: 11px;
        }
        .content{
            background-color: tan;
            border: 1px solid green;
            height: 300px;

        }
        .hide{
            display: none;
        }

        .current{
            background-color: #2868c8;
            color: white;
            border-top: solid 2px rebeccapurple;
        }
    </style>
</head>
<body>
      <div class="tab_outer">
          <ul class="menu">
              <li relation="c1" class="current">菜单一</li>
              <li relation="c2" >菜单二</li>
              <li relation="c3">菜单三</li>
          </ul>
          <div class="content">
              <div id="c1">内容一</div>
              <div id="c2" class="hide">内容二</div>
              <div id="c3" class="hide">内容三</div>
          </div>

      </div>
</body>


<script src="../jquery-3.3.1.js"></script>
    <script>
          $(".menu li").click(function(){

               var index=$(this).attr("relation");
               $("#"+index).removeClass("hide").siblings().addClass("hide");
               $(this).addClass("current").siblings().removeClass("current");

          });


    </script>
</html>
```



## table正反选

![1554094959942](jQuery例子\1554094959942.png)

```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>

</head>
<body>

     <button>全选</button>
     <button>取消</button>
     <button>反选</button>
     <hr>
     <table border="1">
         <tr>
             <td><input type="checkbox"></td>
             <td>111</td>
             <td>111</td>
             <td>111</td>
             <td>111</td>
         </tr>
         <tr>
             <td><input type="checkbox"></td>
             <td>222</td>
             <td>222</td>
             <td>222</td>
             <td>222</td>
         </tr>
         <tr>
             <td><input type="checkbox"></td>
             <td>333</td>
             <td>333</td>
             <td>333</td>
             <td>333</td>
         </tr>
         <tr>
             <td><input type="checkbox"></td>
             <td>444</td>
             <td>444</td>
             <td>444</td>
             <td>444</td>
         </tr>
     </table>




<script src="jquery.min.js"></script>
    <script>

            $("button").click(function(){

               if($(this).text()=="全选"){    // $(this)代指当前点击标签

                   $("table :checkbox").prop("checked",true)
               }
                else if($(this).text()=="取消"){
                   $("table :checkbox").prop("checked",false)
               }
                else {
                   $("table :checkbox").each(function(){

                     $(this).prop("checked",!$(this).prop("checked"));

                 });
               }



            });

    </script>
</body>
</html>
```

## 轮播图效果一

```
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>轮播图效果</title>
	<style>
		.play {
			margin: 100px auto;
			width: 1226px;
			height: 460px;
			border: 1px solid #999;
			position: relative;
		}
		ul {
			list-style: none;
			margin:0;
			padding:0;
		}
		.play img {
			display: block;
			width: 1226px;
			height:460px;
		}
		.imglist li {
			position: absolute;
			left:0;
			top:0;
			opacity: 0;
			transition: opacity 1s;
		}
		.imglist li.current {
			
			opacity: 1;
		}
		.control-list {
			position: absolute;
			bottom:20px;
			right:20px;
		}
		.control-list span {
			font-size:0px;
			float:left;
			margin-right:5px;
			width:12px;
			height:12px;
			border:1px solid #999;
			border-radius: 7px;
			background: #999;
			cursor: pointer;
		}
		.control-list span.current {
			background: #fff;
		}
		.slide {
			position: absolute;
			top:50%;
			transform: translate(0, -50%);
			width:40px;
			height:80px;
			background:rgba(0,0,0,.6);
			color:#fff;
			font-size: 20px;
			font-weight: bold;
			text-align: center;
			line-height: 80px;
			cursor: pointer;
			opacity: .5;
			transition: .3s;
		}
		.slide:hover {
			opacity: 1;
		}
		.slide-left{
			left:0;
		}
		.slide-right {
			right:0;
		}
	</style>
</head>
<body>
	<div id="play" class="play">
		
		<ul class="imglist">
			<li class="current">
				<a href="#">
					<img src="./images/play01.jpg" alt="">
				</a>
			</li>
			<li>
				<a href="#">
					<img src="./images/play02.jpg" alt="">
				</a>
			</li>
			
			<li>
				<a href="#">
					<img src="./images/play03.jpg" alt="">
				</a>
			</li>
			<li>
				<a href="#">
					<img src="./images/play04.jpg" alt="">
				</a>
			</li>
			<li>
				<a href="#">
					<img src="./images/play05.jpg" alt="">
				</a>
			</li>
		</ul>
		<div class="control-list">
			<span class="current">1</span>
			<span>2</span>
			<span>3</span>
			<span>4</span>
			<span>5</span>
		</div>
		<div class="slide-list">
			<span class="slide slide-left"><</span>
			<span class="slide slide-right">></span>
		</div>
	</div>
	<script src="../jquery-3.3.1.js"></script>
	<script>
		//轮播图效果
		$(function(){
			var m = 0; 			//循环变量
			var delay = 3000; 	//轮播的时间间隔
			var length = 5; 	//轮播的数量
			//1.设置定时
			var runTime = setInterval(runPlay, delay);
			//鼠标悬浮 定时停止4
			$('#play').on('mouseenter', function(){
				clearInterval(runTime);
			}).on('mouseleave', function(){
				runTime = setInterval(runPlay, delay)
			});
			//给控制按钮 绑定 单击事件
			$('.control-list span').on('click', function(){
				//console.log($(this).index())
				// 刷新m
				m = $(this).index();
				controlImage(m);
			});
			//向右
			$('.slide-right').on('click', function(){
				m ++;
				if (m >= length) {
					m = 0;
				}
				controlImage(m)
			});
			//向左 上一个
			$('.slide-left').on('click', function(){
				m --;
				if (m < 0) {
					m = length-1
				}
				controlImage(m)
			})
			//定时函数2
			function runPlay() {
				//循环变量累加
				m ++;
				//判断
				if (m >= length) {
					m = 0;
				}
				//调用函数 控制图片
				controlImage(m)
			}
			//控制图片的变化3
			// n表示 要第几个显示
			function controlImage(n) {
				$('.imglist li').removeClass('current').eq(n).addClass('current');
				$('.control-list span').removeClass('current').eq(n).addClass('current');
			}
		//	插入:
		//	内联元素可以同设置块状去掉空格 image是内联元素
		//	font-size也能去掉空格
		//	让他们在一起的策略是  定位加  改变透明度
		})
	</script>
</body>
</html>
```

## 轮播图效果二

![1554095210189](jQuery例子\1554095210189.png)

```
<!DOCTYPE html>
<html lang="zh">
<head>
	<meta charset="UTF-8">
	<title>轮播图</title>
	<style type="text/css">
	    .wrap {
	        width: 300px;
	        height: 200px;
	        border: 1px solid black;
	        overflow: hidden;
	        position: relative;
	    }
	    	
	    ul {
	        width: 1200px;
	        height: 200px;
	        list-style: none;
	        margin: 0;
	        padding: 0;
	        position: absolute;
	        left: 0;
	    }
	        
	    li {
	        width: 300px;
	        height: 200px;
	        float: left;
	        font: bold 100px/200px arial;
	        text-align: center;
	        color: white;
	    }
	</style>
</head>
<body>
	<div class="wrap">
	    <ul>
	        <li style="background:red;">1</li>
	        <li style="background:orange;">2</li>
	        <li style="background:pink;">3</li>
	        <li style="background:cyan;">4</li>
	    </ul>
	</div>
	<div>
	    <input type="button" value="图1" />
	    <input type="button" value="图2" />
	    <input type="button" value="图3" />
	    <input type="button" value="图4" />
	</div>
</body>
<script src="../js/jquery-3.3.1.js"></script>
<script type="text/javascript">
	// 四个input按钮触发点击事件
	// ul做动画,整体移动带动li运动
	// 出现在wrap区域的li会被显示,超出的会被隐藏

	// input触发事件
	$('input').click(function () {
		// ul做动画
		$('ul').animate({
			// 定位left状态改变
			// 点击第几个 $(this).index() 按钮就往左移动几个宽度$('li').width()
			left: -$(this).index() * $('li').width()

		}, 300)
	})
</script>
</html>
```

## 全屏滚动

![1554095097551](jQuery例子\1554095097551.png)

```
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>全屏滚动</title>
	<link href="https://cdn.bootcss.com/fullPage.js/2.9.7/jquery.fullpage.css" rel="stylesheet">
	<style>
		.slide {
			color: #fff;
			font-size:100px;
			text-align: center;
		}
	</style>
</head>
<body>
	<!--HTML部分-->
	<div id="fullpage">
	    <div class="section">
	    	<h2>Page1</h2>
	    </div>
	    <div class="section">
	        <div class="slide">A</div>
	        <div class="slide">B</div>
	        <div class="slide">C</div>
	    </div>
	    <div class="section">
	    	<h2>Page3</h2>
	    </div>
	    <div class="section">
	    	<h2>Page4</h2>
	    </div>
	</div>


	<script src="../jquery-3.3.1.js"></script>
	<script src="https://cdn.bootcss.com/fullPage.js/2.9.7/jquery.fullpage.js"></script>
	<script>
		$('#fullpage').fullpage({
			 navigation: true,
			 sectionsColor: ['red','green','purple','orange']
		});
	</script>
</body>
</html>
```

## 菜单实例

![1554095639281](jQuery例子\1554095639281.png)

```
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>菜单实例</title>
	<style>
		ul {
			padding:0;
			margin:0;
			list-style: none;
		}
		.nav {
			width: 120px;
		}
		.nav h2 {
			margin:0;
			font-size: 16px;
			font-weight: normal;
			padding: 0px 20px;
			height: 40px;
			line-height: 40px;
			border:1px solid #999;
			border-bottom:none;
			background: #369;
			cursor: pointer;
		}
		.nav ul {
			border:1px solid #999;
			display: none;
		}
		.nav li a{
			color:#333;
			font-size: 14px;
			text-align: center;
			text-decoration: none;
			display: block;
			padding: 0px 20px;
			height: 30px;
			line-height: 30px;
			border-bottom:1px solid #999;
		}
		.nav li:last-child a {
			border-bottom:none;
		}
	</style>
</head>
<body>
	<h1>后台管理</h1>
	<hr>

	<div class="nav">
		<h2>用户管理</h2>
		<ul>
			<li><a href="#">用户列表</a></li>
			<li><a href="#">用户添加</a></li>
			<li><a href="#">用户删除</a></li>
			<li><a href="#">用户修改</a></li>
		</ul>

		<h2>订单管理</h2>
		<ul>
			<li><a href="#">订单列表</a></li>
			<li><a href="#">订单添加</a></li>
			<li><a href="#">订单删除</a></li>
			<li><a href="#">订单修改</a></li>
		</ul>


		<h2>商品管理</h2>
		<ul>
			<li><a href="#">用户列表</a></li>
			<li><a href="#">用户添加</a></li>
			<li><a href="#">用户删除</a></li>
			<li><a href="#">用户修改</a></li>
		</ul>

		<h2>评论管理</h2>
		<ul>
			<li><a href="#">用户列表</a></li>
			<li><a href="#">用户添加</a></li>
			<li><a href="#">用户删除</a></li>
			<li><a href="#">用户修改</a></li>
		</ul>
	</div>

	<script src="../jquery-3.3.1.js"></script>
	<script>
		$(function(){
				//找到具体的触发  jquery元素. on('事件',function(){})
			$('.nav h2').on('click', function(){
				//$(this).next('ul').toggle();
				//当前元素的下一个兄弟元素  然后调用隐藏显示的方法
				$(this).next('ul').slideToggle();
			})
		})
	</script>
</body>
</html>
```

## 菜单实例css3

![1554095692446](jQuery例子\1554095692446.png)

```
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>菜单实例</title>
	<style>
		ul {
			padding:0;
			margin:0;
			list-style: none;
		}
		.nav {
			width: 120px;
		}
		.nav h2 {
			margin:0;
			font-size: 16px;
			font-weight: normal;
			padding: 0px 20px;
			height: 40px;
			line-height: 40px;
			border:1px solid #999;
			border-bottom:none;
			background: #ccc;
			cursor: pointer;
		}
		.nav ul {
			border:1px solid #999;
			height: 0px;
			border-width:0px;
			overflow: hidden;
			transition:all .5s;

		}
		.nav ul.active {
			/*height: 125px;*/
			height:125px;
			border-width: 1px;
		}
		.nav li a{
			color:#333;
			font-size: 14px;
			text-align: center;
			text-decoration: none;
			display: block;
			padding: 0px 20px;
			height: 30px;
			line-height: 30px;
			border-bottom:1px solid #999;
		}
		.nav li:last-child a {
			border-bottom:none;
		}
	</style>
</head>
<body>
	<h1>后台管理</h1>
	<hr>

	<div class="nav">
		<h2>用户管理</h2>
		<ul>
			<li><a href="#">用户列表</a></li>
			<li><a href="#">用户添加</a></li>
			<li><a href="#">用户删除</a></li>
			<li><a href="#">用户修改</a></li>
		</ul>

		<h2>订单管理</h2>
		<ul>
			<li><a href="#">订单列表</a></li>
			<li><a href="#">订单添加</a></li>
			<li><a href="#">订单删除</a></li>
			<li><a href="#">订单修改</a></li>
		</ul>


		<h2>商品管理</h2>
		<ul>
			<li><a href="#">用户列表</a></li>
			<li><a href="#">用户添加</a></li>
			<li><a href="#">用户删除</a></li>
			<li><a href="#">用户修改</a></li>
		</ul>

		<h2>评论管理</h2>
		<ul>
			<li><a href="#">用户列表</a></li>
			<li><a href="#">用户添加</a></li>
			<li><a href="#">用户删除</a></li>
			<li><a href="#">用户修改</a></li>
		</ul>
	</div>

	<script src="../jquery-3.3.1.js"></script>
	<script>
		$(function(){
			$('.nav h2').on('click', function(){
				$(this).next('ul').toggleClass('active')
			})
		})
	</script>
</body>
</html>
```

## 手风琴

![1554095816685](jQuery例子\1554095816685.png)

```
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>菜单实例</title>
	<style>
		ul {
			padding:0;
			margin:0;
			list-style: none;
		}
		.nav {
			width: 120px;
		}
		.nav h2 {
			margin:0;
			font-size: 16px;
			font-weight: normal;
			padding: 0px 20px;
			height: 40px;
			line-height: 40px;
			border:1px solid #999;
			border-bottom:none;
			background: #369;
			cursor: pointer;
		}
		.nav ul {
			border:1px solid #999;
			display: none;
		}
		.nav li a{
			color:#333;
			font-size: 14px;
			text-align: center;
			text-decoration: none;
			display: block;
			padding: 0px 20px;
			height: 30px;
			line-height: 30px;
			border-bottom:1px solid #999;
		}
		.nav li:last-child a {
			border-bottom:none;
		}
	</style>
</head>
<body>
	<h1>后台管理</h1>
	<hr>

	<div class="nav">
		<h2>用户管理</h2>
		<ul>
			<li><a href="#">用户列表</a></li>
			<li><a href="#">用户添加</a></li>
			<li><a href="#">用户删除</a></li>
			<li><a href="#">用户修改</a></li>
		</ul>

		<h2>订单管理</h2>
		<ul>
			<li><a href="#">订单列表</a></li>
			<li><a href="#">订单添加</a></li>
			<li><a href="#">订单删除</a></li>
			<li><a href="#">订单修改</a></li>
		</ul>


		<h2>商品管理</h2>
		<ul>
			<li><a href="#">用户列表</a></li>
			<li><a href="#">用户添加</a></li>
			<li><a href="#">用户删除</a></li>
			<li><a href="#">用户修改</a></li>
		</ul>

		<h2>评论管理</h2>
		<ul>
			<li><a href="#">用户列表</a></li>
			<li><a href="#">用户添加</a></li>
			<li><a href="#">用户删除</a></li>
			<li><a href="#">用户修改</a></li>
		</ul>
	</div>

	<script src="../jquery-3.3.1.js"></script>
	<script>
		$(function(){
			$('.nav ul:first').show();
			$('.nav h2').on('click', function(){
				$(this).next('ul').slideDown().siblings('ul').slideUp();
			})
		})
	</script>
</body>
</html>
```

