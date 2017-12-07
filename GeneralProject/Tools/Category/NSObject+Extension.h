//
//  NSObject+Extension.h
//  GeneralProject
//
//  Created by Jone on 2017/4/28.
//  Copyright © 2017年 Jone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

//------------------------------通知------------------
- (BOOL)isAllowedNotification;






//-------------------------------属性------------------

- (NSMutableArray *)attributeList;




//-------------------------------设备------------------

/*当前设备的系统版本号*/
- (float)deviceSystemVersion;

/*当前设备模型*/
- (NSString *)deviceModel;

/*当前系统语言*/
- (NSString *)appleLanguages;



//------------------------------Doucuments--------------
- (uint64_t)getFreeDiskspace;

- (uint64_t)getTotalDiskspace;


- (NSString *)applicationDocumentsDirectory;


//--------------------------------md5--------------------

- (NSString *)md5Capital:(BOOL)copital; // 默认小写




//-------------------------------class------------------

/*判断是否为字符串*/
- (BOOL)isString;

/*判断是否为NSArray*/
- (BOOL)isArray;

/*判断是否为不为空的NSArray*/
- (BOOL)isEmptyArray;

- (BOOL)isNotEmptyArray;

/*判断是否为NSDictionary*/
- (BOOL)isDictionary;

- (BOOL)isEmptyDictionary;

- (BOOL)isNotEmptyDictionary;

// 是否是空
- (BOOL)isNotNil;


//----------------------------------Function----------------
- (BOOL)openURL:(NSURL *)url;

- (void)sendMail:(NSString *)mail;

- (void)sendSMS:(NSString *)number;

- (void)callNumber:(NSString *)number;



- (BOOL)deviceIsSuportFingerprint;

- (NSInteger)numberWithHexString:(NSString *)hexString;

/*注册成为指定消息的观察者*/
- (void)observeNotificaiton:(NSString *)name;

- (void)observeNotificaiton:(NSString *)name selector:(SEL)selector;

- (void)unobserveNotification:(NSString *)name;

- (void)unobserveAllNotification;

- (void)postNotification:(NSString *)name;

- (void)postNotification:(NSString *)name object:(id)object;

- (void)postNotification:(NSString *)name userInfo:(NSDictionary *)userInfo;

- (void)postNotification:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo;

@end
