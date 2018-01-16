//
//  ConstantMarco.h
//  GeneralProject
//
//  Created by Jone on 2017/4/28.
//  Copyright © 2017年 Jone. All rights reserved.
//

#ifndef ConstantMarco_h
#define ConstantMarco_h




//----------------------------设备信息------------------


#define kStatus_H [[UIApplication sharedApplication] statusBarFrame].size.height


//获取屏幕 宽度、高度
#define SCREEN_W ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_H ([UIScreen mainScreen].bounds.size.height)

//获取视图宽高
#define VIEW_W(view) view.frame.size.width
#define VIEW_H(view) view.frame.size.height

// ios 屏幕比例
#define SCREEN_SCALE_IOS [UIScreen mainScreen].scale

//----------------------------app信息------------------

#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define kAppBuild [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#define kAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

//-------------------打印日志----------------------------
//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

//DEBUG  模式下打印日志,当前行 并弹出一个警告
#ifdef DEBUG
#define NSL(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define NSL(...)
#endif




//----------------------系统----------------------------
//获取系统版本
#define CURRENT_VER [[[UIDevice currentDevice] systemVersion] floatValue]   //浮点型
#define CURRENT_VER_IOS7_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) // 当前版本大于iOS7.0


//判断是否 Retina屏、设备是否%fhone 5、是否是iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)
#define IS_IPAD_BIG (IS_IPAD && SCREEN_MAX_LENGTH == 1366.0)  // 针对 2732*2048 的IPD

//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

#define AppDidEnterBackgroundNotification @"AppDidEnterBackgroundNotification"
#define AppWillEnterForegroundNotification @"AppWillEnterForegroundNotification"

#define weak_self(A_Self)  __weak typeof(self) weakSelf = a_self;


//---------------------View------------
//View圆角和加边框
#define ViewBorderRadius(View,Radius,Width,Color)\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]




//----------------------图片----------------------------
//读取本地图片
#define INMAGE_BUNDLE(name,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:type]]
//读取图片
#define IMAGE_NAME(name) [UIImage imageNamed:name]



//----------------------YYModel定义----------------------------
#define YYModelSynthCoderAndHash \
- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; } \
- (id)initWithCoder:(NSCoder *)aDecoder { return [self yy_modelInitWithCoder:aDecoder]; } \
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; } \
- (NSUInteger)hash { return [self yy_modelHash]; } \
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }





#endif /* ConstantMarco_h */
