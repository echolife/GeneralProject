//
//  BaseParameters.m
//  GeneralProject
//
//  Created by Jone on 2017/5/14.
//  Copyright © 2017年 Jone. All rights reserved.
//

#import "BaseParameters.h"

@implementation BaseParameters

+ (instancetype)parameter {
    return [[self alloc] init];
}

- (NSDictionary *)fetchPropertyListDic {
    NSMutableDictionary *propertyDic = [NSMutableDictionary dictionary];
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    for (unsigned int i = 0; i < propertyCount; i++) {
        objc_property_t propertyName = properties[i];
        const char * name = property_getName(propertyName);
        NSString *nameStr = [NSString stringWithUTF8String:name];
        if (![self valueForKey:nameStr])  continue;
        propertyDic[nameStr] = [self valueForKey: nameStr];
    }
    return (NSDictionary *)propertyDic;
}

@end
