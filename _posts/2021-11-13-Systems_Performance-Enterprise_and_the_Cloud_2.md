---
layout: post
current: post
cover: assets/images/luminism_style_painting.png
navigation: True
title: 《性能之巅》读书笔记（二）
date: 2021-11-13 20:25:25 +0800
tags: [notes]
class: post-template
subclass: 'post'
author: bbig
---

##  《性能之巅：洞悉系统、企业与云计算》读书笔记（二）

基准测试



### 如何进行有效的基准测试

首先需要搞清楚几个问题：

- **测试的是什么？**
- **有哪些限制因素？**
- **有哪些干扰会影响结果？**
- **从结果可以得出什么结论？**

也就是需要深刻地**理解**基准测试软件的**运作**、系统的**响应**，以及**结果**与目标环境是如何**关联**的。

如果**不理解**测试了什么，就有可能出现：你以为测量了 A ，实际上测量了 B ，但你的结论是测量了 C 。最为典型的例子就是，想测**磁盘**性能，但实际上测试的是**文件系统**性能。

其次还要考虑各种干扰，比如你可能测 Web 延时的时候，请求被防火墙阻挡了；再比如测试的时候收到设备中断的影响，

