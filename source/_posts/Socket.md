---
title: Socket
tags: [网络编程]
date: 2019-03-17 21:44:10
categories: 理解
photos:
book:
---

# 网络通信标准---网络协议

### 互联网协议--osi七层协议

五层协议：应用层：应用层、表示层、会话层
          传输层：传输层
   	 网络层：网络层
   	 数据链路层：数据链路层
    	物理层：物理层
物理层就是用来发送电信号的
数据链路层跑协议，分组标准。 ethernet以太网协议，规定电信号如何分组
电信号拿来后是一堆数据，只要规定了怎么分组才能拿到正确数据

### ethernet规定

一组电信号构成一个数据报，叫做帧
每一数据帧分成：报头head和数据data两部分
但凡接入互联网必须要有网卡
每个网卡出厂都有自己的MAC地址   前六位厂商地址后几位自己地址
MAC是全世界独一无二的
以通讯角度来说，以太网协议有物理层和数据链路层已经可以实现通讯了
以太网有广播的工作方式
广播包只能在局域网里面传，要不数据量太大会造成网络的故障
网络层---ip协议  ipv4/ipv6
ip数据包也分成head和data部分 ip头的意思和以太网差不多
ip地址和ip子网掩码中间的运算得出一个地址，是网段地址
按位与运算   两个同时是1才是1  二进制的ip地址和子网掩码进行计算
按照这个网段地址找到范围，然后再找到这个机器
ipv4/ipv6网关是用来帮助跨过子网的关口
跨子网，要用网关和网关进行通讯
用以太网的广播方式将数据交给网关，但是得先获得网关的MAC地址
但是我们知道的只有网关的IP地址
所以需要ARP协议，局域网内，用IP地址解析成MAC地址。这样用网关的IP地址获取MAC地址
才能将数据交给网关
如果发送端主机发送了目标MAC地址为FF.FF.FF.FF.FF.FF那么它就知道发送端需要获取MAC
但是接受数据的主机不知道是不是向它要MAC地址，所以还需要发送一个IP地址，让他知道是自己需要的
ARP协议里面的
同一子网地址内都用以太网的广播方式
IP地址和MAC地址可以确定一个机器在什么位置

\-------------------------------------------------------------------------------------------------------------------------------------------

传输层跑两种协议：tcp协议和udp协议得到端口    确定要传输的是这个机器的哪个软件
ip加端口确定了全世界独一无二的软件
软件用机器的哪个端口，65536个端口前1024是操作系统用，后面全是自己的软件用
应用层：httpp ftp mai  协议   可以自己定协议
数据前一般都要加头  然后是数据
DHCP ：自动分配IP地址
DNS：域名服务   将网址域名地址解析成IP地址

### tcp协议

建立双向连接，用来进行数据的交互相互发送。
工作方式：c传给s一个请求，然后s再发送一个确认和一个请求，然后c再发送一个确认
所以一共发送了三次，三次握手
为了确认是否以我发送的那个数据，你俩进行回应，所以我的数据要加一个序列
如果你发送回来的时候我的序列+1证明是用我的数据进行回应
tcp协议又称为可靠协议，发送完包一定要等待对方确认收到了我的包进行了回应，才算发成功
如果没有回应过一段时间再发一次，所以是可靠协议。
可靠在发送完数据并不清空内存，直到对方回应确认收到后才收到
udp协议不用建立连接，被称为不可靠协议，发送完数据就清空内存，不等对方的确认信息。
tcp有断开连接，udp没有
谁最后确认数据收到谁先断，四次挥手断链接

# socket编程

## 应用层与运输层之间多了一个socket抽象层

将传输协议都封装好直接用
基于应用层与传输层之间的抽象层
用基于网络的套接字：AF——INET
服务器端：先初始化socket()，然后与端口绑定bind()服务端的固定地址，对端口进行监听listen()看谁来链接了
accept()阻塞直到有客户端链接  和connect()组成一队进行链接

```python
import socket
socket.socket(socket.AF_INET,socket.SOCK_STREAM)
服务端：
import socket
#买手机
phone=socket.socket(socket.AF_INET,socket.SOCK_STREAM)   打开了这个服务端最后要关闭
#绑定手机卡
phone.bind(('127.0.0.1',8080))#127.0.0.1指的就是自己这台机器的IP地址
#开机
phone.listen(5)#5代表最大挂起的链接数
#等电话链接
conn,addr=phone.accept()       等待建立链接accept()等待建立
print('客户端IP：%s，客户端端口：%s'%(addr[0],addr[1]))
data=conn.recv(1024)  #最大收1024       recv()接受数据，括号内最大接收量
print(data.decode('utf-8'))
conn.send(data.upper())      send()发送数据
#6、挂电话
conn.close()           建立的链接要关闭
#7.关机
phone.close()

客户端：
import socket
#买手机
phone=socket.socket(socket.AF_INET,socket.SOCK_STREAM)  一样打开这个端口
#绑定手机卡   客户端没必要绑定所以不用了
#开机  也不用监听了

phone.connect(('127.0.0.1',8080))    主动建立链接，前面IP地址后面是端口
phone.send('hello'.encode('utf-8'))  发送数据

data=phone.recv(1024)
print(data.decode('utf-8'))
#关机
phone.close()          #同样要关机
```

