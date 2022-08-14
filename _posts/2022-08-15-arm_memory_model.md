---
layout: post
current: post
cover: assets/images/cocora_valley_wax_palm_tree.png
navigation: True
title: Arm 内存模型
date: 2022-08-15 07:10:53 +0800
tags: [notes]
class: post-template
subclass: 'post'
author: bbig
---
# Arm 内存模型

## 硬件的内存模型

### SC (Sequential consistency)

所有内存操作都按照代码序来执行。所有的操作都有一个全局的顺序，即在每个线程上观察到的顺序都是一致的。


### TSO (Total store order)

在操作不同地址时，允许 "store load" 乱序。x86 架构使用的就是 TSO 模型。


### Weak (Weak memory model)

有依赖关系的才不会乱序（地址依赖、数据依赖、控制依赖）。Arm 架构使用的是 Weak 模型。Arm 提供了内存 barrier 指令，可以用来保证顺序。


## Arm barriers

分为数据访问屏障 (Load-Acquire/Store-Release, DMB, DSB) 和指令同步屏障 (ISB)。

- 数据访问屏障 (Data access barriers)
  - Data Memory Barrier (DMB)
  - Data Synchronization Barrier (DSB)
  - Load-Acquire, Store-Release
- 指令同步屏障 (Instruction synchronization barrier)
  - Instruction Synchronization Barrier(ISB)

其中 Load-Acquire / Store-Release，是半屏障，比较轻量级。其他的为双向屏障。

严格程度为 Load-Acquire / Store-Release < DMB < DSB < ISB 。
