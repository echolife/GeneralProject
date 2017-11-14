//
//  BaseLayoutConstraint.h
//  GeneralProject
//
//  Created by 王滔 on 2017/5/11.
//  Copyright © 2017年 王滔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseLayoutConstraint : NSLayoutConstraint

@property (assign, nonatomic) IBInspectable BOOL isScale;
@property (assign, nonatomic) IBInspectable CGFloat iPhone4;
@property (assign, nonatomic) IBInspectable CGFloat iPhone5;
@property (assign, nonatomic) IBInspectable CGFloat iPhone6;
@property (assign, nonatomic) IBInspectable CGFloat iPhone6Plus;

@end
