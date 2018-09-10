//
//  HYLoginUtil.h
//  RJHY
//
//  Created by 王强 on 2018/7/24.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseUtil.h"
#import "HYpasswordUtil.h"

@interface HYLoginUtil : HYBaseUtil
//登录
-(void)LoginWithUserInfo:(NSDictionary *)dic Success:(void(^)(NSDictionary *listData))success Fail:(void(^)(id err))error;

-(void)GetUserMoneySuccess:(void(^)(NSDictionary *listData))success Fail:(void(^)(id err))error;

@end
