//
//  HYStockLineController.h
//  RJHY
//
//  Created by 王强 on 2018/7/30.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseController.h"
#import "HYLineUtil.h"
#import "HYStockDetailView.h"
#import "HYNavView.h"
#import "HYStockBottomView.h"

@interface HYStockLineController : HYBaseController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,copy)NSString *stockCode;
@property(nonatomic,strong)NSArray *dataArr;//k线图数据
@property(nonatomic,strong)NSArray *detailArr;//股票数据

@property(nonatomic,strong)HYNavView *navView;
@property(nonatomic,strong)HYStockBottomView *bottomBtns;
@end
