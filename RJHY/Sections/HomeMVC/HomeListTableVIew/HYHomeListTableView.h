//
//  HYHomeListTableView.h
//  RJHY
//
//  Created by 王强 on 2018/7/25.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseTableView.h"
#import "HYTopScrollView.h"
typedef void(^ClickTheCellIndex)(NSString *stockCode);
@interface HYHomeListTableView : HYBaseTableView<UITableViewDelegate,UITableViewDataSource>


-(void)loadDataRise:(BOOL)isRise;

@property(nonatomic,copy)ClickTheCellIndex TBBlock;
@end
