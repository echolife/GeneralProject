//
//  UIImage+Extension.m
//  Dingding
//
//  Created by 陈欢 on 14-3-3.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import "UIImage+Extension.h"
#import <Accelerate/Accelerate.h>
#import <SDWebImage/UIImageView+WebCache.h>

#define kCompresseionDataLength (500000.0f) //最大压缩大小(50k)

@implementation UIImage (Extension)

+ (UIImage*)circleImage:(UIImage*)image withParam:(CGFloat)inset
{
    //在retian屏幕上要使用这个函数，才能保证不失真
    UIGraphicsBeginImageContextWithOptions(image.size, NO, [UIScreen mainScreen].scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, inset);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:255.f green:255.f blue:255.f alpha:.6].CGColor);
	CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
	CGContextAddEllipseInRect(context, rect);
	CGContextClip(context);
	
	[image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
	CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

+ (UIImage*)circleImage:(UIImage*)image withParam:(CGFloat)inset withSize:(CGSize)imageSize
{
    //在retian屏幕上要使用这个函数，才能保证不失真
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:255.f green:255.f blue:255.f alpha:.6].CGColor);
	CGRect rect = CGRectMake(inset, inset, imageSize.width - inset * 2.0f, imageSize.height - inset * 2.0f);
	CGContextAddEllipseInRect(context, rect);
	CGContextClip(context);
	
	[image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
	CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

+ (UIImage*)cornerImage:(UIImage*)image withParam:(CGFloat)corner withSize:(CGSize)imageSize
{
    //在retian屏幕上要使用这个函数，才能保证不失真
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGRect rect = CGRectMake(0,
                             0,
                             imageSize.width,
                             imageSize.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                    byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight
                                                     cornerRadii:CGSizeMake(corner,
                                                                            corner)];
	CGContextAddPath(context, [path CGPath]);
	CGContextClip(context);
	
	[image drawInRect:rect];

    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

+ (UIImage*)circleImageWithRadius:(CGFloat)radius Color:(UIColor *)color
{
    //在retian屏幕上要使用这个函数，才能保证不失真
    CGSize imageSize = CGSizeMake(radius, radius);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
	CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    CGContextAddEllipseInRect(context, rect);
	CGContextFillPath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}

+ (UIImage*)verticalBarWithWidth:(CGFloat)width Height:(CGFloat)height Color:(UIColor *)color
{
    //在retian屏幕上要使用这个函数，才能保证不失真
    CGSize imageSize = CGSizeMake(width, height);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
	CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    CGContextAddRect(context, rect);
	CGContextFillPath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    CGSize imageSize = size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

+ (UIImage *)imageWithScroe:(NSString *)score {
    NSArray *scorePicArray = @[@"star 01", @"star 02", @"star 03", @"star 04", @"star 05", @"star 06", @"star 07", @"star 08", @"star 09", @"star 10", @"star 11"];
    NSInteger grade = 5;
    if (score.length) {
        CGFloat scoreFloat = [score floatValue];
        if (((int)(scoreFloat * 10)) % 10 >= 5) {
            grade = (int)ceil(scoreFloat);
        } else if(((int)(scoreFloat * 10)) % 10 < 5){
            grade = (int)floorf(scoreFloat);
        }
    }
    return [UIImage imageNamed:scorePicArray[10 - grade]];;
}

+ (UIImage *)cutCenterImage:(UIImage *)image size:(CGSize)size{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize originSize = CGSizeMake(image.size.width, image.size.height);
    CGSize imageSize = CGSizeMake(size.width * scale, size.height * scale);
    
    if(originSize.width < imageSize.width)
    {
        originSize.height *= imageSize.width/originSize.width;
        originSize.width = imageSize.width;
    }
    if(originSize.height < imageSize.height){
        originSize.width *= imageSize.height/originSize.height;
        originSize.height = imageSize.height;
    }
    
    CGRect frame;
    frame.origin.x = (originSize.width - imageSize.width)/2;
    frame.origin.y = (originSize.height - imageSize.height)/2;
    frame.size = imageSize;
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, frame);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    
    return smallImage;
}

+ (UIImage *)cutImage:(UIImage *)image size:(CGSize)size{
    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGSize originSize = CGSizeMake(image.size.width, image.size.height);
   
    CGSize imageSize = CGSizeMake(size.width * scale, size.height * scale);
    
    if(originSize.width < imageSize.width)
    {
        originSize.height *= imageSize.width/originSize.width;
        originSize.width = imageSize.width;
    }
    if(originSize.height < imageSize.height){
        originSize.width *= imageSize.height/originSize.height;
        originSize.height = imageSize.height;
    }
    
    CGRect frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size = imageSize;
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, frame);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    
    return smallImage;
}

+ (UIImage *)imageWithGradient:(UIImage *)image
                    startColor:(UIColor *)startColor
                      endColor:(UIColor *)endColor
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextDrawImage(context, rect, image.CGImage);
    
    // Create gradient
    NSArray *colors = [NSArray arrayWithObjects:(id)endColor.CGColor, (id)startColor.CGColor, nil];
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(space, (CFArrayRef)colors, NULL);
    
    // Apply gradient
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0,0), CGPointMake(0, image.size.height), 0);
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(space);
    
    return gradientImage;
}




