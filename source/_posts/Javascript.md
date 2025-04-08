---
title: Javascript
tags: [前端]
date: 2019-03-30 16:47:10
categories: 理解
photos:
book:
---

# JavaScript

## JavaScript 组成部分

 ECMAScript 核心语法 (ActionScript有使用ECMAScript语法)
 BOM 浏览器对象模型
 DOM 文档对象模型

## JavaScript基本语法

### 2.1 在HTML中使用JS

####  在`<script>`标签内 写代码

```
  <script>
      alert('hello world')
  </script>
```

####  引入外部 脚本文件

```
  <script src="./script.js"></script>
```

####  通过事件属性定义在元素内部

```
  <button onclick="alert('啊，好疼啊')">点我啊</button>
```

## 变量

### 变量的定义: 声明 + 初始化

```javascript
// ES5变量的定义

	// 注:ES5标准下无块级作用域,只有方法可以产生实际的局部作用域
	// 无块级作用域的局部变量
	var a = 10;
	// alert(a);
	// 全局变量
	b = 20;
	// alert(b);
```

### 方法的自调用,

就会产生一个局部作用域

```javascript
(function () {
		var x = 10;
		y = 20;
	})()

	// alert(x) 报错,x只能在局部作用域中使用
	// alert(y); 正常使用
```

### 无视块级作用域

```javascript
{
		var n = 10; // 无视块级作用域
		m = 20;  // 全局变量,更无视块级作用域
	}
	// alert(n)  // 可以
	// alert(m)  // 可以
```

### ES6变量的定义

// ES6变量的定义

#### 有块级作用域的let

```javascript
// 有块级作用域的局部变量
	let aa = 100;
	// alert(aa);
	// 有块级作用域的常量
	const bb = 200;
	// alert(bb);
```

```javascript
{
		let xx = 100;
		const yy = 200;
	}
	// alert(xx);  // 无法访问
	// alert(yy);  // 无法访问
	// 函数产生的局部作用域同该情况
```

#### let可以更改变量

```javascript
let nn = 100;
	nn = 200;
	// alert(nn);  // 200
```

#### const常量值不允许更改

```javascript
// MM = 2000;  // 常量值不允许更改
	// alert(MM);
```

#### 变量名的命名规范

```
① 可以由字母,数字,_,$组成,但是不能以数字开头(可以包含中文,采用小驼峰命名法)
② 区分大小写
③ 不能与关键字保留字重名
```

```js
var 变量名 = 值;
* var 关键字
* 变量名 由数字、字母、下划线、$ 组成 不能数字开头。 变量名不能使关键字
* 变量名严格区分大小写
* 变量声明 没给值，默认值是undefined
```

### 查看变量的值的方式

```
alert(a)
console.log(a)//控制台输出
document.write(a)//直接输出到页面
断点调试
```

## 弹框

### 弹出框alert

```
/ 弹出框: 一个弹出框只能弹出一条信息
	// alert("普通弹出框", "呵呵");  // 呵呵被忽略了	
```

### 确认框confirm

```
// var res = confirm("你是男的吗?");  // true | false
	// alert(res);
```

### 输入框prompt

```
// 输入框
	// var res = prompt("请输入你的小名!");  // 确定为输入值, 取消为null
	// alert(res);  
```

## 数据类型

### 1、值类型

####  number：数字类型

```js
var a = 10;
console.log(a, typeof a)
// 判断方式
console.log(typeof a == 'number')
```

####  string：字符串类型

```js
var a = '10';
console.log(a, typeof a)
// 判断方式
console.log(typeof a == 'string')
```

####  boolean：布尔类型

```js
var a = true;
console.log(a, typeof a)
// 判断方式
console.log(typeof a == 'boolean')
```

####  undefined：未定义类型

```js
var a = undefined;
console.log(a, typeof a)
// 判断方式
console.log(typeof a == 'undefined')
console.log(a == undefined)
```

undefined表示当声明一个变量但未初始化时，该变量的默认值是undefined。还有就是函数无明确的返回值时，返回的也是undefined。

### Null & Undefined类型

#### Undefined类型

Undefined 类型只有一个值，即 undefined。当声明的变量未初始化时，该变量的默认值是 undefined。

当函数无明确返回值时，返回的也是值 "undefined";

#### Null类型*

另一种只有一个值的类型是 Null，它只有一个专用值 null，即它的字面量。值 undefined 实际上是从值 null 派生来的，因此 ECMAScript 把它们定义为相等的。

尽管这两个值相等，但它们的含义不同。undefined 是声明了变量但未对其初始化时赋予该变量的值，null 则用于表示尚未存在的对象（在讨论 typeof 运算符时，简单地介绍过这一点）。如果函数或方法要返回的是对象，那么找不到该对象时，返回的通常是 null。

### 2、引用类型

###  function：函数类型

```js
var a = function(){};
console.log(a, typeof a)
// 判断方式
console.log(typeof a == 'function')
```

###  object：对象类型

```js
var a = {};
console.log(a, typeof a)
// 判断方式
console.log(typeof a == 'object')
console.log(a instanceof Object)
```

### 3、具体的对象类型

####  null：空对象

```js
var a = null;
console.log(a, typeof a)
// 判断方式
console.log(typeof a == 'object')
console.log(a == null)
```

####  Array：数组对象

instanceof运算符用于测试构造函数的prototype属性是否出现在对象的原型链中的任何位置 

```js
var a = new Array(1, 2, 3, 4, 5);
console.log(a, typeof a)
// 判断方式
console.log(typeof a == 'object')
console.log(a instanceof Object)
console.log(a instanceof Array)
```

####  Date：时间对象

```js
var a = new Date();
console.log(a, typeof a)
// 判断方式
console.log(typeof a == 'object')
console.log(a instanceof Object)
console.log(a instanceof Date)
```

####  RegExp：正则对象

```js
var a = new RegExp();
console.log(a, typeof a)
// 判断方式
console.log(typeof a == 'object')
console.log(a instanceof Object)
console.log(a instanceof RegExp)
```

## 开启严格模式

​		'use strict'
		

		var username = '小丽丽';
		//userage = 100; //严格模式下 声明变量必须加 var
	
		console.log(username)
## 类型转换

####  数字|布尔 转换为 字符串

```js
var a = 10 or true

String(a)

a.toString()
```

####  布尔|字符串 转换为 数字

```js
var a = true or '10'

Number(a)

+ a

parseFloat()
parseInt()
```

####  字符串|数字 转换为 布尔

```js
var a = 10 or '10'
Boolean(a)
```

####  自动转换

```js
5 + null  // 5
"5" + null  // "5nll"
"5" + 1  // "51"
"5"  1  // 4
```

####  特殊产物

```js
// NaN: 非数字类型
// 不与任何数相等，包含自己
// 利用isNaN()进行判断
```

#### 显示类型转换

- Number()
- parseInt()
- parseFloat()
- String()
- Boolean()

#### 自动类型转换

当JavaScript想使用A类型的值得时候,而你提供的是B类型的值,JavaScript会自动把B类型转换为A类型

#### 转换规则

| 原始值              | 转换为数字 | 转换为字符串      | 转换为布尔值 |
| ------------------- | ---------- | ----------------- | ------------ |
| false               | 0          | "false"           | false        |
| true                | 1          | "true"            | true         |
| 0                   | 0          | "0"               | false        |
| 1                   | 1          | "1"               | true         |
| "0"                 | 0          | "0"               | true         |
| "000"               | 0          | "000"             | true         |
| "1"                 | 1          | "1"               | true         |
| NaN                 | NaN        | "NaN"             | false        |
| Infinity            | Infinity   | "Infinity"        | true         |
| -Infinity           | -Infinity  | "-Infinity"       | true         |
| ""                  | 0          | ""                | false        |
| "20"                | 20         | "20"              | true         |
| "Runoob"            | NaN        | "Runoob"          | true         |
| [ ]                 | 0          | ""                | true         |
| [20]                | 20         | "20"              | true         |
| [10,20]             | NaN        | "10,20"           | true         |
| ["Runoob"]          | NaN        | "Runoob"          | true         |
| ["Runoob","Google"] | NaN        | "Runoob,Google"   | true         |
| function(){}        | NaN        | "function(){}"    | true         |
| { }                 | NaN        | "[object Object]" | true         |
| null                | 0          | "null"            | false        |
| undefined           | NaN        | "undefined"       | false        |

## 运算符

### 算术运算符：

    +   -    *    /     %       ++        -- 

### 比较运算符：

​    >   >=   <    <=    !=    ==    ===   !==

### 逻辑运算符：

​     &&   ||   ！

### 赋值运算符：

​    =  +=   -=  *=   /=

### 字符串运算符：

```
 + 连接，两边操作数有一个或两个是字符串就做连接运算
```

## 算术运算符

**注意1: 自加自减**

假如x=2，那么x++表达式执行后的值为3，x--表达式执行后的值为1；i++相当于i=i+1，i--相当于i=i-1；
递增和递减运算符可以放在变量前也可以放在变量后：--i

### 简单的说

#### i++

就是没有执行,将要执行

#### ++i

执行后的结果

```
var i=10;
console.log(i++);
console.log(i);
console.log(++i);
console.log(i);
console.log(i--);
console.log(--i);
```

### 注意2: 单元运算符

除了可以表示减号还可以表示负号  例如：x=-y 

除了可以表示加法运算还可以用于字符串的连接  例如：``"abc"``+``"def"``="abcdef"

### NaN

```javascript
   var d="yuan";
    d=+d;
    alert(d);//NaN:属于Number类型的一个特殊值,当遇到将字符串转成数字无效时,就会得到一个NaN数据
    alert(typeof(d));//Number

    //NaN特点:
    
    var n=NaN;
    
    alert(n>3);
    alert(n<3);
    alert(n==3);
    alert(n==NaN);
    
    alert(n!=NaN);//NaN参与的所有的运算都是false,除了!=
```

## 比较运算符

```
>
>=
<
<=
== 相等      两个操作数  只要值相等(类型不同会自动转换) 就相等   
=== 全等     类型和值都要相同才全等
!=  不得
!== 不全等
in 判断 数组的索引 和 对象的属性 是否存在
instanceof  一个对象是否属于某个构造函数(类)
```

### 用于控制语句时：

```
        if (2>1){       //  3  0  false null undefined ［］
            console.log("条件成立!")
        }
```

### 全等号和非全等号

等号和非等号的同类运算符是全等号和非全等号。这两个运算符所做的与等号和非等号相同，只是它们在检查相等性前，不执行类型转换。

```
console.log(2==2);
console.log(2=="2");
console.log(2==="2");
console.log(2!=="2");
```

## 逻辑运算符

```
&&   逻辑与and
||   逻辑或or
！   逻辑非not
```

```
if (2>1 && [1,2]){
    console.log("条件与")
}

// 思考返回内容?
console.log(1 && 3);
console.log(0 && 3);
console.log(0 || 3);
console.log(2 || 3);
```

