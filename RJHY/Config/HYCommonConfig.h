//
//  HYCommonConfig.h
//  RJHY
//
//  Created by 王强 on 2018/7/23.
//  Copyright © 2018年 王强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYCommonConfig : NSObject
#pragma mark - 公共宏
#define kCacheFolder NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]
#define kDocumentFolder NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]




//Debug模式下有输出，Release模式下无输出
#ifndef __OPTIMIZE__
#   define DBLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DBLog(...) {}
#endif

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
//获取导航栏+状态栏的高度
#define getRectNavAndStatusHight  self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height

#define RectNavHight self.navigationController.navigationBar.frame.size.height
#define StatusHight [[UIApplication sharedApplication] statusBarFrame].size.height
#define TabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49) //底部tabbar高度
#define NEWNavHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?68:44)

#define isPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)



#define proArr(arr) @property (nonatomic,strong) NSArray *(arr);
#define proDic(dic) @property (nonatomic,strong) NSDictionary *(dic);
#define proStr(str) @property (nonatomic,copy) NSString *(str);
#define proNum(num)  @property (nonatomic,copy) NSNumber *(num);
#define defaultStr @"--";

#pragma mark - 本地文件
#define kCurrentUserAccountFile [kCacheFolder stringByAppendingPathComponent:kCurrentUserAccount] //当前登录用户
#define kDBFolderPath [kDocumentFolder stringByAppendingPathComponent:[NSString stringWithFormat:@"db"]] //数据库文件夹
#define kDBFilePath [kDBFolderPath stringByAppendingPathComponent:kDBFileName] //数据库路径
#define kAppPath [NSBundle mainBundle].bundlePath //app路径

/********** IPHONE INFO **********/
#define kAPP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define kAPP_BUILD  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define kSYSTEM_VERSION [[UIDevice currentDevice] systemVersion]
#define kIOS9 [[UIDevice currentDevice].systemVersion hasPrefix:@"9"]
#define kSCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define kSCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height
#define kKEYWINDOW [[UIApplication sharedApplication] keyWindow]
#define kIPHONE4 (kSCREEN_HEIGHT == 480.0)
#define kIPHONE5 (kSCREEN_HEIGHT == 568.0)
#define kIPHONE6 (kSCREEN_HEIGHT == 667.0)
#define KIPHONE6PLUS (kSCREEN_WIDTH == 414.0)
#define KIPHONE_X (kSCREEN_HEIGHT == 812.0)
#define kRatio (kSCREEN_WIDTH/375.0)
#define kFitSize(a) ((a)*kRatio)
#define kFitFont(R) [UIFont systemFontOfSize:kFitSize(R)]

#define kLightFontSize(a) [UIFont systemFontOfSizeCustom:a]
#define kNormalFontSize(a) [UIFont boldFontOfSizeCustom:a]
#define kBoldFontSize(a) [UIFont bigFontOfSizeCustom:a]
#define kSuperBoldFontSize(a) [UIFont superBigFontOfSizeCustom:a]
#define kSideWide kSCREEN_WIDTH * 0.8
#define IS_NULL(x)          (!x || [x isKindOfClass:[NSNull class]])
#define IS_EMPTY_STRING(x)  (IS_NULL(x) || [x isEqual:@""] || [x isEqual:@"(null)"]|| [x isEqual:@"<null>"])

/********** Color **********/
#define kRGBCOLOR(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define kBackgroundGrayColor_Color kRGBCOLOR(235, 235, 235)
#define kLightBlue_Color kRGBCOLOR(120, 202, 240)
#define kLightBlue_Color1 kRGBCOLOR(100, 160, 215)
#define kBorderline_Color kRGBCOLOR(212,218,218)
#define kProgressGreen_Color kRGBCOLOR(104,174,39)
#define kProgressOrange_Color kRGBCOLOR(246,153,2)
#define kWhite_Color [UIColor colorWithHexString:@"FFFFFF"]
#define kRed_Color [UIColor colorWithHexString:@"FF5A5F"]
#define kBlack_Color [UIColor colorWithHexString:@"000000"]
#define kGray_Color [UIColor colorWithHexString:@"D1D1D1"]
#define kLight_Gray_Color [UIColor colorWithHexString:@"F0F0F0"]
#define kBlue_Color [UIColor colorWithHexString:@"0082DA"]
#define kGreen_Color [UIColor colorWithHexString:@"74B737"]
#define kGreen_Light_Color [UIColor colorWithHexString:@"D8F178"]
#define kPurple_Color [UIColor colorWithHexString:@"55438B"]
#define kOrange_Color [UIColor colorWithHexString:@"F3A327"]
#define kFont_Normal_Color [UIColor colorWithHexString:@"666666"]
#define kFont_Light_Color [UIColor colorWithHexString:@"999999"]
#define kFont_Bold_Color [UIColor colorWithHexString:@"333333"]
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]//随机色
#define urlStr(str) [NSURL URLWithString:str]//字符串转化为网站
#define imgStr(str)  [UIImage imageNamed:str]

#pragma mark - 域名
extern NSString * const kAppURL;//app接口域名

@end
