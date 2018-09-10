//
//  HYUserInfoManager.h
//  RJHY
//
//  Created by 王强 on 2018/7/25.
//  Copyright © 2018年 王强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYUserInfoManager : NSObject
@property (nonatomic, assign) BOOL hasLogin;                //是否登录成功

@property (nonatomic, strong) NSString *userid;             //userid
@property (nonatomic, strong) NSString *nickName;           // 后台返回的nickName
@property (nonatomic, strong) NSString *userImgAddress;     // 用户头像
@property (nonatomic, strong) NSString *loginName;          // 用户名
@property (nonatomic, strong) NSString *phoneNumString;     // 后台返回的使用的手机号

+ (instancetype)sharedUserInfo;

+ (void)parseUserDataToSave:(NSDictionary *)parsedData;

- (void)logout;
- (void)saveLoginInfo;

@end
