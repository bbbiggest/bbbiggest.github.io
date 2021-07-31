---
layout: post
current: post
cover: assets/images/cactus.png
navigation: True
title: 《Effective C++》读书笔记（五）
date: 2021-07-24 23:26:08
tags: [notes]
class: post-template
subclass: 'post'
author: bbig
---

##  《Effective C++》读书笔记（五）

《 Effective C++ 改善程序与设计的 55 个具体做法》设计与声明



### 预防”接口被误用“

比较安全的做法是预先定义所有的有效的值，如下面的 Months ：

``` c++
class Month
{
public:
    static Month Jan() { return Month(1); }
    static Month Feb() { return Month(2); }
    // ...
    static Month Dec() { return Month(12); }

private:
    explicit Month(int m);
    // ...
};
```

上面这种封装其内的数据、导入新类型的方法，使接口更容易被使用且不被误用，然后客户可以像下面那样使用接口，而不用担心他们以错误的顺序传递参数或者传递无效参数。

``` c++
Date d(Month::Mar(), Day(30), Year(1995));
```



