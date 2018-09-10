//
//  HYOrderUtil.h
//  RJHY
//
//  Created by 王强 on 2018/7/30.
//  Copyright © 2018年 王强. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    TodayEntrust = 0,
    TodayClinchDeal = 1,
    HistoryEntrust =2 ,
    HistoryClinchDeal = 3,
}JLRequestType;


@interface HYOrderUtil : NSObject
/**
 *持仓
 */
-(void)getmobilesPosition:(void(^)(NSDictionary  *listData))success Failed:(void(^)(NSString *errStr))err;

/**
 *委托请求
 */
-(void)getJLJsonWithPage:(NSInteger)page RequestType:(JLRequestType)type Success:(void(^)(NSDictionary  *listData))success Failed:(void(^)(NSString *errStr))err;
/**
 *获取用户成交记录
 */
-(void)getmobileCjjlJsonWithPage:(NSInteger)page isToday:(BOOL)isToday Success:(void(^)(NSDictionary  *listData))success Failed:(void(^)(NSString *errStr))err;

/**
 *撤单，委托
 */
-(void)getmobileWtjlJsonWithPage:(NSInteger)page isToday:(BOOL)isToday Success:(void(^)(NSDictionary  *listData))success Failed:(void(^)(NSString *errStr))err;

@end
