---
layout: post
current: post
cover: assets/images/spring.png
navigation: True
title: 《Effective C++》读书笔记（二） 
date: 2021-07-03 11:57:05
tags: [notes]
class: post-template
subclass: 'post'
author: bbig
---

##  《Effective C++》读书笔记（二）

《 Effective C++ 改善程序与设计的 55 个具体做法》条款 05 ~ 条款 07、条款39



### 可将成员函数声明为 private 以驳回编译器自动提供的机能

假如你有一个类是不希望支持拷贝操作的，但当某些人尝试调用时，编译器会自动创建拷贝构造函数或拷贝赋值运算符，此时你可以令这些函数为 private ，同时不去定义它们，如：

``` c++
class HomeForSale
{
public:
    // ...

private:
    // ...
    HomeForSale(const HomeForSale &); // 只有声明
    HomeForSale &operator=(const HomeForSale &);
};
```

这样当别人企图拷贝 HomeForSale 对象时，编译器会报错；如果是在成员函数或者友元函数中这么操作，那连接器会报错。

或者也可以像下面这样，这样可以使得连接期错误移至编译期

``` c++
class Uncopyable
{
protected:
    Uncopyable() {} // 允许派生类对象构造和析构
    ~Uncopyable() {}

private:
    Uncopyable(const Uncopyable &); // 但阻止拷贝操作
    Uncopyable &operator=(const Uncopyable &);
};

class HomeForSale : private Uncopyable
{
    // ...
};
```



### private 继承

private 继承纯粹只是一种实现技术，意味着只有部分被继承，接口部分应略去。

有两条 private 的继承规则

+ 如果是 private 继承，编译器不会自动将一个派生类对象转换为一个基类对象
+ 由 private 继承来的所有成员，在派生类中都会变成 private 属性



### 为多态基类声明 virtual 析构函数

如果一个派生类对象经由一个基类指针被删除，而其基类带着一个 non-virtual 的析构函数，实际执行时通常会让对象的派生类成分没被销毁，而其基类成分被销毁，于是造成了一个”局部销毁“对象，可能会造成资源泄漏、败坏数据结构

所以如果是带有多态性质的基类，就应该为其声明一个 virtual 析构函数，然后删除派生类对象时，就会销毁整个对象，包括派生类部分

当然如果不是作为基类或是不是为了具备多态性，就不该声明 virtual 析构函数
