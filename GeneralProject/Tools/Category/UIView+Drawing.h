//
//  UIView+Drawing.h
//  FtxBookViaPhone
//
//  Created by Jone on 16/8/19.
//  Copyright © 2016年 FTXJOY. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIView (Drawing)

- (void)drawArcLineWithDirction:(UITextLayoutDirection )dire fillColor:(UIColor *)fillColor strackColor:(UIColor *)strackColor path:(void(^)(UIBezierPath *bezierPath))completion;


// 0 表示横向  1 纵向
- (void)drawDashPatternDirction:(NSInteger )direction;

- (void)tileImgWithDirction:(UITextLayoutDirection)dir;

// 0 表示横向  1 纵向
- (void)dashPatternDirction:(NSInteger )direction; // 上下方向有效

@end
