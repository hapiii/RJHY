//
//  HYRequestTool.h
//  RJHY
//
//  Created by 王强 on 2018/7/23.
//  Copyright © 2018年 王强. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef  enum{
    HYHttpRequestMethodPost=1,
    HYHttpRequestMethodGet=2,
}HYHTTPRequestMethod;

@interface HYRequestTool : NSObject
+(id)Network;
/**
 post/get host为空使用默认的
 */
- (void)dataWithUrl:(NSString *)url Host:(NSString *)host param:(NSDictionary *)param method:(HYHTTPRequestMethod)method modelClassName:(Class)className onProgress:(void (^)(NSProgress * _Nonnull progress))onProgress isLoading:(BOOL)isLoading onComplete:(void (^)(NSDictionary *data))onComplete onFault:(void (^)(id error))onFault;

@end
