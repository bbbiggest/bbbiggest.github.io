---
layout: post
current: post
cover: assets/images/snow_forest_under_the_setting_sun.png
navigation: True
title: 《计算机网络》读书笔记（七）
date: 2022-01-01 17:04:32 +0800
tags: [notes]
class: post-template
subclass: 'post'
author: bbig
---

##  《计算机网络 自顶向下方法》读书笔记（七）

运输层



### TCP 拥塞控制算法

TCP 拥塞控制算法包括 **3 个**部分：

1. **慢启动**
2. **拥塞避免**
3. **快速恢复**

其中，前两个是 TCP 的**强制**部分



![2022-01-01-TCP_congestion_control_algorithm](https://bbbiggest.github.io/assets/images/2022-01-01-TCP_congestion_control_algorithm.png)



#### 慢启动

当一条 TCP 连接**开始时**，TCP 的发送方为了**快速找到**可用带宽的数量，通常**拥塞窗口 (cwnd)** 的值会从 1 个 MSS 开始，并且每当传输的报文段首次被确认就**增加**一个 MSS 。第一个被确认就加一个 MSS ，然后这两个都被确认就再加两个，以这种**翻倍**的速率增加。

但是这种指数增长不可能一直持续下去，有**三种**方式结束：

- 当出现一个由**超时**指示的**丢包**事件时， TCP 发送方将 **cwnd 设置为 1** ，将**慢启动阈值 (ssthresh)** 并重新开启慢启动过程
- 当**到达或超过 ssthresh** 的值时，结束慢启动并且 TCP 转移到**拥塞避免模式**
- 检测到 3 个冗余 ACK 时，TCP 执行一种快速重传，并进入快速恢复状态



#### 拥塞避免

进入拥塞避免状态时， cwnd 的值大约是上次遇到拥塞时的值的一半，于是采用一种较为保守的方法：每个 RTT 只将 cwnd 的值**增加一个** MSS 。

结束线性增长有两种情况：

- 当丢包事件由**超时**触发时， cwnd 的值被设置为 **1 个** MSS ， ssthresh 的值被更新为 cwnd 值的**一半** 
- 当丢包事件由**三个冗余 ACK** 触发时，cwnd 的值**减半**（为了使测量结果更好，要加上 3 个 MSS ），将 ssthresh 的值记录为 cwnd 值的**一半**，然后**进入快速恢复状态**



#### 快速恢复

- 对引起 TCP 进入快速恢复的缺失报文段，对收到的**每个**冗余的 ACK ， cwnd 的值增加**一个** MSS ，最终当丢失报文段的一个 ACK 到达时， TCP 在降低 cwnd 的值后**进入拥塞避免状态**
- 当出现超时指示的丢包事件时， cwnd 的值被设置为 **1 个** MSS ，并将 ssthresh 的值设为 cwnd 值的**一半**

