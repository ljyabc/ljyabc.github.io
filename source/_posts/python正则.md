---
title: python正则
tags: [python基础]
date: 2019-03-02 21:57:36
categories: 查找,灵活
photos:
---

### 正则匹配

##### 一.常用符号

- 转义字符\ （******）

  ```
  在正则中有特殊意义的符号通过转义字符转义，就会变成普通的符号
  eg: \. --就是普通的. （.本来是统配意义）
  无特殊意义的字符，通过转义符号转义，就会变得有特殊意义
  eg:\d --变成匹配数字的意义（d本来无特殊意义）
  ```


- \w与\W

  ```python
  print(re.findall('\w', 'hello zhang 123 章'))  # 匹配Unicode（str）模式 匹配任何单词字符
  # ['h', 'e', 'l', 'l', 'o', 'z', 'h', 'a', 'n', 'g', '1', '2', '3'，'章']
  
  print(re.findall('\W', 'hello zhang 123'))  # 匹配任何非unicode的单词字符
  # [' ', ' ']
  ```

- \s与\S

  ```python
  print(re.findall('\s', 'hello zhang 123'))  # 匹配unicode中的空白字符
  # [' ', ' ']
  
  print(re.findall('\s', 'hello \n \t zhang 123'))  # \n \t都是空都可以被\s匹配
  # [' ', '\n', ' ', '\t', ' ', ' ']
  
  print(re.findall('\S', 'hello zhang 123'))  # 匹配任何非unicode的非空白字符
  # ['h', 'e', 'l', 'l', 'o', 'z', 'h', 'a', 'n', 'g', '1', '2', '3']
  ```

- \n与\t

  ```python
  print(re.findall(r'\n', 'hello zhang \n123'))
  # ['\n']
  
  print(re.findall(r'\t', 'hello zhang \t123'))
  # ['\t']
  ```

- \d与\D

  ```python
  print(re.findall('\d', 'hello zhang 123'))  # 匹配数字
  # ['1', '2', '3']
  
  print(re.findall('\D', 'hello zhang 123'))  # 匹配非数字
  # ['h', 'e', 'l', 'l', 'o', ' ', 'z', 'h', 'a', 'n', 'g', ' ']  <class 'list'>
  ```

- \A与\Z

  ```python
  print(re.findall('\Ahe', 'hello zhang 123'))  # 相当^
  # ['he']
  
  print(re.findall('123\Z', 'hello zhang 123'))  # 相当$
  # ['123']
  ```

- ^与$

  ```python
  print(re.findall('^h', 'hello zhang 123'))
  # ['h']
  
  print(re.findall('3$', 'hello zhang 123'))
  # ['3']
  ```

- 重复匹配：| . | * | ? | .* | .*? | + |{n,m}|

  ```python
  #  .通配符
  print(re.findall('z...g', 'zhang'))
  # ['zhang']
  
  print(re.findall('.h', 'zhang cheng h mm'))
  # ['zh', 'ch', ' h']
  
  print(re.findall('z.h', 'z\nhang'))
  # []
  
  print(re.findall('z.h', 'z\nhang', re.S))
  # ['z\nh']
  
  print(re.findall('z.h', 'z\nhang', re.DOTALL))
  # ['z\nh']
  ```

  ```python
  # * == {0,n} 默认是贪婪匹配
  print(re.findall('ab*', 'bbbbbbbbbbb'))
  # []
  
  print(re.findall('ab*', 'a'))
  # ['a']
  
  print(re.findall('ab*', 'abcd'))
  # ['ab']
  
  print(re.findall('ab*', 'abbbbbbbb'))
  # ['abbbbbbbb']
  ```

  ```python
  # ? == {0,1}
  print(re.findall('ab?', 'a'))
  # ['a']
  
  print(re.findall('ab?', 'abbbb '))
  # ['ab']
  
  # 匹配所有包含小数在内的数字
  print(re.findall('\d+\.?\d*', 'jskdafnjk12jnk1.2323asdass12sjndknas89a8asndjk98ad987'))
  # ['12', '1.2323', '12', '89', '8', '98', '987']
  ```

  ```python
  # .*默认为贪婪匹配
  print(re.findall('z.*g', 'zcghang  '))
  # ['zcghang']
  
  # .*?默认为非贪婪匹配：推荐使用
  print(re.findall('z.*?g', 'zcghang '))
  # ['zcg']
  ```

  ```python
  # + == {1，n}
  print(re.findall('zh+', 'zbang'))
  # [] 
  
  print(re.findall('zh+', 'zhang'))
  # ['zh']
  ```

  ```python
  # {n,m}
  print(re.findall('ab{2}', 'abbbbb'))
  # ['abb']
  
  print(re.findall('ab{2,4}', 'abbbbbb  abbb ab abb'))
  # ['abbbb', 'abbb', 'abb']
  
  print(re.findall('ab{1,}', 'abbb a ab abbbbbbbbbb'))
  # ['abbb', 'ab', 'abbbbbbbbbb']
  
  print(re.findall('ab{0,}', 'abbbb a ab abbbbbbbbb'))
  # ['abbbb', 'a', 'ab', 'abbbbbbbbb']
  ```

