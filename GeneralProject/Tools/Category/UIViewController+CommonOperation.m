//
//  UIViewController+CommonOperation.m
//  FtxBookViaPhone
//
//  Created by 王滔 on 16/9/1.
//  Copyright © 2016年 FTXJOY. All rights reserved.
//

#import "UIViewController+CommonOperation.h"

@implementation UIViewController (CommonOperation)

- (void)jumpToLogin {
    UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *loginPage = [stroyboard instantiateViewControllerWithIdentifier:@"FTXLoginAndRegisterPage"];
    [self.navigationController pushViewController:loginPage animated:YES];
}

@end
