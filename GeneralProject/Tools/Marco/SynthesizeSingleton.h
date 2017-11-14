//
//  SynthesizeSingleton.h
//  GeneralProject
//
//  Created by Jone on 2017/4/28.
//  Copyright © 2017年 Jone. All rights reserved.
//

#ifndef SynthesizeSingleton_h
#define SynthesizeSingleton_h
#import <objc/runtime.h>

#define SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(__CLASSNAME__)	\
\
+ (__CLASSNAME__*) sharedInstance;	\



#define SYNTHESIZE_SINGLETON_FOR_CLASS(__CLASSNAME__)	\
\
static __CLASSNAME__ *instance = nil;   \
\
+ (__CLASSNAME__ *)sharedInstance{ \
static dispatch_once_t onceToken;   \
dispatch_once(&onceToken, ^{    \
if (nil == instance){   \
instance = [[__CLASSNAME__ alloc] init];    \
}   \
}); \
\
return instance;   \
}

#endif /* SynthesizeSingleton_h */
