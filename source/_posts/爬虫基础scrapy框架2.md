---
title: 爬虫基础scrapy框架2
tags: [python之scrapy框架]
date: 2021-04-26 15:29:53
categories: 框架
photos:
book:
---



# scrapy shell

```
# Scrapy shell
[s] Available Scrapy objects:
[s]   scrapy     scrapy module (contains scrapy.Request, scrapy.Selector, etc)  #scrapy  模块
[s]   crawler    <scrapy.crawler.Crawler object at 0x000002624C415F98>  #爬虫对象
[s]   item       {}                                                    #item对象
[s]   request    <GET https://movie.douban.com/top250>                 # 请求对象
[s]   response   <200 https://movie.douban.com/top250>                  #响应对象
[s]   settings   <scrapy.settings.Settings object at 0x000002624C415EB8>  #配置文件
[s]   spider     <DefaultSpider 'default' at 0x2624c8ed3c8>               #spider文件
[s] Useful shortcuts:
[s]   fetch(url[, redirect=True]) Fetch URL and update local objects (by default, redirects are followed)  #通过url  获取response
[s]   fetch(req)                  Fetch a scrapy.Request and update local objects  #通过请求对象  获取response
[s]   shelp()           Shell help (print this help)    #列出命令
[s]   view(response)    View response in a browser     #response  界面    本地浏览器环境下使用
```

# 选择器

```python
html_str="""
<div class="info">
                    <div class="hd">
                        <a href="https://movie.douban.com/subject/1292052/" class="">
                            <span class="title">肖申克的救赎</span>
                            <span class="title">&nbsp;/&nbsp;The Shawshank Redemption</span>
                            <span class="other">&nbsp;/&nbsp;月黑高飞(港)  /  刺激1995(台)</span>
                        </a>
                            <span class="playable">[可播放]</span>
                    </div>
                    <div class="bd">
                        <p class="">
                            导演: 弗兰克·德拉邦特 Frank Darabont&nbsp;&nbsp;&nbsp;主演: 蒂姆·罗宾斯 Tim Robbins /...<br>
                            1994&nbsp;/&nbsp;美国&nbsp;/&nbsp;犯罪 剧情
                        </p>
                        <div class="star">
                                <span class="rating5-t"></span>
                                <span class="rating_num" property="v:average">9.7</span>
                                <span property="v:best" content="10.0"></span>
                                <span>1980500人评价</span>
                        </div>

                            <p class="quote">
                                <span class="inq">希望让人自由。</span>
                            </p>
                    </div>
                </div>
            </div>
"""
from  scrapy.selector  import  Selector
#1.通过text 参数来构造对象
selc_text=Selector(text=html_str)

# print(selc_text.xpath('//div[@class="info"]//div/a/span/text()').extract()[0])
# print(selc_text.xpath('./body/div[@class="info"]//div/a/span/text()').extract()[0])
# print(selc_text.xpath('//div[@class="info"]//div/a/span/text()').extract_first())

#2.通过 response  构造selector对象

from  scrapy.http import   HtmlResponse
response=HtmlResponse(url="http://www.example.com",body=html_str.encode())
Selector(response=response)
# print(response.selector.xpath('//div[@class="info"]//div/a/span/text()').extract()[0])
# print(response.xpath('//div[@class="info"]//div/a/span/text()').extract()[0])

#3.嵌套表达式  selector  可以任意使用 css   xpath  re
# print(response.css("a").xpath('./span[1]/text()').extract()[0])
print(response.css("a").xpath('./span[1]/text()').re("的..")[0])
print(response.css("a").xpath('./span[1]/text()').re_first("的.."))
```

# Scrapy框架(二)



## 次级页面抓取及数据传递拼接（豆瓣电影）

**1.详情页抓取**（次级页面）的主要方法是**get_detail** 方法

```python
def  get_detail(self,response):
	pass
```

**2.参数的传递拼接** 的关键参数是 **meta**参数

#### spider文件

