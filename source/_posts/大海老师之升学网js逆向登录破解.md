---
title: 大海老师之升学网js逆向登录破解
tags: [图灵python]
date: 2022-10-26 15:41:02
password: tulingnixiang
categories: python核心编程
photos:
book:
---

# 升学e网之js逆向破解

## 升学e网网址

https://web.ewt360.com/register/#/login

## 一.技术难点

### 1.AES加密

简介：全称高级加密标准，由美国国家标准与技术研究院于 2001 年发布，并在 2002 年成为有效的标准，是美国联邦政府采用的一种区块加密标准。

![1666681362749](大海老师之升学网js逆向登录破解\1666681362749.png)

#### 1.1.说白了其实就是5个参数

 text 加密对象，aesKey 密钥，aesIv 偏移量，CBC 加密模式，Pkcs7 填充方式

#### 1.2.以下是二个模板：加密"I love Python!" 

##### JavaScript代码实现

```js
// 引用 crypto-js 加密模块
var CryptoJS = require('crypto-js')

function tripleAesEncrypt() {
    var key = CryptoJS.enc.Utf8.parse(aesKey),
        iv = CryptoJS.enc.Utf8.parse(aesIv),
        srcs = CryptoJS.enc.Utf8.parse(text),
        // CBC 加密方式，Pkcs7 填充方式
        encrypted = CryptoJS.AES.encrypt(srcs, key, {
            iv: iv,
            mode: CryptoJS.mode.CBC,
            padding: CryptoJS.pad.Pkcs7
        });
    return encrypted.toString();
}

function tripleAesDecrypt() {
    var key = CryptoJS.enc.Utf8.parse(aesKey),
        iv = CryptoJS.enc.Utf8.parse(aesIv),
        srcs = encryptedData,
        // CBC 加密方式，Pkcs7 填充方式
        decrypted = CryptoJS.AES.decrypt(srcs, key, {
            iv: iv,
            mode: CryptoJS.mode.CBC,
            padding: CryptoJS.pad.Pkcs7
        });
    return decrypted.toString(CryptoJS.enc.Utf8);
}

var text = "I love Python!"       // 待加密对象
var aesKey = "6f726c64f2c2057c"   // 密钥，16 倍数
var aesIv = "0123456789ABCDEF"    // 偏移量，16 倍数

var encryptedData = tripleAesEncrypt()
var decryptedData = tripleAesDecrypt()

console.log("加密字符串: ", encryptedData)
console.log("解密字符串: ", decryptedData)

// 加密字符串:  dZL7TLJR786VGvuUvqYGoQ==
// 解密字符串:  I love Python!

//  写爬虫做逆向  加密方式 AES DES  密钥 填充 初始向量  加密的模式
```

##### python代码

```python
import base64
from Cryptodome.Cipher import AES
# 需要补位，str不是16的倍数那就补足为16的倍数
def add_to_16(value):
    while len(value) % 16 != 0:
        value += '\0'
    return str.encode(value)
# 加密方法
def aes_encrypt(key, t, iv):
    aes = AES.new(add_to_16(key), AES.MODE_CBC, add_to_16(iv))  # 初始化加密器
    encrypt_aes = aes.encrypt(add_to_16(t))                    # 先进行 aes 加密
    encrypted_text = str(base64.encodebytes(encrypt_aes), encoding='utf-8')  # 执行加密并转码返回 bytes
    return encrypted_text
# 解密方法
def aes_decrypt(key, t, iv):
    aes = AES.new(add_to_16(key), AES.MODE_CBC, add_to_16(iv))         # 初始化加密器
    base64_decrypted = base64.decodebytes(t.encode(encoding='utf-8'))  # 优先逆向解密 base64 成 bytes
    decrypted_text = str(aes.decrypt(base64_decrypted), encoding='utf-8').replace('\0', '')  # 执行解密密并转码返回str
    return decrypted_text
if __name__ == '__main__':
    secret_key = '12345678'   # 密钥
    text = 'I love Python!'   # 加密对象
    iv = secret_key           # 初始向量
    encrypted_str = aes_encrypt(secret_key, text, iv)
    print('加密字符串：', encrypted_str)
    decrypted_str = aes_decrypt(secret_key, encrypted_str, iv)
    print('解密字符串：', decrypted_str)
# 加密字符串：lAVKvkQh+GtdNpoKf4/mHA==
# 解密字符串：I love Python!
```




