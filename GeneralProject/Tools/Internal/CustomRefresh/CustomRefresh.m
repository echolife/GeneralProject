//
//  CustomRefresh.m
//  FtxBookViaPhone
//  根据需求 替换图片数组
//  Created by Jone on 2017/4/25.
//  Copyright © 2017年 FTXJOY. All rights reserved.
//

#import "CustomRefresh.h"

@implementation CustomRefresh

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)prepare {
    [super prepare];
    
    NSString *refreshPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Refresh.bundle"];
    NSBundle *refreshBundle = [NSBundle bundleWithPath: refreshPath];
    
    // 闲置状态
    NSMutableArray *idleImges = [NSMutableArray array];
    for (NSInteger i = 1; i < 2; i++) {
        NSString *imgName = [NSString stringWithFormat:@"Frame%02ld@2x", (long)i];
        UIImage *imge = [UIImage imageWithContentsOfFile:[refreshBundle pathForResource:imgName ofType:@"png"]];
        [idleImges addObject:imge];
    }
    [self setImages:idleImges forState:MJRefreshStateIdle];
    
    // 下拉过程 加载过程中的动画
    NSMutableArray *refreshingImges = [NSMutableArray array];
    for (NSInteger i = 2; i < 8; i++) {
        NSString *imgName = [NSString stringWithFormat:@"Frame%02ld@2x", (long)i];
        UIImage *imge = [UIImage imageWithContentsOfFile:[refreshBundle pathForResource:imgName ofType:@"png"]];
        [refreshingImges addObject:imge];
    }

    [self setImages:refreshingImges duration:1.5 forState:MJRefreshStatePulling];
    [self setImages:refreshingImges duration:1.5 forState:MJRefreshStateRefreshing];
    
    
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
    
}

@end
