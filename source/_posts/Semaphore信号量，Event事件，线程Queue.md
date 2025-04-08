---
title: Semaphore信号量，Event事件，线程Queue
tags: [并发编程]
date: 2019-03-19 16:41:50
categories: 理解
photos:
book:
---

# Semaphore信号量，Event事件，线程Queue

## 一.信号量

     Semaphore管理一个内置的计数器，
     每当调用acquire()时内置计数器-1；
     调用release() 时内置计数器+1；
     计数器不能小于0；当计数器为0时，acquire()将阻塞线程直到其他线程调用release()。

     实例：(同时只有5个线程可以获得semaphore,即可以限制最大连接数为5)

```python
import time
from threading import Semaphore,Thread,current_thread
 
 
 
def func():
    sm.acquire()
    print("%s get sm" %current_thread().name)
    time.sleep(5)
    sm.release()
    
 
if __name__ == '__main__':
    sm=Semaphore(5)
    for i in range(23):
        t=Thread(target=func)
        t.start()

```

注意：池与信号量是两个完全不同的概念 ，进程池Pool(4),最大只能产生4个进程，而且从头到尾都只是这四个进程，不会产生新的，而信号量是产生一堆线程/进程 

## 二.Event事件

 同进程的一样,线程的一个关键特性是每个线程都是独立运行且状态不可预测。如果程序中的其 他线程需要通过判断某个线程的状态来确定自己下一步的操作,这时线程同步问题就会变得非常棘手。为了解决这些问题,我们需要使用threading库中的Event对象。 对象包含一个可由线程设置的信号标志,它允许线程等待某些事件的发生。在 初始情况下,Event对象中的信号标志被设置为假。如果有线程等待一个Event对象, 而这个Event对象的标志为假,那么这个线程将会被一直阻塞直至该标志为真。一个线程如果将一个Event对象的信号标志设置为真,它将唤醒所有等待这个Event对象的线程。如果一个线程等待一个已经被设置为真的Event对象,那么它将忽略这个事件, 继续执行

  event.isSet()：返回event的状态值；

  event.wait()：如果 event.isSet()==False将阻塞线程；

  event.set()： 设置event的状态值为True，所有阻塞池的线程激活进入就绪状态， 等待操作系统调度；

  event.clear()：恢复event的状态值为False。

例如，有多个工作线程尝试链接MySQL，我们想要在链接前确保MySQL服务正常才让那些工作线程去连接MySQL服务器，如果连接不成功，都会去尝试重新连接。那么我们就可以采用threading.Event机制来协调各个工作线程的连接操作 

```python
#链接数据库
#检测数据库的可连接情况
 
#起两个线程
# 第一个线程：链接数据库       等待一个信号 告诉我们我们之间的网络是通的
# 第二个线程：检测与数据库的网络是否连通
#
import time
import random
from threading import Thread,Event
 
def connect_db(e):
    count=0
    while count<3:
        e.wait(1) #状态为False的时候，我只等1s 然后继续执行下面的代码
        if e.is_set()==True:
            print('连接数据库成功')
            break
        else:
            count += 1
            print("第%s次连接数据库失败" %count)
    else:
        raise TimeoutError("链接数据库超时")
    
  
def check_web(e):
    time.sleep(random.randint(0,2))
    e.set()
    
    
e=Event()
t1=Thread(target=connect_db,args=(e,))
t2=Thread(target=check_web,args=(e,))
t1.start()
t2.start()

```

## 三.线程Queue 

queue队列 ：使用import queue，用法与进程Queue一样

    queue is especially useful in threaded programming when information must be exchanged safely between multiple threads.

```python
import queue
 
#先进先出
q=queue.Queue()
q.put()
q.get()
 
 
#栈 后进先出
q=queue.LifoQueue()
q.put(1)
q.put(2)
q.put(3)
q.put(4)
print(q.get())
print(q.get())
print(q.get())
print(q.get())
 
 
#优先级队列:数字越小优先级越高,优先级相同,按ASCII
q=queue.PriorityQueue()
q.put(10,'a')
q.put(20,'b')
q.put(30,'c')
q.put(1,'d')
q.put(1,'z')
q.put(-1,'z')
 
print(q.get())
print(q.get())
print(q.get())

```

