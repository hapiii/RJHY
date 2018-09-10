//
//  HYTradingController.h
//  RJHY
//
//  Created by 王强 on 2018/7/23.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseController.h"
#import "TTTopChannelContianerView.h"

@interface HYTradingController : HYBaseController<UITableViewDelegate,UITableViewDataSource,TTTopChannelContianerViewDelegate>

@property(nonatomic,strong)UITableView *tradsTb;
@property(nonatomic,strong)NSArray *dataList;
@end