- #### []

  ```python
  # []
  print(re.findall('a[1*-]b', 'a1b a*b a-b'))  # []内都为普通字符，且如果-没有被转译的话，应该放到[]的开头或结尾
  # ['a1b', 'a*b', 'a-b']
  
  print(re.findall('a[^1*-]b', 'a1b a*b a-b a=b'))  # ^意思代表取反
  # ['a=b']
  
  print(re.findall('a[0-9]b', 'a1b a*b a-b a=b a2b'))  # 取a[o到9]b
  # ['a1b', 'a2b']
  
  print(re.findall('a[a-z]b', 'abb acb adb aeb amb a'))  # 取a[a到z]b
  # ['abb', 'acb', 'adb', 'aeb', 'amb']
  
  print(re.findall('a[a-zA-Z]b', 'aZb aBB axb'))  # # 取a[a到z,A到Z]b
  # ['aZb', 'axb']
  ```

- ()

  ```python
  # ()
  print(re.findall('(ab)+123', 'ababab123'))  # 匹配到末尾中含ab123中的ab
  # ['ab']
  
  print(re.findall('(?:ab)+123', 'ababab123'))
  # ['ababab123']
  
  print(re.findall('href="(.*?)"', '<a href="http://www.baidu.com">点击</a>'))
  # ['http://www.baidu.com']
  
  print(re.findall('href="(?:.*?)"', '<a href="http://www.baidu.com">点击</a>'))
  # ['href="http://www.baidu.com"']
  ```

- |

  ```python
  # |
  print(re.findall('compan(?:n|y|ies)', 'Too many companies have gone bankrupt , and the next one is my company'))
  # ['companies', 'company']  n|y|ies结尾的字符
  ```

##### 二.re模块的常用方法

```python
1.findall查找所有
print(re.findall('z', 'zhan zhang zzz z'))  # 返回所有满足匹配条件的结果
# ['z', 'z', 'z', 'z', 'z', 'z']

2.search找到第一个匹配的对象
print(re.search('z', 'zhan zhang zzz z'))  # 找到第一个匹配对象，没有返回None
# <_sre.SRE_Match object; span=(0, 1), match='z'>

print(re.search('z', 'ehan zhang zzz z').group())  # 通过group（）方法得到匹配的字符串
# z

3.match从第一个匹配
print(re.match('e', 'ehang eee ae'))  # 字符串开始处进行匹配，没有返回None
# <_sre.SRE_Match object; span=(0, 1), match='e'>

4.split切分
print(re.split('[zh]', 'zhang'))  # 先按照z进行进行分割，再按照h进行分割
# ['', '', 'ang']

5.sub替换
print(re.sub('z', 'Z', 'zhang zz'))  # 替换，默认替换所有
# Zhang ZZ

print(re.sub('z', 'Z', 'zhang zz', 1))  # 替换一个
# Zhang zz

6.subn替换结果显示总共替换的个数
print(re.subn('z', 'Z', 'zhang zz'))  # 结果显示总共替换的个数
# ('Zhang ZZ', 3)

7.compile实例化出正则对象
obj = re.compile('\d{2}')
print(obj.search('abc122eeee').group())
# 12

print(obj.findall('abc123eeee'))
# ['12']
```

##### 思维导图

{% pdf  正则.pdf %}

```python
pattern=re.compile('alex')
print(pattern.findall('alex is SB,alex is bigSB'))  # 匹配所有的'alex'
print(pattern.search('alex is SB,alex is bigSB').group())  # 从行首开始匹配,没有就返回None.有就可以通过group拿到
print(re.match('alex','123alex is SB,alex is bigSB'))#以什么结尾,有就返回这个值,没有就返回None
结果如下:
['alex', 'alex']
alex
None
```