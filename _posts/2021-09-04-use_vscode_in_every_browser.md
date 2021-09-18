---
layout: post
current: post
cover: assets/images/jungle.jpg
navigation: True
title: 随时随地使用 vscode
date: 2021-09-04 15:52:14
tags: [sharing]
class: post-template
subclass: 'post'
author: bbig
---

## 随时随地使用 vscode



### 背景

无意间在 github 上发现了 [code-server](https://github.com/cdr/code-server) ，它可以在**浏览器**中使用 **vscode**

然后想起来，虽然笔记本并不是很**重**，但毕竟总有**不想带**或者**没带**的时候，这个时候假如**突然**要用电脑**写个代码**，就只能借**别人的**或是用**机房的**电脑

可是这个时候就会遇到很多**问题**， ide **用不惯**都算小问题了，**没有**你需要的**环境**，然后**不得不**现场安装，**等了好久**终于装好语言之后，又要**配置**环境，然后机房电脑**重启**之后，下次又得**再来一遍**这些步骤，极其**费时费力**

但通过这个项目，把它部署到**服务器**中，然后通过 **host** 在**任何**一个**浏览器**直接使用 vscode ，也不再**局限于**电脑了， **IPad** 、甚至手机都可以直接使用 vscode ，直接**编译运行**，不再需要配置环境，可以使用你所**顺手**的**设置**、**快捷键**、**插件**等，还可以加上**密码**保证隐私，想想就**很方便**



### 实现

想在 **docker 中**运行，然后 dockerfile **写到一半**，发现 **dockerhub** 上有个**现成的** [linuxserver/code-server](linuxserver/code-server) ，嗯...连 **docker-compose** 都有了，我本来是打算把**配置**、**插件**什么的全部写进 **docker** 里面，但暂时就不**重复造轮子**了

不过我建议在 docker-compose 中**限制**一下内存，免得又**占用**很多**内存**



### 步骤

1. 在服务器**安装** docker 和 docker-compose

2. 命令行**运行** `docker pull linuxserver/code-server`

3. **编写** docker-compose.yml ，像这样

   <iframe   src="https://carbon.now.sh/embed?bg=rgba%28171%2C+184%2C+195%2C+1%29&t=one-dark&wt=none&l=application%2Fjson&ds=true&dsyoff=20px&dsblur=68px&wc=true&wa=true&pv=56px&ph=56px&ln=false&fl=1&fm=Hack&fs=14px&lh=133%25&si=false&es=2x&wm=false&code=version%253A%2520%25223%2522%250Aservices%253A%250A%2520%2520code-server%253A%250A%2520%2520%2520%2520image%253A%2520ghcr.io%252Flinuxserver%252Fcode-server%250A%2520%2520%2520%2520deploy%253A%250A%2520%2520%2520%2520%2520%2520resources%253A%250A%2520%2520%2520%2520%2520%2520%2520%2520limits%253A%250A%2520%2520%2520%2520%2520%2520%2520%2520%2520%2520cpus%253A%2520%270.50%27%250A%2520%2520%2520%2520%2520%2520%2520%2520%2520%2520memory%253A%2520512M%250A%2520%2520%2520%2520%2520%2520%2520%2520reservations%253A%250A%2520%2520%2520%2520%2520%2520%2520%2520%2520%2520cpus%253A%2520%270.25%27%250A%2520%2520%2520%2520%2520%2520%2520%2520%2520%2520memory%253A%2520256M%250A%2520%2520%2520%2520container_name%253A%2520code-server%250A%2520%2520%2520%2520environment%253A%250A%2520%2520%2520%2520%2520%2520-%2520PUID%253D1000%250A%2520%2520%2520%2520%2520%2520-%2520PGID%253D1000%250A%2520%2520%2520%2520%2520%2520-%2520TZ%253DEurope%252FLondon%250A%2520%2520%2520%2520%2520%2520-%2520PASSWORD%253Dabc%2520%2523optional%250A%2520%2520%2520%2520%2520%2520-%2520HASHED_PASSWORD%253D%2520%2523optional%250A%2520%2520%2520%2520%2520%2520-%2520SUDO_PASSWORD%253Dabc%2520%2523optional%250A%2520%2520%2520%2520%2520%2520-%2520SUDO_PASSWORD_HASH%253D%2520%2523optional%250A%2520%2520%2520%2520%2520%2520-%2520PROXY_DOMAIN%253Dcode-server.my.domain%2520%2523optional%250A%2520%2520%2520%2520volumes%253A%250A%2520%2520%2520%2520%2520%2520-%2520%252Fpath%252Fto%252Fappdata%252Fconfig%253A%252Fconfig%250A%2520%2520%2520%2520ports%253A%250A%2520%2520%2520%2520%2520%2520-%25208443%253A8443%250A%2520%2520%2520%2520restart%253A%2520unless-stopped"   style="width: 589px; height: 671px; border:0; transform: scale(1); overflow:hidden;"   sandbox="allow-scripts allow-same-origin"> </iframe>

4. 在你含有 docker-compose.yml 的文件夹中，**执行** `docker-compose up`

5. 在任意**浏览器**打开你服务器的 Host + ":8443" ，即可打开 vscode ，**密码**刚刚设的是 abc

6. 要**停止**的话就 ctrl+C 或者使用 `docker-compose stop` 命令



### 实际效果

**插件**什么的也**可以安装**，**域名**也都**可以改**，应该也可以同时部署**多个 code-server**

所以**理论上**应该非常好用，我找同学借了个服务器**试了下**，效果如下：

![2021-09-04-use_vscode_in_every_browser-photo_1](https://bbbiggest.github.io/assets/images/2021-09-04-use_vscode_in_every_browser-photo_1.png)

但是...其实...**挺卡的**，在把它变得**足够快**之前，什么域名、同时部署多个 code-server ，都得**先放放**

