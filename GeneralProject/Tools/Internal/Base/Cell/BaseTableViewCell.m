//
//  BaseTableViewCell.m
//  GeneralProject
//
//  Created by 王滔 on 2017/5/6.
//  Copyright © 2017年 王滔. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (NSString *)nibName {
    return [self reuseIdentifier];
}

+ (NSString *)reuseIdentifier {
    NSString *__reuseIdentifier = nil;
    __reuseIdentifier = NSStringFromClass([self class]);
    
    return __reuseIdentifier;
}

@end
