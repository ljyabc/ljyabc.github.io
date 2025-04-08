---
title: flask
tags: [python框架]
date: 2019-03-02 21:01:43
categories: python入门到放弃系列
photos:
---

## Flask框架

### STEP-1

#### 一.flask简介

****

```python
"""
1. Flask是一个基于Python开发并且依赖jinja2模板和Werkzeug  WSGI服务的一个微型框架，对于Werkzeug本质是Socket服务端，其用于接收http请求并对请求进行预处理，然后触发Flask框架，开发人员基于Flask框架提供的功能对请求进行相应的处理，并返回给用户，如果要返回给用户复杂的内容时，需要借助jinja2模板来实现对模板的处理，即：将模板和数据进行渲染，将渲染后的字符串返回给用户浏览器。

2. “微”(micro) 并不表示你需要把整个 Web 应用塞进单个 Python 文件（虽然确实可以 ），也不意味着 Flask  在功能上有所欠缺。微框架中的“微”意味着 Flask 旨在保持核心简单而易于扩展。Flask 不会替你做出太多决策——比如使用何种数据库。而那些  Flask 所选择的——比如使用何种模板引擎——则很容易替换。除此之外的一切都由可由你掌握。如此，Flask 可以与您珠联璧合。

3. 默认情况下，Flask 不包含数据库抽象层、表单验证，或是其它任何已有多种库可以胜任的功能。然而，Flask  支持用扩展来给应用添加这些功能，如同是 Flask  本身实现的一样。众多的扩展提供了数据库集成、表单验证、上传处理、各种各样的开放认证技术等功能。Flask  也许是“微小”的，但它已准备好在需求繁杂的生产环境中投入使用。
"""
```

****

#### 二.flask安装

```
pip3 install flask
```

****

#### 三.werkzeug

##### 3.1 简介

```python
"""
1. Werkzeug是一个WSGI工具包，他可以作为一个Web框架的底层库。

2. werkzeug 不是一个web服务器，也不是一个web框架，而是一个工具包，官方的介绍说是一个 WSGI 工具包，它可以作为一个 Web 框架的底层库，因为它封装好了很多 Web 框架的东西，例如 Request，Response 等等
"""
```

##### 3.2 示例

```python
from werkzeug.wrappers import Request, Response

@Request.application
def hello(request):
    return Response('Hello World!')

if __name__ == '__main__':
    from werkzeug.serving import run_simple
    run_simple('localhost', 4000, hello)
```

```python
"""
注意：
1. run_simple方法，需要传入一个可调用的对象，函数，类对象均可，会一直监听指定的端口，一旦有请求来时，会执行可调用的对象。

2. 如果是方法：就会直接加括号执行里面的方法。

3. 如果是对象：就会加括号执行，类对象加括号，会执行类中的__call__方法

4. 所以，Flask的__call__方法，是所有请求的入口
"""
```

****

#### 四.flask的快速使用

##### 4.1 首先导入Flask这个类

```python
from flask import Flask
```

##### 4.2 实例化产生一个Flask的对象

```python
app = Flask(__name__)
```

##### 4.3 设置成调试模式，自动刷新重启

```python
app.debug = True
```

##### 4.4 写视图函数并配置路由

```python
@app.route("/")
def index():
    return "hello world"
```

##### 4.5 启动flask项目

```python
if __name__ == "__main__":
    app.run()
```

****

##### 4.6 示例

```python
from flask import Flask

# 生成一个Flask的对象
app = Flask(__name__)
# 设置成调试模式，自动刷新重启
app.debug = True


@app.route('/')
def index():
    return "HELLO WORLD"


if __name__ == '__main__':
    # 项目启动最先执行的方法，会监听请求，当请求进来时，会触发Flask类中的__call__方法
    # __call__方法是所有请求来时的入口
    app.run(host="127.0.0.1", port=5001)

```

#### 五. 基于Flask写一个项目具备：登录，显示用户信息

##### 5.1 目录结构

```python
"""
D:.
│  flask_damon.py
│
└─templates
        login.html
        user_detail.html
        user_list.html
"""
```

****

##### 5.2 flask_damon.py

```python
from flask import Flask, render_template, redirect, session, request

app = Flask(__name__)
# 一旦用了session,一定要记住，要写secret_key,不然会出错
# The session is unavailable because no secret key was set.  Set the secret_key on the application to something unique and secret.
app.secret_key = "zhang"
app.debug = True
USER_LIST = {
    1: {'name': '张三', 'age': 18, 'text': '道路千万条'},
    2: {'name': '李四', 'age': 48, 'text': '安全第一条'},
    3: {'name': '王五', 'age': 68, 'text': '亲人两行泪'},
}


# methods = ["GET", "POST"] 配置能够响应的请求方式
@app.route("/login", methods=["GET", "POST"])
def login():
    """
    django三件套类比于Flask
    HttpResponse --- ""
    render --- render_template
    redirect --- redirect
    """
    if request.method == "GET":
        return render_template("login.html")
    else:
        name = request.form.get("name")
        pwd = request.form.get("pwd")
        if name == "zcg" and pwd == "123":
            # 登录成功，跳转到用户列表的页面
            # 写入session中
            session["user"] = name
            return redirect("/user_list")
        return render_template("login.html", error="用户名或密码错误")


@app.route("/user_list", methods=["GET"])
def user_list():
    user = session.get("user")
    if user:
        return render_template("user_list.html", user_list=USER_LIST)
    else:
        return redirect("/login")


@app.route("/user_detail/<int:nid>", methods=["GET"])
def user_detail(nid):
    print(nid)
    user = USER_LIST.get(nid)
    return render_template("user_detail.html", user=user)


if __name__ == '__main__':
    app.run(port=5002)

```

****

##### 5.3 login.html

```html
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>登录</title>
</head>
<body>
<form method="post">
    <p>用户名：<input type="text" name="name"></p>
    <p>密码：<input type="password" name="pwd"></p>
    <input type="submit" value="提交"><span>{{error}}</span>
</form>
</body>
</html>
```

```python
"""
注释：
1. {{error}}
用户输入错误的时候返回的错误信息
"""
```

****

##### 5.4 user_list.html

```html
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>用户列表</title>
</head>
<body>
<table border="1px">
    <thead>
    <tr>
        <th>id</th>
        <th>name</th>
        <th>详情页面</th>
    </tr>
    </thead>
    <tbody>
    {% for k,v in user_list.items() %}
    <tr>
        <td>{{k}}</td>
        <td>{{v.name}}</td>
        <td><a href="/user_detail/{{k}}">查看详情</a></td>
    </tr>
    {% endfor %}
    </tbody>
</table>
</body>
</html>
```

```python
"""
注意：Flask中的items一定要和python一样，必须加括号执行，但是django中一定不能加括号
{% for k,v in user_list.items() %}
......
{% endfor %}
"""
```

****

##### 5.5 user_detail.html

```html
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>用户详情</title>
</head>
<body>
<p>{{user.name}}</p>
<p>{{user["age"]}}</p>
<p>{{user.get("text")}}</p>
</body>
</html>
```

```python
"""
1. 字典在模板中取值可以完全按照python中字典的取值方式
方式一：
{{user.name}}
方式一：
{{user["age"]}}
方式一：
{{user.get("text")}}
"""
```

#### 六. 基于flask的登录认证装饰器

```python
from flask import Flask, render_template, redirect, session, request, url_for

app = Flask(__name__)
# 一旦用了session,一定要记住，要写secret_key,不然会出错
# The session is unavailable because no secret key was set.  Set the secret_key on the application to something unique and secret.
app.secret_key = "zhang"
app.debug = True
USER_LIST = {
    1: {'name': '张三', 'age': 18, 'text': '道路千万条'},
    2: {'name': '李四', 'age': 48, 'text': '安全第一条'},
    3: {'name': '王五', 'age': 68, 'text': '亲人两行泪'},
}


# 登录认证装饰器
def auth(func):
    from functools import wraps
    @wraps(func)
    def inner(*args, **kwargs):
        url = request.path
        print(url, "hello")
        if session.get('user'):
            ret = func(*args, **kwargs)
        else:
            return redirect("/login?next=%s" % url)
        return ret

    return inner


# methods = ["GET", "POST"] 配置能够响应的请求方式
@app.route("/login", methods=["GET", "POST"], endpoint="login")
def login():
    """
    HttpResponse --- ""
    render --- render_template
    redirect --- redirect
    """
    print(request.args.get("next"))
    origin_url = request.args.get("next")
    if request.method == "GET":
        return render_template("login.html")
    else:
        name = request.form.get("name")
        pwd = request.form.get("pwd")
        if name == "zcg" and pwd == "123":
            # 登录成功，跳转到用户列表的页面
            # 写入session中
            session["user"] = name
            return redirect("%s" % origin_url)
        return render_template("login.html", error="用户名或密码错误")


# with app.test_request_context():
#     print(url_for('login', ))
#     print(url_for('login', next='/'))


@app.route("/user_list", methods=["GET"], endpoint="user_list")
@auth
def user_list():
    url = url_for('user_detail', nid=1)
    print(url)
    return render_template("user_list.html", user_list=USER_LIST, url=url)


@app.route("/user_detail/<int:nid>", methods=["GET"], endpoint="user_detail")
@auth
def user_detail(nid):
    print(nid)
    user = USER_LIST.get(nid)
    return render_template("user_detail.html", user=user)


# with app.test_request_context():
#     print(url_for('login', ))
#     print(url_for('login', next='/'))

if __name__ == '__main__':
    app.run(port=5002)

```

```python
"""
注意：
1. 视图重命名问题

@app.route本质执行了decorator=app.route() --->decorator(func)---->add_url_rule
--->_endpoint_from_view_func

如果不指定endpoint，则使用函数名decorator作为endpoint的值，就会导致冲突，抛出异常

解决方式一：将装饰器中内层函数通过wraps伪装成和原视图函数名字一样的新的视图函数
from functools import wraps
@wraps(func)

解决方式二：给视图函数指定endpoint
@app.route("/user_list", methods=["GET"], endpoint="user_list")

2. 视图叠加自定义的装饰器
@app.route("/user_list", methods=["GET"], endpoint="user_list")
@auth
...
需要包在app.route内

如果叠加多个装饰器：view_func.__name__ = 自定义装饰器的内层函数名，所以需要做处理，同视图重命名问题
"""


def add_url_rule(self, rule, endpoint=None, view_func=None,
                 provide_automatic_options=None, **options)

	.....
    
	if view_func is not None:
        # self.view_functions是一个字典，如果里面有值，就取出值，和现有的视图名字进行比较
        # 从字典中取出endpoint对应的视图函数的内存地址
        old_func = self.view_functions.get(endpoint)
        
        # 如果取出的视图函数存在，且取出的视图的内存地址和当前的视图的内存地址不一样
        # 则表示当前的视图函数的endpoint已经和一个已存在的视图的endpoint重名，抛出异常
        if old_func is not None and old_func != view_func:
            raise AssertionError('View function mapping is overwriting an '
                                 'existing endpoint function: %s' % endpoint)
            
        # 其他情况，则在view_functions字典中新增一个endpoint，以当前被装饰的视图函数的endpoint作为key
        # 以当前视图函数的被装饰后的函数的内存地址作为value
        self.view_functions[endpoint] = view_func

```

****

### STEP-2

#### 一. Flask的配置文件

##### 1.1 默认的配置文件是一个flask.config.Config对象（继承字典)

```python
"""
'ENV': None,
'DEBUG': None,
'TESTING': False,
'PROPAGATE_EXCEPTIONS': None,
'PRESERVE_CONTEXT_ON_EXCEPTION': None,
'SECRET_KEY': None,
'PERMANENT_SESSION_LIFETIME': timedelta(days=31),
'USE_X_SENDFILE': False,
'SERVER_NAME': None,
'APPLICATION_ROOT': '/',
'SESSION_COOKIE_NAME': 'session',
'SESSION_COOKIE_DOMAIN': None,
'SESSION_COOKIE_PATH': None,
'SESSION_COOKIE_HTTPONLY': True,
'SESSION_COOKIE_SECURE': False,
'SESSION_COOKIE_SAMESITE': None,
'SESSION_REFRESH_EACH_REQUEST': True,
'MAX_CONTENT_LENGTH': None,
'SEND_FILE_MAX_AGE_DEFAULT': timedelta(hours=12),
'TRAP_BAD_REQUEST_ERRORS': None,
'TRAP_HTTP_EXCEPTIONS': False,
'EXPLAIN_TEMPLATE_LOADING': False,
'PREFERRED_URL_SCHEME': 'http',
'JSON_AS_ASCII': True,
'JSON_SORT_KEYS': True,
'JSONIFY_PRETTYPRINT_REGULAR': False,
'JSONIFY_MIMETYPE': 'application/json',
'TEMPLATES_AUTO_RELOAD': None,
'MAX_COOKIE_SIZE': 4093,
"""
```

