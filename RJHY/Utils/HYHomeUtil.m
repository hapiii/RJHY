//
//  HYHomeUtil.m
//  RJHY
//
//  Created by 王强 on 2018/7/24.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYHomeUtil.h"

@implementation HYHomeUtil

-(void)getScrollSix:(void(^)(NSDictionary  *listData))success{
    
    [[HYRequestTool Network]dataWithUrl:@"https://xueqiu.com/v4/stock/quotec.json" Host:nil param:@{@"code":@"SH000001,SZ399006,SZ399001,SH000300,SZ399005,SZ399100"} method:HYHttpRequestMethodGet modelClassName:nil onProgress:^(NSProgress * _Nonnull progress) {
    } isLoading:NO onComplete:^(NSDictionary *data) {
        
if (success) {
            success(data);
        }
    } onFault:^(id error) {
        DBLog(@"%@",error);
    }];
}

-(void)getRiseDropData:(void(^)(NSDictionary  *listData))success{
    [[HYRequestTool Network]dataWithUrl:@"https://wows-api.wallstreetcn.com/statis_data/quote_change" Host:nil param:nil method:HYHttpRequestMethodGet modelClassName:nil onProgress:^(NSProgress * _Nonnull progress) {
    } isLoading:NO onComplete:^(NSDictionary *data) {
        if (success) {
            success([data dictionaryForKey:@"data"]);
        }
    } onFault:^(id error) {
        
    }];
}

-(void)getHomeListisRise:(BOOL)isRise Success:(void(^)(NSArray  <HYHomeStockModel *> *listData))success Failed:(void(^)(NSString *errText))errInfo{//asc 0 1 上升下降
    NSMutableDictionary *dic =  [@{@"sort":@"percent",@"asc":@1,@"page":@1,@"num":@10,@"node":@"hs",@"dpc":@"1"} mutableCopy];
    if (isRise) {
        [dic setValue:@"1" forKey:@"asc"];
        
    }else{
        [dic setValue:@"0" forKey:@"asc"];
    }
    [[HYRequestTool Network] dataWithUrl:@"http://gu.sina.cn/hq/api/openapi.php/StockV2Service.getNodeList" Host:nil param:dic method:HYHttpRequestMethodGet modelClassName:nil onProgress:^(NSProgress * _Nonnull progress) {
    } isLoading:NO onComplete:^(NSDictionary *data) {
        NSMutableArray *returnArr = [NSMutableArray new];
        
        NSDictionary *result = [data dictionaryForKey:@"result"];
        NSDictionary *Data1 = [result dictionaryForKey:@"data"];
        NSArray *dataArr = [Data1 arrayForKey:@"data"];
        
        for (NSDictionary *secondDic in dataArr) {
            NSDictionary *endDic = [secondDic dictionaryForKey:@"ext"];
            HYHomeStockModel *model = [HYHomeStockModel new];
            [model mj_setKeyValues:endDic];
            [returnArr addObject:model];
        }
        if (returnArr.count>0&&success) {
            success(returnArr);
        }
        
        
        
    } onFault:^(id error) {
        errInfo(@"请求失败");
        
    }];
}

//市场
-(void)getMarketListType:(marketType )type Success:(void(^)(NSArray   *listData))success{
    
    
    NSMutableDictionary *dic =  [@{@"num":@3,@"page":@1,@"sort":@"percent",@"asc":@0,@"dpc":@1,@"plate":@"all"} mutableCopy];
    switch (type) {
        case riseModule:
             [dic setValue:@"all" forKey:@"plate"];
            break;
        case IndustryModule:
            [dic setValue:@"sw2" forKey:@"plate"];
            break;
        case conceptModule:
            [dic setValue:@"chgn" forKey:@"plate"];
            break;
        default:
            break;
    }
    
    
    [[HYRequestTool Network] dataWithUrl:@"http://gu.sina.cn/hq/api/openapi.php/StockV2Service.getPlateList" Host:nil param:dic method:HYHttpRequestMethodGet modelClassName:nil onProgress:^(NSProgress * _Nonnull progress) {
    } isLoading:NO onComplete:^(NSDictionary *data) {
        NSMutableArray *returnArr = [NSMutableArray new];
        
        NSDictionary *result = [data dictionaryForKey:@"result"];
        NSDictionary *Data1 = [result dictionaryForKey:@"data"];
        NSArray *dataArr = [Data1 arrayForKey:@"data"];
        
        for (NSDictionary *endDic in dataArr) {
            
            HYMarketStockModel *model = [HYMarketStockModel new];
            [model mj_setKeyValues:endDic];
            [returnArr addObject:model];
        }
        if (returnArr.count>0&&success) {
            success(returnArr);
        }
        
        
        
    } onFault:^(id error) {
    }];
    
}

//股票详情
-(void)getStockDetialInfo:(NSString*)code Success:(void(^)(NSArray   *listData))success{
    
    //http://192.168.2.200:8080/stock/dsfjk/dayKline/
    NSDictionary *Dic = @{@"stockCode":@"sz000862"};
    [[HYRequestTool Network] dataWithUrl:@"stock/dsfjk/weekKline" Host:kAppURL param:Dic method:HYHttpRequestMethodGet modelClassName:nil onProgress:^(NSProgress * _Nonnull progress) {
    } isLoading:NO onComplete:^(NSDictionary *data) {
    
    } onFault:^(id error) {
    }];
}



@end
