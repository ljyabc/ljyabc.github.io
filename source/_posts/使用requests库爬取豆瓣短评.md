---
title: 使用requests库爬取豆瓣短评
tags: [python爬虫]
date: 2019-03-16 21:34:20
categories: 理解
photos:
---

# 使用requests库爬取豆瓣短评

本文主要分析`pyhton requests`库的主要用法，以及通过`requests`库来爬取豆瓣短评

## 1. Requests的简单用法

**Requests库的七个主要方法**

| 方法               | 说明                                           |
| ------------------ | ---------------------------------------------- |
| requests.request() | 构造一个请求，支撑以下各方法的基础方法         |
| requests.get()     | 获取HTML网页的主要方法，对应于HTTP的GET        |
| requests.head()    | 获取HTML网页头信息的方法，对应于HTTP的HEAD     |
| requests.post()    | 向HTML网页提交POST请求的方法，对应于HTTP的POST |
| requests.put()     | 向HTML网页提交PUT请求的方法，对应于HTTP的PUT   |
| requests.patch()   | 向HTML网页提交局部修改请求，对应于HTTP的PATCH  |
| requests.delete()  | 向HTML网页提交删除请求，对应于HTTP的DELETE     |

这里我们只需要掌握最常用的requests.get()方法即可。

**Requests.get的用法：**

```python
import requests  #导入Requests库

r = requests.get(url) #使用get方法发送请求，返回包含网页数据的Response并存储到Response对象r中
```

**Response对象的属性：**

- **r.status_code：**http请求的返回状态，200表示连接成功(阅读[HTTP状态码](http://www.runoob.com/http/http-status-codes.html)，了解各状态码含义)
- **r.text：**返回对象的文本内容
- **r.content：**猜测返回对象的二进制形式
- **r.encoding：**分析返回对象的编码方式
- **r.apparent_encoding：**响应内容编码方式（备选编码方式）

> requests库文档地：[点击查看](http://docs.python-requests.org/zh_CN/latest/user/quickstart.html)

## 2. 用requests爬取豆瓣短评

这里我们爬取一部电影短评，就周六刚看完的一部印度电影《小萝莉的猴神大叔》，电影很赞，超越了国籍，宗教，种族，看完之后我就迫不及待的想到豆瓣看看大家都是如何来评价这部电影的。话不多说，我们开始!

**使用requests下载数据的步骤**

- 导入requests库
- 输入要爬取的url
- 使用get()方法
- 打印返回文本
- 抛出异常

```python
import requests

url = 'https://movie.douban.com/subject/26393561/comments'
r = requests.get(url)
print(r.text)
```

**爬取网页通用框架**

- 定义函数
- 设置超时
- 异常处理
- 调用函数

```python
# _*_ coding:utf-8 _*_
import requests

def getHTMLText(url):
    try:
        r = requests.get(url,timeout = 20) # 设置超时，别爬太快
        return r.text
    except:
        return "产生异常！"

if __name__ == '__main__':
    url = 'https://movie.douban.com/subject/26393561/comments'
    print(getHTMLText(url))
```

通过上述代码框架，就可以成功的将网页数据爬取到，爬到之后就可以进行数据解析了。