```python
# -*- coding: utf-8 -*-
import json

import scrapy

from ..items  import  DbItem   #是一个安全的字典
class Db250Spider(scrapy.Spider):#继承基础类
    name = 'db250'  #爬虫文件名字  必须存在且唯一
    # allowed_domains = ['movie.douban.com'] #允许的域名   可以不存在 不存在  任何域名都可以
    start_urls = ['https://movie.douban.com/top250']#初始url  必须要存在
    page_num=0
    def parse(self, response):#解析函数  处理响应数据
        node_list=response.xpath('//div[@class="info"]')
        for node  in  node_list:
            #电影名字
            film_name=node.xpath("./div/a/span/text()").extract()[0]
            #导演信息
            director_name=node.xpath("./div/p/text()").extract()[0].strip()
            #评分
            score=node.xpath('./div/div/span[@property="v:average"]/text()').extract()[0]

            #使用管道存储
            item_pipe=DbItem() #创建Dbitem对象  当成字典来使用
            item_pipe['film_name']=film_name
            item_pipe['director_name']=director_name
            item_pipe['score']=score
            # yield item_pipe
            # print("电影信息",dict(item_pipe))
            # 电影简介
            detail_url = node.xpath('./div/a/@href').extract()[0]
            yield scrapy.Request(detail_url,callback=self.get_detail,meta={"info":item_pipe})

        #发送新一页的请求
        #构造url
        self.page_num += 1
        if self.page_num==4:
            return
        page_url="https://movie.douban.com/top250?start={}&filter=".format(self.page_num*25)
        yield scrapy.Request(page_url)
    def  get_detail(self,response):
        item=DbItem()
        #解析详情页的response
        #1.meta 会跟随response 一块返回  2.通过response.meta接收 3.通过update  添加到新的item对象中
        info = response.meta["info"]
        item.update(info)
        #简介内容
        description=response.xpath('//div[@id="link-report"]//span[@property="v:summary"]/text()').extract()[0].strip()
        # print('description',description)

        item["description"]=description
        #通过管道保存
        yield  item

#目标数据  电影信息+ 获取电影简介数据  次级页面的网页源代码里
#请求流程   访问一级页面  提取电影信息+次级页面的url    访问次级页面url 从次级的数据中提取电影简介

#存储的问题   数据没有次序  需要使用  meta传参 保证 同一电影的信息在一起
```

#### items文件

```python
import scrapy


class DbItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    film_name=scrapy.Field()
    director_name=scrapy.Field()
    score=scrapy.Field()
    description=scrapy.Field()
```

#### pipelines 文件

```python
import json
class DbPipeline(object):

    def  open_spider(self,spider):
        #爬虫文件开启,此方法执行
        self.f=open("film_pipe.txt","w",encoding="utf-8")

    def process_item(self, item, spider):
        json_data=json.dumps(dict(item),ensure_ascii=False)+"\n"
        self.f.write(json_data)
        return item
    def  close_spider(self,spider):
        # 爬虫文件关闭,此方法执行
        self.f.close() #关闭文件
```

#### settings 文件

此处删除了大部分注释

```python
# -*- coding: utf-8 -*-

# Scrapy settings for db project

BOT_NAME = 'db'

SPIDER_MODULES = ['db.spiders']
NEWSPIDER_MODULE = 'db.spiders'

# Crawl responsibly by identifying yourself (and your website) on the user-agent
#USER_AGENT = 'db (+http://www.yourdomain.com)'

# Obey robots.txt rules
ROBOTSTXT_OBEY = False

# Override the default request headers:
DEFAULT_REQUEST_HEADERS = {
  'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
  'Accept-Language': 'en',
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36"
}

# Configure item pipelines
# See https://docs.scrapy.org/en/latest/topics/item-pipeline.html
ITEM_PIPELINES = {
   'db.pipelines.DbPipeline': 300,
}
```



## Scrapy   shell

scrapy shell的作用是用于调试，

在项目 目录下输入scrapy shell    https://movie.douban.com/top250 得到下列信息：

