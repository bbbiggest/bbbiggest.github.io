---
layout: post
current: post
cover: assets/images/a_pair_of_foxes.png
navigation: True
title: 《程序员修炼之道》读书笔记（三）
date: 2022-06-20 07:54:50 +0800
tags: [notes]
class: post-template
subclass: 'post'
author: bbig
---

## 《程序员修炼之道》读书笔记（三）



### 基本工具 The Basic Tools

### 纯文本

缺点主要有两个：

1. 与压缩的二进制格式相比，存储纯文本所需空间更多。
2. 要解释及处理纯文本文件，计算上的代价可能更昂贵。



优点：

1. 保证不过时

   人能够阅读的数据形式，以及自描述的数据，将比所有其他的数据形式和创建它们的应用都活得更长久。

2. 杠杆作用

   实际上，计算世界中的每一样工具，从源码管理系统到编译器环境，再到编辑器及独立的过滤器，都能够在纯文本上进行操作。就像 UNIX 哲学：“提供“锋利”的小工具、其中每一样都意在把一件事情做好——Unix因围绕这样的哲学进行设计而著称。”

3. 更易于测试

   如果你用纯文本创建用于驱动系统测试的合成数据，那么增加、更新、或是修改测试数据就是一件简单的事情，而且无须为此创建任何特殊工具。