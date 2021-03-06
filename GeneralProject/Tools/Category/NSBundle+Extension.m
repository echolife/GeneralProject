//
//  NSBundle+Extension.m
//  GeneralProject
//
//  Created by Jone on 2017/5/6.
//  Copyright © 2017年 Jone. All rights reserved.
//

#import "NSBundle+Extension.h"

@implementation NSBundle (Extension)

+ (NSBundle *)bundleOfCustomWihtName:(NSString *)name {
    name = [name stringByAppendingString:@".bundle"];
    NSString *bundlePatch = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name];
    NSBundle *customeBundle = [NSBundle bundleWithPath:bundlePatch];
    return customeBundle;
}

@end
