---
layout: post
current: post
cover: assets/images/elephant.jpg
navigation: True
title: 《Effective C++》读书笔记（九）
date: 2021-08-28 18:34:13 +0800
tags: [notes]
class: post-template
subclass: 'post'
author: bbig
---

##  《Effective C++》读书笔记（九）

《 Effective C++ 改善程序与设计的 55 个具体做法》定制 new 和 delete



### 什么时候可以用到自定的 new 和 delete 

+ 为了检测运用错误
+ 为了收集动态分配内存之使用统计信息
+ 为了增加分配和归还的速度
+ 为了降低缺省内存管理器带来的空间额外开销
+ 为了弥补缺省分配器中的非最佳对齐位
+ 为了将相关对象成簇集中
+ 为了获得非传统行为



### class 专属的 new 和 delete 

``` c++
class Base
{
public:
    static void *operator new(std::size_t size) throw(std::bad_alloc);
    static void *operator delete(void *rawMemory, std::size_t size);
};
```

其 operator new 成员函数如下：

``` c++
void *Base::operator new(std::size_t size) throw(std::bad_alloc)
{
    using namespace std;
    if (size != sizeof(Base)) // 处理大小错误和 0-byte 申请
        return ::operator new(size);
    while (true)
    {
        尝试分配 size bytes;

        if (分配成功)
            return (一个指针，指向分配来的内存);

        // 分配失败：找出目前的 new-handling 函数
        new_handler globalHandler = set_new_handler(0);
        set_new_handler(globalHandler);

        if (globalHandler)
            (*globalHandler)();
        else
            throw std::bad_alloc();
    }
}
```

operator delete 成员函数：

``` c++
void Base::operator delete(void *rawMemory, std::size_t size)
{
    if (rawMemory == 0) // 检查 null 指针
        return;
    if (size != sizeof(Base)) // 处理大小错误的情况
    {
        ::operator delete(rawMemory);
        return;
    }
    现在，归还 rawMemory 所指的内存;
    return;
}
```

当然，如果你打算这么做，你还需要实现它的 array 兄弟版： **operator new[]** 。

