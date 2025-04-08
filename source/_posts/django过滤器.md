---
title: django过滤器
tags: [lnhdjango基础]
date: 2021-04-30 15:01:03
categories: 理解
photos:
book:
---

# 模板层之过滤器

## 1模版语法之数据类型过滤

```
 **语法：** {{obj|filter__name:param}}  变量名字|过滤器名称：变量
```

### default

 如果一个变量是false或者为空，使用给定的默认值。否则，使用变量的值。例如： 

```html
 {{ value|default:"nothing" }}
```

### length

返回值的长度。它对字符串和列表都起作用。例如：

```html
`{{ value|length }}`
```

```
如果 value 是 ['a', 'b', 'c', 'd']，那么输出是 4。
```



### filesizeformat

```
将值格式化为一个 “人类可读的” 文件尺寸 （例如 `'13 KB'`, `'4.1 MB'`, `'102 bytes'`, 等等）。例如：
```

```
`{{ value|filesizeformat }}`
```

如果 `value` 是 123456789，输出将会是 `117.7 MB`。

### date

如果 value=datetime.datetime.now()

```
`{{ value|date:``"Y-m-d"` `}}　　`
```

### slice

如果 value="hello world"

```html
`{{ value|``slice``:``"2:-1"` `}}`
```



```
truncatechars[ ](http://python.usyiyi.cn/documents/django_182/ref/templates/builtins.html#truncatechars)

如果字符串字符多于指定的字符数量，那么会被截断。截断的字符串将以可翻译的省略号序列（“...”）结尾。

**参数：**要截断的字符数

例如：

`{{ value|truncatechars:``9` `}}`
```



### safe

Django的模板中会对HTML标签和JS等语法标签进行自动转义，原因显而易见，这样是为了安全。但是有的时候我们可能不希望这些HTML元素被转义，比如我们做一个内容管理系统，后台添加的文章中是经过修饰的，这些修饰可能是通过一个类似于FCKeditor编辑加注了HTML修饰符的文本，如果自动转义的话显示的就是保护HTML标签的源文件。为了在Django中关闭HTML的自动转义有两种方式，如果是一个单独的变量我们可以通过过滤器“|safe”的方式告诉Django这段代码是安全的不必转义。比如：

