//
//  UIButton+Extension.h
//  UserMovieChoice
//
//  Created by Jone on 2017/8/4.
//  Copyright © 2017年 Jone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)


- (void)setImageColor:(UIColor *)color disabledColor:(UIColor *)disColor;

- (void)setImageColor:(UIColor *)color highlightedColor:(UIColor *)higcolor disabledColor:(UIColor *)disColor;


- (void)setImageName:(NSString *)normalImgName selectedImgName:(NSString *)selImageName;
@end
