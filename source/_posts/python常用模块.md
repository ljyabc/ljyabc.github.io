---
title: python常用模块
tags: [python基础]
date: 2019-03-15 15:44:25
categories: 记忆
photos:
---

#  python常用模块

## datetime

{% pdf datetime.pdf %}

```python
print(datetime.datetime.now())  # 现在的时间
    print(datetime.datetime.fromtimestamp(1231233213))

    print(datetime.datetime.now() + datetime.timedelta(days=3))  # 现在的时间加上未来的3天
    print(datetime.datetime.now() + datetime.timedelta(days=-3))  # 现在的时间减去3天前

    s=datetime.datetime.now()
    print(s.replace(year=2020))  # 修改年份
```

## json与pickle

{% pdf json与pickle.pdf %}

## os

{% pdf os.pdf %}

start.py

```python
# start.py
import os, sys

BASE_PATH = os.path.dirname(__file__)
sys.path.append(BASE_PATH)

from core import src

if __name__ == '__main__':
    src.run()
```

> os.remove(‘path/filename’) 删除文件
>
> os.rename(oldname, newname) 重命名文件
>
> os.walk() 生成目录树下的所有文件名
>
> os.chdir('dirname') 改变目录
>
> os.mkdir/makedirs('dirname')创建目录/多层目录
>
> os.rmdir/removedirs('dirname') 删除目录/多层目录
>
> os.listdir('dirname') 列出指定目录的文件
>
> os.getcwd() 取得当前工作目录
>
> os.chmod() 改变目录权限
>
> os.path.basename(‘path/filename’) 去掉目录路径，返回文件名
>
> os.path.dirname(‘path/filename’) 去掉文件名，返回目录路径
>
> os.path.join(path1[,path2[,...]]) 将分离的各部分组合成一个路径名
>
> os.path.split('path') 返回( dirname(), basename())元组
>
> os.path.splitext() 返回 (filename, extension) 元组
>
> os.path.getatime\ctime\mtime 分别返回最近访问、创建、修改时间
>
> os.path.getsize() 返回文件大小
>
> os.path.exists() 是否存在
>
> os.path.isabs() 是否为绝对路径
>
> os.path.isdir() 是否为目录
>
> os.path.isfile() 是否为文件

## sys

常用

```python
1 sys.argv           命令行参数List，第一个元素是程序本身路径
2 sys.exit(n)        退出程序，正常退出时exit(0)
3 sys.version        获取Python解释程序的版本信息
4 sys.maxint         最大的Int值
5 sys.path           返回模块的搜索路径，初始化时使用PYTHONPATH环境变量的值
6 sys.platform       返回操作系统平台名称
```

sys.argv 命令行参数List，第一个元素是程序本身路径

sys.modules.keys() 返回所有已经导入的模块列表

sys.exc_info() 获取当前正在处理的异常类,exc_type、exc_value、exc_traceback当前处理的异常详细信息

sys.exit(n) 退出程序，正常退出时exit(0)

sys.hexversion 获取Python解释程序的版本值，16进制格式如：0x020403F0

sys.version 获取Python解释程序的版本信息

sys.maxint 最大的Int值

sys.maxunicode 最大的Unicode值

sys.modules 返回系统导入的模块字段，key是模块名，value是模块

sys.path 返回模块的搜索路径，初始化时使用PYTHONPATH环境变量的值

sys.platform 返回操作系统平台名称

sys.stdout 标准输出

sys.stdin 标准输入

sys.stderr 错误输出

sys.exc_clear() 用来清除当前线程所出现的当前的或最近的错误信息

sys.exec_prefix 返回平台独立的python文件安装的位置

sys.byteorder 本地字节规则的指示器，big-endian平台的值是'big',little-endian平台的值是'little'

sys.copyright 记录python版权相关的东西

sys.api_version 解释器的C的API版本

sys.stdin,sys.stdout,sys.stderr

## os和sys区别

os模块负责程序与操作系统的交互，提供了访问操作系统底层的接口;sys模块负责程序与python解释器的交互，提供了一系列的函数和变量，用于操控python的运行时环境。 

## random

{% pdf random.pdf %}

