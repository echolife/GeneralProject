//
//  UIViewController+Extension.h
//  GeneralProject
//
//  Created by Jone on 2017/4/28.
//  Copyright © 2017年 Jone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)
+ (CGRect)screenBoundsFixedToPortraitOrientation;

- (void)titleColor:(UIColor *)color font:(NSFont *)font;

- (void)titleWithView:(UIView *)view;

- (void)navigationBarBackImgeWihtImge:(UIImage *)img;


- (void)setLeftBarItemWithImage:(NSString *)Image HighlightImage:(NSString*)highImage selector:(SEL)selector;
- (void)setRightBarItemWithImage:(NSString *)Image HighlightImage:(NSString*)highImage selector:(SEL)selector;
- (void)addRightBarItemWithImage:(NSString *)Image HighlightImage:(NSString*)highImage selector:(SEL)selector;
- (void)addRightBarItemWithImage:(NSString *)Image  SelectedImage:(NSString*)selectedImage selector:(SEL)selector;

- (void)pushController:(UIViewController *)viewController;
- (void)pushController:(UIViewController *)viewController withAnimated:(BOOL)animated;
- (void)popController;
- (void)popControllerWithAnimated:(BOOL)Animated;
- (void)presentController:(UIViewController *)viewController;
- (void)dismissModalController;

@end
