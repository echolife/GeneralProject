//
//  ColorMarco.h
//  GeneralProject
//
//  Created by 王滔 on 2017/4/28.
//  Copyright © 2017年 王滔. All rights reserved.
//

#ifndef ColorMarco_h
#define ColorMarco_h

// rgb颜色转换（16进制->10进制）
#define COLOR_HEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// rgb颜色转换（16进制->10进制）带alpha
#define COLOR_HEXA(rgbValue, A) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:A]

//带有RGBA的颜色设置
#define COLOR_RGBA(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

//带有RGB的颜色设置
#define COLOR_RGB(R, G, B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.f]
#endif /* ColorMarco_h */
