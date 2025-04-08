---
title: 爬虫基础scrapy框架3
tags: []
date: 2021-04-26 15:55:32
categories:
photos:
book:
---

# Scrapy框架(三)

## CrawlSpider

- **创建CrawlSpider 的爬虫文件**

- 列表，列举所有的模板

- ![1619425009752](爬虫基础scrapy框架3\1619425009752.png)

  命令： -t 使用模板 名字 域名

  `scrapy genspider -t crawl zongheng  xxx.com`

- **Rule**

  **功能**：Rule用来定义CrawlSpider的爬取规则

  **参数**：

  ```python
  (self, link_extractor=None, callback=None, cb_kwargs=None, follow=None,
                   process_links=None, process_request=None, errback=None):
  ```

  **link_extracto**r：  Link Extractor对象，它定义如何从每个已爬网页面中提取链接。
  **callback** ：回调函数  处理link_extractor形成的response
  **cb_kwargs** ： cb:callback   回调函数的参数，是一个包含要传递给回调函数的关键字参数的dict
  **follow** ：它指定是否应该从使用此规则提取的每个响应中跟踪链接。

  两个值：True  False；follow=True   link_extractor形成的response  会交给rule;False  则不会;
  **process_links** ： 用于过滤链接的回调函数 ， 处理link_extractor提取到的链接  
  **process_request** ： 用于过滤请求的回调函数

  **errback:**处理异常的函数

- **LinkExractor**

LinkExractor也是scrapy框架定义的一个类
它唯一的目的是从web页面中提取最终将被跟踪的额连接。

我们也可定义我们自己的链接提取器，只需要提供一个名为extract_links的方法，它接收Response对象
并返回scrapy.link.Link对象列表。

```python
def __init__(self, allow=(), deny=(), allow_domains=(), deny_domains=(), restrict_xpaths=(),tags=('a', 'area'), attrs=('href',), canonicalize=False,unique=True, process_value=None, deny_extensions=None, restrict_css=(), strip=True, restrict_text=None):
```

**allow**(允许): 正则表达式,或其列表   匹配url   为空   则匹配所有url

**deny**(不允许):正则表达式,或其列表   排除url   为空   则不排除url

**allow_domains**(允许的域名):str,或其列表

**deny_domains**(不允许的域名);str,或其列表
**restrict_xpaths**(通过xpath 限制匹配区域): xpath表达式  或列表
**restrict_css**(通过css 限制匹配区域): css表达式 
**restrict_text**(通过text 限制匹配区域): 正则表达式 
**tags**=('a', 'area'):允许的标签
**attrs**=('href',):允许的属性
**canonicalize**:规范化每个提取的url
**unique**(唯一):将匹配到的重复链接过滤
**process_value**:接收 从标签提取的每个值     函数 
**deny_extensions** ：不允许拓展    提取链接的时候,忽略一些扩展名.jpg  .xxx



## 案例实战-爬取纵横小说

### 1.需求分析

#### 页面分析

- ![纵横小说框架1](D:\Windows 10 Documents\Desktop\爬虫基础课改PPT+教案\爬虫基础教案\scrapy框架图片\纵横小说框架1.png)



- **二级页面  小说详情**

![纵横小说需求2](G:/%E4%BC%81%E4%B8%9Aqq/3002821514/FileRecv/%E7%88%AC%E8%99%AB%E5%9F%BA%E7%A1%80%E6%95%99%E6%A1%88-%E6%96%97%E7%AC%A0/%E7%88%AC%E8%99%AB%E5%9F%BA%E7%A1%80%E6%95%99%E6%A1%88-%E6%96%97%E7%AC%A0/7.Scrapy%E6%A1%86%E6%9E%B6(%E4%B8%89).assets/%E7%BA%B5%E6%A8%AA%E5%B0%8F%E8%AF%B4%E9%9C%80%E6%B1%822-1596131710359.png)



- **三级页面  章节目录**

