//
//  CALayer+Additions.m
//  FtxBookViaPhone
//
//  Created by 王滔 on 16/8/11.
//  Copyright © 2016年 FTXJOY. All rights reserved.
//

#import "CALayer+Additions.h"

@implementation CALayer (Additions)


- (void)setBorderIBColor:(UIColor *)borderIBColor {
    self.borderColor = borderIBColor.CGColor;
}

- (UIColor *)borderIBColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
