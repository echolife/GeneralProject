//
//  APIKey.h
//
//
//  Created by Jone on 15/10/12.
//  Copyright © 2015年 Jone. All rights reserved.
//

#ifndef APIKey_h
#define APIKey_h
#import <Foundation/Foundation.h>

//-------------------- 高德地图 ---------------------
// http://lbs.amap.com/console/key
static NSString *const gdAppID = @""; // 使用高德地图API，请注册Key，



//-------------------- 微信 ---------------------
// https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list&t=resource/res_list&verify=1&id=1417694084&token=&lang=zh_CN
static NSString *const wxAppID = @""; // APPID
static NSString *const wxAppSecret = @"";
static NSString *const MCH_ID = @"";//商户号
static NSString *const PARTNER_ID = @"";//商户API密钥


// -------------------itunesConected-------------
static NSString *const app_ItunesConected = @"itms-apps://itunes.apple.com/app/id---";


// -----------------------新浪--------------------
// http://open.weibo.com/wiki/Sdk/ios
static NSString *const wbAppID = @"";
static NSString *const wbAppSecret = @"";
static NSString *const wbredirectUrl = @"https://api.weibo.com/oauth2/default.html";

// -----------------------百度----------------------
// https://mtj.baidu.com/web/welcome/login
static NSString *const bdAnalytics = @"";
static NSString *const bdPushAppID = @"";


// -----------------------QQ-----------------------
// http://wiki.connect.qq.com/ios_sdk环境搭建
static NSString *const qqAppID = @"";
static NSString *const qqAppkey = @"";


// ----------------------支付宝----------------------
// https://docs.open.alipay.com/204/105295/
static NSString *const AlipayScheme = @"AliPayScheme";

static NSString *const Partner = @"";
                     
static NSString *const Seller = @"";

static NSString *const PrivateKey = @"";



// ----------------------shardSDK---------------------
// http://wiki.mob.com/快速集成/
static NSString *const shardAppID = @"";

static NSString *const userAgreement = @"";

static NSString *userUploadAgreement = @"/Home/Common/uploadAgreement";


#endif /* APIKey_h */
