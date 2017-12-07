//
//  NSURL+Extension.h
//  UserMovieChoice
//
//  Created by 王滔 on 2017/7/31.
//  Copyright © 2017年 王滔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Extension)

+ (instancetype _Nullable )URLWithString:(NSString *_Nullable)URLString relativeToBaseURL:(nullable NSURL *)baseURL;

@end
