---
layout: post
current: post
cover: assets/images/couple_sitting_in_the_pavilion.png
navigation: True
title: 《计算机网络》读书笔记（六）
date: 2021-12-25 21:17:31 +0800
tags: [notes]
class: post-template
subclass: 'post'
author: bbig
---

##  《计算机网络 自顶向下方法》读书笔记（六）

运输层



#### 实践中所采用的两种主要拥塞控制方法



![2021-12-25-congestion_control_method](https://bbbiggest.github.io/assets/images/2021-12-25-congestion_control_method.png)



##### 端到端拥塞控制

- **默认**因特网版本的 **IP 和 TCP** 采用端到端拥塞控制方法。
- 网络层**没有**为运输层拥塞控制提供显示帮助。

- 即使网络中存在拥塞，端系统也必须通过对网络行为的观察（丢失与时延）来推断之。



##### 网络辅助的拥塞控制

- 路由器向发送方提供关于网络中拥塞状态的**显示反馈信息**。可以简单地用一个比特来指示链路中的拥塞情况。
- 两种反馈路径：
  - **直接网络反馈**：可以由网络路由器发给发送方。通常采用一种**阻塞分组** (choke packet) 的形式。
  - **经由接收方的网络反馈**：相比与直接网络反馈，这种形式的通知更**通用**。
    - 路由器**标记或更新**从发送方流向接收方的分组中的某个字段来指示拥塞的产生。一旦接收到一个标记的分组后，接收方就会向发送方通知该网络拥塞指示。
    - 至少要经过**一个完整的往返时间**。



