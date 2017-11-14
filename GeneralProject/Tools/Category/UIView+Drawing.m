//
//  UIView+Drawing.m
//  FtxBookViaPhone
//
//  Created by 王滔 on 16/8/19.
//  Copyright © 2016年 FTXJOY. All rights reserved.
//

#import "UIView+Drawing.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Drawing)

- (void)drawArcLineWithDirction:(UITextLayoutDirection)dire fillColor:(UIColor *)fillColor strackColor:(UIColor *)strackColor path:(void (^)(UIBezierPath *))completion {
    
    CGFloat radius = 5;
    CGFloat diameter = radius * 2;
    CGFloat startAngle = 0;
    CGFloat endAngle = 0;
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *fillPath = [UIBezierPath bezierPath];
    completion(fillPath);
    int length = 0;
    CGPoint arcCenter = CGPointMake(0, 0);
    
    switch (dire) {
            
        case UITextLayoutDirectionRight: {
            startAngle = M_PI_2;
            endAngle = -M_PI_2;
            length = self.height;
            break;
        }
        case UITextLayoutDirectionLeft: {
            startAngle = -M_PI_2;
            endAngle = M_PI_2;
            length = self.height;
            
            break;
        }
        case UITextLayoutDirectionUp: {
            startAngle = 0;
            endAngle = M_PI;
            length = self.width;
            
            break;
        }
        case UITextLayoutDirectionDown: {
            startAngle = -M_PI;
            endAngle = 0;
            length = self.width;
            break;
        }
    }
    
    for (int i = 0; i < length / diameter; i++) {
        
        if (dire == 2) {      // ➡️
            arcCenter = CGPointMake(self.width, radius + i * diameter);
        }
        else if (dire == 3) { // ⬅️
            arcCenter = CGPointMake(0, radius + i * diameter);
        }
        else if (dire == 4) { // ⬆️
            arcCenter = CGPointMake(radius + i * diameter, 0);
        }
        else if (dire == 5) { // ⬇️
            arcCenter = CGPointMake(radius + i * diameter, self.height);
        }
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:radius startAngle: startAngle endAngle:endAngle clockwise:YES];
        [fillPath appendPath:path];
    }
    layer.path = fillPath.CGPath;
    layer.fillColor = fillColor.CGColor;
    layer.strokeColor = strackColor.CGColor;
    [self.layer addSublayer:layer];
    
}

- (void)drawDashPatternDirction:(NSInteger)direction {
    
    
    // 画虚线
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.bounds = self.bounds;
    layer.frame = self.bounds;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor colorWithWhite:0.863 alpha:1.000].CGColor;
    layer.lineJoin = kCALineCapRound;
    layer.lineDashPattern = @[@3, @4];
    
    
    CGFloat startX = direction ? self.width * 0.5 : 0;
    CGFloat startY = direction ? 0 : self.height * 0.5;
    CGFloat stopX = direction ? self.width * 0.5 : self.width;
    CGFloat stopY = direction ? self.height : self.height * 0.5;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, startX, startY);
    CGPathAddLineToPoint(path, NULL, stopX, stopY);
    layer.path = path;
    [self.layer addSublayer:layer];
    CGPathRelease(path);
    
    
    // 两头半圆
    CAShapeLayer *arcLayer = [CAShapeLayer layer];
    CGFloat diameter = direction ? self.width : self.height;
    CGFloat radius = diameter * 0.5;
    CGFloat startAngle = direction ? 0 : - M_PI_2;
    CGFloat endAngle = direction ? M_PI :M_PI_2 ;
    
    CGFloat startAngleSecond = direction ? M_PI : M_PI_2;
    CGFloat endAngleSecond = direction ? 0 : -M_PI_2;
    
    CGPoint arcCenter = CGPointMake(startX, startY);
    CGPoint arcCenterSecond = CGPointMake(stopX, stopY);
    
    UIBezierPath *firstPath = [UIBezierPath bezierPath];
    [firstPath addArcWithCenter:arcCenter radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    UIBezierPath *secondPath = [UIBezierPath bezierPathWithArcCenter:arcCenterSecond radius:radius startAngle:startAngleSecond endAngle:endAngleSecond clockwise:YES];
    [firstPath appendPath:secondPath];
    
    arcLayer.path = firstPath.CGPath;
    arcLayer.fillColor = [UIColor colorWithWhite:0.933 alpha:1.000].CGColor;
    arcLayer.strokeColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:arcLayer];
    
}

