---
title: django视图层
tags: [lnhdjango基础]
date: 2021-04-30 14:51:08
categories: 理解
photos:
book:
---

# 视图层

## 1.视图层之HttpRequest对象

```python
# 前台Post传过来的数据,包装到POST字典中
		# request.POST
		# 前台浏览器窗口里携带的数据,包装到GET字典中
		# request.GET
		# 前台请求的方式
		# request.method
		# post提交的数据,body体的内容,前台会封装成:name=lqz&age=18&sex=1
		# request.body
		# 取出请求的路径,取不到数据部分
		# print(request.path)
		# 取出请求的路径,能取到数据部分
		# print(request.get_full_path())
		# print(request.META)
```

## 2.视图层之HttpResponse对象

```python
三件套:render,HttpResponse,redirect
先导入
from django.template import Template,Context
		render函数:
			temp=Template('<h1>{{ user }}</h1>')
			con=Context({'user':'lqz'})
			ret=temp.render(con)
			print(ret)
			# return render(request,'index.html')
			return HttpResponse(ret)
```

## 3.视图层之JsonResponse对象

返回一个json格式给前台的意义就是前台的js代码拿到了json格式可以实现一个动态的效果，而这个动态的效果是有后端传给前端的，也就是说前端的动态，需要后端控制，前端就是需要管静态，实现了前后端分离

```python
-导入:from django.http import JsonResponse
		-视图函数中:
			def test(request):
				import json
				# dic={'name':'lqz','age':18}
				ll = ['name', 'age']
				# 把字典转换成json格式,返回到前台
				# return HttpResponse(json.dumps(dic))
				# 把列表转换成json格式,返回到前台
				# return HttpResponse(json.dumps(ll))
				# 把字典转换成json格式,返回到前台
				# return JsonResponse(dic)
				# 报错,默认不支持列表形式
				# return JsonResponse(ll)
				# 支持列表形式
				return JsonResponse(ll,safe=False)
```

### 返回中文

```python
def test(request):
	dic = {'name':'六'}
	return JsonResponse(dic,json_dumps_params={'ensure_ascii':False})
```

