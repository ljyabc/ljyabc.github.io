---
title: django文件上传
tags: [lnhdjango基础]
date: 2021-04-30 16:51:05
categories: 理解
photos:
book:
---

# 文件上传

## 前端:

```html
用这个
<form action="" method="post" enctype="multipart/form-data">
    默认是这样
			{#<form action="" method="post" enctype="application/x-www-form-urlencoded">#}
				<input type="file" name="myfile">
				<input type="text" name="password">
				<input type="submit" value="提交">
			</form>
```

## 后台:

```python
def fileupload(request):
				if request.method=='GET':
					return render(request,'fileupload.html')
				if request.method=='POST':
					# FILES
					print(request.FILES)
					print(type(request.FILES.get('myfile')))
					# 从字典里根据名字,把文件取出来
					myfile=request.FILES.get('myfile')
					from django.core.files.uploadedfile import InMemoryUploadedFile
					# 文件名字
					name=myfile.name
					# 打开文件,把上传过来的文件存到本地
					with open(name,'wb') as f:
						# for line in myfile.chunks():
						for line in myfile:
							f.write(line)
					return HttpResponse('ok')
	
		补充:*****编码方式multipart/form-data或者:application/x-www-form-urlencoded传的数据,都可以从
```

