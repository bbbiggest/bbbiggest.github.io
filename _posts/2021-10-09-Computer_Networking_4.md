---
layout: post
current: post
cover: assets/images/little_flamingos.png
navigation: True
title: 《计算机网络》读书笔记（四）
date: 2021-10-09 16:21:19 +0800
tags: [notes]
class: post-template
subclass: 'post'
author: bbig
---

##  《计算机网络 自顶向下方法》读书笔记（四）

运输层



### 比特交替协议 (alternating-bit protocol)

即 **rdt3.0**(reliable data transfer protocol) ，具有**比特差错**的**丢包**信道的可靠数据传输。其运行需要的必不可少的机制包括：检验和、序号、定时器、肯定和否定分组。

协议运作的情况如下：

![2021-10-09-Computer_Networking_4-photo_1](https://bbbiggest.github.io/assets/images/2021-10-09-Computer_Networking_4-photo_1.jpg)



#### 自动重传请求协议

报文接收者在收到分组后，使用**肯定确认** (positive acknowledgment) 与**否定确认** (negetive acknowledgment) 来**反馈**给发送方。这些控制报文使得接收方可以让发送方知道哪些内容被**正确接收**，哪些内容接收有误并因此**需要重复**。基于这样重传机制的可靠数据传输协议称为**自动重传请求** (Automatic Repeat reQuest, ARQ) **协议**。 ARQ 协议中还需要另外三种协议来处理比特差错的情况：

+ **差错检测**。它首先需要使接收方检测到何时出现了比特差错，可以通过额外的比特来存放**检验和**字段。

+ **接收方反馈**。接收方需要提供明确的反馈信息给发送方，以使发送方了解接收方情况。

+ **重传**。当接收方收到有差错的分组时，发送方将重传该分组文。



#### 序号

在数据分组中添加一新字段，让发送方对其数据**分组编号**，即将发送数据分组的**序号** (sequence number) 放在该字段。接收方只需要检查序号即可确定收到的分组是否一次重传



#### 基于时间的重传机制

需要一个**倒计数定时器** (countdown timer) ，在给定的时间量过期后，可**中断**发送方。发送方需要能做到：

+ 每次发送一个分组时，便启动一个定时器。
+ 响应定时器中断。
+ 终止定时器。