![纵横小说需求3](G:/%E4%BC%81%E4%B8%9Aqq/3002821514/FileRecv/%E7%88%AC%E8%99%AB%E5%9F%BA%E7%A1%80%E6%95%99%E6%A1%88-%E6%96%97%E7%AC%A0/%E7%88%AC%E8%99%AB%E5%9F%BA%E7%A1%80%E6%95%99%E6%A1%88-%E6%96%97%E7%AC%A0/7.Scrapy%E6%A1%86%E6%9E%B6(%E4%B8%89).assets/%E7%BA%B5%E6%A8%AA%E5%B0%8F%E8%AF%B4%E9%9C%80%E6%B1%823-1596131717680.png)

- **四级页面  章节内容**

![纵横小说需求4](G:/%E4%BC%81%E4%B8%9Aqq/3002821514/FileRecv/%E7%88%AC%E8%99%AB%E5%9F%BA%E7%A1%80%E6%95%99%E6%A1%88-%E6%96%97%E7%AC%A0/%E7%88%AC%E8%99%AB%E5%9F%BA%E7%A1%80%E6%95%99%E6%A1%88-%E6%96%97%E7%AC%A0/7.Scrapy%E6%A1%86%E6%9E%B6(%E4%B8%89).assets/%E7%BA%B5%E6%A8%AA%E5%B0%8F%E8%AF%B4%E9%9C%80%E6%B1%824-1596131724684.png)

#### 页面总体结构

![页面总体结构](D:\Windows 10 Documents\Desktop\爬虫基础课改PPT+教案\爬虫基础教案\scrapy框架图片\页面总体结构.png)

#### 需求字段

- 小说信息

![小说信息数据库字段](G:/%E4%BC%81%E4%B8%9Aqq/3002821514/FileRecv/%E7%88%AC%E8%99%AB%E5%9F%BA%E7%A1%80%E6%95%99%E6%A1%88-%E6%96%97%E7%AC%A0/%E7%88%AC%E8%99%AB%E5%9F%BA%E7%A1%80%E6%95%99%E6%A1%88-%E6%96%97%E7%AC%A0/7.Scrapy%E6%A1%86%E6%9E%B6(%E4%B8%89).assets/%E5%B0%8F%E8%AF%B4%E4%BF%A1%E6%81%AF%E6%95%B0%E6%8D%AE%E5%BA%93%E5%AD%97%E6%AE%B5-1596131734576.png)

- 章节信息

![章节信息数据库字段](G:/%E4%BC%81%E4%B8%9Aqq/3002821514/FileRecv/%E7%88%AC%E8%99%AB%E5%9F%BA%E7%A1%80%E6%95%99%E6%A1%88-%E6%96%97%E7%AC%A0/%E7%88%AC%E8%99%AB%E5%9F%BA%E7%A1%80%E6%95%99%E6%A1%88-%E6%96%97%E7%AC%A0/7.Scrapy%E6%A1%86%E6%9E%B6(%E4%B8%89).assets/%E7%AB%A0%E8%8A%82%E4%BF%A1%E6%81%AF%E6%95%B0%E6%8D%AE%E5%BA%93%E5%AD%97%E6%AE%B5-1596131742420.png)

### 2.代码实现

#### 爬取逻辑

![crawlspider流程](G:/%E4%BC%81%E4%B8%9Aqq/3002821514/FileRecv/%E7%88%AC%E8%99%AB%E5%9F%BA%E7%A1%80%E6%95%99%E6%A1%88-%E6%96%97%E7%AC%A0/%E7%88%AC%E8%99%AB%E5%9F%BA%E7%A1%80%E6%95%99%E6%A1%88-%E6%96%97%E7%AC%A0/7.Scrapy%E6%A1%86%E6%9E%B6(%E4%B8%89).assets/crawlspider%E6%B5%81%E7%A8%8B-1596131751356.png)

#### **spider文件**

根据目标数据--要存储的数据，在rules中定义Rule规则，按需配置callback函数，解析response获得想要的数据。

- parse_book函数获取小说信息
- parse_catalog函数获取章节信息
- get_content函数获取章节内容

