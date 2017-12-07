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


/**
 *  获取启动图片 图片启动有效
 */
+ (UIImage *)getLaunchImage;


/**
 根据字符串创建二维码
 @param string    二维码信息
 @param size      图片大小
 @param waterSize 水印大小
 @return Img
 */
+ (UIImage *)creatCIQRCodeImage:(NSString *)string imgSize:(CGFloat)size warterImg:(NSString *)waterImg waterSize:(CGFloat)waterSize;


/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 *
 *  @return 生成的高清的UIImage
 */
+ (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size warterImg:(NSString *)waterImg wateImgSize:(CGFloat)waterSize;

@end
