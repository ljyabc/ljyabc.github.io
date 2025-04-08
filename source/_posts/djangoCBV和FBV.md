---
title: djangoCBV和FBV
tags: [lnhdjango基础]
date: 2021-05-05 14:23:56
categories: 理解
photos:
book:
---

# CBV和FBV

## 1.-基于类的视图CBV

```python
-1 路由层:url(r'^test/', views.Test.as_view()),
			-2 视图层
				-导入:from django.views import View
				-写一个类:
					class Test(View):
						def get(self, request):#一定要传request对象
							return HttpResponse('get-test')

						def post(self, request):
							return HttpResponse('post-test')
						
						def dispatch(self,request,*args,**kwargs):
							# 加点东西
							response = super().dispatch(request,*args,**kwargs)
							# 加点东西
```

## 2.-基于函数的视图

随便唉唉唉