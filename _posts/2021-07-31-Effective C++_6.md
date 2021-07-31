---
layout: post
current: post
cover: assets/images/puppy.jpg
navigation: True
title: 《Effective C++》读书笔记（六）
date: 2021-07-31 14:13:09
tags: [notes]
class: post-template
subclass: 'post'
author: bbig
---

##  《Effective C++》读书笔记（六）

《 Effective C++ 改善程序与设计的 55 个具体做法》实现



### “异常安全”

假设有个希望用于**多线程**环境的 class 如下：

```c++
class PrettyMenu
{
public:
    void changeBackground(std::istream &imgSrc);

private:
    Mutex mutex;
    Image *bgImage;
    int imageChanges;
}
```

它改变背景图像的 changeBackground 函数的一个可能实现如下：

``` c++
void PrettyMenu::changeBackground(std::istream &imgSrc)
{
    lock(&mutex);
    delete bgImage;
    ++imageChanges;
    bgImage = new Image(imgSrc);
    unlock(&mutex);
}
```

但当 `new Image(imgSrc)` **抛出异常**时，就不会执行 unlock 的调用，互斥器就会永远被把持住了；而且此时 bgImage 指向的是一个已删除的对象。这就导致了**资源泄露**和**数据败坏**，所以从“异常安全性”的角度来看，这个函数很糟，它没有满足“异常安全”的任何一个条件。



### 异常安全函数的三个保证

1. **基本承诺**：当异常被抛出时，程序内的任何事物仍然保持在**有效**条件下。
2. **强烈保证**：如果异常被抛出，程序状态**不改变**。即，如果函数成功，就是完全成功；如果失败则会回到调用函数之前的状态。
3. **不抛掷保证**：承诺**绝不抛出异常**，因为它们总是能够完成它们原先承诺的功能。

异常安全码 (Exception-safe code) **必须**提供上述三种保证之一。如果没有，则它就不具备**异常安全性**。

为此，我们可以**以对象管理资源**、**重新排列语句次序**、使用 "**copy and swap**" 策略，如：

``` c++
struct PMImpl
{
    std::tr1::shared_ptr<Image> bgImage;
    int imageChanges;
};
class PrettyMenu
{
    // ...
private:
    Mutex mutex;
    std::tr1::shared_ptr<PMImpl> pImpl;
};
void PrettyMenu::changeBackground(std::istream &imgSrc)
{
    using std::swap;
    Lock ml(&mutex);
    std::tr1::shared_ptr<PMImpl> pNew(new PMImpl(*pImpl));
    pNew->bgImage.reset(new Image(imgSrc));
    ++pNew->imageChanges;
    swap(pImpl, pNew);
}
```

与一开始的代码相比，首先导入了 Lock 类（详见[读书笔记（四）](https://bbbiggest.github.io/Effective-C++_4)），确保互斥器被**及时释放**。

然后使用了 reset 函数，使得 delete 只在 reset 函数内被使用，所以只有参数 `new Image(imgSrc)` 被成功**生成之后**才会被调用。

最后所有的修改都是在**副本**上，原对象保持**未改变**状态，待**所有改变都成功后**再进行置换。

