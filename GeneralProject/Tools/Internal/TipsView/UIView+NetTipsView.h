//
//  UIView+NetTipsView.h
//  GeneralProject
//
//  Created by Jone on 2017/5/8.
//  Copyright © 2017年 Jone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Click)(); // 点击会移除本身

@interface UIView (NetTipsView)

- (void)addLoading;

- (void)addLoadingViewWithImg:(UIImage *)img;

- (void)addLoadingViewWithImg:(UIImage *)img title:(NSString *)title;

- (void)addLoadingViewWithImg:(UIImage *)img title:(NSString *)title  click:(void(^)())click;
- (void)addLoadingViewWithGifImg:(NSString *)img title:(NSString *)title click:(void(^)())click;

- (void)addNetResultTip;
- (void)addNetResultTipWithTitle:(NSString *)title;
- (void)addNetResultTipWithTitle:(NSString *)title img:(UIImage *)img;
- (void)addNetResultTipWithTitle:(NSString *)title img:(UIImage *)img click:(void(^)())click;
- (void)removeTipsView;

@property (copy, nonatomic) Click click;

@end
