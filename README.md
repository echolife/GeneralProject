# GeneralProject____Object—C

[TOC]

我们总是想能快速的开始一个工程 组织相应的架构 利用第三方framework 创建快速的宏代码 总之都是能够快速、高效的完成项目开发。而此事例工程向大家展示了如何快速开发、集成。

## 一、环境搭建
1. [安装Xcode](https://developer.apple.com/xcode/) 
2. [安装CocoPod](https://cocoapods.org)


## 二、使用方式一
使用Tools：只使用工程中的Tools进行辅助开发
#### Tools 介绍
* 文件初级目录结构

![](https://github.com/echolife/ImageSource/blob/master/59682968-05B5-409A-ABBF-0DF7240C1B2C.png?raw=true)

* Categor

	主要是一些常用文件的分类，并且每个分类都建立了常用方法 直接在pch 文件导入 `AllCategory.h` 即可在工程任意地方使用

* External

	存放一些不能通过pod导入的三方framework

* Intenal

	常用的内部framework

* Marco

	常用的宏



## 三、使用方式二 
使用Tools
