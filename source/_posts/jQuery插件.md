---
title: jQuery插件
tags: [前端]
date: 2019-04-01 13:19:04
categories: 理解
photos:
book:
---

# jQuery 插件

## 1 jQuery 插件的网站

- <http://plugins.jquery.com/> 官网
- <http://www.jq22.com/> jQuery插件库
- <http://www.htmleaf.com/> jQuery 之家
- <http://www.jq-school.com/> jQuery-school

## 2 经典jQuery插件

2.1 ### select2 下拉框搜索插件

- 官网 <https://select2.org/>

- github <https://github.com/select2/select2>

- 用法

  ```
  $(dom).select2()
  $(dom).select({
    width:,
    data:,
    ajax:,
    ....
  })
  ```

  

### 2.2 datetimepicker 时间日期插件

- github <https://github.com/xdan/datetimepicker>

- 文档 <https://xdsoft.net/jqplugins/datetimepicker/>

- 用法

  ```
  //设置语言
  $.datetimepicker.setLocale('zh');
  //调用插件
  $(dom).datetimepicker({
    datepicker:,
    timepicker:,
    format:"Y-m-d H:i",
    value:，
    ....
  })
  ```

  

### 2.3 fullpage 全屏滚动插件

- 官网 <https://alvarotrigo.com/fullPage/zh/>

- github <https://github.com/alvarotrigo/fullpage.js/>

- 用法

  ```
  <!--HTML部分-->
  <div id="fullpage>
      <div class="section"></div>
      <div class="section">
          <div class="slide"></div>
          <div class="slide"></div>
          <div class="slide"></div>
      </div>
      <div class="section"></div>
      <div class="section"></div>
  </div>
  自定义的导航 卸载包裹元素的外面
  
  <!--JS部分-->
  <script>
      $("#fullpage").fullpage({
        navigation: true,
        sectionsColor: []
        .....
      })
  </script>
  ```

  

### 2.4 lazyload 图片懒加载

- 官网 <https://appelsiini.net/projects/lazyload/>

- github <https://github.com/tuupola/jquery_lazyload/tree/2.x>

- 用法

  ```
  $("#lazyWrapper img").lazyload()
  ```

  

### 2.5 layer 弹窗插件

- 官网 <http://layer.layui.com/?alone>

- github <https://github.com/sentsin/layer/>

- 用法

  ```
  layer.alert()
  layer.confirm()
  layer.msg()
  layer.load()
  layer.tips()
  layer.colse()
  layer.open({
    type: ,
    title: ,
    content: 
    ....
  })
  ...
  ```

  

### 2.6 nice validator 表单验证

- 官网 <https://validator.niceue.com/>

- github <https://github.com/niceue/nice-validator>

- 用法

  ```
  $("form").validator({
  
  })
  ```

  

### 2.7 jQuery-easing

- 官网 <http://gsgd.co.uk/sandbox/jquery/easing/>

- github <https://github.com/gdsmith/jquery.easing>

- 用法

  ```
  $(dom).hide(speed, easing, fn)
  ```

  

## 3 自定义jQuery 插件

**jQuery.fn.extend() 给jQueryDom扩展方法**

```
$.fn.extend({
  方法名:function(){}
})
//或者
$.fn.方法名 = function(){

}
```

**jQuery.extend() 给jQuery 对象本身扩展方法**

```
$.extend({
   方法名: function(){
   }
})
```

## 4 jQuery UI

- 官网 <https://jqueryui.com/>

  

## 5 jQueryMobile

- 官网 <https://jquerymobile.com/>

- 教程 <http://www.runoob.com/jquerymobile/jquerymobile-tutorial.html>

  

## 6 Sizzle

- 官网 <https://sizzlejs.com/>

## 7 Zepto

- 官网 <http://zeptojs.com/>
- 与jquery区别： <https://www.zhihu.com/question/25379207>