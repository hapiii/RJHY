//
//  NSDictionary+HYExtend.m
//  RJHY
//
//  Created by 王强 on 2018/7/24.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "NSDictionary+HYExtend.h"

@implementation NSDictionary (HYExtend)

- (NSDictionary *)dictionaryForKey:(NSString *)aKey
{
    if (aKey) {
        id value = [self objectForKey:aKey];
        if (value && [value isKindOfClass:[NSDictionary class]])
            return value;
    }
    
    return nil;
}

- (NSArray *)arrayForKey:(NSString *)aKey {
    if (aKey) {
        id value = [self objectForKey:aKey];
        if (value && [value isKindOfClass:[NSArray class]])
            return value;
    }
    
    return nil;
}

- (NSString *)stringForKey:(NSString*)aKey
{
    if (aKey) {
        id value = [self objectForKey:aKey];
        if (value) {
            if ([value isKindOfClass:[NSString class]])
                return value;
            else if ([value isKindOfClass:[NSNumber class]])
                return [value stringValue];
        }
    }
    
    return nil;
}

- (NSNumber *)numberForKey:(NSString*)aKey
{
    if (aKey) {
        id value = [self objectForKey:aKey];
        if (value && [value isKindOfClass:[NSNumber class]])
            return value;
    }
    
    return nil;
}

- (float)floatForKey:(NSString *)aKey
{
    if (aKey) {
        id value = [self objectForKey:aKey];
        if (value && ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]))
            return [value floatValue];
    }
    
    return 0.0f;
}

- (double)doubleForKey:(NSString *)aKey
{
    if (aKey) {
        id value = [self objectForKey:aKey];
        if (value && ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]))
            return [value doubleValue];
    }
    
    return 0.0;
}

- (NSInteger)integerForKey:(NSString *)aKey
{
    if (aKey) {
        id value = [self objectForKey:aKey];
        if (value && ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]))
            return [value integerValue];
    }
    
    return 0;
}

- (int)intForKey:(NSString *)aKey
{
    return [self integerForKey:aKey];
}

- (long long)longLongForKey:(NSString *)aKey
{
    if (aKey) {
        id value = [self objectForKey:aKey];
        if (value && ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]))
            return [value longLongValue];
    }
    
    return 0;
}

- (long)longForKey:(NSString *)aKey
{
    if (aKey) {
        id value = [self objectForKey:aKey];
        if (value && ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]))
            return [value longValue];
    }
    
    return 0;
}

- (BOOL)boolForKey:(NSString *)aKey
{
    if (aKey) {
        id value = [self objectForKey:aKey];
        if (value && ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]))
            return [value boolValue];
    }
    
    return NO;
}


@end
