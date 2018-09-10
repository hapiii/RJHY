//
//  HYMarketController.h
//  RJHY
//
//  Created by 王强 on 2018/7/23.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseController.h"
#import "HYoptionalTableView.h"
#import "HYmarketTableView.h"
#import "HYNavBarView.h"
@interface HYMarketController : HYBaseController

@property(nonatomic,strong)HYNavBarView *navView;
@property(nonatomic,strong)HYoptionalTableView *optionalTb;
@property(nonatomic,strong)HYmarketTableView *marketTb;

@end
