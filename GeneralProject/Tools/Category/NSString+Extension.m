//
//  NSString+Extension.m
//  GeneralProject
//
//  Created by Jone on 2017/4/28.
//  Copyright © 2017年 Jone. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>
#import <GTMBase64/GTMBase64.h>


@implementation NSString (Extension)

+ (NSString *)fromInt:(int)value {
    return [NSString stringWithFormat:@"%d", value];
}

+ (NSString *)fromInteger:(NSInteger)value {
    return [NSString stringWithFormat:@"%ld", (long)value];
}

+ (NSString *)fromUInteger:(NSUInteger)value {
    return [NSString stringWithFormat:@"%lu", (unsigned long)value];
}

+ (NSString *)fromFloat:(float)value {
    return [NSString stringWithFormat:@"%f", value];
}

+ (NSString *)fromDouble:(double)value {
    return [NSString stringWithFormat:@"%f", value];
}

+ (NSString *)fromBool:(BOOL)value {
    return [NSString stringWithFormat:@"%d", value];
}

+ (NSString *)stringRoundDotTwo:(CGFloat)decimals {
    return [NSString stringWithFormat:@"%.2f", decimals];
}

+ (NSString *)date:(NSDate *)date format:(DateFormat)format {
    NSString *dateStr = @"";
    NSString *formatStr = @"yy-MM-dd HH:mm:ss";
    
    switch (format) {
        case DateFormatHHMMSS:
          formatStr = @"HH:mm:ss";
            break;
            case DateFormatYYMMDDHHMMSS:
            break;
            case DateFormatMMSS:
            formatStr = @"mm:ss";

        default:
            break;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatStr;
    dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+ (NSString *)safeString:(NSString *)string {
    if (string && string != nil) {
        return string;
    }
    return @"";
}

+ (NSString *)jsonSerialaztionWithDic:(NSDictionary *)dic {
    if (dic) {
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
        if (error) {
            NSLog(@"error：%@",error);
            return @"";
        } else {
            return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
    }
    return @"";
}


- (BOOL)isNotEmpty {
    if (self != nil
        && ![self isKindOfClass:[NSNull class]]
        && (id)self != [NSNull null]
        && [[self trimWhitespace] length]>0) {
        return YES;
    }
    return NO;
}

- (BOOL)isChinese {
    NSString *chineseRegEx = @"[^x00-xff]";
    if (![self isMatchesRegularExp:chineseRegEx]) {
        return NO;
    }
    return NO;
}
// 至少有一个汉字,字母,数字,可以判断是否为空
- (BOOL)isInvalidateMessage {
    NSError *messageError = NULL;
    NSRegularExpression *messageRegex = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z0-9\u4E00-\u9FA5]+" options:NSRegularExpressionCaseInsensitive error:&messageError];
    NSTextCheckingResult *messageResult = [messageRegex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    NSString *afterMessage = [self substringWithRange:messageResult.range];
    if ([afterMessage length]>0) {
        return YES;
    }else {
        return NO;
    }
}

- (BOOL)isMatchesRegularExp:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isEmail {
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [emailTest evaluateWithObject:self];
}


- (BOOL)isURL {
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", [self URLRegularExp]];
    return [urlTest evaluateWithObject:self];
}
- (BOOL)isCellPhoneNumber {
    NSString *cellPhoneRegEx = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *cellPhoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cellPhoneRegEx];
    return [cellPhoneTest evaluateWithObject:self];
}

- (BOOL)isPhoneNumber {
    NSString *phoneRegEx= @"((^0(10|2[0-9]|\\d{2,3})){0,1}-{0,1}(\\d{6,8}|\\d{6,8})$)";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegEx];
    return [phoneTest evaluateWithObject:self];
}
- (BOOL)isValidateVerifyCode {
    NSString *captchaRegex = @"^[0-9]{4}";
    NSPredicate *captchaTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",captchaRegex];
    BOOL isRight = [captchaTest evaluateWithObject:self];
    return isRight;
    
}
- (BOOL)isValidatePassward {
    
    NSString * string = @"^[0-9A-Za-z]{6,23}+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", string];
    return [predicate evaluateWithObject:self];
}

- (NSString *)URLRegularExp {
    static NSString *urlRegEx = @"((https?|ftp|gopher|telnet|file|notes|ms-help):((//)|(\\\\))+[\\w\\d:#@%/;$()~_?\\+-=\\\\.&]*)";;
    return urlRegEx;
}


