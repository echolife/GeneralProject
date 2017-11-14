//
//  BaseLayoutConstraint.m
//  GeneralProject
//
//  Created by Jone on 2017/5/11.
//  Copyright © 2017年 Jone. All rights reserved.
//

#import "BaseLayoutConstraint.h"

@implementation BaseLayoutConstraint
- (void)setIsScale:(BOOL)isScale {
    if (isScale) {
        CGRect sreenBounds = [UIScreen mainScreen].bounds;
        CGFloat scale = sreenBounds.size.width / 375;
        self.constant *= scale;
    }
}

- (void)setIPhone4:(CGFloat)iPhone4 {
    //640 x 960
    if (IS_IPHONE_4_OR_LESS) {
        self.constant = iPhone4;
    }
}

- (void)setIPhone5:(CGFloat)iPhone5 {
    //640 x 1136
    if (IS_IPHONE_5) {
        self.constant = iPhone5;
    }
}

- (void)setIPhone6:(CGFloat)iPhone6 {
    //750 x 1334
    if (IS_IPHONE_6) {
        self.constant = iPhone6;
    }
}

- (void)setIPhone6Plus:(CGFloat)iPhone6Plus {
    //1242 x 2208
    if (IS_IPHONE_6P) {
        self.constant = iPhone6Plus;;
    }
}

@end
