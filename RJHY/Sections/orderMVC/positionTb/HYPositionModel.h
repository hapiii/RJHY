//
//  HYPositionModel.h
//  RJHY
//
//  Created by 王强 on 2018/7/30.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYPositionModel : HYBaseModel
proStr(stockName)//名字
proStr(marketvalue)//市值

proStr(stockCode)//代码

proStr(quantity)//数量
proStr(presentprice)//现价
proStr(frozenQuantity)//冰冻的数量

proStr(profitbl)//现价
proStr(profitprice)//成本



proStr(stockPrice)//现价

/*
 frozenQuantity = 0;
 marketvalue = 88060;
 presentprice = "10.36";
 profitbl = "-18.68%";
 profitprice = "-20230";
 quantity = 8500;
 stockCode = 002282;
 stockName = "\U535a\U6df1\U5de5\U5177";
 stockPrice = "12.74";
 */
@end