## 一、分支结构

#### 1、if语句

- if 基础语法

```js
if (条件表达式) {
    代码块;
}
// 当条件表达式结果为true，会执行代码块；反之不执行
// 条件表达式可以为普通表达式
// 0、undefined、null、""、NaN为假，其他均为真
```

- if 复杂语法

```js
// 1.双分支
if (表达式1) {
    代码块1;
} else {
    代码块2;
}

// 2.多分支
if (表达式1) {
    
} else if (表达式2) {
    
} 
...
else if (表达式2) {
    
} else {
    
}
```

- if 嵌套

```js
if (表达式1) {
    if (表达式2) {
        
    }...
}...
```

#### 2、switch语句

```js
switch (表达式) {
    case 值1: 代码块1; break;
    case 值2: 代码块2; break;
    default: 代码块3;
}
// 1.表达式可以为 整数表达式 或 字符串表达式
// 2.值可以为 整数 或 字符串
// 3.break
// 4.default为默认代码块，需要出现在所有case最下方，在所有case均未被匹配时执行
```

## 二、循环结构

#### 1、for循环

```js
for (循环变量①; 条件表达式②; 循环变量增量③) {
    代码块④;
}
// 1.循环变量可以在外、在内声明
// 2.执行逻辑 ① ②④③ ... ②④③ ②，入口为①，出口为②，②④③个数为[0, n]
```

```
for (var i = 0; i < 5; i++) {
		document.write("</br><h1 style='margin: 0'>学习使我快乐!</h1>");
```

#### 2、while循环

```js
while (条件表达式) {
    代码块;
}
```

#### 3、do...while循环(最少执行一次)

```js
do {
    代码块;
} while (条件表达式);
// 与while不同，是先执行一次函数体代码，再去判断
```

#### 4、for...in循环

```js
obj = {"name": "zero", "age": 8}
for (k in obj) {
    console.log(k, obj[k])
}
// 用于遍历对象：遍历的结果为key，通过[]语法访问对应的value
```

#### 5、for...of循环

```js
iter = ['a', 'b', 'c'];
for (i of iter) {
    console.log(iter[i])
}
// 1.用于遍历可迭代对象：遍历结果为值
// 2.ES6新增，可迭代对象有 字符串、数组、Map、Set、Anguments、NodeList等
```

#### 1.用于遍历可迭代对象：

遍历结果为value

​	// 2.ES6新增，可迭代对象有 字符串、数组、Map、Set、Anguments、NodeList等

#### 6、break，continue关键词

- break：结束本层循环
- continue：结束本次循环进入下一次循环

## 三、异常处理

```js
try {
    易错代码块;
} catch (err) {
    异常处理代码块;
} finally {
    必须逻辑代码块;
}
// 1.err为存储错误信息的变量
// 2.finally分支在异常出现与否都会被执行
```

```js
throw "自定义异常"
// 必要的时候抛出自定义异常，要结合对应的try...catch使用
```

```javascript
<script type="text/javascript">
	while (1) {
		var num1 = + prompt("请输入第一个数字:");
		var num2 = + prompt("请输入第二个数字:");

		var res = num1 + num2;

		try {
			if (isNaN(res)) throw "计算有误!";
			alert(res);
			break;
		} catch (err) {
			console.log("异常:" + err);
		} finally {
			console.log('该语句一定会被执行,一次try逻辑执行一次');
		}
	}

	
</script>
```

## 函数

### 函数的定义

虽然由于字符串的关系，第二种形式写起来有些困难，但有助于理解函数只不过是一种引用类型，它们的行为与用 Function 类明确创建的函数行为是相同的。 

```javascript
//1.
function 函数名 (参数){<br>    函数体;
    return 返回值;
}
//2.
var 函数名 = new Function("参数1","参数n","function_body");
// 3. ES6
let 函数名 = (参数列表) => {
    函数体;
}
```

```javascript
function func1(name){
    alert('hello'+name);
    return 8
}

    ret=func1("yuan");
    alert(ret);


var func2=new Function("name","alert(\"hello\"+name);")
func2("egon")
```

### 函数调用

```
function func1(a,b){

    alert(a+b);
}

    func1(1,2);  //3
    func1(1,2,3);//3
    func1(1);    //NaN
    func1();     //NaN

    //只要函数名写对即可,参数怎么填都不报错.
```

#### 面试题

```
函数名a背定义了

function a(a,b){
    alert(a+b);
}

   var a=1;
   var b=2;
   a(a,b)
```

###  匿名函数

```js
function (参数列表) {
    函数体;
}

// 匿名函数需要自调用
(function (参数列表) {
    函数体;
})(参数列表);

// 3.匿名函数
	// (function () {
	// 	console.log("匿名函数");
	// })

	// 匿名函数定义后,无法使用,所以只能在定义阶段自调用
	let d = "匿名";
	(function (t) {
		console.log(t + "函数");
	})(d);
```

### 函数的内置对象arguments

```javascript
function add(a,b){

        console.log(a+b);//3
        console.log(arguments.length);//2
        console.log(arguments);//[1,2]

    }
    add(1,2)

    ------------------arguments的用处1 ------------------
    function nxAdd(){
        var result=0;
        for (var num in arguments){
            result+=arguments[num]
        }
        alert(result)

    }

    nxAdd(1,2,3,4,5)

//     ------------------arguments的用处2 ------------------

    function f(a,b,c){
        if (arguments.length!=3){
            throw new Error("function f called with "+arguments.length+" arguments,but it just need 3 arguments")
        }
        else {
            alert("success!")
        }
    }

    f(1,2,3,4,5)
```



### 函数提升

```javascript
<script>
    //f(); --->OK

    function f(){
        console.log("hello")

    }

    f() //----->OK
</script>
```

### 定义函数内的变量

```javascript
function demo(a, b) {
			/*
			ES6之间 默认值的写法  了解
			if (b === undefined) {
				b = '默认值'
			}*/
			console.log(a+' 和 '+b+' 正在一起交友');
		}
function fn(a, b='小梅梅') {
			console.log(`${a} 和 ${b} 一起跳舞`);
		}
		
```

### arguments

```javascript
//可变数量的参数
		//声明函数 实现 所有参数累加的和
		function sum() {
			//arugments 只能在函数里面用
			var s = 0;
			
			//遍历 arguments 取出其中的每一个值
			for (var i = 0; i < arguments.length; i ++) {
				s += arguments[i]
			}

			//返回
			return s;

		}

		console.log(sum(1,2,3,4))
		console.log(sum(1,2,3,4,123,123,1231231,123123123123))
```

### 函数的参数

#####  个数不需要统一多了丢弃

```js
function fn (a, b, c) {
    console.log(a, b, c)  // 100 undefined undefined
}
fn(100)

function fn (a) {
    console.log(a)  // 100
}
fn(100, 200, 300)  // 200,300被丢弃
```

#####  可以任意位置具有默认值

```js
function fn (a, b=20, c, d=40) {
    console.log(a, b, c, d)  // 100 200 300 40
}
fn(100, 200, 300)
```

#####  不定长参数...语法接收多个值

```js
function fn (a, ...b) {
    console.log(a, b)  // 100 [200 300]
}
fn(100, 200, 300)
// ...变量必须出现在参数列表最后
```

##### 4、返回值

```js
function fn () {
    return 返回值;
}
// 1.可以空return操作，用来结束函数
// 2.返回值可以为任意js类型数据
// 3.函数最多只能拥有一个返回值
```

```javascript
<script type="text/javascript">
	// 返回值
	// 1.空返回
	var func1 = function (num) {
		if (num == 0) return; // 用来结束函数
		console.log('num: ', num);
	}
	func1(100);

	// 2.返回值类型任意,但只能为一个值
	var func2 = function (a, b) {
		// return a, b, a + b; // 不报错,但只返回最后一个值
		return a + b;
	}
	// 注:函数返回值就是函数的值,外界可以用变量结束函数执行后的函数值
	var res = func2(10, 20);
	console.log("和:%d", res);

</script>
```

### 函数回调

```js
// 回调的函数
function callback(data) {}
// 逻辑函数
function func(callback) {
    // 函数回调
    if (callback) callback(data);
}

// 函数回调的本质：在一个函数中(调用函数)，当满足一定条件，调用参数函数(回调函数)
// 回调函数作为调用函数的参数传入
// 回调函数通过参数将调用还是内部数据传出
```

### 闭包

```js
function outer() {
    var data = {}
    function inner() {
        return data;
    }
    return inner;
}

// 闭包目的：不允许提升变量作用域时，该函数的局部变量需要被其他函数使用
// 闭包本质：函数的嵌套，内层函数称之为闭包
// 闭包的解决案例：①影响局部变量的生命周期，持久化局部变量；②解决变量污染
```

### 二、循环绑定

```html
.html文件
<ul>
	<li>列表项</li>
    <li>列表项</li>
    <li>列表项</li>
</ul>
```

```js
.js文件
var lis = document.querySelector('li');
for (var i = 0; i < lis.length; i++) {
    lis[i].onclick = function () {
        // 打印列表项的索引
		console.log(i);
	}
}
// 变量污染
// 获取局部作用域解决
// 闭包解决
// 对象属性解决
```

## 函数高级

#### 1、函数回调

```js
// 回调的函数
function callback(data) {}
// 逻辑函数
function func(callback) {
    // 函数回调
    if (callback) callback(data);
}

// 函数回调的本质：在一个函数中(调用函数)，当满足一定条件，调用参数函数(回调函数)
// 回调函数作为调用函数的参数传入
// 回调函数通过参数将调用还是内部数据传出
```

#### 2、闭包

```js
function outer() {
    var data = {}
    function inner() {
        return data;
    }
    return inner;
}

// 闭包目的：不允许提升变量作用域时，该函数的局部变量需要被其他函数使用
// 闭包本质：函数的嵌套，内层函数称之为闭包
// 闭包的解决案例：①影响局部变量的生命周期，持久化局部变量；②解决变量污染
```

## 二、循环绑定

```html
.html文件
<ul>
	<li>列表项</li>
    <li>列表项</li>
    <li>列表项</li>
</ul>
```

```js
.js文件
var lis = document.querySelector('li');
for (var i = 0; i < lis.length; i++) {
    lis[i].onclick = function () {
        // 打印列表项的索引
		console.log(i);
	}
}
// 变量污染
// 获取局部作用域解决
// 闭包解决
// 对象属性解决
```

## 三、面向对象JS

#### 1、属性与方法

```js
var obj = {}; | var obj = new Object();
// 属性
obj.prop = "";
// 方法
obj.func = function () {}
// 删除属性与方法
delete obj.prop
delete obj.func
```

#### 2、类字典结构使用

 结构

```js
var dict = {name: "zero", age: 18}
```

 拓展

```js
var dict = {"myname": "zero", fn: function () {}, fun () {}}
```

 使用

```js
dict.name | dict["myname"] | dict.fn()
```

