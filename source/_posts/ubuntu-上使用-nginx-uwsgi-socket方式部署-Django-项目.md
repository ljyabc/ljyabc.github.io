---
title: ubuntu 上使用 nginx + uwsgi socket方式部署 Django 项目
tags: [django项目]
date: 2019-04-01 13:33:39
categories: 配置
photos:
book:
---

# ubuntu 上使用 nginx + uwsgi socket方式部署 Django 项目

## 1 在开发服务器上测试

运行开发服务器测试，确保开发服务器下能正常打开网站。

```
cd 项目目录
python manage.py runserver
```

## 2 安装 nginx 和 需要的包

```
sudo apt-get install python-dev nginx
```

## 3 使用 uwsgi 部署

安装 uwsgi

```
sudo pip install uwsgi --upgrade
```

使用 uwsgi 运行项目

```
uwsgi --http :8001 --chdir /path/to/project --home=/path/to/env --module project.wsgi
```

这样就可以运行了，--home 指定virtualenv 路径，如果没有可以去掉。project.wsgi 指的是 project/wsgi.py 文件

注意：如果提示端口被占用了，我们可以先查出端口对应的进程号，然后杀掉进程

```
lsof -i :8001    # 根据端口后进行查询 查询结果中的PID就是进程号,如果相关进程有多个，那就杀多个
```

```
sudo kill -9 进程号   #根据进程号杀死进程
```

## 4 使用supervisor来管理进程

安装 supervisor 软件包

```
(sudo) pip install supervisor
```

生成 supervisor 默认配置文件，比如我们放在 /etc/supervisord.conf 路径中：

```
(sudo) echo_supervisord_conf > /etc/supervisord.conf
```

打开 supervisor.conf 在最底部添加（每一行前面不要有空格，防止报错）：

```
[program:fmxm]
command=/path/to/uwsgi --http :8003 --chdir /path/to/fuxm --module fmxm.wsgi
directory=/path/to/fmxm
startsecs=0
stopwaitsecs=0
autostart=true
autorestart=true
```

command 中写上对应的命令，这样，就可以用 supervisor 来管理了。

启动 supervisor

```
(sudo) supervisord -c /etc/supervisord.conf
```

重启项目：

```
(sudo) supervisorctl -c /etc/supervisord.conf restart fmxm
```

启动，停止，或重启 supervisor 管理的某个程序 或 所有程序：

```
(sudo) supervisorctl -c /etc/supervisord.conf [start|stop|restart] [program-name|all]
```

以 uwsgi 为例，上面这样使用一行命令太长了，我们使用 ini 配置文件来搞定，比如项目在 /home/tu/fmxm 这个位置，

在其中新建一个 uwsgi.ini 全路径为 /home/tu/fmxm/uwsgi.ini

```
[uwsgi]
socket = /home/tu/fmxm/fmxm.sock
chdir = /home/tu/fmxm
wsgi-file = fmxm/wsgi.py
touch-reload = /home/tu/fmxm/reload
 
processes = 2
threads = 4
 
chmod-socket = 664
chown-socket = tu:www-data
 
vacuum = true
```

注意上面的 /home/tu/fmxm/fmxm.sock ，一会儿我们把它和 nginx 关联起来。

在项目上新建一个空白的 reload 文件，只要 touch 一下这个文件（touch reload) 项目就会重启。

注意：不建议把 sock 文件放在 /tmp 下，比如 /tmp/xxx.sock (不建议)！有
些系统的临时文件是 namespaced 的，进程只能看到自己的临时文件，导致 nginx 找不到 uwsgi 的 socket 文件，访问时显示502，nginx 的 access log 中显示 unix: /tmp/xxx.sock failed (2: No such file or directory)，所以部署的时候建议用其它目录来放 socket 文件，比如放在运行nginx用户目录中，也可以专门弄一个目录来存放 sock 文件，比如 /tmp2/

```
sudo mkdir -p /tmp2/ && sudo chmod 777 /tmp2/  #然后可以用 /tmp2/fmxm.sock 这样的路径了
```

修改 supervisor 配置文件中的 command 一行：

```
[program:fmxm]
command=/path/to/uwsgi --ini /home/tu/fmxm/uwsgi.ini
directory=/path/to/fmxm
startsecs=0
```

然后重启一下 supervisor：

```
(sudo) supervisorctl -c /etc/supervisord.conf restart fmxm
或者
(sudo) supervisorctl -c /etc/supervisord.conf restart all
```

## 5 配置 Nginx

新建一个配置文件

```
sudo vim /etc/nginx/sites-available/fmxm.conf
```

写入以下内容

```
server {
    listen      80;
    server_name www.ziqiangxuetang.com;
    charset     utf-8;
 
    client_max_body_size 75M;
 
    location /media  {
        alias /path/to/project/media;
    }
 
    location /static {
        alias /path/to/project/static;
    }
 
    location / {
        uwsgi_pass  unix:///home/tu/fmxm/fmxm.sock;
        include     /etc/nginx/uwsgi_params;
    }
}
```

激活网站

```
sudo ln -s /etc/nginx/sites-available/fmxm.conf /etc/nginx/sites-enabled/fmxm.conf
```

测试配置语法

```
sudo service nginx configtest 或 /path/to/nginx -t
```

重启 nginx 服务器：

```
sudo service nginx reload 或 sudo service nginx restart 或 /path/to/nginx -s reload
```