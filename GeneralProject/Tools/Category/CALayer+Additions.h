//
//  CALayer+Additions.h
//  FtxBookViaPhone
//  user defined runtime property 的时候会自动调用方法
//  Created by 王滔 on 16/8/11.
//  Copyright © 2016年 FTXJOY. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (Additions)

// CATAGORY 可以实现添加属性 但必须同时实现get set方法

@property (strong, nonatomic) UIColor *borderIBColor;

@end
