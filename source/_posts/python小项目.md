---
title: python小项目
tags: [算法]
date: 2019-03-14 20:07:25
categories: 逻辑
photos:
---

## 冒泡排序

### 算法描述

冒泡排序的基本思想就是：从无序序列头部开始，进行两两比较，根据大小交换位置，直到最后将最大的数据元素交换到了无序队列的队尾，从而成为有序序列的一部分；下一次继续这个过程，直到所有数据元素都排好序。

> 算法的核心在于每次通过两两比较交换位置，选出剩余无序序列里最大的数据元素放到队尾。

### 代码实现

- 比较相邻的元素，如果第一个比第二个大(升序)，就交换他们两个；
- 对每一对相邻元素做同样的工作，从开始第一对到结尾的最后一对；
- 针对所有的元素重复以上的步骤，除了最后已经选出的元素；
- 持续每次对越来越少的元素重复上面的步骤，直到没有任何一对数字需要比较。

```python
# _*_ coding:utf-8 _*_

# 冒泡排序
def bubble_sort(list):

    n = len(list)
    print(f"列表的总长度为：{n}")

    for i in range(n - 1):

        print('-' * 20)
        print(f"当前i为：{i}")
        count = 0
        print('*' * 20)

        for j in range(0, n-1-i):

            print(f"当前j为：{j}")
            print(list)

            # 让列表的前一位与后一位进行对比，如果前一位大于后一位，则交换两者的位置,当最大的以为移至队列尾部时停止比较
            if list[j] > list[j+1]:

                list[j], list[j+1] = list[j+1], list[j]
                count += 1
                print(f"当前count为：{count}")

        if 0 == count:
            break

if __name__ == '__main__':
    list = [56, 12, 1, 8, 254, 456, 10, 100, 34, 56, 7, 23, 234, -57]
    print(f"原列表为：{list}")
    bubble_sort(list)
    print('^' * 60)
    print(f"新列表为：{list}")
```

最终结果为：

```python
新列表为：[-57, 1, 7, 8, 10, 12, 23, 34, 56, 56, 100, 234, 254, 456]
```

## 插入排序

### 算法描述

插入排序的基本操作就是将一个数据插入到已经排好序的有序数据中，从而得到一个新的、个数加一的有序数据，算法适用于少量数据的排序，时间复杂度为O(n^2)。是稳定的排序方法。插入算法把要排序的数组分成两部分：第一部分包含了这个数组的所有元素，但将最后一个元素除外（让数组多一个空间才有插入的位置），而第二部分就只包含这一个元素（即待插入元素）。在第一部分排序完成后，再将这个最后元素插入到已排好序的第一部分中。

### 代码实现

```python
# _*_ coding:utf-8 _*_

# 插入排序
def insert_sort(list):

    n = len(list)
    print(f"列表的总长度为：{n}")

    for i in range(1, n):

        print('-' * 40)
        print(f"当前i为：{i}")
        key = list[i]
        print(f"当前key为：{key}")
        j = i - 1
        print(f"当前j为：{j}")

        while j >= 0:

            if list[j] > key:
                print(f"因为list[j]:{list[j]}>key:{key},所以执行这一步")
                print(f"list[{j+1}]={list[j+1]},list[{j}]={list[j]}")
                # list[j + 1], list[j] = list[j], key

                list[j+1] = list[j]
                list[j] = key

                print(f"list[{j}]:{list[j]},key:{key}")

            j -= 1
            print(f"当前j为：{j}")
            print(f"当前list为：{list}")

        # # return list

if __name__ == '__main__':
    list = [56, 12, 1, 8, 254, 456, 10, 100, 34, 56, 7, 23, 234, -57]
    print(f"原列表为：{list}")
    insert_sort(list)
    print(f"新列表为：{list}")
```

最终结果为：

```python
新列表为：[-57, 1, 7, 8, 10, 12, 23, 34, 56, 56, 100, 234, 254, 456]
```

## 计算x的n次方

```python
def power(x, n):
    s = 1
    print(f"初始x为：{x}")
    print(f"初始n为：{n}")
    print('-' * 30)

    while n > 0:
        n -= 1
        print(f"当前n为：{n}")
        s = s * x
        print(f"当前s为：{s}")
        print('- ' * 10)

    return s
```

## 计算axa+bxb+cxc+..

```python
def clac(*numbers):

    sum = 0

    for n in numbers:
        print(f"当前n为：{n}")
        sum = sum + n * n
        print(f"当前sum为：{sum}")
        print('-' * 10)

    print(sum)
    return sum
```

## 计算阶乘n！

```python
# 方法一
def fac(num):
    factorial = 1

    if num < 0:
        print("抱歉，负数没有阶乘")

    elif num == 0:
        print("0的阶乘为1")

    else:
        for i in range(1, num + 1):
            print(f"当前i为：{i}")
            print(f"乘法流程为factorial[{factorial}]* i[{i}]")
            factorial = factorial * i
            print(f"当前factorial为：{factorial}")
            print("- " * 10)

        print(f"{num}！的阶乘为{factorial}")

# 方法二
def factorial(n):

    result = n

    for i in range(1, n):
        result *= i

    print(result)
    return result

# 方法三
def fact(n):
    if n == 1:
        return 1

    m = n * fact(n - 1)
    print(m)
    return m
```

