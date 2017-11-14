//
//  CustomGifRefresh.m
//  UserMovieChoice
//
//  Created by 王滔 on 2017/8/21.
//  Copyright © 2017年 王滔. All rights reserved.
//

#import "CustomGifRefresh.h"

@interface CustomGifRefresh ()

@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) CAShapeLayer *drawLayer;

@end

@implementation CustomGifRefresh

- (void)prepare {
    [super prepare];
    self.mj_h = 50;
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_bgView];
    
    _drawLayer = [CAShapeLayer layer];
    _drawLayer.lineWidth = 2.0f;
    _drawLayer.strokeColor = [UIColor whiteColor].CGColor;
    _drawLayer.fillColor = [UIColor clearColor].CGColor;
    [_bgView.layer addSublayer:_drawLayer];
    
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    _bgView.frame = CGRectMake(0, 0, 28, 28);
    _bgView.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
    
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            NSLog(@"print:idl");
            [self endAnimation];
            break;
        case MJRefreshStatePulling: {
            NSLog(@"print:iPulling");
            
            break;
        }
        case MJRefreshStateRefreshing: {
            NSLog(@"print:freshing");
            [self startAnimation];
            break;
        }
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    [_drawLayer removeFromSuperlayer];
    if (pullingPercent > 0 && pullingPercent < 1) {
        CGFloat endAngle = M_PI * pullingPercent;
        UIBezierPath *bepath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(14, 14) radius:14 startAngle:M_PI * 1.25 endAngle:endAngle clockwise:YES];
        _drawLayer.path = bepath.CGPath;
    } else if (pullingPercent >= 1) {
        UIBezierPath *bepath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(14, 14) radius:14 startAngle:M_PI * 1.25 endAngle:M_PI clockwise:YES];
        _drawLayer.path = bepath.CGPath;
    }
    [_bgView.layer addSublayer:_drawLayer];
}

- (void)startAnimation {
    [self endAnimation];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration = 1.5;
    animation.repeatCount = HUGE_VAL;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = @(0);
    animation.toValue = @(2 * M_PI);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [_bgView.layer addAnimation:animation forKey:@""];
    
}

- (void)endAnimation {
    [_bgView.layer removeAllAnimations];
}

@end