```python
# -*- coding: utf-8 -*-
import datetime
import scrapy
from scrapy.linkextractors import LinkExtractor
from scrapy.spiders import CrawlSpider, Rule
from ..items import   NovelItem,ChapterItem,ContentItem

class ZhSpider(CrawlSpider):
    name = 'zh'
    allowed_domains = ['book.zongheng.com']
    start_urls = ['http://book.zongheng.com/store/c0/c0/b0/u1/p1/v0/s1/t0/u0/i1/ALL.html']#起始的url

    #定义爬取规则  1.提取url(LinkExtractor对象)   2.形成请求    3.响应的处理规则
    rules = (
        Rule(LinkExtractor(allow=r'http://book.zongheng.com/book/\d+.html',restrict_xpaths='//div[@class="bookname"]'),
             callback='parse_book', follow=True,process_links="process_booklink"),
        Rule(LinkExtractor(allow=r'http://book.zongheng.com/showchapter/\d+.html'), callback='parse_catalog', follow=True,),
        Rule(LinkExtractor(allow=r'http://book.zongheng.com/chapter/\d+/\d+.html',restrict_xpaths='//ul[@class="chapter-list clearfix"]'),
             callback='get_content', follow=False,process_links="process_chpter"),
    )
    def process_booklink(self,links):
        #处理 LinkExtractor  提取到的url
        for  index,link  in  enumerate(links):
            if index==0:
                print(index,link.url)
                yield link
            else:
                return
            
    def  process_chpter(self,links):
        for  index,link  in  enumerate(links):
            if index<=20:             
                yield link
            else:
                return
            
    def parse_book(self, response):
        category = response.xpath('//div[@class="book-label"]/a/text()').extract()[1]
        book_name = response.xpath('//div[@class="book-name"]/text()').extract()[0].strip()
        author = response.xpath('//div[@class="au-name"]/a/text()').extract()[0]
        status = response.xpath('//div[@class="book-label"]/a/text()').extract()[0]
        book_nums = response.xpath('//div[@class="nums"]/span/i/text()').extract()[0]
        description = ''.join(response.xpath('//div[@class="book-dec Jbook-dec hide"]/p/text()').re("\S+"))
        c_time = datetime.datetime.now()
        book_url = response.url
        catalog_url = response.css("a").re('http://book.zongheng.com/showchapter/\d+.html')[0]
    
        item = NovelItem()
        item["category"] = category
        item["book_name"] = book_name
        item["author"] = author
        item["status"] = status
        item["book_nums"] = book_nums
        item["description"] = description
        item["c_time"] = c_time
        item["book_url"] = book_url
        item["catalog_url"] = catalog_url
        yield item
              
    def  parse_catalog(self,response):
        a_tags = response.xpath('//ul[@class="chapter-list clearfix"]/li/a')
        chapter_list = []
        catalog_url = response.url
        for a in a_tags:
            print("解析catalog_url")
            title = a.xpath("./text()").extract()[0]
            chapter_url = a.xpath("./@href").extract()[0]
            chapter_list.append((title, chapter_url, catalog_url))
        item = ChapterItem()
        item["chapter_list"] = chapter_list
        yield item
        
    def  get_content(self,response):
        chapter_url = response.url
        content = ''.join(response.xpath('//div[@class="content"]/p/text()').extract())
        c_time = datetime.datetime.now()
        # 向管道传递数据
        item = ContentItem()
        item["chapter_url"] = chapter_url
        item["content"] = content
        yield item
    
```

#### items文件

items文件里的字段，是根据目标数据的需求，

```python
import scrapy
class ZonghengItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    pass

class NovelItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    category = scrapy.Field()
    book_name = scrapy.Field()
    author = scrapy.Field()
    status = scrapy.Field()
    book_nums = scrapy.Field()
    description = scrapy.Field()
    c_time = scrapy.Field()
    book_url = scrapy.Field()
    catalog_url = scrapy.Field()

class ChapterItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    chapter_list = scrapy.Field()
    catalog_url = scrapy.Field()

class ContentItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    content = scrapy.Field()
    chapter_url = scrapy.Field()
```

#### pipelines文件

此处是将数据写入数据库，

1. 先写入小说信息
2. 写入章节信息，除了章节内容之外的部分
3. 根据章节url，写入章节内容

