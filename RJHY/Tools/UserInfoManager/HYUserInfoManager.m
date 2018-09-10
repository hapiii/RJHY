//
//  HYUserInfoManager.m
//  RJHY
//
//  Created by 王强 on 2018/7/25.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYUserInfoManager.h"

static HYUserInfoManager *theSharedUserInfo = nil;

@implementation HYUserInfoManager
+ (instancetype)sharedUserInfo {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        theSharedUserInfo = [[HYUserInfoManager alloc] init];
    });
    
    return theSharedUserInfo;
}

- (instancetype)init {
    if (self = [super init]) {
        // 初始化
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        self.userid = [defaults stringForKey:@"userid"];
        self.nickName = [defaults stringForKey:@"kNickName"];
        self.userImgAddress = [defaults stringForKey:@"kUserImgAddress"];
        self.loginName = [defaults stringForKey:@"kLoginName"];
        self.phoneNumString = [defaults stringForKey:@"kPhoneNumber"];
        self.hasLogin = [defaults boolForKey:@"kHasLogin"];
        DBLog(@"self.nickName=%@, self.phoneNumString=%@, self.hasLogin=%d",
              self.nickName, self.phoneNumString, self.hasLogin);
        
        if (self.userid.length > 0) {
            self.hasLogin = YES;
        }else {
            self.hasLogin = NO;
        }
    }
    
    return self;
}
#pragma mark ==＝＝＝保存用户的登录信息
- (void)saveLoginInfo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.userid forKey:@"userid"];
    [defaults setObject:self.nickName forKey:@"kNickName"];
    [defaults setObject:self.userImgAddress forKey:@"kUserImgAddress"];
    [defaults setObject:self.loginName forKey:@"kLoginName"];
    [defaults setObject:self.phoneNumString forKey:@"kPhoneNumber"];
    [defaults setInteger:self.hasLogin forKey:@"kHasLogin"];
    [defaults synchronize];
}
- (void)logout {
    self.userid = @"";
    self.nickName = @"";
    self.userImgAddress = @"";
    self.loginName = @"";
    self.phoneNumString = @"";
    self.hasLogin = NO;
    
   
    [self saveLoginInfo];
    
}
#pragma mark====拆解用户数据存到本地
+ (void)parseUserDataToSave:(NSDictionary *)parsedData {
    
        /*
         crateDate = "2018-06-06 18:56:45";
         id = 111;
         nickname = "\U5c0f\U9ed1";
         phone = 18535354545;
         serviceCharge = "0.001";
         updateDate = "2018-06-08 10:08:35";
         userName = xiaohei;
         */
        [HYUserInfoManager sharedUserInfo].nickName = [parsedData stringForKey:@"nickname"];
        [HYUserInfoManager sharedUserInfo].userid = [parsedData stringForKey:@"id"];
        [HYUserInfoManager sharedUserInfo].phoneNumString = [parsedData stringForKey:@"phone"];
        [HYUserInfoManager sharedUserInfo].userImgAddress = [parsedData stringForKey:@"serviceCharge"];
    
        
        
        
        if ([HYUserInfoManager sharedUserInfo].userid.length > 0) {
            [HYUserInfoManager sharedUserInfo].hasLogin = YES;
        }else {
            [HYUserInfoManager sharedUserInfo].hasLogin = NO;
        }
        
        //存入本地
        [[HYUserInfoManager sharedUserInfo] saveLoginInfo];
    
}

@end
