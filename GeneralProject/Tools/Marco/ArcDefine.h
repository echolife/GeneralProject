//
//  ArcDefine.h
//  Dingding
//
//  Created by 陈欢 on 14-2-21.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#ifndef Dingding_ArcDefine_h
#define Dingding_ArcDefine_h

#ifndef M1905_STRONG
    #if __has_feature(objc_arc)
        #define M1905_STRONG strong
    #else
        #define M1905_STRONG retain
    #endif
#endif

#ifndef M1905_WEAK
    #if __has_feature(objc_arc_weak)
        #define M1905_WEAK weak
    #elif __has_feature(objc_arc)
        #define M1905_WEAK unsafe_unretained
    #else
        #define M1905_WEAK assign
    #endif
#endif

#if __has_feature(objc_arc)
    #define M1905_AUTORELEASE(expression) expression
    #define M1905_RELEASE(expression) expression
    #define M1905_RETAIN(expression) expression
#else
    #define M1905_AUTORELEASE(expression) [expression autorelease]
    #define M1905_RELEASE(expression) [expression release]
    #define M1905_RETAIN(expression) [expression retain]
#endif

#endif
