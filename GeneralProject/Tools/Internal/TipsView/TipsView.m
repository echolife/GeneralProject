//
//  TipsView.m
//  GeneralProject
//
//  Created by Jone on 2017/5/6.
//  Copyright © 2017年 Jone. All rights reserved.
//

#import "TipsView.h"
#import <MBProgressHUD/MBProgressHUD.h>

#define kTipsViewDismissAfterDelay 1.5  //提示框显示时间

#define kTipsViewTimtOut 30.0f   //progressview超时时间,设置为比联网超时时间稍长，作为若没有正常执行超时事件的处理

#define kTipsViewTag 917996690

#define kMessageFont   [UIFont systemFontOfSize:13.0f]

#define kPadding 5.0f

@interface TipsView ()

@property (copy, nonatomic) NSString *message;

@property (copy, nonatomic) void(^selector)();

@end

@implementation TipsView


- (void)setMessage:(NSString *)message {
    _message = message;
    [self setNeedsDisplay];
}

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        [self setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6f]];
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:4.0f];
        [self setTag:kTipsViewTag];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.message) {
        
        CGRect drawRect = CGRectMake(kPadding, kPadding, CGRectGetWidth(self.frame) - 2 * kPadding, CGRectGetHeight(self.frame) - 2 * kPadding);
        
        NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:kMessageFont,NSFontAttributeName,
                              [UIColor whiteColor],NSForegroundColorAttributeName,nil];
        [self.message drawWithRect:drawRect
                           options:NSStringDrawingUsesLineFragmentOrigin
                        attributes:dic
                           context:nil];
    }
}

- (void)dealloc {
    [self removeFromSuperview];
}

+ (void)showMessageWithTitle:(NSString *)message {
    
    [self showMessage:message dismissAfterDelay:kTipsViewDismissAfterDelay];
}


+ (void)showMessage:(NSString *)message dismissAfterDelay:(NSTimeInterval)second {
    [self showMessage:message dismissAfterDelay:second selector:nil];
}

+ (void)showMessage:(NSString *)message dismissAfterDelay:(NSTimeInterval)second selector:(void (^)())selector {
    [[[self alloc] init] showMessage:message dismissAfterDelay:second selector:selector];
}
- (void)showMessage:(NSString *)message dismissAfterDelay:(NSTimeInterval)second selector:(void (^)())selector {
    _selector = selector;
    if (![message isNotEmpty]) return;
    // 1. 设置时长
    if (second <= 0) {
        second = kTipsViewDismissAfterDelay;
    }
    
    // 2.取消之前的预执行事件
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissTips) object:_message];
    
    // 3.根控制器
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = keyWindow.rootViewController;
    CGRect rect = [self tipsViewRectWithMsg:message font:kMessageFont];
    self.center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    
    [UIView animateWithDuration:0.3f animations:^{
        [self setAlpha:1.0f];
    }];
    
    UIWindow *keyboardWindow = nil;
    
    NSUInteger count = [UIApplication sharedApplication].windows.count;
    for (NSInteger i = (count - 1) ; i > -1; i --) {
        UIWindow  *window = [[UIApplication sharedApplication].windows objectAtIndex:i];
        if (![NSStringFromClass(window.class) isEqualToString:NSStringFromClass([UIWindow class])] && window.hidden != YES) {
            keyWindow = window;
            break;
        }
    }
    
    if (keyboardWindow != nil) {
        if ([keyboardWindow viewWithTag:kTipsViewTag]) {
            UIView *view = [keyboardWindow viewWithTag:kTipsViewTag];
            [view removeFromSuperview];
        }
        
        rect = CGRectMake(rect.origin.x, SCREEN_H - rect.size.height - 300, rect.size.width, rect.size.height);
        
        
        [keyboardWindow addSubview:self];
        [keyboardWindow bringSubviewToFront:self];
        
    } else if (keyWindow != nil) {
        
        if ([keyWindow viewWithTag:kTipsViewTag]) {
            UIView *view = [keyWindow viewWithTag:kTipsViewTag];
            [view removeFromSuperview];
        }
        [keyWindow addSubview:self];
        [keyWindow bringSubviewToFront:self];
    }
    else {
        if ([rootViewController.view viewWithTag:kTipsViewTag]) {
            UIView *view = [rootViewController.view viewWithTag:kTipsViewTag];
            [view removeFromSuperview];
        }
        [rootViewController.view addSubview:self];
        [rootViewController.view bringSubviewToFront:self];
    }
    [self setFrame:rect];
    self.message = message;
    [self performSelector:@selector(dismissTips) withObject:_message afterDelay:second];
    
}

- (CGRect)tipsViewRectWithMsg:(NSString *)msg font:(UIFont *)font {
    CGRect rect = CGRectZero;
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 30, 200, 30);
    CGSize constrainedToSize = CGSizeMake(SCREEN_W - edgeInsets.right * 2, 0);
    
    CGSize size = [msg boundingRectWithSize:constrainedToSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName : [UIColor whiteColor]} context:nil].size;
    
    CGRect screenBounds = [UIViewController screenBoundsFixedToPortraitOrientation];
    
    CGFloat height = size.height + kPadding * 2;
    CGFloat width = size.width + kPadding * 2;
    CGFloat x = (screenBounds.size.width - width) / 2;
    CGFloat y = (screenBounds.size.height - edgeInsets.bottom - height);
    
    rect = CGRectMake(x, y, width, height);
    
    return rect;
}

-(void) dismissTips {
    if (_selector) {
        _selector();
        _selector = nil;
    }
    [UIView animateWithDuration:.3f animations:^{
        [self setAlpha:0.0f];
        [self setBounds:CGRectMake(0, 0, 0, 0)];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


+ (void)showProgress {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self showProgressView:window];
}

+ (void)showProgressView:(UIView *)view {
    
    [[[self alloc] init] showProgresssView:view];
}


- (void)showProgresssView:(UIView *)view {
    
    if (view == nil) {
        return;
    }
    
    UIView *befor = [view viewWithTag:kTipsViewTag + 1];
    if (befor) {
        MBProgressHUD *hud = (MBProgressHUD *)befor;
        [hud hideAnimated:NO];
        [hud removeFromSuperview];
    }

    [[view viewWithTag:kTipsViewTag + 2] removeFromSuperview];
    
    UIView *backView = [[UIView alloc] initWithFrame:view.frame];
    backView.backgroundColor = [UIColor clearColor];
    backView.tag = kTipsViewTag + 2;
    [view addSubview:backView];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [hud bringToFront];
    [hud hideAnimated:YES afterDelay:kTipsViewTimtOut];
    hud.tag = kTipsViewTag + 1;
    hud.completionBlock = ^() {
        [backView removeFromSuperview];
    };
}


+ (void)hideProgress {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self hideProgressView:window];
}

+ (void)hideProgressView:(UIView *)view {
    if (!view) {
        
    }
    [[[self alloc] init] hideProgressView:view];
}

- (void)hideProgressView:(UIView *)view {
    UIView *befor = [view viewWithTag:kTipsViewTag + 1];
    if (befor) {
        MBProgressHUD *hud = (MBProgressHUD *)befor;
        [hud hideAnimated:NO];
        [hud removeFromSuperview];
    }
    [[view viewWithTag:kTipsViewTag + 2] removeFromSuperview];
}



@end
