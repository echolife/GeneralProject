//
//  NSObject+Extension.m
//  GeneralProject
//
//  Created by Jone on 2017/4/28.
//  Copyright © 2017年 Jone. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import <LocalAuthentication/LocalAuthentication.h>


@implementation NSObject (Extension)

- (BOOL)isAllowedNotification {
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (setting.types != UIUserNotificationTypeNone) {
        return YES;
    }
    return NO;
}

- (NSMutableArray *)attributeList {
    static NSMutableDictionary *classDictionary = nil;
    if (classDictionary == nil) {
        classDictionary = [[NSMutableDictionary alloc] init];
    }
    
    NSString *className = NSStringFromClass(self.class);
    
    NSMutableArray *propertyList = [classDictionary objectForKey:className];
    
    if (propertyList != nil) {
        return propertyList;
    }
    
    propertyList = [[NSMutableArray alloc] init];
    
    id theClass = object_getClass(self);
    [self getPropertyList:theClass forList:&propertyList];
    
    [classDictionary setObject:propertyList forKey:className];
#if !__has_feature(objc_arc)
    [propertyList release];
#endif
    return propertyList;
}

- (void)getPropertyList:(id)theClass forList:(NSMutableArray **)propertyList {
    id superClass = class_getSuperclass(theClass);
    unsigned int count, i;
    objc_property_t *properties = class_copyPropertyList(theClass, &count);
    for (i=0; i<count; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property)
                                                          encoding:NSUTF8StringEncoding];
        if (propertyName != nil) {
            [*propertyList addObject:propertyName];
#if !__has_feature(objc_arc)
            [propertyName release];
#endif
            propertyName = nil;
        }
    }
    free(properties);
    
    if (superClass != [NSObject class]) {
        [self getPropertyList:superClass forList:propertyList];
    }
}


- (NSString *)deviceModel {
    NSString *model = [[UIDevice currentDevice] model];
    model = [model stringByReplacingOccurrencesOfString: @" " withString:@"_"];
    return model;
}

- (float)deviceSystemVersion {
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    return version;
}

- (NSString *)appleLanguages {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
}

- (NSString *)md5Capital:(BOOL)copital {
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [data md5Capital:copital];
    
}

- (uint64_t)getFreeDiskspace {
    uint64_t totalFreeSpace = 0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary)
    {
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
    } else {
        
    }
    
    return totalFreeSpace;
}

- (uint64_t)getTotalDiskspace {
    uint64_t totalSpace = 0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary)
    {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
    } else {
        
    }
    return totalSpace;
}

- (NSString *)applicationDocumentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}


- (BOOL)isString {
    if ([self isKindOfClass:[NSString class]]) {
        return YES;
    }
    return NO;
}

- (BOOL)isArray {
    if ([self isKindOfClass:[NSArray class]]) {
        return YES;
    }
    return NO;
}

- (BOOL)isEmptyArray {
    if (self != nil && [self isArray] && [(NSArray *)self count] > 0) {
        return NO;
    }
    return YES;
}

- (BOOL)isNotEmptyArray {
    if (self != nil && [self isArray] && [(NSArray *)self count] > 0) {
        return YES;
    }
    return NO;
}

- (BOOL)isDictionary {
    if ([self isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    return NO;
}

- (BOOL)isEmptyDictionary {
    if ([self isDictionary]) {
        NSDictionary *tempDict = (NSDictionary *)self;
        if ([tempDict allKeys].count == 0) {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)isNotEmptyDictionary {
    if ([self isDictionary]) {
        NSDictionary *tempDict = (NSDictionary *)self;
        if ([tempDict allKeys].count > 0) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isNotNil {
    if (self != nil
        && ![self isKindOfClass:[NSNull class]]
        && (id)self != [NSNull null]) {
        return YES;
    }
    return NO;
}

- (BOOL)openURL:(NSURL *)url {
    return [[UIApplication sharedApplication] openURL:url];
}

- (void)sendMail:(NSString *)mail {
    NSString *url = [NSString stringWithFormat:@"mailto://%@", mail];
    [self openURL:[NSURL URLWithString:url]];
}

- (void)sendSMS:(NSString *)number {
    NSString *url = [NSString stringWithFormat:@"sms://%@", number];
    [self openURL:[NSURL URLWithString:url]];
}

- (void)callNumber:(NSString *)number {
    NSString *url = [NSString stringWithFormat:@"tel://%@", number];
    [self openURL:[NSURL URLWithString:url]];
}

- (UIImage *)fetchGradStartImgWith:(NSString *)score {
    NSArray *scorePicArray = @[@"star_cmt_01", @"star_cmt_02", @"star_cmt_03", @"star_cmt_04", @"star_cmt_05", @"star_cmt_06", @"star_cmt_07", @"star_cmt_08", @"star_cmt_09", @"star_cmt_10", @"star_cmt_11"];
    NSInteger grade = 5;
    if (score.length) {
        CGFloat scoreFloat = [score floatValue];
        if (scoreFloat > 10.0) {
            scoreFloat *= 0.1;
        }
        grade = (int)roundf(scoreFloat);
    }
    return [UIImage imageNamed:scorePicArray[grade]];;
}

- (BOOL)deviceIsSuportFingerprint {
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] > 8.0) {
        LAContext *context = [[LAContext alloc] init]; // 初始化上下文对象
        NSError *error = nil;
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            
            return YES;
        }
        NSLog(@"print:%@",error);
    }
    return NO;
}

- (NSInteger)numberWithHexString:(NSString *)hexString{
    
    const char *hexChar = [hexString cStringUsingEncoding:NSUTF8StringEncoding];
    
    int hexNumber;
    
    sscanf(hexChar, "%x", &hexNumber);
    
    return (NSInteger)hexNumber;
}

@end
