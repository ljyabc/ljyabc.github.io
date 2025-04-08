---
title: nginxlinux班
tags: [代理服务]
date: 2019-03-07 23:29:59
categories: 记忆
photos:
---

# 一

## 1.用户输入URL--->

> 浏览器跳转-->浏览器缓存-->DNS域名解析-->tcp三次握手-->http请求-->http响应-->tcp四次挥手
> 		http请求
> 			方法：GET 请求
> 			协议：http://     http1.0短连接   http1.1长连接
> 			域名：www.oldboyedu.com
> 			端口：http 80    https 443
> 			路径：/index.php
> 			参数：?user=123&pwd=456
> 			header：（类型、长连接、压缩、语言、浏览器缓存）
> 			空行
> 		http响应：
> 			状态码：
> 				200 304  301  302  401  403  404 500 502 503 504 
> 			协议：http1.1
> 			响应主体

### 开源的web服务器（静态资源）

​	nginx
	apache
	IIS
	lighttpd
	tengine
	openresty

### 动态：

> Tomcat

### Nginx安装

yum方式（官方）

[root@web01 ~]# vim /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/$basearch/
gpgcheck=0
enabled=1

[root@web01 ~]# yum install nginx -y

### #查看版本

[root@web01 ~]# nginx -v
nginx version: nginx/1.14.2

源码编译安装

[root@web01 ~]# wget http://nginx.org/download/nginx-1.14.2.tar.gz
[root@web01 ~]# tar xf nginx-1.14.2.tar.gz
[root@web01 ~]# cd nginx-1.14.2/
[root@web01 nginx-1.14.2]# ./configure --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib64/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-compat --with-file-aio --with-threads --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-stream --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-cc-opt='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -m64 -mtune=generic -fPIC' --with-ld-opt='-Wl,-z,relro -Wl,-z,now -pie'
[root@web01 nginx-1.14.2]# make && make install

### 目录结构

#### 启动Nginx

​			先关闭之前已启动的httpd服务
[root@web01 ~]# systemctl stop httpd
[root@web01 ~]# systemctl disable httpd

			然后启动Nginx服务
[root@web01 ~]# systemctl enable nginx
[root@web01 ~]# systemctl start nginx

#### 启动方式有两种：

​	nginx  启动
	nginx -s stop 停止
	nginx -s reload |restart 重载服务

	systemctl start nginx
	systemctl restart nginx
	systemctl stop nginx 



#### nginx配置文件

[root@web01 ~]# cat /etc/nginx/nginx.conf
---------------核心模块
user  nginx;									#nginx进程运行的用户
worker_processes  1;							#nginx工作的进程数量
error_log  /var/log/nginx/error.log warn;		#nginx的错误日志【警告及其警告以上的都记录】

pid        /var/run/nginx.pid;					#nginx进程运行后的进程id

---------------事件模块
events {
    worker_connections  1024;					#一个work进程的最大连接数
	use epool;									#使用epool网络模型

}




