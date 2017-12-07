//
//  WTSegmented.h
//  Receptionist
//
//  Created by 王滔 on 2016/10/10.
//  Copyright © 2016年 王滔. All rights reserved.
//

#import <HMSegmentedControl/HMSegmentedControl.h>

@interface WTSegmented : HMSegmentedControl

@property (strong, nonatomic) UIScrollView *internalScrollView;

@property (copy, nonatomic) void(^scrollViewContent)(CGSize size);

@end
