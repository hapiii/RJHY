//
//  HYLoginUtil.m
//  RJHY
//
//  Created by 王强 on 2018/7/24.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYLoginUtil.h"
#import "HYUserInfoManager.h"

@implementation HYLoginUtil

-(void)LoginWithUserInfo:(NSDictionary *)dic Success:(void(^)(NSDictionary *listData))success Fail:(void(^)(id err))error{
    
    NSString *account = @"ceshi";
    NSString *password = @"123456";
    
    // 服务器加密规则:
    // 1.把需要加密的内容转换成NSData
    // 2.再和内容和key一起由加密工具类加密生成加密后的NSData
    // 3.把加密后的NSData转换成十六进制的字符串传到服务器端
    //wq 这里有泄漏
    NSData *encryptData = [account dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encData = [HYpasswordUtil encryptPBEWithMD5AndDESData:encryptData key:password];
    NSString *encryptPwd = [HYpasswordUtil convertDataToHexStr:encData];
    
    NSData *encryptDeviceCode = [account dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encDeviceCodeData = [HYpasswordUtil encryptPBEWithMD5AndDESData:encryptDeviceCode key:account];
    NSString *encDeviceCode = [HYpasswordUtil convertDataToHexStr:encDeviceCodeData];
    
    
    NSDictionary *newDic = @{@"username":@"ceshi",@"password":encryptPwd};
    
    [[HYRequestTool Network] dataWithUrl:@"stock/login/mobileLogin1" Host:kAppURL param:newDic method:HYHttpRequestMethodPost modelClassName:nil onProgress:^(NSProgress * _Nonnull progress) {
        
    } isLoading:NO onComplete:^(NSDictionary *data) {
        
        [HYUserInfoManager parseUserDataToSave:[data dictionaryForKey:@"sUser"]];
        DBLog(@"%@%@",[HYUserInfoManager sharedUserInfo].nickName,[HYUserInfoManager sharedUserInfo].phoneNumString);
        if (success) {
            success([data dictionaryForKey:@"sUser"]);
        }
    } onFault:^(id error) {
        
    }];
}

-(void)GetUserMoneySuccess:(void(^)(NSDictionary *listData))success Fail:(void(^)(id err))error{
    if ([HYUserInfoManager sharedUserInfo].userid) {
        [self LoginWithUserInfo:nil Success:^(NSDictionary *listData) {
            NSDictionary *dic = @{@"userId":[HYUserInfoManager sharedUserInfo].userid};
            [[HYRequestTool Network] dataWithUrl:@"stock/mobileUserStock" Host:kAppURL param:dic method:HYHttpRequestMethodGet modelClassName:nil onProgress:^(NSProgress * _Nonnull progress) {
                
            } isLoading:NO onComplete:^(NSDictionary *data) {
                if (success) {
                    success(data[@"userDetailMoney"]);
                }
            } onFault:^(id error) {
                DBLog(@"%@",error);
            }];
        } Fail:nil];
    }
    
}

@end
