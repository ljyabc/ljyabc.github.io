---
title: django之ajax上传文件
tags: [lnhdjango基础]
date: 2021-05-05 14:41:42
categories: 理解
photos:
book:
---

# ajax上传文件

## 1.form表单上传

### 1.模板层

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<form action="/files/" method="post" enctype="multipart/form-data">
    <input type="file" name="myfile">
    <input type="submit" name="提交">
</form>
</body>
</html>
```

### 2.视图层views.py

```python
def add_files(request):
    if request.method == 'GET':
        return render(request,'add_files.html')
    # 这是个字典
    dic_files=request.FILES
    myfile = dic_files.get('myfile')
    # 文件对象拿到文件的name
    with open(myfile.name,'wb')as f:
        for line in myfile:
            f.write(line)
    return HttpResponse('ok')
```

## 2.ajax上传文件

### 模板层:

```python
$("#btn").click(function () {
				//上传文件,必须用FormData,生产一个formdata对象
				var formdata=new FormData();
				formdata.append('name',$("#name").val());
				//取出文件$("#myfile")[0].files拿到的是文件列表,取第0个把具体的文件取出来
				formdata.append('myfile',$("#myfile")[0].files[0]);

				$.ajax({
					url:'/files_ajax/',
					type:'post',
					//不预处理数据,(name=lqz&age=18)
					processData:false,
					//指定往后台传数据的编码格式(urlencoded,formdata,json)
					//现在用formdata对象处理了,就不需要指定编码格式了,不要给我编码了
					contentType:false,
					data:formdata,
					success:function (data) {
						alert(data)

					}
				})

```

### 视图层:

(跟form表单上传文件完全一样)

```python
def files_ajax(request):
				# 提交文件从,request.FILES中取,提交的数据,从request.POST中取
				name=request.POST.get('name')
				print(name)
				dic_files = request.FILES
				myfile = dic_files.get('myfile')
				with open(myfile.name, 'wb') as f:
					# 循环上传过来的文件
					for line in myfile:
						# 往空文件中写
						f.write(line)
				return HttpResponse('ok')
```

## 3.ajax json提交

### 模板层

#### ajax参数

##### 请求的编码方式:

```
contentType:'application/json',
```

##### 响应回来解析的方式

```
dataType:'json',
```

#### 模板层代码:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="/static/jquery-3.3.1.js"></script>
    <title>Title</title>
</head>
<body>
<form >
    <p>用户名:<input type="text" name="name" id="name"></p>
    <p>密码:<input type="password" name="myfile" id="pwd"></p>
    <input type="submit" name="提交">
</form>
<button id="btn">ajax提交json格式</button>
</body>
<script>
    $('#btn').click(function (){
        var post_data= {'name':$('#name').val(),'pwd':$('#pwd').val()};
        console.log(typeof post_data)
        // 如何把post_data这个字典,转成json格式字符串
        var pos = JSON.stringify(post_data)
        console.log(typeof pos)

        $.ajax({
            url:'/json/',
            type:'post',
            //提交一个json格式字符串pos
            data:pos,
            // django 可以自动解urlencode 和formdata的形式 ，可以指定application/json
            //解不了
            contentType:'application/json',
            dataType:'json',
            success:function (data) {
                {#alert(data)#}
                // 如果data是json格式字符串，如何转换成对象（字典）？
                //data = JSON.parse(data)
                console.log(typeof data)
                console.log(data)
                console.log(data.name)

                {#var ret = JSON.parse(data)#}
                {#console.log(typeof ret)#}
                {#console.log(ret.name)#}

            }
        })
    })
</script>
</html>
```

### 视图层

#### 注意

HttpResponse

json

JsonResponse

#### 视图层代码

```python
from django.http import JsonResponse
def add_json(request):
    if request.method == 'GET':
        return render(request,'json.html')
    print(request.POST)
    print(request.GET)
    # 前端传过来是一个json的字符串
    print(request.body)
    import json
    # 转换成字典
    ret=json.loads(request.body.decode('utf-8'))

    print(type(ret))
    print(ret)
    # 又把字典转换成json的字符串给前台
    # return HttpResponse(json.dumps(ret))
    return JsonResponse(ret)
    # return HttpResponse(ret)
```

