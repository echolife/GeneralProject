//
//  TipLoadingIndicatorView.m
//  GeneralProject
//
//  Created by 王滔 on 2017/5/8.
//  Copyright © 2017年 王滔. All rights reserved.
//

#import "TipLoadingIndicatorView.h"
#import <SDWebImage/UIImage+GIF.h>

@interface TipLoadingIndicatorView ()

@property (strong, nonatomic) UIImageView *activityView;
@property (strong, nonatomic) UIImage *indicatorImg;
@end

@implementation TipLoadingIndicatorView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (instancetype)initWithImg:(UIImage *)img {
    
    if (!img) {
        NSBundle *customBundle = [NSBundle  bundleOfCustomWihtName:@"GeneralSource"];
        NSString *imageName = @"Loading@2x";
        if (IS_IPHONE_6P) {
            imageName = @"Loading@3x";
        }
        img = [UIImage imageWithContentsOfFile:[customBundle pathForResource:imageName ofType:@"png"]];
    }
    _indicatorImg = img;
    self = [super initWithFrame:CGRectMake(0, 0, MIN(100, img.size.width), MIN(100, img.size.height))];
    if (self) {
        [self initViews];
    }
    return self;
}

- (instancetype)initWithGifImg:(NSString *)name {
    NSBundle *bundle = [NSBundle mainBundle];
    if (!name) {
        bundle = [NSBundle bundleOfCustomWihtName:@"GeneralSource"];
        name = @"LoadingGif";
    }
    
    NSString *retinaPath = [bundle pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];
    if ([UIScreen mainScreen].scale == 3) {
        [bundle pathForResource:[name stringByAppendingString:@"@3x"] ofType:@"gif"];
    }
    
    if (!retinaPath) {
        retinaPath = [bundle pathForResource:name ofType:@"gif"];
    }
    
    UIImage *gifImage = [UIImage imageWithContentsOfFile:retinaPath];
    
    self = [super initWithFrame:CGRectMake(0, 0, MIN(30, gifImage.size.width), MIN(30, gifImage.size.height))];
    if (self) {
        
        NSData *data = [NSData dataWithContentsOfFile:retinaPath];
        
        
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.image = [UIImage sd_animatedGIFWithData:data];
        [self addSubview:imageView];
        self.activityView = imageView;
    }
    return self;
}

-(void)initViews {
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    imageView.image = _indicatorImg;
    [self addSubview:imageView];
    self.activityView = imageView;
}

- (void)startAnimating {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    rotationAnimation.duration = 1.0;
    rotationAnimation.repeatCount = MAXFLOAT;
    [_activityView.layer addAnimation:rotationAnimation forKey:nil];
    
}

- (void)stopAnimating {
    [_activityView.layer removeAllAnimations];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
