//
//  UIViewController+Swizzled.m
//  FtxBookViaPhone
//
//  Created by Jone on 2017/2/13.
//  Copyright © 2017年 FTXJOY. All rights reserved.
//

#import "UIViewController+Swizzled.h"

@implementation UIViewController (Swizzled)

+(void)load {
    [super load];
    
    __weak typeof(self) weakSelf = self;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [weakSelf class];
        Method oldMethod = class_getInstanceMethod(weakSelf, NSSelectorFromString(@"dealloc"));
        Method newMethod = class_getInstanceMethod(weakSelf, @selector(swizzledDealloc));
        BOOL didAddMethod = class_addMethod(class, NSSelectorFromString(@"dealloc"), method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
        if (didAddMethod) {
            class_replaceMethod(class, @selector(swizzledDealloc), method_getImplementation(oldMethod), method_getTypeEncoding(oldMethod));
        } else {
            method_exchangeImplementations(oldMethod, newMethod);
        }
    });
}

- (void)swizzledDealloc {
    NSLog(@"print:dealloc-%@",NSStringFromClass([self class]));
    
    [self swizzledDealloc];
}

@end
