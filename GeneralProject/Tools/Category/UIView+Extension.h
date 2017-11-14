//
//  UIView+Extension.h
//  GeneralProject
//
//  Created by 王滔 on 2017/4/28.
//  Copyright © 2017年 王滔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

//--------------------------Property-----------------------

/*size*/
- (CGSize)size;
- (void)setSize:(CGSize)size;

/*x*/
- (CGFloat)x;
- (void)setX:(CGFloat)x;

/*y*/
- (CGFloat)y;
- (void)setY:(CGFloat)y;

/*width*/
- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

/*height*/
- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

/*top*/
- (CGFloat)top;
- (void)setTop:(CGFloat)top;

/*bottom*/
- (CGFloat)bottom;
- (void)setBottom:(CGFloat)bottom;

/*left*/
- (CGFloat)left;
- (void)setLeft:(CGFloat)left;

/*right*/
- (CGFloat)right;
- (void)setRight:(CGFloat)right;


//-------------------------- 功能------------------

/*菊花*/
- (UIActivityIndicatorView *)activityIndicatorView;

/*快照*/
- (UIImage *)snapshot;

/*清除背景颜色*/
- (void)clearBackgroundColor;

/*设置背景图片*/
- (void)setBackgroundImage:(UIImage *)image;

/*设置View层顺序*/
- (void)setIndex:(NSInteger)index;

/*设置为最顶层View*/
- (void)bringToFront;

/*设置为最底层View*/
- (void)sendToBack;

- (void)registEndEditing;

/*设置边框颜色 和 边框宽度*/
- (void)setBorderColor:(UIColor *)color width:(CGFloat)width;

/*设置圆角*/
- (void)setCornerRadius:(CGFloat)radius;

/*设置外阴影*/
- (void)setShadowColor:(UIColor *)color opacity:(CGFloat)opacity offset:(CGSize)offset blurRadius:(CGFloat)blurRadius;

- (UIViewController *)viewController;

- (void)pushView:(UIView *)view completion:(void (^)(BOOL finished))completion;

- (void)popCompletion:(void (^)(BOOL finished))completion;


//-------------------------------------旋转动画-----------------------

//开始旋转动画
- (void)startRotateAnimation;

//停止旋转动画
- (void)stopRotateAnimation;

@end
