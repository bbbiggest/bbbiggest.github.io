---
layout: post
current: post
cover: assets/images/Reaper.jpg
navigation: True
title: 《Effective C++》读书笔记（八）
date: 2021-08-14 22:41:11
tags: [notes]
class: post-template
subclass: 'post'
author: bbig
---

##  《Effective C++》读书笔记（八）

《 Effective C++ 改善程序与设计的 55 个具体做法》模板与泛型编程

~~每周看书的时间太少了吧，这个系列竟然都写到八了，八个星期还没看完这本书~~



### typename

假设你有下面这样的一个模板函数

``` c++
template <typename C>
void print2nd(const C &container)
{
    C::const_iterator *x;
    // ...
}
```

但这是错误的，因为这对解析器来说会引起歧义，因为它既可以是一个类型，一个指向迭代器的指针类型，也可以是一个 C 里面叫做 `const_iterator` 的变量然后乘上一个全局变量 x

为了消除这一歧义，必须要说明它是一个类型，所以需要在它前面放置 `typename` ，即

``` c++
template <typename C>
void print2nd(const C &container)
{
    if (container.size() >= 2)
    {
        typename C::const_iterator *iter(container.begin());
        // ...
    }
}
```

