//
//  HYOrderUtil.m
//  RJHY
//
//  Created by 王强 on 2018/7/30.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYOrderUtil.h"

@implementation HYOrderUtil
//持仓
-(void)getmobilesPosition:(void(^)(NSDictionary  *listData))success Failed:(void(^)(NSString *errStr))err{
    
    if (IS_EMPTY_STRING([HYUserInfoManager sharedUserInfo].userid)) {
        if (err) {
            err(@"用户未登录");
        }
    }else{
        [[HYRequestTool Network]dataWithUrl:@"stock/mobilesPosition" Host:kAppURL param:@{@"userId":[HYUserInfoManager sharedUserInfo].userid} method:HYHttpRequestMethodGet modelClassName:nil onProgress:^(NSProgress * _Nonnull progress) {
        } isLoading:NO onComplete:^(NSDictionary *data) {
            
            if (success) {
                success(data[@"sPositions"]);
            }
            
        } onFault:^(id error) {
            DBLog(@"%@",error);
            err(@"获取持仓数失败");
        }];
    }
   
}
-(void)getJLJsonWithPage:(NSInteger)page RequestType:(JLRequestType)type Success:(void(^)(NSDictionary  *listData))success Failed:(void(^)(NSString *errStr))err{
    if (IS_EMPTY_STRING([HYUserInfoManager sharedUserInfo].userid)) {
        if (err) {
            err(@"用户未登录");
        }
    }else{
        BOOL isToday;
        if (type==TodayEntrust||type == HistoryEntrust) {//委托
            isToday = type == TodayEntrust?1:0;
            NSDictionary *dic = @{@"userId":[HYUserInfoManager sharedUserInfo].userid,
                                  @"nowDay":[NSNumber numberWithBool:isToday],
                                  @"pageNo":[NSNumber numberWithInteger:page],
                                  @"pageSize":@10};
            
            [[HYRequestTool Network]dataWithUrl:@"stock/mobileWtjlJson" Host:kAppURL param:dic method:HYHttpRequestMethodGet modelClassName:nil onProgress:^(NSProgress * _Nonnull progress) {
            } isLoading:NO onComplete:^(NSDictionary *data) {
                
                if (success) {
                    success(data[@"sEntrustList"]);
                }
                
            } onFault:^(id error) {
                DBLog(@"%@",error);
                err(@"获取持撤单失败");
            }];
        }else{//成交记录
            isToday = type == TodayClinchDeal?1:0;
            NSDictionary *dic = @{@"userId":[HYUserInfoManager sharedUserInfo].userid,
                                  @"nowDay":[NSNumber numberWithBool:isToday],
                                  @"pageNo":[NSNumber numberWithInteger:page],
                                  @"pageSize":@10};
            
            [[HYRequestTool Network]dataWithUrl:@"stock/mobileCjjlJson" Host:kAppURL param:dic method:HYHttpRequestMethodGet modelClassName:nil onProgress:^(NSProgress * _Nonnull progress) {
            } isLoading:NO onComplete:^(NSDictionary *data) {
                
                if (success) {
                    success(data[@"sPositions"]);
                }
                
            } onFault:^(id error) {
                DBLog(@"%@",error);
                err(@"获取持用户成交记录失败");
            }];
        }
    
    }
}
//获取用户成交记录
-(void)getmobileCjjlJsonWithPage:(NSInteger)page isToday:(BOOL)isToday Success:(void(^)(NSDictionary  *listData))success Failed:(void(^)(NSString *errStr))err{
    
   
    if (IS_EMPTY_STRING([HYUserInfoManager sharedUserInfo].userid)) {
        if (err) {
            err(@"用户未登录");
        }
    }else{
        //getUserDealInfo(user.getId(), true,1);
        NSDictionary *dic = @{@"userId":[HYUserInfoManager sharedUserInfo].userid,
                              @"nowDay":[NSNumber numberWithBool:isToday],
                              @"pageNo":[NSNumber numberWithInteger:page],
                              @"pageSize":@10};
        
        [[HYRequestTool Network]dataWithUrl:@"stock/mobileCjjlJson" Host:kAppURL param:dic method:HYHttpRequestMethodGet modelClassName:nil onProgress:^(NSProgress * _Nonnull progress) {
        } isLoading:NO onComplete:^(NSDictionary *data) {
            
            if (success) {
                success(data[@"sPositions"]);
            }
            
        } onFault:^(id error) {
            DBLog(@"%@",error);
            err(@"获取持用户成交记录失败");
        }];
    }
    
}


//委托与撤单
-(void)getmobileWtjlJsonWithPage:(NSInteger)page isToday:(BOOL)isToday Success:(void(^)(NSDictionary  *listData))success Failed:(void(^)(NSString *errStr))err{
    
    
    if (IS_EMPTY_STRING([HYUserInfoManager sharedUserInfo].userid)) {
        if (err) {
            err(@"用户未登录");
        }
    }else{
        //getUserDealInfo(user.getId(), true,1);
        NSDictionary *dic = @{@"userId":[HYUserInfoManager sharedUserInfo].userid,
                              @"nowDay":[NSNumber numberWithBool:isToday],
                              @"pageNo":[NSNumber numberWithInteger:page],
                              @"pageSize":@10};
        
        [[HYRequestTool Network]dataWithUrl:@"stock/mobileWtjlJson" Host:kAppURL param:dic method:HYHttpRequestMethodGet modelClassName:nil onProgress:^(NSProgress * _Nonnull progress) {
        } isLoading:NO onComplete:^(NSDictionary *data) {
            
            if (success) {
                success(data[@"sEntrustList"]);
            }
            
        } onFault:^(id error) {
            DBLog(@"%@",error);
            err(@"获取持撤单失败");
        }];
    }
    
}
@end
