//
//  UIView+NetTipsView.m
//  GeneralProject
//
//  Created by Jone on 2017/5/8.
//  Copyright © 2017年 Jone. All rights reserved.
//

#import "UIView+NetTipsView.h"
#import "TipLoadingIndicatorView.h"

#define kBgViewTag  1909090

static const void *UtilityKey = &UtilityKey;


@implementation UIView (NetTipsView)


- (Click)click {
    return objc_getAssociatedObject(self, UtilityKey);
}

- (void)setClick:(Click)click {
    objc_setAssociatedObject(self, UtilityKey, click, OBJC_ASSOCIATION_COPY);
}

- (void)addLoading {
    [self addLoadingViewWithImg:nil title:nil click:nil];
}

- (void)addLoadingViewWithImg:(UIImage *)img {
    [self addLoadingViewWithImg:img title:nil click:nil];
}

- (void)addLoadingViewWithImg:(UIImage *)img title:(NSString *)title {
    [self addLoadingViewWithImg:img title:title click:nil];
}


- (void)addLoadingViewWithImg:(UIImage *)img title:(NSString *)title click:(void (^)())click {
    self.click = click;
    if (!title) {
        title = @"正在努力加载·······";
    }
    
    [[self viewWithTag:kBgViewTag] removeFromSuperview ];
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    bgView.backgroundColor = COLOR_HEX(0xeeeeee);
    bgView.tag = kBgViewTag;
    [self addSubview:bgView];
    
    TipLoadingIndicatorView *indicatorView = [[TipLoadingIndicatorView alloc] initWithImg:img];
    indicatorView.center = CGPointMake(self.center.x, 300);
    [indicatorView startAnimating];
    [bgView addSubview:indicatorView];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:13];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:label];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    [bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[label]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
    [bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[indicatorView]-10-[label]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(label, indicatorView)]];
    [self bringSubviewToFront:bgView];
}

- (void)addLoadingViewWithGifImg:(NSString *)img title:(NSString *)title click:(void (^)())click {
    self.click = click;
    if (!title) {
        title = @"正在努力加载·······";
    }
    
    [[self viewWithTag:kBgViewTag] removeFromSuperview ];
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    bgView.backgroundColor = COLOR_HEX(0xeeeeee);
    bgView.tag = kBgViewTag;
    [self addSubview:bgView];
    
    TipLoadingIndicatorView *indicatorView = [[TipLoadingIndicatorView alloc] initWithGifImg:img];
    indicatorView.center = CGPointMake(self.center.x, 300);
    [indicatorView startAnimating];
    [bgView addSubview:indicatorView];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:13];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:label];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    [bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[label]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
    [bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[indicatorView]-10-[label]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(label, indicatorView)]];
    [self bringSubviewToFront:bgView];
}



- (void)addNetResultTip {
    [self addNetResultTipWithTitle:nil];
}

- (void)addNetResultTipWithTitle:(NSString *)title {
    [self addNetResultTipWithTitle:title img:nil];
}

- (void)addNetResultTipWithTitle:(NSString *)title img:(UIImage *)img {
    [self addNetResultTipWithTitle:title img:img click:nil];
}

- (void)addNetResultTipWithTitle:(NSString *)title img:(UIImage *)img click:(void (^)())click {
    self.click = click;
    if (!img) {
        NSBundle *customBundle = [NSBundle  bundleOfCustomWihtName:@"GeneralSource"];
        NSString *imageName = @"Emptyicon@2x";
        if (IS_IPHONE_6P) {
            imageName = @"Emptyicon@3x";
        }
        img = [UIImage imageWithContentsOfFile:[customBundle pathForResource:imageName ofType:@"png"]];
    }
    
    if (!title) {
        title = @"暂无结果";
    }
    
    [[self viewWithTag:kBgViewTag + 1] removeFromSuperview ];
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    bgView.backgroundColor = COLOR_HEX(0xeeeeee);
    bgView.tag = kBgViewTag + 1;
    [self addSubview:bgView];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = img;
    [bgView addSubview:imgView];
    imgView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tipViewTapped)];
    [bgView addGestureRecognizer:tapGesture];
    
    CGFloat imgW = MIN(img.size.width, 100);
    CGFloat imgH = MIN(img.size.height, 100);
    
    [bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imgView(imgW)]" options:0 metrics:@{@"imgW":[NSNumber numberWithFloat:imgW]} views:NSDictionaryOfVariableBindings(imgView)]];
    [bgView addConstraint:[NSLayoutConstraint constraintWithItem:imgView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:bgView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    [bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[imgView(imgH)]" options:0 metrics:@{@"imgH": [NSNumber numberWithFloat:imgH]} views:NSDictionaryOfVariableBindings(imgView)]];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:13];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:label];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    [bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[label]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
    [bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imgView]-10-[label]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(label, imgView)]];
}


- (void)removeTipsView {
    [[self viewWithTag:kBgViewTag] removeFromSuperview ];
    [[self viewWithTag:(kBgViewTag + 1)] removeFromSuperview ];
}

- (void)tipViewTapped {
    if (self.click) {
        self.click();
        [self removeTipsView];
    }
}

@end
