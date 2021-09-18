---
layout: post
current: post
cover: assets/images/ice.png
navigation: True
title: 《Effective C++》读书笔记（四）
date: 2021-07-17 22:42:07 +0800
tags: [notes]
class: post-template
subclass: 'post'
author: bbig
---

##  《Effective C++》读书笔记（四）

《 Effective C++ 改善程序与设计的 55 个具体做法》资源管理



### 以对象管理资源

为了确保资源总是被**释放**，可以把资源**放进对象内**，然后当控制流离开时，该对象的**析构函数**会自动释放那些资源。

**std::tr1::shared_ptr** 就是这样的，它是”引用计数型智慧指针“ (reference-counting smart pointer; RSCP) ，会持续追踪**共有多少对象**指向某笔资源，它在其析构函数内做 **delete** ，当**无人指向**它时会自动删除资源，但它无法打破**环状引用**。

除此之外， `tr1::shared_ptr` 允许指定”删除器“ (deleter) ，那是一个函数或者函数对象，当引用次数为 0 时便被调用，如：

``` c++
class Lock
{
public:
    explicit Lock(Mutex *pm)   // 以某个 Mutex 初始化 shared_ptr
        : mutexPtr(pm, unlock) // 并以 unlock 函数为删除器
    {
        lock(mutexPtr.get()); // get 显示转换，返回智能指针内部的原始指针
    }

private:
    std::tr1::shared_ptr<Mutex> mutexPtr;
};
```

