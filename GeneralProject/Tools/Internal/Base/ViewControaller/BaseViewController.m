//
//  BaseViewController.m
//  GeneralProject
//
//  Created by 王滔 on 2017/5/6.
//  Copyright © 2017年 王滔. All rights reserved.
//

#import "BaseViewController.h"
#import "UIButton+LXMImagePosition.h"

@interface BaseViewController ()



@end

@implementation BaseViewController

#pragma mark -
#pragma mark - Custom Accessors

- (NSString *)pageStr {
    return [NSString stringWithFormat:@"%ld",_page];
}

- (NSString *)pageSizeStr {
    return [NSString stringWithFormat:@"%ld",_pageSize];
}

- (CGFloat)navigationBar_H {
    if (self.navigationController) {
        return self.navigationController.navigationBar.frame.size.height;
    }
    return 0;
}
- (CGFloat)tabBar_H {
    if (self.tabBarController.tabBar) {
        return self.tabBarController.tabBar.frame.size.height;
    }
    return 0;
}

- (CGFloat)topBar_H {
    return  self.navigationBar_H + kStatus_H;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_HEX(0xeeeeee);
    
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    NSBundle *customBundle = [NSBundle bundleOfCustomWihtName:@"GeneralSource"];

    NSString *normalImgName = @"NavBar_back@2x";
    NSString *highlightImgName = @"NavBar_back@2x";
    if (IS_IPHONE_6P) {
        normalImgName = @"NavBar_back@3x";
        highlightImgName = @"NavBar_back@3x";
    }
    
    UIImage *norImg = [UIImage imageWithContentsOfFile:[customBundle pathForResource:normalImgName ofType:@"png"]];
    UIImage *higImg = [UIImage imageWithContentsOfFile:[customBundle pathForResource:highlightImgName ofType:@"png"]];

    
    [self customeBackButtonWithImg:norImg highlightImg:higImg];
    [self initialSomething];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)customeBackButtonWithImg:(UIImage *)normalImg highlightImg:(UIImage *)highlightImg {
    [self customeBackButtonWithImg:normalImg highlightImg:highlightImg title:nil];
}


- (void)customeBackButtonWithImg:(UIImage *)normalImg highlightImg:(UIImage *)highlightImg  title:(NSString *)title {
     UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.contentMode = UIViewContentModeLeft;
    backBtn.frame = CGRectMake(0, 0, 50, 44);
    [backBtn setImage:normalImg forState:UIControlStateNormal];
    [backBtn setImage:highlightImg forState:UIControlStateHighlighted];
    [backBtn setTitle:title forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor colorWithRed:53.0f/255 green:159.0f/255 blue:229.0f/255 alpha:1.0f] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor colorWithRed:79.0f/255 green:139.0f/255 blue:233.0f/255 alpha:1.0f]
                  forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(popController) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImagePosition:LXMImagePositionLeft spacing:5];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    barItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = barItem;
}

- (void)hideBackButton {
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - Private

- (void)initialSomething {
    self.pageSize = 30;
    
}


- (void)registerRefreshFunction {
 
}

- (void)endRefreshData {

}

- (void)refreshData {
    self.page = 1;
    self.isRefreshData = YES;
 
}


- (void)infiniteData {
    self.page++;
    self.isRefreshData = NO;
}


- (void)noMoreData {
    [self endRefreshData];
    //    _tableView.showsInfiniteScrolling = NO;
    
}

- (void)interfaceAssignValue {
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
