---
layout: post
current: post
cover: assets/images/jungle.jpg
navigation: True
title: 随时随地使用 vscode
date: 2021-09-03 15:52:14
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

   ``` json
   version: "3"
   services:
     code-server:
       image: ghcr.io/linuxserver/code-server
       deploy:
         resources:
           limits:
             cpus: '0.50'
             memory: 512M
           reservations:
             cpus: '0.25'
             memory: 256M
       container_name: code-server
       environment:
         - PUID=1000
         - PGID=1000
         - TZ=Europe/London
         - PASSWORD=abc #optional
         - HASHED_PASSWORD= #optional
         - SUDO_PASSWORD=abc #optional
         - SUDO_PASSWORD_HASH= #optional
         - PROXY_DOMAIN=code-server.my.domain #optional
       volumes:
         - /path/to/appdata/config:/config
       ports:
         - 8443:8443
       restart: unless-stopped
   ```

4. 在你含有 docker-compose.yml 的文件夹中，**执行** `docker-compose up`

5. 在任意**浏览器**打开你服务器的 Host + ":8443" ，即可打开 vscode ，**密码**刚刚设的是 abc

6. 要**停止**的话就 ctrl+C 或者使用 `docker-compose stop` 命令



### 实际效果

**插件**什么的也**可以安装**，**域名**也都**可以改**，应该也可以同时部署**多个 code-server**

所以**理论上**应该非常好用，我找同学借了个服务器**试了下**，效果如下：

![2021-09-04-use_vscode_in_every_browser-photo_1](https://bbbiggest.github.io/assets/images/2021-09-04-use_vscode_in_every_browser-photo_1.png)

但是...其实...**挺卡的**，在把它变得**足够快**之前，什么域名、同时部署多个 code-server ，都得**先放放**

