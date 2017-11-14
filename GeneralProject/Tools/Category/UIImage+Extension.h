//
//  UIImage+Extension.h
//  Dingding
//
//  Created by 陈欢 on 14-3-3.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  创建圆形图
 *
 *  @param image 原图
 *  @param inset 缩进
 *
 *  @return 圆形图
 */
+ (UIImage*)circleImage:(UIImage*) image withParam:(CGFloat) inset;

+ (UIImage*)circleImage:(UIImage*)image withParam:(CGFloat)inset withSize:(CGSize)imageSize;

+ (UIImage*)circleImageWithRadius:(CGFloat)radius Color:(UIColor *)color;

+ (UIImage*)cornerImage:(UIImage*)image withParam:(CGFloat)corner withSize:(CGSize)imageSize;

+ (UIImage*)verticalBarWithWidth:(CGFloat)width Height:(CGFloat)height Color:(UIColor *)color;

+ (UIImage *)cutCenterImage:(UIImage *)image size:(CGSize)size;

+ (UIImage *)cutImage:(UIImage *)image size:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageWithScroe:(NSString *)score;


// 图片渐变
+ (UIImage *)imageWithGradient:(UIImage *)image
                    startColor:(UIColor *)startColor
                      endColor:(UIColor *)endColor;


+ (UIImage *)imageWithUrl:(NSString *)url;

// 中点拉伸图片
+ (UIImage *)stretchableImageWith:(UIImage *)image;

 /**
   图片压缩
  @param compressionQuality 图片压缩比例
  @return 图片data
  */

- (NSData *)compressedData:(CGFloat)compressionQuality;

- (NSData *)compressedData;

- (CGFloat)compressionQuality;




/*!
 *  @brief 毛玻璃效果
 *
 *  @param blur  模糊度
 *
 *  @return image
 */

- (UIImage *)blurryWithBlurLevel:(CGFloat)blur;





@end