```python
 import random

  print(random.random())#(0,1)----float    大于0且小于1之间的小数

  print(random.randint(1,3))  #[1,3]    大于等于1且小于等于3之间的整数

 print(random.randrange(1,3)) #[1,3)    大于等于1且小于3之间的整数

  print(random.choice([1,'23',[4,5]]))#1或者23或者[4,5]

  print(random.sample([1,'23',[4,5]],2))#列表元素任意2个组合

 print(random.uniform(1,3))#大于1小于3的小数，如1.927109612082716 

 item=[1,3,5,7,9]
 random.shuffle(item) #打乱item的顺序,相当于"洗牌"
 print(item)
```

### 产生随机号码

```python
def make_code(size=7):
    res = ''
    for i in range(size):
        # 循环一次则得到一个随机字符（字母/数字）
        s = chr(random.randint(65, 90))
        num = str(random.randint(0, 9))
        res += random.choice([s, num])
    return res

res=make_code()
print(res)
```

### 打印进度条

```python
import time

def make_progress(percent,width=50):
    if percent > 1:
        percent=1
    show_str=('[%%-%ds]' % width) % (int(percent * width) * '#')
    print('\r%s %s%%' %(show_str,int(percent * 100)),end='')

total_size=1025
recv_size=0
while recv_size < total_size:
    time.sleep(0.1) # 模拟经过了0.5的网络延迟下载了1024个字节
    recv_size+=1024
    # 调用打印进度条的功能去打印进度条
    percent=recv_size / total_size
    make_progress(percent)
```

## subprocess

{% pdf subprocess.pdf %}

## time

{% pdf time.pdf %}

## 时间分为三种格式

### 1、时间戳

```python
    start= time.time()
    time.sleep(3)
    stop= time.time()
    print(stop - start)
    输出结果:
    3.000129222869873
```

### 2、格式化的字符串形式

```python
    print(time.strftime('%Y-%m-%d %X'))
    print(time.strftime('%Y-%m-%d %H:%M:%S %p'))
    输出结果:
    2018-07-30 18:04:27
    2018-07-30 18:04:27 PM
```

### 3、 结构化的时间/时间对象

```python
    t1=time.localtime()
    print(t1)
    print(type(t1.tm_min))
    print(t1.tm_mday)

    t2=time.gmtime()
    print(t1)
    print(t2)
```

获取格式化字符串形式的时间麻烦
时间戳与格式化时间之间的转换麻烦
获取之前或者未来的时间麻烦.所以用到了 datetime模块

## hash

- 什么是hash
  hash是一种算法，该算法接受传入的内容，经过运算得到一串hash值
  如果把hash算法比喻为一座工厂
  那传给hash算法的内容就是原材料
  生成的hash值就是生产出的产品

- 为何要用hash算法
  hash值/产品有三大特性：
  1、只要传入的内容一样，得到的hash值必然一样
  2、只要我们使用的hash算法固定，无论传入的内容有多大，
  得到的hash值的长度是固定的
  3、不可以用hash值逆推出原来的内容

  ```
  基于1和2可以在下载文件时做文件一致性校验
  基于1和3可以对密码进行加密
  ```

- 怎么用
  import hashlib
  1、造出hash工厂
  m=hashlib.sha512('你'.encode('utf-8'))

  ```python
  2、运送原材料
  m.update('好啊美sadfsadf丽asdfsafdasdasdfsafsdafasdfasdfsadfsadfsadfsadfasdff的张铭言'.encode('utf-8'))
  ```

  3、产出hash值
  print(m.hexdigest()) #2ff39b418bfc084c8f9a237d11b9da6d5c6c0fb6bebcde2ba43a433dc823966c

{% pdf hash.pdf %}

### hashlib.md5

```python
import hashlib

m=hashlib.md5()# m=hashlib.sha256()

m.update('hello'.encode('utf8'))
print(m.hexdigest())  #5d41402abc4b2a76b9719d911017c592

m.update('alvin'.encode('utf8'))

print(m.hexdigest())  #92a7e713c30abbb0319fa07da2a5c4af

m2=hashlib.md5()
m2.update('helloalvin'.encode('utf8'))
print(m2.hexdigest()) #92a7e713c30abbb0319fa07da2a5c4af

'''
注意：把一段很长的数据update多次，与一次update这段长数据，得到的结果一样
但是update多次为校验大文件提供了可能。
'''
```

### hashlib.sha256