#### 3、构造函数（ES5）

```js
function People(name, age) {
    this.name = name;
    this.age = age;
    this.eat = function () {
        return 'eat';
    }
}
```

#### 4、继承（ES5）

```js
// 父级
function Sup(name) {
    this.name = name;
    this.fn = function () {
        console.log('fn class');
    }
}
// 原型
console.log(Sup.prototype);
console.log(sup.__proto__);
// 子级
function Sub(name) {
    // 继承属性
    Sup.call(this, name);
}
// 继承方法
Sub.prototype = new Sup;
// 创建子级对象
var sub = new Sub("subClass");
// 使用属性
console.log(sub.name);
// 使用方法
sub.fn();

// 指向自身构造函数
Sub.prototype.constructor = Sub;
```

#### 5、类及继承（ES6）

```js
// 父类
class People {
    // 构造器
    constructor (name, age) {
        this.name = name;
        this.age = age;
    }
    // 实例方法
    eat () {
        console.log('吃吃吃');
    }
    // 类方法
    static create () {
        console.log('诞生');
    }
}
// 子类
class Student extends People {
    constructor (name, age) {
        // super关键词
        super(name, age)
    }
}
```

## 六、JS选择器

#### 1、getElement系列

```js
// 1.通过id名获取唯一满足条件的页面元素
document.getElementById('id名');
// 该方法只能由document调用

// 2、通过class名获取所有满足条件的页面元素
document.getElementsByClassName('class名');
// 该方法可以由document及任意页面元素对象调用
// 返回值为HTMLCollection (一个类数组结果的对象，使用方式同数组)
// 没有匹配到任何结果返回空HTMLCollection对象 ([])

// 3.通过tag名获取所有满足条件的页面元素
document.getElementsByTagName('tag名');
// 该方法可以由document及任意页面元素对象调用
// 返回值为HTMLCollection (一个类数组结果的对象，使用方式同数组)
// 没有匹配到任何结果返回空HTMLCollection对象 ([])
```

#### 2、querySelect系列

```js
// 1.获取第一个匹配到的页面元素
document.querySelector('css语法选择器');
// 该方法可以由document及任意页面对象调用

// 2.获取所有匹配到的页面元素
document.querySelectorAll('css语法选择器');
// 该方法可以由document及任意页面对象调用
// 返回值为NodeList (一个类数组结果的对象，使用方式同数组)
// 没有匹配到任何结果返回空NodeList对象 ([])
```

#### 3、id名

 可以通过id名直接获取对应的页面元素对象，但是不建议使用

# 内置对象

### number

#### 2、常用进制

```js
二进制：0b1010
八进制：012
十进制：10
十六进制：0xA
```

#### 3、NaN

```js
类型为Number,但非常规数字，与任何值都不相等，通过isNaN()进行判断
```

#### 4、常用常量

```js
最大值：MAX_VALUE(1.7976931348623157e+308)
最小值：MIN_VALUE(5e324)
正负无穷：NEGATIVE_INFINITY | POSITIVE_INFINITY(Infinity | Infinity)
```

#### 5、常用实例方法

```js
toExponential(n) => 3.14.toExponential(1) => 3.1e+0 (先科学记数，再确定精度，n为小数精度)
toFixed(n) => 3.14.toFixed(1) => 3.1 (先确定精度，再普通记数，n为小数精度)
toPrecision(n) => 13.14.toPrecision(1|2) => 1e+1|13 (先确定精度，再记数，n为位数精度)
toString(n) => 转换为指定进制的字符串，n代表进制
```

###### vhint：经典bug数字13.145

#### 1.1 属性

#####  MAX_VALUE 

JS可以表示的最大的数字

#####  MIN_VALUE

 JS可以表示的最小的数字

#### 1.2 方法

#####  toFixed(length)

 指定保留长度的小数

#####  toExponential()

 用科学计数法表示

#####  toPrecision(length)

 要求数字按照指定长度显示 整数+小数

#####  toString(number)

 把数字转换为字符串 可以按照指定的 进制 返回

```javascript
       var n1 =100;
        var n2 =new Number(100);

        console.log(n1);
        console.log(n2);
        //如果自动转换了   就能相等
        console.log(n1== n2);
        // 直接是不相等的
        console.log(n1===n2);
        //查看构造函数是谁
        console.log(n1.constructor);

        //查看最大最小的数值
        console.log(Number.MAX_VALUE)
        console.log(Number.MIN_VALUE)

        //编程字符串100
        console.log(typeof  n1.toString())
        // console.log()


        //用这个比较方便   可以直接把一个10进制的进行转换
        console.log(n1.toString(2)) //二进制输出   
        console.log(n1.toString(8)) //8进制输出

        //这个不光可以取得整数  并且还可以 选择保留的小数
        console.log(n1.toFixed())
        console.log(10.354.toFixed())
        console.log(10.354.toFixed(1))
        console.log(10.354.toFixed(2))

```

### String

#### 常用字符串

```
'string' | "string" | 'my name is "zero"' | "I'm boy" | "I \"love\" you"
```



#### 2.1 属性

#####  length

 字符串长度

#### 2.2 方法

#####  indexOf(str)

 返回小字符串在字符串对象中第一次出现位置 1表示不存在

```javascript
console.log(message.indexOf('o')); 
```

#####  lastIndexOf() 

返回小字符在字符串中最后一次出现的位置

#####  substr(start, length)

 截取字符串 省略长度截取到结束

#####  substring(start, end)

 截取字符串, 省略结束位置 一直到最后

#####  slice(start, end)

 与substring 一模一样

#####  split(char) 

把字符串分割为数组

#####  toUpperCase() 

把字符串转为大写

#####  toLowerCase()

 把字符串转为小写

#####  match()

 匹配字符串 可用正则

#####  search()

 查找字符串 可用正则

#####  replace()

 替换字符串可用正则

#####  charCodeAt()

 返回在指定的位置的字符的 Unicode 编码。

#####  String.formCharCode()

 从字符编码创建一个字符串。

```javascript
var message = 'i love you hello 你';


		console.log(message.length);  //字符的个数
		console.log(message[3]);


		//方法
		console.log(message.charAt(3)); //返回指定位置的字符
		console.log(message.indexOf('o')); //返回指定的字符串(字符串) 第一次出现的位置
		console.log(message.indexOf('love')); //返回指定的字符串(字符串) 第一次出现的位置
		console.log(message.lastIndexOf('o')); //返回指定的字符串(字符串) 最后一次出现的位置

		console.log(message.substr(4)); //截取
		console.log(message.substr(4, 5)); //截取 从第4开始截取5个
		console.log(message.substring(4))
		console.log(message.substring(4,6)); //从第4个到第6个（不包含第6个）
		console.log(message.slice(4,6));//同上

		//把字符串分隔成 数组
		console.log(message.split(' '));


		console.log(message.toUpperCase())
		console.log(message.toLowerCase())

		console.log(message.replace('o', '偶'));
		console.log(message.replace(/o/g, '偶'));

		console.log(message.trim());


		console.log(message.indexOf('哈哈哈')); //返回指定的字符串(字符串) 第一次出现的位置
```

### Array

#### 3.1 创建数组

 使用直接量 `[]`
 构造函数方式 `new Array()`

```javascript
创建方式1:
var arrname = [元素0,元素1,….];          // var arr=[1,2,3];

创建方式2:
var arrname = new Array(元素0,元素1,….); // var test=new Array(100,"a",true);

创建方式3:
var arrname = new Array(长度); 
            //  初始化数组对象:
                var cnweek=new Array(7);
                    cnweek[0]="星期日";
                    cnweek[1]="星期一";
                    ...
                    cnweek[6]="星期六";
```

##### 创建二维数组：

```
var cnweek=new Array(7);
for (var i=0;i<=6;i++){
    cnweek[i]=new Array(2);
}
cnweek[0][0]="星期日";
cnweek[0][1]="Sunday";
cnweek[1][0]="星期一";
cnweek[1][1]="Monday";
...
cnweek[6][0]="星期六";
cnweek[6][1]="Saturday";
```

#### 3.2 数组特点

 索引必须连续
 如果索引不连续，会产生稀疏数组

#### 3.3 数组的遍历(迭代)

 for 循环遍历
 for...in 循环
 for...of 循环

#### 3.4 数组元素的添加和删除

##### 添加

 为新索引赋值
 利用数组长度,在数组尾部插入新元素
 push()
 unshift()
 splice()

##### 删除

 改变数组长度

 pop()

 shift()

 splice()

 运算符 delete

#### 3.5 数组对象属性

#####  length

 数组长度 元素个数

#### 3.6 数组对象方法

#####  splice()

> 删除指定位置指定个数的元素
>
> > 替换指定位置指定个数的元素
> > 添加指定位置的元素
> > 返回 被删除的元素组成的数组

```javascript
//指定位置追加

list.splice(3,0,'小丽丽','大丽丽')
//删除第一个
		list.shift();
		//删除指定位置
		list.splice(4,1)

//修改数组中的元素,指定位置追加
		list[2] = '老丽丽';
		list.splice(2, 2, '小芳','小芳她妹','小芳她姐')


		console.log(list);
```

#####  reverse()

 翻转数组

```
arr1.reverse(); //颠倒数组元素
```

#####  sort()

 数组排序

```javascript
list.sort(function(v1, v2) {
            return v1-v2;
        });
        // `sort 内部的原理是  把连续的两个值拿出来
        //  给一个函数  如果这个函数的返回值是负数的话 会把这两个数换位值 `
        //
        // `如 1 ,3,5,1,6`
        // `第一次 1 3`
        // `第二次 3 5`
        // `第三次 5 1`
        // `然后借用一个  匿名函数  来判断正负 `
```

#####  push() 和 pop()

 在数组的最后添加或删除元素

#####  unshift()和shift() 

在数组的最前面添加或删除元素

#####  toString() 和 toLocalString()

 把数组转换为字符串

#####  join() 

把数组的元素拼接成字符串

```
// [1,2,3].join("@"); 与Python不同，python中join属于字符串的方法
```



#####  slice()

 截取数组中的一部分,返回新的数组 slice(start, end)

#####  concat() 

合并多个数组

```javascript
console.log(list.concat([1,2,3], ['a','b','c']))
```

#####  indexOf()

 搜索数组中的元素，并返回它所在的位置。

```javascript
//切记  如果没有会返回-1  查询到符合条件的第一个
        console.log(list.indexOf(2)); //查询某字符 
```



#####  lastIndexOf()

 返回一个指定的字符串值最后出现的位置，在一个字符串中的指定位置从后向前搜索。

```javascript
查询的是符合条件的最后一个元素的位置
        console.log(list.lastIndexOf(301));
