//
//  HYLineUtil.h
//  RJHY
//
//  Created by 王强 on 2018/7/30.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseUtil.h"
#import "StockDataModel.h"
#import "HYNewStockDetailModel.h"

typedef enum {
    
    dayKLine=0,
    weekKLine=1,
    monthKline=2
}LineType;

@interface HYLineUtil : HYBaseUtil
+(id)Network;
@property(nonatomic,strong)AFHTTPSessionManager *manager;
/**
 *日分图
 */
-(void)getDayStockLIneInfo:(NSString*)code WithType:(LineType )type Success:(void(^)(NSArray   *listData))success;
/**
 *K线图数据
 */
-(void)getStockLIneInfo:(NSString*)code WithType:(LineType )type Success:(void(^)(NSArray   *listData))success;
/**
 *股票详情
 */
-(void)getStockWholeDetialInfoCode:(NSString*)code Success:(void(^)(NSString *str,NSArray *arr))success;

/**
 *涨五，跌五
 */
-(void)getTimeDataInfoCode:(NSString*)code Success:(void(^)(HYNewStockDetailModel *model))success;

@end
