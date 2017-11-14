//
//  UIButton+Extension.m
//  UserMovieChoice
//
//  Created by 王滔 on 2017/8/4.
//  Copyright © 2017年 王滔. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)
- (void)setImageColor:(UIColor *)color disabledColor:(UIColor *)disColor {
    [self setImage:[UIImage imageWithColor:color] forState:UIControlStateNormal];
    [self setImage:[UIImage imageWithColor:disColor] forState:UIControlStateDisabled];
}


- (void)setImageColor:(UIColor *)color highlightedColor:(UIColor *)higcolor disabledColor:(UIColor *)disColor {
    [self setImageColor:color disabledColor:disColor];
    [self setImage:[UIImage imageWithColor:higcolor] forState:UIControlStateHighlighted];
}

- (void)setImageName:(NSString *)normalImgName selectedImgName:(NSString *)selImageName {
    [self setImage:[UIImage imageNamed:normalImgName] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:selImageName] forState:UIControlStateSelected];
}


@end
