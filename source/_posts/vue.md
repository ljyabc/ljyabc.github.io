---
title: vue实例,视图
tags: [vue]
date: 2019-04-01 14:44:51
categories: 理解
photos:
book:
---

# Vue

## 安装

![1554101192779](vue\1554101192779.png)

## 1 Vue是什么

### 1.1 定义

- Vue 是一套用于构建用户界面的渐进式框架
- 使用Vue框架，可以完全在浏览器端渲染页面，服务端只提供数据
- 使用Vue框架可以非常方便的构建 单页面应用 (SPA)

### 1.2 关于作者

- 国人 尤雨溪
- 百科介绍： <https://baike.baidu.com/item/%E5%B0%A4%E9%9B%A8%E6%BA%AA/2281470?fr=aladdin>
- 微博： <https://weibo.com/arttechdesign?is_hot=1#1528176039582>

### 1.3 相关网站

- 官方网站： <https://cn.vuejs.org/>
- GitHub： <https://github.com/vuejs/vue>

### 1.4 Vue 与 jQuery 区别

- jQuery 仍然是操作DOM的思想，jQuery主要用来写页面特效
- Vue是前端框架（MVVM），对项目进行分层。处理数据
- 数据驱动



### 1.5 前端框架



- React               是facebook  比较全面
- Angular           google
- Vue                  社区维护

### 



### 1.6  框架的区别

#### Vue与React

- React与Vue 都采用虚拟DOM
- 核心功能都在核心库中，其他类似路由这样的功能则由其他库进行处理
- React的生态系统更庞大，由ReactNative来进行混合App开发; Vue更轻量
- React由独特的JSX语法; Vue是基于传统的Web计数进行扩展(HTML、CSS、JavaScript)，更容易学习

#### Vue与Angular

- Angular1和Angular2以后的版本 是完全不同的两个框架； 一般Angular1被称作Angular.js, Angular之后的版本被称作 Angular
- Vue与Angular的语法非常相似
- Vue没有像Angular一样深入开发，只保证了基本功能。 Angular过于笨重
- Vue的运行速度比Angular快得多
- Angular的脏检查机制带来诸多性能问题



### 1.7  MVVM

- Model     M模型层

- View         V视图层

- ViewModel     VM控制层

  vm负责把M和V连接到一起

### 1.8 Vue的优点

- 不存在依赖
- 轻便（25k min）
- 适用范围广(大中小型项目、PC、移动端、混合开发)
- 本土框架,社区非常活跃
- 语法简单、学习成本低
- 双向数据绑定（所见即所得）



### 1.9  使用框架开展一个项目的时候，需要考虑哪些方面？

1.性能

如果一个网站在性能方面存在问题，它将会损失超过一半以上的用户。

对于框架性能，你可以在网上查询到各类测试，你可以了解框架的代码结构、逻辑处理，判断是否能够满足你对性能的需求。

2.扩展性

对于一个需要长期维护的项目而言，经常会有各种各样的功能添加进来，这时扩展性就显得尤为重要，如果你在前期选择了一款满足前期的框架，但后期你需要使用某个插件来完成某个功能，或者基于什么完成一个功能，这时候你发现网上并没有检索到相关内容，内心是否充满了心塞。

3.维护性

一个项目的生命周期不是三天两天，而前端的发展则是爆炸式的。在你选择框架的时候是否考虑过官方在后续的一段时间是否会一直对框架进行更新维护？如果不确定，是否已经有了官方放弃维护后的解决方案？

4.兼容性

这里的兼容性指的不是浏览器兼容，而是框架与其他框架及工具的兼容，使用这个框架对于你的开发环境是否有影响，对于你的开发 IDE 是否有影响。

Vue.js 适用具有以下性质的项目：

- 对浏览器兼容要求不高，不需要兼容至IE6-8；
- SPA开发；
- 对性能较高要求;
- 组件化。

