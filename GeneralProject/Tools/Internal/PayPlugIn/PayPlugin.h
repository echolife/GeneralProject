//
//  PayPlugin.h
//  GeneralProject
//
//  Created by Jone on 2017/5/6.
//  Copyright © 2017年 Jone. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <WechatOpenSDK/WXApi.h>
#import <AlipaySDK/AlipaySDK.h>

typedef NS_ENUM(NSUInteger, Payment) {
    PaymentWechat = 0,
    PaymentApipay,
};

typedef void (^PayResult)(Payment payment, NSError *error);

@interface PayPlugin : NSObject<WXApiDelegate>

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(PayPlugin)

//---------支付宝本地签名使用-----------
@property (nonatomic, copy)  NSString *sn;//订单号
@property (nonatomic, copy)  NSString *productTitle;//标题
@property (nonatomic, copy)  NSString *productDesc;//产品详情
@property (nonatomic, copy)  NSString *productPrice;//产品价格 单位分
@property (nonatomic, copy)  NSString *notiUrl;//通知地址


@property (nonatomic, copy)  NSString *AlipaySignData;//支付宝订单签名字符串
@property (nonatomic, copy)  NSString *AlipayData;//支付宝订单字符串


//----------微信用------------
/** wx8888888888888888    微信开放平台审核通过的应用APPID */
@property (copy, nonatomic) NSString *appId;
/** 商家向财付通申请的商家id */
@property (nonatomic, copy) NSString *partnerId;
/** 预支付订单 */
@property (nonatomic, copy) NSString *prepayId;
/** 随机串，防重发 */
@property (nonatomic, copy) NSString *nonceStr;
/** 时间戳，防重发 */
@property (nonatomic, assign) UInt32 timeStamp;
/** 商家根据财付通文档填写的数据和签名 */
@property (nonatomic, copy) NSString *package;

/** 由用户微信号和AppID组成的唯一标识，发送请求时第三方程序必须填写，用于校验微信用户是否换号登录*/
@property (nonatomic, copy) NSString *openID;



- (void)payWihtPayment:(Payment)payment payResult:(PayResult)payresult;

- (void)dispatchAlipayPayResult:(NSDictionary *)resultDic;


@end