```
`value``=``"`">点击"`
```

```
`{{ value|safe}}`
```

## 其它过滤器了解）

```
| 过滤器             | 描述                                                     | 示例                                                         |
| ------------------ | -------------------------------------------------------- | ------------------------------------------------------------ |
| upper              | 以大写方式输出                                           | {{ user.name \| upper }}                                     |
| add                | 给value加上一个数值                                      | {{ user.age \| add:”5” }}                                    |
| addslashes         | 单引号加上转义号                                         |                                                              |
| capfirst           | 第一个字母大写                                           | {{ ‘good’\| capfirst }} 返回”Good”                           |
| center             | 输出指定长度的字符串，把变量居中                         | {{ “abcd”\| center:”50” }}                                   |
| cut                | 删除指定字符串                                           | {{ “You are not a Englishman” \| cut:”not” }}                |
| date               | 格式化日期                                               |                                                              |
| default            | 如果值不存在，则使用默认值代替                           | {{ value \| default:”(N/A)” }}                               |
| default_if_none    | 如果值为None, 则使用默认值代替                           |                                                              |
| dictsort           | 按某字段排序，变量必须是一个dictionary                   | {% for moment in moments \| dictsort:”id” %}                 |
| dictsortreversed   | 按某字段倒序排序，变量必须是dictionary                   |                                                              |
| divisibleby        | 判断是否可以被数字整除                                   | `{{ 224 | divisibleby:2 }}  返回 True`                       |
| escape             | 按HTML转义，比如将”<”转换为”&lt”                         |                                                              |
| filesizeformat     | 增加数字的可读性，转换结果为13KB,89MB,3Bytes等           | `{{ 1024 | filesizeformat }} 返回 1.0KB`                     |
| first              | 返回列表的第1个元素，变量必须是一个列表                  |                                                              |
| floatformat        | 转换为指定精度的小数，默认保留1位小数                    | {{ 3.1415926 \| floatformat:3 }} 返回 3.142 四舍五入         |
| get_digit          | 从个位数开始截取指定位置的数字                           | {{ 123456 \| get_digit:’1’}}                                 |
| join               | 用指定分隔符连接列表                                     | {{ [‘abc’,’45’] \| join:’*’ }} 返回 abc*45                   |
| length             | 返回列表中元素的个数或字符串长度                         |                                                              |
| length_is          | 检查列表，字符串长度是否符合指定的值                     | {{ ‘hello’\| length_is:’3’ }}                                |
| linebreaks         | 用<p>或<br>标签包裹变量                                  | {{ “Hi\n\nDavid”\|linebreaks }} 返回<p>Hi</p><p>David</p>    |
| linebreaksbr       | 用<br/>标签代替换行符                                    |                                                              |
| linenumbers        | 为变量中的每一行加上行号                                 |                                                              |
| ljust              | 输出指定长度的字符串，变量左对齐                         | {{‘ab’\|ljust:5}}返回 ‘ab  ’                                 |
| lower              | 字符串变小写                                             |                                                              |
| make_list          | 将字符串转换为列表                                       |                                                              |
| pluralize          | 根据数字确定是否输出英文复数符号                         |                                                              |
| random             | 返回列表的随机一项                                       |                                                              |
| removetags         | 删除字符串中指定的HTML标记                               | {{value \| removetags: “h1 h2”}}                             |
| rjust              | 输出指定长度的字符串，变量右对齐                         |                                                              |
| slice              | 切片操作， 返回列表                                      | {{[3,9,1] \| slice:’:2’}} 返回 [3,9] `{{ 'asdikfjhihgie' | slice:':5' }} 返回 ‘asdik’` |
| slugify            | 在字符串中留下减号和下划线，其它符号删除，空格用减号替换 | `{{ '5-2=3and5 2=3' | slugify }} 返回 5-23and5-23`           |
| stringformat       | 字符串格式化，语法同python                               |                                                              |
| time               | 返回日期的时间部分                                       |                                                              |
| timesince          | 以“到现在为止过了多长时间”显示时间变量                   | 结果可能为 45days, 3 hours                                   |
| timeuntil          | 以“从现在开始到时间变量”还有多长时间显示时间变量         |                                                              |
| title              | 每个单词首字母大写                                       |                                                              |
| truncatewords      | 将字符串转换为省略表达方式                               | `{{ 'This is a pen' | truncatewords:2 }}返回``This is ...`   |
| truncatewords_html | 同上，但保留其中的HTML标签                               | `{{ 'This is a pen' | truncatewords:2 }}返回``This is ...`   |
| urlencode          | 将字符串中的特殊字符转换为url兼容表达方式                | {{ ‘http://www.aaa.com/foo?a=b&b=c’ \| urlencode}}           |
| urlize             | 将变量字符串中的url由纯文本变为链接                      |                                                              |
| wordcount          | 返回变量字符串中的单词数                                 |                                                              |
| yesno              | 将布尔变量转换为字符串yes, no 或maybe                    | `{{ True | yesno }}{{ False | yesno }}{{ None | yesno }} ``返回 ``yes``no ``maybe` |
```



## locals()可以接受所有的模板变量

### 模板之数据类型过滤器

#### views.py层之数据类型过滤

```python
def moban(request):
	name = 'shouyue'
    age = 18
    ll = [1,2,'shouyue']
    tu = (1,2,3)
    dic = {'name':'shouyue','age':18,'ll':[1,2,4]}
    return render(request,'moban.html',locals())
```

#### template层之数据类型过滤

```html
<p>统计字符串的长度:{{ name|length }}</p>
<p>统计字符串相加:{{ name|add:'dsb' }}</p>
<p>数字相加add:{{ age|add:'11' }}</p>
<p>利用过滤器判断列表没有值的时候执行默认值:{{ ll2|default:'没有值' }}</p>
{#前闭后开区间#}
<p>python列表切片类似的过滤器之slice:{{ ll|slice:'2:-1' }}</p>
{#支持步长#}
<p>python字符串取值类似过滤器之slice-字符串:{{ name|slice:'0:3:3' }}</p>
{#三个起步#}
```

### 模板之文件过滤器

#### views.py层之文件过滤

```python
def moban(request):
	file_size=1024
    return render(request,'moban.html',locals())
```

#### template层之文件过滤

```html
<p>过滤器之truncatechars:{{ 'dafddfafgadfgaasdgadgfadaf'|truncatechars:5 }}</p>
<p>过滤器之truncatewords:{{ '我 dfaf ga dfgaas 你 dgf adaf'|truncatewords:5 }}</p>
```

### 模板之HTML标签和JS等语法标签进行自动转义过滤器safe

#### 1.HTML标签自动转义过滤

##### views.py层之safeHTML标签自动转义过滤

```python
def moban(request):
	h1='<h1>你好</h1>'
    return render(request,'moban.html',locals())
```

##### template层之safeHTML标签自动转义过滤

```html
<p>过滤器之不用safe:{{ h1 }}</p>
<p>过滤器之用safe:{{ h1|safe }}</p>
```

#### 2.css选择器自动转义过滤

##### views.py层之safecss选择器自动转义过滤

```python
def moban(request):
	css1 = '''
        <style>
        p {
            color:red
        }
    </style>
        '''
    return render(request,'moban.html',locals())
```

##### template层之safecss选择器自动转义过滤

```html
<p>css之不用safe:{{ css1 }}</p>
<p>css之用safe:{{ css1|safe }}</p>
```

#### 3.JS等语法标签自动转义过滤

##### views.py层之safeJS自动转义过滤

```python
def moban(request):
	script='<script>alert(111)</script>'
    return render(request,'moban.html',locals())
```

##### template层之safeJS自动转义过滤

```html
<p>过滤器之不用safe:{{ script }}</p>
会产生弹窗，就会形成攻击
{#<p>过滤器之用safe:{{ script|safe }}</p>#}
```