```

##### includes(ele, n)：

从索引n开始往后，元素ele是否在数组中，做全等匹配，索引从头开始n可以省略(in只做值匹配)

##### fill(ele)：

以指定元素填充整个数组（一般用于清空数组中的数据，不操作长度）

#####  forEach()

 遍历 循环

```javascript
var arr=[10,20,30,40]

        //第一种 正常遍历
        for (var i=0;i<arr.length;i++){
            console.log(arr[i])
        }
    //    第二种  不牛逼的for in
    //(var i in arr)
        for (var i in arr){
            //便利出来的  也是  索引

            //除了条件和第一种不了一样  其余的都一样
            console.log(arr[i])
        }

    //    第三种   forEach
    //    对象.forEach(function(值  和  索引){})
    //    注意千万别写反了
        arr.forEach(function (value,index) {

             console.log(index+'=>'+value)

        })
```



#####  map()映射

 通过指定函数处理数组的每个元素，并返回处理后的数组。

```javascript
//    map的应用  映射
    //    数组.map(匿名函数(值,索引))
    //     每取出来一次值和索引 都将会调用一次匿名函数
    //    在匿名函数里的值处理一下 并且  把返回的值存到一个新的数组
        var arr= list.map(function (value,index) {
            return value+100;

        })

        console.log(arr)
```



#####  filter() true的便利出来的值

检测数值元素，并返回符合条件所有元素的数组。

```javascript
//    filter的应用  取档次函数返回为true的便利出来的值
        var arr = list.filter(function (value, index) {

            if (value>1){
                return true
            }else{
                return false
            }
        })
        console.log(arr)
```



#####  every()全部为真才为真

 检测数值元素的每个元素是否都符合条件。

```javascript
//every 全部为真才为真
    var res = list.every(function (value,index) {
        return value >1;
    });
    console.log(res)
```



#####  some()有一真则为真

 检测数组元素中是否有元素符合指定条件。

```javascript
//    some 返回布尔值  有一真则为真
    var res=list.some(function(value,index) {
        return value >5;
    })
    console.log(res)
```



#####  reduce()

 将数组元素 索引值从低到高 进行组合 reduceRight() 将数组元素 索引值从高到低进行组合

##### prev阶乘

```
//   prev 第一次的值为1
    //    余下的每一次 prev的值都是上一次的返回结果
    //    可以实现累加  或者阶乘的效果
    var res=list.reduce(function (prev,value,index) {
        return prev*value;

    })
    console.log(res)
```



```javascript
var list=[1,2,4,5,5,2,2,2,5,10];
        console.log(list)

        //翻转  和  排序  会改变原来的数组
        list.reverse();
        console.log(list);



        list.sort(function(v1, v2) {
            return v1-v2;
        });
        // `sort 内部的原理是  把连续的两个值拿出来
        //  给一个函数  如果这个函数的返回值是负数的话 会把这两个数换位值 `
        //
        // `如 1 ,3,5,1,6`
        // `第一次 1 3`
        // `第二次 3 5`
        // `第三次 5 1`
        // `然后借用一个  匿名函数  来判断正负 `

        console.log(list)

    //   对象.join(','); 拼成字符串
        str =list.join('%%%%')  //新拼接出来的字符串以什么符号相连
        //上面的括号里面一般是以逗号相连
        console.log(str)




        //数组没有+  说以我们只能用concat
        console.log(list.concat([1,2,3],[2,4,4,]));
        console.log(list.slice(1,4));//切片  顾头不顾尾

        //切记  如果没有会返回-1  查询到符合条件的第一个
        console.log(list.indexOf(2)); //查询某字符 在第几个元素
        //       如果没有会返回-1  查询的是符合条件的最后一个元素的位置
        console.log(list.lastIndexOf(301));

    //    map的应用  映射
    //    数组.map(匿名函数(值,索引))
    //     每取出来一次值和索引 都将会调用一次匿名函数
    //    在匿名函数里的值处理一下 并且  把返回的值存到一个新的数组
        var arr= list.map(function (value,index) {
            return value+100;

        })

        console.log(arr)


    //    filter的应用  取档次函数返回为true的便利出来的值
        var arr = list.filter(function (value, index) {

            if (value>1){
                return true
            }else{
                return false
            }
        })
        console.log(arr)

    //every 全部为真才为真
    var res = list.every(function (value,index) {
        return value >1;
    });
    console.log(res)

    //    some 返回布尔值  有一真则为真
    var res=list.some(function(value,index) {
        return value >5;
    })
    console.log(res)


    //   prev 第一次的值为1
    //    余下的每一次 prev的值都是上一次的返回结果
    //    可以实现累加  或者雷乘的效果
    var res=list.reduce(function (prev,value,index) {
        return prev*value;

    })
    console.log(res)
```

##  Function

#### this

```
//这个是 如果  这个出现了一个 xxx=function aa(){}
        //这种的this是  xxx
        //但是  如果  没有等于的这种形式   那么就是  window


        //这么说来应该是  地下如果 有 new  那么  this 代表的是这个对象
        //如果没有的话  this代表的应该是构造函数
```



#### 5.1 属性

prototype 原型

##### length 

形参的数量

#### 5.2 方法

##### apply()

 将函数作为一个对象的方法调用

```javascript
//apply 调用函数，改变函数内的this的志向
		demo.apply({name:'lili'}, [10,'hello',30]);
```

##### call()

 将函数作为对象的方法调用

```javascript
demo.call({name:'xiaofang'}, 10, 20, 40);
```

###### 借别人的方法(不要脸)

```javascript
var obj = {}; //对象
		[].push.call(obj, 300)
		console.log(obj);


		console.log('')


		function fn() {
			//遍历所有的实参
			//这个是 改变了  [] 的this   原来this 指向的是自己
			//现在this 指向的是 arguments
			//相当于 arguments 借用了 []  的方法

			//再次强调 arguments  直接写在了这里  就能用
			//代表一个接受了  全部参数的变量

			[].forEach.call(arguments, function(val, index){
				console.log(val)
			})
		}

		fn(10,203,34,2342,243,34,'hello');
```

##### bind()

 返回一个作为方法调用的函数

### 数组去重

```javascript
 var aa=[1,1,4,4,1,2,4,4,1,23,455,6]
    //   我们可以利用一个函数将他去重  并把返回值  直接付给aa
        function unique(aa) {
            var bb=[];
            //便利一边  aa  然后我们根据  bb中是否有这个值
            //来去 为bb添加值
            aa.forEach(function (val, index) {
                if (bb.indexOf(val)===-1){
                    bb.push(val)
                }
            })
            return bb

        }

        aa= unique(aa)
        console.log(aa)

    //    总结  这种题  是  去重 如果需要创建新的列表
    //    我们就需要 把他转化为  一个列表的值根据另一个列表来判断
    //    所以  原始的列表  一定要写在外面
    //    终归是一个谁来映射谁的问题
```

```javascript
arr=[1,1,1,4,3,2,2,4]
        // console.log(arr)
        //首先我们做一个函数
        // 并且把这个函数的返回值
        // 给做成不重复的列表
        function uniqueArray(arr) {
            //定义上一个空列表
            var newArr =[];
            //用foreach  拿到 value 和 index  foreach 里面有value和 index
            //我们  就往另一个添加就好了  indexof 可以判断是否有这个值
            //而我们只要没有的那种情况
            arr.forEach(function (val, index) {
                //如果 判断 一个数组中是否有  这个值
                //如果没有回返回-1
                //没有的情况  我们就添加上  就会避免 重复的现象
                if(newArr.indexOf(val)===-1){
                    newArr.push(val)
                }

            })
            return newArr;

        }
        arr =  uniqueArray(arr)
        console.log(arr)
```



## 6 Math

```
console.log(Math);
		console.log(typeof Math);
		console.log(Math.constructor);
```

![1553954656993](Javascript\1553954656993.png)

### 6.1 属性

#### PI

 返回圆周率（约等于3.14159）。

### 6.2 方法

#### abs(x) 

返回数的绝对值。

#### sqrt(x)

 返回数的平方根。

#### pow(x,y)

 返回 x 的 y 次幂。

#### ceil(x)

 对数进行上舍入

```javascript
console.log(Math.ceil(12.0001)); //取整数，进位取整 往大了取
```



#### floor(x) 

对数进行下舍入。

```javascript
console.log(Math.floor(12.9998)); //取整数，舍位取整  往下了取
```

#### round(x)

 把数四舍五入为最接近的整数。

#### max(x,y)

 返回 x 和 y 中的最高值。

```javascript
console.log(Math.max(10,20,1,45,3)); //可变参数数量  取最大值
```

#### min(x,y)

 返回 x 和 y 中的最低值。

```javascript
console.log(Math.min(10,20,1,45,3)); //可变参数数量  取最小值
```

#### random()

 返回 0 ~ 1 之间的随机数。

```javascript
//取随机数
		console.log(Math.random()); //0到1之间  0可能会被取到 1不可能

		//取 0到10之间的随机数
		console.log( Math.floor(Math.random() * 11));

		//0到11
		console.log( Math.round(Math.random() * 11));

		//0到28
		console.log(Math.floor(Math.random() * 29));


		//7-17随机数
		//取0~10 + 7
		console.log(Math.floor(Math.random() * 11) + 7);

```



## 7 Date

### 7.1 方法

 getYear() 请使用 getFullYear() 方法代替。

####  getFullYear()

 从 Date 对象以四位数字返回年份。
 getMonth() 从 Date 对象返回月份 (0 ~ 11)。
 getDate() 从 Date 对象返回一个月中的某一天 (1 ~ 31)。
 getDay() 从 Date 对象返回一周中的某一天 (0 ~ 6)。
 getHours() 返回 Date 对象的小时 (0 ~ 23)。
 getMinutes() 返回 Date 对象的分钟 (0 ~ 59)。
 getSeconds() 返回 Date 对象的秒数 (0 ~ 59)。
 getMilliseconds() 返回 Date 对象的毫秒(0 ~ 999)。
 getTime() 返回 1970 年 1 月 1 日至今的毫秒数。
 getTimezoneOffset() 返回本地时间与格林威治标准时间 (GMT) 的分钟差。
 getUTC.... 标准时区
 set...
 setUTC...
 toTimeString() 把 Date 对象的时间部分转换为字符串。
 toDateString() 把 Date 对象的日期部分转换为字符串。
 toUTCString() 根据世界时，把 Date 对象转换为字符串。
 toLocaleString() 根据本地时间格式，把 Date 对象转换为字符串。
 toLocaleTimeString() 根据本地时间格式，把 Date 对象的时间部分转换为字符串。
 toLocaleDateString() 根据本地时间格式，把 Date 对象的日期部分转换为字符串。

```javascript
//获取日期对象
		var date = new Date();

		date.setFullYear(1978);//可以修改
		date.setUTCHours(1);// 修改时区加1小时

		console.log(date);

		// 2018-08-13 12:34:23
		console.log(date.getFullYear());	
		console.log(date.getMonth() + 1);	
		console.log(date.getDate());
		console.log('星期', date.getDay());


		console.log(date.getHours())
		console.log(date.getMinutes())
		console.log(date.getSeconds())
		console.log(date.getMilliseconds())


		//时间戳
		console.log(date.getTime()); //单位是毫秒


		//0时区的时间
		console.log(date.getUTCFullYear())
		console.log(date.getUTCDate())
		console.log(date.getUTCHours())