## 列出当前目录下的所有文件和目录名

```python
def show_all_dir():
    # for d in os.listdir('.'):
    #     print(d)
    # d for d in os.listdir('.')就等于for d in os.listdir('.')
    a = [d for d in os.listdir('.')]
    print(a)
```

2中写法，其中一种写法注释了。

## 把一个list中所有的字符串变成小写

```python
def word_lower(list):
    # for i in list:
    #     i.lower()

    list = [i.lower() for i in list]
    # print(list)
    # print(f"新列表为：{list}")
    return list
```

## 输出某个路径下的所有文件和文件夹的路径

```python
def get_dir():
    filepath = input(">>请输入一个路径：")
    try:
        if filepath == "":
            print("请输入正确的路径！")
        else:
            for i in os.listdir(filepath):
                print(os.path.join(filepath, i))
    except:
        print("路径错误！请重新输入！")
```

## 输出某个路径及其子目录下的所有文件路径

```python
def show_dir():
    filepath = input(">>请输入一个路径：")
    for i in os.listdir(filepath):
        path = (os.path.join(filepath, i))
        print(path)
        if os.path.isdir(path):
            show_dir(path)
```

## 输出某个路径及其子目录下所有以.html为后缀的文件

```python
def show_dir_html(filepath):
    for i in os.listdir(filepath):
        path = os.path.join(filepath, i)
        if os.path.isdir(path):
            show_dir_html(path)
        if path.endswith(".xml"):
            print(path)
```

## 把原字典的键值对颠倒并生产新的字典

```python
def get_dict():
    dict1 = {
        "A": "a",
        "B": "b",
        "C": "c",
        "D": "d"
    }

    dict2 = {y:x for x, y in dict1.items()}

    print(dict2)
```

## 打印99乘法表

```python
def chengfa():
    for i in range(1, 10):
        for j in range(1, i + 1):
            # print(f"{j} x {i} = {i*j}", end=' ')
            # print('- ' * 20)
            print('%d x %d = %d \t'%(i, j, i*j), end='')
```

## 替换列表中所有的3位3a

```python
def tihuan(list):
    for i in range(list.count(3)):
        ele_index = list.index(3)
        list[ele_index] = "3a"
        print(list)
```

## 摇骰子小游戏

```python
def random_num():
    i = 1
    a = random.randint(0, 100)
    print(a)
    b = int(input(">>>请输入0-100中的一个数字\n然后查看是否与电脑一样："))

    while a != b:
        if a > b:
            print(f"你输了，电脑赢了！中奖号为{a}")
            b = int(input(">>>请再次输入输入数字:"))
        else:
            print(f"你赢了，中奖号为{a},你大于电脑输入的！")
            b = int(input(">>>请再次输入输入数字:"))

        i += 1

    else:
        print("居然跟电脑输入的数字一样！")
```

## 随机验证码

```python
def yanzhengmasuiji():
    str1 = "0123456789"

    # string.ascii_letters包含所有字母（大写与小写）的字符串
    str2 = string.ascii_letters
    # print(str2)
    str3 = str1 + str2
    print(str3)

    ma1 = random.sample(str3, 6)
    print(ma1)
    ma1 = ''.join(ma1)
    print(ma1)
```

## 计算平方根

```python
def num_genhao():
    num = float(input(">"))
    num_sqrt = num ** 0.5

    print(num_sqrt)
```

## 判断字符串是否只由数字组成

```python
def is_numbers(s):
    try:
        float(s)
        return True
    except ValueError:
        pass

    try:
        import unicodedata2
        unicodedata.numberic(s)
        return True
    except (TypeError, ValueError):
        pass

    return False
```

## 判断奇偶

```python
def jiou():
    # num = int(input(">请输入一个数字："))
    # if (num % 2) == 0:
    #     print(f"{num}是偶数！")
    # else:
    #     print(f"{num}是奇数！")

    while True:
        try:
            num = int(input(">请输入一个数字："))
        except ValueError:
            print("输入的不是整数！")
            continue
        if (num % 2) == 0:
            print(f"{num}是偶数！")
        else:
            print(f"{num}是奇数！")

        break
```

## 判断闰年

```python
# 方法一
def runnian():

    year = int(input("请输入一个年份："))
    if (year % 4) == 0:
        if (year % 100) == 0:
            if (year % 400) == 0:
                print(f"{year}是闰年")
            else:
                print(f"{year}不是闰年")

        else:
            print(f"{year}是闰年")

    else:
        print(f"{year}不是闰年")

# 方法二
def runnian2():
    import calendar

    year = int(input("请输入一个年份："))
    check_year = calendar.isleap(year)
    if check_year == True:
        print(f"{year}是闰年")
    else:
        print(f"{year}不是闰年")
```

## 获取最大值

