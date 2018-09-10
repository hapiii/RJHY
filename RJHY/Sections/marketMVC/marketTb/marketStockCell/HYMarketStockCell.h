//
//  HYMarketStockCell.h
//  RJHY
//
//  Created by 王强 on 2018/7/26.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseCell.h"
#import "HYMarketStockView.h"
#import "HYMarketStockModel.h"
#import "HYHomeUtil.h"
@interface HYMarketStockCell : HYBaseCell

@property(nonatomic,strong)NSArray <HYMarketStockModel *>*modelArrs;
@property(nonatomic,assign)NSInteger type;
@end
