//
//  WTSegmented.m
//  Receptionist
//
//  Created by 王滔 on 2016/10/10.
//  Copyright © 2016年 王滔. All rights reserved.
//

#import "WTSegmented.h"

@interface WTSegmented ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation WTSegmented

- (UIScrollView *)internalScrollView {
    return self.scrollView;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.scrollViewContent) {
        self.scrollViewContent(self.scrollView.contentSize);
    }
}

@end
