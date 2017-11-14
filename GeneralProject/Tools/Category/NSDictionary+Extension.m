//
//  NSDictionary+Extension.m
//  GeneralProject
//
//  Created by 王滔 on 2017/4/28.
//  Copyright © 2017年 王滔. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

- (id)objectForKey_conver:(id)key{
    id obj = [self objectForKey:key];
    if([[obj class] isSubclassOfClass:[NSNull class]]) return nil;
    if([[obj class] isSubclassOfClass:[NSDictionary class]]){
        NSDictionary *temp = (NSDictionary *)obj;
        if(temp.count < 1) return nil;
        else return obj;
    }
    if([[obj class] isSubclassOfClass:[NSArray class]]) {
        NSArray *temp = (NSArray *)obj;
        if(temp.count < 1) return nil;
        else return obj;
    }
    return obj ;
}

@end
