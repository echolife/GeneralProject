//
//  UIViewController+Extension.m
//  GeneralProject
//
//  Created by Jone on 2017/4/28.
//  Copyright © 2017年 Jone. All rights reserved.
//

#import "UIViewController+Extension.h"
#import "UIView+Extension.h"

@implementation UIViewController (Extension)

+ (CGRect)screenBoundsFixedToPortraitOrientation {
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
    {
        return CGRectMake(screenBounds.origin.x,
                          screenBounds.origin.y,
                          screenBounds.size.height,
                          screenBounds.size.width);
    }
    return screenBounds;
}

- (void)titleColor:(UIColor *)color font:(NSFont *)font {
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                      font, NSFontAttributeName, color, NSForegroundColorAttributeName,  nil]];
}

- (void)titleWithView:(UIView *)view {
    self.navigationItem.titleView = view;
}

- (void)setLeftBarItemWithImage:(NSString *)Image HighlightImage:(NSString *)highImage selector:(SEL)selector {
    NSString *topString = @"";
    CGSize size = [topString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0f]}];
    
    UIImage *backImg = [UIImage imageNamed:Image];
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, backImg.size.width + size.width, MAX(backImg.size.height, 44))];
    //    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 20);
    //    backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 20);
    backBtn.contentMode = UIViewContentModeLeft;
    [backBtn setImage:backImg forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    [backBtn setTitle:topString forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor colorWithRed:79.0f/255 green:139.0f/255 blue:233.0f/255 alpha:1.0f]
                  forState:UIControlStateHighlighted];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    barItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = barItem;
    
    // 减少返回点击区域的宽度
    //    UIView *blockView = [[UIView alloc]initWithFrame:CGRectMake(35.f, 0.f, 75.f, 45.f)];
    //    [blockView setBackgroundColor:[UIColor clearColor]];
    //    [self.navigationController.navigationBar addSubview:blockView];
}

- (void)setRightBarItemWithImage:(NSString *)Image HighlightImage:(NSString *)highImage selector:(SEL)selector {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:[UIImage imageNamed:Image] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    [backButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    barItem.style = UIBarButtonItemStylePlain;
    
    self.navigationItem.rightBarButtonItem = barItem;
    
#if !__has_feature(objc_arc)
    [barItem release];
#endif
    barItem = nil;
}

- (void)addRightBarItemWithImage:(NSString *)Image HighlightImage:(NSString *)highImage selector:(SEL)selector {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 53, 44);
    [backButton setImage:[UIImage imageNamed:Image] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    [backButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    barItem.style = UIBarButtonItemStylePlain;
    
    NSMutableArray *itemsArray = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
    [itemsArray addObject:barItem];
    self.navigationItem.rightBarButtonItems = itemsArray;
}

- (void)addRightBarItemWithImage:(NSString *)Image SelectedImage:(NSString *)selectedImage selector:(SEL)selector {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 44, 44);
    [backButton setImage:[UIImage imageNamed:Image] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    
    [backButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIControl* bgView=[[UIControl alloc]initWithFrame:CGRectMake(20, 0, 44, 44)];
    [bgView addSubview:backButton];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    barItem.style = UIBarButtonItemStylePlain;
    
    // iOS bug 辅助移动button
    UIBarButtonItem *barItem1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:selector];
    [barItem1 setWidth:-10];
    //    [barItem setBackgroundImage:[UIImage imageNamed:Image] forState:UIControlStateNormal barMetrics:nil];
    //    [barItem setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected barMetrics:nil];
    
    //    NSMutableArray *itemsArray = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
    //    [itemsArray addObject:barItem];
    self.navigationItem.rightBarButtonItems = @[barItem1,barItem];
    barItem = nil;
}


- (void)navigationBarBackImgeWihtImge:(UIImage *)img {
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
    {
        [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)pushController:(UIViewController *)viewController {
    [self pushController:viewController withAnimated:YES];
}

- (void)pushController:(UIViewController *)viewController withAnimated:(BOOL)animated {
    if ([self isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)self pushViewController:viewController animated:animated];
    } else if (self.navigationController != nil) {
        [self.navigationController pushViewController:viewController animated:animated];
    } else {
        if (viewController == self) {
            return ;
        }
#if !__has_feature(objc_arc)
        [viewController retain];
#endif
        [viewController viewWillAppear:YES];
        [self.view pushView:viewController.view completion:^(BOOL finished) {
            [viewController viewDidAppear:YES];
        }];
    }
}


- (void)popController {
    [self popControllerWithAnimated:YES];
}

- (void)popControllerWithAnimated:(BOOL)Animated{
    if ([self isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)self popViewControllerAnimated:Animated];
    }
    if (self.navigationController != nil && self != self.navigationController.viewControllers[0]) {
        [self.navigationController popViewControllerAnimated:Animated];
    } else {
        [self viewWillDisappear:Animated];
        [self.view popCompletion:^(BOOL finished) {
            [self viewDidDisappear:Animated];
#if !__has_feature(objc_arc)
            [self release];
#endif
        }];
    }
}

- (void)presentController:(UIViewController *)viewController {
    [self presentController:viewController withAnimated:YES];
}

- (void)presentController:(UIViewController *)viewController withAnimated:(BOOL)animated {
    [self presentViewController:viewController animated:animated completion:nil];
}

- (void)dismissModalController {
    if (self.navigationController != nil) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)presentWithNavigationController:(UIViewController *)viewController {
    [self presentWithNavigationController:viewController withAnimated:YES];
}

- (void)presentWithNavigationController:(UIViewController *)viewController withAnimated:(BOOL)animated {
    if (viewController != nil) {
        UINavigationController *navController = nil;
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            navController = (UINavigationController *)viewController;
        } else {
            navController = [[UINavigationController alloc] initWithRootViewController:viewController];
        }
        [self presentViewController:navController animated:animated completion:nil];
#if !__has_feature(objc_arc)
        [navController release];
#endif
        navController = nil;
    }
}

- (void)close {
    [self dismissModalController];
    [self popController];
}

@end