```python
import hashlib
 
# ######## 256 ########
 
hash = hashlib.sha256('898oaFs09f'.encode('utf8'))
hash.update('alvin'.encode('utf8'))
print (hash.hexdigest())#e79e68f070cdedcfe63eaf1a2e92c83b4cfb1b5c6bc452d214c1b7e77cdfd1c7
```

### 模拟撞库破解密码

```
import hashlib
passwds=[
    'alex3714',
    'alex1313',
    'alex94139413',
    'alex123456',
    '123456alex',
    'a123lex',
    ]
def make_passwd_dic(passwds):
    dic={}
    for passwd in passwds:
        m=hashlib.md5()
        m.update(passwd.encode('utf-8'))
        dic[passwd]=m.hexdigest()
    return dic

def break_code(cryptograph,passwd_dic):
    for k,v in passwd_dic.items():
        if v == cryptograph:
            print('密码是===>\033[46m%s\033[0m' %k)

cryptograph='aee949757a2e698417463d47acac93df'
break_code(cryptograph,make_passwd_dic(passwds))

模拟撞库破解密码
```

### hmac.new

```python
#要想保证hmac最终结果一致，必须保证：
#1:hmac.new括号内指定的初始key一样
#2:无论update多少次，校验的内容累加到一起是一样的内容

import hmac

h1=hmac.new(b'egon')
h1.update(b'hello')
h1.update(b'world')
print(h1.hexdigest())

h2=hmac.new(b'egon')
h2.update(b'helloworld')
print(h2.hexdigest())

h3=hmac.new(b'egonhelloworld')
print(h3.hexdigest())

'''
f1bf38d054691688f89dcd34ac3c27f2
f1bf38d054691688f89dcd34ac3c27f2
bcca84edd9eeb86f30539922b28f3981
'''

注意！注意！注意
```

## logger日志

```python
# setting.py

import os

BASE_PATH = os.path.dirname(os.path.dirname(__file__))
DB_PATH = os.path.join(BASE_PATH, 'db')
LOG_PATH = os.path.join(BASE_PATH, 'log')

logfile_name = 'log.log'

standard_format = '[%(asctime)s][%(threadName)s:%(thread)d][task_id:%(name)s][%(filename)s:%(lineno)d]' \
                  '[%(levelname)s][%(message)s]'

simple_format = '[%(levelname)s][%(asctime)s][%(filename)s:%(lineno)d]%(message)s'

id_simple_format = '[%(levelname)s][%(asctime)s] %(message)s'

if not os.path.isdir(LOG_PATH):
    os.mkdir(LOG_PATH)

logfile_path = os.path.join(LOG_PATH, logfile_name)

LOGGING_DIC = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'standard': {
            'format': standard_format
        },
        'simple': {
            'format': simple_format
        },
    },
    'filters': {},
    'handlers': {
        'console': {
            'level': 'DEBUG',
            'class': 'logging.StreamHandler',
            'formatter': 'simple'
        },
        'default': {
            'level': 'DEBUG',
            'class': 'logging.handlers.RotatingFileHandler',
            'formatter': 'standard',
            'filename': logfile_path,
            'maxBytes': 1024 * 1024 * 5,
            'backupCount': 5,
            'encoding': 'utf-8',
        },
    },
    'loggers': {
        '': {
            'handlers': ['default', 'console'],
            'level': 'DEBUG',
            'propagate': True,
        },
    },
}
```

### 接口

```python
bank_logger = common.get_logger('bank')
```

### 公共端函数

```python
def get_logger(name):
    logging.config.dictConfig(setting.LOGGING_DIC)
    logger = logging.getLogger(name)
    return logger
```

## subprocess模块

```python
import subprocess

obj=subprocess.Popen(
    'tasklist',
    shell=True,
    stdout=subprocess.PIPE, # 正确的管道
    stderr=subprocess.PIPE  #  错误的管道

)
print(obj)
stdout_res = obj.stdout.read()  # 得到正确管道中的数据
print(stdout_res.decode('gbk'))
print(stdout_res)

stderr_res1=obj.stderr.read()  #得到错误管道中的数据
stderr_res2=obj.stderr.read()  # 管道中的信息只能取一次
stderr_res3=obj.stderr.read()
print(stderr_res1.decode('gbk'))
print(stderr_res1)
print(stderr_res2)
print(stderr_res3)
```