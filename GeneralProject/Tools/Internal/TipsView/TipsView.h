//
//  TipsView.h
//  GeneralProject
//
//  Created by Jone on 2017/5/6.
//  Copyright © 2017年 Jone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipsView : UIView

//---------------message---------------
+ (void)showMessageWithTitle:(NSString *)message;
+ (void)showMessage:(NSString *)message dismissAfterDelay:(NSTimeInterval)second;
+ (void)showMessage:(NSString *)message dismissAfterDelay:(NSTimeInterval)second selector:(void(^)())selector;


//-----------------Progress-----------------
+ (void)showProgress;
+ (void)showProgressView:(UIView *)view;
+ (void)hideProgress;
+ (void)hideProgressView:(UIView *)view ;

@end