总的来说，如果你是一个 MVVM 框架新手，那么 Vue.js 就是你最好的进阶工具，如果你是一个已经掌握了其他 MVVM 框架的老手，那你会发现 Vue.js 更加简单轻便。



## 2 多页面应用和单页面应用

### 2.1 多页面应用（MultiPage Application，MPA）

多页面跳转刷新所有资源，每个公共资源(js、css等)需选择性重新加载，常用于 app 或 客户端等

![img](data:image/jpeg;base64,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)

### 2.2 单页面应用（SinglePage Web Application，SPA）

只有一张Web页面的应用，是一种从Web服务器加载的富客户端，单页面跳转仅刷新局部资源 ，公共资源(js、css等)仅需加载一次，常用于PC端官网、购物等网站

![img](data:image/jpeg;base64,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)

### 2.3 两者对比

|                   | 单页面应用                                                   | 多页面应用                                   |
| ----------------- | ------------------------------------------------------------ | -------------------------------------------- |
| 组成              | 一个外壳页面和多个页面片段组成                               | 多个完整页面构成                             |
| 资源公用(css,js)  | 共用，只需在外壳部分加载                                     | 不共用，每个页面都需要加载                   |
| 刷新方式          | 页面局部刷新或更改                                           | 整页刷新                                     |
| url 模式          | a.com/#/pagetwo a.com/#/pagetwo                              | a.com/pageone.html a.com/pagetwo.html        |
| 用户体验          | 页面片段间的切换快，用户体验良好                             | 页面切换加载缓慢，流畅度不够，用户体验比较差 |
| 转场动画          | 容易实现                                                     | 无法实现                                     |
| 数据传递          | 容易                                                         | 依赖 url传参、或者cookie 、localStorage等    |
| 搜索引擎优化(SEO) | 需要单独方案、实现较为困难、适用于追求高度支持搜索引擎的应用 | 实现方法简易                                 |
| 试用范围          | 高要求的体验度、追求界面流畅的应用                           | 适用于追求高度支持搜索引擎的应用             |
| 开发成本          | 较高，常需借助专业的框架                                     | 较低 ，但页面重复代码多                      |
| 维护成本          | 相对容易                                                     | 相对复杂                                     |





## 3 Vue入门



### 3.1 安装直接<script>引入

##### 下载地址

- 开发环境版本 <https://vuejs.org/js/vue.js> 包含完整的警告和调试模式
- 生成环境版本 <https://vuejs.org/js/vue.min.js> 删除了警告、进行了压缩



- ##### CDN

```
https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.min.js
https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js
# 以手动指定版本号
```

##### NPM

在用 Vue 构建大型应用时推荐使用 NPM 安装[1]。NPM 能很好地和诸如 webpack 或 Browserify 模块打包器配合使用。同时 Vue 也提供配套工具来开发单文件组件。

```
npm install vue
```

#### 构建工具 (CLI)

```
npm install -g @vue/cli
vue create my-project
```

注意：

Vue把js当核心，无需等待所有Html元素运行完毕，因为Vue可以生成Html元素，所以写在前后可以。





## 4 Vue实例

![1554109878008](vue\1554109878008.png)

### 计算属性最常用

可以个属性的变化

![1554108535975](vue\1554108535975.png)

### 4.0 实例方法

Vue 实例还暴露了一些有用的实例属性与方法。它们都有前缀 $，以便与用户定义的属性区分开来

##### vm.$el

原生的dom

##### vm.$data

数据ojb

##### vm.$watch(dataAttr, fn)

```
vm.$watch('title', function(){
			console.log('变了');
		})
```



### 4.1 挂载元素

```
let app = new Vue({
    el:'#app',  与元素进行挂载
   
})
```

### 4.2 数据 data

```
let app = new Vue ({
	
	data:{
        title:'交友',            <p>{{title}}</p>  设置html元素的内容
	}
})
```



### 4.3 方法  methods

