//
//  HYoptionalTableView.h
//  RJHY
//
//  Created by 王强 on 2018/7/24.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseTableView.h"
#import "HYHomeStockCell.h"

@interface HYoptionalTableView : HYBaseTableView<UITableViewDelegate,UITableViewDataSource>

-(void)loadDataRise:(BOOL)isRise;
@end
