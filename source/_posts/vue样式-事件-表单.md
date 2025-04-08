---
title: 'vue样式,事件,表单'
tags: [前端]
date: 2019-04-01 17:58:33
categories: 理解
photos:
book:
---

# vue样式,事件,表单

## vue选项卡

![1554114409827](vue样式-事件-表单\1554114409827.png)

![1554113713161](vue样式-事件-表单\1554113713161.png)

```
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>选项卡 tabs</title>
	<link rel="stylesheet" href="../dist/css/bootstrap.css">
	<style>
		#app {
			margin:100px auto 0px;
			width:800px;
		}
		.panel {
			border-top:none;
		}
	</style>
</head>
<body>

	<div id="app">
		<div class="row">
			<div class="col-md-12">
				<ul class="nav nav-tabs">
					<li :class="{active: tab == 0}" @click="tab = 0"><a href="#">未付款订单</a></li>
					<li :class="{active: tab == 1}" @click="tab = 1"><a href="#">未发货订单</a></li>
					<li :class="{active: tab == 2}" @click="tab = 2"><a href="#">未收货订单</a></li>
					<li :class="{active: tab == 3}" @click="tab = 3"><a href="#">未评价订单</a></li>
					<li :class="{active: tab == 4}" @click="tab = 4"><a href="#">所有订单</a></li>
				</ul>

				<div class="panel panel-default" v-show="tab === 0">
					<div class="panel-body">
						这是未付款的订单
					</div>
				</div>

				<div class="panel panel-default" v-show="tab === 1">
					<div class="panel-body">
						这是未发货的订单
					</div>
				</div>

				<div class="panel panel-default" v-show="tab === 2"> 
					<div class="panel-body">
						这是未收货的订单
					</div>
				</div>

				<div class="panel panel-default" v-show="tab === 3">
					<div class="panel-body">
						这是未评价的订单
					</div>
				</div>

				<div class="panel panel-default" v-show="tab === 4">
					<div class="panel-body">
						这是所有的订单
					</div>
				</div>
			</div>
		</div>

	</div>
	

	<script src="../dist/js/vue.js"></script>
	<script>
		let vm = new Vue({
			el:'#app',
			data: {
				tab: 0
			},

		})
	</script>
</body>
</html>
```

### 2

![1554114464616](vue样式-事件-表单\1554114464616.png)

![1554114487254](vue样式-事件-表单\1554114487254.png)

```js
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>选项卡 tabs</title>
	<!--21.导入css,导入图片-->
	<link rel="stylesheet" href="../dist/css/bootstrap.css">
	<style>
		#app {
			margin:100px auto 0px;
			width:800px;
		}
		.panel {
			border-top:none;
		}
	</style>
</head>
<body>

	<div id="app">
		<div class="row">
			<div class="col-md-12">
				<!--22.导航条样式-->
				<ul class="nav nav-tabs">
					<li :class="{active: isTab(0)}" @click="setTab(0)"><a href="javascript:void(0)">未付款订单</a></li>
					<li :class="{active: isTab(1)}" @click="setTab(1)"><a href="javascript:void(0)">未发货订单</a></li>
					<li :class="{active: isTab(2)}" @click="setTab(2)"><a href="javascript:void(0)">未收货订单</a></li>
					<li :class="{active: isTab(3)}" @click="setTab(3)"><a href="javascript:void(0)">未评价订单</a></li>
					<li :class="{active: isTab(4)}" @click="setTab(4)"><a href="javascript:void(0)">所有订单</a></li>
				</ul>
                <!--23.设置面板panel panel-default颜色-->
				<div class="panel panel-default" v-show="isTab(0)">
					<div class="panel-body">
						这是未付款的订单
					</div>
				</div>

				<div class="panel panel-default" v-show="isTab(1)">
                    <!--24.设置面板内容-->
					<div class="panel-body">
						这是未发货的订单
					</div>
				</div>

				<div class="panel panel-default" v-show="isTab(2)"> 
					<div class="panel-body">
						这是未收货的订单
					</div>
				</div>

				<div class="panel panel-default" v-show="isTab(3)">
					<div class="panel-body">
						这是未评价的订单
					</div>
				</div>

				<div class="panel panel-default" v-show="isTab(4)">
					<div class="panel-body">
						这是所有的订单
					</div>
				</div>
			</div>
		</div>

	</div>
	

	<script src="../dist/js/vue.js"></script>
	<script>
		let vm = new Vue({
			el:'#app',
			// 25.定义初始变量值
			data: {
				tab: 0
			},

			methods: {
			    // 26.设置click触发的索引
				setTab(index) {
					this.tab = index;
				},
				// 27.返回bool值===设置click触发的索引,打开下拉
				isTab(index) {
					return this.tab === index;
				}
			}
		})
	</script>
</body>
</html>
```

