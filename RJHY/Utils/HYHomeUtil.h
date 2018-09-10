//
//  HYHomeUtil.h
//  RJHY
//
//  Created by 王强 on 2018/7/24.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseUtil.h"
#import "HYHomeStockModel.h"
#import "HYMarketStockModel.h"

typedef enum {
    riseModule = 0,
    IndustryModule = 1,
    conceptModule = 2,
    
}marketType;
@interface HYHomeUtil : HYBaseUtil
-(void)getScrollSix:(void(^)(NSDictionary  *listData))success;
-(void)getRiseDropData:(void(^)(NSDictionary  *listData))success;
-(void)getHomeListisRise:(BOOL)isRise Success:(void(^)(NSArray  <HYHomeStockModel *> *listData))success Failed:(void(^)(NSString *errText))errInfo;

-(void)getMarketListType:(marketType )type Success:(void(^)(NSArray   *listData))success;

-(void)getStockDetialInfo:(NSString*)code Success:(void(^)(NSArray   *listData))success;
@end
