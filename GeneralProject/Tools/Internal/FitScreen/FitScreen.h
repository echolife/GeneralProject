//
//  FitScreen.h
//  GeneralProject
//
//  Created by 王滔 on 2017/5/6.
//  Copyright © 2017年 王滔. All rights reserved.
//

#ifndef FitScreen_h
#define FitScreen_h

CG_INLINE CGFloat FitScreenPt(CGFloat value) {
    CGRect sreenBounds = [UIScreen mainScreen].bounds;
    CGFloat scale  = sreenBounds.size.width / 375;
    return scale * value;
}

#endif /* FitScreen_h */
