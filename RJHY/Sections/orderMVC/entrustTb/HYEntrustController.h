//
//  HYEntrustController.h
//  RJHY
//
//  Created by 王强 on 2018/7/27.
//  Copyright © 2018年 王强. All rights reserved.
// 委托

#import "HYBaseController.h"
#import "TTTopChannelContianerView.h"
#import "HYOrderUtil.h"
#import "HYPositionCell.h"

@interface HYEntrustController : HYBaseController<TTTopChannelContianerViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)TTTopChannelContianerView *ChannelView;
@property(nonatomic,strong)HYOrderUtil *util;
@property(nonatomic,strong)UITableView *tb;
@property(nonatomic,strong)NSMutableArray *dataList;
@property(nonatomic,assign)JLRequestType currectType;

@end