- (void)tileImgWithDirction:(UITextLayoutDirection)dir {
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;

    UIImage *backgroudImage = [UIImage imageNamed:@"BorderRepeatS"];
    UIColor *color = [[UIColor alloc] initWithPatternImage:backgroudImage];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = color;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:imageView];
    CGFloat imgWidth = backgroudImage.size.width > 15 ? 15 : backgroudImage.size.width;
    CGFloat imgOff  = - imgWidth * 0.5;
    NSDictionary *metrics = @{@"ImgWidth":@(imgWidth), @"imgOff": @(imgOff)};
    
    switch (dir) {
        case UITextLayoutDirectionRight: {
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(==ImgWidth)]-imgOff-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(imageView)]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(imageView)]];
            break;
        }
        case UITextLayoutDirectionLeft: {
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-imgOff-[imageView(==ImgWidth)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(imageView)]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(imageView)]];
            break;
        }
        case UITextLayoutDirectionUp: {
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-imgOff-[imageView(==ImgWidth)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(imageView)]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(imageView)]];
            break;
        }
        case UITextLayoutDirectionDown: {
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView(==ImgWidth)]-imgOff-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(imageView)]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(imageView, self)]];
            break;
        }
    }
    
}

- (void)dashPatternDirction:(NSInteger)direction {
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    // 破折号
    if (direction == 0) { // 横向
        UIImage *backgroudImage = [UIImage imageNamed:@"dasheshr"];
        UIColor *color = [[UIColor alloc] initWithPatternImage:backgroudImage];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = color;
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:imageView];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(imageView, self)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView(==1.5)]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(imageView, self)]];
         [self addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        
    } else {
        UIImage *backgroudImage = [UIImage imageNamed:@"dashes"];
        UIColor *color = [[UIColor alloc] initWithPatternImage:backgroudImage];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = color;
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:imageView];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView]-0-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(imageView, self)]];
        
         [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(==1.5)]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(imageView, self)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        
    }
    
    
    
    // 两圆
    UIImage *arcImg = [UIImage imageNamed:@"BorderRepeatL"];
    
    UIImageView *imgViewOne = [[UIImageView alloc] init];
    imgViewOne.image = arcImg;
    imgViewOne.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:imgViewOne];
    
    UIImageView *imgViewTow = [[UIImageView alloc] init];
    imgViewTow.image = arcImg;
    imgViewTow.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:imgViewTow];
    
    CGFloat RoundedWH = arcImg.size.height > 15 ? 15 : arcImg.size.height;
    CGFloat RoundedWHOff = - (RoundedWH * 0.5);
    
    NSDictionary *metrics = @{@"RoundedWHOff" : @(RoundedWHOff), @"RoundedWH":@(RoundedWH)};
    if (direction == 0) {
        // 横向
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-RoundedWHOff-[imgViewOne(==RoundedWH)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(imgViewOne)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imgViewOne(==RoundedWH)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(imgViewOne)]];
         [self addConstraint:[NSLayoutConstraint constraintWithItem:imgViewOne attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imgViewTow(==RoundedWH)]-RoundedWHOff-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(imgViewTow)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imgViewTow(==RoundedWH)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(imgViewTow)]];
         [self addConstraint:[NSLayoutConstraint constraintWithItem:imgViewTow attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    } else {
        // 纵向
         [self addConstraint:[NSLayoutConstraint constraintWithItem:imgViewOne attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imgViewOne(==RoundedWH)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(imgViewOne)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-RoundedWHOff-[imgViewOne(==RoundedWH)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(imgViewOne)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:imgViewTow attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imgViewTow(==RoundedWH)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(imgViewTow)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imgViewTow(==RoundedWH)]-RoundedWHOff-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(imgViewTow)]];
    }
}

@end