---------------http核心层模块
http {
    include       /etc/nginx/mime.types;				#包含资源类型文件
    default_type  application/octet-stream;				#默认以下载方式传输给浏览器（前提是该资源在mime.types中无法找到）

	日志格式定义
	log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
	                  '$status $body_bytes_sent "$http_referer" '
	                  '"$http_user_agent" "$http_x_forwarded_for"';
	
	access_log  /var/log/nginx/access.log  main;		#访问日志
	
	sendfile        on;		
	#tcp_nopush     on;
	keepalive_timeout  65;		#长连接超时时间
	#gzip  on;					#是否开启压缩功能
	
	include /etc/nginx/conf.d/*.conf;		#包含哪个目录下面的*.conf文件
	
	server {  定义一个网站
		listen       80;			#监听端口
		server_name  localhost;		#域名
	
		#charset koi8-r;			#字符集
	
		location / {	 			#位置
			root   /usr/share/nginx/html;	#代码的主文件位置
			index  index.html index.htm;	#服务端默认返回给用户的文件
		}
		location /test {	 			#位置
			root   /code/test/123/;	#代码的主文件位置
			index  index.html index.htm;	#服务端默认返回给用户的文件
		}
	}

http server location扩展了解项
http{}层下允许有多个Server{}层，一个Server{}层下又允许有多个Location
http{} 标签主要用来解决用户的请求与响应。
server{} 标签主要用来响应具体的某一个网站。
location{} 标签主要用于匹配网站具体URL路径。


Nginx搭建一个静态资源web服务器

1.编写Nginx配置文件
[root@web01 conf.d]# cat game.conf
server {
	listen 80;
	server_name game.oldboy.com;

	location / {
		root /code;
		index index.html;
	}
}

2.根据配置文件，创建目录，上传代码
[root@web01 ~]# mkdir /code
[root@web01 ~]# cd /code
[root@web01 ~]# rz html5.zip
[root@web01 code]# unzip html5.zip 

3.重载nginx服务
[root@web01 code]# systemctl restart nginx		#立即重启
[root@web01 code]# systemctl reload nginx		#平滑重启

4.配置域名解析
Windows:  C:\Windows\System32\drivers\etc
				10.0.0.7      game.oldboy.com
Mac   sudo vim /etc/hosts
				10.0.0.7      game.oldboy.com
				
C:\Users\Administrator>ping game.oldboy.com			#检查解析的是否是10.0.0.7
正在 Ping game.oldboy.com [10.0.0.7] 具有 32 字节的数据:
来自 10.0.0.7 的回复: 字节=32 时间=9ms TTL=64
来自 10.0.0.7 的回复: 字节=32 时间<1ms TTL=64
来自 10.0.0.7 的回复: 字节=32 时间<1ms TTL=64
来自 10.0.0.7 的回复: 字节=32 时间<1ms TTL=64
	
​	
5.通过浏览器访问对应的项目
		game.oldboy.com
	
	root  /code
	index index.html index.htm;


​	
http://game.oldboy.com/game/duxinshu/index.html    用户请求的路径

实际上服务器查找的路径		/code/game/duxinshu/index.html

http://game.oldboy.com/game/yyncl/
code/game/yyncl/index.html


nginx虚拟主机

Nginx配置虚拟主机有如下三种方式：
方式一、基于主机多IP方式

1.配置多网卡多IP的方式
[root@web01 conf.d]# cat ip.conf 
server {
	listen 10.0.0.7:80;
	server_name _;

	location / {
		root /code_ip_eth0;
		index index.html;
	}
}

server {
	listen 172.16.1.7:80;
	server_name _;

	location / {
		root /code_ip_eth1;
		index index.html;
	}
}

2.根据配置创建目录
[root@web01 conf.d]# mkdir /code_ip_eth0
[root@web01 conf.d]# echo "Eth0" > /code_ip_eth0/index.html

[root@web01 conf.d]# mkdir /code_ip_eth1
[root@web01 conf.d]# echo "Eth1" > /code_ip_eth1/index.html

3.重启nginx服务
[root@web01 conf.d]# systemctl restart nginx

4.使用curl命令测试
[root@web01 ~]# curl 172.16.1.7
Eth1
[root@web01 ~]# curl 10.0.0.7
Eth0



方式二、基于端口的配置方式

1.配置多端口的虚拟主机
[root@web01 conf.d]# vim port.conf
server {
        listen 81;
        
        location / { 
                root /code_81;
                index index.html;
        }
}
server {
        listen 82;
        
        location / { 
                root /code_82;
                index index.html;
        }
}		

2.根据配置文件创建所需的目录
[root@web01 conf.d]# mkdir /code_8{1..2}
[root@web01 conf.d]# echo "81" > /code_81/index.html
[root@web01 conf.d]# echo "82" > /code_82/index.html

3.检查语法并重启服务
[root@web01 conf.d]# nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
[root@web01 conf.d]# systemctl restart nginx


4.如何去访问
	http://10.0.0.7:82/


方式三、基于多个hosts名称方式(多域名方式)
1.准备多虚拟主机配置文件
[root@web01 conf.d]# cat test1.oldboy.com.conf 
server {
	listen 80;
	server_name test1.oldboy.com;

	location / {
		root /code/test1;
		index index.html;
	}
}

[root@web01 conf.d]# cat test2.oldboy.com.conf 
server {
	listen 80;
	server_name test2.oldboy.com;

	location / {
		root /code/test2;
		index index.html;
	}
}

2.根据配置文件创建对应的目录
[root@web01 conf.d]# mkdir /code/test{1..2} -p
[root@web01 conf.d]# echo "test1_server" > /code/test1/index.html
[root@web01 conf.d]# echo "test2_server" > /code/test2/index.html
[root@web01 conf.d]# nginx -t
[root@web01 conf.d]# systemctl restart nginx

3.配置域名解析
10.0.0.7      test1.oldboy.com
10.0.0.7      test2.oldboy.com

4.通过浏览器访问该网站

nginx自查
	1.修改完配置记得使用 nginx -t 检查语法
	2.如果没有检查语法，直接重载导致报错。systemctl status nginx -l 查看错误信息

nginx日志
	访问日志：

server {
    listen 80;
    server_name code.oldboy.com;
    
    #将当前的server网站的访问日志记录至对应的目录，使用main格式
    access_log /var/log/nginx/code.oldboy.com.log main;
    location / {
        root /code;
    }
    
    #当有人请求改favicon.ico时，不记录日志
    location /favicon.ico {
        access_log off;
        return 200;
    }
}

错误日志
	tail -f /var/log/nginx/error.log

--------------------------------------------------------------
nginx
	安装
		yum
		编译
	配置
		目录结构
		配置文件
			核心层
			事件层
			http层
	启动
		启动与停止两种方式
			nginx
			systemctl
	搭建静态游戏网页
	
	nginx虚拟主机
		多IP的虚拟主机
		多端口虚拟主机   
		多域名虚拟主机
	
	nginx排错(服务无法启动时需要使用到的命令)
		nginx -t
		systemctl status nginx -l
	
	nginx日志（网站访问异常，需要提取日志进行分析）
		log_format 定义日志变量
		access_log  定义 
		access_log off
		日志的作用域  
		errror_log