```

## 8 RegExp

### 8.1 属性

 global RegExp 对象是否具有标志 g。
 ignoreCase RegExp 对象是否具有标志 i。
 lastIndex 一个整数，标示开始下一次匹配的字符位置。
 multiline RegExp 对象是否具有标志 m。
 source 正则表达式的源文本。

### 8.2 方法

#### 创建正则对象

```javascript
// 构造函数
var re = new RegExp('^\\w', 'igm');
// 字面量
		var r = /^\w{4,6}$/;
```

####  exec()返回一个数组的索引位置

 检索字符串中指定的值。返回找到的值，并确定其位置。

```javascript
console.log(r.exec('abc_nb')); // 返回数组 第一个元素 匹配到的内容，index指定匹配的位置
```

#### search()匹配不到返回-1

匹配指定正则，结果为匹配的索引，反之1

```
//字符串 方法匹配正则
		var msg = 'hello world';
		console.log(msg.search(/\w/)); //返回第一次匹配的位置
		console.log(msg.search(/o/)); //返回第一次匹配的位置
		console.log(msg.search(/哈/)); //返回第一次匹配的位置 匹配不到返回-1
```

#### match()返回一个数组本身

匹配指定正则，结果为数组(可全文匹配)

```javascript
console.log(msg.match(/\w/)); //返回数组，数组中有 被匹配到的内容
		//["h", index: 0, input: "hello world", groups: undefined]
		console.log(msg.match(/\w/g)); //匹配出 所有满足正则的字符串
		//(10) ["h", "e", "l", "l", "o", "w", "o", "r", "l", "d"]
```

#### replace(re, newStr)

匹配指定正则，替换匹配的结果(可全文匹配)

```javascript
console.log(msg.replace(/o/g, '偶'))
```

#### split(re, n)

```js
按正则进行拆分，n的值可以决定结果的数组长度(可选参数)
```



#### 2、修饰符

##### i

不区分大小写

##### g

：全文匹配

##### m

：多行匹配

#### test() 

检索字符串中指定的值。返回 true 或 false。

```javascript
console.log(r.test('abc')); //返回布尔值
		console.log(r.test('abc12'))
```



## 9 JSON

### 9.1方法

 JSON.parse() 解析json格式的字符串
 JSON.stringify() 序列化对象 数组 或 原始值

## 10 Global

### 10.1 属性

 NaN
 InFinity

### 10.2 方法

 escape() 对字符串进行Unicode编码。
 unescape() 对由 escape() 编码的字符串进行解码。
 encodeURI() 把字符串编码为 URI。 对其他一些在网址中有特殊含义的符号“; / ? : @ & = + $ , #”不进行编码
 decodeURI() 解码某个编码的 URI。
 encodeURIComponent() 把字符串编码为 URI 组件
 decodeURIComponent() 解码一个编码的 URI 组件。
 eval() 计算 JavaScript 字符串，并把它作为脚本代码来执行。
 isFinite() 检查某个值是否为有穷大的数。
 isNaN() 检查某个值是否是数字。
 parseInt() 解析一个字符串并返回一个整数。
 parseFloat() 解析一个字符串并返回一个浮点数。
 Number() 把对象的值转换为数字。
 String() 把对象的值转换为字符串。
 所有内置构造函数 都是 全局对象的属性



## 类数组对象

```javascript
//for ... of
		var list = [1,2,3,4,5];  //纯的
		var itemList = document.querySelectorAll('.item');

		console.log(list);
		console.log(itemList);

		console.log(list.constructor);
		console.log(itemList.constructor);


		function demo(){
			console.log(arguments.constructor)
		}

		demo();


		console.log(itemList[0])
		console.log(itemList.length);


		for (var i = 0; i < itemList.length; i ++) {
			console.log(itemList[i])
		}

		console.log('');

		for (var i in itemList) {
			console.log(i, itemList[i])
		}


		itemList.forEach(function(value, index) {
			console.log(value)
		})
```

![1553951853266](Javascript\1553951853266.png)

# JavaScript 事件机制

## 1 什么是事件

JavaScript 使我们有能力创建动态页面。事件是可以被 JavaScript 侦测到的行为。

网页中的每个元素都可以产生某些可以触发 JavaScript 函数的事件。比方说，我们可以在用户点击某按钮时产生一个 onClick 事件来触发某个函数。事件在 HTML 页面中定义。

## 2 把事件绑定给元素

#### 1、on事件绑定方式

```js
document.onclick = function() {
    console.log("文档点击");
}
// on事件只能绑定一个方法，重复绑定保留最后一次绑定的方法
```

```js
document.onclick = function() {
    console.log("文档点击");
}
// 事件的移除
document.onclick = null;
```

#### 2、非on事件绑定方式

```js
document.addEventListener('click', function() {
     console.log("点击1");
})
document.addEventListener('click', function() {
     console.log("点击2");
})
// 非on事件可以同时绑定多个方法，被绑定的方法依次被执行
// addEventListener第三个参数(true|false)决定冒泡的方式
```

```js
var fn = function() {}
document.addEventListener('click', fn);
// 事件的移除
document.removeEventListener('click', fn);
```

#### 事件监听方式(标准方式)

```
addEventListener(Event, fn)    (非IE IE9+)  
attachEvent(Event, fn)  (IE8)
```

#### 把事件作为元素的方法

```
dom.onclick = fn
```

#### 把事件作为标签的内部属性

```
<button onclick="code..">
```

## 冒泡

```js
var wrapperEle =document.querySelector('#wrapper');
		var innerEle =document.querySelector('#inner')

		wrapperEle.onclick = function () {
            alert('我是大的');
        }
        innerEle.onclick=function (event) {
			alert('我是小的');

			//也就是 这个就是  让冒泡停留在本层
			//
			event.stopPropagation();
			//阻止冒泡


        }
```

```js
//事件是在冒泡阶段触发的
		var wrapperEle = document.querySelector('#wrapper');
		var innerEle = document.querySelector('#inner');

		// wrapperEle.onclick = function(){
		// 	alert('我是大的');
		// }
        //
		// innerEle.onclick = function(event) {
		// 	alert('我是小的');
		// 	event.stopPropagation(); //阻止冒泡
		// }

	//	上面的这两种方式 是无法改变  事件实在捕获还是 冒泡阶段触发的
	//	我们要用事件的标准写法
		wrapperEle.addEventListener('click',function () {
		    alert('我是大的  如果我是第一个被弹出来的' +
				'说明了是在捕获阶段就触发了')


        },true)

		innerEle.addEventListener('click',function (event) {
			alert('我是小的  如果我是第二个出来的说明' +
				'实在捕获阶段就出发了')
			// event.stopPropagation();//阻止冒泡
        },true)
```



## 3 给元素解除事件绑定

#### 标准方式绑定的事件

```
removeEventListener(event, fn)  (IE9+ 非IE)
detachEvent(Event, fn)   (IE8)
```

#### 其他方式绑定

```
重新绑定事件,用空的函数 覆盖 前面的
dom.onclick = function(){}
```

## 4 this在事件中的作用

 给一组元素绑定事件
 在元素内部 通过属性形式 `<button onclick="fn(this)">` 此时this表示所在的元素

## 5 事件列表

### 5.1 鼠标事件

#### click       

 单击左键

#### dblclick  

  双击 左键

#### contextmenu 

   右单击

```js
<script>
		document.oncontextmenu = function(e){
		    console.log(e.clientY,e.clientX)
			//alert('啊，我被右击了');
			// return false; //阻止系统菜单
		}
	</script>
```

#### mouseover 

   鼠标悬浮

#### mouseout 

   鼠标移出

#### mousedown 

   鼠标按键按下

#### mouseup   

​       鼠标按键抬起

#### mousemove 

   鼠标移动

### 5.2 键盘事件

#### keydown   

​     键盘按键 按下

#### keyup  

​      键盘按键 抬起

#### keypress   



  键盘按键 按下 (只有字符按键)  (控制按键不可以 Ctrl shift 上下左右都不行)

```js
<input type="text" id="inputEle">
	<div id="res"></div>

	<script>
		
		var inputEle = document.querySelector('#inputEle');
		inputEle.onkeyup = function(){
			document.querySelector('#res').innerHTML = this.value;
		}
	</script>
```



### 5.3 文档事件

#### load        

​    加载完成

#### unload       

​     文档关闭

#### beforeunload  

   文档关闭 (兼容性好)

```js
<h1>文档事件</h1>
	<hr>
	<!-- <img src="http://www.google.com/1.jpg" alt=""> -->

	<script>
		window.onload = function(){
			//一些操作 必须等到页面中 所有的内容 加载完毕
			console.log('页面加载完毕');
		}


		window.onbeforeunload = function(){
			return '你确定要离开我码？';
		}
	</script>
```

### 5.4 表单事件

#### submit

​        表单提交的时候, 绑定给form元素

#### reset   

​     表单重置, 绑定给form元素

#### blur     

   失去焦点

#### focus   

​     获得焦点

#### change

​        表单控制的内容改变   通常绑定给 radio checkbox select  如果绑定给输入的input, 必须满足 内容改变和失去焦点才能触发

#### select

​        input 或 textarea  内容被选中的时候触发

```js
	<form action="1.php" id="myForm">
		用户名： <input type="text" id="userEle" name="username"> <br>
		密码：   <input type="password" id="pwdEle" name="pwd"> <br>
		<button>提交</button>
		<input type="reset" value="重置">
	</form>


	<script>
		var userEle = document.querySelector('#userEle');
		var formEle = document.querySelector('#myForm');

		userEle.onblur = function() {
			console.log('失去焦点啦');
		}

		userEle.onfocus = function() {
			console.log('获取焦点啦');
			//在失去焦点的时候，验证内容合法性
		}

		//选中输入框中的文字
		userEle.onselect = function() {
			console.log('啊，我被选了');
		}

		//对于输入框，内容改变 并且失去焦点 （没用）
		userEle.onchange = function() {
			console.log('啊，我变了');
		}

		//类似于 用的keyup 内容变化就触发   兼容性不好
		userEle.oninput = function(){
			console.log('啊，我变了');
		}


		//form表单的事件
		formEle.onsubmit = function() {
			alert('啊，我被提交了');
			return false; //阻止表单提交
		}
	</script>
```

##### 地址联动

```js
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>地址联动</title>
	<style>
		select {
			width: 100px;
			padding: 5px;
			font-size:16px;
		}
	</style>
