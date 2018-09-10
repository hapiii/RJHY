//
//  HYMyController.h
//  RJHY
//
//  Created by 王强 on 2018/7/23.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseController.h"
#import "HYBaseTableView.h"
#import "HYBaseCell.h"
#import "HYLoginController.h"

@interface HYMyController : HYBaseController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)HYBaseTableView *myTb;
-(void)configData;
@end