持续性数据的交互，还有排队的进行链接：
服务端：

```python
import socket
#买手机
phone=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
#绑定手机卡
phone.setsockopt(socket.SOL_SOCKET,socket.SO_REUSEADDR,1)
phone.bind(('192.168.11.52',8080))#127.0.0.1指的就是自己这台机器的IP地址
#开机
phone.listen(5)#5代表最大挂起的链接数
#等电话链接
print('starting...')
while True:   #链接循环
    conn,addr=phone.accept()
    print('客户端IP：%s，客户端端口：%s'%(addr[0],addr[1]))
    while True:            #通信循环
        try:                  #用到try是因为有时候会发生但无法预知的错误
            data=conn.recv(1024)  #最大收1024
            if not data:break  #针对linux
            print(data.decode('utf-8'))
            conn.send(data.upper())
        except ConnectionResetError:
            break
#6、挂电话
        conn.close()       #断开连接
#7.关机
phone.close()

客户端：

import socket
#买手机
phone=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
#绑定手机卡   客户端没必要绑定所以不用了
#开机  也不用监听了
#等电话链接
phone.connect(('192.168.11.52',8080))
while True:
    msg=input('请输入：').strip()
    phone.send(msg.encode('utf-8'))
    data=phone.recv(1024)
    print(data.decode('utf-8'))
#关机
phone.close()

#客户端向服务端发送空消息的话   服务端的接收会卡住 
```

# 主机命令执行 

```python
import os
os.system()#执行系统命令
#只能执行命令不能返回值
import subprocess # 能执行系统命令
res=subprocess.Popen('dir',shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE) #第一个参数是执行命令的字符串形式，第二个是shell=True代表使用命令解释器
#PIPE是subprocess提供的一个功能，管道。可以让结果不打印存在管道里面
print(res.stdout.read().decode('gbk'))#用stdout正确输出管道，read管道里面的数据
```

**windows里面是gbk格式的所以要转gbk** **stderr是错误的结果 stdout是正确的结果** **如果想让用户错误和正确的结果都可以看见的话要建立两个管道一个正确的一个错误的** **命令正确的话就进入正确管道stdout拿取结果** **如果命令错误的话就进入错误的管道stderr拿取结果** **命令中如何使用管道：** **要查看windows中都开了哪些任务命令：tasklist** **如果想看看是不是运行了pycharm或者别的程序：findstr pycharm** **程序中：tasklist ! findstr pycharm     感叹号就是管道**  **有管道tasklist会将结果暂存在管道中，然后由findstr pycharm来循环判断** **还有一种管道：** 

```python
import subprocess
subprocess.Popen('dir',shell=True,stdin=subprocess.PIPE)#也是一个管道
```

**如果在输入命令时最大recv是1024  像tasklist之类的命令数据太多，如果取出数据大于1024**
**那么管道内的数据无法完全取出。接下来再输入命令取出的管道内的数据还是之前命令的那样命令就会乱**
**SOCK_STREAM流式协议就是TCP协议**
**TCP使用了nagle算法，将多次间隔较小且数据量小的数据，合并成一个大数据发出去**
**所以会有粘包现象，所以上面取出数据，是因为粘包了分不清谁是谁。**
**socket里面推荐使用 from socket import \***
**粘包现象发送端和服务端都会粘包**
**服务端接收的少了剩下的会留在那粘包，下次再继续接受**
**客户端发送的太多了也会粘包。**
**发送数据长所以要把长度发在前面，关键点在于recv收的量，高速长度就可以解决接受的问题**
**但是一次传进来的太大，大过了系统内存就无法存了，所以需要一次一次边传数据边写数据，循环接受**
**下载文件就是打开文件将文件数据传给接收端再写新文件写入的过程**

**先收报头，固定报头的bytes 然后确定长度**
**得让接收端知道多少的bytes是我的报头没所以报头固定长度。**
**要用到struct模块**
**struct.pack('i',123456),括号内i是整型，将后面整型的数据打包成一个bytes格式**
**固定长度是4所以可以用这个模块固定报头的长度**
**struct.unpack('i',收到的) 解包，将打包时候的数据接收了解包出来。取出来是个元祖**
**第一个数据就是打包的所以索引0直接取**

**因为struct.pack  的i格式打包不了  报头要传的数据很多**
**所以要用字典的方法来打包报头**