//
//  HYNewStockDetailModel.h
//  RJHY
//
//  Created by 王强 on 2018/8/6.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYNewStockDetailModel : HYBaseModel
@property (nonatomic , copy) NSString              * dateTime;
@property (nonatomic , copy) NSString              * buy5Money;
@property (nonatomic , assign) CGFloat              yestodayClosePrice;
@property (nonatomic , copy) NSString              * buy2Money;
@property (nonatomic , copy) NSString              * sell3Money;
@property (nonatomic , copy) NSString              * sell1Money;
@property (nonatomic , assign) CGFloat              nowPrice;
@property (nonatomic , copy) NSString              * buy1Num;
@property (nonatomic , copy) NSString              * buy3Num;
@property (nonatomic , copy) NSString              * stockName;
@property (nonatomic , copy) NSString              * successStockNum;
@property (nonatomic , copy) NSString              * sell4Num;
@property (nonatomic , copy) NSString              * sell2Num;
@property (nonatomic , copy) NSString              * buy5Num;
@property (nonatomic , copy) NSString              * sell2Money;
@property (nonatomic , copy) NSString              * sell5Money;
@property (nonatomic , assign) CGFloat              todayHighPrice;
@property (nonatomic , copy) NSString              * buy1Money;
@property (nonatomic , copy) NSString              * buy4Money;
@property (nonatomic , copy) NSString              * buy2Num;
@property (nonatomic , copy) NSString              * sell5Num;
@property (nonatomic , copy) NSString              * buy4Num;
@property (nonatomic , assign) NSInteger              todayBeginPrice;
@property (nonatomic , assign) NSInteger              todayLowPrice;
@property (nonatomic , copy) NSString              * sell4Money;
@property (nonatomic , copy) NSString              * successStockMoney;
@property (nonatomic , copy) NSString              * buy3Money;
@property (nonatomic , copy) NSString              * sell1Num;
@property (nonatomic , copy) NSString              * sell3Num;
@end
