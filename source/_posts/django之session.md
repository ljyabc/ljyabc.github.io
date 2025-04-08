---
title: django之session
tags: [lnhdjango基础]
date: 2021-05-05 14:35:39
categories: 理解
photos:
book:
---



# django的session

## 必须先走数据库迁移生产django_session表

```
python manage.py makemirgration

python manage.py mirgrate
```

## session原来和cookie的对比

```python
-解决cookie不安全的问题,
-存在服务器上的键值对{'sdaf随机字符串':{name:lqz,pwd:123}}
-用session必须跟cookie连用
```

## session的使用

### 设置值

```python
-request.session['name']='lqz'
-如果设置多个,它会以字典的形式存储到session表中的session_data中
```

#### 生成session时:

```python
1 生成随机字符串:dfasfasdfa
2 取数据库存储
3 写入cookie(set_cookie('sessionid','dfasfasdfa'))
```

### 取值

```python
name=request.session['name']
```

#### 执行流程:

```python
-取到cookie的随机字符串
-取session表中根据随机字符串查询,查询出session_data这个字典,然后把字典中name返回
```

### 设置和取值的代码

#### 路由

```python
url(r'^set_session/', views.set_session),
url(r'^get_session/', views.get_session),
```

#### 视图层

```python
from django.shortcuts import render,HttpResponse

# Create your views here.

def set_session(request):
    request.session['name']='shouyue'

    return HttpResponse('ok')

def get_session(request):
    name = request.session['name']
    print(name)

    return HttpResponse('测试取到session的session对应的key值放到了cookis里面')
```

## session使用详细

```python
# 获取、设置、删除Session中数据
request.session['k1']
request.session.get('k1',None)
request.session['k1'] = 123
request.session.setdefault('k1',123) # 存在则不设置
del request.session['k1']


# 所有 键、值、键值对
request.session.keys()
request.session.values()
request.session.items()
request.session.iterkeys()
request.session.itervalues()
request.session.iteritems()

# 会话session的key
request.session.session_key

# 将所有Session失效日期小于当前日期的数据删除
request.session.clear_expired()

# 检查会话session的key在数据库中是否存在
request.session.exists("session_key")

# 删除当前会话的所有Session数据(只删数据库)
request.session.delete()
　　
# 删除当前的会话数据并删除会话的Cookie（数据库和cookie都删）。
request.session.flush() 
    这用于确保前面的会话数据不可以再次被用户的浏览器访问
    例如，django.contrib.auth.logout() 函数中就会调用它。

# 设置会话Session和Cookie的超时时间
request.session.set_expiry(value)
    * 如果value是个整数，session会在些秒数后失效。
    * 如果value是个datatime或timedelta，session就会在这个时间后失效。
    * 如果value是0,用户关闭浏览器session就会失效。
    * 如果value是None,session会依赖全局session失效策略。
```

## Django中的Session配置

```python
1. 数据库Session
SESSION_ENGINE = 'django.contrib.sessions.backends.db'   # 引擎（默认）

2. 缓存Session
SESSION_ENGINE = 'django.contrib.sessions.backends.cache'  # 引擎
SESSION_CACHE_ALIAS = 'default'                            # 使用的缓存别名（默认内存缓存，也可以是memcache），此处别名依赖缓存的设置

3. 文件Session
SESSION_ENGINE = 'django.contrib.sessions.backends.file'    # 引擎
SESSION_FILE_PATH = None                                    # 缓存文件路径，如果为None，则使用tempfile模块获取一个临时地址tempfile.gettempdir() 

4. 缓存+数据库
SESSION_ENGINE = 'django.contrib.sessions.backends.cached_db'        # 引擎

5. 加密Cookie Session
SESSION_ENGINE = 'django.contrib.sessions.backends.signed_cookies'   # 引擎

其他公用设置项：
SESSION_COOKIE_NAME ＝ "sessionid"                       # Session的cookie保存在浏览器上时的key，即：sessionid＝随机字符串（默认）
SESSION_COOKIE_PATH ＝ "/"                               # Session的cookie保存的路径（默认）
SESSION_COOKIE_DOMAIN = None                             # Session的cookie保存的域名（默认）
SESSION_COOKIE_SECURE = False                            # 是否Https传输cookie（默认）
SESSION_COOKIE_HTTPONLY = True                           # 是否Session的cookie只支持http传输（默认）
SESSION_COOKIE_AGE = 1209600                             # Session的cookie失效日期（2周）（默认）
SESSION_EXPIRE_AT_BROWSER_CLOSE = False                  # 是否关闭浏览器使得Session过期（默认）
SESSION_SAVE_EVERY_REQUEST = False                       # 是否每次请求都保存Session，默认修改之后才保存（默认）
```

## 中间件session流程

```
先去浏览器找到cookie提取对应的随机字符串，然后通过随机字符串找到数据库的字典，
在视图函数就可以直接提取出来
```

