---
title: django之BBS注册
tags: [lnhdjango基础]
date: 2021-05-05 14:42:26
categories: 理解
photos:
book:
---

# 45.BBS注册

## 1.先要进行form验证

### 在app下面新建一个myform.py文件

```python
# 1.导入forms表单验证模块
from django import forms
# 4.导入forms表单样式模块
from django.forms import widgets

# 2.写一个类ReForm实例化生成的对象(表的字段)
class ReForm(forms.Form):
    # 3.修改label成中文
    # 5.widgets.TextInput，widgets.PasswordInput，widgets.TextInput添加不同的样式
    name = forms.CharField(max_length=18,min_length=2,label='用户名',
                           widget=widgets.TextInput(attrs={'class':'form-control'})
                           )
    pwd = forms.CharField(max_length=18,min_length=2,label='密码',
                           widget=widgets.PasswordInput(attrs={'class':'form-control'})
                          )
    re_pwd=forms.CharField(max_length=18,min_length=2,label='密码',
                           widget=widgets.PasswordInput(attrs={'class':'form-control'})
                           )
    email=forms.EmailField(label='邮箱',
                           widget=widgets.TextInput(attrs={'class':'form-control'})
                           )
```

## 2.写路由

```python
url(r'^register/', views.register),
```

## 3.视图函数提交前台form组件

```python
def register(request):
    # 生成一个空的form组件
    my_form = myforms.ReForm()
    return render(request,'register.html',{'my_form':my_form})
```

## 4.前台form组件

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script src="/static/jquery-3.3.1.js"></script>
    <title>注册</title>
    <style>
                {#把文件空间隐藏#}
        #my_file{
            display: none;
        }
    </style>