## 3 样式

### 3.1 绑定HTML Class

```
<p class="item" :class="cname">
cname:'current',
```



#### 对象语法

```vue
<div v-bind:class="{ active: isActive }"></div>  对象
<div class="static"
     v-bind:class="{ active: isActive, 'text-danger': hasError }">  key对应的值可以为true/false 可以写多个
</div>
<div v-bind:class="classObject"></div>  可以写变量，用vue传对象
```

#### 数组语法

```vue
<div v-bind:class="[activeClass, errorClass]"></div>
```

```
data: {
classList: ['link', 'item']
}
```



### 3.2 绑定内联样式

#### 对象语法

```vue
<div v-bind:style="{ color: activeColor, fontSize: fontSize + 'px' }"></div>
<div v-bind:style="styleObject"></div>
<p :style="{color:'purple', background:'pink'}">Lorem ipsum dolor sit amet.</p>
```

#### 数组语法

数组语法可以将多个样式对象应用到同一个元素上

```vue
<div v-bind:style="[baseStyles, overridingStyles]"></div>  数组的值为对象类型
<p :style="[styleObj, {borderWidth:'10px'}]">Lorem ipsum dolor sit amet.</p>
```

#### 数据驱动

```js
data: {
				styleValue: 'color:red;background:green',
				styleObj: {color:'pink',background:'#ccc'}
			}
```



#### 自动添加前缀

当 `v-bind:style` 使用需要添加浏览器引擎前缀的 CSS 属性时，如 transform，Vue.js 会自动侦测并添加相应的前缀。



## 4. 事件

### 本身是就是调用函数无参不用加括号methods可以执行的方法

##### 事件

```
<p @事件名="方法">
<p v-on:事件名="方法">
// 方法加括号的问题
<p @事件名="方法(1,2,3,4,$event)">
```

##### 事件修饰符

```
.stop  阻止事件冒泡
.prevent  阻止默认动作
.capture  捕获阶段，触发事件
.once  只绑定一次
.self  只有本身才触发
.passive  优化移动端的scroll事件

```

##### 键盘修饰符

```
.enter
.space
.tab
.up
.left
.right
.down
.delete
.数字(ascii)
```

##### 系统按键修饰符

```
.ctrl
.alt
.shift
.meta
// <input @keyup.ctrl.enter> 按住ctrl再按回车
```

### 4.1 事件绑定

#### 监听事件

```vue
<div id="example-1">
  <button v-on:click="counter += 1">Add 1</button>
  <p>The button above has been clicked {{ counter }} times.</p>
</div>
```

#### 事件处理方法

```vue
<div id="example-2">
  <!-- `greet` 是在下面定义的方法名 -->
  <button v-on:click="greet">Greet</button>
</div>
```

#### 内联调用方法

```vue
<div id="example-3">
  <button v-on:click="say('hi')">Say hi</button>
  <button v-on:click="say('what')">Say what</button>
</div>
```

