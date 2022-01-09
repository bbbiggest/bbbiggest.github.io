---
layout: post
current: post
cover: assets/images/mountain_stream.png
navigation: True
title: 《计算机网络》读书笔记（一）
date: 2021-09-18 23:31:16 +0800
tags: [notes]
class: post-template
subclass: 'post'
author: bbig
---

##  《计算机网络 自顶向下方法》读书笔记（一）

计算机网络和因特网



### 网络核心

网络核心，即由互联因特网端系统的**分组交换机**和**链路**构成的**网状网络**。



#### 分组交换

在网络应用中，端系统彼此交换**报文** (message) 。报文能够包含协议设计者需要的任何东西，包括执行一种控制功能、数据等。

为了从源端系统向目的端系统发送一个报文，源将长报文划分为较小的数据块，称之为**分组** (packet) 。

在源和目的地之间，每个分组都通过通信链路和**分组交换机** (packet switch) 传送。交换机主要有两种：**路由器** (router) 和**链路层交换机** (link-layer switch) 。

分组以等于该链路**最大传输速率**的速度传输通过通信链路。因此，如果某源端系统或分组交换机经过一条链路发送一个 L 比特的分组，链路的传输速率为 R 比特/秒，则传输该分组的时间为 L/R 秒。

多数分组交换机在链路的**输入端**使用**存储转发传输**，存储转发传输是指交换机必须接收到**整个**分组之后，才能够开始向输出链路传输该分组的第一个比特。

在因特网中，每台路由器具有一个**转发表** (forwarding table) ，用于将目的地址**映射**成为输出链路。因特网具有一些特殊的**路由选择协议** (routing protocol) ，用于**自动地**设置这些转发表。

每台分组交换机有**多条**链路与之相连，对于每条相连的链路，该分组交换机具有一个**输出缓存** (output buffer) ，用于**存储**路由器准备发往那条链路的分组。



#### 电路交换

在电路交换网络中，在端系统间进行通信会话期间，**预留**了端系统间沿路径通信所需要的资源。即主机 A 为了向主机 B 发送报文，网络必须在两条链路的每条上先预留一条电路。因此原则上**不需要排队**，也不会出现拥塞。

链路中的电路是通过**频分复用** (Frequency-Division Multiplexing, FDM) 或**时分复用** (Time-Division Multiplexing, TDM) 来实现的。对于 FDM ，在连接期间链路为每条连接专用**一个频段**，每条电路连续地得到**部分带宽**。对于 TDM ，时间被划分为固定期间的帧，并且每个帧又被划分为固定数量的**时隙**，每条电路在短时间间隔中**周期性地**得到**所有带宽**。



#### 分组交换与电路交换的对比

+ 分组交换提供了比电路交换更好的**带宽共享**
+ 分组比电路交换更**简单**、更**有效**，实现**成本更低**

+ 分组交换的端到端时延是**可变**的和**不可预测**的，不适合实时服务

+ 电路交换不考虑需求，而**预先分配**了传输链路的使用。分组交换**按需分配**链路使用

**趋势**是朝着**分组交换**方向发展