scrapy  shell 会自动加载settings里的配置，即robots协议，请求头等都可以加载，从而发起请求可以得到正确的响应信息。

```python
[s] Available Scrapy objects:
[s]   scrapy     scrapy module (contains scrapy.Request, scrapy.Selector, etc)  #scrapy  模块
[s]   crawler    <scrapy.crawler.Crawler object at 0x000002624C415F98>  #爬虫对象
[s]   item       {}                                                    #item对象
[s]   request    <GET https://movie.douban.com/top250>                 # 请求对象
[s]   response   <200 https://movie.douban.com/top250>                  #响应对象
[s]   settings   <scrapy.settings.Settings object at 0x000002624C415EB8>  #配置文件
[s]   spider     <DefaultSpider 'default' at 0x2624c8ed3c8>               #spider文件
[s] Useful shortcuts:
[s]   fetch(url[, redirect=True]) Fetch URL and update local objects (by default, redirects are followed)  #通过url  获取response
[s]   fetch(req)                  Fetch a scrapy.Request and update local objects  #通过请求对象  获取response
[s]   shelp()           Shell help (print this help)    #列出命令
[s]   view(response)    View response in a browser     #response  界面    本地浏览器环境下使用
```

Scrapy shell 本质上就是个普通的python shell
只不过提供了一些需要使用的对象，快捷方法便于我们调试。

- **快捷方法：**
  shelp()
  fetch(url[,redirect=True])
  fetch(request)
  view(response)
- **scrapy 对象：**
  crawler
  spider
  request
  response
  setting

## Scrapy  选择器

- Scrapy提供基于lxml库的解析机制，它们被称为选择器。
  因为，它们“选择”由XPath或CSS表达式指定的HTML文档的某部分。
  Scarpy选择器的API非常小，且非常简单。

- 选择器提供2个方法来提取标签

  xpath()   基于xpath的语法规则 
  css()  基于css选择器的语法规则
  **快捷方式**
  response.xpath()
  response.css()
  它们返回的选择器列表
  **提取文本：**
  selector.extract()  返回文本列表
  selector.extract_first() 返回第一个selector的文本，没有返回None

- 嵌套选择器

  有时候我们获取标签需要多次调用选择方法（.xpath()或.css()）
  response.css('img').xpath('@src')

  Selector还有一个.re()方法使用正则表达式提取数据的方法。
  它返回字符串。
  它一般使用在xpath()，css()方法之后，用来过滤文本数据。
  re_first()用来返回第一个匹配的字符串。

```python
html_str="""
<div class="info">
                    <div class="hd">
                        <a href="https://movie.douban.com/subject/1292052/" class="">
                            <span class="title">肖申克的救赎</span>
                            <span class="title">&nbsp;/&nbsp;The Shawshank Redemption</span>
                            <span class="other">&nbsp;/&nbsp;月黑高飞(港)  /  刺激1995(台)</span>
                        </a>
                            <span class="playable">[可播放]</span>
                    </div>
                    <div class="bd">
                        <p class="">
                            导演: 弗兰克·德拉邦特 Frank Darabont&nbsp;&nbsp;&nbsp;主演: 蒂姆·罗宾斯 Tim Robbins /...<br>
                            1994&nbsp;/&nbsp;美国&nbsp;/&nbsp;犯罪 剧情
                        </p>
                        <div class="star">
                                <span class="rating5-t"></span>
                                <span class="rating_num" property="v:average">9.7</span>
                                <span property="v:best" content="10.0"></span>
                                <span>1980500人评价</span>
                        </div>

                            <p class="quote">
                                <span class="inq">希望让人自由。</span>
                            </p>
                    </div>
                </div>
            </div>
"""
from  scrapy.selector  import  Selector
#1.通过text 参数来构造对象
selc_text=Selector(text=html_str)

# print(selc_text.xpath('//div[@class="info"]//div/a/span/text()').extract()[0])
# print(selc_text.xpath('./body/div[@class="info"]//div/a/span/text()').extract()[0])
# print(selc_text.xpath('//div[@class="info"]//div/a/span/text()').extract_first())

#2.通过 response  构造selector对象
from  scrapy.http import   HtmlResponse
response=HtmlResponse(url="http://www.example.com",body=html_str.encode())
Selector(response=response)
# print(response.selector.xpath('//div[@class="info"]//div/a/span/text()').extract()[0])
# print(response.xpath('//div[@class="info"]//div/a/span/text()').extract()[0])

#3.嵌套表达式  selector  可以任意使用 css   xpath  re
# print(response.css("a").xpath('./span[1]/text()').extract()[0])
print(response.css("a").xpath('./span[1]/text()').re("的..")[0])
print(response.css("a").xpath('./span[1]/text()').re_first("的.."))
```