```
let app = new Vue ({
	methods:{
        函数名：function(){
	this.message='hello';               this表示实例 用来给事件绑定方法
        
	}
})
```



##### 需要视图层加括号

```
{{ reverseMessage() }}
```



```
methods: {
					reverseMessage: function(){
					return this.message.split('').reverse().join('')
				}
			},
```

### 4.4 计算属性 computed

##### 不加括号

```
{{ reverseMessage }}
```



```
Vue({
    computed: {
        属性名: function(){
            
            
        }
    }
})
```

##### 计算属性：

 适合一个属性受到多个属性的影响(被动改变)

```
computed: {
				fullName: function(){
					return this.firstName + this.lastName
				}
			}
```



### 4.5 监听属性

![1554108284123](vue\1554108284123.png)

```
Vue({
    watch: {
        属性: function(){
        
            
        }
    }
})
```

监听属性和计算属性

计算属性： 适合一个属性受到多个属性的影响

##### 监听属性：

 多个属性依赖于一个属性

```
watch: {
				fullName: function(){
					this.firstName = this.fullName.split(' ')[0]
					this.lastName = this.fullName.split(' ')[1]
				}
			}
```



### 4.6 生命周期的钩子函数

#### beforeCreate       

 vue实例刚刚创建，其他都没做

```
//钩子函数
			beforeCreate: function(){
				//vue实例刚刚创建，什么都没干
				console.log('beforeCreate');
				//console.log(this);
				//console.log(this.title);
				console.log('')
			},
```



#### created      

此时，Vue实例的方法、属性都都已经创建。 可以在这里获取后端数据

```
created: function(){
				//创建了数据、计算属性、方法、监听 统统创建
				//可以在这里 获取服务端的数据
				console.log(this.title)
				console.log('created');
				console.log('')

			},
```



#### beforeMount    

 在挂载开始之前被调用，相关的 render 函数将首次被调用。

#### mounted      

此时，Vue实例已经挂载到元素上。 操作DOM请在这里

#### beforeUpdate   

数据更新时调用，发生在虚拟 DOM 重新渲染和打补丁之前

```
mounted: function(){
				//非要进行 dom操作，请在进行
				console.log('挂载完成');
				console.log(this.$el);
				console.log('')
			},
			updated: function(){
				console.log('属性更新完成', this.message);
				
			}
```



#### updated          

 数据更新完成会调用

#### activated  

 keep-alive 组件激活时调用。

#### deactivated     

keep-alive 组件停用时调用。

#### beforeDestory   

 实例销毁之前调用。在这一步，实例仍然完全可用。

#### destoryed     

 Vue 实例销毁后调用。调用后，Vue 实例指示的所有东西都会解绑定，所有的事件					监听器会被移除，所有的子实例也会被销毁。



## 5 Vue视图

### 5.1 基本模板语法

#### 文本插值

##### title,v-text,v-once

```
<p>{{ title }}</p>           可以写多个值

<p v-text="title"></p>      只能写一个值

<p v-once>{{ title }}</p>  message变化，这里不会改 
```

#### HTML

#####  v-html

```
<div v-html="message"></div>   原样输出相当于innerHTML
```

#### 绑定属性

##### v-bind简写就是冒号

v-bind:class="{current:isActive}

可以控制

```
<img v-bind:src="imgSrc" v-bind:title="title"  :alt="altContent">
<p v-bind:id="" :class="">   可以简写：

```

#### 视图进行表达式运算

```
{{ 表达式运算 }}
不建议
```

#### 防止闪烁

```
<style>
	[v-cloak] {
        display:none !important  可以让同等优先级的情况下，优先运行
        					在挂载之前生效，在挂载完成之后删除
	}
</style>

<div id="app" v-cloak>     在挂载元素内运行
```



### 5.3 条件渲染

#### 语法

