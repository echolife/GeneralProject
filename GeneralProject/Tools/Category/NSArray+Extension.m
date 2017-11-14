//
//  NSArray+Extension.m
//  Dingding
//
//  Created by 陈欢 on 14-2-27.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)

- (NSArray *)offsetRangesInArrayBy:(NSUInteger)offset
{
    NSUInteger aOffset = 0;
    NSUInteger prevLength = 0;
    
    
    NSMutableArray *ranges = [[NSMutableArray alloc] initWithCapacity:[self count]];
    for(NSInteger i = 0; i < [self count]; i++)
    {
        @autoreleasepool {
            NSRange range = [[self objectAtIndex:i] rangeValue];
            prevLength    = range.length;
            
            range.location -= aOffset;
            range.length    = offset;
            [ranges addObject:[NSValue valueWithRange:range]];
            
            aOffset = aOffset + prevLength - offset;
        }
    }
    
    return ranges;
}

- (id)objectAtIndex_conver:(int)index
{
    if(index + 1 > self.count || index < 0) return nil;
    id obj = [self objectAtIndex:index];
    if([[obj class] isSubclassOfClass:[NSNull class]]) return nil;
    if([[obj class] isSubclassOfClass:[NSDictionary class]]){
        NSDictionary *temp = (NSDictionary *)obj;
        if(temp.count < 1)return nil;
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


@implementation NSMutableArray (Extension)



@end
