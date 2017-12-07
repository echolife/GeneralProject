//
//  NSURL+Extension.m
//  UserMovieChoice
//
//  Created by 王滔 on 2017/7/31.
//  Copyright © 2017年 王滔. All rights reserved.
//

#import "NSURL+Extension.h"

@implementation NSURL (Extension)

+ (instancetype)URLWithString:(NSString *)URLString relativeToBaseURL:(NSURL *)baseURL {
    NSURL *newUrl = [NSURL URLWithString:URLString];
    if (!newUrl.scheme) {
            newUrl = [self URLWithString:URLString relativeToURL:baseURL];
    }
    return newUrl;
}

@end
