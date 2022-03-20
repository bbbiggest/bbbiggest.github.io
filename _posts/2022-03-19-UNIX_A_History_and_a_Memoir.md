---
layout: post
current: post
cover: assets/images/Sci_Fi-Landscape.jpg
navigation: True
title: 《UNIX 传奇：历史与会议》读书笔记
date: 2022-03-19 00:50:43 +0800
tags: [notes]
class: post-template
subclass: 'post'
author: bbig
---

#  《UNIX 传奇：历史与会议》读书笔记

《UNIX 传奇：历史与会议》布莱恩 · W. 克尼汉



## UNIX 出现背景

1964 年麻省理工推出了 CTSS （兼容**分时**系统），与当时主流的“**批处理**”系统相比，操作系统在用户之间快速轮转，使每个用户都感受不到其他用户的存在，体验极佳。

于是麻省理工、GE、贝尔实验室三者决定做一个更好的版本，也就是 Multics 系统，意为多路复用信息和计算服务 (Multiplexed Information and Computing Service) 。

但由于它被“**过度设计**”，最终系统过于**复杂**，无法实现以合理的代价为贝尔实验室提供计算服务的目标，并且太贵了，最后贝尔实验室退出了 Multics 项目。所以后来的 **UNIX** 也吸取了 Multics 的**教训**，**UNICS** 代表“**毫不复杂的信息与计算服务**” (UNiplexed Information and Computing Service) ，但后来由于某些原因，UNICS 改为了 UNIX。



### 第二系统效应 (second system effect) 

在首个系统（如 CTSS）创建成功后，打算创建一个新系统，修正旧系统的遗留问题，还要添加每个人期望的新特性，结果常常是塞了太多不同东西进去，最终得到过于复杂的系统。

Multics 就算是“第二系统效应”的受害者，

