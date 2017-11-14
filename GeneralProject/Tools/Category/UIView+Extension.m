//
//  UIView+Extension.m
//  GeneralProject
//
//  Created by Jone on 2017/4/28.
//  Copyright © 2017年 Jone. All rights reserved.
//

#import "UIView+Extension.h"
#define kActivityViewTag 400001


@implementation UIView (Extension)

- (CGSize)size {
    return self.bounds.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)width {
    return CGRectGetWidth(self.bounds);
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return CGRectGetHeight(self.bounds);
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)top {
    return self.y;
}

- (void)setTop:(CGFloat)top {
    [self setY:top];
}

- (CGFloat)bottom {
    return self.y+self.height;
}

- (void)setBottom:(CGFloat)bottom {
    [self setY:bottom-self.height];
}

- (CGFloat)left {
    return [self x];
}

- (void)setLeft:(CGFloat)left {
    [self setX:left];
}

- (CGFloat)right {
    return self.x+self.width;
}

- (void)setRight:(CGFloat)right {
    [self setX:right-self.width];
}

- (UIActivityIndicatorView *)activityIndicatorView {
    UIActivityIndicatorView *activityView = (UIActivityIndicatorView *)[self viewWithTag:kActivityViewTag];
    if (activityView == nil) {
        activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView setTag:kActivityViewTag];
        CGFloat width = 100;
        CGFloat height = 100;
        CGFloat x = (CGRectGetWidth(self.frame) - width) / 2;
        CGFloat y = (CGRectGetHeight(self.frame) - height) / 2;
        [activityView setFrame:CGRectMake(x, y, width, height)];
        [self addSubview:activityView];
#if !__has_feature(objc_arc)
        [activityView release];
#endif
    }
    return activityView;
}

- (UIImage *)snapshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)clearBackgroundColor {
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)setBackgroundImage:(UIImage *)image {
    UIColor *color = [UIColor colorWithPatternImage:image];
    [self setBackgroundColor:color];
}

- (void)setIndex:(NSInteger)index {
    if (self.superview != nil) {
        [self.superview insertSubview:self atIndex:index];
    }
}

- (void)bringToFront {
    if (self.superview != nil) {
        [self.superview bringSubviewToFront:self];
    }
}

- (void)sendToBack {
    if (self.superview != nil) {
        [self.superview sendSubviewToBack:self];
    }
}

- (void)registEndEditing {
    UITapGestureRecognizer *endEditingTapGesture = nil;
    endEditingTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                   action:@selector(endEditingTapGestureHandler:)];
    [endEditingTapGesture setCancelsTouchesInView:YES];
    [self addGestureRecognizer:endEditingTapGesture];
#if !__has_feature(objc_arc)
    [endEditingTapGesture release];
#endif
    endEditingTapGesture = nil;
}

- (void)endEditingTapGestureHandler:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        if ([self isKindOfClass:[UITableView class]]) {
            [self.superview endEditing:YES];
        } else {
            [self endEditing:YES];
        }
    }
}

- (void)setBorderColor:(UIColor *)color width:(CGFloat)width {
    [self.layer setBorderWidth:width];
    [self.layer setBorderColor:color.CGColor];
}

- (void)setCornerRadius:(CGFloat)radius {
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:radius];
}

- (void)setShadowColor:(UIColor *)color opacity:(CGFloat)opacity offset:(CGSize)offset blurRadius:(CGFloat)blurRadius {
    [self.layer setShadowColor:color.CGColor];
    [self.layer setShadowOpacity:opacity];
    [self.layer setShadowOffset:offset];
    [self.layer setShadowRadius:blurRadius];
}

- (UIViewController *)viewController {
    return (UIViewController *)[self traverseResponderChainForUIViewController];
}

- (id)traverseResponderChainForUIViewController {
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder traverseResponderChainForUIViewController];
    } else {
        return nil;
    }
}

- (void)pushView:(UIView *)view completion:(void (^)(BOOL finished))completion {
    if (view == self) {
        return ;
    }
    [view setFrame:CGRectMake(CGRectGetWidth(self.bounds),
                              0,
                              CGRectGetWidth(self.bounds),
                              CGRectGetHeight(self.bounds))];
    [self addSubview:view];
    [UIView animateWithDuration:0.2 animations:^{
        [view setFrame:self.bounds];
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}

- (void)popCompletion:(void (^)(BOOL finished))completion {
    [UIView animateWithDuration:0.2 animations:^{
        [self setFrame:CGRectMake(CGRectGetWidth(self.bounds),
                                  0,
                                  CGRectGetWidth(self.bounds),
                                  CGRectGetHeight(self.bounds))];
    } completion:^(BOOL finished) {
        completion(finished);
        [self removeFromSuperview];
    }];
}

//开始旋转动画
- (void)startRotateAnimation
{
    CAKeyframeAnimation *theAnimation = [CAKeyframeAnimation animation];
    
    CATransform3D rotation1 = CATransform3DMakeRotation(60 * M_PI/180, 0, 0, 1);
    CATransform3D rotation2 = CATransform3DMakeRotation(120 * M_PI/180, 0, 0, 1);
    CATransform3D rotation3 = CATransform3DMakeRotation(180 * M_PI/180, 0, 0, 1);
    CATransform3D rotation4 = CATransform3DMakeRotation(240 * M_PI/180, 0, 0, 1);
    CATransform3D rotation5 = CATransform3DMakeRotation(300 * M_PI/180, 0, 0, 1);
    CATransform3D rotation6 = CATransform3DMakeRotation(360 * M_PI/180, 0, 0, 1);
    CATransform3D rotation7 = CATransform3DMakeRotation(60 * M_PI/180, 0, 0, 1);
    [theAnimation setValues:[NSArray arrayWithObjects:
                             [NSValue valueWithCATransform3D:rotation1],
                             [NSValue valueWithCATransform3D:rotation2],
                             [NSValue valueWithCATransform3D:rotation3],
                             [NSValue valueWithCATransform3D:rotation4],
                             [NSValue valueWithCATransform3D:rotation5],
                             [NSValue valueWithCATransform3D:rotation6],
                             [NSValue valueWithCATransform3D:rotation7],
                             nil]];
    
    theAnimation.duration = 1.0f;
    theAnimation.repeatCount = CGFLOAT_MAX;
    theAnimation.removedOnCompletion = NO;
    
    [self.layer addAnimation:theAnimation forKey:@"transform"];
}

//停止旋转动画
- (void)stopRotateAnimation
{
    [self.layer removeAnimationForKey:@"transform"];
}

@end
