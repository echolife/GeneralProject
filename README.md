# GeneralProject____Object—C


我们总是想能快速的开始一个工程 组织相应的架构 利用第三方framework 创建快速的宏代码 总之都是能够快速、高效的完成项目开发。而此事例工程向大家展示了如何快速开发、集成。

## 一、环境搭建
1. [安装Xcode](https://developer.apple.com/xcode/) 
2. [安装CocoPod](https://cocoapods.org)


## 二、使用方式一

使用Tools：只使用工程中的Tools进行辅助开发

#### Tools 介绍
1. 文件目录结构

![](https://github.com/echolife/ImageSource/blob/master/59682968-05B5-409A-ABBF-0DF7240C1B2C.png?raw=true)

2. 依赖framework

![](https://github.com/echolife/ImageSource/blob/master/BC66587A-3475-4916-8120-4E39D37E8CEB.png?raw=true)


##### Categor

主要是一些常用文件的分类，并且每个分类都建立了常用方法 直接在pch 文件导入	`AllCategory.h` 即可在工程任意地方使用

![](https://github.com/echolife/ImageSource/blob/master/99BF269A-B42E-4C80-AD8E-2C54E9BD624B.png?raw=true)

##### External

存放一些不能通过pod导入的三方framework

目前导入如下：

1.[Alipy](https://docs.open.alipay.com/204/105295/)


![](https://github.com/echolife/ImageSource/blob/master/97998B73-7365-4685-B1A1-405E30C95AE2.png?raw=true)


##### Intenal
常用的内部framework

1. Customized 等待自定义

2. CustomRefresh 根据[MJRefresh]()自定义刷新header

> + `CustomRefresh` 通过播放多张图片进行动画
> + `CustomeGifRefresh` 根据拖拽程度 使用`UIBezierPat`进行绘制动画

3. FitScreen 根据屏幕尺寸 自动匹配相应的float

4. TipsView 用于请求过程中的进度展示 完成时的提示信息

5. 支付插件 集成支付宝和微信支付 在使用支付时 调用以下方法

```objc
- (void)payWihtPayment:(Payment)payment payResult:(PayResult)payresult;
```

 6. 基础控件

![](https://github.com/echolife/ImageSource/blob/master/59682968-05B5-409A-ABBF-0DF7240C1B2C.png?raw=true)

* layout  class继承 `BaseLayoutConstraint` 就可以设置不同屏幕的尺寸

![](https://github.com/echolife/ImageSource/blob/master/87732A2B-9B97-4F1F-8D6F-F432FBDE564E.png?raw=true)

![](https://github.com/echolife/ImageSource/blob/master/FB238BD2-C1BD-460D-96D7-A94B400B543C.png?raw=true)

* APIKey  用来存放需要使用到的sdk的相关信息

![](https://github.com/echolife/ImageSource/blob/master/C4931DD4-697B-4EA9-A0A9-D7574EF4F1E2.png?raw=true)

* Resource Tools使用到的相关图片

* Cell  为cell添加通用方法 利于xib导入cell

* View 为View添加方法 利于xib导入View

* ViewController 为View添加方法 方便子类实现通用方法

* Parameter 作为网络请求传参基类 实现转property为字典 解决了nil导致NSDiction崩溃问题


##### Marco

常用的宏

![](https://github.com/echolife/ImageSource/blob/master/AF3BC8D7-6D16-474F-85BE-8E442F1B259E.png?raw=true)



## 三、使用方式二 