有时也需要在内联语句处理器中访问原始的 DOM 事件。可以用特殊变量 $event 把它传入方法

```
@mousemove="onMoveFn($event, 100)"
methods: {
			    // 54.设置一个默认参数
				addCounter(num=1) {
					this.counter += num;
				},

				onMoveFn(ev, num) {
					console.log(ev.target)
					//ev 是获取的event 对象
					console.log(ev.pageX, ev.pageY)
				}
			}
```



```vue
<button v-on:click="warn('Form cannot be submitted yet.', $event)">
  Submit
</button>
```

### 4.2 事件修饰符

```
.stop  阻止事件冒泡
.prevent  阻止默认动作   
.capture   捕获阶段触发事件
.once      只绑定一次
.self      只有本身才触发
.passive   优化移动端的scroll事件

<p @click.stop="">
<p @click.stop.prevent="">
```



```
<!-- 阻止单击事件继续传播 阻止事件冒泡-->
<a v-on:click.stop="doThis"></a>

<!-- 提交事件不再重载页面 阻止默认事件-->
<form v-on:submit.prevent="onSubmit"></form>

<!-- 修饰符可以串联 阻止默认事件和事件冒泡 -->
<a v-on:click.stop.prevent="doThat"></a>

<!-- 只有修饰符 阻止事件的提交 -->
<form v-on:submit.prevent></form>

<!-- 添加事件监听器时使用事件捕获模式 -->
<!-- 即元素自身触发的事件先在此处处理，然后才交由内部元素进行处理 -->
<div v-on:click.capture="doThis">...</div>

<!-- 只当在 event.target 是当前元素自身时触发处理函数 -->
<!-- 即事件不是从内部元素触发的 -->
<div v-on:click.self="doThat">...</div>

<!-- 点击事件将只会触发一次 2.1.4新增-->
<a v-on:click.once="doThis"></a>

<!-- 滚动事件的默认行为 (即滚动行为) 将会立即触发 2.3.0新增-->
<!-- 而不会等待 `onScroll` 完成  -->
<!-- 这其中包含 `event.preventDefault()` 的情况 -->
<!--.passive 修饰符尤其能够提升移动端的性能。-->
<div v-on:scroll.passive="onScroll">...</div>
```

### 4.3 按键修饰符

#### 数字

```
<!-- 只有在 `keyCode` 是 13 时调用 `vm.submit()` -->
<input v-on:keyup.13="submit">
```

```
<!--65的按键对应的a的asill吗-->
				<input type="text" class="form-control" @keyup.65="onkeyupFn">
				<!--回车-->
				<input type="text" class="form-control" @keyup.enter="onkeyupFn">
				<!--ctrl+a-->
				<input type="text" class="form-control" @keyup.ctrl.65="onkeyupFn">
				
				
				
				methods: {
				boxFn(){
					console.log('box');
				},
				// 62.自动传人event
				innerFn(){
					console.log('inner');
					//event.stopPropagation();
				},
				// 63.asil吗
				onkeyupFn(event) {
					console.log('按了 '+event.keyCode+' 按键')
				}
			}
```



#### 按键别名

```
<!-- 回车键 -->
<input v-on:keyup.enter="submit">
```

- .enter  
- .tab
- .delete (捕获“删除”和“退格”键)
- .esc
- .space
- .up
- .down
- .left
- .right

可以通过全局 config.keyCodes 对象自定义按键修饰符别名：

```
// 可以使用 `v-on:keyup.f1`
Vue.config.keyCodes.f1 = 112
```





### 4.4 系统修饰键

可以用如下修饰符来实现仅在按下相应按键时才触发鼠标或键盘事件的监听器。

- .ctrl
- .alt
- .shift
- .meta

