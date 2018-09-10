//
//  NSDictionary+HYExtend.h
//  RJHY
//
//  Created by 王强 on 2018/7/24.
//  Copyright © 2018年 王强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (HYExtend)
- (NSDictionary *)dictionaryForKey:(NSString *)aKey;
- (NSArray *)arrayForKey:(NSString *)aKey;

- (NSString *)stringForKey:(NSString *)aKey;
- (NSNumber *)numberForKey:(NSString *)aKey;
- (float)floatForKey:(NSString *)aKey;
- (double)doubleForKey:(NSString *)aKey;
- (NSInteger)integerForKey:(NSString *)aKey;
- (int)intForKey:(NSString *)aKey;
- (long long)longLongForKey:(NSString *)aKey;
- (long)longForKey:(NSString *)aKey;
- (BOOL)boolForKey:(NSString *)aKey;

@end
