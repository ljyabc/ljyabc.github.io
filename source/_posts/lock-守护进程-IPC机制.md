---
title: lock/守护进程/IPC机制
tags: [并发编程]
date: 2019-03-18 16:24:09
categories: 理解
photos:
book:
---

Lock/守护

### 守护进程

看主程序是否还在执行
最后回收进程
如果最后一行主程序代码执行完还没有执行，那就直接被干死
同步锁/互斥锁：

### LOCK 模块

锁住一部分并行
一部分串行
lock=Lock()
在args里面将lock传进去
lock.acquire()来枷锁 加锁
中间是要执行这段程序，别人等待开锁再进行
lock.release()来解放锁  开锁
速度慢但是牺牲速度保证安全问题
效率低
需要自己加锁处理

# IPC机制

进程之间通信
共享带来竞争
要找共享的内存空间
对应两种：

### 1.队列

```
form multiprocessing import Queue
q=Queue(3)    #最大放多少

q.put({'a':1})   #向里面放东西
q.put('bbb')
q.put((3,2,1))


q.get()  #取值  第几次取就是取第几次放的值 先进先出


q.put_nowait   #放的时候不等如果满了就报异常
```

 

 

取得时候也是，取得时候不等，如果没了就报是空的

### 2.管道

两个用的都是内存空间，用的是共享内存

### 生产者消费者模型（非常重要）

生产者：创造数据
消费者：处理数据
平衡两者之间的速度差
找一个中间的机制IPC机制(队列)
生产者消费者解耦合
两个人跟机制相关
frommultiprocessing inport Queue,Process
q=Queue()
创造一个队列
JoinableQueue可以给q添加join功能，等待q.task_done() 判断是否取完取完的话生产者
的join就结束
Manager()创造一个在内存的共享对象

# 进程池

### 同步调用

提交完任务后，在原地等待任务结束,一旦结束可以立刻拿到结果

### 阻塞

正在进行的进程遇到io则进入阻塞状态

### 异步调用

提交完任务后，不会在原地等待任务结束,会继续提交下一次任务，等到所有任务都结束后，才get结果

### 非阻塞

可能是运行状态，也可能是就绪状态

### 异步调用

```
from multiprocessing import  Pool
import os,time,random
def work(n):
    print('%s is working'%os.getpid())
    time.sleep(random.randint(1,3))
    return n
if __name__=='__main__':
    p=Pool(4)
    objs=[]
    for i in range(10):
         res=p.apply_async(work,args=(i,))
         objs.append(res)
    p.close()
    p.join()
    for obj in objs:
        print(obj.get())
```

 

### 回调函数

函数回调callback里面的函数名不要传参，参数就前面任务执行结果,运行时间不能大于前面的
应用爬虫边下边解析

# 线程

进程是一个资源单位，把资源集中起来，线程是执行的流水线
1.同一进程内的多个线程是共享该进程的资源
2.创建新的线程开销要远远小于开启新的进程
推荐书（现代操作系统）
子线程与主线程pid都是一样的
同一进程内的多个线程共享该进程的资源
主进程和子进程在不同的地址空间

### 线程对象的其他方法

.is_alive()判断是否存活
active_Count()活跃进程的数目
enumerate()当前活跃进程列表形式
current_thread().geName()

### 守护线程

主线程从执行角度就代表了该进程，主线程会在所有的非守护线程都运行完毕才结束
守护线程在主线程结束后结束