---
layout: post
current: post
cover: assets/images/Lake_Biwa.png
navigation: True
title: 如何更优雅的表示红黑树结点
date: 2022-07-25 05:08:52 +0800
tags: [notes]
class: post-template
subclass: 'post'
author: bbig
---

# 如何更优雅的表示红黑树结点

我们正常红黑树的结点定义是：

```
struct rb_node
{
   struct rb_node *rb_parent;
   int rb_color;
   struct rb_node *rb_right;
   struct rb_node *rb_left;
};
```

但在 Linux 内核中，它是这么定义的：

```
struct rb_node {
unsigned long  __rb_parent_color;
struct rb_node *rb_right;
struct rb_node *rb_left;
} __attribute__((aligned(sizeof(long))));
   /* The alignment might seem pointless, but allegedly CRIS needs it */
​
struct rb_root {
struct rb_node *rb_node;
};
​
#define rb_parent(r)   ((struct rb_node *)((r)->__rb_parent_color & ~3))
```

它把 parent 和 color 放在一起了，但为什么可以呢，明明 `sizeof(struct rb_node *) == sizeof(unsigned long)` ，并没有多出来的位置。

看下面的那行宏 `#define rbparent(r) ((struct rbnode *)((r)->_rbparent_color & ~3))` ，它是把后两位置零之后，当作父结点的指针。那也就是说，它能保证父结点的指针后面两位都是 0 。

再看结构体后面的 `attribute((aligned(sizeof(long))))` ，它告诉编译器确保 `struct rb_node` 的大小始终是 `sizeof(long)` 的倍数。这一点貌似没什么用， `sizeof(struct rb_node *) == sizeof(long)` ，这三个本来就一样大。

再看下面的注释 `/ The alignment might seem pointless, but allegedly CRIS needs it /` —— ”对齐可能看起来毫无意义，但据称 CRIS 需要它“。

提交记录里说到：

> [RBTREE] Add explicit alignment to sizeof(long) for struct rb_node.
>
> Seems like a strange requirement, but allegedly it was necessary for struct address_space on CRIS, because it otherwise ended up being only byte-aligned. It's harmless enough, and easier to just do it than to prove it isn't necessary... although I really ought to dig out my etrax board and test it some time.

这个 [CRIS](https://en.wikipedia.org/wiki/ETRAX_CRIS) 是 RISC ISA 的一系列 CPU，它可能对地址有某种要求。

像《深入理解计算机系统》第 3.9.3 节（P189）数据对齐中也有提到：

> 许多计算机系统对基本数据类型的合法地址做出了一些限制，要求某种类型的对象的地址必须是某个值 K（通常是 2、4 或 8）的倍数。这种对齐限制简化了形成处理器和内存系统之间接口的硬件设计。例如，假设一个处理器总是从内存中取 8 个字节，则地址必须为 8 的倍数。如果我们能保证将所有的 double 类型数据的地址对齐成 8 的倍数，那么就可以用一个内存操作来读或者写值了。否则，我们可能需要执行两次内存访问，因为对象可能被分放在两个 8 字节内存块中。

而这个 `aligned(sizeof(long))` 对齐实际上是 `kmalloc` 对齐分配的函数。

`kmalloc` 在 32 位 CPU 上保证 4 字节对齐，在 64 位 CPU 上保证 8 字节对齐。也就是至少保证了 4 字节对齐。

所以它分配的地址都会是 4 的倍数，在二进制上后两位都会是 0。于是开发人员就将这两个位用于颜色。