</head>
<body>
	<h1>选择地址</h1>
	<hr>
	<select id="prov"></select>
	<select id="city"></select>

	<script>
		//定义省市的信息
		var provList = ['江苏','浙江','福建','湖南'];
		var cityList = [];
		cityList[0] = ['南京', '苏州', '宿迁', '扬州'];
		cityList[1] = ['杭州', '温州', '宁波', '台州'];
		cityList[2] = ['福州', '厦门', '泉州', '漳州'];
		cityList[3] = ['长沙', '湘潭', '株洲', '湘西'];

		//获取select元素
		var provSelect = document.querySelector('#prov');
		var citySelect = document.querySelector('#city');


		//把省的信息 添加到第一个select元素中
		provList.forEach(function(val, index){
			//DOM操作  了解
			provSelect.add(new Option(val, index))
		});


		//给第一个select绑定change事件
		provSelect.onchange = function(){
			//获取 当前的选项
			var index = this.value;

			//清空第二个select原先内容
			citySelect.length = 0;

			//选择对应的城市列表，添加到第二个select
			cityList[index].forEach(function(val, index){
				citySelect.add(new Option(val, index));
			})
		}


		//手工触发一次 change事件
		provSelect.onchange();






	</script>
</body>
</html>
```

### 5.5 图片事件

#### abort     

   图片加载中断

#### load     

   图片加载完成

#### error     

   图片加载错误

```js
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>图片事件</title>
	<style>
		#imgList img {
			width: 200px;
			height: 300px;
		}
	</style>
</head>
<body>
	<h1>图片事件</h1>
	<hr>

	<div id="imgList">
		<img src="../../dist/images_one/1.jpg" alt="">
		<img src="../../dist/images_one/2.jpg" alt="">
		<img src="../../dist/images_one/3.jpg" alt="">
		<img src="../../dist/images_one/4.jpg" alt="">
		<img src="../../dist/images_one/41.jpg" alt="美图">
		<img src="../../dist/images_one/7.jpg" alt="">
		<img src="../../dist/images_one/8.jpg" alt="">
	</div>

	<script>
		//获取所有图片的列表
		var imgs = document.querySelectorAll('#imgList img');

		//给每个img元素绑定 error 事件
		for (var i = 0; i < imgs.length; i ++) {
			imgs[i].onerror = function() {
				this.src = '../../dist/images_two/11.jpg'
			}
		}
	</script>
</body>
</html>
```



### 5.6 其他事件

#### scroll     

   元素内部的内容滚动  适合于有滚动条的元素

#### resize     

   绑定给window, 窗口尺寸发生变化

```js
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>其他事件</title>
</head>
<body>
	<div style="height:20000px"></div>
	<script>
		window.onscroll = function(){
			console.log('页面在滚动');
		}

		window.onresize = function(){
			console.log(window.innerWidth, window.innerHeight)
		}
	</script>
</body>
</html>
```

### 历史

#### history

```js
<button onclick="history.back()">上一步</button>
	<button onclick="history.forward()">下一步</button>
	<button onclick="history.go(-2)">上两步</button>
	<button onclick="history.go(1)">下1步</button>

	<hr>

	<a href="http://www.baidu.com">百度</a>

	<script>
		<!--下面这俩是一个对象-->
		console.log(history)
		console.log(window.history)


		console.log(history.length); //历史记录的长度 在这个长度上来回切换

	</script>
```

### 主机

#### location

```js
<script>
		console.log(location)
		console.log(location.href)
		console.log(location.protocol)
		console.log(location.host);  //主机名和端口
		console.log(location.hostname)
		console.log(location.port)
		console.log(location.pathname)
		console.log(location.search)
		console.log(location.hash)


		//location.href= "1.html"
		location.hash = '#哈哈哈'
	</script>
```

![1554001071511](Javascript\1554001071511.png)

### 解析浏览器navigator

```js
<script>
		console.log(navigator.userAgent)
	</script>
```



## 6 Event对象

### 6.1 分类

```
Event        
MouseEvent    
KeyboardEvent    
FocusEvent    
...................
```

### 6.2 属性

####  clientX 

鼠标的x坐标

####  clientY

 鼠标的Y坐标

####  button 

鼠标按键的标示

```
  值
  0    按了左键
  1    按了滚轮
  2    按了右键
```

 keyCode

 键盘按键的值

 cancelBubble

 阻止事件冒泡 设置为true

####  target 

返回触发此事件的元素

```html
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>事件对象</title>
</head>
<body>
	<h1>event对象</h1>
	<hr>
	<form action="1.php">
		<button id="btn">按钮</button>
	</form>
	<script>
		
		var btn = document.querySelector('#btn');

		btn.onclick = function(event){
			alert('啊，我被点击了');
			event.preventDefault(); //阻止元素的 默认动作
		}


		document.onclick = function(event) {
			console.log(event.target)
		}
	</script>
</body>
</html>
```

![1554000668740](Javascript\1554000668740.png) 

tyep 

返回事件类型

 timeStamp

 返回触发事件的那一刻的时间戳(从页面打开的那一刻开始

 altKey

 返回当事件被触发时，"ALT" 是否被按下。

 ctrlKey

 返回当事件被触发时，"CTRL" 键是否被按下。

 shiftKey

 返回当事件被触发时，"SHIFT" 键是否被按下。

### 6.3 方法

####  stopPropagation() 

阻止事件冒泡

####  preventDefault() 

阻止元素默认的事件

## dom

### innerHTML元素

```js
<p>Lorem ipsum dolor sit amet.</p>
```

### innerText内容

```js
Lorem ipsum dolor sit amet.
```



```js
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>DOM</title>
	<style>
		#box {
			padding: 20px;
			width: 600px;
			border: 1px solid #ccc;
		}
	</style>
</head>
<body>
	<div id="box">
		<p>Lorem ipsum dolor sit amet.</p>
		<p>Lorem ipsum dolor sit amet.</p>
		<p>Lorem ipsum dolor sit amet.</p>
	</div>


	<script>
		var box = document.querySelector('#box');

		console.log(box.innerHTML)
		console.log(box.innerText)


		box.innerHTML = '<ul><li>HELLO</li></ul>'
		box.innerText = '<ul><li>HELLO</li></ul>'
	</script>
</body>
</html>
```

# js扩展

## javascript作用域

作用域是JavaScript最重要的概念之一，想要学好JavaScript就需要理解JavaScript作用域和作用域链的工作原理。

任何程序设计语言都有作用域的概念，简单的说，作用域就是变量与函数的可访问范围，即作用域控制着变量与函数的可见性和生命周期。在JavaScript中，变量的作用域有全局作用域和局部作用域两种。

作用域

### 全局作用域(Global Scope)

在代码中任何地方都能访问到的对象拥有全局作用域，一般来说一下几种情形拥有全局作用域：

(1)最外层函数和在最外层函数外面定义的变量拥有全局作用域

 

```js
var name="yuan";

    function foo(){
        var age=23;
        function inner(){
            console.log(age);
        }

        inner();
    }

    console.log(name);    // yuan
    //console.log(age);   // Uncaught ReferenceError: age is not defined
    foo();                // 23
    inner();              // Uncaught ReferenceError: inner is not defined
```

)所有末定义直接赋值的变量自动声明为拥有全局作用域，例如： 

```js
var name="yuan";

    function foo(){
        age=23;

        var sex="male"
    }
    foo();
    console.log(age);   //  23
    console.log(sex);   // sex is not defined
```

变量blog拥有全局作用域，而sex在函数外部无法访问到。

(3)所有window对象的属性拥有全局作用域

一般情况下，window对象的内置属性都都拥有全局作用域，例如window.alert()、window.location、window.top等等。

### 2. 局部作用域(Local Scope)

和全局作用域相反，局部作用域一般只在固定的代码片段内可访问到，最常见的例如函数内部，所有在一些地方也会看到有人把这种作用域成为函数作用域.

如示例1中的age与inner都只有局部作用域。（js中if、for没有自己的作用域）

## 作用域链(Scope Chain)

在JavaScript中，函数也是对象，实际上，JavaScript里一切都是对象。函数对象和其它对象一样，拥有可以通过代码访问的属性和一系列仅供JavaScript引擎访问的内部属性。其中一个内部属性是[[Scope]]，由ECMA-262标准第三版定义，该内部属性包含了函数被创建的作用域中对象的集合，这个集合被称为函数的作用域链，它决定了哪些数据能被函数访问。

### 示例演示

```js
//-----**********************例1*********************************

var s=12;
    function f(){
        console.log(s);
         var s=12;          // if s=12
        console.log(s)
    }
    f();

//-----**********************例2*********************************

var s=10;
function foo(){
  console.log(s);
  var s=5;
  console.log(s);
  function s(){console.log("ok")}// 函数的定于或声明是在词法分析时完成的,执行时已不再有任何操作

  console.log(s);
}

foo();

//-----***********************例3********************************

function bar(age) {

        console.log(age);
        var age = 99;
        var sex= 'male';
        console.log(age);
        function age() {
            alert(123)
        };
        console.log(age);
        return 100;
}

result=bar(5);

//-----********************************************************
```

### 结果分析

我相信大家一定会有想不到的结果，接下来我们就以最复杂的例3来分析整个过程。

当一个函数创建后，它的作用域链会被创建此函数的作用域中可访问的数据对象填充。在函数bar创建时，它的作用域链中会填入一个全局对象，该全局对象包含了所有全局变量，如下图所示：

![img](Javascript\877318-20170528114555063-310685483.png)

解析到函数调用时，即bar(5)，会生成一个active object的对象，该对象包含了函数的所有局部变量、命名参数、参数集合以及this，然后此对象会被推入作用域链的前端，当运行期上下文被销毁，活动对象也随之销毁。新的作用域链如下图所示：

![img](Javascript\877318-20170528121333250-1032064321.png)

```js
function bar(age) {

        console.log(age);
        var age = 99;
        var sex="male";
        console.log(age);
        function age(){
            alert(123);
        } ;
        console.log(age);
        return 100;
}

result=bar(5);

一 词法分析过程(涉及参数，局部变量声明，函数声明表达式)：
    1-1 、分析参数，有一个参数，形成一个 AO.age=undefine;
    1-2 、接收参数 AO.age=5;
    1-3 、分析变量声明，有一个 var age, 发现 AO 上面有一个 AO.age ，则不做任何处理
    1-4 、分析变量声明，有一个 var sex，形成一个 AO.sex=undefine;
    1-5 、分析函数声明，有一个 function age(){} 声明， 则把原有的 age 覆盖成 AO.age=function(){};
二 执行过程：
    2-1 、执行第一个 console.log(age) 时，当前的 AO.age 是一个函数，所以输出的一个函数
    2-2 、这句 var age=99; 是对不 AO.age 的属性赋值， AO.age=99 ，所以在第二个输出的age是 99;
    2-3 、同理第三个输出的是 99, 因为中间没有改变 age 值的语句了。

          注意：执行阶段：
                        function age(){
                            alert(123)
                        } ;

            不进行任何操作，将执行语句复制给age这部操作是在词法分析时，即运行前完成的。
