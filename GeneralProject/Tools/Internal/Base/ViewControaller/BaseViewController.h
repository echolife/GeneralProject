//
//  BaseViewController.h
//  GeneralProject
//
//  Created by 王滔 on 2017/5/6.
//  Copyright © 2017年 王滔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (copy, nonatomic) NSString *pageStr;
@property (copy, nonatomic) NSString *pageSizeStr;

@property (assign, nonatomic) CGFloat tabBar_H;
@property (assign, nonatomic) CGFloat navigationBar_H;
@property (assign, nonatomic) CGFloat topBar_H;

@property (assign, nonatomic) NSInteger page;
@property (assign, nonatomic) NSInteger pageSize;
@property (assign, nonatomic) BOOL isRefreshData; // 刷新数据
@property (assign, nonatomic) BOOL isInitial;


- (void)customeBackButtonWithImg:(UIImage *)normalImg highlightImg:(UIImage *)highlightImg;

- (void)hideBackButton;



// subClass write
- (void)initialSomething;
- (void)registerRefreshFunction;
- (void)endRefreshData;
- (void)refreshData;
- (void)infiniteData;
- (void)noMoreData;
- (void)interfaceAssignValue;
@end
