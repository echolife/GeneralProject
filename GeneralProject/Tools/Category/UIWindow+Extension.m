//
//  UIWindow+Extension.m
//  FtxBookViaPhone
//
//  Created by Jone on 15/12/17.
//  Copyright © 2015年 Jone. All rights reserved.
//

#import "UIWindow+Extension.h"

@implementation UIWindow (Extension)

- (UIImage *)snapshotScreen
{
    
    CGSize imageSize = CGSizeZero;
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        imageSize = [UIScreen mainScreen].bounds.size;
    } else {
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    }
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.center.x, self.center.y);
    CGContextConcatCTM(context, self.transform);
    CGContextTranslateCTM(context, -self.bounds.size.width * self.layer.anchorPoint.x, -self.bounds.size.height * self.layer.anchorPoint.y);
    
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        CGContextRotateCTM(context, (CGFloat)M_PI_2);
        CGContextTranslateCTM(context, 0, -imageSize.width);
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        CGContextRotateCTM(context, (CGFloat)-M_PI_2);
        CGContextTranslateCTM(context, -imageSize.height, 0);
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        CGContextRotateCTM(context, (CGFloat)M_PI);
        CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
    }
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    CGContextRestoreGState(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}
@end