> 注意：在 Mac 系统键盘上，meta 对应 command 键 (⌘)。在 Windows 系统键盘 meta 对应 Windows 徽标键 (⊞)。在 Sun 操作系统键盘上，meta 对应实心宝石键 (◆)。在其他特定键盘上，尤其在 MIT 和 Lisp 机器的键盘、以及其后继产品，比如 Knight 键盘、space-cadet 键盘，meta 被标记为“META”。在 Symbolics 键盘上，meta 被标记为“META”或者“Meta”。

```
<!-- Alt + C -->
<input @keyup.alt.67="clear">

<!-- Ctrl + Click -->
<div @click.ctrl="doSomething">Do something</div>
```

## 表单输入绑定*

你可以用 `v-model` 指令在表单 `<input>` 及 `<textarea>` 元素上创建双向数据绑定。它会根据控件类型自动选取正确的方法来更新元素。

`v-model` 会忽略所有表单元素的 value、checked、selected 特性的初始值而总是将 Vue 实例的数据作为数据来源。你应该通过 JavaScript 在组件的 data 选项中声明初始值。

### 5.1 基础用法

#### 文本

```vue
<input v-model="message" placeholder="edit me">
<textarea v-model="message" placeholder="add multiple lines"></textarea>
```

#### 复选框

单个复选框，绑定到布尔值：

```vue

<input
  type="checkbox" 
  v-model="toggle"  // 他会变成yes和no
  true-value="yes"
  false-value="no"
>
用布尔值，可以指定 yes 和 no
```

#### 多个复选框

```javascript
<input type="checkbox" value="lanball" v-model="loveList">篮球
		<input type="checkbox" value="zuball" v-model="loveList">足球
		<input type="checkbox" value="bangball" v-model="loveList">棒球
		<input type="checkbox" value="paiball" v-model="loveList">排球
```



#### 多个复选框，绑定到同一个数组

```vue
<div id='example'>
  <input type="checkbox" id="jack" value="Jack" v-model="checkedNames">
  <label for="jack">Jack</label>
  <input type="checkbox" id="john" value="John" v-model="checkedNames">
  <label for="john">John</label>
  <input type="checkbox" id="mike" value="Mike" v-model="checkedNames">
  <label for="mike">Mike</label>
  <br>
  <span>Checked names: {{ checkedNames }}</span>
</div>
```

#### 单选按钮

绑定value对应的字符串

```vue
<div id="example">
  <input type="radio" id="one" value="One" v-model="picked">
  <label for="one">One</label>
  <br>
  <span>Picked: {{ picked }}</span>
</div>

 v-model  value值
```

#### 选择框



```vue
<div id="example">
  <select v-model="selected" multiple style="width: 50px;">
    <option value='A'>A</option>
    <option value='B'>B</option>
    <option value='C'>C</option>
  </select>
  <br>
  <span>Selected: {{ selected }}</span>
</div>

数组可以写一个默认值，
```

### 5.2 修饰符

#### .lazy

在默认情况下，v-model 在每次 input 事件触发后将输入框的值与数据进行同步

添加 lazy 修饰符，从而转变为使用 change 事件进行同步

失去焦点

```
<!-- 在“change”时而非“input”时更新 -->
<input v-model.lazy="msg" >
```

#### .number

如果想自动将用户的输入值转为数值类型，可以给 v-model 添加 number 修饰符

```
<input v-model.number="age" type="number">
```

#### .trim

自动过滤用户输入的首尾空白字符，可以给 v-model 添加 trim 修饰符

```
<input v-model.trim="msg">
```

## 表单数据

