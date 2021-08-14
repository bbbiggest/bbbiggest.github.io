---
layout: post
current: post
cover: assets/images/bear2.jpg
navigation: True
title: 《Effective C++》读书笔记（七）
date: 2021-08-07 23:12:10
tags: [notes]
class: post-template
subclass: 'post'
author: bbig
---

##  《Effective C++》读书笔记（七）

《 Effective C++ 改善程序与设计的 55 个具体做法》继承与面向对象设计



### using 声明式

假设基类的定义为

```c++
class Base
{
public:
    void mf3();
    void mf3(double);
    // ...
}
```

然后有个派生类想**继承**函数 mf3 ，并且还想**重载**它

``` c++
class Derived: public Base
{
public:
    void mf3();
}
```

但是此时假如

``` c++
Derived d;
d.mf3();
d.mf3(x); // 错误
```

会发现第二条语句错误，这是因为 Base::mf3 被 Derived::mf3 的作用域**遮掩**了

此时可以使用 **using 声明式**解决这个问题

``` c++
class Derived: public Base
{
public:
    using Base::mf3;
    void mf3();
}
```

即可让 Base 类内名为 mf3 的所有东西在派生类的**作用域**内都可见
