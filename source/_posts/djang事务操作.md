---
title: djang事务操作
tags: [lnhdjango基础]
date: 2021-05-05 14:25:29
categories: 理解
photos:
book:
---

## 事务操作

```python
from django.db import transaction
with transaction.atomic():
	# 业务流程 同事创建2张表 ，共进退
	pass
```