| 源码                                             | 作用                                                         |
| ------------------------------------------------ | ------------------------------------------------------------ |
| 'DEBUG': None                                    | 启用/禁止调试模式                                            |
| 'TESTING': False                                 | 启用/禁止测试模式                                            |
| 'PROPAGATE_EXCEPTIONS': None                     | 显式地启用或者禁止异常的传播。如果没有设置或显式设置为None，当TESTING或DEBUG为真时，隐式为真 |
| 'PRESERVE_CONTEXT_ON_EXCEPTION': None            | 默认情况下，如果应用工作在调试模式， 请求上下文不会在异常时出栈来允许调试器内省。 这可以通过这个键来禁用。 你同样可以用这个设定来强制启用它， 即使没有调试执行，这对调试生产应用很有用 (但风险也很大) |
| 'SECRET_KEY': None                               | 密钥，使用session时需要使用                                  |
| 'PERMANENT_SESSION_LIFETIME': timedelta(days=31) | 一个持久化的会话的生存时间，作为一个[`datetime.timedelta`](http://docs.python.org/dev/library/datetime.html#datetime.timedelta) 对象。从 Flask0.8 开始 也可以用一个整数来表示秒。 |
| 'USE_X_SENDFILE': False                          | 启用/禁止x-sendfile                                          |
| 'SERVER_NAME': None                              | 服务器的名称以及端口，需要它为了支持子域名 (如: `'myapp.dev:5000'`)。注意 localhost 是 不支持子域名的因此设置成 “localhost” 是无意义的。 设置 `SERVER_NAME` 默认会允许在没有请求上下文 而仅有应用上下文时生成 URL。 |
| 'APPLICATION_ROOT': '/'                          | 如果应用不占用完整的域名或子域名， 这个选项可以被设置为应用所在的路径。 这个路径也会用于会话 cookie 的路径值。 如果直接使用域名，则留作 `None`。 |
| 'SESSION_COOKIE_NAME': 'session'                 | 会话cookie的名称                                             |
| 'SESSION_COOKIE_DOMAIN': None                    | 会话cookie的域，如果没有设置的话，cookie将会对SERVER_NAME所有的子域有效。 |
| 'SESSION_COOKIE_PATH': None                      | 会话cookie的路径。如果没有设置或者没有为'/'设置，cookie将会对所有的APPLICATION_ROOT有效. |
| 'SESSION_COOKIE_HTTPONLY': True                  | 控制cookie是否应被设置httponly的标志，默认为True。           |
| 'SESSION_COOKIE_SECURE': False                   | 控制cookie是否应被设置安全标志，默认为False。                |
| 'MAX_CONTENT_LENGTH': None                       | 如果设置为字节数，Flask会拒绝内容长度大于此值的请求进入，并返回一个413的状态码。 |
| 'SEND_FILE_MAX_AGE_DEFAULT': timedelta(hours=12) | 默认缓存控制的最大期限，以秒计， 在 [`send_static_file()`](http://www.pythondoc.com/flask/api.html#flask.Flask.send_static_file) (默认的静态文件处理器)和 [`send_file()`](http://www.pythondoc.com/flask/api.html#flask.send_file) 中使用。 对于单个文件，覆盖这个值，使用 [`get_send_file_max_age()`](http://www.pythondoc.com/flask/api.html#flask.Flask.get_send_file_max_age) 勾住[`Flask`](http://www.pythondoc.com/flask/api.html#flask.Flask) 或者 [`Blueprint`](http://www.pythondoc.com/flask/api.html#flask.Blueprint)。 默认为 43200（12小时）。 |
| 'TRAP_BAD_REQUEST_ERRORS': None                  | Werkzeug 处理请求中的特定数据的内部数据结构会 抛出同样也是“错误的请求”异常的特殊的 key errors 。 同样地，为了保持一致，许多操作可以 显式地抛出 BadRequest 异常。因为在调试中， 你希望准确地找出异常的原因， 这个设置用于在这些情形下调试。 如果这个值被设置为 `True` ， 你只会得到常规的回溯。 |
| 'TRAP_HTTP_EXCEPTIONS': False                    | 如果这个值被设置为 `True` ， Flask 不会执行 HTTP 异常的错误处理， 而是像对待其它异常一样，通过异常栈让它冒泡。 这对于需要找出 HTTP 异常源头的可怕调试情形是有用的。 |
| 'PREFERRED_URL_SCHEME': 'http'                   | url模式用于url生成。如果没有设置url模式，默认将为http。      |
| 'JSON_AS_ASCII': True                            | 默认情况下 Flask 序列化对象成 ascii 编码的 JSON。 如果不对该配置项就行设置的话，Flask 将不会编码成 ASCII 保持字符串原样，并且返回 unicode 字符串。`jsonfiy` 会自动按照 `utf-8` 进行编码并且传输。 |
| 'JSON_SORT_KEYS': True                           | 默认情况下 Flask 将会依键值顺序的方式序列化 JSON。 这样做是为了确保字典哈希种子的独立性，返回值将会一致不会造成 额外的 HTTP 缓存。通过改变这个变量可以重载默认行为。 这是不推荐也许会带来缓存消耗的性能问题。 |
| 'JSONIFY_PRETTYPRINT_REGULAR': False             | 如果设置成 `True` (默认下)，jsonify 响应将会完美地打印。     |

****

##### 1.2 配置文件的方式一：通过config对象字典特性

```python
app.config["DEBUG"] = True

ps:
由于Config对象本质上是字典，所以还可以使用app.config.update(...)
```

****

##### 1.3 配置文件方式二：通过py文件配置

```python
app.config.from_pyfile("python文件名称")

eg：
settings.py
DEBUG = True
```

****

##### 1.4 配置文件方式三：通过环境变量配置

```python
app.config.from_ecvvar("环境变量名称")

eg：
app.config.from_pyfile(os.environ["YOURAPPLICATION_SETTINGS"])

环境变量的值为python文件名称，内部调用from_pyfile方法
```

****

##### 1.5 配置文件方式四：通过json文件

```python
app.config.from_json("json文件名称")

json文件名称，必须是json格式，因为内部会执行json.loads
```

****

##### 1.6 配置文件方式五：通过字典映射

```python
app.config.from_mapping({"DEBUG":True})
```

****

##### 1.7 配置文件方式六：通过对象的方式

```python
app.config.from_object("python类或类的路径")

app.config.from_object("pro_flask.settings.TestingConfig")

内部会调用importlib模块
```

###### 1.7.1 实例

```python
# settings.py文件中

class Config(object):
    DEBUG = True
    TESTING = False
    DATABASE_URL = "sqlite://:memory:"
    
class ProductionConfig(Config):
    DATABASE_URL = "mysql://user@localhost/foo"
    
class DevelopmentConfig(Config):
    DEBUG = True
    
class TestingConfig(Config):
    TESTING = True
```

```python
"""
好处：
在项目测试阶段，使用测试阶段对应的类对象
在项目上线阶段，使用上线阶段对应的类对象
只需要修改from_object里面的类对象即可，不需要修改配置文件中的配置
"""
```

****

##### 1.8 配置文件的路径问题

```python

"""
1. 从sys.path中已经存在的路径开始写

2. settings.py文件默认路径要放在程序的root_path目录，如果instance_relative_config为True，则就是instance_path目录（Flask对象init方法的参数）

3.例如
instance_path=路径,
instance_relative_config=True,
以后settings.py文件放在这个路径下

"""
```

****

#### 二. Flask的路由系统

##### 2.1 路由的典型写法

```python
@app.route('/index',methods=['GET'],endpoint='index')
```

##### 2.2 默认的内置转换器

```python

#源码所在 from werkzeug.routing import BaseConverter
DEFAULT_CONVERTERS = {
    'default':          UnicodeConverter,
    'string':           UnicodeConverter,
    'any':              AnyConverter,
    'path':             PathConverter,
    'int':              IntegerConverter,
    'float':            FloatConverter,
    'uuid':             UUIDConverter,
}
```

##### 2.3 自定义正则转换器

###### 2.3.1 写一个类继承BaseConverter

```python
# 自定义转换器，支持正则
# 1. 写一个类继承BaseCoverter
# 2. 注册：app.url_map.converters['regex'] = RegexConverter
# 3 使用：@app.route('/index/<regex("\d+"):nid>')  正则表达式会当作第二个参数传递到类中

from flask import Flask
from werkzeug.routing import BaseConverter

app = Flask(__name__)
app.debug = True

class RegexConverter(BaseConverter):
    """
    自定义URL匹配正则表达式
    """

    # regex正则表达式
    def __init__(self, map, regex):
        super(RegexConverter, self).__init__(map)
        self.regex = regex

    def to_python(self, value):
        """
        路由匹配时，匹配成功后传递给视图函数中参数的值
        """
        return value

    def to_url(self, value):
        """
        使用url_for反向生成URL时，传递的参数经过该方法处理，返回的值用于生成URL中的参数
        """
        val = super(RegexConverter, self).to_url(value)
        return val


# 添加到flask的转换器中
app.url_map.converters['regex'] = RegexConverter


@app.route("/index/<regex('\d+'):nid>")
def index(nid):
    print(nid)
    return "index"


if __name__ == '__main__':
    app.run(port=5100)

```

###### 2.3.2 注册转换器

```python
app.url_map.converters["regex"] = RegexConverter
```

###### 2.3.3 使用转换器

```python
@app.route('/index/<regex("\d+"):nid>')
def index(nid):
    print(url_for('index', nid='888'))
    return 'Index'

if __name__ == '__main__':
    app.run()
```

###### 2.3.4 注意

```
2.3.2和2.3.3中的regex名字必须一致
```

****

##### 2.4 路由的本质

###### 2.4.0 执行流程

```python
"""
--- app.route()装饰器

　　获取URL, 视图对象，其他options方法，并调用app实例的add_url_rule方法

--- add_url_rule方法:

    1. 获取app.route的methods关键字参数，视图模块里定义的methods参数等Http 请求方法这里视图可以是一个函数，也可以是一个python模块
    
    2. 把URL，视图对象，Http请求方法，绑定到一个Rule实例（app实例的），通过app实例的url_rule_class方法。

　　　　Rule的__init__方法的其他参数来自app.route的关键字传参，可以控制一些URL的匹配规则

　　　　build_only参数可以让URL不绑定任何视图，实现static文件夹等。

---- url_map.add

　　把Rule实例和app实例保存的map实例绑定
　　
"""
```



###### 2.4.1 例子代码

```python
@app.route("/user_list", methods=["GET"], endpoint="user_list")
@auth
def user_list():
    url = url_for('user_detail', nid=1)
    print(url)
    return render_template("user_list.html", user_list=USER_LIST, url=url)
```

###### 2.4.2 源码分析：route

> **route方法的分析**

```python

def route(self, rule, **options):
	# self是Flask这个类对象app
    # rule是传入的路由的路径
    # options是一个字典，接受methods，endpoint等其它参数
    def decorator(f):
        endpoint = options.pop('endpoint', None)
        # 本质是执行了add_url_rule
        # 第一个参数是一个路径
        # 第二个参数是视图函数的别名
        # 第三个参数是视图函数的内存地址
        self.add_url_rule(rule, endpoint, f, **options)
        return f

    return decorator
```

###### 2.4.3 源码分析：add_url_rule
> **add_url_rule方法的分析**

```python
def add_url_rule(self, rule, endpoint=None, view_func=None,
                 provide_automatic_options=None, **options):
    # 如果没有指定endpoint，则会执行_endpoint_from_view_func方法，该方法的就是将被装饰的函数的名字赋给endpoint
    if endpoint is None:
        endpoint = _endpoint_from_view_func(view_func)
    # 如果指定endpoint，则会直接使用传入的endpoint
    # 将endpoint的值赋给options这个字典
    options['endpoint'] = endpoint
    # 从options中取出请求的methods
    methods = options.pop('methods', None)

    # if the methods are not given and the view_func object knows its
    # methods we can use that instead.  If neither exists, we go with
    # a tuple of only ``GET`` as default.
    # 如果methods是空，CBV会传入view函数，因为view函数进过as_view，将其类属性赋给了view
    # 所以如果是CBV的情况下，可以从view中取出methods的属性
    # 如果传入的view_func没有methods属性，则会使用methods=('GET',)
    if methods is None:
        methods = getattr(view_func, 'methods', None) or ('GET',)
    # 如果methods是字符串的类型，直接抛出异常
    if isinstance(methods, string_types):
        raise TypeError('Allowed methods have to be iterables of strings, '
                        'for example: @app.route(..., methods=["POST"])')
    # 循环methods，将methods中的元素，大写后，放入集合中
    methods = set(item.upper() for item in methods)

    # Methods that should always be added
    # 从视图函数中取required_methods属性，如果没有去的取到，则生成一个空的集合
    required_methods = set(getattr(view_func, 'required_methods', ()))

    # starting with Flask 0.8 the view_func object can disable and
    # force-enable the automatic options handling.
    # 自动选项管理
    # 如果provide_automatic_options属性时None
    if provide_automatic_options is None:
        # 会先尝试从视图函数中取出provide_automatic_options，如果取到就用取到的结果，没取到就为None
        provide_automatic_options = getattr(view_func,
                                            'provide_automtic_options', None)

    if provide_automatic_options is None:
        # 如果OPTIONS不在methods列表中，开启自动选项管理，并将OPTIONS添加到required_methods的集合中
        if 'OPTIONS' not in methods:
            provide_automatic_options = True
            required_methods.add('OPTIONS')
        # 如果OPTIONS在methods列表中，将关闭自动选项管理
        else:
            provide_automatic_options = False

    # Add the required methods now.
    # 将methods和required_methods进行并集处理，都添加到methods中
    # methods = methods | required_methods
    methods |= required_methods

    # self.url_rule_class的是是Rule这个类的内存地址，加括号执行产生一个rule的对象
    rule = self.url_rule_class(rule, methods=methods, **options)
    # 为rule这个对象添加一个属性provide_automatic_options
    rule.provide_automatic_options = provide_automatic_options
    # self.url_map=Map() 是一个Map实例，Map实例调用其add方法，将rule对象传入，进行绑定
    self.url_map.add(rule)
    if view_func is not None:
        # self.view_functions是一个字典，如果里面有值，就取出值，和现有的视图名字进行比较
        # 从字典中取出endpoint对应的视图函数的内存地址
        old_func = self.view_functions.get(endpoint)
        # 如果取出的视图函数存在，且取出的视图的内存地址和当前的视图的内存地址不一样
        # 则表示当前的视图函数的endpoint已经和一个已存在的视图的endpoint重名，抛出异常
        if old_func is not None and old_func != view_func:
            raise AssertionError('View function mapping is overwriting an '
                                 'existing endpoint function: %s' % endpoint)
        # 其他情况，则在view_functions字典中新增一个endpoint，以当前被装饰的视图函数的endpoint作为key
        # 以当前视图函数的被装饰后的函数的内存地址作为value
        self.view_functions[endpoint] = view_func
```
###### 2.4.4 源码分析：_endpoint_from_view_func
> **_endpoint_from_view_func**

```python
def _endpoint_from_view_func(view_func):
    
    assert view_func is not None, 'expected view func if endpoint ' \
                                  'is not provided.'
    # 返回传入的视图函数的名字
    return view_func.__name__
```

###### 2.4.5 源码分析：url_rule_class

```python
"""
1. 本质就是Rule这个类实例化，产生一个rule对象

2. flask里把路由相关的：URL，host，适用的HTTP请求方法，endpoint视图都保存到了Rule这个类的实例中
"""
```

```python
class Rule(RuleFactory):
    
    def __init__(self, string, defaults=None, subdomain=None, methods=None,
                 build_only=False, endpoint=None, strict_slashes=None,
                 redirect_to=None, alias=False, host=None):
        # 首先判断app.route传入的URL不是一个以'/'开头的字符串
        if not string.startswith('/'):
            # 抛出异常
            raise ValueError('urls must start with a leading slash')
        # 将app.route传入的URL赋值给rule这个对象
        self.rule = string
        # 记录url是否没有以/结尾
        self.is_leaf = not string.endswith('/')

        self.map = None
        self.strict_slashes = strict_slashes
        self.subdomain = subdomain
        self.host = host
        self.defaults = defaults
        self.build_only = build_only
        self.alias = alias
        if methods is None:
            self.methods = None
        else:
            if isinstance(methods, str):
                raise TypeError('param `methods` should be `Iterable[str]`, not `str`')
            self.methods = set([x.upper() for x in methods])
            # 如果methods里面没有head方法，有get方法，则会将head方法添加到methods中
            if 'HEAD' not in self.methods and 'GET' in self.methods:
                self.methods.add('HEAD')
        # 将endpoint赋给rule对象
        self.endpoint = endpoint
        self.redirect_to = redirect_to

        if defaults:
            self.arguments = set(map(str, defaults))
        else:
            self.arguments = set()
        self._trace = self._converters = self._regex = self._argument_weights = None
```

###### 2.4.6 源码分析：self.url_map.add(rule)

```python
"""
1. 这里url_map是Map类的一个实例，是在app实例化的时候绑定到app实例的


"""
```

```python
def add(self, rulefactory):
    """
	将rule实例或RuleFactory实例添加到Map实例并绑定它。要求rule实例未绑定到其他Map实例
    :param rulefactory: a :class:`Rule` or :class:`RuleFactory`
    """
    
    # rulefactory其实就是rule对象，调用rule对象的get_rules方法（本质是一个生成器），并将map这个对象传入
    for rule in rulefactory.get_rules(self):
        # rule对象调用bind方法，并将map对象传入
        # 这里就控制了一个rule实例只能跟一个map实例进行绑定
        rule.bind(self)
        # 把rule实例append到这个map实例的self._rules列表中
        self._rules.append(rule)
        # 这个map实例的_rules_by_endpoint（是一个控制点）属性的会添加这样一个键值对：rule.endpoint: [rule]
        # 也就是视图对象：[rule实例]
        self._rules_by_endpoint.setdefault(rule.endpoint, []).append(rule)
    self._remap = True
```

```python
def get_rules(self, map):
    # 直接返回rule实例
    yield self
```

```python
def bind(self, map, rebind=False):
    """Bind the url to a map and create a regular expression based on
    the information from the rule itself and the defaults from the map.

    :internal:
    """
    # 如果rule实例自身的map不是None，且
    # 就会抛出异常
    if self.map is not None and not rebind:
        raise RuntimeError('url rule %r already bound to map %r' %
                           (self, self.map))
    # 如果rule实例自身的map是None，就将map实例绑定给rule实例的map属性
    self.map = map
    if self.strict_slashes is None:
        # 将map实例的strict_slashes属性值赋给rule实例的strict_slashes
        self.strict_slashes = map.strict_slashes
    if self.subdomain is None:
        self.subdomain = map.default_subdomain
    # 调用rule实例的compile方法，就要是编译正则表达式并存储它
    self.compile()
```

###### 2.4.7 装饰器执行流程

```python
"""
1. 第一步：返回内层函数内存地址
decorator = @app.route("/user_list", methods=["GET"], endpoint="user_list")

2. 第二步：将内层函数的内存地址加括号，并将视图函数的内存地址传入
decorator(user_list)

"""
```

###### 2.4.8 例子代码改写

```python
def user_list():
    url = url_for('user_detail', nid=1)
    print(url)
    return render_template("user_list.html", user_list=USER_LIST, url=url)

app.add_url_rule("/user_list","user_list",user_list)
```

****

##### 2.5 CBV源码解析

###### 2.5.1 例子代码

```python
from flask import Flask, views, session, redirect

app = Flask(__name__)
app.debug = True

from functools import wraps


def login_auth(func):
    @wraps(func)
    def inner(*args, **kwargs):
        user = session.get('user')
        if user:
            res = func(*args, **kwargs)
            return res
        else:
            return redirect('http://www.baidu.com')

    return inner


class CBVTest(views.MethodView):
    # 可写可不写
    methods = ["GET", "POST"]

    # decorators = [login_auth, ]

    # 方式一
    def get(self):
        return "cbv_get"

    # 方式二
    def posttest(self):
        return "cbv_post"

    post = posttest


app.add_url_rule("/cbvtest", view_func=CBVTest.as_view(name="cbvtest"))
# name 就是endpoint

if __name__ == '__main__':
    app.run(port=8000)

```

###### 2.5.1 as_view

```python
"""
1. 由于CBVTest没有重写as_view方法，所以肯定是在其基类（View）里面实现了这个方法

2. 基类通过as_view方法最终返回一个view函数的内存地址，同时在as_view方法里面将传入name的值赋给了view的__name__属性，将类的__doc__属性赋值给view.__doc__,将类的__module__属性赋给view的__module__,
将类中的methods属性赋给了view

3. 将view函数加括号执行
"""
```

```python
def as_view(cls, name, *class_args, **class_kwargs):
    """
    name: 传入的endpoint，就是CBV的别名
    class_args: 接受传入的位置参数
    class_kwargs：接受传入的关键字参数
    """
    def view(*args, **kwargs):
        # 先实例产生一个自定义类视图的对象，本例中就是CBVTest对象
        self = view.view_class(*class_args, **class_kwargs)
        # 调用对象的dispatch_request进行分发，本质先调用MethodView类中的dispatch_request
        return self.dispatch_request(*args, **kwargs)
	
    # 如果类中定义了decorators，先循环decorators用装饰器将view函数进行包裹
    if cls.decorators:
        view.__name__ = name
        view.__module__ = cls.__module__
        for decorator in cls.decorators:
            view = decorator(view)

	# 主要将视图类属性附加给view
    view.view_class = cls
    view.__name__ = name
    view.__doc__ = cls.__doc__
    view.__module__ = cls.__module__
    view.methods = cls.methods
    # 将是否开启自动选项处理的信息赋给view
    view.provide_automatic_options = cls.provide_automatic_options
    return view
```

###### 2.5.2 dispatch_request

```python
"""
1. 使用的是自定义类的基类MethodView类中的dispatch_request方法

2. 该方法主要是做请求方式与视图函数映射。
"""
```

```python
def dispatch_request(self, *args, **kwargs):
    # 其本质就是从视图类中取出对应请求的视图方法
    # 先从自定义类对象中获取请求的方式，如果请求的方式，对象中没有，则meth值为None
    meth = getattr(self, request.method.lower(), None)

    # If the request method is HEAD and we don't have a handler for it
    # retry with GET.
    # 如果meth值为None，且请求方式为HEAD
    # 尝试去从对象中取出get的属性
    if meth is None and request.method == 'HEAD':
        meth = getattr(self, 'get', None)

    # 断言meth的值不是None，如果没有，则抛出异常
    assert meth is not None, 'Unimplemented method %r' % request.method
    # 返回meth()，就是调用视图类中对应的视图方法
    return meth(*args, **kwargs)
```

###### 2.5.3 MethodViewType元类的作用

```python
"""
主要作用：
保证给自定义的视图类，添加methods属性，只要视图类写了，视图函数，且视图函数的名字在
['get', 'post', 'head', 'options','delete', 'put', 'trace', 'patch'] 
就会通过该类给methods添加大写的以上方式
"""
```

```python
class MethodViewType(type):

    def __init__(cls, name, bases, d):
        super(MethodViewType, cls).__init__(name, bases, d)
        
        # 如果视图类中没有methods属性，则新建一个集合methods
        if 'methods' not in d:
            methods = set()
            
            # http_method_funcs ['get', 'post', 'head', 'options','delete', 'put', 'trace', 'patch']                              
            for key in http_method_funcs:
                # 判断类中是否有以上请求方式，如果有，methods里面添加这个请求方式
                if hasattr(cls, key):
                    methods.add(key.upper())

            if methods:
                # 将新的methods重新赋给类添加属性methods
                cls.methods = methods
```

****

##### 2.6 add_url_rule参数

###### 2.6.1 rule

```
URL规则,如"/"
```

###### 2.6.2 view_func

```
视图函数名称
```

###### 2.6.3 defaults

```
defaults = None, 默认值, 当URL中无参数，函数需要参数时，使用defaults = {'k': 'v'}为函数提供参数
```

###### 2.6.4 endpoint

```
endpoint = None, 名称，用于反向生成URL，即： url_for('名称')
```

###### 2.6.5 methods

```
methods = None, 允许的请求方式，如：["GET", "POST"]
```

###### 2.6.6 strict_slashes

```python
对URL最后的 / 符号是否严格要求
'''
@app.route('/index', strict_slashes=False)
#访问http://www.xx.com/index/ 或http://www.xx.com/index均可

@app.route('/index', strict_slashes=True)
#仅访问http://www.xx.com/index
'''
```

###### 2.6.7 redirect_to

```python
重定向到指定地址

'''
@app.route('/index/<int:nid>', redirect_to='/home/<nid>')
'''
```

###### 2.6.8 subdomain

```python
子域名访问
subdomain = None, 
'''
#C:\Windows\System32\drivers\etc\hosts
127.0.0.1       www.liuqingzheng.com
127.0.0.1       admin.liuqingzheng.com
127.0.0.1       buy.liuqingzheng.com

from flask import Flask, views, url_for

app = Flask(import_name=__name__)

app.config['SERVER_NAME'] = 'liuqingzheng.com:5000'

@app.route("/", subdomain="admin")
def static_index():
    """Flask supports static subdomains
    This is available at static.your-domain.tld"""
    return "static.your-domain.tld"
    
#可以传入任意的字符串，如传入的字符串为aa，显示为 aa.liuqingzheng.com
@app.route("/dynamic", subdomain="<username>")
def username_index(username):
    """Dynamic subdomains are also supported
    Try going to user1.your-domain.tld/dynamic"""
    return username + ".your-domain.tld"
    
if __name__ == '__main__':
	app.run()

访问：
http://www.liuqingzheng.com:5000/dynamic
http://admin.liuqingzheng.com:5000/dynamic
http://buy.liuqingzheng.com:5000/dynamic
'''
```

****

#### 三.Flask的模板语言(依赖于jinjia2)

##### 3.1 和django模板的不同

```
比django中多可以加括号，执行函数，传参数
```

##### 3.2 实例

###### 3.2.1 视图

```python
from flask import Flask, render_template, Markup, jsonify, make_response

app = Flask(__name__)
app.debug = True


def func1(arg):
    return Markup("<input type='text' value='%s' />" % (arg,))


def func2(arg):
    return "<input type='text' value='%s' />" % (arg,)


@app.route('/')
def index():
    return render_template('index.html', f1=func1, f2=func2)


if __name__ == '__main__':
    app.run(port=8001)

```

###### 3.2.2 模板

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
{{f1}}
{{f1("zhang")}}
{{f2("zhang")}}
{{f2("zhang")|safe}}
</body>
</html>
```

##### 3.3 flask处理了xss攻击,如果想显示原生html

```
safe:模板中
Markup:后台处理
```

##### 3.4 注意

```
1.Markup等价django的mark_safe

2.extends,include一模一样
```
##### 3.5 标签：template_global

###### 3.5.1 使用

```
通过template_global装饰后，可以直接在模板html文件中通过{{标签名(参数,参数)}}使用
eg:
{{add(1,2)}}
```

```python
@app.template_global()
def add(a,b):
    return a+b
```

###### 3.5.2 实例

> html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
{{ add(1,2) }}
</body>
</html>
```

> view

```python
from flask import Flask, render_template

app = Flask(__name__)
app.debug = True


@app.template_global()
def add(a, b):
    return a + b


@app.route("/index", methods=["GET"], endpoint="index")
def index():
    return render_template("index.html")


if __name__ == '__main__':
    app.run(port=5033)

```

##### 3.6 过滤器：template_filter

###### 3.6.1 使用

```
通过template_filter装饰后，可以直接在模板html文件中通过{{ 参数1 | 标签名(参数2,参数3)}}使用
eg：
{{ 1|add(2,3,4) }}

注意：
django中过滤器最多传2个参数，但是flask可以传任意个参数
```

###### 3.6.2 实例

> html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
{{ 1|add(2,3) }}
</body>
</html>
```

> view

```python
from flask import Flask, render_template

app = Flask(__name__)
app.debug = True


@app.template_filter()
def add(a, b, c, d):
    return a + b + c + d


@app.route("/index", methods=["GET"], endpoint="index")
def index():
    return render_template("index.html")


if __name__ == '__main__':
    app.run(port=5033)

```



****

#### 四. Flask的请求与响应

##### 4.1 request

```python
# 请求相关信息
# request.method         请求方式
# request.args           GET传入的数据
# request.form           接受非json格式外的post传入的数据
# request.json           接受json的数据格式
# request.values         接受所有的非json传入的数据
# request.cookies        传入的cookie
# request.headers        请求头
# request.path           传入的路径，不包含get方式传入的数据
# request.full_path      传入的完全路径，包含get方式传入的数据
# request.script_root    
# request.url            传入的包含主机和端口的完整路径               
# request.base_url       传入包含主机和端口的路径，不包含get方式传入的数据
# request.url_root       传入的包含主机和端口的根路径
# request.host_url       传入包含主机和端口的主机路径
# request.host           传入的主机地址
# request.files          传入的文件
# obj = request.files['the_file_name']
# obj.save('/var/www/uploads/' + secure_filename(f.filename))
```

```python
"""
    请求方式：post
    127.0.0.1:5000/login.html?name=zcg

    传入数据为：json
    {
        "sex":"male",
        "age":18
    }

    传入数据为：formdata
    ('name', 'wangjinshu')
    :return:
"""
# 请求相关信息http://127.0.0.1:5000/login.html?name=zcg
print(request.method)
# GET/POST
print(request.args)
# ImmutableMultiDict([('name', 'zcg')])
print(request.form)
# ImmutableMultiDict([('name', 'wangjinshu')])
print(request.json)  # 取出ajax传入的json的数据
# {'sex': 'male', 'age': 18}
print(request.values)
# CombinedMultiDict([ImmutableMultiDict([('name', 'zcg')]), ImmutableMultiDict([('name', 'wangjinshu')])])
print(request.cookies)
# {}
print(request.headers)
"""
    Host: 127.0.0.1:5000
    Connection: keep-alive
    Upgrade-Insecure-Requests: 1
    User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36
    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8
    Accept-Encoding: gzip, deflate, br
    Accept-Language: zh-CN,zh;q=0.9
"""

print(request.path)
# /login.html
print(request.full_path)
# /login.html?name=zcg
print(request.script_root, "1")
print(request.url, "2")
# http://127.0.0.1:5000/login.html?name=zcg
print(request.base_url, "3")
# http://127.0.0.1:5000/login.html
print(request.url_root, "4")
# http://127.0.0.1:5000/
print(request.host_url, "5")
# http://127.0.0.1:5000/
print(request.host, "6")
# 127.0.0.1:5000
print(request.files, "7")
# ImmutableMultiDict([])
```

##### 4.2 response

```python
# return "字符串"
# return render_template('html模板路径',**{})
# return redirect('/index.html')
# return jsonify({'k1':'v1'})
```



##### 4.3 往响应头里面加东西

```python
# from flask import make_response
# response = make_response(render_template('index.html'))
# response是flask.wrappers.Response类型
# response.delete_cookie('key')
# response.set_cookie('key', 'value')
# response.headers['X-Something'] = 'A value'
# return response
```

##### 4.4 参考实例

```python
from flask import Flask, jsonify
from flask import request
from flask import render_template
from flask import redirect
from flask import make_response

app = Flask(__name__)
app.debug = True


@app.route('/login.html', methods=['GET', "POST"])
def login():
    """
    请求方式：post
    127.0.0.1:5000/login.html?name=zcg

    传入数据为：json
    {
        "sex":"male",
        "age":18
    }

    传入数据为：formdata
    ('name', 'wangjinshu')
    :return:
    """
    # 请求相关信息http://127.0.0.1:5000/login.html?name=zcg
    print(request.method)
    # GET
    print(request.args)
    # ImmutableMultiDict([('name', 'zcg')])
    print(request.form)
    # ImmutableMultiDict([('name', 'wangjinshu')])
    print(request.json)  # 取出ajax传入的json的数据
    # {'sex': 'male', 'age': 18}
    print(request.values)
    # CombinedMultiDict([ImmutableMultiDict([('name', 'zcg')]), ImmutableMultiDict([('name', 'wangjinshu')])])
    print(request.cookies)
    # {}
    print(request.headers)
    """
    Host: 127.0.0.1:5000
    Connection: keep-alive
    Upgrade-Insecure-Requests: 1
    User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36
    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8
    Accept-Encoding: gzip, deflate, br
    Accept-Language: zh-CN,zh;q=0.9
    """

    print(request.path)
    # /login.html
    print(request.full_path)
    # /login.html?name=zcg
    print(request.script_root, "1")
    print(request.url, "2")
    # http://127.0.0.1:5000/login.html?name=zcg
    print(request.base_url, "3")
    # http://127.0.0.1:5000/login.html
    print(request.url_root, "4")
    # http://127.0.0.1:5000/
    print(request.host_url, "5")
    # http://127.0.0.1:5000/
    print(request.host, "6")
    # 127.0.0.1:5000
    print(request.files, "7")
    # ImmutableMultiDict([])

    # obj = request.files['the_file_name']
    # obj.save('/var/www/uploads/' + secure_filename(f.filename))

    # 响应相关信息
    # return "字符串"
    # return render_template('html模板路径',**{})
    # return redirect('/index.html')
    # return jsonify({'k1': 'v1'})

    response = make_response(jsonify({'k1': 'v1'}))
    # response是flask.wrappers.Response类型
    # response.delete_cookie('key')
    response.set_cookie('key', 'value')
    response.headers['X-Something'] = 'A value'
    return response
    # return "内容"


if __name__ == '__main__':
    app.run()

```

****

#### 五.session

##### 5.1 使用:一定要加盐

```
设置值:session['user']='lqz'
删除值:
    session.pop('username', None)
    del session['user']
取值:session['user']
```

##### 5.2 实例

```python
from flask import Flask, render_template, redirect, session, request, url_for
.....
app.secret_key = "zhang"

session['username'] ＝ 'xxx'

session['username']
session.get("username")

session.pop('username', None)
del session['username']
```

##### 5.3 session源码分析之wsgi_app

###### 1. 流程分析

```python

wsgi_app
请求过来的时候，flask 会根据 cookie 信息创建出 session 变量（如果 cookie 不存在，这个变量有可能为空），保存在该请求的上下文中

视图函数可以获取 session 中的信息，实现自己的逻辑处理

flask 会在发送 response 的时候，根据 session 的值，把它写回到 cookie 中

# ctx.push()
请求过来的时候，flask 会根据 cookie 信息创建出 session 变量（如果 cookie 不存在，这个变量有可能为空），保存在该请求的上下文中

# response = self.full_dispatch_request()
flask 会在发送 response 的时候，根据 session 的值，把它写回到 cookie 中

# ctx.auto_pop(error)
```

###### 2.  wsgi_app

```python
def wsgi_app(self, environ, start_response):
    # 返回RequestContext(self, environ)对象，初始化的时候做了好多事情
    # 最主要生成一个request对象和一个session对象，并赋给了对象ctx
    ctx = self.request_context(environ)
    error = None
    try:
        try:
            # 执行RequestContext对象的push方法
            ctx.push()
            
            response = self.full_dispatch_request()
        except Exception as e:
            error = e
            response = self.handle_exception(e)
        except:
            error = sys.exc_info()[1]
            raise
        return response(environ, start_response)
    finally:
        if self.should_ignore_error(error):
            error = None
        # 删除请求的ctx和app_ctx
        ctx.auto_pop(error)
```

##### 5.4 session源码分析之：ctx = self.request_context(environ)

```Python
"""
self.session = None
会产生一个空session赋给RequestContext类对象ctx
"""
```

```python
class RequestContext(object):

    def __init__(self, app, environ, request=None):
        # app就是Flask的对象，environ就是传入的http协议相关请求参数（字典）
        # 将Flask的对象赋给RequestContext类对象的app属性
        self.app = app
        if request is None:
            # app.request_class就是Request类，Request(environ)实例化产生一个request对象
            # from flask.wrappers import RequestBase
            request = app.request_class(environ)
        # 将产生的request对象赋给RequestContext类对象的request属性
        self.request = request
        # 将MapAdapter的对象，就是将map对象的属性映射到MapAdapter对象的属性上
        # 将ctx的属性url_adapter赋值为MapAdapter的对象
        self.url_adapter = app.create_url_adapter(self.request)
        self.flashes = None
        self.session = None
		.......
        # 将请求路径和请求的endpoint以及参数和request做个关联
        self.match_request()
```

##### 5.5 session源码分析之：ctx.push()

###### 1. ctx.push()

```python
"""
self.session = session_interface.open_session(
            self.app, self.request
        )

会将接受一个字典里面包含cookie反解过后的数据，放入
"""
```

```python
def push(self):

	.......
    # 由于每次请求都会初始化创建ctx，因此session都为None
    if self.session is None:
        
        # # session_interface = SecureCookieSessionInterface(),
        # 即session_interface就是一个SecureCookieSessionInterface类的实例对象
        # 在 Flask 中，所有和 session 有关的调用，都是转发到 self.session_interface 的方法调用上（这样用户就能用自定义的 session_interface 来控制 session 的使用）
        
        session_interface = self.app.session_interface
        
        # 第一次访问：生成一个 字典(容器) 返回至 self.session，如果没有加盐返回一个None
        self.session = session_interface.open_session(
            self.app, self.request
        )
		# make_null_session 来生成一个空的 session，这个特殊的 session 不能进行任何读写操作，不然会报异常给用户。
        if self.session is None:
            self.session = session_interface.make_null_session(self.app)
```

###### 2. open_session

```python
"""
本质就是返回一个SecureCookieSession类的实例对象，其实可以当做就是一个特殊的字典

第一次访问时：就返回一个空字典

第二次访问时：通过解密算法，反解出cookie包含色session信息
"""
```

```python
def open_session(self, app, request):
    
    # 获取加解密对象，就是加的盐
    s = self.get_signing_serializer(app)
    if s is None:
        # 如果没有盐，则返回None
        return None
    
    # 从 cookie 中获取 session 的value
    val = request.cookies.get(app.session_cookie_name)
    # 如果cookie没有值
    # 第一次访问为空执行
    if not val:
        # 生成一个 SecureCookieSession类的实例对象，用于保存用户的session数据。
        #  SecureCookieSession类其实就是一个特殊的字典
        # 返回{}
        return self.session_class()
    
    # 第二次访问
    max_age = total_seconds(app.permanent_session_lifetime)
    try:
        # 解密返回原始数据
        data = s.loads(val, max_age=max_age)
        # 返回一个含有cookie信息的 SecureCookieSession 类实例
        return self.session_class(data)
    except BadSignature:
        return self.session_class()
```

##### 5.6 session源码分析之：response = self.full_dispatch_request()

###### 1. full_dispatch_request

```python
"""
主要是处理视图，以及请求拓展，信号钩子函数，最后返回一个response对象
"""
```

```python
def full_dispatch_request(self):
	.......
    # 视图函数的返回值当做参数传入，返回一个response并触发后续处理函数,完成request请求。
    return self.finalize_request(rv)
```

###### 2. self.finalize_request(rv)

```python
"""
产生一个response对象，并为其执行请求过后的一些操作
"""
```

```python
def finalize_request(self, rv, from_error_handler=False):

    # 包装一个response的对象
    response = self.make_response(rv)
    try:
        response = self.process_response(response)
        # 触发 request_finished 信号
        request_finished.send(self, response=response)
    except Exception:
        ....
    return response
```

###### 3. response = self.process_response(response)

```python
"""
执行SecureCookieSessionInterface类对象的save_session方法

将 self.session 这个字典序列化，并返回，写入到客户端浏览器的cookie中
"""
```

```python
    def process_response(self, response):
		.......
        if not self.session_interface.is_null_session(ctx.session):
            #  将 self.session 这个字典序列化，并返回，写入到客户端浏览器的cookie中
            self.session_interface.save_session(self, ctx.session, response)
        return response
```

###### 4. save_session(self, ctx.session, response) 

```python
"""
判断session是否为空，如果为空，则不设置cookie
如果session发生变化，就需要修改session，并返回新的session对象
"""
```

```python
def save_session(self, app, session, response):
    domain = self.get_cookie_domain(app)
    path = self.get_cookie_path(app)

    # If the session is modified to be empty, remove the cookie.
    # If the session is empty, return without setting the cookie.
    # 如果 session 变成了空字典，flask 会直接删除对应的 cookie
    if not session:
        if session.modified:
            response.delete_cookie(
                app.session_cookie_name,
                domain=domain,
                path=path
            )

        return

    # Add a "Vary: Cookie" header if the session was accessed at all.
    # 是否需要设置 cookie。如果 session 发生了变化，就一定要更新 cookie，
    # 否则用户可以 `SESSION_REFRESH_EACH_REQUEST` 变量控制是否要设置 cookie
    if session.accessed:
        response.vary.add('Cookie')

    if not self.should_set_cookie(app, session):
        return

    httponly = self.get_cookie_httponly(app)
    secure = self.get_cookie_secure(app)
    samesite = self.get_cookie_samesite(app)
    expires = self.get_expiration_time(app, session)
    # 将session通过加密算法生成加密字符串
    val = self.get_signing_serializer(app).dumps(dict(session))
    # 为响应头添加cookie信息
    response.set_cookie(
        app.session_cookie_name,
        val,
        expires=expires,
        httponly=httponly,
        domain=domain,
        path=path,
        secure=secure,
        samesite=samesite
    )
```



****

#### 六. 闪现(message)

##### 6.1 作用

```python
假设在a页面操作出错，跳转到b页面，在b页面显示a页面的错误信息
本质是基于session现将设置的值，存起来，当get_flashed_messages取出值后，会自动删除值，所以在不同的浏览器访问，不会出现错乱。
```

##### 6.2 设置值

```python
1. 普通设置
flash('aaa')

2. 分类设置
flash('你的名字不是lqz是%s',category='aa')
```

##### 6.3 取值

```python
1. 普通取值
get_flashed_message()

2. 分类取值
get_flashed_messages(category_filter=['aa',])
```

##### 6.4 实例

```python
from flask import Flask, url_for, flash, get_flashed_messages

app = Flask(__name__)

app.secret_key = "zhang"
app.debug = True


@app.route("/index", endpoint="index", methods=["GET", "POST"])
def index():
    # 设置闪现的值
    flash("hello", category="test")
    return "ok"


@app.route("/test", endpoint="test", methods=["GET"])
def test():
    # 取出闪现的值
    res = get_flashed_messages(category_filter=["test"])
    return res[0]


if __name__ == '__main__':
    app.run()
```

****

#### 七. 请求拓展（类似于django中的中间件）

##### 7.1 before_request

###### 7.1.1 作用

```python
类比django中间件中的process_request,在请求收到之前绑定一个函数做一些事情
```

```python
# 基于它做用户登录认证
@app.before_request
def process_request(*args,**kwargs):
    if request.path == "/login":
        return None
    user = session.get("user_info")
    if user:
        return None
    return redirect("/login")
```

##### 7.2 after_request

###### 7.2.1 作用

```
类比于django中间件中的process_response,每一个请求的之后绑定一个函数，如果请求没有异常。
```

```python
@app.after_request
def process_response(response):
    print("process_response 走了")
    return response
```

##### 7.3 before_first_request

###### 7.3.1 作用

```
第一次请求时，和浏览器无关
```

```python
@app.before_first_request
def first():
    pass
```

##### 7.4 teardown_request

###### 7.4.1 作用

```
每一个请求之后绑定一个函数，即使遇到了异常
```

```python
@app.teardown_request
def ter(e):
    pass
```

###### 7.4.2 实例

```python
from flask import Flask, request, redirect, flash, get_flashed_messages

app = Flask(__name__)
# app.debug = True
app.secret_key = 'ssss'


# 访问index页面传参数name=lqz,如果不是lqz,出错,跳转到order页面,显示错误信息
@app.route('/index')
def index():
    m
    return "hello_index"


# 访问路径不存在时的处理函数
@app.errorhandler(404)
def error(e):
    print(e)
    return "404请求的页面不存在"


# 服务器内部错误时响应的方法
@app.errorhandler(500)
def error_500(e):
    print(e)
    return "服务器内部错误"

# 即使遇到异常都会走到此函数
@app.teardown_request
def evedone(f):
    print("teardown_request执行了")
    return "hello"


if __name__ == '__main__':
    app.run(port=8008)
```

```python
"""
执行结果：
name 'm' is not defined
teardown_request执行了
"""
```

##### 7.5 errorhandler

```
路径不存在时404，服务器内部错误500
```

```python
@app.errorhandler(404)
def error_404(arg):
	return "404错误了"
```

###### 7.5.1 实例

```python
from flask import Flask

app = Flask(__name__)
app.debug = True
app.secret_key = 'ssss'


# 访问index页面传参数name=lqz,如果不是lqz,出错,跳转到order页面,显示错误信息
@app.route('/index')
def index():
    m
    return "hello_index"


# 访问路径不存在时的处理函数
@app.errorhandler(404)
def error(e):
    print(e)
    return "404请求的页面不存在"


# 服务器内部错误时响应的方法
@app.errorhandler(500)
def error_500(e):
    print(e)
    return "服务器内部错误"


if __name__ == '__main__':
    app.run(port=8008)

```

##### 7.6 总结

```python
"""
1. 重点掌握before_request和after_request

2. 注意有多个的情况，执行顺序

3. before_request请求拦截后（也就是有return值），response所有都执行
"""
```

##### 7.7 实例

###### 7.7.1 实例一：before_request返回None

```python
from flask import Flask, request, redirect, flash, get_flashed_messages

app = Flask(__name__)
app.debug = True
app.secret_key = 'ssss'


# 访问index页面传参数name=lqz,如果不是lqz,出错,跳转到order页面,显示错误信息
@app.route('/index')
def index():
    return "hello_index"


@app.before_request
def process_request():
    print('来了')
    # return 'xxx'


@app.after_request
def process_response(response):
    print(response)
    print('走了')
    return response


@app.before_request
def process_request1():
    print('来了1')
    # return 'xxx'


@app.after_request
def process_response1(response):
    print(response)
    print('走了1')
    return response


@app.before_first_request
def first():
    print('我的第一次')


if __name__ == '__main__':
    app.run(port=8002)

```

```python
"""
结果：
    我的第一次
    来了
    来了1
    <Response 11 bytes [200 OK]>
    走了1
    <Response 11 bytes [200 OK]>
    走了
"""
```

****

###### 7.7.2 实例二：before_request返回非None

```python
@app.before_request
def process_request():
    # print('来了')
    return 'xxx'
```

```python
"""
结果：
    我的第一次
    来了
    <Response 3 bytes [200 OK]>
    走了1
    <Response 3 bytes [200 OK]>
    走了

"""
```

****

#### 八. 中间件

##### 8.1 作用

```python
"""
1. 请求之前，或者请求之后，做些自定义的处理
"""
```

##### 8.2 源码分析

```python
"""
1. 程序监听端口，并等待请求，主要执行下面的方法
run -- run_simple(host, port, self, **options) 

2. 当程序监听的端口有请求进入，首先会执行Flask类中的__call__方法，接着执行wsgi_app（请求的总入口）
__call__ -- wsgi_app(environ, start_response)

3. 因此需要中间件起作用，需要在程序执行wsgi_app之前和之后做些处理
"""
```

##### 8.3 如何自定义中间件

```python
from flask import Flask

app = Flask(__name__)


@app.route("/index", methods=["GET"], endpoint="index")
def index():
    return "index"


class Middleware(object):
    def __init__(self, wsgi_app):
        self.wsgi_app = wsgi_app

    def __call__(self, environ, start_response):
        print("我是请求之前")
        print(environ)
        res = self.wsgi_app(environ, start_response)
        print("我是请求之后")
        print(environ)
        return res


if __name__ == '__main__':
    # 将app的wsgi_app属性重新赋值为Middleware对象，将原来的wsgi_app传入，并保存为Middleware对象
    # 的wsgi_app属性，当程序一旦执行self.wsgi_app(environ, start_response)，本质是执行			# Middleware对象的__call__方法，将原wsgi_app执行的结果返回。
    app.wsgi_app = Middleware(app.wsgi_app)
    app.run(port=8888)

```

****

### STEP-3

#### 一. 蓝图（Blueprint）

##### 1. 蓝图的作用

```python
"""
1. 对程序进行目录结构的划分

2. 有点类似于django中的路由分发include

3. 可以实现不同的蓝图对象管理不同的视图函数
"""
```

##### 2. 不使用蓝图自己分文件

###### 2.1 目录结构

```python
D:.
│  manage.py
│
└─flask_test
    │  __init__.py
    │
    ├─static
    ├─templates
    ├─views
      │  order.py
      │  user.py
      └─  __init__.py


```

```python
"""
manage.py:项目的启动文件
flask_test：项目文件的目录
flask_test下面的__init__.py：是实例产生Flask对象，以及请求拓展，中间件，url和视图映射的地方
static：静态文件夹
templates：模板文件夹
views：视图文件夹
order.py：order相关的视图函数
user.py：用户相关的视图函数
__init__.py：将视图函数导入此文件，方便导入
"""
```

###### 2.2 manage.py

```python
from flask_test import app

if __name__ == '__main__':
    app.run(port=8200)

```

###### 2.3 flask_test下的__init__.py

```python
from flask import Flask
from .views import *

app = Flask(__name__)
app.debug = True

app.add_url_rule("/order", "order", order)
app.add_url_rule("/login", "login", login)
app.add_url_rule("/logout", "logout", logout)

```

###### 2.4 order.py

```python


def order():
    return "order"

```

###### 2.5 user.py

```python
def login():
    return "login"


def logout():
    return "logour"

```

###### 2.6 views下面的__init__

```python
from .user import logout, login
from .order import order
```

****

##### 3. 使用蓝图之中小型项目

###### 3.1 目录结构

```python
D:.
│  manage.py
│
└─flask_test
    │  __init__.py
    │
    ├─static
    ├─templates
    ├─views
      │  order.py
      │  user.py
      │  __init__.py

```

```python
"""
和自定义非蓝图版文件目录的区别
1. flask_test文件下的__init__.py，主要是注册蓝图

2. order.py和user.py主要是生成一个蓝图对象，接着装饰到视图函数

3. views下的__init__.py主要是将视图函数实例的蓝图对象，更方便的导入

"""
```

###### 3.2 manage.py

```python
from flask_test import app

if __name__ == '__main__':
    app.run(port=8201)

```

###### 3.3 flask_test下的__init__.py

```python
from flask import Flask
from .views import order_blue, user_blue

app = Flask(__name__)
app.debug = True

app.register_blueprint(order_blue)
app.register_blueprint(user_blue)

```

###### 3.4 order.py

```python
from flask import Blueprint

order_blue = Blueprint("order", __name__)


@order_blue.route("/order", endpoint="order")
def order():
    return "order"

```

###### 3.5 user.py

```python
from flask import Blueprint

user_blue = Blueprint("user", __name__)


@user_blue.route("/login", endpoint="login")
def login():
    return "login"


@user_blue.route("/logout", endpoint="logout")
def logout():
    return "logour"

```

###### 3.6 views下面的init

```python
from .user import user_blue
from .order import order_blue
```

****

##### 4. 使用蓝图之大型项目

###### 4.1 项目目录

```
D:.
│  manage.py
│
|
└─flask_app
    │  __init__.py
    │
    ├─flask_admin
    │  │  __init__.py
    │  │
    │  ├─static
    │  ├─templates
    │  ├─views
    │    │  order.py
    │    │  user.py
    │    │  __init__.py
    │
    ├─flask_user
      │  __init__.py
      │
      ├─static
      ├─templates
      ├─views
        │  order.py
        │  user.py
        │  __init__.py
   
```

```python
"""
目录解释：
manage.py：项目启动入口
flask_app：项目所有app的目录，如user和admin
flask_app下面的init.py:主要是产生Flask实例app，并注册蓝图
flask_admin/flask_user：flask_user类似django中的app
flask_admin/flask_user下面的__init__.py：主要是产生蓝图实例，以及蓝图所控制的视图函数
其他同上
"""
```

###### 4.2 manage.py

```python
from flask_app import app

if __name__ == '__main__':
    app.run(port=8202)

```

###### 4.3 flask_app下面的init.py

```python
from flask import Flask
from .flask_admin import admin
from .flask_user import user_blue

app = Flask(__name__)
app.debug = True
# 127.0.0.1:8202/admin/..访问
app.register_blueprint(admin, url_prefix="/admin")
app.register_blueprint(user_blue, url_prefix="/user")

```

###### 4.4 flask_admin/flask_user下面的init.py

>flask_admin

```python
from flask import Blueprint

admin = Blueprint("admin", __name__, static_folder="static", template_folder="templates")
from .views import *

```

>flask_user

```python
from flask import Blueprint
# user_blue一定不能和管理视图函数的文件名重复
user_blue = Blueprint("user", __name__, static_folder="static", template_folder="templates")
from .views import *

```

###### 4.5 views下面的__init__.py

>flask_admin

```python
from .order import order
from .user import login, logout
```

>flask_user

```python
from .order import order
from .user import login, logout
```

###### 4.6 views下面的order.py

>flask_admin

```python
from ...flask_admin import admin


@admin.route("/order", endpoint="admin_order")
def order():
    return "admin_order"

```

>flask_user

```python
from ...flask_user import user_blue


@user_blue.route("/order", endpoint="order")
def order():
    return "user_order"

```

###### 4.7 views下面的user.py

>flask_admin

```python
from ...flask_admin import admin


@admin.route("/login", endpoint="admin_login")
def login():
    return "admin_login"


@admin.route("/logout", endpoint="admin_logour")
def logout():
    return "admin_logour"

```

>flask_user

```python
from flask_app.flask_user import user_blue


@user_blue.route("/login", endpoint="user_login")
def login():
    return "user_login"


@user_blue.route("/logout", endpoint="user_logour")
def logout():
    return "user_logour"

```

****

##### 5. 使用蓝图注意事项

###### 5.1 当为templates目录添加目录解耦时

```python
render_template('user/login.html')
# user为templates里面的文件目录，login.html为user目录下的文件
# 可以同过template_folder创建蓝图是指定模板文件的目录
```

##### 6. 蓝图总结

```
总结：

1 xxx = Blueprint('account', __name__,url_prefix='/xxx') ：蓝图URL前缀，表示url的前缀，在该蓝图下所有url都加前缀

2 xxx = Blueprint('account', name,url_prefix='/xxx',template_folder='tpls')：给当前蓝图单独使用templates，向上查找，当前找不到，会找总templates

3 蓝图的befort_request，对当前蓝图有效

4 大型项目，可以模拟出类似于django中app的概念
```

****

#### 二. 请求上下文源码分析

##### 1. Flask上下文的种类

###### 1.1 应用上下文

```python
"""
current_app（当前激活程序实例）
g（处理请求时临时存储的对象）
"""
```

###### 1.2 请求上下文

```python
"""
request（请求对象，封装了http请求内容）
session（用户会话，用于存储请求之间需要‘记住’的字典值）
"""
```

##### 2. 上下文的作用

```python
"""
flask从客户端获取到请求时，要让视图函数能访问一些对象，这样才能处理请求。例如请求对象就是一个很好的例子。要让视图函数访问请求对象，一个显而易见的方法就是将其作为参数传入视图函数，不过这回导致程序中的每个视图函数都增加一个参数，为了避免大量可有可无才参数把视图函数弄得一团糟，flask使用上下文临时把某些对象变为全局可访问（只是当前线程的全局可访问）。
"""
```

##### 3. 上下文的生命周期

```python
"""
1. request对象只有在请求上下文的生命周期内才可以访问。离开了请求的生命周期，其上下文环境也就不存在了，自然也无法获取request对象

2. 一般就是在视图函数里，或者请求钩子中，才能使用请求上下文request。flask在接收到来自客户端的请求时，会帮我们构造请求上下文的使用环境，当flask根据url跳到相应的视图函数的时候，自然而然就可以直接使用请求上下文，请求钩子也是同理。

3. 在不同http请求之间得到的request必然也是不一样的，它只包含当前http请求的一些信息，是线程隔离的。

4. session不一样，session是可以跨请求的，在不同的http请求之间，session都是同一个，因此，可以借session来存储一些请求之间需要‘记住’的字典值。
"""
```

##### 4. 请求上下文环境构造

###### 4.1 **wsgi_app**

```python
"""
1. 首先通过request_context(environ)产生一个RequestContext上下文对象ctx，并将重要的request对象，和session赋给了ctx对象。

2. 通过push（）方法，产生2个LocalStack的对象，分别将请求上下文和应用上下文通过push方法压入LocalStack的对象。并通过open_session方法将session获取到。

3. 通过full_dispatch_request()执行请求拓展，信号，视图函数，并将视图函数返回的结果封装成一个response对象,并通过save_session方法将session转化成cookie赋给response对象。

4. 通过auto_pop方法将请求上下文对象和应用上下文对象从LocalStack的栈中删除。
"""
```

```python
def wsgi_app(self, environ, start_response):

    # 返回RequestContext(self, environ)对象，初始化的时候做了好多事情
    
    ctx = self.request_context(environ)
    error = None
    try:
        try:
            # 执行RequestContext对象的push方法
            ctx.push()
            response = self.full_dispatch_request()
        except Exception as e:
            error = e
            response = self.handle_exception(e)
        except:
            error = sys.exc_info()[1]
            raise
        return response(environ, start_response)
    finally:
        if self.should_ignore_error(error):
            error = None
        ctx.auto_pop(error)

```

###### 4.2 request_context

> **1.RequestContext的init方法**

```python
class RequestContext(object):
    
    def __init__(self, app, environ, request=None):
        
        # app就是Flask的对象，environ就是传入的http协议相关请求参数（字典）
        # 将Flask的对象赋给RequestContext类对象的app属性
        self.app = app
        
        if request is None:
            # app.request_class就是Request类，Request(environ)实例化产生一个request对象
            # from flask.wrappers import RequestBase
            request = app.request_class(environ)
        # 将产生的request对象赋给RequestContext类对象的request属性
        self.request = request
        
        # 将MapAdapter的对象，就是将map对象的属性映射到MapAdapter对象的属性上
        # 将ctx的属性url_adapter赋值为MapAdapter的对象
        self.url_adapter = app.create_url_adapter(self.request)
        
        self.flashes = None
        self.session = None

        self._implicit_app_ctx_stack = []

        self.preserved = False

        self._preserved_exc = None

        self._after_request_functions = []

        # 将请求路径和请求的endpoint以及参数和request做个关联
        self.match_request()
```

> **2. BaseRequest的init方法**

```python
class BaseRequest(object):
    def __init__(self, environ, populate_request=True, shallow=False):
        # 给request对象设置属性environ并将传入environ赋给它
        self.environ = environ
        
        if populate_request and not shallow:
            # 给request对象的environ添加新值werkzeug.request=self, self就是request对象
            self.environ['werkzeug.request'] = self
            
        # 给request对象设置属性shallow，此时shallow为False
        self.shallow = shallow
```

****

###### 4.3  ctx.push

> **1.ctx.push**

```python
def push(self):
    """Binds the request context to the current context."""
    # 将请求上下文绑定到当前上下文

    # _request_ctx_stack.top，top是一个静态方法
    # _request_ctx_stack是LocalStack对象
    # 调用LocalStack对象的top方法，返回None或者栈顶元素ctx对象，
    # from .globals import _request_ctx_stack
    top = _request_ctx_stack.top
    # 如果top不是None且top.preserved值为True，ctx就执行自己的pop方法RequestContext的top方法
    if top is not None and top.preserved:
        top.pop(top._preserved_exc)


    # _app_ctx_stack是LocalStack对象
    app_ctx = _app_ctx_stack.top
    if app_ctx is None or app_ctx.app != self.app:
        # self.app == Fask()
        #  得到一个 AppContext类的实例对象，得到一个 应用上下文对象 app_ctx，此时 app_ctx拥有以下属性
        #  app_ctx.app = app, app_ctx.g = app.app_ctx_globals_class()
        app_ctx = self.app.app_context()
        
        # 将 app_ctx 入栈,应用上下文入栈
        app_ctx.push()
        
        # _implicit_app_ctx_stack是一个[],将app_ctx添加到列表中
        self._implicit_app_ctx_stack.append(app_ctx)
    else:
        self._implicit_app_ctx_stack.append(None)

    if hasattr(sys, 'exc_clear'):
        sys.exc_clear()

    # self 指的是 ctx，即将ctx入栈，即 _request_ctx_stack._local.stack = [ctx]。请求上下文入栈
    # 执行的是LocalStack的push
    _request_ctx_stack.push(self)


    # 由于每次请求都会初始化创建ctx，因此session都为None
    if self.session is None:
        # session_interface = SecureCookieSessionInterface(),
        # 即session_interface就是一个SecureCookieSessionInterface类的实例对象
        session_interface = self.app.session_interface
        # 第一次访问：生成一个 字典(容器) 返回至 self.session
        self.session = session_interface.open_session(
            self.app, self.request
        )
		# 如果没有自定义盐，返回None，生成一个特殊的session对象，不能对session进行修改和读取
        if self.session is None:
            self.session = session_interface.make_null_session(self.app)
```

> **2. LocalStack的top方法**

```python
@property
def top(self):
    # 堆栈上最顶层的项。如果堆栈为空，则返回“none”。
    try:
        # self._local就是Local()，从stack的列表中取出最新的一个上下文对象
        return self._local.stack[-1]
    
    except (AttributeError, IndexError):
        return None
```

> **3.LocalStack的push方法 **

```python
def push(self, obj):
    # 从Local类对象中取stack的值，如果没有就是None
    rv = getattr(self._local, 'stack', None)
    
    # 如果rv是None
    if rv is None:
        # 给Local类添加一个属性stack=rv = []
        self._local.stack = rv = []
        
    # 请求进来将请求上下文RequestContext加入到列表中:
    rv.append(obj)
    
    # 返回有ctx的的列表rv
    return rv
```

> **4. Flask对象的app_context**

```python

def app_context(self):
	# 返回一个AppContext对象
    return AppContext(self)
```

> **5.AppContext的init方法 **

```python
class AppContext(object):

    def __init__(self, app):
        # app就是Flask对象
        self.app = app
        self.url_adapter = app.create_url_adapter(None)
        # 为AppContext添加g属性
        self.g = app.app_ctx_globals_class()
        self._refcnt = 0
```

> **6. open_session**

```python
def open_session(self, app, request):
    # 获取 app的 secret_key,并解密
    s = self.get_signing_serializer(app)
    
    # 如果没有定义secret_key，则返回None
    if s is None:
        return None
    
    # 从 cookie 中获取 session 的value，session_cookie_name值为session
    val = request.cookies.get(app.session_cookie_name)
    
    # 如果cookie没有值
    # 第一次访问为空执行
    if not val:
        # 生成一个 SecureCookieSession类的实例对象，用于保存用户的session数据。
        #  SecureCookieSession类其实就是一个特殊的字典
        # 返回{}
        return self.session_class()
    
    # 第二次访问
    max_age = total_seconds(app.permanent_session_lifetime)
    try:
        # 将获取到的cookie进行反解
        data = s.loads(val, max_age=max_age)
        # 返回一个含有cookie信息的 SecureCookieSession 类实例
        return self.session_class(data)
    except BadSignature:
        return self.session_class()
```

****

###### 4.4 full_dispatch_request

> **1. full_dispatch_request**

```python

def full_dispatch_request(self):
    #  将 _got_first_request =  True，依次执行定义的 before_first_request 函数
    self.try_trigger_before_first_request_functions()
    
    try:
        # 触发 request_started 信号
        request_started.send(self)
        
        #  执行钩子函数：before_request
        rv = self.preprocess_request()
        
        # 如果执行的before_request,before_first_request函数没有返回值，则继续执行视图函数。若有返回值，否则不执行视图函数
        if rv is None:
            # 执行此url对应的别名的视图函数并执行该函数，返回视图函数的返回值，得到相应信息
            rv = self.dispatch_request()
            
    except Exception as e:
        # 如果发生错误，则将异常信息作为返回值进行返回
        rv = self.handle_user_exception(e)
        
    # 视图函数的返回值当做参数传入，返回一个response并触发后续处理函数,完成request请求。
    return self.finalize_request(rv)
```

> **2. try_trigger_before_first_request_functions**

```python
def try_trigger_before_first_request_functions(self):
	....
    with self._before_request_lock:
  		....
        # 循环before_first_request_funcs的列表，并执行里面的before_first_request的函数
        for func in self.before_first_request_funcs:
            func()
        self._got_first_request = True
```

> **3.preprocess_request **

```python
def preprocess_request(self):

	....
    funcs = self.url_value_preprocessors.get(None, ())
	....
    for func in funcs:
        func(request.endpoint, request.view_args)
	.....
    # 取出before_request的请求拓展的函数列表
    funcs = self.before_request_funcs.get(None, ())
	....
    # 循环函数列表，并返回非空的的结果
    for func in funcs:
        rv = func()
        if rv is not None:
            return rv
```

> **4. dispatch_request**

```python
def dispatch_request(self):

    req = _request_ctx_stack.top.request
    if req.routing_exception is not None:
        self.raise_routing_exception(req)
    rule = req.url_rule
    # if we provide automatic options for this URL and the
    # request came with the OPTIONS method, reply automatically
    if getattr(rule, 'provide_automatic_options', False) \
            and req.method == 'OPTIONS':
        return self.make_default_options_response()
    # otherwise dispatch to the handler for that endpoint
    # 执行对应的视图函数，并返回视图函数的结果
    return self.view_functions[rule.endpoint](**req.view_args)
```

> **5. finalize_request**

```python
def finalize_request(self, rv, from_error_handler=False):

    # 包装一个response的对象
    response = self.make_response(rv)
    try:
        response = self.process_response(response)
        
        # 触发 request_finished 信号
        request_finished.send(self, response=response)
        
    except Exception:
        if not from_error_handler:
            raise
        self.logger.exception('Request finalizing failed with an '
                              'error while handling an error')
    # 返回response对象
    return response
```

> **6. process_response**

```python
def process_response(self, response):
	# 从栈顶取出当前的ctx对象
    ctx = _request_ctx_stack.top
    bp = ctx.request.blueprint
    
    # 取出after_request的请求拓展的方法的列表
    funcs = ctx._after_request_functions
    if bp is not None and bp in self.after_request_funcs:
        funcs = chain(funcs, reversed(self.after_request_funcs[bp]))
    if None in self.after_request_funcs:
        funcs = chain(funcs, reversed(self.after_request_funcs[None]))
    #循环这个列表，执行列表的方法
    for handler in funcs:
        # 因为会将response对象传入after_request的方法中，所以after_request修饰的方法，必须要接受参数response
        # 将执行过后最新的response赋给response
        response = handler(response)
        
        
    if not self.session_interface.is_null_session(ctx.session):
        #  将 self.session 这个字典序列化，并返回，写入到客户端浏览器的cookie中
        self.session_interface.save_session(self, ctx.session, response)
    return response
```

> **7. save_session**

```python

def save_session(self, app, session, response):
    ....

    # If the session is modified to be empty, remove the cookie.
    # 如果session修改成空的字典，则移除cookie
    # If the session is empty, return without setting the cookie.
    # 如果session是空的，则不返回cookie
    # 如果 session 变成了空字典，flask 会直接删除对应的 cookie
    if not session:
        if session.modified:
            response.delete_cookie(
                app.session_cookie_name,
                domain=domain,
                path=path
            )

        return

    # Add a "Vary: Cookie" header if the session was accessed at all.
    # 是否需要设置 cookie。如果 session 发生了变化，就一定要更新 cookie，
    # 否则用户可以 `SESSION_REFRESH_EACH_REQUEST` 变量控制是否要设置 cookie
    if session.accessed:
        response.vary.add('Cookie')

    if not self.should_set_cookie(app, session):
        return

   	.....
    
    # 对session进行加密
    val = self.get_signing_serializer(app).dumps(dict(session))
    
    # 为响应头添加cookie信息
    response.set_cookie(
        app.session_cookie_name,
        val,
        expires=expires,
        httponly=httponly,
        domain=domain,
        path=path,
        secure=secure,
        samesite=samesite
    )
```

****

###### 4.5 RequestCentext类auto_pop

> **1. auto_pop**

```python
def auto_pop(self, exc):
    .....
    # 执行RequestCentext的pop方法
    # exc=None
    self.pop(exc)
```

> **2.RequestCentext类的pop方法 **

```python
def pop(self, exc=_sentinel):

    # 取出应用上下文
    app_ctx = self._implicit_app_ctx_stack.pop()

    try:
        clear_request = False
        if not self._implicit_app_ctx_stack:
            self.preserved = False
            self._preserved_exc = None
            if exc is _sentinel:
                exc = sys.exc_info()[1]
            # 执行teardown_request的请求拓展
            self.app.do_teardown_request(exc)

            ....
    finally:
        # 删除请求上下文
        rv = _request_ctx_stack.pop()
		....
        # 如果应用上下文不是空
        if app_ctx is not None:
            # 删除应用上下文
           app_ctx.pop(exc)
```

> **3. AppContext的pop**

```python
def pop(self, exc=_sentinel):
	# 删除应用上下文
    try:
        .....
        
    finally:
        # 从栈中删除应用上下文
        rv = _app_ctx_stack.pop()
        .....
  
```

****

##### 5. **LocalStack**

###### 5.1 作用

```python
"""
1. 请求上下文和应用上下文是LocalStack数据结构的实例

2. _request_ctx_stack和_app_ctx_stack的push、pop、top操作都是针对自己self._local.stack属性进行的。


"""
```

###### 5.2 源码

```python
class LocalStack(object):

    def __init__(self):
        self._local = Local()

    def __release_local__(self):
        self._local.__release_local__()

    def _get__ident_func__(self):
        return self._local.__ident_func__

    def _set__ident_func__(self, value):
        object.__setattr__(self._local, '__ident_func__', value)

    __ident_func__ = property(_get__ident_func__, _set__ident_func__)
    del _get__ident_func__, _set__ident_func__

    def __call__(self):
        def _lookup():
            rv = self.top
            if rv is None:
                raise RuntimeError('object unbound')
            return rv

        return LocalProxy(_lookup)

    def push(self, obj):
        """Pushes a new item to the stack"""
        # 从Local类对象中取stack的值，如果没有就是None
        rv = getattr(self._local, 'stack', None)
        # 如果rv是None
        if rv is None:
            # 给Local类添加一个属性stack=rv = []
            # 会触发Local对象__setattr__，{"id":{"stack":[]}}
            self._local.stack = rv = []
        # 请求进来将请求上下文RequestContext加入到列表中:
        rv.append(obj)
        # 返回有ctx的的列表rv
        return rv

    def pop(self):
        """Removes the topmost item from the stack, will return the
        old value or `None` if the stack was already empty.
        """
        # 移除栈顶上的元素，可能返回ctx，也可能返回空
        # stack是一个列表
        stack = getattr(self._local, 'stack', None)
        if stack is None:
            return None
        elif len(stack) == 1:
            # 传入一个local对象，执行local对象的__release_local__
            # 就是删除__storage__={}里面的{id:{}}
            release_local(self._local)
            # 返回ctx对象
            return stack[-1]
        else:
            return stack.pop()

    @property
    def top(self):
        """The topmost item on the stack.  If the stack is empty,
        `None` is returned.
        """
        # 堆栈上最顶层的项。如果堆栈为空，则返回“none”。
        try:
            # self._local就是Local()，从stack的列表中取出最新的一个上下文对象
            return self._local.stack[-1]
        except (AttributeError, IndexError):
            return None
```



##### 6. Local

###### 6.1 作用

```python
"""
1. 真正的将ctx存储的栈是Local对象

"""
```

###### 6.2 源码

```python
try:
    from greenlet import getcurrent as get_ident
except ImportError:
    try:
        from thread import get_ident
    except ImportError:
        from _thread import get_ident

class Local(object):
    __slots__ = ('__storage__', '__ident_func__')

    def __init__(self):
        # 给每个线程对象设置一个__storage__={}，__ident_func__=get_ident
        # get_ident是线程id或者协程id
        object.__setattr__(self, '__storage__', {})
        object.__setattr__(self, '__ident_func__', get_ident)

    def __iter__(self):
        return iter(self.__storage__.items())

    def __call__(self, proxy):
        """Create a proxy for a name."""
        return LocalProxy(self, proxy)

    def __release_local__(self):
        # 从字典中删除当前线程的对应的value的值
        self.__storage__.pop(self.__ident_func__(), None)

    def __getattr__(self, name):
        try:
            return self.__storage__[self.__ident_func__()][name]
        except KeyError:
            raise AttributeError(name)

    def __setattr__(self, name, value):
        # get_ident()获取线程或者协程的id
        ident = self.__ident_func__()
        # 获取__storage__={}的字典
        storage = self.__storage__
        try:
            storage[ident][name] = value
        except KeyError:
            storage[ident] = {name: value}

    def __delattr__(self, name):
        try:
            del self.__storage__[self.__ident_func__()][name]
        except KeyError:
            raise AttributeError(name)
```

****

##### 7. LocalProxy

###### 7.1 作用

```python
"""
视图函数导入：request/session 
执行request.method等其他操作时，会执行该类的方法

"""
```

```python
def _lookup_req_object(name):
    # 取出ctx
    top = _request_ctx_stack.top
    if top is None:
        raise RuntimeError(_request_ctx_err_msg)
    # ctx.request/ctx.session
    return getattr(top, name)


def _lookup_app_object(name):
    # 取出app_ctx
    top = _app_ctx_stack.top
    if top is None:
        raise RuntimeError(_app_ctx_err_msg)
    # app_ctx.g
    return getattr(top, name)


def _find_app():
    # 取出app_ctx
    top = _app_ctx_stack.top
    if top is None:
        raise RuntimeError(_app_ctx_err_msg)
    # app_ctx.app取出的就是Flask的对象
    return top.app

current_app = LocalProxy(_find_app)
request = LocalProxy(partial(_lookup_req_object, 'request'))
session = LocalProxy(partial(_lookup_req_object, 'session'))
g = LocalProxy(partial(_lookup_app_object, 'g'))
```

###### 7.2 源码

```python
@implements_bool
class LocalProxy(object):
   
    __slots__ = ('__local', '__dict__', '__name__', '__wrapped__')

    def __init__(self, local, name=None):
        object.__setattr__(self, '_LocalProxy__local', local)
        object.__setattr__(self, '__name__', name)
        if callable(local) and not hasattr(local, '__release_local__'):
            # "local" is a callable that is not an instance of Local or
            # LocalManager: mark it as a wrapped function.
            object.__setattr__(self, '__wrapped__', local)

    def _get_current_object(self):
        """Return the current object.  This is useful if you want the real
        object behind the proxy at a time for performance reasons or because
        you want to pass the object into a different context.
        """
        if not hasattr(self.__local, '__release_local__'):
            return self.__local()
        try:
            return getattr(self.__local, self.__name__)
        except AttributeError:
            raise RuntimeError('no object bound to %s' % self.__name__)

    @property
    def __dict__(self):
        try:
            return self._get_current_object().__dict__
        except RuntimeError:
            raise AttributeError('__dict__')

    def __repr__(self):
        try:
            obj = self._get_current_object()
        except RuntimeError:
            return '<%s unbound>' % self.__class__.__name__
        return repr(obj)

    def __bool__(self):
        try:
            return bool(self._get_current_object())
        except RuntimeError:
            return False

    def __unicode__(self):
        try:
            return unicode(self._get_current_object())  # noqa
        except RuntimeError:
            return repr(self)

    def __dir__(self):
        try:
            return dir(self._get_current_object())
        except RuntimeError:
            return []

    def __getattr__(self, name):
        if name == '__members__':
            return dir(self._get_current_object())
        return getattr(self._get_current_object(), name)

    def __setitem__(self, key, value):
        self._get_current_object()[key] = value

    def __delitem__(self, key):
        del self._get_current_object()[key]

    
```

##### 8. g对象

###### 8.1 作用

```python
"""
1. 专门用来存储用户信息的g对象，g的全称的为global 

2. g对象在一次请求中的所有的代码的地方，都是可以使用的 
"""
```

###### 8.2 g对象和session的区别

```python
"""
session对象是可以跨request的，只要session还未失效，不同的request的请求会获取到同一个session，但是g对象不是，g对象不需要管过期时间，请求一次就g对象就改变了一次，或者重新赋值了一次
"""
```

###### 8.3 实例

```python
from flask import Flask, g
import redis

app = Flask(__name__)


@app.before_first_request
def first():
    g.name = 'lqz'



@app.route('/')
def hello_world():
    print(g.name)



if __name__ == '__main__':
    app.run(port=8009)

```

****

#### 三. flask_session插件

##### 1 作用

```
作用：将默认保存的签名cookie中的值 保存到 redis/memcached/file/Mongodb/SQLAlchemy
```

##### 2 安装

```
安装：pip3 install flask-session
```

##### 3 使用方式一

```python
from flask import Flask, request, session, g
from flask_session import RedisSessionInterface
import redis

app = Flask(__name__)
conn = redis.Redis(host='127.0.0.1', port=6379)
app.session_interface = RedisSessionInterface(conn, key_prefix='flask_')



@app.route('/')
def hello_world():
    session['name'] = 'zhang'
    return 'Hello World!'


@app.route('/n1')
def n1():
    print(session.get('name'))
    return 'n1'


if __name__ == '__main__':
    app.run(port=8009)

```

##### 4 使用方式二

```python
from flask import g, Flask, session
from redis import Redis
from flask_session import Session

app = Flask(__name__)
app.config['SESSION_TYPE'] = 'redis'
app.config['SESSION_REDIS'] = Redis(host='127.0.0.1', port='6379')
Session(app)


@app.route("/login")
def login():
    session["user"] = "zhang"
    return "login"


@app.route("/index")
def index():
    user = session.get("user")
    print(user)
    return "index"


if __name__ == '__main__':
    app.run(port=8734)


```

#### 四. flask_script插件

##### 1. 作用

```
用于实现类似于django中 python3 manage.py runserver  ...类似的命令

应用场景：
把excel的数据导入数据库，定制个命令，去执行等
```

##### 2. 安装

```
pip3 install flask-script
```

##### 3. 使用

```python
from flask import g, Flask, session
from redis import Redis
from flask_session import Session
from flask_script import Manager

app = Flask(__name__)
app.config['SESSION_TYPE'] = 'redis'
app.config['SESSION_REDIS'] = Redis(host='127.0.0.1', port='6379')
Session(app)

manager = Manager(app)


# 自定义命令
@manager.command
def custom(arg):
    """
    自定义命令
    python manage.py custom 123
    :param arg:
    :return:
    """
    print(arg)


"""
D:\AAA\Flask\day04>python flask_script插件.py custom 100
100

"""


@manager.option('-n', '--name', dest='name')
@manager.option('-u', '--url', dest='url')
def cmd(name, url):
    """
    自定义命令（-n也可以写成--name）
    执行： python manage.py  cmd -n lqz -u http://www.oldboyedu.com
    执行： python manage.py  cmd --name lqz --url http://www.oldboyedu.com
    :param name:
    :param url:
    :return:
    """
    print(name, url)


"""
D:\AAA\Flask\day04>python flask_script插件.py cmd -n zhang -u www.baidu.com
zhang www.baidu.com

"""


@app.route("/login")
def login():
    session["user"] = "zhang"
    return "login"


@app.route("/index")
def index():
    user = session.get("user")
    print(user)
    return "index"


if __name__ == '__main__':
    manager.run()

```

```
以后在执行，直接：python3 文件名.py runserver 
```

****

#### 五. 多app应用

##### 1. 作用

```
用来分文件管理，管理不同的视图函数，蓝图就可以实现
本质：是根据不同的url路径，分发到不同的app中执行
```

##### 2. 使用

```python
from werkzeug.wsgi import DispatcherMiddleware
from werkzeug.serving import run_simple
from flask import Flask, current_app

app1 = Flask('app01')
app2 = Flask('app02')


@app1.route('/index')
def index():
    return "app01"


@app2.route('/index2')
def index2():
    return "app2" 


# http://www.oldboyedu.com/index
# http://www.oldboyedu.com/sec/index2
dm = DispatcherMiddleware(app1, {
    '/sec': app2,
})

if __name__ == "__main__":
    run_simple('localhost', 5000, dm)

```

****

#### 六. 信号

##### 1. 作用

```
Flask框架中的信号基于blinker，其主要就是让开发者可是在flask请求过程中定制一些用户行为 。
```

##### 2. 内置信号

```python
request_started = _signals.signal('request-started')                # 请求到来前执行
request_finished = _signals.signal('request-finished')              # 请求结束后执行
 
before_render_template = _signals.signal('before-render-template')  # 模板渲染前执行
template_rendered = _signals.signal('template-rendered')            # 模板渲染后执行
 
got_request_exception = _signals.signal('got-request-exception')    # 请求执行出现异常时执行
 
request_tearing_down = _signals.signal('request-tearing-down')      # 请求执行完毕后自动执行（无论成功与否）
appcontext_tearing_down = _signals.signal('appcontext-tearing-down')# 应用上下文执行完毕后自动执行（无论成功与否）
 
appcontext_pushed = _signals.signal('appcontext-pushed')            # 应用上下文push时执行
appcontext_popped = _signals.signal('appcontext-popped')            # 应用上下文pop时执行
message_flashed = _signals.signal('message-flashed')                # 调用flask在其中添加数据时，自动触发
```

##### 3. 使用信号

```python
from flask import Flask, signals, render_template

app = Flask(__name__)


# 往信号中注册函数
def func(*args, **kwargs):
    print('触发信号', args, kwargs)


signals.request_started.connect(func)


# 触发信号： signals.request_started.send()
@app.before_first_request
def before_first1(*args, **kwargs):
    print("before_first1")
    pass


@app.before_first_request
def before_first2(*args, **kwargs):
    print("before_first2")
    pass


@app.before_request
def before_first3(*args, **kwargs):
    print("before_request1")
    pass


@app.route('/', methods=['GET', "POST"])
def index():
    print('视图')
    # return render_template('index.html')
    return "hello world"


if __name__ == '__main__':
    app.run(port=8677)




```

```python
"""
执行结果

before_first1
before_first2
触发信号 (<Flask '信号'>,) {}
before_request1
视图
"""
```

##### 4. Flask中信号的触发点

```python
"""
1. before_first_request

2. 触发 request_started 信号

3. before_request

4. 模板渲染
	渲染前的信号 before_render_template.send(app, template=template, context=context)
		rv = template.render(context) # 模板渲染
	渲染后的信号 template_rendered.send(app, template=template, context=context)
	
5. after_request

6. session.save_session()

7. 触发 request_finished信号		
	如果上述过程出错：
		触发错误处理信号 got_request_exception.send(self, exception=e)
			
9. 触发信号 request_tearing_down
"""
```

##### 5. 自定义信号(了解)

```python
from flask import Flask
from flask.signals import _signals

app = Flask(import_name=__name__)

# 自定义信号
my_signal = _signals.signal('xxxxx')


def func(sender, *args, **kwargs):
    print(sender)


# 自定义信号中注册函数
my_signal.connect(func)


@app.route("/index")
def index():
    # 触发信号
    print("信号触发前")
    my_signal.send('123123', k1='v1')
    print("信号触发后")
    return 'Index'


if __name__ == '__main__':
    app.run(port=8555)

```

```python
"""
信号触发前
123123
信号触发后
"""
```

****

### STEP-4

#### 一. wtforms组件

##### 1. 安装

```python
"""
pip3 install wtforms
"""
```

##### 2. 作用

```
1. 和django中的forms组件基本类似，可以参考django使用
2. 主要作用：校验数据，渲染表单，错误信息
```

##### 3. 使用

```
1.前端传过来的数据，通过post或者get，或者body里面取出来，生成字典类型
2.将自定义的UserForms类实例化，同时将字典传入该类中，生成一个form的对象
3.执行form.validate()进行字段的校验
```

##### 4. 简单使用

###### 4.0 使用步骤

```python
"""
1. 首先定义一个Form类，继承Form
2. 定义需要校验的字段的验证规则
3. 在视图中如果是GET请求直接生成一个空的Form类的对象，如果是Post请求，先将传入的formdata数据传入到Form类中并实例化产生form对象，执行校验规则form.validate()
4. 如果校验通过，可以通过form.data中取出验证通过的数据
5. 如果没有通过，可以在form.errors中取出验证错误的信息
"""
```



###### 4.1 视图

```python
from flask import Flask, render_template, request
from wtforms import Form
from wtforms.fields import simple
from wtforms import validators
from wtforms import widgets

app = Flask(__name__, template_folder="templates")

app.debug = True


class LoginForm(Form):
    # 字段
    name = simple.StringField(
        label="用户名",
        # validators放所有的校验规则

        validators=[
            validators.DataRequired(message="用户名不能为空"),
            validators.Length(min=6, max=10, message="用户名长度必须大于%(min)d且小于%(max)d")

        ],

        # 页面中显示的插件，render_kw给TextInput渲染样式
        widget=widgets.TextInput(),
        render_kw={"class": "form-control"}
    )
    pwd = simple.PasswordField(
        label="密码",
        validators=[
            validators.DataRequired(message="密码不能为空"),
            validators.Length(min=6, message="密码长度必须大于%(min)d"),
            # validators.Regexp(
            #     regex="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,}",
            #     message="密码至少8个字符，至少1个大写字母，1个小写字母，1个数字和1个特殊字符"
            # )
        ],
        widget=widgets.PasswordInput(),
        render_kw={"class": "form-control"}
    )


@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "GET":
        form = LoginForm()
        return render_template("login.html", form=form)
    else:
        # request.form 前端post提交的数据
        form = LoginForm(formdata=request.form)

        # form.validate()是True代表验证通过
        if form.validate():
            print("用户提交校验通过的数据：", form.data)
            # {'name': 'sadfasdfa', 'pwd': 'sdafas'}
        else:
            print(form.errors)
            # {'name': ['用户名不能为空'], 'pwd': ['密码不能为空']}

            print(form.name.errors)
            # ['用户名不能为空']
        return render_template("login.html", form=form)


if __name__ == '__main__':
    app.run(port=8999)

```

###### 4.2 模板

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<h1>登录</h1>
<form method="post" novalidate="false">
    <p>{{form.name.label}} {{form.name}} {{form.name.errors[0] }}</p>

    <p>{{form.pwd.label}} {{form.pwd}} {{form.pwd.errors[0] }}</p>
    <input type="submit" value="提交">
</form>
</body>
</html>
```

###### 4.3 关闭html的form验证功能

```
<form method="post" novalidate="false">
```

****

##### 5. 复杂使用

###### 5.1 视图

```python
from flask import Flask, render_template, request
from wtforms import Form
from wtforms.fields import core
from wtforms.fields import html5
from wtforms.fields import simple
from wtforms import validators
from wtforms import widgets

app = Flask(__name__, template_folder="templates")
app.debug = True


class RegisterForm(Form):
    name = simple.StringField(
        label="用户名",
        validators=[
            validators.DataRequired(message="用户名不能为空"),
        ],
        widget=widgets.TextInput(),
        render_kw={"class": "form-control"},
        default="zhang"

    )

    pwd = simple.PasswordField(
        label="密码",
        validators=[
            validators.DataRequired(message="密码不能为空"),
        ],
        widget=widgets.PasswordInput(),
        render_kw={"class": "form-control"}

    )

    pwd_confirm = simple.PasswordField(
        label="请再次输入密码",
        validators=[
            validators.DataRequired(message="重复密码不能为空"),
            # 代替了之前的全局钩子
            validators.EqualTo("pwd", message="两次密码输入不一致")
        ],
        widget=widgets.PasswordInput(),
        render_kw={"class": "form-control"}
    )

    email = html5.EmailField(
        label="邮箱",
        validators=[
            validators.DataRequired(message="邮箱不能为空"),
            validators.Email(message="邮箱格式错误")
        ],
        widget=widgets.TextInput(),
        render_kw={"class": "form-control"}
    )

    gender = core.RadioField(
        label="性别",
        choices=(
            (1, "男"),
            (2, "女"),
        ),
        coerce=int
    )

    city = core.SelectField(
        label="城市",
        choices=(
            ("bj", "北京"),
            ("sh", "上海"),
        )
    )

    hobby = core.SelectMultipleField(
        label="爱好",
        choices=(
            (1, "篮球"),
            (2, "足球"),
        ),
        coerce=int
    )

    favor = core.SelectMultipleField(
        label="喜好",
        choices=(
            (1, "篮球"),
            (2, "足球"),
        ),
        widget=widgets.ListWidget(prefix_label=False),
        option_widget=widgets.CheckboxInput(),
        coerce=int,
        default=[1, 2]
    )

    def __init__(self, *args, **kwargs):
        super(RegisterForm, self).__init__(*args, **kwargs)
        # 保证数据实时更新
        self.favor.choices = ((1, '篮球'), (2, '足球'), (3, '羽毛球'))

    # 局部钩子
    def validate_pwd_confirm(self, field):
        """
        自定义pwd_confirm字段规则，例如：与pwd字段是否一致
        """
        # 最开始初始化时，self.data中已经有所有的值
        # field不是字符串的值，field.data取出字符串的值
        if field.data != self.data["pwd"]:
            aa = self.data["data_confirm"]
            # 继续后续验证
            # raise validators.ValidationError("密码不一致")
            # 不在继续后续的验证
            raise validators.StopValidation("密码不一致")


@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "GET":
        form = RegisterForm(data={"gender": 2, "hobby": [1, ]})
        return render_template("register.html", form=form)
    else:
        form = RegisterForm(formdata=request.form)
        if form.validate():
            print('用户提交数据通过格式验证，提交的值为：', form.data)
        else:
            print(form.errors)
        return render_template('register.html', form=form)


if __name__ == '__main__':
    app.run(port=8435)

```

###### 5.2 模板

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<h1>用户注册</h1>
<form method="post" novalidate style="padding:0  50px">
    {% for field in form %}
    <p>{{field.label}}: {{field}} {{field.errors[0] }}</p>
    {% endfor %}
    <input type="submit" value="提交">
</form>
</body>
</html>
```

****

#### 二. Python中的数据库连接池DBUtils

##### 1. 为什么要用数据库连接池

```python
1. 所有请求用同一个连接，会造成数据不安全

2. 所有请求用同一个连接，加锁，串行，保证数据安全，但是不能并发

3. 用请求连接池，每个请求独享一个线程，保证数据安全，也能支持并发
```

```python
"""
1. 如果每个请求过来，都需要创建一个数据库连接，如果同时并发了非常多的请求，则会对数据库造成压力

2. 如果全局使用一个数据库连接，通过加锁，保证了数据安全，但是导致无法支持并发。
"""
```

###### 1.1 每个请求开个连接

```
缺点：会对数据库造成压力，且无法保证数据安全。
```

```python
from flask import Flask, render_template, request, redirect
import pymysql

app = Flask(__name__, template_folder='templates')

app.debug = True
conn = pymysql.connect(host='127.0.0.1', port=3306, user='root', passwd='123', db='pymysql')
cursor = conn.cursor(cursor=pymysql.cursors.DictCursor)


@app.route('/login', methods=['GET', 'POST'])
def login():
    cursor.execute("select id,name from user where name=%s and pwd=%s", ['章成刚', '123', ])
    # cursor.execute("select id,name from users where name=%(user)s and pwd=%(pwd)s", {'user': 'lqz', 'pwd': '123'})
    obj = cursor.fetchone()
    conn.commit()
    cursor.close()
    conn.close()
    print(obj)
    return 'ok'


if __name__ == '__main__':
    app.run(port=8211)

"""
{'id': 1, 'name': '章成刚'}
"""

```

###### 1.2 加锁使用单个数据库连接对象

```
缺点：无法支持并发
```

```python
# 第二步：缺点，不能支持并发
    # pymysql.threadsafety
    # with LOCK:
    #     cursor = CONN.cursor()
    #     cursor.execute('select * from tb where id > %s', [5, ])
    #     result = cursor.fetchall()
    #     cursor.close()
    #
    #     print(result)
```

###### 1.3 结论

```python
由于上述原因，所以使用数据库连接池。每来一个请求从池中	取个连接，当连接取完过后，其他的请求在排队等待，当一个请求执行完毕后，将连接放回池中，供排队的请求使用
```

****

##### 2. 什么是DBUtils

```
DBUtils是Python的一个用于实现数据库连接池的模块
```

##### 3. DBUtils的2种模式

###### 3.1 模式一：PersistentDB

```
1. 提供线程专用的数据库连接，并自动管理连接。
2. 为每个线程创建一个连接，线程即使调用了close方法，也不会关闭，只是把连接重新放到连接池，供自己线程再次使用。当线程终止时，连接自动关闭
```

```python
from DBUtils.PersistentDB import PersistentDB
import pymysql

POOL = PersistentDB(
    creator=pymysql,  # 使用链接数据库的模块
    maxusage=None,  # 一个链接最多被重复使用的次数，None表示无限制
    setsession=[],  # 开始会话前执行的命令列表。
    ping=0,
    # ping MySQL服务端，检查是否服务可用。
    closeable=False,
    # 如果为False时， conn.close() 实际上被忽略，供下次使用，再线程关闭时，才会自动关闭链接。如果为True时， conn.close()则关闭链接，那么再次调用pool.connection时就会报错，因为已经真的关闭了连接（pool.steady_connection()可以获取一个新的链接）
    threadlocal=None,  # 本线程独享值得对象，用于保存链接对象，如果链接对象被重置
    host='127.0.0.1',
    port=3306,
    user='root',
    password='123',
    database='pymysql',
    charset='utf8'
)


def func():
    conn = POOL.connection(shareable=False)
    cursor = conn.cursor()
    cursor.execute('select * from user')
    result = cursor.fetchall()
    print(result)
    cursor.close()
    conn.close()


if __name__ == '__main__':
    func()

"""
((1, '章成刚', '123'),)
"""
```

****

###### 3.2 模式二：PooledDB

```
1. 提供线程间可共享的数据库连接，并自动管理连接。
2. 创建一批连接到连接池，供所有线程共享使用。
```

```python
import pymysql

from DBUtils.PooledDB import PooledDB

POOL = PooledDB(
    creator=pymysql,  # 使用链接数据库的模块
    maxconnections=6,  # 连接池允许的最大连接数，0和None表示不限制连接数
    mincached=2,  # 初始化时，链接池中至少创建的空闲的链接，0表示不创建
    maxcached=5,  # 链接池中最多闲置的链接，0和None不限制
    maxshared=3,
    # 链接池中最多共享的链接数量，0和None表示全部共享。PS: 无用，因为pymysql和MySQLdb等模块的 threadsafety都为1，所有值无论设置为多少，_maxcached永远为0，所以永远是所有链接都共享。
    blocking=True,  # 连接池中如果没有可用连接后，是否阻塞等待。True，等待；False，不等待然后报错
    maxusage=None,  # 一个链接最多被重复使用的次数，None表示无限制
    setsession=[],  # 开始会话前执行的命令列表。
    ping=0,
    # ping MySQL服务端，检查是否服务可用。
    host='127.0.0.1',
    port=3306,
    user='root',
    password='123',
    database='pymysql',
    charset='utf8'
)


def func():
    # 检测当前正在运行连接数的是否小于最大链接数，如果不小于则：等待或报raise TooManyConnections异常
    # 否则
    # 则优先去初始化时创建的链接中获取链接 SteadyDBConnection。
    # 然后将SteadyDBConnection对象封装到PooledDedicatedDBConnection中并返回。
    # 如果最开始创建的链接没有链接，则去创建一个SteadyDBConnection对象，再封装到PooledDedicatedDBConnection中并返回。
    # 一旦关闭链接后，连接就返回到连接池让后续线程继续使用。
    conn = POOL.connection()

    # print(th, '链接被拿走了', conn1._con)
    # print(th, '池子里目前有', pool._idle_cache, '\r\n')

    cursor = conn.cursor()
    cursor.execute('select * from user')
    result = cursor.fetchall()
    print(result)
    conn.close()


if __name__ == '__main__':
    func()

"""
((1, '章成刚', '123'),)
"""
```

****

#### 三. SQLAlchemy模块

##### 1. 什么是SQLAlchemy

```
SQLAlchemy是一个基于Python实现的ORM框架。该框架建立在 DB API之上，使用关系对象映射进行数据库操作，

简言之便是：将类和对象转换成SQL，然后使用数据API执行SQL并获取执行结果。 
```

##### 2. 安装

```
pip3 install sqlalchemy
```

##### 3. 组成

```python
"""
1. Engine，框架的引擎
2. Connection Pooling ，数据库连接池
3. Dialect，选择连接数据库的DB API种类
4. Schema/Types，架构和类型
5. SQL Exprression Language，SQL表达式语言
"""
```

##### 4. 注意

###### 4.1 SQLAlchemy本身无法操作数据库，其必须以来pymsql等第三方插件

###### 4.2 Dialect用于和数据API进行交流，根据配置文件的不同调用不同的数据库API，从而实现对数据库的操作

```python
"""
MySQL-Python
    mysql+mysqldb://<user>:<password>@<host>[:<port>]/<dbname>
    
pymysql
    mysql+pymysql://<username>:<password>@<host>/<dbname>[?<options>]
    
MySQL-Connector
    mysql+mysqlconnector://<user>:<password>@<host>[:<port>]/<dbname>
    
cx_Oracle
    oracle+cx_oracle://user:pass@host:port/dbname[?key=value&key=value...]
    
更多：http://docs.sqlalchemy.org/en/latest/dialects/index.html
"""
```

****

##### 5. 简单使用

###### 5.1 注意事项

```
1. 不能创建数据库

2. 不能修改字段(去数据库改,在类中对应上)

3. 只能创建表,删除表

4. 增,删,改一定要记住commit()
```

###### 5.2 执行原生sql（不常用）

```python
import time
import threading
import sqlalchemy
from sqlalchemy import create_engine
from sqlalchemy.engine.base import Engine

# 引擎对象,它是负责调度
engine = create_engine(
    # 用pymysql模块链接数据库,用户,密码,地址,端口,数据库名,字符编码
    "mysql+pymysql://root:123@127.0.0.1:3306/pymysql?charset=utf8",
    max_overflow=0,  # 超过连接池大小外最多创建的连接
    pool_size=5,  # 连接池大小
    pool_timeout=30,  # 池中没有线程最多等待的时间，否则报错
    pool_recycle=-1  # 多久之后对线程池中的线程进行一次连接的回收（重置）
)


def task(arg):
    # 从引擎对象中取出链接
    conn = engine.raw_connection()
    cursor = conn.cursor()
    cursor.execute(
        "select * from user"
    )
    result = cursor.fetchall()
    print(result)
    cursor.close()
    conn.close()


for i in range(20):
    t = threading.Thread(target=task, args=(i,))
    t.start()
"""
((1, '章成刚', '123'),)
((1, '章成刚', '123'),)
((1, '章成刚', '123'),)
((1, '章成刚', '123'),)
((1, '章成刚', '123'),)
((1, '章成刚', '123'),)
((1, '章成刚', '123'),)
((1, '章成刚', '123'),)
((1, '章成刚', '123'),)
((1, '章成刚', '123'),)
((1, '章成刚', '123'),)
((1, '章成刚', '123'),)
((1, '章成刚', '123'),)
((1, '章成刚', '123'),)
((1, '章成刚', '123'),)
((1, '章成刚', '123'),)
((1, '章成刚', '123'),)
((1, '章成刚', '123'),)
((1, '章成刚', '123'),)
((1, '章成刚', '123'),)
"""
```

****

###### 5.3 orm使用

> models.py

```python
import datetime
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String, Text, ForeignKey, DateTime, UniqueConstraint, Index

# 类似于django中model.Models,所有的类都要继承它
Base = declarative_base()


class Users(Base):
    __tablename__ = 'users'  # 数据库表名称
    id = Column(Integer, primary_key=True)  # id 主键
    name = Column(String(32), index=True, nullable=False)  # name列，索引，不可为空
    # email = Column(String(32), unique=True)
    # datetime.datetime.now不能加括号，加了括号，以后永远是当前时间
    # ctime = Column(DateTime, default=datetime.datetime.now)
    # extra = Column(Text, nullable=True)

    __table_args__ = (
        # UniqueConstraint('id', 'name', name='uix_id_name'), #联合唯一
        # Index('ix_id_name', 'name', 'email'), #索引
    )


def init_db():
    """
    根据类创建数据库表
    :return:
    """
    engine = create_engine(
        "mysql+pymysql://root:123@127.0.0.1:3306/pymysql?charset=utf8",
        max_overflow=0,  # 超过连接池大小外最多创建的连接
        pool_size=5,  # 连接池大小
        pool_timeout=30,  # 池中没有线程最多等待的时间，否则报错
        pool_recycle=-1  # 多久之后对线程池中的线程进行一次连接的回收（重置）
    )
    # 继承自base所有表的创建
    Base.metadata.create_all(engine)


def drop_db():
    """
    根据类删除数据库表
    :return:
    """
    engine = create_engine(
        "mysql+pymysql://root:123@127.0.0.1:3306/aaa?charset=utf8",
        max_overflow=0,  # 超过连接池大小外最多创建的连接
        pool_size=5,  # 连接池大小
        pool_timeout=30,  # 池中没有线程最多等待的时间，否则报错
        pool_recycle=-1  # 多久之后对线程池中的线程进行一次连接的回收（重置）
    )
    # 删除所有继承自base的表
    Base.metadata.drop_all(engine)


if __name__ == '__main__':
    # drop_db()
    init_db()

```

> app.py

```python
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine
# from models import Users
import models

engine = create_engine("mysql+pymysql://root:123@127.0.0.1:3306/pymysql?charset=utf8", max_overflow=0, pool_size=5)
Session = sessionmaker(bind=engine)

# 每次执行数据库操作时，都需要创建一个session
# 区别于原生sql的操作
session = Session()

# ############# 执行ORM操作 新增#############
# 生成一个对象
obj1 = models.Users(name="lqz")

# 新增一条记录
session.add(obj1)

# 提交事务
session.commit()
# 关闭session
session.close()

```

****

##### 6. 单表操作

> models.py

```python
import datetime
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String, Text, ForeignKey, DateTime

# 类似于django中model.Models,所有的类都要继承它
Base = declarative_base()


class Users(Base):
    __tablename__ = 'users'  # 数据库表名称
    id = Column(Integer, primary_key=True)  # id 主键
    name = Column(String(32), index=True, nullable=False)  # name列，索引，不可为空
    age = Column(String(32), nullable=False)

    __table_args__ = (
        # UniqueConstraint('id', 'name', name='uix_id_name'), #联合唯一
        # Index('ix_id_name', 'name', 'email'), #索引
    )


def init_db():
    """
    根据类创建数据库表
    :return:
    """
    engine = create_engine(
        "mysql+pymysql://root:123@127.0.0.1:3306/single_form?charset=utf8",
        max_overflow=0,  # 超过连接池大小外最多创建的连接
        pool_size=5,  # 连接池大小
        pool_timeout=30,  # 池中没有线程最多等待的时间，否则报错
        pool_recycle=-1  # 多久之后对线程池中的线程进行一次连接的回收（重置）
    )
    # 继承自base所有表的创建
    Base.metadata.create_all(engine)


def drop_db():
    """
    根据类删除数据库表
    :return:
    """
    engine = create_engine(
        "mysql+pymysql://root:123@127.0.0.1:3306/single_form?charset=utf8",
        max_overflow=0,  # 超过连接池大小外最多创建的连接
        pool_size=5,  # 连接池大小
        pool_timeout=30,  # 池中没有线程最多等待的时间，否则报错
        pool_recycle=-1  # 多久之后对线程池中的线程进行一次连接的回收（重置）
    )
    # 删除所有继承自base的表
    Base.metadata.drop_all(engine)


if __name__ == '__main__':
    # drop_db()
    init_db()

```

> app.py

```python
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine
# from models import Users
import models

engine = create_engine("mysql+pymysql://root:123@127.0.0.1:3306/single_form?charset=utf8", max_overflow=0, pool_size=5)
Session = sessionmaker(bind=engine)

# 每次执行数据库操作时，都需要创建一个session
# 区别于原生sql的操作
session = Session()

"""

.....写增删改查逻辑

"""

# 提交事务
session.commit()
# 关闭session
session.close()

```

###### 6.1 增

> **1.新增单条记录：add**

```python
"""
obj1 = models.Users(name="lqz", age="18")

session.add(obj1)
"""
```

> **2. 新增多条记录：add_all**

```python
"""
obj1 = models.Users(name="lqz", age="18")
obj2 = models.Users(name="zcg", age="19")

session.add_all([obj1, obj2])
"""
```

###### 6.2 改

> **1. 传字典：update**

```python
"""
1. 将age是19的人的名字改成zhang
session.query(models.Users).filter_by(age="19").update({"name": "zhang"})

2. 将id大于0的所有user的名字改成lqz
session.query(models.Users).filter(models.Users.id > 0).update({"name": "lqz"})
"""
```

> **2. 类似于django的F查询：update**

```python
"""
1. 将user的名字是zhang的人的名字改成名字+chenggang
session.query(models.Users).filter(models.Users.name == "zhang").update({models.Users.name: models.Users.name+"chenggang"},synchronize_session=False)

"""
```

###### 6.3 删

> **1. delete**

```python
"""
1. 删除user的id是3的人
session.query(models.Users).filter(models.Users.id == 3).delete()
"""
```

###### 6.4 查

> **1.查所有-all**

```python
"""
1. 查询User表中所有的记录
r1 = session.query(models.Users).all()

[<models.Users object at 0x000002BC3634AA20>, <models.Users object at 0x000002BC363835C0>]

# 只取name列，把name重命名为xx
r2 = session.query(models.Users.name.label('xx')).all()

[('lqz',), ('zhangchenggang',)]
"""
```

> **2. filter过滤查询-all**

```python
"""
1. 查询User名字是lqz的所有人
r3 = session.query(Users).filter(Users.name == "lqz").all()

[<models.Users object at 0x0000024AC9495AC8>]


"""
```

> **3. filter_by过滤查询-all**

```python
"""
1. 查询所有名字是lqz且id是1的人
r4 = session.query(Users).filter_by(name='lqz', id=1).all()

[<models.Users object at 0x000001C886B45B38>]
"""
```

> **4. filter和filter_by的区别**

```
filter传的是表达式，filter_by传的是参数
```

****

> **5. first查询**

```python
"""
1. 查出名字lqz的第一个记录
r5 = session.query(Users).filter_by(name='lqz').first()

<models.Users object at 0x000001947DD55BE0>
"""
```

> **6. params查询**

```python
"""
from sqlalchemy.sql import text

:value 和:name 相当于占位符，用params传参数

1.查询id小于3且name=lqz的所有的人，并按照id进行排序
r6 = session.query(Users).filter(text("id<:value and name=:name")).params(value=3, name='lqz').order_by(Users.id).all()
"""

```

> **7. 自定义查询sql**

```python
"""
1. 查询名字是zhangchenggang的所有人
r7 = session.query(Users).from_statement(text("SELECT * FROM users where name=:name")).params(name='zhangchenggang').all()

[<models.Users object at 0x0000027DEA943898>]
"""
```

****

##### 7. orm一对多关系

###### 7.1 关联字段写在多的地方

```python
import datetime
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String, Text, ForeignKey, DateTime
from sqlalchemy.orm import relationship

# 类似于django中model.Models,所有的类都要继承它
Base = declarative_base()


class Hobby(Base):
    __tablename__ = 'hobby'
    id = Column(Integer, primary_key=True)
    caption = Column(String(50), default='篮球')


class Person(Base):
    __tablename__ = 'person'
    nid = Column(Integer, primary_key=True)
    name = Column(String(32), index=True, nullable=True)
    # hobby指的是tablename而不是类名
    hobby_id = Column(Integer, ForeignKey("hobby.id"))

    # 跟数据库无关，不会新增字段，只用于快速链表操作
    # 类名，backref用于反向查询
    hobby = relationship('Hobby', backref='person')


def init_db():
    """
    根据类创建数据库表
    :return:
    """
    engine = create_engine(
        "mysql+pymysql://root:123@127.0.0.1:3306/single_form?charset=utf8",
        max_overflow=0,  # 超过连接池大小外最多创建的连接
        pool_size=5,  # 连接池大小
        pool_timeout=30,  # 池中没有线程最多等待的时间，否则报错
        pool_recycle=-1  # 多久之后对线程池中的线程进行一次连接的回收（重置）
    )
    # 继承自base所有表的创建
    Base.metadata.create_all(engine)


def drop_db():
    """
    根据类删除数据库表
    :return:
    """
    engine = create_engine(
        "mysql+pymysql://root:123@127.0.0.1:3306/single_form?charset=utf8",
        max_overflow=0,  # 超过连接池大小外最多创建的连接
        pool_size=5,  # 连接池大小
        pool_timeout=30,  # 池中没有线程最多等待的时间，否则报错
        pool_recycle=-1  # 多久之后对线程池中的线程进行一次连接的回收（重置）
    )
    # 删除所有继承自base的表
    Base.metadata.drop_all(engine)


if __name__ == '__main__':
    # drop_db()
    init_db()

```

##### 8. 多对多关系

```python

```

##### 9. 单表查询

```python
查询：********非常重要**********
1.all()取到表中所有记录放入列表中
r1 = session.query(models.Users).all()

2.filter() 相当于sql中的where，后面以表达式形式跟过滤条件
r3 = session.query(Users).filter(Users.name == "lqz").all()

3.first() 从查出的结果中取第一个记录
r5 = session.query(Users).filter_by(name='lqz').first()


ret = models.Book.objects.filter(name="水浒传", id=11)
print(ret) --取到名字是水浒传且id是1的queryset对象

4.get() 有且只有一个结果，返回的是表中的一条记录，不是queryset对象
r8 = session.query(models.Users).get(ident=1) --返回唯一的对象


5.order_by() 按指定字段排序，默认是asc，-号是desc
r9 = session.query(models.Users).order_by("age").all()

r9 = session.query(models.Users).order_by("-age").all()

r9 = session.query(models.Users).order_by("age","name").all() --可以传多个值


6.count() 查询结果的个数，是int类型
r9 = session.query(models.Users).count()


7.values(*field) 返回生成器对象

r9 = session.query(models.Users).filter_by(name="lqz").values("name")


8.distinct() 必须完全一样,才能去重   只要带了id,去重就没有意义了

r9 = session.query(models.Users.age).filter_by(name="lqz").distinct()

```



```python
查询：基于双下划线的模糊查询
1.大于gt >
ret = session.query(models.Users).filter(models.Users.id > 1).all()
print(ret)

2.小于lt <
ret = session.query(models.Users).filter(models.Users.age < 19).all()
print(ret)

3.大于等于gte >=
ret = session.query(models.Users).filter(models.Users.age >= 19).all()
print(ret)

4.小于等于lte <=
ret = session.query(models.Users).filter(models.Users.age <= 18).all()
print(ret)

5.在什么之中 in
ret = session.query(models.Users).filter(models.Users.age.in_([19,])).all()
print(ret)

6.在什么范围中 range = between and
ret = session.query(models.Users).filter(models.Users.age.between(19,20)).all()
print(ret)

7.查询在字段中是否包含某个字contains 首尾中全符合
ret = session.query(models.Users).filter(models.Users.name.contains("c")).all()
print(ret)


8.以什么开头startswith 
ret = session.query(models.Users).filter(models.Users.name.startswith("z")).all()
print(ret)

9.以什么结尾endswith 不能查询价格之类的字段
ret = session.query(models.Users).filter(models.Users.name.endswith("z")).all())
print(ret)

10.按年查询：year | month | day
from sqlalchemy import extract, and_

historys = History.query.filter(_and(
    extract('year', History.date) == 2016,
    extract('month', History.date) == 12
).all()
```

****

##### 10.常用操作:增删改

###### 10.1 插入数据

```python
Session = sessionmaker(bind=engine)  # 获取 Session类
ses = Session()  # 获取session对象

zhangsan = Student(name="zhangsan", gender=1, std_id='XS331', teacher='hanmeimei', math=90)
lisi = Student(name="lisi", gender=1, std_id='XS332', teacher='hanmeimei', math=10)
wangwu = Student(name="wangwu", gender=0, std_id='XS333', teacher='lilei', math=60)
zhaoliu = Student(name="zhaoliu", gender=0, std_id='XS337', teacher='lilei', math=80)

ses.add(zhangsan)  # 单条添加
ses.add_all([lisi, wangwu, zhaoliu])  # 批量添加
ses.commit()
```

###### 10.2 修改数据

```python
zhangsan = ses.query(Student).filter_by(name='zhangsan').first()  #先获取对象
zhangsan.math = 91  #更改对象的属性
ses.commit()   #提交
```

也可以在还创建数据的时候修改，就是在提交之前进行修改：

```python
liqi = Student(name="liqi", gender=1, std_id='XS335', teacher='xiadonghai', math=100)   #实例化一个对象
ses.add(liqi)  #添加对象，也可以视作添加一条数据
liqi = ses.query(Student).filter_by(name='liqi').first()
liqi.gender = 0
ses.commit()
```

在创建一个对象之后，未添加之前直接改变其属性。

```python
liqi = Student(name="liqi", gender=1, std_id='XS335', teacher='xiadonghai', math=100)
liqi.gender = 0
ses.add(liqi)
ses.commit()
```

除此之外还可以使用update。

```python
sess.query(Student).filter_by(name='liming').update({'gender':0})
sess.commit()
```

****

###### 10.3 删除数据

```python
result = sess.query(Student).filter(Student.id == 1 ).delete()
sess.commit()
result = sess.query(Student).filter(Student.id == 2 ).first()
sess.delete(result)
sess.commit()
```

****

##### 11. 常用操作：查

###### 11.1 算术操作符

```python
= 操作符
students_99 = sess.query(Student).filter_by(name ='zhangsan').all()
students_100 = sess.query(Student).filter(Student.name == 'zhangsan').all()
for i in students_100:
   print(i.name)

！= 操作符
student_101 = sess.query(Student).filter_by(name != 'liming').all()  # error
student_98 = sess.query(Student).filter(Student.name != 'liming').all()
for i in student_98:
  print(i.name)

 > ,<, <=, >=, 操作符
student_60 = sess.query(Student).filter(Student.math > 10).all()
student_61= sess.query(Student).filter_by(math>10).all()  # error
student_62 = sess.query(Student).filter(Student.math < 100).all()
student_63 = sess.query(Student).filter(Student.math <= 90).all()
student_64 = sess.query(Student).filter(Student.math >= 90).all()
student_64 = sess.query(Student).filter(Student.math <> 90).all()  # error
for i in student_60:
    print(i.math)
for i in student_62:
    print(i.math)
for i in student_63:
    print(i.math)
for i in student_64:
    print(i.math)
```

****

###### 11.2 模糊查询

```python
like 操作符  % 代表任意多个字符  _ 代表一个字符
student_17 = sess.query(Student).filter(Student.name.like("%i%")).all()
for i in student_17:
    print(i.name)
student_17_2 = sess.query(Student).filter(Student.name.like("%i_i")).all()
for i in student_17_2:
    print(i.name)

not like
student_70 = sess.query(Student).filter(~Student.name.like("%i_i")).all()
student_71 = sess.query(Student).filter(Student.name.notlike("%i_i")).all()
for i in student_70:
    print(i.name)
print(student_70 == student_71)
```

****

###### 11.3 区间选取

```python
in 操作符
student_18 = sess.query(Student).filter(Student.name.in_(['zhangsan','lisi','wangwu'])).all()
for i in student_18:
    print(i.name)
not in
student_19 = sess.query(Student).filter(~Student.name.in_(['lisi'])).all()
student_19_2 = sess.query(Student).filter(Student.name.notin_(['lisi'])).all()
for i in student_19:
    print(i.name)
print(student_19 == student_19_2)
```

****

###### 11.4 分页

```python
student_10 = sess.query(Student).limit(2).offset(1).all()  #从第几条开始选取几条
student_11 = sess.query(Student).offset(1).limit(2).all()
student_12 = sess.query(Student)[1:3]
for i in student_10:
    print(i.id)
for i in student_11:
    print(i.id)
for i in student_12:
    print(i.id)
```

****

###### 11.5 排序

```python

order_by 排序
student_33 = sess.query(Student).filter(text("math >= 10")).order_by(~text("math")).all()  # 逆序
student_33_2 = sess.query(Student).filter(text("math >= 10")).order_by(text("math")).all()  # 顺序
student_33_2_1 = sess.query(Student).filter(text("math >= 10")).order_by(desc(text("math"))).all()  # 逆序
student_33_3 = sess.query(Student).order_by(desc(Student.math)).all()  # 逆序
student_33_4 = sess.query(Student).order_by(Student.math.desc()).all()  # 逆序
student_33_5 = sess.query(Student).order_by(~Student.math).all()  # 逆序
student_33_6 = sess.query(Student).order_by(Student.math).all()  # 顺序

print(student_31)
print(student_32)
print("___"* 30)
for i in student_33:
    print(i.math)
print("___"* 30)
for i in student_33_2:
    print(i.math)
for i in student_33_3:
    print(i.math)
for i in student_33_4:
    print(i.math)
for i in student_33_5:
    print(i.math)
for i in student_33_6:
    print(i.math)
```

***

###### 11.6 分组

```python
group_by 分组

student_39 = sess.query(Student).group_by(Student.gender == 1).count()
print(student_39)
```

****

###### 11.7 having：分组之后条件过滤

```python
having

student_39_1 = sess.query(Student).group_by(Student.gender == 1).having(Student.math>60).all()
for i in student_39_1:
    print(i)
```

****

###### 11.8 计数

```python
count

student_38 = sess.query(Student).filter_by(gender=1).count()
student_38_2 = sess.query(func.count(Student.name),Student.name).group_by(Student.name).all()
student_38_3 = sess.query(func.count(Student.name),Student.gender).group_by(Student.gender).all()
print(student_38_2)
print(student_38_3)
```

****

###### 11.9 去重

```python
distinct

student_40 = sess.query(distinct(Student.name)).all()
for i in student_40:
    print(i)
```

****

###### 11.10 空值

```python
是否为null
student_20 = sess.query(Student).filter(Student.name != None).all()
student_21 = sess.query(Student).filter(~Student.name.is_(None)).all()
student_22 = sess.query(Student).filter(Student.name.isnot(None)).all()
student_21_3 = sess.query(Student).filter(Student.name.is_('zhangsan')).all()  # error
student_21_2 = sess.query(Student).filter(Student.name.is_(1)).all()
for i in student_20:
    print(i.name)
print(student_20 == student_21 == student_22)

student_23 = sess.query(Student).filter(Student.math.is_(90)).all()
student_24 = sess.query(Student).filter(Student.math == None).all()
```

****

###### 11.11 逻辑操作

```python
and
student_25 = sess.query(Student).filter(Student.gender == 1, Student.math > 70).all()
student_26 = sess.query(Student).filter(and_(Student.gender == 1, Student.math > 70)).all()  # 别忘了引入该方法
student_27 = sess.query(Student).filter(Student.gender == 1).filter(Student.math > 70).all()
for i in student_25:
    print(i.name)
print(student_25 == student_26 == student_27)

or
student_28 = sess.query(Student).filter(or_(Student.gender == 1, Student.math > 80)).all()
for i in student_28:
    print(i.name)
```

****

###### 11.12 text：原生sql语句

```python
text  原生sql条件语句
student_31 = sess.query(Student).filter(text("name='lisi'")).first()  # 注意值为字符串时的写法
student_32 = sess.query(Student).filter(text("id=1")).first()  # 注意值为 数字 的写法
student_31 = sess.query(Student).filter(text("id>1 and math>10")).all()
for i in student_31:
    print(i.name)

text 插入变量
student_34 =sess.query(Student).filter(text("gender=:sex and math>:score")).params(sex=1, score=1).all()
for i in student_34:
    print(i.name)

from_statement 原生sql语句
student_35 = sess.query(Student).from_statement(text("select * from students where id=:id")).params(id=1).one()
student_36 = sess.query(Student).from_statement("select * from students where math>:score").params(score=10).all()
student_36_1 = sess.query(Student).from_statement("select * from students where math>10").all()
print(student_35)
for i in student_36:
    print(i.name)
print(student_36 == student_36_1)
```

****

###### 11.13 使用别名

```python
student_7 = sess.query(Student.name.label('std_name')).all()
print(student_7)
for i in student_7:
    print(i.std_name)
    print(i[0])  # 第二种取值方式
    
student_8 = sess.query(Student.name).all()
print(student_8)
for i in student_8:
    print(i.name)
    print(i[0])
```

****

###### 11.14 取值

```python
根据主键获取对象
students_1 = sess.query(Student).get(1)
print(students_1

value指定要获取的字段 返回的是生成器
students_3  = sess.query(Student).value(Student.name)
print(students_3)

values 指定多个字段 返回的是生成器
students_3_2  = sess.query(Student).values(Student.id,Student.name)
print(students_3_2)
for i in students_3_2:
    print(i)


一次获取多个字段值
students_4 = sess.query(Student.name,Student.gender).all()
print(students_4)
for i in students_4:
    print(i)

后续添加的方式选择要得到的字段结果
students_5 = sess.query(Student.name).add_columns(Student.gender).all()
print(students_5)
student_6 = sess.query(Student).filter_by(name="王大麻子").one()
print(student_6)

错误用法
error_1 = sess.query(Student).filter_by(and_(Student.id == 1, Student.name == 'lisi')).first()
error_2 = sess.query(Student).filter_by(and_(id=1, name='lisi')).first()
error_3 = sess.query(Student).filter(and_(id=1, name='lisi')).first()

one 有且只有一个，否则报错
student_30 = sess.query(Student).filter(Student.id == 1).one()
print(student_30)
可以只有一个或者没有，不能为多个结果，否则报错
student_31 = sess.query(Student).filter(Student.id == 10).one_or_none()
print(student_31)

student_13 = sess.query(Student).filter_by(id=1).one_or_none()
student_14 = sess.query(Student).filter(Student.id == 1).one_or_none()
print(student_13)
print(student_14)
```

****

###### 11.15 chain链式调用

```python
student_15 = sess.query(Student).filter_by(gender=1).filter(Student.math>80).all()
# student_15_2 = sess.query(Student).filter_by(gender=1).filter_by(math>80).all()  # error
student_16 = sess.query(Student).filter(Student.gender == 1).filter(Student.math>80).all()
for i in student_15:
    print(i.name)
for i in student_16:
    print(i.name)
```

****

##### 12. 一对多的操作

```python
import time
import threading

from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String, ForeignKey, UniqueConstraint, Index
from sqlalchemy.orm import sessionmaker, relationship
from sqlalchemy import create_engine
from sqlalchemy.sql import text
from sqlalchemy.engine.result import ResultProxy
from db import Users, Hosts, Hobby, Person

engine = create_engine("mysql+pymysql://root:123@127.0.0.1:3306/s6?charset=utf8", max_overflow=0, pool_size=5)
Session = sessionmaker(bind=engine)
session = Session()
# 添加
"""
session.add_all([
    Hobby(caption='乒乓球'),
    Hobby(caption='羽毛球'),
    Person(name='张三', hobby_id=3),
    Person(name='李四', hobby_id=4),
])

person = Person(name='张九', hobby=Hobby(caption='姑娘'))
session.add(person)
#添加二
hb = Hobby(caption='人妖')
hb.pers = [Person(name='文飞'), Person(name='博雅')]
session.add(hb)

session.commit()
"""

# 使用relationship正向查询
"""
v = session.query(Person).first()
print(v.name)
print(v.hobby.caption)
"""

# 使用relationship反向查询
"""
v = session.query(Hobby).first()
print(v.caption)
print(v.pers)
"""
#方式一，自己链表
# person_list=session.query(models.Person.name,models.Hobby.caption).join(models.Hobby,isouter=True).all()
person_list=session.query(models.Person,models.Hobby).join(models.Hobby,isouter=True).all()
for row in person_list:
    # print(row.name,row.caption)
    print(row[0].name,row[1].caption)

#方式二：通过relationship

person_list=session.query(models.Person).all()
for row in person_list:
    print(row.name,row.hobby.caption)
#查询喜欢姑娘的所有人
obj=session.query(models.Hobby).filter(models.Hobby.id==1).first()
persons=obj.pers
print(persons)
session.close()
```

****

##### 13. 多对多的操作

```python
import time
import threading

from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String, ForeignKey, UniqueConstraint, Index
from sqlalchemy.orm import sessionmaker, relationship
from sqlalchemy import create_engine
from sqlalchemy.sql import text
from sqlalchemy.engine.result import ResultProxy
from db import Users, Hosts, Hobby, Person, Group, Server, Server2Group

engine = create_engine("mysql+pymysql://root:123@127.0.0.1:3306/s6?charset=utf8", max_overflow=0, pool_size=5)
Session = sessionmaker(bind=engine)
session = Session()
# 添加
"""
session.add_all([
    Server(hostname='c1.com'),
    Server(hostname='c2.com'),
    Group(name='A组'),
    Group(name='B组'),
])
session.commit()

s2g = Server2Group(server_id=1, group_id=1)
session.add(s2g)
session.commit()


gp = Group(name='C组')
gp.servers = [Server(hostname='c3.com'),Server(hostname='c4.com')]
session.add(gp)
session.commit()


ser = Server(hostname='c6.com')
ser.groups = [Group(name='F组'),Group(name='G组')]
session.add(ser)
session.commit()
"""


# 使用relationship正向查询
"""
v = session.query(Group).first()
print(v.name)
print(v.servers)
"""

# 使用relationship反向查询
"""
v = session.query(Server).first()
print(v.hostname)
print(v.groups)
"""


session.close()
```

****

##### 14. 其他不常用操作

```python
import time
import threading

from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String, ForeignKey, UniqueConstraint, Index
from sqlalchemy.orm import sessionmaker, relationship
from sqlalchemy import create_engine
from sqlalchemy.sql import text, func
from sqlalchemy.engine.result import ResultProxy
from db import Users, Hosts, Hobby, Person, Group, Server, Server2Group

engine = create_engine("mysql+pymysql://root:123@127.0.0.1:3306/s6?charset=utf8", max_overflow=0, pool_size=5)
Session = sessionmaker(bind=engine)
session = Session()

# 关联子查询:correlate(Group)表示跟Group表做关联，as_scalar相当于对该sql加括号，用于放在后面当子查询
subqry = session.query(func.count(Server.id).label("sid")).filter(Server.id == Group.id).correlate(Group).as_scalar()
result = session.query(Group.name, subqry)
"""
SELECT `group`.name AS group_name, (SELECT count(server.id) AS sid 
FROM server 
WHERE server.id = `group`.id) AS anon_1 
FROM `group`
"""
'''

select * from tb where id in [select id from xxx];

select id,
		name,
		#必须保证此次查询只有一个值
		(select max(id) from xxx) as mid
from tb

例如，第三个字段只能有一个值
id name  mid
1  lqz   1，2  不合理
2  egon   2


'''


# 原生SQL
"""
# 查询
cursor = session.execute('select * from users')
result = cursor.fetchall()

# 添加
cursor = session.execute('insert into users(name) values(:value)',params={"value":'wupeiqi'})
session.commit()
print(cursor.lastrowid)
"""

session.close()
```

****

#### 四. Flask-sqlalchemy

##### 1. 目录

```
D:.
│  create_table.py
│  requirements.txt
│  run.py
│  settings.py
│
│
├─sansa
  │  models.py
  │  __init__.py
  │
  ├─static
  ├─templates
  ├─views
     │  account.py
```

##### 2. __init__.py

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
from flask import Flask
# flask_sqlalchemy,SQLAlchemy
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

from .models import *
from .views import account


def create_app():
    app = Flask(__name__)
    app.config.from_object('settings.DevelopmentConfig')

    # 将db注册到app中
    db.init_app(app)

    # 注册蓝图
    app.register_blueprint(account.account)

    return app

```

##### 3. models.py

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
from . import db


class Users(db.Model):
    """
    用户表
    """
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)

    def __repr__(self):
        return '<User %r>' % self.username

```

##### 4. settings.py

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-

class BaseConfig(object):
    # SESSION_TYPE = 'redis'  # session类型为redis
    # SESSION_KEY_PREFIX = 'session:'  # 保存到session中的值的前缀
    # SESSION_PERMANENT = True  # 如果设置为False，则关闭浏览器session就失效。
    # SESSION_USE_SIGNER = False  # 是否对发送到浏览器上 session:cookie值进行加密

    SQLALCHEMY_DATABASE_URI = "mysql+pymysql://root:123@127.0.0.1:3306/tmd?charset=utf8"
    SQLALCHEMY_POOL_SIZE = 5
    SQLALCHEMY_POOL_TIMEOUT = 30
    SQLALCHEMY_POOL_RECYCLE = -1

    # 追踪对象的修改并且发送信号
    # SQLALCHEMY_TRACK_MODIFICATIONS = False


class ProductionConfig(BaseConfig):
    pass


class DevelopmentConfig(BaseConfig):
    pass


class TestingConfig(BaseConfig):
    pass

```

##### 5. create_table.py

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
from sansa import create_app
from sansa import db

app = create_app()

with app.app_context():
    db.create_all()

```

##### 6. account.py

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-

from flask import Blueprint
from .. import db
from .. import models

account = Blueprint('account', __name__)


@account.route('/login')
def login():
    db.session.add(models.Users(username='lqz', email='123'))
    db.session.commit()
    # 添加示例
    """
    db.session.add(models.Users(username='lqz', pwd='123', gender=1))
    db.session.commit()

    obj = db.session.query(models.Users).filter(models.Users.id == 1).first()
    print(obj)

    PS: db.session和db.create_session
    """
    # db.session.add(models.Users(username='wupeiqi1', email='wupeiqi1@xx.com'))
    # db.session.commit()
    # db.session.close()
    #
    # db.session.add(models.Users(username='wupeiqi2', email='wupeiqi2@xx.com'))
    # db.session.commit()
    # db.session.close()
    # db.session.add(models.Users(username='alex1',email='alex1@live.com'))
    # db.session.commit()
    # db.session.close()

    user_list = db.session.query(models.Users).all()
    db.session.close()
    for item in user_list:
        print(item.username)

    return 'login'

```

##### 7. run.py

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
"""
生成依赖文件：
    pipreqs ./

"""
from sansa import create_app

app = create_app()

if __name__ == '__main__':
    app.run()

```