```python
# -*- coding: utf-8 -*-

import pymysql
from  zongheng.items import NovelItem,ChapterItem,ContentItem
import datetime
from  scrapy.exceptions import DropItem
class ZonghengPipeline(object):
    #连接数据库
    def open_spider(self,spider):
        data_config = spider.settings["DATABASE_CONFIG"]
        print("数据库内容",data_config)
        if data_config["type"] == "mysql":
            self.conn = pymysql.connect(**data_config["config"])
            self.cursor = self.conn.cursor()
            spider.conn = self.conn
            spider.cursor = self.cursor
    #数据存储
    def process_item(self, item, spider):
        #1.小说信息存储
        if isinstance(item,NovelItem):
            sql="select id from  novel  where  book_name=%s  and author=%s"
            self.cursor.execute(sql,(item["book_name"],item["author"]))
            if  not self.cursor.fetchone():
                #写入小说数据
                sql="insert  into  novel(category,book_name,author,status,book_nums,description,c_time,book_url,catalog_url)" \
                    "values (%s,%s,%s,%s,%s,%s,%s,%s,%s)"
                self.cursor.execute(sql,(
                    item["category"],
                    item["book_name"],
                    item["author"],
                    item["status"],
                    item["book_nums"],
                    item["description"],
                    item["c_time"],
                    item["book_url"],
                    item["catalog_url"],
                ))
                self.conn.commit()
            return item
        #2.章节信息存储
        elif isinstance(item,ChapterItem):

            #写入  目录信息
            sql = "insert into  chapter(title,ordernum,c_time,chapter_url,catalog_url)  values(%s,%s,%s,%s,%s)"
            data_list=[]
            for  index,chapter  in  enumerate(item["chapter_list"]):
                c_time = datetime.datetime.now()
                ordernum=index+1
                title,chapter_url,catalog_url=chapter
                data_list.append((title,ordernum,c_time,chapter_url,catalog_url))
            self.cursor.executemany(sql,data_list)
            self.conn.commit()
            return item
        #3.章节内容存储
        elif isinstance(item, ContentItem):
            sql="update chapter set  content=%s where chapter_url=%s"
            content=item["content"]
            chapter_url=item["chapter_url"]
            self.cursor.execute(sql,(content,chapter_url))
            self.conn.commit()
            return item
        else:
            return  DropItem
    #关闭数据库
    def close_spider(self,spider):
        data_config=spider.settings["DATABASE_CONFIG"]#settings里设置数据库
        if data_config["type"]=="mysql":
            self.cursor.close()
            self.conn.close()
```

#### settings文件

- 设置robots协议，添加全局请求头，开启管道
- 开启下载延迟
- 配置数据库

```python
# -*- coding: utf-8 -*-

BOT_NAME = 'zongheng'

SPIDER_MODULES = ['zongheng.spiders']
NEWSPIDER_MODULE = 'zongheng.spiders'

# Obey robots.txt rules
ROBOTSTXT_OBEY = False

# Configure maximum concurrent requests performed by Scrapy (default: 16)
#CONCURRENT_REQUESTS = 32

# Configure a delay for requests for the same website (default: 0)
# See https://docs.scrapy.org/en/latest/topics/settings.html#download-delay
# See also autothrottle settings and docs
DOWNLOAD_DELAY = 1
# The download delay setting will honor only one of:
#CONCURRENT_REQUESTS_PER_DOMAIN = 16
#CONCURRENT_REQUESTS_PER_IP = 16

# Override the default request headers:
DEFAULT_REQUEST_HEADERS = {
  'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
  'Accept-Language': 'en',
   "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36"
}

# Configure item pipelines
# See https://docs.scrapy.org/en/latest/topics/item-pipeline.html
ITEM_PIPELINES = {
   'zongheng.pipelines.ZonghengPipeline': 300,
}

DATABASE_CONFIG={
    "type":"mysql",
    "config":{
        "host":"localhost",
        "port":3306,
        "user":"root",
        "password":"123789",
        "db":"zhnovel",
        "charset":"utf8"
    }
}

LOG_FORMAT='%(asctime)s  [%(name)s] %(levelname)s: %(message)s'
LOG_DATEFORMAT='%Y'
```

## CrawlerSpider去重

这里对链接做了条件判定,通过集合seen去重

```python
def _requests_to_follow(self, response):
    if not isinstance(response, HtmlResponse):
        return
    seen = set()
    for rule_index, rule in enumerate(self._rules):
        links = [lnk for lnk in rule.link_extractor.extract_links(response)
                 if lnk not in seen]
        for link in rule.process_links(links):
            seen.add(link)
            request = self._build_request(rule_index, link)
            yield rule._process_request(request, response)
```