```

# 实例练习

### 1 左侧菜单

![1554002102591](Javascript\1554002102591.png)



```js
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        *{
            margin: 0;
            padding: 0;
        }
          .left{
              width: 20%;
              height: 500px;
              float: left;
              background-color: wheat;
          }

          .right{
              float: left;
              width: 80%;
              height: 500px;
              background-color: lightgray;

          }

           .title{
               text-align: center;
               line-height: 40px;
               background-color: #0e90d2;
               color: white;
           }
        .item{
            padding: 10px;
        }

        .hide{
            display: none;
        }
    </style>
</head>
<body>



<div class="outer">
      <div class="left">
           <div class="item">
               <div class="title">菜单一</div>
               <ul class="con">
                   <li>111</li>
                   <li>111</li>
                   <li>111</li>
               </ul>
           </div>
          <div class="item">
               <div class="title">菜单二</div>
               <ul class="con hide">
                   <li>222</li>
                   <li>222</li>
                   <li>222</li>
               </ul>
           </div>
          <div class="item">
               <div class="title">菜单三</div>
               <ul class="con hide">
                   <li>333</li>
                   <li>333</li>
                   <li>333</li>
               </ul>
           </div>
      </div>
      <div class="right"></div>
</div>


<script>

    var eles_title=document.getElementsByClassName("title");



    for (var i=0;i<eles_title.length;i++){
         eles_title[i].onclick=function(){

             this.nextElementSibling.classList.remove("hide");

             for(var j=0;j<eles_title.length;j++){

                 if (eles_title[j]!=this){
                     eles_title[j].nextElementSibling.classList.add("hide")
                 }

             }


         }

    }




</script>
</body>
</html>
```

### 2 搜索框

```js
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>


<script>

function Focus(){

    var input=document.getElementById("ID1");
    if (input.value=="请输入用户名"){
        input.value="";
    }

}

function Blurs(){

    var ele=document.getElementById("ID1");
    var val=ele.value;
    if(!val.trim()){

        ele.value="请输入用户名";
    }
}

</script>
</head>
<body>
    <input id="ID1" type="text" value="请输入用户名" onblur="Blurs()" onfocus="Focus()">
</body>
</html>
```

### 模态对话框

```js
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        .back{
            background-color: white;
            height: 2000px;
        }

        .shade{
            position: fixed;
            top: 0;
            bottom: 0;
            left:0;
            right: 0;
            background-color: grey;
            opacity: 0.4;
        }

        .hide{
            display: none;
        }

        .models{
            position: fixed;
            top: 50%;
            left: 50%;
            margin-left: -100px;
            margin-top: -100px;
            height: 200px;
            width: 200px;
            background-color: wheat;

        }
    </style>
</head>
<body>
<div class="back">
    <input class="c" type="button" value="click">
</div>

<div class="shade hide handles"></div>

<div class="models hide handles">
    <input class="c" type="button" value="cancel">
</div>


<script>


    var eles=document.getElementsByClassName("c");
    var handles=document.getElementsByClassName("handles");
    for(var i=0;i<eles.length;i++){
        eles[i].onclick=function(){

            if(this.value=="click"){

                for(var j=0;j<handles.length;j++){

                    handles[j].classList.remove("hide");

                 }

            }
            else {
                for(var j=0;j<handles.length;j++){

                    handles[j].classList.add("hide");
                }

            }
        }
    }

</script>

</body>
</html>
```

### 表格案例

```js
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>

<button class="select_all">全选</button>
<button class="select_reverse">反选</button>
<button class="cancel">取消</button>

<hr>

<table class="server_table" border="2px" cellspacing="2px">
    <tr>
        <td><input type="checkbox" class="item"></td>
        <td>111</td>
        <td>111</td>
        <td>111</td>
    </tr>
    <tr>
        <td><input type="checkbox" class="item"></td>
        <td>222</td>
        <td>222</td>
        <td>222</td>
    </tr>
    <tr>
        <td><input type="checkbox" class="item"></td>
        <td>333</td>
        <td>333</td>
        <td>333</td>
    </tr>
    <tr>
        <td><input type="checkbox" class="item"></td>
        <td>444</td>
        <td>444</td>
        <td>444</td>
    </tr>
</table>


<script>
/*
    var ele_all=document.getElementsByClassName("select_all")[0];
    var ele_reverse=document.getElementsByClassName("select_reverse")[0];
    var ele_cancel=document.getElementsByClassName("cancel")[0];
    var input_arr=document.getElementsByClassName("item");

    ele_all.onclick=function(){
          for(var i=0;i<input_arr.length;i++){
              console.log(input_arr[i]);
              var input=input_arr[i];
              input.checked=true;
          }
    };

     ele_cancel.onclick=function(){
          for(var i=0;i<input_arr.length;i++){
              console.log(input_arr[i]);
              var input=input_arr[i];
              input.checked=false;
          }
    };

    ele_reverse.onclick=function(){
          for(var i=0;i<input_arr.length;i++){
              console.log(input_arr[i]);
              var input=input_arr[i];
              if(input.checked){
                  input.checked=false;
              }
              else{
                  input.checked=true;
              }
          }
    };

*/


    var input_arr=document.getElementsByClassName("item");
    var button_arr=document.getElementsByTagName("button");

    for(var i=0;i<button_arr.length;i++){

        button_arr[i].onclick=function(){


            for (var j=0;j<input_arr.length;j++){
                 var inp=input_arr[j]
                 if(this.innerText=="全选"){
                     console.log("ok");
                 inp.checked=true;
             }
            else if(this.innerText=="取消"){
                  inp.checked=false;
             }
            else {
                 if(inp.checked){
                     inp.checked=false;
                 }else {
                     inp.checked=true;
                 }
             }
                
            }
        }

    }
</script>
</body>
</html>
```

### select移动

![1554002384623](Javascript\1554002384623.png)

```js
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>

    <style>
        .outer{
            margin: 0 auto;
            background-color: darkgray;
            width: 80%;
            height: 600px;margin-top: 30px;
            word-spacing: -5px;

        }

        #left{
            display: inline-block;
            width: 100px ;
            height: 140px;
            background-color: wheat;
            text-align: center;


        }

        #choice{
            display: inline-block;
            height: 140px;
            background-color: darkolivegreen;

            vertical-align: top;
            padding:0 5px;


        }

        #choice button{
            margin-top: 20px;
        }

         #right{
            display: inline-block;
            width: 100px ;
            height: 140px;
            background-color: wheat;
            text-align: center;
            line-height: 140px;

        }

    </style>
</head>
<body>



<div class="outer">

    <select multiple="multiple" size="5" id="left">
    <option>红楼梦</option>
    <option>西游记</option>
    <option>水浒传</option>
    <option>JinPingMei</option>
    <option>三国演义</option>
</select>




<span id="choice">
    <button id="choose_move"> > </button><br>
    <button id="all_move"> >> </button>
</span>



<select multiple="multiple" size="10" id="right">
    <option>放风筝的人</option>
</select>


</div>




<script>

    var choose_move=document.getElementById("choose_move");
    var all_move=document.getElementById("all_move");

    var right=document.getElementById("right");
    var left=document.getElementById("left");
    var options=left.options;



    choose_move.onclick=function(){

        for (var i=0; i<options.length;i++){

             var option=options[i];
             if(option.selected==true){

                   // var news=option.cloneNode(true);
                   // console.log(news);

                   right.appendChild(option);
                   i--;
             }
         }
    };

    all_move.onclick=function(){

        for (var i=0; i<options.length;i++){

             var option=options[i];

                   right.appendChild(option);
                   i--;

         };
    };




    /*
   var buttons=document.getElementsByTagName("button");
   for(var i=0;i<buttons.length;i++) {
        buttons[i].onclick = function () {

            for (var i = 0; i < options.length; i++) {

                var option = options[i];

                if (this.innerText == ">") {
                    if (option.selected == true) {

                        // var news=option.cloneNode(true);
                        // console.log(news);

                        right.appendChild(option);
                        i--;
                    }
                } else {
                    right.appendChild(option);
                    i--;
                }
            }
        };
    }


   */


</script>


</body>
</html>
```

### 二级联动

![1554002468085](Javascript\1554002468085.png)

```js
<select id="province">
    <option>请选择省:</option>
</select>

<select id="city">
    <option>请选择市:</option>
</select>


<script>
    data={"河北省":["廊坊","邯郸"],"北京":["朝阳区","海淀区"]};


      var p=document.getElementById("province");
      var c=document.getElementById("city");
    
    for(var i in data){
        var option_pro=document.createElement("option");

        option_pro.innerHTML=i;

        p.appendChild(option_pro);
    }
     p.onchange=function(){

            pro=(this.options[this.selectedIndex]).innerHTML;
            citys=data[pro];

         c.options.length=0;

         for (var i in citys){
             var option_city=document.createElement("option");
             option_city.innerHTML=citys[i];
             c.appendChild(option_city);
         }

        }
</script>
```

### 跑马灯与tab切换

#### 跑马灯

```js
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>tab</title>
  <style>
    
  </style>
</head>

<body>
    <h3 id="wel">京东商城欢迎您</h3>
    <!--  direction="right up down left" -->
<!--  behavior：滚动方式(包括3个值：scroll、slide、alternate) -->
<!--  说明：scroll：循环滚动，默认效果；slide：只滚动一次就停止；alternate：来回交替进行滚动。 -->
<!--  scrollamount="5" 滚动速度 -->

<marquee behavior="scroll" direction="right">欢迎您李江洋先生</marquee>
    
   
</body>
</html>
```



```js
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>tab</title>
  <style>
    *{margin:0; padding:0; list-style:none;}
    body{
        font-family: "Helvetica Neue", "Hiragino Sans GB", "Microsoft YaHei", "\9ED1\4F53", Arial, sans-serif;
    }
    h3{
        text-align: center;
        color:darkcyan;
        margin-top: 30px;
        letter-spacing: 5px;
    }
    .box{
      width: 1000px;
      margin:50px auto 0px;
    }
    #title{
      line-height: 40px;
      background-color: rgb(247,247,247);
      font-size: 16px;
      font-weight: bold;
      color: rgb(102,102,102);
    }
    #title span{
      float: left;
      width: 166px;
      text-align: center;
    }
    #title span:hover{
      /*color: black;*/
      cursor: pointer;
    }
    #content{
      margin-top: 20px;
    }
    #content li{
      width: 1050px;
      display: none;
      background-color: rgb(247,247,247);
    }
    #content li div{
      width: 156px;
      margin-right: 14px;
      float: left;
      text-align: center;
    }
    #content li div a{
      font-size: 14px;
      color: black;
      line-height: 14px;
    /*  float: left;*/
    display: inline-block;
      margin-top: 10px;
    }
    #content li a:hover{
      color: #B70606;
    }
    #content li div span{
        font-size: 16px;
        line-height: 16px;
        /*float: left;*/
        display: block;
        color: rgb(102,102,102);
        margin-top: 10px;
      }
    #content img{
      float: left;
      width: 155px;
      height: 250px;
    }
    #title .select{
      background-color: #2459a2;
      color: white;
        border-radius: 10%;
    }
    #content .show{
      display: block;
    }

    .show span{
        color: red!important;
        font-size: 30px;
    }
  </style>
