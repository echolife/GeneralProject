//
//  ViewController.m
//  GeneralProject
//
//  Created by Jone on 2017/4/28.
//  Copyright © 2017年 Jone. All rights reserved.
//

#import "ViewController.h"
#import "TipsView.h"
#import "UIView+NetTipsView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITextField *f = [[UITextField alloc] initWithFrame:self.view.bounds];
    [f becomeFirstResponder];
    [self.view addSubview:f];
    [TipsView showProgress];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [TipsView showMessageWithTitle:@"fjdosjfosdifjiodsjfodsfjod"];
//     [TipsView showMessageWithTitle:@"dfjoijo"];
//     [TipsView showMessageWithTitle:@"f"];
//     [TipsView showMessageWithTitle:@"000000"];
//    [TipsView showProgress];
//
//    [TipsView showProgress];
//
    [TipsView showProgress];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [TipsView hideProgress];
    });
 
   
//    [TipsView showMessage:@"" dismissAfterDelay:3 selector:^{
//        
//    }];
    
//    [self.view addNetResultTipWithTitle:nil img:nil click:^{
//         NSLog(@"是你点了我");
//    }];
//    [self.view addNetResultTipWithTitle:nil img:nil];

//    [self.view addLoadingViewWithGifImg:nil title:@"jjjaao" click:^{
//        NSLog(@"是你点了我");
//    }];
//    [self.view addLoadingViewWithGifImg:nil title:@"jjjaao" click:nil];



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