```python
def whos_number_is_big():

    n = int(input("请输入需要对比大小数字的个数："))

    print("请输入需要对比的数字：")

    num = []
    for i in range(1, n+1):
        temp = int(input(f'>>>请输入第{i}个数字：'))
        num.append(temp)

    print("输入的数字为：", num)
    print("最大值为:", max(num))
```

## 斐波那契数列

斐波那契数列指的是这样一个数列：0，1，1，2，3，5，8，13；第1项为0，第2项为1，从第3项开始，每一项都等于前两项之和。

```python
def feibonaqi():
    n1 = 0
    n2 = 1
    nterms = int(input(">>>请输入一个数："))
    if nterms <=  0:
        print("请输入一个大于1的正整数！")
    elif nterms == 1:
        print("请输入一个大于1的正整数！")
    else:
        print("斐波那契数列：")
        print(n1, end=",")

        count = 0
        while count < nterms:
            # print(f"当前count为{count}")
            nth = n1 + n2
            print(n1 + n2, end=",")
            n1 = n2
            n2 = nth

            count += 1
```

## 十进制转二进制，八进制，十六进制

```python
def shijinzhi():
    dec = int(input("请输入数字："))

    print("十进制数为：", dec)
    print(f"转化为二进制为：{bin(dec)}")
    print(f"转化为八进制为：{oct(dec)}")
    print(f"转化为十六进制为：{hex(dec)}")
```

## 求两个数的最大公约数

```python
def hcf(x,y):
    if x > y:
        smaller = y
    else:
        smaller = x

    for i in range(1, smaller + 1):
        if (x % i == 0) and (y % i == 0):
            hcf = i

    return hcf

num1 = int(input("输入第一个数字："))
num2 = int(input("输入第二个数字："))

print(f"num1喝num2的最大公约数为：{hcf(num1, num2)}")
```

## 求两个数的最小公倍数

```python
def lcm(x,y):
    if x > y:
        greater = y
    else:
        greater = x

    while(True):
        if((greater % x == 0) and (greater % y == 0)):
            lcm = greater
            break

        greater += 1

    return lcm

num1 = int(input("输入第一个数字："))
num2 = int(input("输入第二个数字："))
print()

print(f"num1喝num2的最最小公倍数为：{lcm(num1, num2)}")
```

## 简单计算器

```python
def add(x, y):

    return x + y

def subtract(x, y):

    return x - y

def muliply(x, y):

    return x * y

def divide(x, y):

    return x / y

print("选择运算：")
print("1.相加\n2.相减\n3.相乘\n4.相除")

choice = input("输入你的选择（1/2/3/4):")

num1 = int(input("输入第一个数字："))
num2 = int(input("输入第二个数字："))

if choice == '1':
    print(f"{num1}+{num2}={add(num1,num2)}")
elif choice == '2':
    print(f"{num1}-{num2}={subtract(num1,num2)}")
elif choice == '3':
    print(f"{num1}*{num2}={muliply(num1, num2)}")
elif choice == '4':
    if num2 != 0:
        print(f"{num1}/{num2}={divide(num1,num2)}")
    else:
        print("分母不能为0")
else:
    print("非法输入！")
```

## 生成日历

```python
import calendar

yy = int(input(">>>请输入年份："))
mm = int(input(">>>请输入月份："))

print(calendar.month(yy, mm))
```

## 文件IO

```python
def file_io():
    with open("huixing.txt", "wt") as out_file:
        out_file.write("该文本写入到文件中\n看到我了吧！")

    with open("huixing.txt", "rt") as in_file:
        text = in_file.read()

    print(text)

file_io()
```

## 字符串判断

```python
def str_test():
    # str = "www.liuyude.com"
    str = "Liuyude"
    print(str.isalnum())  # 判断所有字符都是数字或者字母
    print(str.isalpha())  # 判断所有字符都是字母
    print(str.isdigit())  # 判断所有字符都是数字
    print(str.islower())  # 判断所有字符都是小写
    print(str.isupper())  # 判断所有字符都是大写
    print(str.istitle())  # 判断所有单词都是首字母大写，像标题
    print(str.isspace())  # 判断所有字符都是空白字符

    print("-" * 40)
```

## 字符串大小写转换

```python
def trans_str():
    str = "https://liuyude.COM"
    print(str.upper())  # 把所有字符中的小写字母转换成大写字母
    print(str.lower())  # 把所有字符串中大写字母转换成小写字母
    print(str.capitalize())  # 把第一个字母转化为大写字母，其余小写
    print(str.title())  # 把每个单词的第一个字母转化为大写，其余小写
```

## 计算每个月天数

```python
def get_month_days():
    import calendar
    monthRange = calendar.monthcalendar(2019, 2)
    print(monthRange)
```

## 获取昨天的日期

```python
def get_last_day():
    import datetime
    today = datetime.date.today()
    oneday = datetime.timedelta(days=1)
    yesterday = today - oneday
    print(yesterday)
    return yesterday
```
```python
dic = {"k1":"vlvl","k2":[11,22,33,44,55]}

for key in dic:
    dic[key] = dic[key][:2]

print(dic)
```