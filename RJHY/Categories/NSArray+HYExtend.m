//
//  NSArray+HYExtend.m
//  RJHY
//
//  Created by 王强 on 2018/7/24.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "NSArray+HYExtend.h"

@implementation NSArray (HYExtend)

-(id)objectAtIndexCheck:(NSUInteger)index
{
    if (index < self.count) {
        return [self objectAtIndex:index];
    }
    return @"--";
}

@end