</head>

<body>
    <h3 id="wel">京东商城欢迎您</h3>
    <!--  direction="right up down left" -->
<!--  behavior：滚动方式(包括3个值：scroll、slide、alternate) -->
<!--  说明：scroll：循环滚动，默认效果；slide：只滚动一次就停止；alternate：来回交替进行滚动。 -->
<!--  scrollamount="5" 滚动速度 -->

<marquee behavior="scroll" direction="right">欢迎您苑昊先生</marquee>
    <script>

    function test(){

        var mywel = document.getElementById("wel");
        var content = mywel.innerText;

        var f_content = content.charAt(0);
        var l_content = content.substring(1,content.length);

        var new_content = l_content + f_content;
        mywel.innerText = new_content;

    }

    // setInterval("test();", 500);
</script>
    <div class="box">
      <p id="title">
        <span class="select">家用电器</span>
        <span>家具</span>
        <span>汽车</span>
        <span>食品</span>
        <span>女鞋</span>
        <span>医疗保健</span>
      </p>

      <ul id="content">
        <li class="show">

          <div><img src="https://img10.360buyimg.com/n1/s450x450_jfs/t4786/325/2470647304/119102/9e1a4ed5/59005841Nd786a8df.jpg" alt="冰箱"><a href="#">容声(Ronshen)冰箱</a><span>价格:5600</span></div>
          <div><img src="https://img12.360buyimg.com/n1/s450x450_jfs/t3037/347/1290968859/201366/7c1028a0/57c00194N9d0a54c6.jpg" alt="洗衣机"><a href="#">海尔洗衣机</a><span>价格:5400</span></div>
          <div><img src="https://img11.360buyimg.com/n1/jfs/t3289/128/2393835119/236360/af1d283b/57e0f300N53dde603.jpg" alt="电饭煲"><a href="#">福库(CUCKOO)电饭煲</a><span>价格:3999</span></div>
          <div><img src="https://img13.360buyimg.com/n1/jfs/t3235/137/2361713777/152258/a6908440/57e098c2N44a90a5d.jpg" alt="智能电视"><a href="#">三星智能电视</a><span>价格:8999</span></div>
          <div><img src="https://img10.360buyimg.com/n1/jfs/t2053/101/1391591157/215066/572e131b/5696ee9bN2376492d.jpg" alt="净水器"><a href="#">净水器</a><span>价格:1300</span></div>
          <div><img src="https://img14.360buyimg.com/n1/jfs/t3175/78/2357430273/262835/9a8e7f65/57e0a3e9Nbda39dd2.jpg" alt="空气净化器"><a href="#">空气净化器</a><span>价格:5300</span></div>
        </li>

        <li>

          <div><img src="https://img12.360buyimg.com/n1/jfs/t1948/172/2877517581/556924/682eb107/56f63dc8Naddf77e5.jpg" alt="沙发"><a href="#">沙发</a><span>价格:2900</span></div>
          <div><img src="https://img12.360buyimg.com/n1/jfs/t1948/172/2877517581/556924/682eb107/56f63dc8Naddf77e5.jpg" alt="沙发"><a href="#">沙发</a><span>价格:2900</span></div>
          <div><img src="https://img12.360buyimg.com/n1/jfs/t1948/172/2877517581/556924/682eb107/56f63dc8Naddf77e5.jpg" alt="沙发"><a href="#">沙发</a><span>价格:2900</span></div>
          <div><img src="https://img12.360buyimg.com/n1/jfs/t1948/172/2877517581/556924/682eb107/56f63dc8Naddf77e5.jpg" alt="沙发"><a href="#">沙发</a><span>价格:2900</span></div>
          <div><img src="https://img12.360buyimg.com/n1/jfs/t1948/172/2877517581/556924/682eb107/56f63dc8Naddf77e5.jpg" alt="沙发"><a href="#">沙发</a><span>价格:2900</span></div>
          <div><img src="https://img12.360buyimg.com/n1/jfs/t1948/172/2877517581/556924/682eb107/56f63dc8Naddf77e5.jpg" alt="沙发"><a href="#">沙发</a><span>价格:2900</span></div>

        </li>
        <li>
          <div><img src="http://img11.360buyimg.com/n1/jfs/t4969/76/45396935/144539/347153d4/58d9cff4N36872ad6.jpg" alt="长安汽车"><a href="#">长安汽车</a><span>价格:12900</span></div>
          <div><img src="http://img11.360buyimg.com/n1/jfs/t4969/76/45396935/144539/347153d4/58d9cff4N36872ad6.jpg" alt="长安汽车"><a href="#">长安汽车</a><span>价格:12900</span></div>
          <div><img src="http://img11.360buyimg.com/n1/jfs/t4969/76/45396935/144539/347153d4/58d9cff4N36872ad6.jpg" alt="长安汽车"><a href="#">长安汽车</a><span>价格:12900</span></div>
          <div><img src="http://img11.360buyimg.com/n1/jfs/t4969/76/45396935/144539/347153d4/58d9cff4N36872ad6.jpg" alt="长安汽车"><a href="#">长安汽车</a><span>价格:12900</span></div>
          <div><img src="http://img11.360buyimg.com/n1/jfs/t4969/76/45396935/144539/347153d4/58d9cff4N36872ad6.jpg" alt="长安汽车"><a href="#">长安汽车</a><span>价格:12900</span></div>
          <div><img src="http://img11.360buyimg.com/n1/jfs/t4969/76/45396935/144539/347153d4/58d9cff4N36872ad6.jpg" alt="长安汽车"><a href="#">长安汽车</a><span>价格:12900</span></div>
        </li>
        <li>

          <div><img src="https://img14.360buyimg.com/n1/jfs/t4414/110/2582917360/207971/b7e129ad/58f0ee1fN94425de1.jpg" alt="嘉兴粽子"><a href="#">嘉兴粽子</a><span>价格:1</span></div>
          <div><img src="https://img14.360buyimg.com/n1/jfs/t4414/110/2582917360/207971/b7e129ad/58f0ee1fN94425de1.jpg" alt="嘉兴粽子"><a href="#">嘉兴粽子</a><span>价格:1</span></div>
          <div><img src="https://img14.360buyimg.com/n1/jfs/t4414/110/2582917360/207971/b7e129ad/58f0ee1fN94425de1.jpg" alt="嘉兴粽子"><a href="#">嘉兴粽子</a><span>价格:1</span></div>
          <div><img src="https://img14.360buyimg.com/n1/jfs/t4414/110/2582917360/207971/b7e129ad/58f0ee1fN94425de1.jpg" alt="嘉兴粽子"><a href="#">嘉兴粽子</a><span>价格:1</span></div>
          <div><img src="https://img14.360buyimg.com/n1/jfs/t4414/110/2582917360/207971/b7e129ad/58f0ee1fN94425de1.jpg" alt="嘉兴粽子"><a href="#">嘉兴粽子</a><span>价格:1</span></div>
          <div><img src="https://img14.360buyimg.com/n1/jfs/t4414/110/2582917360/207971/b7e129ad/58f0ee1fN94425de1.jpg" alt="嘉兴粽子"><a href="#">嘉兴粽子</a><span>价格:1</span></div>

        </li>
        <li>

          <div><img src="https://img14.360buyimg.com/n1/jfs/t3079/298/5759209435/92674/14818594/587f1c33N53e5d2a9.jpg" alt="星期六"><a href="#">星期六</a><span>价格:439</span></div>
          <div><img src="https://img14.360buyimg.com/n1/jfs/t3079/298/5759209435/92674/14818594/587f1c33N53e5d2a9.jpg" alt="星期六"><a href="#">星期六</a><span>价格:439</span></div>
          <div><img src="https://img14.360buyimg.com/n1/jfs/t3079/298/5759209435/92674/14818594/587f1c33N53e5d2a9.jpg" alt="星期六"><a href="#">星期六</a><span>价格:439</span></div>
          <div><img src="https://img14.360buyimg.com/n1/jfs/t3079/298/5759209435/92674/14818594/587f1c33N53e5d2a9.jpg" alt="星期六"><a href="#">星期六</a><span>价格:439</span></div>
          <div><img src="https://img14.360buyimg.com/n1/jfs/t3079/298/5759209435/92674/14818594/587f1c33N53e5d2a9.jpg" alt="星期六"><a href="#">星期六</a><span>价格:439</span></div>
          <div><img src="https://img14.360buyimg.com/n1/jfs/t3079/298/5759209435/92674/14818594/587f1c33N53e5d2a9.jpg" alt="星期六"><a href="#">星期六</a><span>价格:439</span></div>

        </li>
        <li>

          <div><img src="https://img12.360buyimg.com/n1/jfs/t5755/127/1139389729/356866/99d4e869/5923e410Nb2983f70.jpg" alt="汇仁 肾宝片"><a href="#">汇仁 肾宝片</a><span>价格:322</span></div>
          <div><img src="https://img12.360buyimg.com/n1/jfs/t5755/127/1139389729/356866/99d4e869/5923e410Nb2983f70.jpg" alt="汇仁 肾宝片"><a href="#">汇仁 肾宝片</a><span>价格:322</span></div>
          <div><img src="https://img12.360buyimg.com/n1/jfs/t5755/127/1139389729/356866/99d4e869/5923e410Nb2983f70.jpg" alt="汇仁 肾宝片"><a href="#">汇仁 肾宝片</a><span>价格:322</span></div>
          <div><img src="https://img12.360buyimg.com/n1/jfs/t5755/127/1139389729/356866/99d4e869/5923e410Nb2983f70.jpg" alt="汇仁 肾宝片"><a href="#">汇仁 肾宝片</a><span>价格:322</span></div>
          <div><img src="https://img12.360buyimg.com/n1/jfs/t5755/127/1139389729/356866/99d4e869/5923e410Nb2983f70.jpg" alt="汇仁 肾宝片"><a href="#">汇仁 肾宝片</a><span>价格:322</span></div>
          <div><img src="https://img12.360buyimg.com/n1/jfs/t5755/127/1139389729/356866/99d4e869/5923e410Nb2983f70.jpg" alt="汇仁 肾宝片"><a href="#">汇仁 肾宝片</a><span>价格:322</span></div>

        </li>


      </ul>
    </div>

    <script>
      var title=document.getElementById('title');
      var content=document.getElementById('content');
      var category=title.getElementsByTagName('span');
      var item=content.getElementsByTagName('li');

      for (var i = 0; i < category.length; i++) {

          category[i].index=i;

          category[i].onclick=function(){

            for (var j = 0; j < category.length; j++) {
              category[j].className='';
              item[j].className='';
            }
            this.className='select';
            item[this.index].className='show';
          }


      }

    </script>
</body>
</html>
```