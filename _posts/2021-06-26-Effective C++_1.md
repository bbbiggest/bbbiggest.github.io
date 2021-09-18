---
layout: post
current: post
cover: assets/images/design.jpg
navigation: True
title: 《Effective C++》读书笔记（一） 
date: 2021-06-26 18:23:04 +0800
tags: [notes]
class: post-template
subclass: 'post'
author: bbig
---

## 《Effective C++》读书笔记（一）

读了《 Effective C++ 改善程序与设计的 55 个具体做法》的前 4 个条款

感觉这一定是一本很棒的书



### enum

首先是学到了 enum 的一些其它用法，不仅仅是枚举类型，还可以当成一个整数**常量**来使用，这被称为 "enum hack" 。与 `#define` 类似，编译器不会为 enum **分配内存**，当然也就无法取它的地址。但不同的是，它拥有**作用域** 。"enum hack" 还是**模板元编程**的基础技术。



### 将常量性转除

有时为了使成员函数可作用于 const 对象，需要一个 const 成员函数，但这会带来**代码重复**以及伴随的编译时间、维护、代码膨胀等问题，因此需要令其中一个调用另一个，也就促使了我们将常量性转除，即可以像下面这样**令 non-const 调用 const** ：

``` c++
class TextBlock
{
public:
    // ...
    const char &operator[](std::size_t position) const
    {
        // ...
        return text[position];
    }
    char &operator[](std::size_t position)
    {
        return const_cast<char &>(
            static_cast<const TextBlock &>(*this)[position]);
    }
    // ...
};
```



### 用成员初始化列表替换赋值动作

初始化列表，书上叫它成员初值列 (member initialization list)

也就是用

``` c++
ABEntry::ABEntry(const std::string &name, const std::string &address,
                 const std::list<PhoneNumber> &phone)
    : theName(name),
      theAddress(address),
      thePhones(phones),
      numTimesConsulted(0)
{}
```

来替换

``` c++
ABEntry::ABEntry(const std::string &name, const std::string &address,
                 const std::list<PhonrNumber> &phone)
{
    theName = name;
    theAddress = address;
    thePhones = phones;
    numTimesConsulted = 0;
}
```

这是一个我以前没注意过的点，这两种构造函数我都是随机写的，不过也可能是因为我写的大部分类的成员变量都是内置类型，久而久之就忘记了这一点

后面这一种其实是**赋值**而非初始化，成员初值列的初始化动作发生在进入构造函数本体之前。也就是说，后面的写法其实相当于用成员的默认构造函数先设了一次**初值**，然乎马上又对它们赋予**新值**，所以默认构造函数所做的都浪费掉了

所以第一种更为**高效**，它只调用**一次**拷贝构造函数