```js
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>表单</title>
	<link rel="stylesheet" href="../dist/css/bootstrap.css">
	<style>
	
	</style>
</head>
<body>

	<div id="app">
		<div class="container">
			<div class="page-header">
				<h1>表单提交</h1>
			</div>

			<div class="row">
				<div class="col-md-12">
					<form @submit.prevent="">
						<div class="form-group">
							<!--81.label绑定一下id-->
							<label for="a">用户名</label>
							<!--82.数据双向-->
							<input id="a" type="text" class="form-control" v-model="loginData.username" placeholder="请输入用户名">
						</div>

						<div class="form-group">
							<label for="#">密码</label>
							<input type="password" class="form-control" v-model="loginData.pwd">
						</div>

						<div class="checkbox">
							<label for="#">
								<input type="checkbox" v-model="loginData.remember"> 记住密码
							</label>
						</div>

						<button class="btn btn-success btn-block" @click="login()">登 录</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	

	<script src="../dist/js/vue.js"></script>
	<script>
		let vm = new Vue({
			el:'#app',
			data: {
				loginData: {
					username:'',
					pwd:'',
					remember: true
				}
			},
			methods: {
				login() {
					//获取所哟表单的值
					console.log(this.loginData)
				}
			}
		})
	</script>
</body>
</html>
```

## tolist

```js
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>todoList</title>
	<style>
		#app {
			margin:100px auto 0;
			width:600px;
		}
		.input-box {
			font-size:0;
		}
		.input-box input {
			box-sizing: border-box;
			width:500px;
			font-size:16px;
			border:1px solid #ccc;
			padding:10px;
			line-height: 18px;
		}
		.input-box button {
			width:100px;
			padding:10px;
			font-size:16px;
			border:1px solid #ccc;
			background: #f5f5f5;
			cursor: pointer;
			line-height: 18px;
			border-left:none;
		}
		ul {
			list-style: none;
			margin:0;
			padding:0;
		}
		.todo-list {
			margin-top:20px;
		}
		.todo-list li{
			border:1px solid #ccc;
			padding:10px;
			margin-bottom:10px;
			font-size:0;
		}
		.todo-list i {
			margin-right:20px;
			display: inline-block;
			width:16px;
			height:16px;
			border:1px solid #ccc;
			cursor: pointer;
			vertical-align: bottom;
		}
		.todo-list p {
			width:500px;
			display: inline-block;
			font-size:16px;
			margin:0;
		}
		.todo-list span {
			width:50px;
			cursor: pointer;
			color:red;
			font-size:16px;

		}
		.done-list {
			margin-top:20px;
		}
		.done-list li{
			border:1px solid #ccc;
			padding:10px;
			margin-bottom:10px;
			background: #999;
			color:#ccc;
			cursor: not-allowed;
			text-decoration: line-through;
		}
	</style>
</head>
<body>
	<div id="app">
		<div class="input-box">
			<!--91.trim去空格-->
			<input type="text" v-model.trim="newTodo" placeholder="请输入代办事项">
			<button @click="addTodo">添 加</button>
		</div>

		<div class="todo-list">
			<ul>
				<li v-for="(todo,index) in todoList" :key="index">
					<!--将i设置样式-->
					<i @click="addDone(index)"></i>
					<p>{{ todo }}</p>
					<span @click="deleteTodo(index)">&times;</span>
				</li>
			</ul>
		</div>

		<h3>已完成</h3>
		<div class="done-list">
			<ul>
				<li v-for="done in doneList" :key="done">{{ done }}</li>
			</ul>
		</div>
	</div>


	<script src="../dist/js/vue.js"></script>
	<script>
		new Vue({
			el:"#app",
			data: {
				todoList: ['今天代码敲三遍', '晚上和小莉莉去喝酒'],
				doneList: [],
				newTodo:''
			},
			methods: {
				addTodo() {
					//如果输入框是空的，不执行
					if (this.newTodo.length === 0) {
						return;
					}
					//添加内容到 代办事项
					this.todoList.push(this.newTodo)
					//清空输入框
					this.newTodo = '';
				},
				deleteTodo(index) {
					this.todoList.splice(index, 1)
				},
				addDone(index) {
					//把内容添加到 doneList
					this.doneList.push(this.todoList[index])
					//从todoList删掉
					this.deleteTodo(index);
				}
			}
		})
	</script>
</body>
</html>
```

