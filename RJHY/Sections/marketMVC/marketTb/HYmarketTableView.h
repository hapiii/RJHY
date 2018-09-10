//
//  HYmarketTableView.h
//  RJHY
//
//  Created by 王强 on 2018/7/24.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseTableView.h"
#import "HYMarketStockCell.h"
#import "HYTopScrollView.h"

@interface HYmarketTableView : HYBaseTableView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *arrRise;
@property(nonatomic,strong)NSArray *arrIndustry;
@property(nonatomic,strong)NSArray *arrConcept;
-(void)loadData;

@end