{#    <script>#}
{#        //等文档加载完毕之后,再进行操作#}
{#        window.onload = function () {#}
{#            //$("#id_name").val('lqz')#}
{#        }#}
{##}
{#    </script>#}
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <h1>注册</h1>
            <form id="form">
                {% csrf_token %}
{#          1.后台传入form组件      #}
                {% for foo in my_form %}
                    <div class="form-group">
                        <label for="{{ foo.auto_id }}">{{ foo.label }}</label>
                        {{ foo }}
                    </div>
                {% endfor %}
                {# 2.加一个上传文件的控件#}
                <div class="form-group">
                    <label for="my_file">头像
{#                        3.把图片放到label里面目的是为了点击图片的时候才可以上传#}
                        <img src="/static/img/default.png" id="img_file" alt="" width="80" height="80"
                             style="margin-left: 10px">
                    </label>
{#                4.input输入图片也就是上传图片的标签#}
                    <input type="file" id="my_file">
                </div>


                <input type="button" value="注册" class="btn btn-primary " id="btn"><span class="error"></span>
            </form>

        </div>

    </div>

</div>
</body>
<script>
    //5.拿到上传图片的标签，这个控件值发生变化的事件change方法
    $('#my_file').change(function () {
        {#alert(11)#}
        //6.先取出文件(图片)
        //$('#my_file')拿到的是个这个控件
        //$('#my_file')[0]拿到的是个这个控件上传图片的标签
        //$('#my_file')[0].files拿到的是个这个控件上传图片的标签的列表
        //$('#my_file')[0].files[0]拿到的是个这个控件上传图片的标签的列表的图片
        var file_obj=$('#my_file')[0].files[0];
        //7.通过文件阅读器，把图片放到img标签上
        //生成一个文件阅读器对象
        var filereader=new FileReader()
        //把图片对象，读到filereader对象中
        filereader.readAsDataURL(file_obj)
        //filereader.result 这是filereader对象的值
        //把文件对象渲染到img标签上(这样不行.需要加载完成才能操作)
        {#$("#img_file").attr('src', filereader.result)#}
        {#alert(1)#}
        //等加载完成,在操作
        filereader.onload=function () {
            $("#img_file").attr('src', filereader.result)
        }
    })
    // 8 取到提交按钮标签启动点击事件
    $('#btn').click(function () {
        //9生成一个formdata对象
        var formdata =new FormData()
        //10.因为form组件会把标签id渲染成id_name
        formdata.append('name',$('#id_name').val())
        formdata.append('pwd',$('#id_pwd').val())
        formdata.append('re_pwd',$('#id_re_pwd').val())
        formdata.append('email',$('#id_email').val())
        // 11.把session的字符串添加到formdata对象里面
        formdata.append('csrfmiddlewaretoken',$('[name="csrfmiddlewaretoken"]').val())
        //12.把文件放到formdata中
        formdata.append('my_file',$('#my_file')[0].files[0])
        //13.把formdata里面添加的数据添加到ajax
        $.ajax({
            url:'/register/',
            type:'post',
            //写什么来？
            ///14.不预处理数据,(name=lqz&age=18)
            prosccData:false,
            //15.指定往后台传数据的编码格式(urlencoded,formdata,json)
			//现在用formdata对象处理了,就不需要指定编码格式了,不要给我编码了
            contentType:false,
            data:formdata,
            success:function (data) {
                console.log(data)

            }
        })
    })
</script>


</html>
```

## 5.回到视图函数

```python
def register(request):
    if request.method=='GET':
        # 生成一个空的form组件
        my_form = myforms.ReForm()
        return render(request,'register.html',{'my_form':my_form})
    elif request.is_ajax():
        response= {'status':100,'msg':None}
        my_form = myforms.ReForm(request.POST)
        # 校验是否通过
        if my_form.is_valid():
            pass
        else:
            #失败
            #返回错误信息
            response['status']=101
            response['msg']=my_form.errors

        # ajax 不能return render和redirect
        return JsonResponse(response)
```

## 6.回到前台form组件

但是这样的方式不好，因为form组件可以会有很多

```javascript
// 8 取到提交按钮标签启动点击事件
    $('#btn').click(function () {
        //9生成一个formdata对象
        var formdata =new FormData()
        //10.因为form组件会把标签id渲染成id_name
        formdata.append('name',$('#id_name').val())
        formdata.append('pwd',$('#id_pwd').val())
        formdata.append('re_pwd',$('#id_re_pwd').val())
        formdata.append('email',$('#id_email').val())
        // 11.把session的字符串添加到formdata对象里面
        formdata.append('csrfmiddlewaretoken',$('[name="csrfmiddlewaretoken"]').val())
        //12.把文件放到formdata中
        formdata.append('my_file',$('#my_file')[0].files[0])
        //13.把formdata里面添加的数据添加到ajax
        $.ajax({
            url:'/register/',
            type:'post',
            //写什么来？
            ///14.不预处理数据,(name=lqz&age=18)
            processData:false,
            //15.指定往后台传数据的编码格式(urlencoded,formdata,json)
            //现在用formdata对象处理了,就不需要指定编码格式了,不要给我编码了
            contentType:false,
            data:formdata,
            success:function (data) {
                console.log(data)

            }
        })
    })
```

## 7.回到前台form组件，方式二

### 注册标签加

```html
<form id="form">
```

### $("#form").serializeArray()

```javascript
// 8 取到提交按钮标签启动点击事件
    $('#btn').click(function () {
        //9生成一个formdata对象
        var formdata =new FormData()
        //$("#form").serializeArray()把form表单打包,转成对象(列表套字典)
        var arr=$("#form").serializeArray()
        //第二种方式
        //jquery 的循环,传参数:第一个参数是要循环的对象,第二个参数是一个匿名函数
        $.each(arr,function (key,obj) {
            //obj对应的是:{name: "name", value: "sfdae"}
            console.log(key)
            console.log(obj)
            formdata.append(obj.name,obj.value)
        })
       //把文件放到formdata中
        formdata.append('my_file',$('#my_file')[0].files[0])
        //console.log(formdata)
        console.log(arr)
        $.ajax({
            url:'/register/',
            type:'post',
            //写什么来？
            ///14.不预处理数据,(name=lqz&age=18)
            processData:false,
            //15.指定往后台传数据的编码格式(urlencoded,formdata,json)
            //现在用formdata对象处理了,就不需要指定编码格式了,不要给我编码了
            contentType:false,
            data:formdata,
            success:function (data) {
                console.log(data)

            }
        })
    })
```

## 8.回到视图函数校验成功了的代码

```python
def register(request):
    if request.method=='GET':
        # 生成一个空的form组件
        my_form = myforms.ReForm()
        return render(request,'register.html',{'my_form':my_form})
    elif request.is_ajax():
        response= {'status':100,'msg':None}
        my_form = myforms.ReForm(request.POST)
        # 校验是否通过
        if my_form.is_valid():
            # 存数据,返回正确信息
            # 得用create_user,回忆一下为什么
            # 定义一个字典,把清理的数据赋给它
            dic = my_form.cleaned_data
            # 移除掉确认密码字段
            dic.pop('re_password')
            # 取出上传的文件对象
            my_file = request.FILES.get('my_file')

            # 如果上传的文件为空,这个字段不传,数据库里存默认值
            if my_file:
                # 放到字典中
                dic['avatar'] = my_file
            # 存数据的时候,多肯定不行,少,可以能行(null=True),它是可以的
            user = models.UserInfo.objects.create_user(**dic)
            '''
            models.FileField 有了这个字段,存文件,以及往数据库放文件路径,统统不需要自己做了
            只需要把文件对象赋给它就可以了
            '''
            # user=models.UserInfo.objects.create_user(username=name,password=pwd,avatar=文件对象)
            # 看看存没存进去
            print(user.username)
            #     要跳转的路径
        else:
            #失败
            #返回错误信息
            response['status']=101
            response['msg']=my_form.errors

        # ajax 不能return render和redirect
        return JsonResponse(response)
```

## 9.回到myform.py设置钩子函数进行校验

```python
# 1.导入forms表单验证模块
from django import forms
# 4.导入forms表单样式模块
from django.forms import widgets
# 6.异常渲染
from django.core.exceptions import ValidationError
from blog import models
# 2.写一个类ReForm实例化生成的对象(表的字段)
class ReForm(forms.Form):
    # 3.修改label成中文
    # 5.widgets.TextInput，widgets.PasswordInput，widgets.TextInput添加不同的样式
    username = forms.CharField(max_length=18,min_length=2,label='用户名',
                           widget=widgets.TextInput(attrs={'class':'form-control'})
                           )
    password = forms.CharField(max_length=18,min_length=2,label='密码',
                           widget=widgets.PasswordInput(attrs={'class':'form-control'})
                          )
    re_password=forms.CharField(max_length=18,min_length=2,label='密码',
                           widget=widgets.PasswordInput(attrs={'class':'form-control'})
                           )
    email=forms.EmailField(label='邮箱',
                           widget=widgets.TextInput(attrs={'class':'form-control'})
                           )
    #7. 局部钩子
    def clean_username(self):
        name = self.cleaned_data.get('username')
        #8. 去数据库校验
        ret = models.UserInfo.objects.filter(username=name).first()
        if ret:
            raise ValidationError('用户已经存在')
        #9. 局部返回name
        return name

    #10. 全局校验钩子函数
    def clean(self):
        pwd = self.cleaned_data.get('password')
        re_pwd=self.cleaned_data.get('re_password')
        if pwd and re_pwd:
            if pwd == re_pwd:
                # 11. 这里要返回cleaned_data
                return self.cleaned_data
            else:
                raise ValidationError('两次密码不一致')


```

## 10.注册错误信息渲染到前端

### javascript代码

```javascript
//name,发ajax的请求校验用户是否存
    /*
    $("#id_username").change(function () {
        alert('change')
    })
    */
    $("#id_username").blur(function () {
        $.ajax({
            url:'/check_username/',
            type:'post',
            //name加引号不加引号都可以
            data:{name:$(this).val(),'csrfmiddlewaretoken':'{{ csrf_token }}'},
            success:function (data) {
                console.log(data)
                if(data.status==101){
                    $('#id_username').next().html(data.msg).parent().addClass('has-error')
                }
            }

        })
    })
```

### 路由check_username

```python
url(r'^check_username/', views.check_username),
```

### 视图函数check_username

```python
def check_username(request):
    response={'status':100,'msg':None}
    name=request.POST.get('name')
    user = models.UserInfo.objects.filter(username=name).first()
    if user:
        response['status']=101
        response['msg']='用户名已经被占用'
    return JsonResponse(response)
```

## 

