//
//  TipLoadingIndicatorView.h
//  GeneralProject
//
//  Created by Jone on 2017/5/8.
//  Copyright © 2017年 Jone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipLoadingIndicatorView : UIView

- (instancetype)initWithImg:(UIImage *)img;
- (instancetype)initWithGifImg:(NSString *)name;
- (void)startAnimating;
- (void)stopAnimating;


@end