```
<div class="box" v-if="true">
			Lorem ipsum dolor sit amet, consectetur adipisicing elit. Rem quo saepe, eum nisi. Atque, pariatur ad sapiente alias, dignissimos tempora iusto ullam veritatis, obcaecati ipsa dicta sunt dolorem ducimus eos!
		</div> -->
```



#### v-if

直接消失

v-else-if
v-else
如果在运行时条件很少改变，则使用 v-if 较好


Vue 会尽可能高效地渲染元素，通常会复用已有元素而不是从头开始渲染
要想每次都重新渲染，只需添加一个具有唯一值的 key 属性

```
<template></template>   Vue加的，不影响原来的布局，运行完不会在html中产生元素
```



#### v-show  

元素还存在

v-show控制隐藏和显示 

  元素经常改变用，为display：none

### 5.4 列表渲染

#

#### 遍历数组

```
<ul id="example-1">
  <li v-for="item in items">
    {{ item.message }}
  </li>
</ul>
```

v-for 还支持一个可选的第二个参数为当前项的索引

```
<ul id="example-2">
  <li v-for="(item, index) in items">
    {{ index }} - {{ item.message }}
  </li>
</ul>
```

#### 遍历对象

```
<!-- 只取值 -->
<li v-for="value in object">
  {{ value }}
</li>

<!-- 值、属性名 -->
<div v-for="(value, key) in object">
  {{ key }}: {{ value }}
</div>

<!--值、属性名、索引-->
<div v-for="(value, key, index) in object">
  {{ index }}. {{ key }}: {{ value }}
</div>
```

#### key

- 当 Vue.js 用 v-for 正在更新已渲染过的元素列表时，它默认用“就地复用”策略。
- 这个默认的模式是高效的，但是只适用于不依赖子组件状态或临时 DOM 状态 的列表渲染输出。
- 为了给 Vue 一个提示，以便它能跟踪每个节点的身份，从而重用和重新排序现有元素，你需要为每项提供一个唯一 key 属性。因为在遍历，需要用 v-bind 来绑定动态值
- 建议尽可能在使用 v-for 时提供 key，除非遍历输出的 DOM 内容非常简单，或者是刻意依赖默认行为以获取性能上的提升。

#### 更新检测

**数组**

由于 JavaScript 的限制，Vue 不能检测以下变动的数组：

 当你利用索引直接设置一个项时，例如：vm.items[indexOfItem] = newValue 当你修改数组的长度时，例如：vm.items.length = newLength

**对象**

还是由于 JavaScript 的限制，Vue 不能检测对象属性的添加或删除

**方法**

- `Vue.set()`         设置对象属性值
- `vm.$set()`

#### 遍历数字

```
<div>
  <span v-for="n in 10">{{ n }} </span>
</div>
```

#### v-for on <tmplate>

```
<ul>
  <template v-for="item in items">
    <li>{{ item.msg }}</li>
    <li class="divider" role="presentation"></li>
  </template>
</ul>
```

#### v-for 和 v-if

当它们处于同一节点，v-for 的优先级比 v-if 更高，这意味着 v-if 将分别重复运行于每个 v-for 循环中。

```
<li v-for="todo in todos" v-if="!todo.isComplete">
  {{ todo }}
</li>
```

```
<tr v-for="item in dataList" :key="item.id" v-if="item.id > 2">
				<td>{{ item.id }}</td>
				<td>{{ item.name }}</td>
				<td>{{ item.age }}</td>
				<td>{{ item.job }}</td>
				<td>{{ item.address }}</td>
			</tr>
```

#### 更新数组@click="updateItemList()"

##### push

```
this.itemList.push('贾宝玉');
```



##### pop

```
this.itemList.pop();
```



##### reverse

```
this.itemList.reverse();
```



##### 改

```
Vue.set(this.itemList, 1, '焦宝玉')
```



```
//this.itemList[1] = '贾宝玉'
					//this.itemList.push('贾宝玉');
					//this.itemList.pop();
					//this.itemList.reverse();
					Vue.set(this.itemList, 1, '焦宝玉')
```

