//
//  BaseCollectionViewCell.m
//  GeneralProject
//
//  Created by 王滔 on 2017/5/6.
//  Copyright © 2017年 王滔. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

+ (NSString *)nibName {
    return [self reuseIdentifier];
}


+ (NSString *)reuseIdentifier {
    NSString *__reuseIdentifier = nil;
    __reuseIdentifier = NSStringFromClass([self class]);
    
    return __reuseIdentifier;
}

@end
