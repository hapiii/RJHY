//
//  UIColor+Custom.h
//  BeMothor
//
//  Created by zhouhan on 15/6/7.
//  Copyright (c) 2015年 yongbaoHealth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Custom)

// 有#使用这个
+ (UIColor *)colorWithHexHasSignString:(NSString *)stringToConvert;
// 没有#号用这个
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (UIImage *)imgWithColor:(UIColor *)color;
+ (UIColor *) randomColor;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
