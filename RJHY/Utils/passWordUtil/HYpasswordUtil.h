//
//  HYpasswordUtil.h
//  RJHY
//
//  Created by 王强 on 2018/7/24.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseUtil.h"

@interface HYpasswordUtil : HYBaseUtil
/**
 加密
 @param data 需要加密的数据
 @param key 密钥
 @return 加密后的数据
 */
+ (NSData *)encryptPBEWithMD5AndDESData:(NSData *)data key:(NSString *)key;

/**
 解密
 @param data 需要解密的数据
 @param key 密钥
 @return 解密后的数据
 */
+ (NSData *)decryptPBEWithMD5AndDESData:(NSData *)data key:(NSString *)key;
/**
 加解密核心代码
 @param data 需要加密或者解密的数据
 @param key 密钥
 @param direction 1:加密, 0:解密
 @return 加密或者解密后的数据
 */
+ (NSData *)pbeWithMD5AndDESData:(NSData *)data key:(NSString *)key direction:(int)direction;

+ (NSData *)convertHexStrToData:(NSString *)str;
+ (NSString *)convertDataToHexStr:(NSData *)data;

@end
