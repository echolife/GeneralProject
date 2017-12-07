//
//  NSString+Extension.h
//  GeneralProject
//
//  Created by Jone on 2017/4/28.
//  Copyright © 2017年 Jone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

typedef NS_ENUM(NSUInteger, DateFormat) {
    DateFormatHHMMSS, // 00:00:00
    DateFormatMMSS, // 00:00
    DateFormatYYMMDDHHMMSS // 2016-01-01 00:00:00
};

@interface NSString (Extension)

+ (NSString *)fromInt:(int)value;

+ (NSString *)fromInteger:(NSInteger)value;

+ (NSString *)fromUInteger:(NSUInteger)value;

+ (NSString *)fromFloat:(float)value;

+ (NSString *)fromDouble:(double)value;

+ (NSString *)fromBool:(BOOL)value;

/**
 四舍五入 保留两位小数
 
 @param decimals 小数
 @return nss
 */
+ (NSString *)stringRoundDotTwo:(CGFloat)decimals;

+ (NSString *)date:(NSDate *)date format:(DateFormat)format;

/**
 返回安全字符串
 
 @param string 需要验证的字符串
 @return 安全的字符串
 */
+ (NSString *)safeString:(NSString *)string;

+ (NSString *)jsonSerialaztionWithDic:(NSDictionary *)dic;


- (BOOL)isNotEmpty;

- (BOOL)isChinese;

- (BOOL)isInvalidateMessage;

- (BOOL)isMatchesRegularExp:(NSString *)regex;

- (BOOL)isCellPhoneNumber;

- (BOOL)isPhoneNumber;

- (BOOL)isValidateVerifyCode;

- (BOOL)isValidatePassward;

- (NSString *)replaceCharactersAtIndexes:(NSArray *)indexes withString:(NSString *)aString;

- (NSString *)md5Capital:(BOOL)copital; // 默认小写

- (NSString *)sha1Capital:(BOOL)copital;

- (NSString *)threeDESWithEncreyptOrDecrpty:(CCOperation)operation key:(NSString *)key;

- (NSString *)dateSecondWiht:(DateFormat)format;  // 秒转换


- (NSString *)urlEncode;

- (NSString *)urlDecode;

- (NSInteger )hexInteger;

- (id)jsonObject:(NSError **)error;



@end