+ (UIImage *)imageWithUrl:(NSString *)url
{
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    result = [UIImage imageWithData:data];
    
    return result;
}

- (NSData *)compressedData:(CGFloat)compressionQuality
{
    if (compressionQuality<=1.0 && compressionQuality >=0)
    {
        return UIImageJPEGRepresentation(self, compressionQuality);
    }
    else
    {
        return UIImageJPEGRepresentation(self, 1.f);
    }
}

- (CGFloat)compressionQuality
{
    NSData *data = UIImageJPEGRepresentation(self, 1.0);
    NSUInteger dataLength = [data length];
    if(dataLength > kCompresseionDataLength)
    {
        return 1.0 - kCompresseionDataLength / dataLength;
    }
    else
    {
        return 1.0;
    }
}

- (NSData *)compressedData {
    CGFloat quality = [self compressionQuality];
    return [self compressedData:quality];
}

+ (UIImage *)stretchableImageWith:(UIImage *)image
{
    return  [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height/2, image.size.width/2, image.size.height/2, image.size.width/2) resizingMode:UIImageResizingModeStretch];
}

- (UIImage *)blurryWithBlurLevel:(CGFloat)blur {

    //模糊度,
    if ((blur < 0.0f) || (blur > 2.0f)) {
        blur = 0.5f;
    }
    
    //boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    //图像处理
    CGImageRef img = self.CGImage;
    
    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    //像素缓存
    void *pixelBuffer;
    
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }

    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }

    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }

    
    //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(self.CGImage));
    
    
    
    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    
    CGImageRelease(imageRef);
    
    return returnImage;
}

+(UIImage *)getLaunchImage{
    CGSize viewSize = [UIApplication sharedApplication].keyWindow.bounds.size;
    NSString *viewOrientation = @"Portrait";    //横屏请设置成 @"Landscape"
    NSString *launchImage = @"";
    NSArray *imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imagesDict) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImage = dict[@"UILaunchImageName"];
            break;
        }
    }
    return [UIImage imageNamed:launchImage];
}

+ (UIImage *)creatCIQRCodeImage:(NSString *)string imgSize:(CGFloat)size warterImg:(NSString *)waterImg waterSize:(CGFloat)waterSize {
    // 创建过滤器， 参数固定
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 恢复默认设置
    [filter setDefaults];
    
    // 添加数据
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    // 设置二维码纠错等级
    [filter setValue:@"L" forKey:@"inputCorrectionLevel"];
    
    CIImage *outputImg = [filter outputImage];
    
    return [self creatNonInterpolatedUIImageFormCIImage:outputImg withSize:size warterImg:waterImg wateImgSize:waterSize];
}


+ (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size warterImg:(NSString *)waterImg wateImgSize:(CGFloat)waterSize {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 创建bitmap
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    
    // 创建一个deviceGray 颜色空间
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CFRelease(cs);
    
    // 得到图片
    UIImage *outImg = [UIImage imageWithCGImage:scaledImage];
    CGImageRelease(scaledImage);
    
    // 添加水印
    if (waterSize == 0) return outImg;
    
    UIGraphicsBeginImageContextWithOptions(outImg.size, NO, [UIScreen mainScreen].scale);
    [outImg drawInRect:CGRectMake(0, 0, size, size)];
    
    // 水印图片
    UIImage *waterImage = [UIImage imageNamed:waterImg];
    
    // 将水印画入二维码
    [waterImage drawInRect:CGRectMake(size - waterSize / 2, size - waterSize / 2, waterSize, waterSize)];
    UIImage *newOutputImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newOutputImg;
}

@end
