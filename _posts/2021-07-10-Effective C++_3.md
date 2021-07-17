---
layout: post
current: post
cover: assets/images/Effective_C++_3.jpg
navigation: True
title: 《Effective C++》读书笔记（三）
date: 2021-07-10 20:11:06
tags: [notes]
class: post-template
subclass: 'post'
author: bbig
---

##  《Effective C++》读书笔记（三）

《 Effective C++ 改善程序与设计的 55 个具体做法》条款 08 ~ 条款 12



### 在构造和析构期间不要调用 virtual 函数

假如你在**基类**的**构造**函数中调用了一个**虚函数**，然后当你在建立一个**派生类**对象时，会发现它调用的那个**虚函数**并不是你想要的那个版本

因为在派生类的构造函数**调用之前**，基类的构造函数一定会被**更早**的调用，然后在**基类构造期间**，派生类的成员变量并**未初始化**，你所建立的对象类型暂时是**基类**的而不是派生类的，如果使用运行期类型信息，也会把对象视为**基类类型**，所以调用的那个虚函数也就不会**下降**到派生类阶层，对象在**派生类构造函数执行前**不会成为一个派生类对象。**析构**函数也是同理

所以要想解决这个问题，可以令派生类将必要的**构造信息向上传递**至基类构造函数，如：

``` c++
class Transaction
{
public:
    explicit Transaction(const std::string &logInfo);
    void logTransaction(const std::string &logInfo) const;
    // ...
};
Transaction::Transaction(const std::string &logInfo)
{
    // ...
    logTransaction(logInfo); // 非虚函数的调用
}
class BuyTransaction : public Transaction
{
public:
    BuyTransaction(parameters)
        : Transaction(createLogString(parameters)) // 将log信息传给基类构造函数
    {
        // ...
    }

private:
    static std::string createLogString(parameters);
};
```

其中 createLogString 函数是**静态**的，也就不可能意外地指向**尚未初始化**的成员变量



### std::abort()

**中止**当前进程，产生程序终止的异常。

没有返回值，而且程序终止时不会破坏任何对象，不会导致数据竞争。

如果一个程序遇到”于析构期间发生的错误”后无法继续执行，就可以制作运转记录，记下这个失败，然后调用 `std::abort()` 结束程序，这样可以**阻止异常从析构函数传播出去**。因为从**析构**函数中**抛出异常**是危险的，如果抛出发生在**堆栈展开**操作期间（如另一个异常已经在传播），程序通常会**崩溃**；如果子类析构函数抛出异常，则不会调用父析构函数，会使对象处于部分销毁状态。所以如果一个被析构函数调用的函数可能抛出异常，析构函数应该**捕捉**任何异常，然后**吞下它们**或**结束程序**。



### 确保 operator= 能正确处理自我赋值

下面是自我赋值时并**不安全**的实现代码：

``` c++
class Bitmap {};
class Widget
{
private:
    Bitmap *pb;
};

Widget &Widget::operator=(const Widget &rhs)
{
    delete pb;
    pb = new Bitmap(*rhs.pb);
    return *this;
}
```

假如 *this 和 rhs 是**同一个**对象时， delete 销毁操作之后，`*rhs.pb` 所指向的就是一个**已被删除**的对象

所以如果想解决这个问题，可以先进行”**证同测试** (identity test) “，如果是自我赋值则不做任何事情。或者可以精心安排一下**语句顺序**，记住原先的 pb ，然后先复制再删除

可以使用 **copy and swap** 技术：

``` c++
class Widget
{
    // ...
    void swap(Widget &rhs); // 交换*this和rhs的数据
};

Widget &Widget::operator=(const Widget &rhs)
{
    Widget temp(rhs);
    swap(temp);
    return *this;
}
```