## scrapy.Spider

- **spider 的名称**   **name**

  一个字符串，用于定义此蜘蛛的名称。蜘蛛名称是Scrapy如何定位（并实例化）蜘蛛，因此它必须是唯一的。这是最重要的蜘蛛属性，它是必需的。

- **起始urls**

  蜘蛛将开始爬取的URL列表。因此，下载的第一页将是此处列出的页面。后续Request将从起始URL中包含的数据连续生成。

- **自定义设置**

  运行此蜘蛛时将覆盖项目范围的设置。必须将其定义为类属性，因为在实例化之前更新了设置。

```python
class Spider(object_ref):
    """Base class for scrapy spiders. All spiders must inherit from this
    class.
    """

    name = None
    custom_settings = None

    def __init__(self, name=None, **kwargs):
        if name is not None:
            self.name = name
        elif not getattr(self, 'name', None):
            raise ValueError("%s must have a name" % type(self).__name__)
        self.__dict__.update(kwargs)
        if not hasattr(self, 'start_urls'):
            self.start_urls = []
```

- **logger**  

使用Spider创建的Python日志器。您可以使用它来发送日志消息。

```python
@property
def logger(self):
    logger = logging.getLogger(self.name)
    return logging.LoggerAdapter(logger, {'spider': self})

def log(self, message, level=logging.DEBUG, **kw):
    """Log the given message at the given log level

    This helper wraps a log call to the logger within the spider, but you
    can use it directly (e.g. Spider.logger.info('msg')) or use any other
    Python logger too.
    """
    self.logger.log(level, message, **kw)
```

- **from_crawler**   

  这是Scrapy用于创建spider的类方法。一般不用覆盖。

```python
@classmethod
def from_crawler(cls, crawler, *args, **kwargs):
    spider = cls(*args, **kwargs)
    spider._set_crawler(crawler)
    return spider

def _set_crawler(self, crawler):
    self.crawler = crawler
    self.settings = crawler.settings
    crawler.signals.connect(self.close, signals.spider_closed)
```

- **start_requests()**  开始请求

  此方法必须返回一个iterable，其中包含第一个要爬网的请求。它只会被调用一次

```python
def start_requests(self):
    cls = self.__class__
    if not self.start_urls and hasattr(self, 'start_url'):
        raise AttributeError(
            "Crawling could not start: 'start_urls' not found "
            "or empty (but found 'start_url' attribute instead, "
            "did you miss an 's'?)")
    if method_is_overridden(cls, Spider, 'make_requests_from_url'):
        warnings.warn(
            "Spider.make_requests_from_url method is deprecated; it "
            "won't be called in future Scrapy releases. Please "
            "override Spider.start_requests method instead (see %s.%s)." % (
                cls.__module__, cls.__name__
            ),
        )
        for url in self.start_urls:
            yield self.make_requests_from_url(url)
    else:
        for url in self.start_urls:
            yield Request(url, dont_filter=True)
```

- **parse**  默认回调函数方法

  这是Scrapy在其请求未指定回调时处理下载的响应时使用的默认回调

```python
def parse(self, response):
    raise NotImplementedError('{}.parse callback is not defined'.format(self.__class__.__name__))
```

- **close**  关闭spider

  spider关闭时调用