- (NSString *)replaceCharactersAtIndexes:(NSArray *)indexes withString:(NSString *)aString {
    NSAssert(indexes != nil, @"%s: indexes 不可以为nil", __PRETTY_FUNCTION__);
    NSAssert(aString != nil, @"%s: aString 不可以为nil", __PRETTY_FUNCTION__);
    
    NSUInteger offset = 0;
    NSMutableString *raw = [self mutableCopy];
    
    NSInteger prevLength = 0;
    for(NSInteger i = 0; i < [indexes count]; i++)
    {
        @autoreleasepool {
            NSRange range = [[indexes objectAtIndex:i] rangeValue];
            prevLength = range.length;
            
            range.location -= offset;
            [raw replaceCharactersInRange:range withString:aString];
            offset = offset + prevLength - [aString length];
        }
    }
    
    return raw;
}

- (NSString *)md5Capital:(BOOL)copital {
    if (!self) {
        return nil;
    }
    const char *original = [self UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(original, (int)strlen(original), result);
    NSMutableString *outString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    NSString *name = @"%02x";
    if (copital) {
        name = @"%02X";
    }
    
    for(int i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [outString appendFormat:name, result[i]];
    }
    return outString;
}

- (NSString *)sha1Capital:(BOOL)copital {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    NSString *name = @"%02x";
    if (copital) {
        name = @"%02X";
    }
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:name, digest[i]];
    
    return output;
}

- (NSString *)threeDESWithEncreyptOrDecrpty:(CCOperation)operation key:(NSString *)key {
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (operation == kCCDecrypt)
    {
        NSData *EncryptData = [GTMBase64 decodeData:[self dataUsingEncoding:NSUTF8StringEncoding]];
        plainTextBufferSize = [EncryptData length];
        vplainText = [EncryptData bytes];
    }
    else
    {
        NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [data length];
        vplainText = (const void *)[data bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    // uint8_t ivkCCBlockSize3DES;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    //    NSString *key = @"123456789012345678901234";
    NSString *initVec = gIv;//@"init Vec";
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [initVec UTF8String];
    
   ccStatus = CCCrypt(operation,
            kCCAlgorithm3DES,
            kCCOptionPKCS7Padding,
            vkey, //"123456789012345678901234", //key
            kCCKeySize3DES,
            vinitVec, //"init Vec", //iv,
            vplainText, //"Your Name", //plainText,
            plainTextBufferSize,
            (void *)bufferPtr,
            bufferPtrSize,
            &movedBytes);
    /*
    if (ccStatus == kCCSuccess) NSLog(@"SUCCESS");
     else if (ccStatus == kCC ParamError) return @"PARAM ERROR";
     else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
     else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
     else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
     else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
     else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED"; 
     */
    
    NSString *result;
    
    if (operation == kCCDecrypt)
    {
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                               length:(NSUInteger)movedBytes]
                                       encoding:NSUTF8StringEncoding]
        ;
    }
    else
    {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [GTMBase64 stringByEncodingData:myData];
    }
    
    free(bufferPtr);
    
    return result;
}

- (NSString *)dateSecondWiht:(DateFormat)format {
    
    NSInteger time = [self integerValue];
    NSString *timeStr = @"";
    
    if (format == DateFormatMMSS) {
        timeStr = [NSString stringWithFormat:@"%@:%@",
                   [NSString stringWithFormat:@"%02d", ((int)time % 3600) / 60],
                   [NSString stringWithFormat:@"%02d", ((int)time % 3600) % 60]];
    } else if (format == DateFormatHHMMSS) {
        timeStr = [NSString stringWithFormat:@"%02.0f:%@:%@",
                   floorf(time / 3600),
                   ((int)time % 3600) / 60 < 10 ?
                   [NSString stringWithFormat:@"0%d", ((int)time % 3600) / 60] :
                   [NSString stringWithFormat:@"%d", ((int)time % 3600) / 60],
                   ((int)time % 3600) % 60  < 10 ?
                   [NSString stringWithFormat:@"0%d", ((int)time % 3600) % 60] :
                   [NSString stringWithFormat:@"%d", ((int)time % 3600) % 60]];

    } else {
        return self;
    }
    return timeStr;
}

- (NSString *)urlEncode {
    
    
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                    (CFStringRef)self,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8 ));
    if (encodedString) {
        return encodedString;
    }
    return @"";
    
}

- (NSString *)urlDecode {
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)self,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    if (decodedString) {
        return decodedString;
    }
    return @"";
}

- (NSInteger)hexInteger {
    const char *hexChar = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
    int hexNumber;
    
    sscanf(hexChar, "%x", &hexNumber);
    
    return (NSInteger)hexNumber;
}


- (id)jsonObject:(NSError *__autoreleasing *)error {
    id obj = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:error];
    return obj;
}



- (NSString *)trimWhitespace {
    NSString *string = [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}








@end
