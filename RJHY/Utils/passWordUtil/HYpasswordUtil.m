//
//  HYpasswordUtil.m
//  RJHY
//
//  Created by 王强 on 2018/7/24.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYpasswordUtil.h"

#import <openssl/md5.h>
#import <openssl/sha.h>
#import <openssl/x509.h>
#import <openssl/err.h>
#import <openssl/evp.h>

@implementation HYpasswordUtil
//加密
+ (NSData *)encryptPBEWithMD5AndDESData:(NSData *)data key:(NSString *)key {
    //leak error
    return [self pbeWithMD5AndDESData:data key:key direction:1];
}
//解密
+ (NSData *)decryptPBEWithMD5AndDESData:(NSData *)data key:(NSString *)key {
    return [self pbeWithMD5AndDESData:data key:key direction:0];
}

+ (NSData *)pbeWithMD5AndDESData:(NSData *)data key:(NSString *)key direction:(int)direction
{
   
    // 这是服务器的盐
    NSString *saltStr = @"89434057";
    const char *saltChar = [saltStr cStringUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char *salt = (unsigned char *)saltChar;
    int saltLen = strlen(saltChar);
    // 1000同盐一样，是和服务器商量好的
    int iterations = 1000;
    EVP_CIPHER_CTX cipherCtx;
    
    unsigned char *mResults; // allocated storage of results
    int mResultsLen = 0;
    
    const char *cKey = [key UTF8String];
    
    unsigned char *mData = (unsigned char *)[data bytes];
    int mDataLen = [data length];
    
    SSLeay_add_all_algorithms();
    X509_ALGOR *algorithm = PKCS5_pbe_set(NID_pbeWithMD5AndDES_CBC,
                                          iterations, salt, saltLen);
    
    memset(&cipherCtx, 0, sizeof(cipherCtx));
    
    if (algorithm != NULL)
    {
        EVP_CIPHER_CTX_init(&(cipherCtx));
        
        if (EVP_PBE_CipherInit(algorithm->algorithm, cKey, strlen(cKey),
                               algorithm->parameter, &(cipherCtx), direction))
        {
            EVP_CIPHER_CTX_set_padding(&cipherCtx, 1);
            
            int blockSize = EVP_CIPHER_CTX_block_size(&cipherCtx);
            int allocLen = mDataLen + blockSize + 1; // plus 1 for null terminator on decrypt
            mResults = (unsigned char *)OPENSSL_malloc(allocLen);
            
            unsigned char *in_bytes = mData;
            int inLen = mDataLen;
            unsigned char *out_bytes = mResults;
            int outLen = 0;
            
            int outLenPart1 = 0;
            if (EVP_CipherUpdate(&(cipherCtx), out_bytes, &outLenPart1, in_bytes, inLen))
            {
                out_bytes += outLenPart1;
                int outLenPart2 = 0;
                if (EVP_CipherFinal(&(cipherCtx), out_bytes, &outLenPart2))
                {
                    outLen += outLenPart1 + outLenPart2;
                    mResults[outLen] = 0;
                    mResultsLen = outLen;
                }
            } else {
                unsigned long err = ERR_get_error();
                
                ERR_load_crypto_strings();
                ERR_load_ERR_strings();
                char errbuff[256];
                errbuff[0] = 0;
                ERR_error_string_n(err, errbuff, sizeof(errbuff));
                NSLog(@"OpenSLL ERROR:\n\tlib:%s\n\tfunction:%s\n\treason:%s\n",
                      ERR_lib_error_string(err),
                      ERR_func_error_string(err),
                      ERR_reason_error_string(err));
                ERR_free_strings();
            }
            
            NSData *encryptedData = [NSData dataWithBytes:mResults length:mResultsLen]; //(NSData *)encr_buf;
            
            //NSLog(@"encryption result: %@\n", [encryptedData base64EncodingWithLineLength:1024]);
            
            EVP_cleanup();
            
            return encryptedData;
        }
    }
    
    EVP_cleanup();
    
    return nil;
}

/** 把十六进制字符串转换成NSData（在解密的时候会用到） */
+ (NSData *)convertHexStrToData:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
}

/** 把NSData转换成十六进制的字符串 */
+ (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}
@end
